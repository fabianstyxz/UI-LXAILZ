--[[
    Input component for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local UserInputService = {}
local Utils = require("Modules.Utils")

local Input = {}
Input.__index = Input

function Input:new(parent, options, theme)
    local self = setmetatable({}, Input)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Input"
    self.Default = opts.Default or ""
    self.Placeholder = opts.Placeholder or "Enter text..."
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    self.NumbersOnly = opts.NumbersOnly or false
    self.ClearTextOnFocus = opts.ClearTextOnFocus or false
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Default
    self.Enabled = true
    self.Focused = false
    
    -- Create input
    self:CreateInput()
    
    return self
end

function Input:CreateInput()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "InputContainer"
    self.Container.Size = UDim2.new(1, 0, 0, 60)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    self.ContainerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    self.ContainerStroke.Parent = self.Container
    
    -- Input label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "InputLabel"
    self.Label.Size = UDim2.new(1, -30, 0, 20)
    self.Label.Position = UDim2.new(0, 15, 0, 5)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Name
    self.Label.TextColor3 = self.Theme:GetColor("Text")
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextYAlignment = Enum.TextYAlignment.Center
    self.Label.Font = self.Theme:GetTextProperties("Caption").Font
    self.Label.TextSize = self.Theme:GetTextProperties("Caption").TextSize
    self.Label.Parent = self.Container
    
    -- Input box
    self.TextBox = Instance.new("TextBox")
    self.TextBox.Name = "InputBox"
    self.TextBox.Size = UDim2.new(1, -30, 0, 25)
    self.TextBox.Position = UDim2.new(0, 15, 0, 25)
    self.TextBox.BackgroundTransparency = 1
    self.TextBox.Text = self.Value
    self.TextBox.PlaceholderText = self.Placeholder
    self.TextBox.TextColor3 = self.Theme:GetColor("Text")
    self.TextBox.PlaceholderColor3 = self.Theme:GetColor("TextDisabled")
    self.TextBox.TextXAlignment = Enum.TextXAlignment.Left
    self.TextBox.TextYAlignment = Enum.TextYAlignment.Center
    self.TextBox.Font = self.Theme:GetTextProperties("Body").Font
    self.TextBox.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.TextBox.ClearButtonMode = Enum.ClearButtonMode.WhileEditing
    self.TextBox.Parent = self.Container
    
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
    
    -- Input events
    self.TextBox.Focused:Connect(function()
        self:OnFocus()
    end)
    
    self.TextBox.FocusLost:Connect(function(enterPressed)
        self:OnFocusLost(enterPressed)
    end)
    
    self.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:OnTextChanged()
    end)
    
    -- Initial visual update
    self:UpdateVisual()
end

function Input:OnFocus()
    self.Focused = true
    
    -- Clear text if specified
    if self.ClearTextOnFocus then
        self.TextBox.Text = ""
    end
    
    -- Update border color
    local focusTween = Utils.CreateTween(self.ContainerStroke, Utils.TweenInfo.Fast, {
        Color = self.Theme:GetColor("Accent")
    })
    focusTween:Play()
    
    -- Scale animation
    local scaleTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Fast, {
        Size = UDim2.new(1, 0, 0, self.Container.Size.Y.Offset + 2)
    })
    scaleTween:Play()
end

function Input:OnFocusLost(enterPressed)
    self.Focused = false
    
    -- Update border color
    local unfocusTween = Utils.CreateTween(self.ContainerStroke, Utils.TweenInfo.Fast, {
        Color = self.Theme:GetColor("Border")
    })
    unfocusTween:Play()
    
    -- Scale back
    local scaleTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Fast, {
        Size = UDim2.new(1, 0, 0, self.Container.Size.Y.Offset - 2)
    })
    scaleTween:Play()
    
    -- Update value and call callback
    self.Value = self.TextBox.Text
    
    if enterPressed then
        spawn(function()
            self.Callback(self.Value)
        end)
    end
end

function Input:OnTextChanged()
    local text = self.TextBox.Text
    
    -- Filter numbers only if specified
    if self.NumbersOnly then
        text = string.gsub(text, "[^%d%.%-]", "")
        if text ~= self.TextBox.Text then
            self.TextBox.Text = text
        end
    end
    
    -- Update value
    self.Value = text
end

function Input:SetValue(value)
    self.Value = tostring(value)
    self.TextBox.Text = self.Value
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Input:UpdateVisual()
    -- Update text color based on focus
    if self.Focused then
        self.Label.TextColor3 = self.Theme:GetColor("Accent")
    else
        self.Label.TextColor3 = self.Theme:GetColor("Text")
    end
end

function Input:SetEnabled(enabled)
    self.Enabled = enabled
    self.TextBox.Editable = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.TextBox.TextTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function Input:GetValue()
    return self.Value
end

function Input:SetPlaceholder(placeholder)
    self.Placeholder = placeholder
    self.TextBox.PlaceholderText = placeholder
end

function Input:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = self.Focused and theme:GetColor("Accent") or theme:GetColor("Text")
    self.TextBox.TextColor3 = theme:GetColor("Text")
    self.TextBox.PlaceholderColor3 = theme:GetColor("TextDisabled")
    self.ContainerStroke.Color = self.Focused and theme:GetColor("Accent") or theme:GetColor("Border")
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function Input:Destroy()
    self.Container:Destroy()
end

return Input
