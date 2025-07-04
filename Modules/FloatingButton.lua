--[[
    Floating Button for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local UserInputService = {}
local TweenService = {}
local RunService = {}
local Utils = require("Modules.Utils")

local FloatingButton = {}
FloatingButton.__index = FloatingButton

function FloatingButton:new(parent, theme, options)
    local self = setmetatable({}, FloatingButton)
    
    -- Options
    local opts = options or {}
    self.Size = opts.Size or UDim2.new(0, 60, 0, 60)
    self.Position = opts.Position or UDim2.new(1, -80, 1, -80)
    self.Icon = opts.Icon or "🎮"
    self.Draggable = opts.Draggable ~= false
    self.AutoHide = opts.AutoHide or false
    self.HideDelay = opts.HideDelay or 3
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Visible = true
    self.Callback = nil
    self.Dragging = false
    self.DragStart = nil
    self.StartPos = nil
    self.HideTimer = nil
    self.PulseConnection = nil
    self.IdleConnection = nil
    
    -- Create floating button
    self:CreateFloatingButton()
    
    -- Setup auto-hide if enabled
    if self.AutoHide then
        self:SetupAutoHide()
    end
    
    return self
end

function FloatingButton:CreateFloatingButton()
    -- Main button container
    self.Container = Instance.new("Frame")
    self.Container.Name = "FloatingButtonContainer"
    self.Container.Size = self.Size
    self.Container.Position = self.Position
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 500
    self.Container.Parent = self.Parent
    
    -- Create shadow
    self:CreateShadow()
    
    -- Main button
    self.Button = Instance.new("TextButton")
    self.Button.Name = "FloatingButton"
    self.Button.Size = UDim2.new(1, 0, 1, 0)
    self.Button.Position = UDim2.new(0, 0, 0, 0)
    self.Button.BackgroundColor3 = self.Theme:GetColor("Accent")
    self.Button.BorderSizePixel = 0
    self.Button.Text = ""
    self.Button.AutoButtonColor = false
    self.Button.ZIndex = 501
    self.Button.Parent = self.Container
    
    -- Button corner (circular)
    local buttonCorner = Utils.CreateCorner(30)
    buttonCorner.Parent = self.Button
    
    -- Button stroke
    self.ButtonStroke = Utils.CreateStroke(2, self.Theme:GetColor("BorderHover"))
    self.ButtonStroke.Parent = self.Button
    
    -- Icon label
    self.IconLabel = Instance.new("TextLabel")
    self.IconLabel.Name = "FloatingButtonIcon"
    self.IconLabel.Size = UDim2.new(1, 0, 1, 0)
    self.IconLabel.Position = UDim2.new(0, 0, 0, 0)
    self.IconLabel.BackgroundTransparency = 1
    self.IconLabel.Text = self.Icon
    self.IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.IconLabel.TextScaled = true
    self.IconLabel.Font = Enum.Font.GothamBold
    self.IconLabel.ZIndex = 502
    self.IconLabel.Parent = self.Button
    
    -- Ripple effect container
    self.RippleContainer = Instance.new("Frame")
    self.RippleContainer.Name = "RippleContainer"
    self.RippleContainer.Size = UDim2.new(1, 0, 1, 0)
    self.RippleContainer.Position = UDim2.new(0, 0, 0, 0)
    self.RippleContainer.BackgroundTransparency = 1
    self.RippleContainer.BorderSizePixel = 0
    self.RippleContainer.ClipsDescendants = true
    self.RippleContainer.ZIndex = 500
    self.RippleContainer.Parent = self.Button
    
    local rippleCorner = Utils.CreateCorner(30)
    rippleCorner.Parent = self.RippleContainer
    
    -- Setup interactions
    self:SetupInteractions()
    
    -- Setup dragging if enabled
    if self.Draggable then
        self:SetupDragging()
    end
    
    -- Start pulse animation
    self:StartPulseAnimation()
end

function FloatingButton:CreateShadow()
    self.Shadow = Instance.new("Frame")
    self.Shadow.Name = "FloatingButtonShadow"
    self.Shadow.Size = UDim2.new(1, 8, 1, 8)
    self.Shadow.Position = UDim2.new(0, 4, 0, 4)
    self.Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.Shadow.BackgroundTransparency = 0.6
    self.Shadow.BorderSizePixel = 0
    self.Shadow.ZIndex = 499
    self.Shadow.Parent = self.Container
    
    local shadowCorner = Utils.CreateCorner(34)
    shadowCorner.Parent = self.Shadow
end

function FloatingButton:SetupInteractions()
    -- Click event
    self.Button.MouseButton1Click:Connect(function()
        self:OnClick()
    end)
    
    -- Hover events
    self.Button.MouseEnter:Connect(function()
        self:OnHover()
    end)
    
    self.Button.MouseLeave:Connect(function()
        self:OnLeave()
    end)
    
    -- Press events for mobile support
    self.Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            self:OnPress()
        end
    end)
    
    self.Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            self:OnRelease()
        end
    end)
end

function FloatingButton:SetupDragging()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    self.Button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            -- Start drag after small delay to distinguish from click
            spawn(function()
                wait(0.2)
                if input.UserInputState == Enum.UserInputState.Begin then
                    dragging = true
                    self.Dragging = true
                    dragStart = input.Position
                    startPos = self.Container.Position
                    
                    -- Visual feedback for drag
                    self:OnDragStart()
                end
            end)
        end
    end)
    
    self.Button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if dragging then
                dragging = false
                self.Dragging = false
                self:OnDragEnd()
            end
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            
            -- Constrain to screen bounds
            newPos = self:ConstrainToScreen(newPos)
            self.Container.Position = newPos
            
            -- Update shadow position
            self.Shadow.Position = UDim2.new(0, 4, 0, 4)
        end
    end)
end

function FloatingButton:ConstrainToScreen(position)
    local screenSize = self.Parent.AbsoluteSize
    local buttonSize = self.Container.AbsoluteSize
    
    local minX = 10
    local maxX = screenSize.X - buttonSize.X - 10
    local minY = 10
    local maxY = screenSize.Y - buttonSize.Y - 10
    
    local constrainedX = math.max(minX, math.min(maxX, position.X.Offset))
    local constrainedY = math.max(minY, math.min(maxY, position.Y.Offset))
    
    return UDim2.new(0, constrainedX, 0, constrainedY)
end

function FloatingButton:OnClick()
    if self.Dragging then return end
    
    -- Ripple effect
    self:CreateRipple()
    
    -- Scale animation
    local scaleTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(0.9, 0, 0.9, 0)
    })
    scaleTween:Play()
    
    scaleTween.Completed:Connect(function()
        local restoreTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
            Size = UDim2.new(1, 0, 1, 0)
        })
        restoreTween:Play()
    end)
    
    -- Call callback
    if self.Callback then
        spawn(function()
            self.Callback()
        end)
    end
    
    -- Reset auto-hide timer
    if self.AutoHide then
        self:ResetHideTimer()
    end
end

function FloatingButton:OnHover()
    -- Hover scale animation
    local hoverTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(1.1, 0, 1.1, 0)
    })
    hoverTween:Play()
    
    -- Hover color animation
    local colorTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = self.Theme:GetColor("AccentHover")
    })
    colorTween:Play()
    
    -- Shadow enhancement
    local shadowTween = Utils.CreateTween(self.Shadow, Utils.TweenInfo.Fast, {
        BackgroundTransparency = 0.4,
        Size = UDim2.new(1, 12, 1, 12),
        Position = UDim2.new(0, 6, 0, 6)
    })
    shadowTween:Play()
end

function FloatingButton:OnLeave()
    if self.Dragging then return end
    
    -- Restore scale
    local scaleTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(1, 0, 1, 0)
    })
    scaleTween:Play()
    
    -- Restore color
    local colorTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = self.Theme:GetColor("Accent")
    })
    colorTween:Play()
    
    -- Restore shadow
    local shadowTween = Utils.CreateTween(self.Shadow, Utils.TweenInfo.Fast, {
        BackgroundTransparency = 0.6,
        Size = UDim2.new(1, 8, 1, 8),
        Position = UDim2.new(0, 4, 0, 4)
    })
    shadowTween:Play()
end

function FloatingButton:OnPress()
    local pressTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(0.95, 0, 0.95, 0)
    })
    pressTween:Play()
end

function FloatingButton:OnRelease()
    local releaseTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(1, 0, 1, 0)
    })
    releaseTween:Play()
end

function FloatingButton:OnDragStart()
    -- Visual feedback for drag start
    local dragTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = self.Theme:GetColor("Warning")
    })
    dragTween:Play()
    
    -- Increase shadow
    local shadowTween = Utils.CreateTween(self.Shadow, Utils.TweenInfo.Fast, {
        BackgroundTransparency = 0.3,
        Size = UDim2.new(1, 16, 1, 16),
        Position = UDim2.new(0, 8, 0, 8)
    })
    shadowTween:Play()
end

function FloatingButton:OnDragEnd()
    -- Restore color
    local restoreTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = self.Theme:GetColor("Accent")
    })
    restoreTween:Play()
    
    -- Restore shadow
    local shadowTween = Utils.CreateTween(self.Shadow, Utils.TweenInfo.Fast, {
        BackgroundTransparency = 0.6,
        Size = UDim2.new(1, 8, 1, 8),
        Position = UDim2.new(0, 4, 0, 4)
    })
    shadowTween:Play()
    
    -- Snap to edge if close
    self:SnapToEdge()
end

function FloatingButton:SnapToEdge()
    local screenSize = self.Parent.AbsoluteSize
    local currentPos = self.Container.Position
    local buttonSize = self.Container.AbsoluteSize
    
    local centerX = currentPos.X.Offset + buttonSize.X / 2
    local centerY = currentPos.Y.Offset + buttonSize.Y / 2
    
    local snapPos = currentPos
    
    -- Snap to closest edge if close enough
    local snapDistance = 100
    
    if centerX < snapDistance then
        -- Snap to left edge
        snapPos = UDim2.new(0, 20, snapPos.Y.Scale, snapPos.Y.Offset)
    elseif centerX > screenSize.X - snapDistance then
        -- Snap to right edge
        snapPos = UDim2.new(0, screenSize.X - buttonSize.X - 20, snapPos.Y.Scale, snapPos.Y.Offset)
    end
    
    if centerY < snapDistance then
        -- Snap to top edge
        snapPos = UDim2.new(snapPos.X.Scale, snapPos.X.Offset, 0, 20)
    elseif centerY > screenSize.Y - snapDistance then
        -- Snap to bottom edge
        snapPos = UDim2.new(snapPos.X.Scale, snapPos.X.Offset, 0, screenSize.Y - buttonSize.Y - 20)
    end
    
    -- Animate to snap position if changed
    if snapPos ~= currentPos then
        local snapTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
            Position = snapPos
        })
        snapTween:Play()
    end
end

function FloatingButton:CreateRipple()
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.5
    ripple.BorderSizePixel = 0
    ripple.ZIndex = 501
    ripple.Parent = self.RippleContainer
    
    local rippleCorner = Utils.CreateCorner(30)
    rippleCorner.Parent = ripple
    
    -- Animate ripple
    local expandTween = Utils.CreateTween(ripple, Utils.TweenInfo.Medium, {
        Size = UDim2.new(2, 0, 2, 0),
        BackgroundTransparency = 1
    })
    
    expandTween:Play()
    expandTween.Completed:Connect(function()
        ripple:Destroy()
    end)
end

function FloatingButton:StartPulseAnimation()
    if self.PulseConnection then
        self.PulseConnection:Disconnect()
    end
    
    self.PulseConnection = RunService.Heartbeat:Connect(function()
        if not self.Visible then return end
        
        wait(3) -- Pulse every 3 seconds
        
        -- Gentle pulse animation
        local pulseTween = Utils.CreateTween(self.ButtonStroke, Utils.TweenInfo.Slow, {
            Thickness = 4,
            Transparency = 0.3
        })
        
        pulseTween:Play()
        
        pulseTween.Completed:Connect(function()
            local restoreTween = Utils.CreateTween(self.ButtonStroke, Utils.TweenInfo.Slow, {
                Thickness = 2,
                Transparency = 0
            })
            restoreTween:Play()
        end)
    end)
end

function FloatingButton:SetupAutoHide()
    self:ResetHideTimer()
    
    -- Track user activity
    self.IdleConnection = UserInputService.InputBegan:Connect(function()
        if self.Visible then
            self:ResetHideTimer()
        end
    end)
end

function FloatingButton:ResetHideTimer()
    if self.HideTimer then
        self.HideTimer:Disconnect()
    end
    
    -- Show button if hidden
    if not self.Visible then
        self:Show()
    end
    
    -- Set new hide timer
    self.HideTimer = spawn(function()
        wait(self.HideDelay)
        if self.AutoHide and self.Visible then
            self:Hide()
        end
    end)
end

function FloatingButton:Show()
    if self.Visible then return end
    
    self.Visible = true
    self.Container.Visible = true
    
    -- Fade in animation
    self.Container.BackgroundTransparency = 1
    
    local fadeInTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        BackgroundTransparency = 0
    })
    
    -- Scale in animation
    self.Button.Size = UDim2.new(0, 0, 0, 0)
    local scaleInTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Bounce, {
        Size = UDim2.new(1, 0, 1, 0)
    })
    
    fadeInTween:Play()
    scaleInTween:Play()
end

function FloatingButton:Hide()
    if not self.Visible then return end
    
    self.Visible = false
    
    -- Scale out animation
    local scaleOutTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 0, 0, 0)
    })
    
    scaleOutTween:Play()
    scaleOutTween.Completed:Connect(function()
        self.Container.Visible = false
    end)
end

function FloatingButton:SetCallback(callback)
    self.Callback = callback
end

function FloatingButton:SetIcon(icon)
    self.Icon = icon
    self.IconLabel.Text = icon
end

function FloatingButton:SetPosition(position)
    self.Position = position
    self.Container.Position = position
end

function FloatingButton:SetSize(size)
    self.Size = size
    self.Container.Size = size
    
    -- Update corner radius based on size
    local radius = size.Y.Offset / 2
    local buttonCorner = self.Button:FindFirstChild("UICorner")
    if buttonCorner then
        buttonCorner.CornerRadius = UDim.new(0, radius)
    end
    
    local shadowCorner = self.Shadow:FindFirstChild("UICorner")
    if shadowCorner then
        shadowCorner.CornerRadius = UDim.new(0, radius + 4)
    end
end

function FloatingButton:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Button.BackgroundColor3 = theme:GetColor("Accent")
    self.ButtonStroke.Color = theme:GetColor("BorderHover")
end

function FloatingButton:Destroy()
    if self.PulseConnection then
        self.PulseConnection:Disconnect()
    end
    
    if self.IdleConnection then
        self.IdleConnection:Disconnect()
    end
    
    if self.HideTimer then
        self.HideTimer:Disconnect()
    end
    
    self.Container:Destroy()
end

return FloatingButton
