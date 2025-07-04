--[[
    ColorPicker component for the Modern UI Library
--]]

local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local ColorPicker = {}
ColorPicker.__index = ColorPicker

function ColorPicker:new(parent, options, theme)
    local self = setmetatable({}, ColorPicker)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Color Picker"
    self.Default = opts.Default or Color3.fromRGB(255, 0, 0)
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Default
    self.Enabled = true
    self.ColorPickerOpen = false
    self.Dragging = false
    self.HueDragging = false
    
    -- Create color picker
    self:CreateColorPicker()
    
    return self
end

function ColorPicker:CreateColorPicker()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "ColorPickerContainer"
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
    
    -- Color picker label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "ColorPickerLabel"
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
    
    -- Color preview button
    self.ColorPreview = Instance.new("TextButton")
    self.ColorPreview.Name = "ColorPreview"
    self.ColorPreview.Size = UDim2.new(0, 35, 0, 35)
    self.ColorPreview.Position = UDim2.new(1, -50, 0.5, -17.5)
    self.ColorPreview.BackgroundColor3 = self.Value
    self.ColorPreview.BorderSizePixel = 0
    self.ColorPreview.Text = ""
    self.ColorPreview.AutoButtonColor = false
    self.ColorPreview.Parent = self.Container
    
    -- Color preview corner
    local previewCorner = Utils.CreateCorner(6)
    previewCorner.Parent = self.ColorPreview
    
    -- Color preview stroke
    local previewStroke = Utils.CreateStroke(2, self.Theme:GetColor("Border"))
    previewStroke.Parent = self.ColorPreview
    
    -- Description label (if provided)
    if self.Description then
        self.Container.Size = UDim2.new(1, 0, 0, 80)
        
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
    
    -- Create color picker popup
    self:CreateColorPickerPopup()
    
    -- Color preview click event
    self.ColorPreview.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:ToggleColorPicker()
        end
    end)
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
end

function ColorPicker:CreateColorPickerPopup()
    -- Color picker popup
    self.ColorPickerPopup = Instance.new("Frame")
    self.ColorPickerPopup.Name = "ColorPickerPopup"
    self.ColorPickerPopup.Size = UDim2.new(0, 250, 0, 200)
    self.ColorPickerPopup.Position = UDim2.new(0, 0, 1, 10)
    self.ColorPickerPopup.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.ColorPickerPopup.BorderSizePixel = 0
    self.ColorPickerPopup.Visible = false
    self.ColorPickerPopup.ZIndex = 20
    self.ColorPickerPopup.Parent = self.Container
    
    -- Popup corner
    local popupCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    popupCorner.Parent = self.ColorPickerPopup
    
    -- Popup stroke
    local popupStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    popupStroke.Parent = self.ColorPickerPopup
    
    -- Color canvas
    self.ColorCanvas = Instance.new("Frame")
    self.ColorCanvas.Name = "ColorCanvas"
    self.ColorCanvas.Size = UDim2.new(0, 180, 0, 180)
    self.ColorCanvas.Position = UDim2.new(0, 10, 0, 10)
    self.ColorCanvas.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    self.ColorCanvas.BorderSizePixel = 0
    self.ColorCanvas.Parent = self.ColorPickerPopup
    
    -- Canvas corner
    local canvasCorner = Utils.CreateCorner(6)
    canvasCorner.Parent = self.ColorCanvas
    
    -- Saturation/Brightness overlay
    self.SaturationOverlay = Instance.new("Frame")
    self.SaturationOverlay.Name = "SaturationOverlay"
    self.SaturationOverlay.Size = UDim2.new(1, 0, 1, 0)
    self.SaturationOverlay.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.SaturationOverlay.BorderSizePixel = 0
    self.SaturationOverlay.Parent = self.ColorCanvas
    
    local saturationCorner = Utils.CreateCorner(6)
    saturationCorner.Parent = self.SaturationOverlay
    
    -- Create gradient for saturation
    local saturationGradient = Instance.new("UIGradient")
    saturationGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
    }
    saturationGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 1)
    }
    saturationGradient.Parent = self.SaturationOverlay
    
    -- Brightness overlay
    self.BrightnessOverlay = Instance.new("Frame")
    self.BrightnessOverlay.Name = "BrightnessOverlay"
    self.BrightnessOverlay.Size = UDim2.new(1, 0, 1, 0)
    self.BrightnessOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.BrightnessOverlay.BorderSizePixel = 0
    self.BrightnessOverlay.Parent = self.SaturationOverlay
    
    local brightnessCorner = Utils.CreateCorner(6)
    brightnessCorner.Parent = self.BrightnessOverlay
    
    -- Create gradient for brightness
    local brightnessGradient = Instance.new("UIGradient")
    brightnessGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
    }
    brightnessGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(1, 0)
    }
    brightnessGradient.Rotation = 90
    brightnessGradient.Parent = self.BrightnessOverlay
    
    -- Color selector dot
    self.ColorSelector = Instance.new("Frame")
    self.ColorSelector.Name = "ColorSelector"
    self.ColorSelector.Size = UDim2.new(0, 8, 0, 8)
    self.ColorSelector.Position = UDim2.new(1, -4, 0, -4)
    self.ColorSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.ColorSelector.BorderSizePixel = 0
    self.ColorSelector.ZIndex = 5
    self.ColorSelector.Parent = self.ColorCanvas
    
    local selectorCorner = Utils.CreateCorner(4)
    selectorCorner.Parent = self.ColorSelector
    
    local selectorStroke = Utils.CreateStroke(2, Color3.fromRGB(0, 0, 0))
    selectorStroke.Parent = self.ColorSelector
    
    -- Hue slider
    self.HueSlider = Instance.new("Frame")
    self.HueSlider.Name = "HueSlider"
    self.HueSlider.Size = UDim2.new(0, 20, 0, 180)
    self.HueSlider.Position = UDim2.new(0, 200, 0, 10)
    self.HueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.HueSlider.BorderSizePixel = 0
    self.HueSlider.Parent = self.ColorPickerPopup
    
    local hueCorner = Utils.CreateCorner(6)
    hueCorner.Parent = self.HueSlider
    
    -- Hue gradient
    local hueGradient = Instance.new("UIGradient")
    hueGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
    }
    hueGradient.Rotation = 90
    hueGradient.Parent = self.HueSlider
    
    -- Hue selector
    self.HueSelector = Instance.new("Frame")
    self.HueSelector.Name = "HueSelector"
    self.HueSelector.Size = UDim2.new(1, 4, 0, 4)
    self.HueSelector.Position = UDim2.new(0, -2, 0, -2)
    self.HueSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.HueSelector.BorderSizePixel = 0
    self.HueSelector.ZIndex = 5
    self.HueSelector.Parent = self.HueSlider
    
    local hueSelectorCorner = Utils.CreateCorner(2)
    hueSelectorCorner.Parent = self.HueSelector
    
    local hueSelectorStroke = Utils.CreateStroke(1, Color3.fromRGB(0, 0, 0))
    hueSelectorStroke.Parent = self.HueSelector
    
    -- Setup input handling
    self:SetupColorPickerInput()
    
    -- Initialize color
    self:UpdateColorFromValue()
end

function ColorPicker:SetupColorPickerInput()
    -- Color canvas dragging
    self.ColorCanvas.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Dragging = true
            self:UpdateColorFromCanvas(input.Position)
        end
    end)
    
    -- Hue slider dragging
    self.HueSlider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.HueDragging = true
            self:UpdateHueFromSlider(input.Position)
        end
    end)
    
    -- Global input handling
    UserInputService.InputChanged:Connect(function(input)
        if self.Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            self:UpdateColorFromCanvas(input.Position)
        elseif self.HueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            self:UpdateHueFromSlider(input.Position)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            self.Dragging = false
            self.HueDragging = false
        end
    end)
end

function ColorPicker:UpdateColorFromCanvas(inputPosition)
    local canvasPosition = self.ColorCanvas.AbsolutePosition
    local canvasSize = self.ColorCanvas.AbsoluteSize
    
    local relativeX = math.max(0, math.min(1, (inputPosition.X - canvasPosition.X) / canvasSize.X))
    local relativeY = math.max(0, math.min(1, (inputPosition.Y - canvasPosition.Y) / canvasSize.Y))
    
    -- Update selector position
    self.ColorSelector.Position = UDim2.new(relativeX, -4, relativeY, -4)
    
    -- Calculate final color
    self:CalculateColorFromSV(relativeX, 1 - relativeY)
end

function ColorPicker:UpdateHueFromSlider(inputPosition)
    local sliderPosition = self.HueSlider.AbsolutePosition
    local sliderSize = self.HueSlider.AbsoluteSize
    
    local relativeY = math.max(0, math.min(1, (inputPosition.Y - sliderPosition.Y) / sliderSize.Y))
    
    -- Update hue selector position
    self.HueSelector.Position = UDim2.new(0, -2, relativeY, -2)
    
    -- Calculate hue
    local hue = relativeY * 360
    self:SetHue(hue)
end

function ColorPicker:SetHue(hue)
    -- Convert hue to RGB for canvas background
    local function HSVtoRGB(h, s, v)
        local r, g, b
        local i = math.floor(h / 60) % 6
        local f = h / 60 - i
        local p = v * (1 - s)
        local q = v * (1 - f * s)
        local t = v * (1 - (1 - f) * s)
        
        if i == 0 then
            r, g, b = v, t, p
        elseif i == 1 then
            r, g, b = q, v, p
        elseif i == 2 then
            r, g, b = p, v, t
        elseif i == 3 then
            r, g, b = p, q, v
        elseif i == 4 then
            r, g, b = t, p, v
        elseif i == 5 then
            r, g, b = v, p, q
        end
        
        return r, g, b
    end
    
    local r, g, b = HSVtoRGB(hue, 1, 1)
    self.ColorCanvas.BackgroundColor3 = Color3.fromRGB(r * 255, g * 255, b * 255)
    
    -- Recalculate color with current saturation/brightness
    local selectorPos = self.ColorSelector.Position
    local saturation = selectorPos.X.Scale
    local brightness = 1 - selectorPos.Y.Scale
    
    self:CalculateColorFromSV(saturation, brightness)
end

function ColorPicker:CalculateColorFromSV(saturation, brightness)
    local canvasColor = self.ColorCanvas.BackgroundColor3
    
    -- Apply saturation and brightness
    local finalColor = Color3.new(
        Utils.Lerp(brightness, canvasColor.R * brightness, saturation),
        Utils.Lerp(brightness, canvasColor.G * brightness, saturation),
        Utils.Lerp(brightness, canvasColor.B * brightness, saturation)
    )
    
    self:SetValue(finalColor)
end

function ColorPicker:UpdateColorFromValue()
    -- Convert RGB to HSV to position selectors
    local function RGBtoHSV(r, g, b)
        local max = math.max(r, g, b)
        local min = math.min(r, g, b)
        local h, s, v = 0, 0, max
        
        local d = max - min
        s = max == 0 and 0 or d / max
        
        if max == min then
            h = 0
        else
            if max == r then
                h = (g - b) / d + (g < b and 6 or 0)
            elseif max == g then
                h = (b - r) / d + 2
            elseif max == b then
                h = (r - g) / d + 4
            end
            h = h / 6
        end
        
        return h * 360, s, v
    end
    
    local h, s, v = RGBtoHSV(self.Value.R, self.Value.G, self.Value.B)
    
    -- Update hue selector
    self.HueSelector.Position = UDim2.new(0, -2, h / 360, -2)
    
    -- Update canvas background
    self:SetHue(h)
    
    -- Update color selector
    self.ColorSelector.Position = UDim2.new(s, -4, 1 - v, -4)
end

function ColorPicker:ToggleColorPicker()
    self.ColorPickerOpen = not self.ColorPickerOpen
    
    if self.ColorPickerOpen then
        self.ColorPickerPopup.Visible = true
        self.ColorPickerPopup.Size = UDim2.new(0, 0, 0, 0)
        
        local openTween = Utils.CreateTween(self.ColorPickerPopup, Utils.TweenInfo.Medium, {
            Size = UDim2.new(0, 250, 0, 200)
        })
        openTween:Play()
    else
        local closeTween = Utils.CreateTween(self.ColorPickerPopup, Utils.TweenInfo.Medium, {
            Size = UDim2.new(0, 0, 0, 0)
        })
        closeTween:Play()
        
        closeTween.Completed:Connect(function()
            self.ColorPickerPopup.Visible = false
        end)
    end
end

function ColorPicker:SetValue(value)
    self.Value = value
    self.ColorPreview.BackgroundColor3 = value
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function ColorPicker:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.ColorPreview.BackgroundTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function ColorPicker:GetValue()
    return self.Value
end

function ColorPicker:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = theme:GetColor("Text")
    self.ColorPickerPopup.BackgroundColor3 = theme:GetColor("Surface")
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function ColorPicker:Destroy()
    self.Container:Destroy()
end

return ColorPicker
