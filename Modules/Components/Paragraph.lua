--[[
    Paragraph component for the Modern UI Library
--]]

local Utils = require("Modules.Utils")

local Paragraph = {}
Paragraph.__index = Paragraph

function Paragraph:new(parent, options, theme)
    local self = setmetatable({}, Paragraph)
    
    -- Options
    local opts = options or {}
    self.Title = opts.Title or "Paragraph"
    self.Content = opts.Content or "This is a paragraph of text."
    self.TitleSize = opts.TitleSize or 16
    self.ContentSize = opts.ContentSize or 14
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    
    -- Create paragraph
    self:CreateParagraph()
    
    return self
end

function Paragraph:CreateParagraph()
    -- Calculate text heights
    local titleHeight = self.TitleSize + 5
    local contentLines = self:CalculateTextLines(self.Content, self.ContentSize)
    local contentHeight = contentLines * (self.ContentSize + 2)
    local totalHeight = titleHeight + contentHeight + 20
    
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "ParagraphContainer"
    self.Container.Size = UDim2.new(1, 0, 0, totalHeight)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "ParagraphTitle"
    self.TitleLabel.Size = UDim2.new(1, -30, 0, titleHeight)
    self.TitleLabel.Position = UDim2.new(0, 15, 0, 10)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Top
    self.TitleLabel.Font = self.Theme:GetTextProperties("Subtitle").Font
    self.TitleLabel.TextSize = self.TitleSize
    self.TitleLabel.TextWrapped = true
    self.TitleLabel.Parent = self.Container
    
    -- Content label
    self.ContentLabel = Instance.new("TextLabel")
    self.ContentLabel.Name = "ParagraphContent"
    self.ContentLabel.Size = UDim2.new(1, -30, 0, contentHeight)
    self.ContentLabel.Position = UDim2.new(0, 15, 0, titleHeight + 15)
    self.ContentLabel.BackgroundTransparency = 1
    self.ContentLabel.Text = self.Content
    self.ContentLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    self.ContentLabel.Font = self.Theme:GetTextProperties("Body").Font
    self.ContentLabel.TextSize = self.ContentSize
    self.ContentLabel.TextWrapped = true
    self.ContentLabel.Parent = self.Container
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
end

function Paragraph:CalculateTextLines(text, textSize)
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

function Paragraph:SetTitle(title)
    self.Title = title
    self.TitleLabel.Text = title
    self:UpdateSize()
end

function Paragraph:SetContent(content)
    self.Content = content
    self.ContentLabel.Text = content
    self:UpdateSize()
end

function Paragraph:UpdateSize()
    local titleHeight = self.TitleSize + 5
    local contentLines = self:CalculateTextLines(self.Content, self.ContentSize)
    local contentHeight = contentLines * (self.ContentSize + 2)
    local totalHeight = titleHeight + contentHeight + 20
    
    -- Update container size
    self.Container.Size = UDim2.new(1, 0, 0, totalHeight)
    
    -- Update content label size and position
    self.ContentLabel.Size = UDim2.new(1, -30, 0, contentHeight)
    self.ContentLabel.Position = UDim2.new(0, 15, 0, titleHeight + 15)
end

function Paragraph:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    self.ContentLabel.TextColor3 = theme:GetColor("TextSecondary")
end

function Paragraph:Destroy()
    self.Container:Destroy()
end

return Paragraph
