--[[
    Slider component for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local UserInputService = {}
local Utils = require("Modules.Utils")

local Slider = {}
Slider.__index = Slider

function Slider:new(parent, options, theme)
    local self = setmetatable({}, Slider)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Slider"
    self.Min = opts.Min or 0
    self.Max = opts.Max or 100
    self.Default = opts.Default or self.Min
    self.Step = opts.Step or 1
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    self.Suffix = opts.Suffix or ""
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Default
    self.Enabled = true
    self.Dragging = false
    
    -- Create slider
    self:CreateSlider()
    
    return self
end

function Slider:CreateSlider()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "SliderContainer"
    self.Container.Size = UDim2.new(1, 0, 0, 60)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Slider label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "SliderLabel"
    self.Label.Size = UDim2.new(1, -100, 0, 20)
    self.Label.Position = UDim2.new(0, 15, 0, 10)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Name
    self.Label.TextColor3 = self.Theme:GetColor("Text")
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextYAlignment = Enum.TextYAlignment.Center
    self.Label.Font = self.Theme:GetTextProperties("Body").Font
    self.Label.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.Label.Parent = self.Container
    
    -- Value label
    self.ValueLabel = Instance.new("TextLabel")
    self.ValueLabel.Name = "ValueLabel"
    self.ValueLabel.Size = UDim2.new(0, 80, 0, 20)
    self.ValueLabel.Position = UDim2.new(1, -95, 0, 10)
    self.ValueLabel.BackgroundTransparency = 1
    self.ValueLabel.Text = tostring(self.Value) .. self.Suffix
    self.ValueLabel.TextColor3 = self.Theme:GetColor("Accent")
    self.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.ValueLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.ValueLabel.Font = self.Theme:GetTextProperties("Body").Font
    self.ValueLabel.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.ValueLabel.Parent = self.Container
    
    -- Slider track
    self.Track = Instance.new("Frame")
    self.Track.Name = "SliderTrack"
    self.Track.Size = UDim2.new(1, -30, 0, 4)
    self.Track.Position = UDim2.new(0, 15, 0, 35)
    self.Track.BackgroundColor3 = self.Theme:GetColor("Border")
    self.Track.BorderSizePixel = 0
    self.Track.Parent = self.Container
    
    -- Track corner
    local trackCorner = Utils.CreateCorner(2)
    trackCorner.Parent = self.Track
    
    -- Slider fill
    self.Fill = Instance.new("Frame")
    self.Fill.Name = "SliderFill"
    self.Fill.Size = UDim2.new(self:GetPercentage(), 0, 1, 0)
    self.Fill.Position = UDim2.new(0, 0, 0, 0)
    self.Fill.BackgroundColor3 = self.Theme:GetColor("Accent")
    self.Fill.BorderSizePixel = 0
    self.Fill.Parent = self.Track
    
    -- Fill corner
    local fillCorner = Utils.CreateCorner(2)
    fillCorner.Parent = self.Fill
    
    -- Slider handle
    self.Handle = Instance.new("Frame")
    self.Handle.Name = "SliderHandle"
    self.Handle.Size = UDim2.new(0, 16, 0, 16)
    self.Handle.Position = UDim2.new(self:GetPercentage(), -8, 0.5, -8)
    self.Handle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.Handle.BorderSizePixel = 0
    self.Handle.ZIndex = 2
    self.Handle.Parent = self.Track
    
    -- Handle corner
    local handleCorner = Utils.CreateCorner(8)
    handleCorner.Parent = self.Handle
    
    -- Handle stroke
    local handleStroke = Utils.CreateStroke(2, self.Theme:GetColor("Accent"))
    handleStroke.Parent = self.Handle
    
    -- Description label (if provided)
    if self.Description then
        self.Container.Size = UDim2.new(1, 0, 0, 75)
        
        self.DescriptionLabel = Instance.new("TextLabel")
        self.DescriptionLabel.Name = "Description"
        self.DescriptionLabel.Size = UDim2.new(1, -30, 0, 15)
        self.DescriptionLabel.Position = UDim2.new(0, 15, 1, -20)
        self.DescriptionLabel.BackgroundTransparency = 1
        self.DescriptionLabel.Text = self.Description
        self.DescriptionLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
        self.DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
        self.DescriptionLabel.TextYAlignment = Enum.TextYAlignment.Center
        self.DescriptionLabel.Font = self.Theme:GetTextProperties("Caption").Font
        self.DescriptionLabel.TextSize = self.Theme:GetTextProperties("Caption").TextSize
        self.DescriptionLabel.Parent = self.Container
    end
    
    -- Input handling
    self:SetupInput()
    
    -- Initial visual update
    self:UpdateVisual()
end

function Slider:SetupInput()
    -- Track input for dragging
    self.Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Dragging = true
            self:UpdateFromInput(input.Position)
        end
    end)
    
    -- Handle input events
    UserInputService.InputChanged:Connect(function(input)
        if self.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            self:UpdateFromInput(input.Position)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Dragging = false
        end
    end)
end

function Slider:UpdateFromInput(inputPosition)
    if not self.Enabled then return end
    
    local trackPosition = self.Track.AbsolutePosition
    local trackSize = self.Track.AbsoluteSize
    
    -- Calculate percentage based on input position
    local relativeX = inputPosition.X - trackPosition.X
    local percentage = math.max(0, math.min(1, relativeX / trackSize.X))
    
    -- Calculate value
    local rawValue = self.Min + (self.Max - self.Min) * percentage
    local steppedValue = math.floor(rawValue / self.Step + 0.5) * self.Step
    local clampedValue = math.max(self.Min, math.min(self.Max, steppedValue))
    
    self:SetValue(clampedValue)
end

function Slider:SetValue(value)
    self.Value = math.max(self.Min, math.min(self.Max, value))
    self:UpdateVisual()
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Slider:GetPercentage()
    return (self.Value - self.Min) / (self.Max - self.Min)
end

function Slider:UpdateVisual()
    local percentage = self:GetPercentage()
    
    -- Update value label
    self.ValueLabel.Text = tostring(self.Value) .. self.Suffix
    
    -- Animate fill
    local fillTween = Utils.CreateTween(self.Fill, Utils.TweenInfo.Fast, {
        Size = UDim2.new(percentage, 0, 1, 0)
    })
    fillTween:Play()
    
    -- Animate handle
    local handleTween = Utils.CreateTween(self.Handle, Utils.TweenInfo.Fast, {
        Position = UDim2.new(percentage, -8, 0.5, -8)
    })
    handleTween:Play()
end

function Slider:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.ValueLabel.TextTransparency = transparency
    self.Track.BackgroundTransparency = transparency
    self.Fill.BackgroundTransparency = transparency
    self.Handle.BackgroundTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function Slider:GetValue()
    return self.Value
end

function Slider:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = theme:GetColor("Text")
    self.ValueLabel.TextColor3 = theme:GetColor("Accent")
    self.Track.BackgroundColor3 = theme:GetColor("Border")
    self.Fill.BackgroundColor3 = theme:GetColor("Accent")
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function Slider:Destroy()
    self.Container:Destroy()
end

return Slider
