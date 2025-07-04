--[[
    Label component for the Modern UI Library
--]]

local Utils = require("Modules.Utils")

local Label = {}
Label.__index = Label

function Label:new(parent, options, theme)
    local self = setmetatable({}, Label)
    
    -- Options
    local opts = options or {}
    self.Text = opts.Text or "Label"
    self.TextSize = opts.TextSize or 14
    self.TextColor = opts.TextColor or nil
    self.Font = opts.Font or nil
    self.RichText = opts.RichText or false
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    
    -- Create label
    self:CreateLabel()
    
    return self
end

function Label:CreateLabel()
    -- Calculate text height
    local textLines = self:CalculateTextLines(self.Text, self.TextSize)
    local textHeight = textLines * (self.TextSize + 2) + 20
    
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "LabelContainer"
    self.Container.Size = UDim2.new(1, 0, 0, textHeight)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Label text
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "Label"
    self.Label.Size = UDim2.new(1, -30, 1, -20)
    self.Label.Position = UDim2.new(0, 15, 0, 10)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Text
    self.Label.TextColor3 = self.TextColor or self.Theme:GetColor("Text")
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextYAlignment = Enum.TextYAlignment.Top
    self.Label.Font = self.Font or self.Theme:GetTextProperties("Body").Font
    self.Label.TextSize = self.TextSize
    self.Label.TextWrapped = true
    self.Label.RichText = self.RichText
    self.Label.Parent = self.Container
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
end

function Label:CalculateTextLines(text, textSize)
    -- Estimate number of lines based on text length and container width
    local containerWidth = 520 -- Approximate width minus padding
    local avgCharWidth = textSize * 0.6 -- Approximate character width
    local charsPerLine = math.floor(containerWidth / avgCharWidth)
    local lines = math.ceil(#text / charsPerLine)
    
    -- Account for manual line breaks
    local _, newlineCount = string.gsub(text, "\n", "")
    lines = lines + newlineCount
    
    return math.max(1, lines)
end

function Label:SetText(text)
    self.Text = text
    self.Label.Text = text
    self:UpdateSize()
end

function Label:SetTextColor(color)
    self.TextColor = color
    self.Label.TextColor3 = color
end

function Label:SetTextSize(size)
    self.TextSize = size
    self.Label.TextSize = size
    self:UpdateSize()
end

function Label:SetFont(font)
    self.Font = font
    self.Label.Font = font
end

function Label:SetRichText(enabled)
    self.RichText = enabled
    self.Label.RichText = enabled
end

function Label:UpdateSize()
    local textLines = self:CalculateTextLines(self.Text, self.TextSize)
    local textHeight = textLines * (self.TextSize + 2) + 20
    
    -- Update container size
    self.Container.Size = UDim2.new(1, 0, 0, textHeight)
    
    -- Update label size
    self.Label.Size = UDim2.new(1, -30, 1, -20)
end

function Label:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    
    if not self.TextColor then
        self.Label.TextColor3 = theme:GetColor("Text")
    end
end

function Label:Destroy()
    self.Container:Destroy()
end

return Label
