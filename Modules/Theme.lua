--[[
    Theme system for the Modern UI Library
--]]

-- Mock Color3 for compatibility
local Color3 = {
    fromRGB = function(r, g, b)
        return {R = r/255, G = g/255, B = b/255}
    end
}

local Theme = {}
Theme.__index = Theme

-- Default theme colors
local Themes = {
    Dark = {
        Primary = Color3.fromRGB(25, 25, 25),
        Secondary = Color3.fromRGB(35, 35, 35),
        Accent = Color3.fromRGB(0, 162, 255),
        AccentHover = Color3.fromRGB(0, 142, 230),
        Background = Color3.fromRGB(20, 20, 20),
        Surface = Color3.fromRGB(30, 30, 30),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(200, 200, 200),
        TextDisabled = Color3.fromRGB(120, 120, 120),
        Border = Color3.fromRGB(60, 60, 60),
        BorderHover = Color3.fromRGB(80, 80, 80),
        Success = Color3.fromRGB(0, 200, 83),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(244, 67, 54),
        Info = Color3.fromRGB(33, 150, 243)
    },
    Light = {
        Primary = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(245, 245, 245),
        Accent = Color3.fromRGB(0, 122, 255),
        AccentHover = Color3.fromRGB(0, 100, 220),
        Background = Color3.fromRGB(250, 250, 250),
        Surface = Color3.fromRGB(255, 255, 255),
        Text = Color3.fromRGB(0, 0, 0),
        TextSecondary = Color3.fromRGB(60, 60, 60),
        TextDisabled = Color3.fromRGB(120, 120, 120),
        Border = Color3.fromRGB(220, 220, 220),
        BorderHover = Color3.fromRGB(180, 180, 180),
        Success = Color3.fromRGB(0, 200, 83),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(244, 67, 54),
        Info = Color3.fromRGB(33, 150, 243)
    },
    Neon = {
        Primary = Color3.fromRGB(15, 15, 25),
        Secondary = Color3.fromRGB(25, 25, 35),
        Accent = Color3.fromRGB(0, 255, 127),
        AccentHover = Color3.fromRGB(0, 230, 115),
        Background = Color3.fromRGB(10, 10, 20),
        Surface = Color3.fromRGB(20, 20, 30),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(200, 200, 200),
        TextDisabled = Color3.fromRGB(120, 120, 120),
        Border = Color3.fromRGB(0, 255, 127),
        BorderHover = Color3.fromRGB(0, 230, 115),
        Success = Color3.fromRGB(0, 255, 127),
        Warning = Color3.fromRGB(255, 193, 7),
        Error = Color3.fromRGB(255, 0, 127),
        Info = Color3.fromRGB(127, 0, 255)
    }
}

function Theme:new(themeName)
    local self = setmetatable({}, Theme)
    
    self.CurrentTheme = themeName or "Dark"
    self.Colors = Themes[self.CurrentTheme]
    self.Font = Enum.Font.Gotham
    self.TextSize = 14
    self.CornerRadius = 8
    self.Padding = 12
    self.Spacing = 8
    
    return self
end

function Theme:SetTheme(themeName)
    if Themes[themeName] then
        self.CurrentTheme = themeName
        self.Colors = Themes[themeName]
        return true
    end
    return false
end

function Theme:GetColor(colorName)
    return self.Colors[colorName] or self.Colors.Primary
end

function Theme:CreateCustomTheme(name, colors)
    Themes[name] = colors
end

function Theme:GetAvailableThemes()
    local themes = {}
    for name, _ in pairs(Themes) do
        table.insert(themes, name)
    end
    return themes
end

-- Animation settings
function Theme:GetAnimationSpeed()
    return 0.25
end

function Theme:GetAnimationEasing()
    return Enum.EasingStyle.Quad
end

function Theme:GetAnimationDirection()
    return Enum.EasingDirection.Out
end

-- Typography settings
function Theme:GetTextProperties(variant)
    local variants = {
        Title = {
            Font = Enum.Font.GothamBold,
            TextSize = 18
        },
        Subtitle = {
            Font = Enum.Font.GothamMedium,
            TextSize = 16
        },
        Body = {
            Font = Enum.Font.Gotham,
            TextSize = 14
        },
        Caption = {
            Font = Enum.Font.Gotham,
            TextSize = 12
        },
        Button = {
            Font = Enum.Font.GothamMedium,
            TextSize = 14
        }
    }
    
    return variants[variant] or variants.Body
end

-- Shadow settings
function Theme:GetShadowProperties()
    return {
        Color = Color3.fromRGB(0, 0, 0),
        Transparency = 0.5,
        Size = UDim2.new(1, 4, 1, 4),
        Position = UDim2.new(0, 2, 0, 2)
    }
end

return Theme
