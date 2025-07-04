--[[
    Toggle component for the Modern UI Library
--]]

local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local Toggle = {}
Toggle.__index = Toggle

function Toggle:new(parent, options, theme)
    local self = setmetatable({}, Toggle)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Toggle"
    self.Default = opts.Default or false
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Default
    self.Enabled = true
    
    -- Create toggle
    self:CreateToggle()
    
    return self
end

function Toggle:CreateToggle()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "ToggleContainer"
    self.Container.Size = UDim2.new(1, 0, 0, 50)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Toggle button (clickable area)
    self.ToggleButton = Instance.new("TextButton")
    self.ToggleButton.Name = "ToggleButton"
    self.ToggleButton.Size = UDim2.new(1, 0, 1, 0)
    self.ToggleButton.BackgroundTransparency = 1
    self.ToggleButton.BorderSizePixel = 0
    self.ToggleButton.Text = ""
    self.ToggleButton.Parent = self.Container
    
    -- Toggle label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "ToggleLabel"
    self.Label.Size = UDim2.new(1, -60, 1, 0)
    self.Label.Position = UDim2.new(0, 15, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Name
    self.Label.TextColor3 = self.Theme:GetColor("Text")
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextYAlignment = Enum.TextYAlignment.Center
    self.Label.Font = self.Theme:GetTextProperties("Body").Font
    self.Label.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.Label.Parent = self.Container
    
    -- Toggle switch background
    self.SwitchBackground = Instance.new("Frame")
    self.SwitchBackground.Name = "SwitchBackground"
    self.SwitchBackground.Size = UDim2.new(0, 40, 0, 20)
    self.SwitchBackground.Position = UDim2.new(1, -55, 0.5, -10)
    self.SwitchBackground.BackgroundColor3 = self.Value and self.Theme:GetColor("Accent") or self.Theme:GetColor("Border")
    self.SwitchBackground.BorderSizePixel = 0
    self.SwitchBackground.Parent = self.Container
    
    -- Switch corner
    local switchCorner = Utils.CreateCorner(10)
    switchCorner.Parent = self.SwitchBackground
    
    -- Toggle switch knob
    self.SwitchKnob = Instance.new("Frame")
    self.SwitchKnob.Name = "SwitchKnob"
    self.SwitchKnob.Size = UDim2.new(0, 16, 0, 16)
    self.SwitchKnob.Position = self.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    self.SwitchKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.SwitchKnob.BorderSizePixel = 0
    self.SwitchKnob.Parent = self.SwitchBackground
    
    -- Knob corner
    local knobCorner = Utils.CreateCorner(8)
    knobCorner.Parent = self.SwitchKnob
    
    -- Description label (if provided)
    if self.Description then
        self.Container.Size = UDim2.new(1, 0, 0, 70)
        
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
    
    -- Click event
    self.ToggleButton.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:SetValue(not self.Value)
        end
    end)
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
    
    -- Initial state
    self:UpdateVisual()
end

function Toggle:SetValue(value)
    self.Value = value
    self:UpdateVisual()
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Toggle:UpdateVisual()
    -- Animate switch background color
    local bgColorTween = Utils.CreateTween(self.SwitchBackground, Utils.TweenInfo.Fast, {
        BackgroundColor3 = self.Value and self.Theme:GetColor("Accent") or self.Theme:GetColor("Border")
    })
    bgColorTween:Play()
    
    -- Animate switch knob position
    local knobPosTween = Utils.CreateTween(self.SwitchKnob, Utils.TweenInfo.Fast, {
        Position = self.Value and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    })
    knobPosTween:Play()
    
    -- Update label color
    local labelColorTween = Utils.CreateTween(self.Label, Utils.TweenInfo.Fast, {
        TextColor3 = self.Value and self.Theme:GetColor("Text") or self.Theme:GetColor("TextSecondary")
    })
    labelColorTween:Play()
end

function Toggle:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.SwitchBackground.BackgroundTransparency = transparency
    self.SwitchKnob.BackgroundTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function Toggle:GetValue()
    return self.Value
end

function Toggle:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = self.Value and theme:GetColor("Text") or theme:GetColor("TextSecondary")
    self.SwitchBackground.BackgroundColor3 = self.Value and theme:GetColor("Accent") or theme:GetColor("Border")
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function Toggle:Destroy()
    self.Container:Destroy()
end

return Toggle
