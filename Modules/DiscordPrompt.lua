--[[
    Discord Prompt for the Modern UI Library
--]]

local Utils = require("Modules.Utils")

local DiscordPrompt = {}
DiscordPrompt.__index = DiscordPrompt

function DiscordPrompt:new(parent, options, theme)
    local self = setmetatable({}, DiscordPrompt)
    
    -- Options
    local opts = options or {}
    self.Title = opts.Title or "Join our Discord!"
    self.Content = opts.Content or "Join our Discord server to get updates, support, and connect with the community."
    self.InviteLink = opts.InviteLink or "https://discord.gg/example"
    self.AutoClose = opts.AutoClose ~= false
    self.Duration = opts.Duration or 10
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Visible = false
    
    -- Create discord prompt
    self:CreateDiscordPrompt()
    
    return self
end

function DiscordPrompt:CreateDiscordPrompt()
    -- Background overlay
    self.Overlay = Instance.new("Frame")
    self.Overlay.Name = "DiscordOverlay"
    self.Overlay.Size = UDim2.new(1, 0, 1, 0)
    self.Overlay.Position = UDim2.new(0, 0, 0, 0)
    self.Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.Overlay.BackgroundTransparency = 0.5
    self.Overlay.BorderSizePixel = 0
    self.Overlay.ZIndex = 3000
    self.Overlay.Visible = false
    self.Overlay.Parent = self.Parent
    
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "DiscordContainer"
    self.Container.Size = UDim2.new(0, 400, 0, 300)
    self.Container.Position = UDim2.new(0.5, -200, 0.5, -150)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Primary")
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 3001
    self.Container.Parent = self.Overlay
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Create shadow
    self:CreateShadow()
    
    -- Discord logo/icon area
    self.IconArea = Instance.new("Frame")
    self.IconArea.Name = "DiscordIcon"
    self.IconArea.Size = UDim2.new(0, 80, 0, 80)
    self.IconArea.Position = UDim2.new(0.5, -40, 0, 30)
    self.IconArea.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord brand color
    self.IconArea.BorderSizePixel = 0
    self.IconArea.Parent = self.Container
    
    -- Icon corner
    local iconCorner = Utils.CreateCorner(40)
    iconCorner.Parent = self.IconArea
    
    -- Discord icon text (since we can't use images)
    self.IconLabel = Instance.new("TextLabel")
    self.IconLabel.Name = "DiscordIconLabel"
    self.IconLabel.Size = UDim2.new(1, 0, 1, 0)
    self.IconLabel.Position = UDim2.new(0, 0, 0, 0)
    self.IconLabel.BackgroundTransparency = 1
    self.IconLabel.Text = "💬"
    self.IconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.IconLabel.TextScaled = true
    self.IconLabel.Font = Enum.Font.GothamBold
    self.IconLabel.Parent = self.IconArea
    
    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "DiscordTitle"
    self.TitleLabel.Size = UDim2.new(1, -40, 0, 30)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 130)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Font = self.Theme:GetTextProperties("Title").Font
    self.TitleLabel.TextSize = self.Theme:GetTextProperties("Title").TextSize
    self.TitleLabel.Parent = self.Container
    
    -- Content label
    self.ContentLabel = Instance.new("TextLabel")
    self.ContentLabel.Name = "DiscordContent"
    self.ContentLabel.Size = UDim2.new(1, -40, 0, 60)
    self.ContentLabel.Position = UDim2.new(0, 20, 0, 170)
    self.ContentLabel.BackgroundTransparency = 1
    self.ContentLabel.Text = self.Content
    self.ContentLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.ContentLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    self.ContentLabel.Font = self.Theme:GetTextProperties("Body").Font
    self.ContentLabel.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.ContentLabel.TextWrapped = true
    self.ContentLabel.Parent = self.Container
    
    -- Join button
    self.JoinButton = Instance.new("TextButton")
    self.JoinButton.Name = "JoinDiscordButton"
    self.JoinButton.Size = UDim2.new(0, 150, 0, 35)
    self.JoinButton.Position = UDim2.new(0.5, -85, 0, 240)
    self.JoinButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    self.JoinButton.BorderSizePixel = 0
    self.JoinButton.Text = "Join Discord"
    self.JoinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.JoinButton.Font = self.Theme:GetTextProperties("Button").Font
    self.JoinButton.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.JoinButton.AutoButtonColor = false
    self.JoinButton.Parent = self.Container
    
    -- Join button corner
    local joinCorner = Utils.CreateCorner(6)
    joinCorner.Parent = self.JoinButton
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseDiscordButton"
    self.CloseButton.Size = UDim2.new(0, 80, 0, 35)
    self.CloseButton.Position = UDim2.new(0.5, 15, 0, 240)
    self.CloseButton.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Text = "Close"
    self.CloseButton.TextColor3 = self.Theme:GetColor("Text")
    self.CloseButton.Font = self.Theme:GetTextProperties("Button").Font
    self.CloseButton.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.CloseButton.AutoButtonColor = false
    self.CloseButton.Parent = self.Container
    
    -- Close button corner
    local closeCorner = Utils.CreateCorner(6)
    closeCorner.Parent = self.CloseButton
    
    -- Close button stroke
    local closeStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    closeStroke.Parent = self.CloseButton
    
    -- X button (top right)
    self.XButton = Instance.new("TextButton")
    self.XButton.Name = "XButton"
    self.XButton.Size = UDim2.new(0, 30, 0, 30)
    self.XButton.Position = UDim2.new(1, -40, 0, 10)
    self.XButton.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.XButton.BorderSizePixel = 0
    self.XButton.Text = "×"
    self.XButton.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.XButton.Font = Enum.Font.GothamBold
    self.XButton.TextSize = 18
    self.XButton.AutoButtonColor = false
    self.XButton.Parent = self.Container
    
    -- X button corner
    local xCorner = Utils.CreateCorner(15)
    xCorner.Parent = self.XButton
    
    -- Button events
    self.JoinButton.MouseButton1Click:Connect(function()
        self:JoinDiscord()
    end)
    
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    self.XButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    -- Click outside to close
    self.Overlay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self:Hide()
        end
    end)
    
    -- Prevent clicks on container from closing
    self.Container.InputBegan:Connect(function(input)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                input = nil
            end
        end)
    end)
    
    -- Hover effects
    Utils.SetupHoverEffect(self.JoinButton, Color3.fromRGB(78, 91, 220), Color3.fromRGB(88, 101, 242))
    Utils.SetupHoverEffect(self.CloseButton, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
    Utils.SetupHoverEffect(self.XButton, self.Theme:GetColor("Error"), self.Theme:GetColor("Surface"))
end

function DiscordPrompt:CreateShadow()
    local shadow = Instance.new("Frame")
    shadow.Name = "DiscordShadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.Container.ZIndex - 1
    shadow.Parent = self.Container.Parent
    
    local shadowCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    shadowCorner.Parent = shadow
    
    self.Shadow = shadow
end

function DiscordPrompt:Show()
    if self.Visible then return end
    
    self.Visible = true
    self.Overlay.Visible = true
    
    -- Start with container scaled down
    self.Container.Size = UDim2.new(0, 0, 0, 0)
    self.Container.BackgroundTransparency = 1
    
    -- Scale up animation
    local scaleUpTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Bounce, {
        Size = UDim2.new(0, 400, 0, 300),
        BackgroundTransparency = 0
    })
    
    scaleUpTween:Play()
    
    -- Pulse animation for icon
    self:StartIconPulse()
    
    -- Auto-close if enabled
    if self.AutoClose then
        spawn(function()
            wait(self.Duration)
            if self.Visible then
                self:Hide()
            end
        end)
    end
end

function DiscordPrompt:StartIconPulse()
    if not self.Visible then return end
    
    local pulseTween = Utils.CreateTween(self.IconArea, Utils.TweenInfo.Slow, {
        Size = UDim2.new(0, 85, 0, 85)
    })
    
    pulseTween:Play()
    
    pulseTween.Completed:Connect(function()
        if self.Visible then
            local reverseTween = Utils.CreateTween(self.IconArea, Utils.TweenInfo.Slow, {
                Size = UDim2.new(0, 80, 0, 80)
            })
            
            reverseTween:Play()
            
            reverseTween.Completed:Connect(function()
                spawn(function()
                    wait(0.5)
                    self:StartIconPulse()
                end)
            end)
        end
    end)
end

function DiscordPrompt:Hide()
    if not self.Visible then return end
    
    self.Visible = false
    
    -- Scale down animation
    local scaleDownTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    scaleDownTween:Play()
    
    -- Fade out overlay
    local overlayFadeOut = Utils.CreateTween(self.Overlay, Utils.TweenInfo.Medium, {
        BackgroundTransparency = 1
    })
    
    overlayFadeOut:Play()
    
    -- Cleanup after animation
    scaleDownTween.Completed:Connect(function()
        self.Overlay.Visible = false
        self.Overlay.BackgroundTransparency = 0.5
    end)
end

function DiscordPrompt:JoinDiscord()
    -- Copy invite link to clipboard (if supported)
    if setclipboard then
        setclipboard(self.InviteLink)
    end
    
    -- Try to open Discord invite in browser (if supported)
    if syn and syn.request then
        syn.request({
            Url = self.InviteLink,
            Method = "GET"
        })
    end
    
    -- Show feedback
    self.JoinButton.Text = "Invite Copied!"
    self.JoinButton.BackgroundColor3 = self.Theme:GetColor("Success")
    
    -- Auto-close after feedback
    spawn(function()
        wait(1.5)
        if self.Visible then
            self:Hide()
        end
    end)
end

function DiscordPrompt:SetTitle(title)
    self.Title = title
    self.TitleLabel.Text = title
end

function DiscordPrompt:SetContent(content)
    self.Content = content
    self.ContentLabel.Text = content
end

function DiscordPrompt:SetInviteLink(link)
    self.InviteLink = link
end

function DiscordPrompt:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Primary")
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    self.ContentLabel.TextColor3 = theme:GetColor("TextSecondary")
    self.CloseButton.BackgroundColor3 = theme:GetColor("Surface")
    self.CloseButton.TextColor3 = theme:GetColor("Text")
    self.XButton.BackgroundColor3 = theme:GetColor("Surface")
    self.XButton.TextColor3 = theme:GetColor("TextSecondary")
end

function DiscordPrompt:Destroy()
    if self.Shadow then
        self.Shadow:Destroy()
    end
    
    self.Overlay:Destroy()
end

return DiscordPrompt
