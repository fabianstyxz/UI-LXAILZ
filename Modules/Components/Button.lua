--[[
    Button component for the Modern UI Library
--]]

local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local Button = {}
Button.__index = Button

function Button:new(parent, options, theme)
    local self = setmetatable({}, Button)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Button"
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    self.Color = opts.Color or nil
    self.Size = opts.Size or UDim2.new(1, 0, 0, 40)
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Enabled = true
    self.Pressed = false
    
    -- Create button
    self:CreateButton()
    
    return self
end

function Button:CreateButton()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "ButtonContainer"
    self.Container.Size = self.Description and UDim2.new(1, 0, 0, 65) or UDim2.new(1, 0, 0, 50)
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Button frame
    self.Button = Instance.new("TextButton")
    self.Button.Name = "Button"
    self.Button.Size = self.Size
    self.Button.Position = UDim2.new(0, 0, 0, 0)
    self.Button.BackgroundColor3 = self.Color or self.Theme:GetColor("Accent")
    self.Button.BorderSizePixel = 0
    self.Button.Text = self.Name
    self.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.Button.Font = self.Theme:GetTextProperties("Button").Font
    self.Button.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.Button.AutoButtonColor = false
    self.Button.Parent = self.Container
    
    -- Button corner
    local buttonCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    buttonCorner.Parent = self.Button
    
    -- Button stroke
    local buttonStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    buttonStroke.Parent = self.Button
    
    -- Description label (if provided)
    if self.Description then
        self.DescriptionLabel = Instance.new("TextLabel")
        self.DescriptionLabel.Name = "Description"
        self.DescriptionLabel.Size = UDim2.new(1, 0, 0, 15)
        self.DescriptionLabel.Position = UDim2.new(0, 0, 1, -20)
        self.DescriptionLabel.BackgroundTransparency = 1
        self.DescriptionLabel.Text = self.Description
        self.DescriptionLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
        self.DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Center
        self.DescriptionLabel.TextYAlignment = Enum.TextYAlignment.Center
        self.DescriptionLabel.Font = self.Theme:GetTextProperties("Caption").Font
        self.DescriptionLabel.TextSize = self.Theme:GetTextProperties("Caption").TextSize
        self.DescriptionLabel.Parent = self.Container
    end
    
    -- Button events
    self.Button.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:OnClick()
        end
    end)
    
    -- Press effects
    self.Button.MouseButton1Down:Connect(function()
        if self.Enabled then
            self:OnPress()
        end
    end)
    
    self.Button.MouseButton1Up:Connect(function()
        if self.Enabled then
            self:OnRelease()
        end
    end)
    
    -- Hover effects
    self.Button.MouseEnter:Connect(function()
        if self.Enabled then
            self:OnHover()
        end
    end)
    
    self.Button.MouseLeave:Connect(function()
        if self.Enabled then
            self:OnLeave()
        end
    end)
end

function Button:OnClick()
    -- Ripple effect
    local mousePosition = UserInputService:GetMouseLocation()
    local buttonPosition = self.Button.AbsolutePosition
    local relativePosition = Vector2.new(
        mousePosition.X - buttonPosition.X,
        mousePosition.Y - buttonPosition.Y
    )
    
    Utils.CreateRipple(self.Button, relativePosition, Color3.fromRGB(255, 255, 255))
    
    -- Call callback
    spawn(function()
        self.Callback()
    end)
end

function Button:OnPress()
    self.Pressed = true
    
    -- Scale down animation
    local pressTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = UDim2.new(self.Size.X.Scale, self.Size.X.Offset - 4, self.Size.Y.Scale, self.Size.Y.Offset - 2)
    })
    pressTween:Play()
end

function Button:OnRelease()
    self.Pressed = false
    
    -- Scale back up animation
    local releaseTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        Size = self.Size
    })
    releaseTween:Play()
end

function Button:OnHover()
    -- Hover color animation
    local hoverColor = self.Color or self.Theme:GetColor("AccentHover")
    local hoverTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = hoverColor
    })
    hoverTween:Play()
end

function Button:OnLeave()
    -- Return to normal color
    local normalColor = self.Color or self.Theme:GetColor("Accent")
    local leaveTween = Utils.CreateTween(self.Button, Utils.TweenInfo.Fast, {
        BackgroundColor3 = normalColor
    })
    leaveTween:Play()
end

function Button:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Button.BackgroundTransparency = transparency
    self.Button.TextTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function Button:SetText(text)
    self.Name = text
    self.Button.Text = text
end

function Button:SetColor(color)
    self.Color = color
    self.Button.BackgroundColor3 = color
end

function Button:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    if not self.Color then
        self.Button.BackgroundColor3 = theme:GetColor("Accent")
    end
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function Button:Destroy()
    self.Container:Destroy()
end

return Button
