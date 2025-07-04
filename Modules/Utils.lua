--[[
    Utility functions for the Modern UI Library
--]]

-- Mock services for demo purposes
local TweenService = {}
local UserInputService = {TouchEnabled = false}
local TextService = {}

-- Mock TweenInfo for compatibility
local TweenInfo = {
    new = function(duration, style, direction, repeatCount, reverses, delayTime)
        return {
            Duration = duration or 1,
            Style = style or "Quad",
            Direction = direction or "Out",
            RepeatCount = repeatCount or 0,
            Reverses = reverses or false,
            DelayTime = delayTime or 0
        }
    end
}

-- Mock Enum for compatibility
local Enum = {
    EasingStyle = {
        Quad = "Quad",
        Sine = "Sine",
        Cubic = "Cubic",
        Quart = "Quart",
        Quint = "Quint",
        Expo = "Expo",
        Circ = "Circ",
        Back = "Back",
        Elastic = "Elastic",
        Bounce = "Bounce"
    },
    EasingDirection = {
        In = "In",
        Out = "Out",
        InOut = "InOut"
    },
    Font = {
        Gotham = "Gotham",
        GothamBold = "GothamBold",
        GothamSemibold = "GothamSemibold"
    }
}

-- Mock Instance for compatibility
local Instance = {
    new = function(className)
        return {
            ClassName = className,
            Name = "",
            Parent = nil,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            Text = "",
            TextWrapped = false,
            Destroy = function() end
        }
    end
}

-- Mock Color3 for compatibility
local Color3 = {
    new = function(r, g, b)
        return {R = r, G = g, B = b}
    end,
    fromRGB = function(r, g, b)
        return {R = r/255, G = g/255, B = b/255}
    end
}

-- Mock Vector2 for compatibility
local Vector2 = {
    new = function(x, y)
        return {X = x, Y = y}
    end
}

local Utils = {}

-- Standard tween info presets
Utils.TweenInfo = {
    Fast = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Medium = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Bounce = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    Smooth = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
}

-- Tween creation helper
function Utils.CreateTween(object, tweenInfo, properties)
    return {
        target = object,
        tweenInfo = tweenInfo,
        properties = properties,
        Play = function() end,
        Pause = function() end,
        Cancel = function() end
    }
end

-- Text size calculation
function Utils.GetTextSize(text, font, textSize)
    -- Mock calculation for demo
    local charWidth = (textSize or 14) * 0.6
    local charHeight = (textSize or 14) * 1.2
    return Vector2.new(#text * charWidth, charHeight)
end

-- Color utilities
function Utils.Lerp(a, b, t)
    return a + (b - a) * t
end

function Utils.LerpColor3(color1, color2, t)
    return Color3.new(
        Utils.Lerp(color1.R, color2.R, t),
        Utils.Lerp(color1.G, color2.G, t),
        Utils.Lerp(color1.B, color2.B, t)
    )
end

function Utils.Color3FromRGB(r, g, b)
    return Color3.fromRGB(r, g, b)
end

function Utils.Color3FromHex(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16) or 0
    local g = tonumber(hex:sub(3, 4), 16) or 0
    local b = tonumber(hex:sub(5, 6), 16) or 0
    return Color3.fromRGB(r, g, b)
end

function Utils.Color3ToHex(color)
    local r = math.floor(color.R * 255)
    local g = math.floor(color.G * 255)
    local b = math.floor(color.B * 255)
    return string.format("#%02x%02x%02x", r, g, b)
end

-- Platform detection
function Utils.GetPlatformType()
    return UserInputService.TouchEnabled and "Mobile" or "Desktop"
end

-- Math utilities
function Utils.Clamp(value, min, max)
    return math.min(math.max(value, min), max)
end

function Utils.Round(num, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

function Utils.MapRange(value, fromMin, fromMax, toMin, toMax)
    return (value - fromMin) / (fromMax - fromMin) * (toMax - toMin) + toMin
end

-- Table utilities
function Utils.DeepCopy(original)
    local copy = {}
    for k, v in pairs(original) do
        if type(v) == "table" then
            copy[k] = Utils.DeepCopy(v)
        else
            copy[k] = v
        end
    end
    return copy
end

function Utils.Merge(table1, table2)
    local result = Utils.DeepCopy(table1)
    for k, v in pairs(table2) do
        result[k] = v
    end
    return result
end

-- String utilities
function Utils.ToString(value)
    if type(value) == "string" then
        return value
    elseif type(value) == "number" then
        return tostring(value)
    elseif type(value) == "boolean" then
        return value and "true" or "false"
    else
        return tostring(value)
    end
end

function Utils.Split(str, delimiter)
    local result = {}
    for part in str:gmatch("[^" .. delimiter .. "]+") do
        table.insert(result, part)
    end
    return result
end

function Utils.Trim(str)
    return str:match("^%s*(.-)%s*$")
end

-- Number formatting
function Utils.FormatNumber(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(num)
    end
end

-- Time utilities
function Utils.GetTimestamp()
    return os.time()
end

function Utils.FormatTime(seconds)
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    
    if hours > 0 then
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    else
        return string.format("%02d:%02d", minutes, secs)
    end
end

-- Unique ID generation
function Utils.CreateUniqueId()
    return tostring(math.random(100000, 999999)) .. "_" .. tostring(os.time())
end

-- Animation easing functions
function Utils.EaseInOut(t)
    return t < 0.5 and 2 * t * t or -1 + (4 - 2 * t) * t
end

function Utils.EaseIn(t)
    return t * t
end

function Utils.EaseOut(t)
    return 1 - (1 - t) ^ 2
end

function Utils.EaseBounce(t)
    if t < 1/2.75 then
        return 7.5625 * t * t
    elseif t < 2/2.75 then
        t = t - 1.5/2.75
        return 7.5625 * t * t + 0.75
    elseif t < 2.5/2.75 then
        t = t - 2.25/2.75
        return 7.5625 * t * t + 0.9375
    else
        t = t - 2.625/2.75
        return 7.5625 * t * t + 0.984375
    end
end

-- Validation utilities
function Utils.IsValidEmail(email)
    return email:match("^[^@]+@[^@]+%.[^@]+$") ~= nil
end

function Utils.IsValidUrl(url)
    return url:match("^https?://[^%s]+$") ~= nil
end

function Utils.IsValidHex(hex)
    return hex:match("^#?[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$") ~= nil
end

-- HSV color conversion
function Utils.RGBToHSV(r, g, b)
    r, g, b = r / 255, g / 255, b / 255
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h, s, v = 0, 0, max
    
    local d = max - min
    s = max == 0 and 0 or d / max
    
    if max == min then
        h = 0
    elseif max == r then
        h = (g - b) / d + (g < b and 6 or 0)
    elseif max == g then
        h = (b - r) / d + 2
    elseif max == b then
        h = (r - g) / d + 4
    end
    
    h = h / 6
    return h, s, v
end

function Utils.HSVToRGB(h, s, v)
    local r, g, b = 0, 0, 0
    
    local i = math.floor(h * 6)
    local f = h * 6 - i
    local p = v * (1 - s)
    local q = v * (1 - f * s)
    local t = v * (1 - (1 - f) * s)
    
    local imod = i % 6
    if imod == 0 then
        r, g, b = v, t, p
    elseif imod == 1 then
        r, g, b = q, v, p
    elseif imod == 2 then
        r, g, b = p, v, t
    elseif imod == 3 then
        r, g, b = p, q, v
    elseif imod == 4 then
        r, g, b = t, p, v
    elseif imod == 5 then
        r, g, b = v, p, q
    end
    
    return math.floor(r * 255), math.floor(g * 255), math.floor(b * 255)
end

-- Device detection
function Utils.IsMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

function Utils.IsTablet()
    return UserInputService.TouchEnabled and UserInputService.KeyboardEnabled
end

function Utils.IsDesktop()
    return not UserInputService.TouchEnabled
end

-- Function utilities
function Utils.Debounce(func, delay)
    local timer = nil
    return function(...)
        local args = {...}
        if timer then
            -- Cancel previous timer
            timer = nil
        end
        timer = coroutine.create(function()
            -- In Roblox, use wait(delay)
            func(unpack(args))
        end)
        coroutine.resume(timer)
    end
end

function Utils.Throttle(func, delay)
    local lastCall = 0
    return function(...)
        local now = Utils.GetTimestamp()
        if now - lastCall >= delay then
            lastCall = now
            return func(...)
        end
    end
end

-- Array utilities
function Utils.Find(array, predicate)
    for i, v in ipairs(array) do
        if predicate(v, i) then
            return v, i
        end
    end
    return nil
end

function Utils.Filter(array, predicate)
    local result = {}
    for i, v in ipairs(array) do
        if predicate(v, i) then
            table.insert(result, v)
        end
    end
    return result
end

function Utils.Map(array, transform)
    local result = {}
    for i, v in ipairs(array) do
        result[i] = transform(v, i)
    end
    return result
end

return Utils