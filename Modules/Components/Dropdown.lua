--[[
    Dropdown component for the Modern UI Library
--]]

local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown:new(parent, options, theme)
    local self = setmetatable({}, Dropdown)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Dropdown"
    self.Options = opts.Options or {"Option 1", "Option 2"}
    self.Default = opts.Default or nil
    self.Multi = opts.Multi or false
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Multi and {} or self.Default
    self.Enabled = true
    self.Expanded = false
    self.OptionButtons = {}
    
    -- Create dropdown
    self:CreateDropdown()
    
    return self
end

function Dropdown:CreateDropdown()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "DropdownContainer"
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
    
    -- Dropdown label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "DropdownLabel"
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
    
    -- Dropdown button
    self.DropdownButton = Instance.new("TextButton")
    self.DropdownButton.Name = "DropdownButton"
    self.DropdownButton.Size = UDim2.new(1, -30, 0, 25)
    self.DropdownButton.Position = UDim2.new(0, 15, 0, 25)
    self.DropdownButton.BackgroundTransparency = 1
    self.DropdownButton.Text = self:GetDisplayText()
    self.DropdownButton.TextColor3 = self.Theme:GetColor("Text")
    self.DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
    self.DropdownButton.TextYAlignment = Enum.TextYAlignment.Center
    self.DropdownButton.Font = self.Theme:GetTextProperties("Body").Font
    self.DropdownButton.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.DropdownButton.AutoButtonColor = false
    self.DropdownButton.Parent = self.Container
    
    -- Dropdown arrow
    self.Arrow = Instance.new("ImageLabel")
    self.Arrow.Name = "DropdownArrow"
    self.Arrow.Size = UDim2.new(0, 12, 0, 12)
    self.Arrow.Position = UDim2.new(1, -27, 0, 31)
    self.Arrow.BackgroundTransparency = 1
    self.Arrow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    self.Arrow.ImageColor3 = self.Theme:GetColor("TextSecondary")
    self.Arrow.Rotation = 0
    self.Arrow.Parent = self.Container
    
    -- Options container
    self.OptionsContainer = Instance.new("Frame")
    self.OptionsContainer.Name = "OptionsContainer"
    self.OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
    self.OptionsContainer.Position = UDim2.new(0, 0, 1, 5)
    self.OptionsContainer.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.OptionsContainer.BorderSizePixel = 0
    self.OptionsContainer.ClipsDescendants = true
    self.OptionsContainer.Visible = false
    self.OptionsContainer.ZIndex = 10
    self.OptionsContainer.Parent = self.Container
    
    -- Options corner
    local optionsCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    optionsCorner.Parent = self.OptionsContainer
    
    -- Options stroke
    local optionsStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    optionsStroke.Parent = self.OptionsContainer
    
    -- Options layout
    self.OptionsLayout = Instance.new("UIListLayout")
    self.OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.OptionsLayout.FillDirection = Enum.FillDirection.Vertical
    self.OptionsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    self.OptionsLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    self.OptionsLayout.Padding = UDim.new(0, 0)
    self.OptionsLayout.Parent = self.OptionsContainer
    
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
    
    -- Create option buttons
    self:CreateOptions()
    
    -- Dropdown events
    self.DropdownButton.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:Toggle()
        end
    end)
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
end

function Dropdown:CreateOptions()
    -- Clear existing options
    for _, button in pairs(self.OptionButtons) do
        button:Destroy()
    end
    self.OptionButtons = {}
    
    -- Create option buttons
    for i, option in ipairs(self.Options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option" .. i
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.BackgroundColor3 = self.Theme:GetColor("Surface")
        optionButton.BorderSizePixel = 0
        optionButton.Text = option
        optionButton.TextColor3 = self.Theme:GetColor("Text")
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.TextYAlignment = Enum.TextYAlignment.Center
        optionButton.Font = self.Theme:GetTextProperties("Body").Font
        optionButton.TextSize = self.Theme:GetTextProperties("Body").TextSize
        optionButton.AutoButtonColor = false
        optionButton.LayoutOrder = i
        optionButton.Parent = self.OptionsContainer
        
        -- Option padding
        local optionPadding = Utils.CreatePadding(10)
        optionPadding.Parent = optionButton
        
        -- Option click event
        optionButton.MouseButton1Click:Connect(function()
            self:SelectOption(option)
        end)
        
        -- Option hover effect
        Utils.SetupHoverEffect(optionButton, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
        
        -- Highlight selected option
        if (self.Multi and table.find(self.Value, option)) or (not self.Multi and self.Value == option) then
            optionButton.BackgroundColor3 = self.Theme:GetColor("Accent")
            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        
        table.insert(self.OptionButtons, optionButton)
    end
    
    -- Update options container size
    local optionsHeight = #self.Options * 30
    self.OptionsContainer.Size = UDim2.new(1, 0, 0, optionsHeight)
end

function Dropdown:SelectOption(option)
    if self.Multi then
        -- Multi-select mode
        if table.find(self.Value, option) then
            -- Remove option
            for i, v in ipairs(self.Value) do
                if v == option then
                    table.remove(self.Value, i)
                    break
                end
            end
        else
            -- Add option
            table.insert(self.Value, option)
        end
    else
        -- Single-select mode
        self.Value = option
        self:Toggle() -- Close dropdown
    end
    
    -- Update visual
    self:UpdateVisual()
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Dropdown:Toggle()
    self.Expanded = not self.Expanded
    
    -- Animate arrow rotation
    local arrowTween = Utils.CreateTween(self.Arrow, Utils.TweenInfo.Fast, {
        Rotation = self.Expanded and 180 or 0
    })
    arrowTween:Play()
    
    -- Show/hide options
    if self.Expanded then
        self.OptionsContainer.Visible = true
        self.OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
        
        local expandTween = Utils.CreateTween(self.OptionsContainer, Utils.TweenInfo.Medium, {
            Size = UDim2.new(1, 0, 0, #self.Options * 30)
        })
        expandTween:Play()
    else
        local collapseTween = Utils.CreateTween(self.OptionsContainer, Utils.TweenInfo.Medium, {
            Size = UDim2.new(1, 0, 0, 0)
        })
        collapseTween:Play()
        
        collapseTween.Completed:Connect(function()
            self.OptionsContainer.Visible = false
        end)
    end
end

function Dropdown:GetDisplayText()
    if self.Multi then
        if #self.Value == 0 then
            return "None selected"
        elseif #self.Value == 1 then
            return self.Value[1]
        else
            return #self.Value .. " selected"
        end
    else
        return self.Value or "None selected"
    end
end

function Dropdown:UpdateVisual()
    -- Update button text
    self.DropdownButton.Text = self:GetDisplayText()
    
    -- Update option buttons
    for i, button in ipairs(self.OptionButtons) do
        local option = self.Options[i]
        local isSelected = (self.Multi and table.find(self.Value, option)) or (not self.Multi and self.Value == option)
        
        if isSelected then
            button.BackgroundColor3 = self.Theme:GetColor("Accent")
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            button.BackgroundColor3 = self.Theme:GetColor("Surface")
            button.TextColor3 = self.Theme:GetColor("Text")
        end
    end
end

function Dropdown:SetValue(value)
    if self.Multi then
        self.Value = type(value) == "table" and value or {}
    else
        self.Value = value
    end
    
    self:UpdateVisual()
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Dropdown:SetOptions(options)
    self.Options = options
    self:CreateOptions()
    self:UpdateVisual()
end

function Dropdown:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.DropdownButton.TextTransparency = transparency
    self.Arrow.ImageTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
end

function Dropdown:GetValue()
    return self.Value
end

function Dropdown:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = theme:GetColor("Text")
    self.DropdownButton.TextColor3 = theme:GetColor("Text")
    self.Arrow.ImageColor3 = theme:GetColor("TextSecondary")
    self.OptionsContainer.BackgroundColor3 = theme:GetColor("Surface")
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
    
    -- Update option buttons
    for _, button in pairs(self.OptionButtons) do
        local option = button.Text
        local isSelected = (self.Multi and table.find(self.Value, option)) or (not self.Multi and self.Value == option)
        
        if isSelected then
            button.BackgroundColor3 = theme:GetColor("Accent")
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            button.BackgroundColor3 = theme:GetColor("Surface")
            button.TextColor3 = theme:GetColor("Text")
        end
    end
end

function Dropdown:Destroy()
    self.Container:Destroy()
end

return Dropdown
