--[[
    Tab component for the Modern UI Library
--]]

local Utils = require("Modules.Utils")

-- Load components with proper require statements for local environment
local Toggle = require("Modules.Components.Toggle")
local Slider = require("Modules.Components.Slider")
local Button = require("Modules.Components.Button")
local Input = require("Modules.Components.Input")
local Dropdown = require("Modules.Components.Dropdown")
local ColorPicker = require("Modules.Components.ColorPicker")
local Keybind = require("Modules.Components.Keybind")
local Paragraph = require("Modules.Components.Paragraph")
local Label = require("Modules.Components.Label")
local Divider = require("Modules.Components.Divider")

local Tab = {}
Tab.__index = Tab

function Tab:new(window, options, theme)
    local self = setmetatable({}, Tab)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Tab"
    self.Icon = opts.Icon or nil
    self.Visible = opts.Visible ~= false
    
    -- Properties
    self.Window = window
    self.Theme = theme
    self.Components = {}
    self.Active = false
    
    -- Create tab
    self:CreateTab()
    self:CreateContent()
    
    return self
end

function Tab:CreateTab()
    -- Tab button
    self.TabButton = Instance.new("TextButton")
    self.TabButton.Name = "TabButton"
    self.TabButton.Size = UDim2.new(0, 0, 1, 0)
    self.TabButton.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.TabButton.BorderSizePixel = 0
    self.TabButton.Text = self.Name
    self.TabButton.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.TabButton.Font = self.Theme:GetTextProperties("Button").Font
    self.TabButton.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.TabButton.AutoButtonColor = false
    self.TabButton.Parent = self.Window.TabContainer
    
    -- Auto-size the tab button
    local textSize = Utils.GetTextSize(self.Name, self.TabButton.Font, self.TabButton.TextSize)
    self.TabButton.Size = UDim2.new(0, textSize.X + 30, 1, 0)
    
    -- Tab corner
    local tabCorner = Utils.CreateCorner(6)
    tabCorner.Parent = self.TabButton
    
    -- Tab click event
    self.TabButton.MouseButton1Click:Connect(function()
        self.Window:SetCurrentTab(self)
    end)
    
    -- Hover effect
    Utils.SetupHoverEffect(self.TabButton, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
end

function Tab:CreateContent()
    -- Content frame
    self.ContentFrame = Instance.new("ScrollingFrame")
    self.ContentFrame.Name = "TabContent"
    self.ContentFrame.Size = UDim2.new(1, 0, 1, 0)
    self.ContentFrame.Position = UDim2.new(0, 0, 0, 0)
    self.ContentFrame.BackgroundTransparency = 1
    self.ContentFrame.BorderSizePixel = 0
    self.ContentFrame.ScrollBarThickness = 6
    self.ContentFrame.ScrollBarImageColor3 = self.Theme:GetColor("Border")
    self.ContentFrame.ScrollBarImageTransparency = 0.5
    self.ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.ContentFrame.Visible = false
    self.ContentFrame.Parent = self.Window.ContentArea
    
    -- Content layout
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContentLayout.FillDirection = Enum.FillDirection.Vertical
    self.ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    self.ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Top
    self.ContentLayout.Padding = UDim.new(0, self.Theme.Spacing)
    self.ContentLayout.Parent = self.ContentFrame
    
    -- Content padding
    local contentPadding = Utils.CreatePadding(self.Theme.Padding)
    contentPadding.Parent = self.ContentFrame
end

function Tab:SetVisible(visible)
    self.Visible = visible
    self.ContentFrame.Visible = visible
    
    -- Update tab button appearance
    if visible then
        self.TabButton.BackgroundColor3 = self.Theme:GetColor("Accent")
        self.TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.Active = true
    else
        self.TabButton.BackgroundColor3 = self.Theme:GetColor("Surface")
        self.TabButton.TextColor3 = self.Theme:GetColor("TextSecondary")
        self.Active = false
    end
end

-- Component creation methods
function Tab:CreateToggle(options)
    local toggle = Toggle:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, toggle)
    return toggle
end

function Tab:CreateSlider(options)
    local slider = Slider:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, slider)
    return slider
end

function Tab:CreateButton(options)
    local button = Button:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, button)
    return button
end

function Tab:CreateInput(options)
    local input = Input:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, input)
    return input
end

function Tab:CreateDropdown(options)
    local dropdown = Dropdown:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, dropdown)
    return dropdown
end

function Tab:CreateColorPicker(options)
    local colorPicker = ColorPicker:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, colorPicker)
    return colorPicker
end

function Tab:CreateKeybind(options)
    local keybind = Keybind:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, keybind)
    return keybind
end

function Tab:CreateParagraph(options)
    local paragraph = Paragraph:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, paragraph)
    return paragraph
end

function Tab:CreateLabel(options)
    local label = Label:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, label)
    return label
end

function Tab:CreateDivider(options)
    local divider = Divider:new(self.ContentFrame, options, self.Theme)
    table.insert(self.Components, divider)
    return divider
end

function Tab:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update tab button
    if self.Active then
        self.TabButton.BackgroundColor3 = theme:GetColor("Accent")
    else
        self.TabButton.BackgroundColor3 = theme:GetColor("Surface")
        self.TabButton.TextColor3 = theme:GetColor("TextSecondary")
    end
    
    -- Update content frame
    self.ContentFrame.ScrollBarImageColor3 = theme:GetColor("Border")
    
    -- Update all components
    for _, component in pairs(self.Components) do
        if component.UpdateTheme then
            component:UpdateTheme(theme)
        end
    end
end

function Tab:Destroy()
    for _, component in pairs(self.Components) do
        if component.Destroy then
            component:Destroy()
        end
    end
    
    self.TabButton:Destroy()
    self.ContentFrame:Destroy()
end

return Tab
