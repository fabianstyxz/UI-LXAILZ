--[[
    Divider component for the Modern UI Library
--]]

local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local Divider = {}
Divider.__index = Divider

function Divider:new(parent, options, theme)
    local self = setmetatable({}, Divider)
    
    -- Options
    local opts = options or {}
    self.Text = opts.Text or nil
    self.Thickness = opts.Thickness or 1
    self.Color = opts.Color or nil
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    
    -- Create divider
    self:CreateDivider()
    
    return self
end

function Divider:CreateDivider()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "DividerContainer"
    self.Container.Size = UDim2.new(1, 0, 0, self.Text and 35 or 15)
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    if self.Text then
        -- Divider with text
        self:CreateTextDivider()
    else
        -- Simple line divider
        self:CreateLineDivider()
    end
end

function Divider:CreateLineDivider()
    -- Divider line
    self.DividerLine = Instance.new("Frame")
    self.DividerLine.Name = "DividerLine"
    self.DividerLine.Size = UDim2.new(1, -30, 0, self.Thickness)
    self.DividerLine.Position = UDim2.new(0, 15, 0.5, -self.Thickness/2)
    self.DividerLine.BackgroundColor3 = self.Color or self.Theme:GetColor("Border")
    self.DividerLine.BorderSizePixel = 0
    self.DividerLine.Parent = self.Container
    
    -- Line corner (for rounded edges if thickness > 1)
    if self.Thickness > 1 then
        local lineCorner = Utils.CreateCorner(self.Thickness/2)
        lineCorner.Parent = self.DividerLine
    end
end

function Divider:CreateTextDivider()
    -- Text label
    self.TextLabel = Instance.new("TextLabel")
    self.TextLabel.Name = "DividerText"
    self.TextLabel.Size = UDim2.new(0, 0, 1, 0)
    self.TextLabel.Position = UDim2.new(0.5, 0, 0, 0)
    self.TextLabel.AnchorPoint = Vector2.new(0.5, 0)
    self.TextLabel.BackgroundColor3 = self.Theme:GetColor("Background")
    self.TextLabel.BorderSizePixel = 0
    self.TextLabel.Text = "  " .. self.Text .. "  "
    self.TextLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TextLabel.Font = self.Theme:GetTextProperties("Caption").Font
    self.TextLabel.TextSize = self.Theme:GetTextProperties("Caption").TextSize
    self.TextLabel.Parent = self.Container
    
    -- Auto-size text label
    local textSize = Utils.GetTextSize(self.TextLabel.Text, self.TextLabel.Font, self.TextLabel.TextSize)
    self.TextLabel.Size = UDim2.new(0, textSize.X + 10, 1, 0)
    
    -- Left divider line
    self.LeftLine = Instance.new("Frame")
    self.LeftLine.Name = "LeftLine"
    self.LeftLine.Size = UDim2.new(0.5, -(textSize.X/2 + 5), 0, self.Thickness)
    self.LeftLine.Position = UDim2.new(0, 15, 0.5, -self.Thickness/2)
    self.LeftLine.BackgroundColor3 = self.Color or self.Theme:GetColor("Border")
    self.LeftLine.BorderSizePixel = 0
    self.LeftLine.Parent = self.Container
    
    -- Right divider line
    self.RightLine = Instance.new("Frame")
    self.RightLine.Name = "RightLine"
    self.RightLine.Size = UDim2.new(0.5, -(textSize.X/2 + 5), 0, self.Thickness)
    self.RightLine.Position = UDim2.new(0.5, textSize.X/2 + 5, 0.5, -self.Thickness/2)
    self.RightLine.BackgroundColor3 = self.Color or self.Theme:GetColor("Border")
    self.RightLine.BorderSizePixel = 0
    self.RightLine.Parent = self.Container
    
    -- Line corners (for rounded edges if thickness > 1)
    if self.Thickness > 1 then
        local leftCorner = Utils.CreateCorner(self.Thickness/2)
        leftCorner.Parent = self.LeftLine
        
        local rightCorner = Utils.CreateCorner(self.Thickness/2)
        rightCorner.Parent = self.RightLine
    end
end

function Divider:SetText(text)
    self.Text = text
    
    if text then
        if not self.TextLabel then
            -- Convert to text divider
            self.Container:ClearAllChildren()
            self:CreateTextDivider()
        else
            -- Update existing text
            self.TextLabel.Text = "  " .. text .. "  "
            
            -- Update text size and line positions
            local textSize = Utils.GetTextSize(self.TextLabel.Text, self.TextLabel.Font, self.TextLabel.TextSize)
            self.TextLabel.Size = UDim2.new(0, textSize.X + 10, 1, 0)
            
            self.LeftLine.Size = UDim2.new(0.5, -(textSize.X/2 + 5), 0, self.Thickness)
            self.RightLine.Size = UDim2.new(0.5, -(textSize.X/2 + 5), 0, self.Thickness)
            self.RightLine.Position = UDim2.new(0.5, textSize.X/2 + 5, 0.5, -self.Thickness/2)
        end
    else
        -- Convert to line divider
        self.Container:ClearAllChildren()
        self:CreateLineDivider()
    end
    
    -- Update container size
    self.Container.Size = UDim2.new(1, 0, 0, text and 35 or 15)
end

function Divider:SetThickness(thickness)
    self.Thickness = thickness
    
    if self.Text then
        self.LeftLine.Size = UDim2.new(self.LeftLine.Size.X.Scale, self.LeftLine.Size.X.Offset, 0, thickness)
        self.LeftLine.Position = UDim2.new(self.LeftLine.Position.X.Scale, self.LeftLine.Position.X.Offset, 0.5, -thickness/2)
        
        self.RightLine.Size = UDim2.new(self.RightLine.Size.X.Scale, self.RightLine.Size.X.Offset, 0, thickness)
        self.RightLine.Position = UDim2.new(self.RightLine.Position.X.Scale, self.RightLine.Position.X.Offset, 0.5, -thickness/2)
    else
        self.DividerLine.Size = UDim2.new(1, -30, 0, thickness)
        self.DividerLine.Position = UDim2.new(0, 15, 0.5, -thickness/2)
    end
end

function Divider:SetColor(color)
    self.Color = color
    
    if self.Text then
        self.LeftLine.BackgroundColor3 = color
        self.RightLine.BackgroundColor3 = color
    else
        self.DividerLine.BackgroundColor3 = color
    end
end

function Divider:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    if not self.Color then
        if self.Text then
            self.LeftLine.BackgroundColor3 = theme:GetColor("Border")
            self.RightLine.BackgroundColor3 = theme:GetColor("Border")
            self.TextLabel.BackgroundColor3 = theme:GetColor("Background")
            self.TextLabel.TextColor3 = theme:GetColor("TextSecondary")
        else
            self.DividerLine.BackgroundColor3 = theme:GetColor("Border")
        end
    end
end

function Divider:Destroy()
    self.Container:Destroy()
end

return Divider
