--[[
    Notification system for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local TweenService = {}
local Utils = require("Modules.Utils")

local Notification = {}
Notification.__index = Notification

function Notification:new(parent, options, theme)
    local self = setmetatable({}, Notification)
    
    -- Options
    local opts = options or {}
    self.Title = opts.Title or "Notification"
    self.Content = opts.Content or "This is a notification."
    self.Duration = opts.Duration or 5
    self.Type = opts.Type or "Info" -- Info, Success, Warning, Error
    self.Icon = opts.Icon or nil
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Visible = false
    
    -- Create notification
    self:CreateNotification()
    
    return self
end

function Notification:CreateNotification()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "NotificationContainer"
    self.Container.Size = UDim2.new(0, 350, 0, 80)
    self.Container.Position = UDim2.new(1, -370, 0, 20)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 100
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self:GetTypeColor())
    containerStroke.Parent = self.Container
    
    -- Create shadow
    self:CreateShadow()
    
    -- Type indicator
    self.TypeIndicator = Instance.new("Frame")
    self.TypeIndicator.Name = "TypeIndicator"
    self.TypeIndicator.Size = UDim2.new(0, 4, 1, 0)
    self.TypeIndicator.Position = UDim2.new(0, 0, 0, 0)
    self.TypeIndicator.BackgroundColor3 = self:GetTypeColor()
    self.TypeIndicator.BorderSizePixel = 0
    self.TypeIndicator.Parent = self.Container
    
    -- Indicator corner
    local indicatorCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    indicatorCorner.Parent = self.TypeIndicator
    
    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "NotificationTitle"
    self.TitleLabel.Size = UDim2.new(1, -70, 0, 25)
    self.TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Font = self.Theme:GetTextProperties("Subtitle").Font
    self.TitleLabel.TextSize = self.Theme:GetTextProperties("Subtitle").TextSize
    self.TitleLabel.TextTruncate = Enum.TextTruncate.AtEnd
    self.TitleLabel.Parent = self.Container
    
    -- Content label
    self.ContentLabel = Instance.new("TextLabel")
    self.ContentLabel.Name = "NotificationContent"
    self.ContentLabel.Size = UDim2.new(1, -70, 0, 35)
    self.ContentLabel.Position = UDim2.new(0, 15, 0, 35)
    self.ContentLabel.BackgroundTransparency = 1
    self.ContentLabel.Text = self.Content
    self.ContentLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    self.ContentLabel.Font = self.Theme:GetTextProperties("Body").Font
    self.ContentLabel.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.ContentLabel.TextWrapped = true
    self.ContentLabel.Parent = self.Container
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 20, 0, 20)
    self.CloseButton.Position = UDim2.new(1, -30, 0, 10)
    self.CloseButton.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.TextSize = 16
    self.CloseButton.AutoButtonColor = false
    self.CloseButton.Parent = self.Container
    
    -- Close button corner
    local closeCorner = Utils.CreateCorner(10)
    closeCorner.Parent = self.CloseButton
    
    -- Close button event
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    -- Hover effects
    Utils.SetupHoverEffect(self.CloseButton, self.Theme:GetColor("Error"), self.Theme:GetColor("Surface"))
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
    
    -- Progress bar (if duration > 0)
    if self.Duration > 0 then
        self:CreateProgressBar()
    end
end

function Notification:CreateShadow()
    local shadow = Instance.new("Frame")
    shadow.Name = "NotificationShadow"
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, 3, 0, 3)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.Container.ZIndex - 1
    shadow.Parent = self.Container.Parent
    
    local shadowCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    shadowCorner.Parent = shadow
    
    self.Shadow = shadow
end

function Notification:CreateProgressBar()
    -- Progress bar background
    self.ProgressBackground = Instance.new("Frame")
    self.ProgressBackground.Name = "ProgressBackground"
    self.ProgressBackground.Size = UDim2.new(1, 0, 0, 3)
    self.ProgressBackground.Position = UDim2.new(0, 0, 1, -3)
    self.ProgressBackground.BackgroundColor3 = self.Theme:GetColor("Border")
    self.ProgressBackground.BorderSizePixel = 0
    self.ProgressBackground.Parent = self.Container
    
    -- Progress bar fill
    self.ProgressFill = Instance.new("Frame")
    self.ProgressFill.Name = "ProgressFill"
    self.ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    self.ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    self.ProgressFill.BackgroundColor3 = self:GetTypeColor()
    self.ProgressFill.BorderSizePixel = 0
    self.ProgressFill.Parent = self.ProgressBackground
    
    -- Progress corners
    local bgCorner = Utils.CreateCorner(2)
    bgCorner.Parent = self.ProgressBackground
    
    local fillCorner = Utils.CreateCorner(2)
    fillCorner.Parent = self.ProgressFill
end

function Notification:GetTypeColor()
    local typeColors = {
        Info = self.Theme:GetColor("Info"),
        Success = self.Theme:GetColor("Success"),
        Warning = self.Theme:GetColor("Warning"),
        Error = self.Theme:GetColor("Error")
    }
    
    return typeColors[self.Type] or self.Theme:GetColor("Info")
end

function Notification:Show()
    if self.Visible then return end
    
    self.Visible = true
    
    -- Start off-screen
    self.Container.Position = UDim2.new(1, 0, 0, 20)
    
    -- Slide in animation
    local slideInTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Position = UDim2.new(1, -370, 0, 20)
    })
    
    slideInTween:Play()
    
    -- Animate progress bar if duration > 0
    if self.Duration > 0 and self.ProgressFill then
        local progressTween = Utils.CreateTween(self.ProgressFill, TweenInfo.new(self.Duration, Enum.EasingStyle.Linear), {
            Size = UDim2.new(0, 0, 1, 0)
        })
        
        progressTween:Play()
        
        -- Auto-hide when progress completes
        progressTween.Completed:Connect(function()
            self:Hide()
        end)
    end
end

function Notification:Hide()
    if not self.Visible then return end
    
    self.Visible = false
    
    -- Slide out animation
    local slideOutTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Position = UDim2.new(1, 0, 0, 20)
    })
    
    slideOutTween:Play()
    
    -- Cleanup after animation
    slideOutTween.Completed:Connect(function()
        self:Destroy()
    end)
end

function Notification:UpdatePosition(yOffset)
    if not self.Visible then return end
    
    local positionTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Fast, {
        Position = UDim2.new(1, -370, 0, 20 + yOffset)
    })
    
    positionTween:Play()
end

function Notification:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    self.ContentLabel.TextColor3 = theme:GetColor("TextSecondary")
    self.CloseButton.TextColor3 = theme:GetColor("TextSecondary")
    
    local typeColor = self:GetTypeColor()
    self.TypeIndicator.BackgroundColor3 = typeColor
    
    if self.ProgressFill then
        self.ProgressFill.BackgroundColor3 = typeColor
        self.ProgressBackground.BackgroundColor3 = theme:GetColor("Border")
    end
end

function Notification:Destroy()
    if self.Shadow then
        self.Shadow:Destroy()
    end
    
    self.Container:Destroy()
end

return Notification
