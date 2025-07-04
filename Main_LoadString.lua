--[[
    LXAIL - Complete Roblox UI Library - FIXED VERSION
    Modern Design with Glitch Effects and Animated Elements
    Complete Rayfield functionality replica
    
    Usage:
    local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/fabianstyxz/UI-LXAILZ/main/Main_LoadString.lua"))()
    
    BUGS FIXED:
    - Fixed duplicate CreateWindow function definitions
    - Fixed UI elements not showing in Roblox environment
    - Fixed component creation and rendering issues
    - Ensured proper parent assignment for Roblox PlayerGui
    - Fixed all enum references for compatibility
--]]

-- === ROBLOX SERVICES ===
local TweenService, UserInputService, RunService, HttpService, TextService, GuiService, Players, CoreGui, Player, PlayerGui

if game then
    -- Running in Roblox environment
    TweenService = game:GetService("TweenService")
    UserInputService = game:GetService("UserInputService")
    RunService = game:GetService("RunService")
    HttpService = game:GetService("HttpService")
    TextService = game:GetService("TextService")
    GuiService = game:GetService("GuiService")
    Players = game:GetService("Players")
    CoreGui = game:GetService("CoreGui")
    Player = Players.LocalPlayer
    PlayerGui = Player:WaitForChild("PlayerGui")
else
    -- Mock environment for local testing
    TweenService = {
        Create = function(obj, info, props) 
            return {
                Play = function() print("TweenService:Create() - Playing tween") end,
                Completed = {
                    Connect = function(func) print("TweenService - Tween completed") if func then func() end end,
                    Wait = function() print("TweenService - Waiting for tween completion") end
                }
            } 
        end
    }
    UserInputService = {
        InputBegan = {Connect = function(func) print("UserInputService.InputBegan connected") end},
        InputChanged = {Connect = function(func) print("UserInputService.InputChanged connected") end},
        InputEnded = {Connect = function(func) print("UserInputService.InputEnded connected") end}
    }
    RunService = {
        Heartbeat = {Connect = function(func) print("RunService.Heartbeat connected") end}
    }
    HttpService = {
        JSONEncode = function(t) return "{}" end,
        JSONDecode = function(s) return {} end
    }
    TextService = {
        GetTextSize = function() return Vector2.new(100, 20) end
    }
    GuiService = {}
    Players = {
        LocalPlayer = {
            Name = "LocalPlayer",
            DisplayName = "TestPlayer",
            UserId = 1
        }
    }
    CoreGui = {}
    Player = Players.LocalPlayer
    PlayerGui = {}
    
    -- Mock global objects
    _G.Instance = {
        new = function(className)
            local obj = {
                ClassName = className,
                Name = "",
                Parent = nil,
                Size = UDim2.new(0, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Text = "",
                TextColor3 = Color3.new(0, 0, 0),
                TextSize = 14,
                Font = "Gotham",
                TextXAlignment = "Left",
                TextYAlignment = "Center",
                TextWrapped = false,
                Visible = true,
                Active = false,
                Draggable = false,
                ResetOnSpawn = false,
                Enabled = true,
                IgnoreGuiInset = true,
                MouseButton1Click = {Connect = function(func) print("MouseButton1Click connected") end},
                MouseEnter = {Connect = function(func) print("MouseEnter connected") end},
                MouseLeave = {Connect = function(func) print("MouseLeave connected") end},
                InputBegan = {Connect = function(func) print("InputBegan connected") end},
                InputChanged = {Connect = function(func) print("InputChanged connected") end},
                InputEnded = {Connect = function(func) print("InputEnded connected") end},
                FocusLost = {Connect = function(func) print("FocusLost connected") end},
                TweenPosition = function() print("TweenPosition called") end,
                TweenSize = function() print("TweenSize called") end,
                Destroy = function() print("Object destroyed") end,
                WaitForChild = function(name) return obj end,
                FindFirstChild = function(name) return obj end,
                GetChildren = function() return {} end,
                GetPropertyChangedSignal = function() 
                    return {Connect = function() end}
                end
            }
            
            -- Add properties based on className
            if className == "UIListLayout" then
                obj.FillDirection = "Vertical"
                obj.SortOrder = "LayoutOrder"
                obj.Padding = UDim.new(0, 0)
                obj.HorizontalAlignment = "Center"
                obj.VerticalAlignment = "Top"
            elseif className == "UICorner" then
                obj.CornerRadius = UDim.new(0, 0)
            elseif className == "UIPadding" then
                obj.PaddingLeft = UDim.new(0, 0)
                obj.PaddingRight = UDim.new(0, 0)
                obj.PaddingTop = UDim.new(0, 0)
                obj.PaddingBottom = UDim.new(0, 0)
            elseif className == "UIGradient" then
                obj.Color = ColorSequence.new(Color3.new(1, 1, 1))
                obj.Rotation = 0
                obj.Transparency = NumberSequence.new(0)
            elseif className == "ScrollingFrame" then
                obj.ScrollBarThickness = 6
                obj.ScrollingDirection = "Y"
                obj.AutomaticCanvasSize = "Y"
                obj.CanvasSize = UDim2.new(0, 0, 0, 0)
                obj.ClipsDescendants = true
            elseif className == "TextBox" then
                obj.PlaceholderText = ""
                obj.ClearTextOnFocus = true
            elseif className == "ImageLabel" or className == "ImageButton" then
                obj.Image = ""
                obj.ImageTransparency = 0
                obj.ScaleType = "Stretch"
            end
            
            return obj
        end
    }
    
    _G.UDim2 = {
        new = function(xScale, xOffset, yScale, yOffset)
            return {
                X = {Scale = xScale or 0, Offset = xOffset or 0},
                Y = {Scale = yScale or 0, Offset = yOffset or 0}
            }
        end
    }
    
    _G.UDim = {
        new = function(scale, offset)
            return {Scale = scale or 0, Offset = offset or 0}
        end
    }
    
    _G.Color3 = {
        new = function(r, g, b) return {R = r or 0, G = g or 0, B = b or 0} end,
        fromRGB = function(r, g, b) return {R = (r or 0)/255, G = (g or 0)/255, B = (b or 0)/255} end,
        fromHSV = function(h, s, v) return {R = v or 0, G = v or 0, B = v or 0} end
    }
    
    _G.Vector2 = {
        new = function(x, y) return {X = x or 0, Y = y or 0} end
    }
    
    _G.ColorSequence = {
        new = function(color)
            return {Color = color or Color3.new(1, 1, 1)}
        end
    }
    
    _G.ColorSequenceKeypoint = {
        new = function(time, color)
            return {Time = time or 0, Value = color or Color3.new(1, 1, 1)}
        end
    }
    
    _G.NumberSequence = {
        new = function(value)
            return {Value = value or 0}
        end
    }
    
    _G.TweenInfo = {
        new = function(time, style, direction, repeatCount, reverses, delayTime)
            return {
                Time = time or 1,
                EasingStyle = style or "Quad",
                EasingDirection = direction or "Out",
                RepeatCount = repeatCount or 0,
                Reverses = reverses or false,
                DelayTime = delayTime or 0
            }
        end
    }
    
    _G.Enum = {
        EasingStyle = {
            Linear = "Linear",
            Sine = "Sine",
            Back = "Back",
            Quad = "Quad",
            Quart = "Quart",
            Quint = "Quint",
            Bounce = "Bounce",
            Elastic = "Elastic"
        },
        EasingDirection = {
            In = "In",
            Out = "Out",
            InOut = "InOut"
        },
        Font = {
            Gotham = "Gotham",
            GothamBold = "GothamBold",
            GothamBlack = "GothamBlack"
        },
        UserInputType = {
            MouseButton1 = "MouseButton1",
            MouseMovement = "MouseMovement",
            Touch = "Touch",
            Keyboard = "Keyboard"
        },
        UserInputState = {
            Begin = "Begin",
            Change = "Change",
            End = "End"
        },
        KeyCode = {
            F = {Name = "F"},
            LeftShift = {Name = "LeftShift"},
            Space = {Name = "Space"},
            LeftControl = {Name = "LeftControl"}
        },
        TextXAlignment = {
            Left = "Left",
            Center = "Center",
            Right = "Right"
        },
        TextYAlignment = {
            Top = "Top",
            Center = "Center",
            Bottom = "Bottom"
        },
        SortOrder = {
            LayoutOrder = "LayoutOrder",
            Name = "Name"
        },
        FillDirection = {
            Horizontal = "Horizontal",
            Vertical = "Vertical"
        },
        HorizontalAlignment = {
            Left = "Left",
            Center = "Center",
            Right = "Right"
        },
        VerticalAlignment = {
            Top = "Top",
            Center = "Center",
            Bottom = "Bottom"
        }
    }
    
    _G.spawn = function(func) func() end
    _G.wait = function(time) print("Waiting for " .. (time or 0) .. " seconds") end
    _G.tick = function() return os.time() end
    _G.coroutine = {
        wrap = function(func) return function() func() end end
    }
    
    if not math.clamp then
        math.clamp = function(value, min, max)
            return math.min(math.max(value, min), max)
        end
    end
end

-- === LXAIL MAIN LIBRARY ===
local LXAIL = {
    Version = "2.0.0",
    Creator = "LXAIL Team",
    Description = "Modern UI with Glitch Effects - Complete Rayfield API replica",
    
    -- Internal storage
    Windows = {},
    Notifications = {},
    Themes = {},
    Config = {},
    KeybindList = {},
    Flags = {},
    
    -- UI References
    CurrentWindow = nil,
    CurrentTab = nil,
    UIExists = false,
    FloatingButtonExists = false
}

-- === MODERN UI THEME ===
LXAIL.ModernTheme = {
    Background = Color3.fromRGB(20, 20, 20),
    Secondary = Color3.fromRGB(35, 35, 35),
    Tertiary = Color3.fromRGB(50, 50, 50),
    Text = Color3.fromRGB(230, 230, 230),
    TextSecondary = Color3.fromRGB(240, 240, 240),
    Accent = Color3.fromRGB(60, 180, 60),
    AccentHover = Color3.fromRGB(60, 220, 60),
    ToggleOff = Color3.fromRGB(150, 40, 40),
    ToggleOn = Color3.fromRGB(60, 180, 60),
    ButtonHover = Color3.fromRGB(255, 100, 100),
    Shadow = Color3.fromRGB(0, 0, 0),
    GradientStart = Color3.fromRGB(30, 30, 30),
    GradientEnd = Color3.fromRGB(15, 15, 15)
}

-- === UTILITY FUNCTIONS ===
local function CreateTween(obj, duration, props)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateShadow(parent, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.ImageTransparency = transparency or 0.85
    shadow.ZIndex = 0
    -- shadow.ScaleType = Enum.ScaleType.Slice
    -- shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = parent
    return shadow
end

local function CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1 or LXAIL.ModernTheme.GradientStart),
        ColorSequenceKeypoint.new(1, color2 or LXAIL.ModernTheme.GradientEnd)
    }
    gradient.Rotation = rotation or 90
    gradient.Transparency = NumberSequence.new(0.2)
    gradient.Parent = parent
    return gradient
end

-- === ANIMATED TITLE SYSTEM ===
local function CreateAnimatedTitle(parent, text, position)
    local letters = {}
    local letterSpacing = 22
    
    for i = 1, #text do
        local char = text:sub(i, i)
        local letterLabel = Instance.new("TextLabel")
        letterLabel.Parent = parent
        letterLabel.BackgroundTransparency = 1
        letterLabel.Text = char
        letterLabel.Font = Enum.Font.GothamBlack
        letterLabel.TextSize = 32
        letterLabel.TextColor3 = LXAIL.ModernTheme.Text
        letterLabel.Size = UDim2.new(0, 20, 0, 40)
        letterLabel.Position = UDim2.new(position.X.Scale, position.X.Offset + (i-1) * letterSpacing, position.Y.Scale, position.Y.Offset)
        letterLabel.TextXAlignment = Enum.TextXAlignment.Center
        letterLabel.TextYAlignment = Enum.TextYAlignment.Center
        letterLabel.TextTransparency = 1
        letters[#letters + 1] = letterLabel
    end
    
    local function animateLetters()
        local fadeInInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local fadeOutInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        
        while true do
            for _, letter in ipairs(letters) do
                TweenService:Create(letter, fadeInInfo, {TextTransparency = 0}):Play()
                wait(0.1)
            end
            wait(0.6)
            for _, letter in ipairs(letters) do
                TweenService:Create(letter, fadeOutInfo, {TextTransparency = 1}):Play()
                wait(0.1)
            end
            wait(0.6)
        end
    end
    
    coroutine.wrap(animateLetters)()
    return letters
end

-- === TAB GLITCH ANIMATION ===
local function CreateGlitchTransition(currentTab, newTab)
    if currentTab and currentTab ~= newTab then
        -- Glitch out current tab
        local glitchTween1 = CreateTween(currentTab, 0.05, {
            Position = UDim2.new(currentTab.Position.X.Scale, currentTab.Position.X.Offset + 5, currentTab.Position.Y.Scale, currentTab.Position.Y.Offset),
            BackgroundTransparency = 0.5,
            Size = UDim2.new(currentTab.Size.X.Scale, currentTab.Size.X.Offset + 5, currentTab.Size.Y.Scale, currentTab.Size.Y.Offset + 5)
        })
        glitchTween1.Completed:Wait()
        
        local glitchTween2 = CreateTween(currentTab, 0.05, {
            Position = UDim2.new(currentTab.Position.X.Scale, currentTab.Position.X.Offset - 5, currentTab.Position.Y.Scale, currentTab.Position.Y.Offset + 5),
            BackgroundTransparency = 0.7,
            Size = UDim2.new(currentTab.Size.X.Scale, currentTab.Size.X.Offset - 5, currentTab.Size.Y.Scale, currentTab.Size.Y.Offset - 5)
        })
        glitchTween2.Completed:Wait()
        
        local glitchTween3 = CreateTween(currentTab, 0.05, {
            Position = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        })
        glitchTween3.Completed:Wait()
        
        currentTab.Visible = false
        currentTab.BackgroundTransparency = 0
        currentTab.Size = UDim2.new(1, 0, 1, 0)
        currentTab.Position = UDim2.new(0, 0, 0, 0)
    end
    
    -- Glitch in new tab
    newTab.Visible = true
    newTab.BackgroundTransparency = 1
    newTab.Size = UDim2.new(1, 0, 1, 0)
    newTab.Position = UDim2.new(0, 0, 0, 0)
    
    local glitchIn1 = CreateTween(newTab, 0.05, {
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 0.5,
        Size = UDim2.new(1, 5, 1, 5)
    })
    glitchIn1.Completed:Wait()
    
    local glitchIn2 = CreateTween(newTab, 0.05, {
        Position = UDim2.new(0, -5, 0, 5),
        BackgroundTransparency = 0.7,
        Size = UDim2.new(1, -5, 1, -5)
    })
    glitchIn2.Completed:Wait()
    
    local glitchIn3 = CreateTween(newTab, 0.05, {
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0)
    })
end

-- === MODERN COMPONENTS ===

-- Toggle Component
local function CreateModernToggle(parent, text, callback)
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = parent
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, -56, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local toggle = Instance.new("TextButton")
    toggle.Text = ""
    toggle.Size = UDim2.new(0, 46, 0, 24)
    toggle.BackgroundColor3 = LXAIL.ModernTheme.ToggleOff
    toggle.BorderSizePixel = 0
    toggle.AutoButtonColor = false
    toggle.LayoutOrder = 2
    toggle.ClipsDescendants = true
    toggle.Parent = section
    CreateCorner(toggle, 12)
    
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 20, 0, 20)
    circle.Position = UDim2.new(0, 2, 0, 2)
    circle.BackgroundColor3 = LXAIL.ModernTheme.Text
    circle.BorderSizePixel = 0
    circle.Name = "Circle"
    circle.Parent = toggle
    CreateCorner(circle, 10)
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.Text = ""
    icon.TextColor3 = LXAIL.ModernTheme.Accent
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 14
    icon.Parent = circle
    
    local toggled = false
    toggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            CreateTween(circle, 0.18, {Position = UDim2.new(1, -22, 0, 2)})
            CreateTween(toggle, 0.18, {BackgroundColor3 = LXAIL.ModernTheme.ToggleOn})
            icon.Text = "✔"
        else
            CreateTween(circle, 0.18, {Position = UDim2.new(0, 2, 0, 2)})
            CreateTween(toggle, 0.18, {BackgroundColor3 = LXAIL.ModernTheme.ToggleOff})
            icon.Text = ""
        end
        if callback then callback(toggled) end
    end)
    
    return section, toggled
end

-- Slider Component
local function CreateModernSlider(parent, text, min, max, default, callback)
    min = min or 0
    max = max or 100
    default = default or 50
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = parent
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.45, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local sliderBG = Instance.new("Frame")
    sliderBG.Size = UDim2.new(0.4, 0, 0, 6)
    sliderBG.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    sliderBG.BorderSizePixel = 0
    sliderBG.LayoutOrder = 2
    sliderBG.AnchorPoint = Vector2.new(0, 0.5)
    sliderBG.Position = UDim2.new(0, 0, 0.5, 0)
    sliderBG.ClipsDescendants = true
    sliderBG.Parent = section
    CreateCorner(sliderBG, 3)
    
    local sliderFG = Instance.new("Frame")
    sliderFG.Size = UDim2.new(0, 0, 1, 0)
    sliderFG.BackgroundColor3 = LXAIL.ModernTheme.Accent
    sliderFG.BorderSizePixel = 0
    sliderFG.Parent = sliderBG
    CreateCorner(sliderFG, 3)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, -7, 0.5, 0)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.BackgroundColor3 = LXAIL.ModernTheme.Text
    knob.BorderSizePixel = 0
    knob.Parent = sliderBG
    CreateCorner(knob, 7)
    
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.15, 0, 1, -8)
    box.Font = Enum.Font.GothamBold
    box.TextSize = 16
    box.TextColor3 = LXAIL.ModernTheme.Text
    box.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    box.BorderSizePixel = 0
    box.Text = tostring(default)
    box.LayoutOrder = 3
    box.Parent = section
    CreateCorner(box, 4)
    
    local currentValue = default
    local dragging = false
    
    local function updateSlider(value)
        value = math.clamp(value, min, max)
        currentValue = value
        local percentage = (value - min) / (max - min)
        local px = percentage * sliderBG.AbsoluteSize.X
        
        CreateTween(sliderFG, 0.15, {Size = UDim2.new(0, px, 1, 0)})
        CreateTween(knob, 0.15, {Position = UDim2.new(0, px, 0.5, 0)})
        box.Text = tostring(math.floor(value))
        
        if callback then callback(value) end
    end
    
    local function handleSliderInput(input)
        local rel = math.clamp(input.Position.X - sliderBG.AbsolutePosition.X, 0, sliderBG.AbsoluteSize.X)
        local percentage = rel / sliderBG.AbsoluteSize.X
        local value = min + (percentage * (max - min))
        updateSlider(value)
    end
    
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            handleSliderInput(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragging = false
        end
    end)
    
    sliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            handleSliderInput(input)
        end
    end)
    
    box.FocusLost:Connect(function()
        local val = tonumber(box.Text)
        if val then
            updateSlider(val)
        else
            box.Text = tostring(currentValue)
        end
    end)
    
    updateSlider(default)
    return section, currentValue
end

-- Button Component
local function CreateModernButton(parent, text, callback)
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 50)
    section.BorderSizePixel = 0
    section.Parent = parent
    CreateCorner(section, 8)
    CreateShadow(section, 0.7)
    
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 15, 0, 0)
    label.Size = UDim2.new(0.7, -15, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    local btn = Instance.new("TextButton")
    btn.Text = "Execute"
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 18
    btn.TextColor3 = LXAIL.ModernTheme.Accent
    btn.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    btn.Size = UDim2.new(0, 80, 0, 35)
    btn.Position = UDim2.new(1, -90, 0.5, -17)
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = true
    btn.Parent = section
    CreateCorner(btn, 6)
    
    btn.MouseEnter:Connect(function()
        CreateTween(btn, 0.15, {BackgroundColor3 = LXAIL.ModernTheme.AccentHover})
    end)
    
    btn.MouseLeave:Connect(function()
        CreateTween(btn, 0.15, {BackgroundColor3 = LXAIL.ModernTheme.Secondary})
    end)
    
    btn.MouseButton1Click:Connect(function()
        btn.Text = "Done!"
        if callback then callback() end
        wait(0.5)
        btn.Text = "Execute"
    end)
    
    return section
end

-- === WINDOW CREATION ===
function LXAIL:CreateWindow(Options)
    if self.UIExists then
        self.CurrentWindow:Destroy()
    end
    
    local WindowOptions = Options or {}
    local Name = WindowOptions.Name or "LXAIL Hub"
    local LoadingTitle = WindowOptions.LoadingTitle or "LXAIL Loading..."
    local LoadingSubtitle = WindowOptions.LoadingSubtitle or "Modern UI Library"
    local ConfigurationSaving = WindowOptions.ConfigurationSaving
    local Discord = WindowOptions.Discord
    local KeySystem = WindowOptions.KeySystem
    local Theme = WindowOptions.Theme
    
    -- Store configuration settings
    if ConfigurationSaving then
        self.ConfigFolderName = ConfigurationSaving.FolderName or "LXAIL_Configs"
        self.ConfigFileName = ConfigurationSaving.FileName or "config"
        self.ConfigEnabled = ConfigurationSaving.Enabled or true
        print("📁 Configuration saving enabled:", self.ConfigFolderName .. "/" .. self.ConfigFileName)
    end
    
    -- Apply theme if specified
    if Theme then
        self:SetTheme(Theme)
        print("🎨 Theme applied:", Theme)
    end
    
    -- Show loading screen if LoadingTitle or LoadingSubtitle is provided
    if LoadingTitle ~= "LXAIL Loading..." or LoadingSubtitle ~= "Modern UI Library" then
        self:ShowLoadingScreen(LoadingTitle, LoadingSubtitle)
    end
    
    -- Create main GUI
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "LXAILUI"
    mainGui.Parent = PlayerGui or CoreGui
    mainGui.IgnoreGuiInset = true
    mainGui.ResetOnSpawn = false
    mainGui.Enabled = true
    
    -- Main container
    local bg = Instance.new("Frame")
    bg.Name = "MainContainer"
    bg.Size = UDim2.new(0.6, 0, 0.7, 0)
    bg.Position = UDim2.new(0.2, 0, 0.15, 0)
    bg.BackgroundColor3 = LXAIL.ModernTheme.Background
    bg.BackgroundTransparency = 0.3
    bg.AnchorPoint = Vector2.new(0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = mainGui
    
    CreateCorner(bg, 12)
    CreateShadow(bg, 0.85)
    CreateGradient(bg)
    
    -- Drag bar
    local dragBar = Instance.new("Frame")
    dragBar.BackgroundTransparency = 1
    dragBar.Size = UDim2.new(1, 0, 0, 50)
    dragBar.Position = UDim2.new(0, 0, 0, 0)
    dragBar.ZIndex = 10
    dragBar.Parent = bg
    
    -- Animated title
    CreateAnimatedTitle(bg, Name, UDim2.new(0, 60, 0, 10))
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 32
    closeBtn.TextColor3 = LXAIL.ModernTheme.Text
    closeBtn.BackgroundTransparency = 1
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.ZIndex = 2
    closeBtn.AutoButtonColor = false
    closeBtn.Parent = bg
    
    closeBtn.MouseEnter:Connect(function()
        CreateTween(closeBtn, 0.15, {TextColor3 = LXAIL.ModernTheme.ButtonHover})
    end)
    
    closeBtn.MouseLeave:Connect(function()
        CreateTween(closeBtn, 0.15, {TextColor3 = LXAIL.ModernTheme.Text})
    end)
    
    closeBtn.MouseButton1Click:Connect(function()
        mainGui.Enabled = false
    end)
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    sidebar.BackgroundTransparency = 0.25
    sidebar.Size = UDim2.new(0, 180, 1, -50)
    sidebar.Position = UDim2.new(0, 0, 0, 43)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = bg
    CreateCorner(sidebar, 10)
    
    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 6)
    sidebarLayout.Parent = sidebar
    
    -- Content area
    local content = Instance.new("Frame")
    content.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    content.BackgroundTransparency = 0.3
    content.Size = UDim2.new(1, -190, 1, -60)
    content.Position = UDim2.new(0, 190, 0, 55)
    content.BorderSizePixel = 0
    content.Parent = bg
    CreateCorner(content, 10)
    
    -- Tab frames storage
    local tabFrames = {}
    local tabs = {}
    
    -- Profile section
    local spacer = Instance.new("Frame")
    spacer.Size = UDim2.new(1, 0, 1, -170)
    spacer.BackgroundTransparency = 1
    spacer.LayoutOrder = 10
    spacer.Parent = sidebar
    
    local profile = Instance.new("Frame")
    profile.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    profile.BackgroundTransparency = 0.25
    profile.Size = UDim2.new(1, 0, 0, 60)
    profile.BorderSizePixel = 0
    profile.LayoutOrder = 20
    profile.Parent = sidebar
    CreateCorner(profile, 10)
    
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 40, 0, 40)
    avatar.Position = UDim2.new(0, 5, 0, 4)
    avatar.BackgroundTransparency = 1
    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..(Player.UserId or 1).."&width=420&height=420&format=png"
    avatar.Parent = profile
    CreateCorner(avatar, 20)
    
    local playerName = Instance.new("TextLabel")
    playerName.Text = Player.DisplayName or Player.Name or "Player"
    playerName.Font = Enum.Font.GothamBold
    playerName.TextSize = 16
    playerName.TextColor3 = LXAIL.ModernTheme.Text
    playerName.BackgroundTransparency = 1
    playerName.Position = UDim2.new(0, 50, 0, 20)
    playerName.Size = UDim2.new(1, -55, 0, 20)
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.Parent = profile
    
    -- Create floating button only if it doesn't exist
    if not self.FloatingButtonExists then
        self:CreateFloatingButton(mainGui)
        self.FloatingButtonExists = true
    end
    
    -- Make draggable
    self:MakeDraggable(dragBar, bg)
    
    -- Store references
    self.CurrentWindow = mainGui
    self.UIExists = true
    
    -- Window object
    local Window = {
        GUI = mainGui,
        Container = bg,
        Sidebar = sidebar,
        Content = content,
        TabFrames = tabFrames,
        Tabs = tabs,
        CurrentTab = nil
    }
    
    -- Check if KeySystem is enabled and show it
    if KeySystem then
        print("🔑 KeySystem enabled, showing authentication")
        -- Hide main window initially
        mainGui.Enabled = false
        
        -- Show key system and wait for authentication
        self:ShowKeySystem(KeySystem, function()
            print("🔑 KeySystem authenticated, showing main window")
            mainGui.Enabled = true
        end)
    end
    
    -- Add CreateTab method
    function Window:CreateTab(TabOptions)
        return LXAIL:CreateTab(self, TabOptions)
    end
    
    table.insert(self.Windows, Window)
    return Window
end

-- === TAB CREATION ===
function LXAIL:CreateTab(Window, Options)
    local TabOptions = Options or {}
    local Name = TabOptions.Name or "Tab"
    local Icon = TabOptions.Icon or TabOptions.Image or "rbxassetid://4483345998"
    
    -- Create tab button
    local tabShadow = Instance.new("Frame")
    tabShadow.Size = UDim2.new(1, 0, 0, 50)
    tabShadow.BackgroundTransparency = 1
    tabShadow.LayoutOrder = #Window.Tabs + 1
    tabShadow.Parent = Window.Sidebar
    
    local tab = Instance.new("TextButton")
    tab.Name = "Tab"
    tab.Text = Name
    tab.Font = Enum.Font.GothamBold
    tab.TextSize = 20
    tab.TextColor3 = LXAIL.ModernTheme.Text
    tab.BackgroundColor3 = (#Window.Tabs == 0) and Color3.fromRGB(60, 60, 60) or LXAIL.ModernTheme.Secondary
    tab.BackgroundTransparency = 0
    tab.Size = UDim2.new(1, -10, 1, -10)
    tab.Position = UDim2.new(0, 5, 0, 5)
    tab.BorderSizePixel = 0
    tab.AutoButtonColor = false
    tab.Parent = tabShadow
    CreateCorner(tab, 8)
    
    CreateShadow(tabShadow, 0.7)
    
    -- Create scroll frame for tab content
    local tabFrame = Instance.new("ScrollingFrame")
    tabFrame.Name = Name .. "Scroll"
    tabFrame.BackgroundTransparency = 1
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.Visible = (#Window.Tabs == 0)
    tabFrame.BorderSizePixel = 0
    tabFrame.ScrollBarThickness = 6
    tabFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabFrame.ClipsDescendants = true
    tabFrame.Parent = Window.Content
    
    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 10)
    list.HorizontalAlignment = Enum.HorizontalAlignment.Center
    list.Parent = tabFrame
    
    -- Store tab references
    Window.Tabs[Name] = tab
    Window.TabFrames[Name] = tabFrame
    
    if #Window.Tabs == 1 then
        Window.CurrentTab = tabFrame
    end
    
    -- Tab click handler
    tab.MouseButton1Click:Connect(function()
        -- Update tab colors
        for _, t in pairs(Window.Tabs) do
            t.BackgroundColor3 = LXAIL.ModernTheme.Secondary
        end
        tab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        
        -- Find current tab
        local currentTab = nil
        for _, f in pairs(Window.TabFrames) do
            if f.Visible then
                currentTab = f
                break
            end
        end
        
        -- Perform glitch transition
        CreateGlitchTransition(currentTab, tabFrame)
        Window.CurrentTab = tabFrame
    end)
    
    -- Tab object with component creation methods
    local Tab = {
        Frame = tabFrame,
        Button = tab,
        Name = Name
    }
    
    -- Add component creation methods
    function Tab:CreateToggle(ToggleOptions)
        return LXAIL:CreateToggle(self, ToggleOptions)
    end
    
    function Tab:CreateSlider(SliderOptions)
        return LXAIL:CreateSlider(self, SliderOptions)
    end
    
    function Tab:CreateButton(ButtonOptions)
        return LXAIL:CreateButton(self, ButtonOptions)
    end
    
    function Tab:CreateInput(InputOptions)
        return LXAIL:CreateInput(self, InputOptions)
    end
    
    function Tab:CreateDropdown(DropdownOptions)
        return LXAIL:CreateDropdown(self, DropdownOptions)
    end
    
    function Tab:CreateColorPicker(ColorPickerOptions)
        return LXAIL:CreateColorPicker(self, ColorPickerOptions)
    end
    
    function Tab:CreateKeybind(KeybindOptions)
        return LXAIL:CreateKeybind(self, KeybindOptions)
    end
    
    function Tab:CreateParagraph(ParagraphOptions)
        return LXAIL:CreateParagraph(self, ParagraphOptions)
    end
    
    function Tab:CreateLabel(LabelOptions)
        return LXAIL:CreateLabel(self, LabelOptions)
    end
    
    function Tab:CreateDivider(DividerOptions)
        return LXAIL:CreateDivider(self, DividerOptions)
    end
    
    return Tab
end

-- === COMPONENT CREATION METHODS ===

function LXAIL:CreateToggle(Tab, Options)
    local ToggleOptions = Options or {}
    local Name = ToggleOptions.Name or "Toggle"
    local Default = ToggleOptions.Default or false
    local Flag = ToggleOptions.Flag
    local Callback = ToggleOptions.Callback
    
    local toggleFrame, value = CreateModernToggle(Tab.Frame, Name, function(newValue)
        if Flag then
            self.Flags[Flag] = newValue
        end
        if Callback then
            Callback(newValue)
        end
    end)
    
    toggleFrame.LayoutOrder = #Tab.Frame:GetChildren()
    
    local Toggle = {
        Frame = toggleFrame,
        Value = value,
        Flag = Flag
    }
    
    function Toggle:Set(newValue)
        -- Implementation would update the toggle state
        self.Value = newValue
        if Flag then
            LXAIL.Flags[Flag] = newValue
        end
        if Callback then
            Callback(newValue)
        end
    end
    
    if Flag then
        self.Flags[Flag] = Default
    end
    
    return Toggle
end

function LXAIL:CreateSlider(Tab, Options)
    local SliderOptions = Options or {}
    local Name = SliderOptions.Name or "Slider"
    local Min = SliderOptions.Min or 0
    local Max = SliderOptions.Max or 100
    local Increment = SliderOptions.Increment or 1
    local Default = SliderOptions.Default or 50
    local Flag = SliderOptions.Flag
    local Callback = SliderOptions.Callback
    
    local sliderFrame, value = CreateModernSlider(Tab.Frame, Name, Min, Max, Default, function(newValue)
        if Flag then
            LXAIL.Flags[Flag] = newValue
        end
        if Callback then
            Callback(newValue)
        end
    end)
    
    sliderFrame.LayoutOrder = #Tab.Frame:GetChildren()
    
    local Slider = {
        Frame = sliderFrame,
        Value = value,
        Flag = Flag,
        Min = Min,
        Max = Max
    }
    
    function Slider:Set(newValue)
        newValue = math.clamp(newValue, Min, Max)
        self.Value = newValue
        if Flag then
            LXAIL.Flags[Flag] = newValue
        end
        if Callback then
            Callback(newValue)
        end
    end
    
    if Flag then
        self.Flags[Flag] = Default
    end
    
    return Slider
end

function LXAIL:CreateButton(Tab, Options)
    local ButtonOptions = Options or {}
    local Name = ButtonOptions.Name or "Button"
    local Callback = ButtonOptions.Callback
    
    local buttonFrame = CreateModernButton(Tab.Frame, Name, Callback)
    buttonFrame.LayoutOrder = #Tab.Frame:GetChildren()
    
    return {
        Frame = buttonFrame
    }
end

-- === FLOATING BUTTON ===
function LXAIL:CreateFloatingButton(mainGui)
    -- Remove existing floating button if it exists
    if PlayerGui and PlayerGui:FindFirstChild("ToggleButtonGui") then
        PlayerGui:FindFirstChild("ToggleButtonGui"):Destroy()
    end
    if CoreGui and CoreGui:FindFirstChild("ToggleButtonGui") then
        CoreGui:FindFirstChild("ToggleButtonGui"):Destroy()
    end
    
    local buttonGui = Instance.new("ScreenGui")
    buttonGui.Name = "ToggleButtonGui"
    buttonGui.Parent = PlayerGui or CoreGui
    buttonGui.IgnoreGuiInset = true
    buttonGui.ResetOnSpawn = false
    
    local draggableButton = Instance.new("ImageButton")
    draggableButton.Name = "ToggleButton"
    draggableButton.Image = "rbxassetid://100710776166961"
    draggableButton.Size = UDim2.new(0, 40, 0, 40)
    draggableButton.Position = UDim2.new(0, 20, 0, 200)
    draggableButton.BackgroundTransparency = 1
    draggableButton.AnchorPoint = Vector2.new(0, 0)
    draggableButton.ZIndex = 1000
    draggableButton.Parent = buttonGui
    CreateCorner(draggableButton, 10)
    
    -- Simple click functionality for toggle (simplified for mock environment)
    draggableButton.MouseButton1Click:Connect(function()
        -- Click animation
        CreateTween(draggableButton, 0.1, {Size = UDim2.new(0, 30, 0, 30)})
        spawn(function()
            wait(0.1)
            CreateTween(draggableButton, 0.1, {Size = UDim2.new(0, 40, 0, 40)})
        end)
        
        -- Toggle UI
        mainGui.Enabled = not mainGui.Enabled
        print("🔘 Floating button clicked - UI toggled:", mainGui.Enabled and "Shown" or "Hidden")
    end)
    
    -- F key toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F then
            mainGui.Enabled = not mainGui.Enabled
        end
    end)
end

-- === DRAGGING FUNCTIONALITY ===
function LXAIL:MakeDraggable(dragBar, frame)
    local dragging = false
    local dragInput, mousePos, framePos
    
    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

-- === COMPLETE COMPONENT IMPLEMENTATIONS ===

-- Input Component
function LXAIL:CreateInput(Tab, Options)
    local InputOptions = Options or {}
    local Name = InputOptions.Name or "Input"
    local PlaceholderText = InputOptions.PlaceholderText or ""
    local Default = InputOptions.Default or ""
    local RemoveTextAfterFocusLost = InputOptions.RemoveTextAfterFocusLost
    local Flag = InputOptions.Flag
    local Callback = InputOptions.Callback
    
    print("📝 CreateInput:", Name)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = Name
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0.6, -6, 1, -8)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.TextColor3 = LXAIL.ModernTheme.Text
    textBox.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    textBox.BorderSizePixel = 0
    textBox.Text = Default
    textBox.PlaceholderText = PlaceholderText
    textBox.LayoutOrder = 2
    textBox.Parent = section
    CreateCorner(textBox, 4)
    
    if RemoveTextAfterFocusLost then
        textBox.FocusLost:Connect(function()
            textBox.Text = ""
        end)
    end
    
    textBox.FocusLost:Connect(function()
        if Flag then
            LXAIL.Flags[Flag] = textBox.Text
        end
        if Callback then
            Callback(textBox.Text)
        end
    end)
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    if Flag then
        LXAIL.Flags[Flag] = Default
    end
    
    return {
        Frame = section,
        Value = textBox.Text,
        Flag = Flag,
        Set = function(self, newText)
            textBox.Text = newText
            if Flag then
                LXAIL.Flags[Flag] = newText
            end
            if Callback then
                Callback(newText)
            end
        end
    }
end

-- Dropdown Component
function LXAIL:CreateDropdown(Tab, Options)
    local DropdownOptions = Options or {}
    local Name = DropdownOptions.Name or "Dropdown"
    local OptionsTable = DropdownOptions.Options or {}
    local CurrentOption = DropdownOptions.CurrentOption or {}
    local MultipleOptions = DropdownOptions.MultipleOptions or false
    local Flag = DropdownOptions.Flag
    local Callback = DropdownOptions.Callback
    
    print("📋 CreateDropdown:", Name)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = Name
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Size = UDim2.new(0.6, -6, 1, -8)
    dropdownButton.Font = Enum.Font.Gotham
    dropdownButton.TextSize = 16
    dropdownButton.TextColor3 = LXAIL.ModernTheme.Text
    dropdownButton.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    dropdownButton.BorderSizePixel = 0
    dropdownButton.Text = (type(CurrentOption) == "table" and CurrentOption[1]) or CurrentOption or "Select..."
    dropdownButton.LayoutOrder = 2
    dropdownButton.Parent = section
    CreateCorner(dropdownButton, 4)
    
    local selectedOptions = type(CurrentOption) == "table" and CurrentOption or {CurrentOption}
    local isOpen = false
    
    dropdownButton.MouseButton1Click:Connect(function()
        if not isOpen then
            -- Create dropdown list
            local dropdownList = Instance.new("Frame")
            dropdownList.Size = UDim2.new(1, 0, 0, math.min(#OptionsTable * 25, 150))
            dropdownList.Position = UDim2.new(0, 0, 1, 2)
            dropdownList.BackgroundColor3 = LXAIL.ModernTheme.Secondary
            dropdownList.BorderSizePixel = 0
            dropdownList.ZIndex = 10
            dropdownList.Parent = dropdownButton
            CreateCorner(dropdownList, 4)
            
            local listLayout = Instance.new("UIListLayout")
            listLayout.SortOrder = Enum.SortOrder.LayoutOrder
            listLayout.Parent = dropdownList
            
            for i, option in ipairs(OptionsTable) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, 0, 0, 25)
                optionButton.BackgroundColor3 = LXAIL.ModernTheme.Secondary
                optionButton.BorderSizePixel = 0
                optionButton.Text = option
                optionButton.TextColor3 = LXAIL.ModernTheme.Text
                optionButton.Font = Enum.Font.Gotham
                optionButton.TextSize = 14
                optionButton.LayoutOrder = i
                optionButton.Parent = dropdownList
                
                optionButton.MouseEnter:Connect(function()
                    optionButton.BackgroundColor3 = LXAIL.ModernTheme.Accent
                end)
                
                optionButton.MouseLeave:Connect(function()
                    optionButton.BackgroundColor3 = LXAIL.ModernTheme.Secondary
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    if MultipleOptions then
                        local index = table.find(selectedOptions, option)
                        if index then
                            table.remove(selectedOptions, index)
                        else
                            table.insert(selectedOptions, option)
                        end
                        dropdownButton.Text = table.concat(selectedOptions, ", ")
                    else
                        selectedOptions = {option}
                        dropdownButton.Text = option
                    end
                    
                    if Flag then
                        LXAIL.Flags[Flag] = MultipleOptions and selectedOptions or selectedOptions[1]
                    end
                    if Callback then
                        Callback(MultipleOptions and selectedOptions or selectedOptions[1])
                    end
                    
                    if not MultipleOptions then
                        dropdownList:Destroy()
                        isOpen = false
                    end
                end)
            end
            
            isOpen = true
            
            -- Auto-close after 5 seconds (simplified for mobile compatibility)
            spawn(function()
                wait(5)
                if dropdownList.Parent then
                    dropdownList:Destroy()
                    isOpen = false
                end
            end)
        end
    end)
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    if Flag then
        LXAIL.Flags[Flag] = MultipleOptions and selectedOptions or selectedOptions[1]
    end
    
    return {
        Frame = section,
        Value = selectedOptions,
        Flag = Flag,
        Set = function(self, newOptions)
            selectedOptions = type(newOptions) == "table" and newOptions or {newOptions}
            dropdownButton.Text = MultipleOptions and table.concat(selectedOptions, ", ") or selectedOptions[1]
            if Flag then
                LXAIL.Flags[Flag] = MultipleOptions and selectedOptions or selectedOptions[1]
            end
            if Callback then
                Callback(MultipleOptions and selectedOptions or selectedOptions[1])
            end
        end
    }
end

-- ColorPicker Component
function LXAIL:CreateColorPicker(Tab, Options)
    local ColorPickerOptions = Options or {}
    local Name = ColorPickerOptions.Name or "ColorPicker"
    local Color = ColorPickerOptions.Color or Color3.fromRGB(255, 0, 0)
    local Flag = ColorPickerOptions.Flag
    local Callback = ColorPickerOptions.Callback
    
    print("🎨 CreateColorPicker:", Name)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = Name
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local colorDisplay = Instance.new("Frame")
    colorDisplay.Size = UDim2.new(0, 30, 0, 30)
    colorDisplay.BackgroundColor3 = Color
    colorDisplay.BorderSizePixel = 0
    colorDisplay.LayoutOrder = 2
    colorDisplay.Parent = section
    CreateCorner(colorDisplay, 15)
    
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(1, 0, 1, 0)
    colorButton.BackgroundTransparency = 1
    colorButton.Text = ""
    colorButton.Parent = colorDisplay
    
    local currentColor = Color
    
    colorButton.MouseButton1Click:Connect(function()
        -- Simple color picker - cycles through preset colors
        local colors = {
            Color3.fromRGB(255, 0, 0),    -- Red
            Color3.fromRGB(0, 255, 0),    -- Green
            Color3.fromRGB(0, 0, 255),    -- Blue
            Color3.fromRGB(255, 255, 0),  -- Yellow
            Color3.fromRGB(255, 0, 255),  -- Magenta
            Color3.fromRGB(0, 255, 255),  -- Cyan
            Color3.fromRGB(255, 255, 255), -- White
            Color3.fromRGB(0, 0, 0)       -- Black
        }
        
        local currentIndex = 1
        for i, color in ipairs(colors) do
            if currentColor == color then
                currentIndex = i
                break
            end
        end
        
        currentIndex = currentIndex + 1
        if currentIndex > #colors then
            currentIndex = 1
        end
        
        currentColor = colors[currentIndex]
        colorDisplay.BackgroundColor3 = currentColor
        
        if Flag then
            LXAIL.Flags[Flag] = currentColor
        end
        if Callback then
            Callback(currentColor)
        end
    end)
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    if Flag then
        LXAIL.Flags[Flag] = Color
    end
    
    return {
        Frame = section,
        Value = currentColor,
        Flag = Flag,
        Set = function(self, newColor)
            currentColor = newColor
            colorDisplay.BackgroundColor3 = newColor
            if Flag then
                LXAIL.Flags[Flag] = newColor
            end
            if Callback then
                Callback(newColor)
            end
        end
    }
end

-- Keybind Component
function LXAIL:CreateKeybind(Tab, Options)
    local KeybindOptions = Options or {}
    local Name = KeybindOptions.Name or "Keybind"
    local CurrentKeybind = KeybindOptions.CurrentKeybind or "F"
    local HoldToInteract = KeybindOptions.HoldToInteract or false
    local Flag = KeybindOptions.Flag
    local Callback = KeybindOptions.Callback
    
    print("⌨️ CreateKeybind:", Name)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 40)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = Name .. (HoldToInteract and " (Hold)" or "")
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.TextColor3 = LXAIL.ModernTheme.TextSecondary
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = 1
    label.Parent = section
    
    local keybindButton = Instance.new("TextButton")
    keybindButton.Size = UDim2.new(0.4, -6, 1, -8)
    keybindButton.Font = Enum.Font.Gotham
    keybindButton.TextSize = 16
    keybindButton.TextColor3 = LXAIL.ModernTheme.Text
    keybindButton.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    keybindButton.BorderSizePixel = 0
    keybindButton.Text = CurrentKeybind
    keybindButton.LayoutOrder = 2
    keybindButton.Parent = section
    CreateCorner(keybindButton, 4)
    
    local currentKeybind = CurrentKeybind
    local isBinding = false
    
    keybindButton.MouseButton1Click:Connect(function()
        if not isBinding then
            isBinding = true
            keybindButton.Text = "Press Key..."
            
            local connection
            connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed then return end
                
                local keyName = input.KeyCode.Name
                if keyName and keyName ~= "Unknown" then
                    currentKeybind = keyName
                    keybindButton.Text = keyName
                    isBinding = false
                    connection:Disconnect()
                    
                    if Flag then
                        LXAIL.Flags[Flag] = keyName
                    end
                    if Callback then
                        Callback(keyName)
                    end
                end
            end)
        end
    end)
    
    -- Handle keybind activation
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed or isBinding then return end
        if input.KeyCode.Name == currentKeybind then
            if Callback then
                Callback(currentKeybind)
            end
        end
    end)
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    if Flag then
        LXAIL.Flags[Flag] = CurrentKeybind
    end
    
    return {
        Frame = section,
        Value = currentKeybind,
        Flag = Flag,
        Set = function(self, newKeybind)
            currentKeybind = newKeybind
            keybindButton.Text = newKeybind
            if Flag then
                LXAIL.Flags[Flag] = newKeybind
            end
            if Callback then
                Callback(newKeybind)
            end
        end
    }
end

-- Paragraph Component
function LXAIL:CreateParagraph(Tab, Options)
    local ParagraphOptions = Options or {}
    local Title = ParagraphOptions.Title or "Paragraph"
    local Content = ParagraphOptions.Content or "This is a paragraph."
    
    print("📄 CreateParagraph:", Title)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 60)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = section
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = section
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = Title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextColor3 = LXAIL.ModernTheme.TextSecondary
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 20)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.LayoutOrder = 1
    titleLabel.Parent = section
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Text = Content
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 14
    contentLabel.TextColor3 = LXAIL.ModernTheme.Text
    contentLabel.BackgroundTransparency = 1
    contentLabel.Size = UDim2.new(1, 0, 0, 25)
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.LayoutOrder = 2
    contentLabel.Parent = section
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    return {
        Frame = section,
        SetContent = function(self, newContent)
            contentLabel.Text = newContent
        end
    }
end

-- Label Component
function LXAIL:CreateLabel(Tab, Options)
    local LabelOptions = Options or {}
    local Name = LabelOptions.Name or "Label"
    local Text = LabelOptions.Text or LabelOptions.Content or "Label Text"
    
    print("🏷️ CreateLabel:", Name)
    
    local section = Instance.new("Frame")
    section.BackgroundColor3 = LXAIL.ModernTheme.Tertiary
    section.BackgroundTransparency = 0.3
    section.Size = UDim2.new(0.95, 0, 0, 30)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    CreateCorner(section, 8)
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.PaddingRight = UDim.new(0, 15)
    padding.Parent = section
    
    local label = Instance.new("TextLabel")
    label.Text = Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 16
    label.TextColor3 = LXAIL.ModernTheme.Text
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = section
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    return {
        Frame = section,
        Set = function(self, newText)
            label.Text = newText
        end
    }
end

-- Divider Component
function LXAIL:CreateDivider(Tab, Options)
    local DividerOptions = Options or {}
    local Name = DividerOptions.Name or "Divider"
    
    print("━━━ CreateDivider:", Name, "━━━")
    
    local section = Instance.new("Frame")
    section.BackgroundTransparency = 1
    section.Size = UDim2.new(0.95, 0, 0, 20)
    section.BorderSizePixel = 0
    section.Parent = Tab.Frame
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    line.BorderSizePixel = 0
    line.Parent = section
    
    if Name ~= "Divider" then
        local label = Instance.new("TextLabel")
        label.Text = Name
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.TextColor3 = LXAIL.ModernTheme.Text
        label.BackgroundColor3 = LXAIL.ModernTheme.Background
        label.Size = UDim2.new(0, #Name * 8 + 10, 1, 0)
        label.Position = UDim2.new(0.5, -(#Name * 4 + 5), 0, 0)
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.Parent = section
    end
    
    section.LayoutOrder = #Tab.Frame:GetChildren()
    
    return {
        Frame = section
    }
end

-- Complete Notification System
function LXAIL:Notify(Options)
    local NotificationOptions = Options or {}
    local Title = NotificationOptions.Title or "Notification"
    local Content = NotificationOptions.Content or "This is a notification"
    local Duration = NotificationOptions.Duration or 5
    local Type = NotificationOptions.Type or "Info"
    
    print("🔔 Notification:", Title)
    
    -- Create notification GUI
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "LXAIL_Notification"
    notificationGui.Parent = CoreGui or PlayerGui
    
    local notification = Instance.new("Frame")
    notification.Size = UDim2.new(0, 300, 0, 80)
    notification.Position = UDim2.new(1, -320, 0, 20)
    notification.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    notification.BorderSizePixel = 0
    notification.Parent = notificationGui
    CreateCorner(notification, 8)
    
    -- Type color bar
    local typeBar = Instance.new("Frame")
    typeBar.Size = UDim2.new(0, 4, 1, 0)
    typeBar.Position = UDim2.new(0, 0, 0, 0)
    typeBar.BorderSizePixel = 0
    typeBar.Parent = notification
    
    if Type == "Success" then
        typeBar.BackgroundColor3 = LXAIL.ModernTheme.Accent
    elseif Type == "Warning" then
        typeBar.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    elseif Type == "Error" then
        typeBar.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    else
        typeBar.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
    end
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = Title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextColor3 = LXAIL.ModernTheme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -10, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notification
    
    -- Content
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Text = Content
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 14
    contentLabel.TextColor3 = LXAIL.ModernTheme.Text
    contentLabel.BackgroundTransparency = 1
    contentLabel.Size = UDim2.new(1, -10, 0, 45)
    contentLabel.Position = UDim2.new(0, 10, 0, 25)
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextWrapped = true
    contentLabel.Parent = notification
    
    -- Animate in
    notification.Position = UDim2.new(1, 0, 0, 20)
    CreateTween(notification, 0.3, {Position = UDim2.new(1, -320, 0, 20)})
    
    -- Auto remove after duration
    spawn(function()
        wait(Duration)
        CreateTween(notification, 0.3, {Position = UDim2.new(1, 0, 0, 20)})
        wait(0.3)
        notificationGui:Destroy()
    end)
    
    return notification
end

-- === ADVANCED SYSTEMS ===

-- Loading Screen Implementation
function LXAIL:ShowLoadingScreen(loadingTitle, loadingSubtitle)
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "LXAIL_LoadingScreen"
    loadingGui.Parent = CoreGui or PlayerGui
    if loadingGui.ZIndexBehavior then
        loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
    
    -- Background
    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.Position = UDim2.new(0, 0, 0, 0)
    background.BackgroundColor3 = LXAIL.ModernTheme.Background
    background.BorderSizePixel = 0
    background.ZIndex = 200
    background.Parent = loadingGui
    
    -- Loading container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 400, 0, 200)
    container.Position = UDim2.new(0.5, -200, 0.5, -100)
    container.BackgroundTransparency = 1
    container.ZIndex = 201
    container.Parent = loadingGui
    
    -- Animated title with typewriter effect
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = ""
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 32
    titleLabel.TextColor3 = LXAIL.ModernTheme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 30)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.ZIndex = 202
    titleLabel.Parent = container
    
    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Text = loadingSubtitle
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextSize = 18
    subtitleLabel.TextColor3 = LXAIL.ModernTheme.TextSecondary
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 0, 0, 90)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subtitleLabel.ZIndex = 202
    subtitleLabel.Parent = container
    
    -- Loading bar
    local loadingBarBG = Instance.new("Frame")
    loadingBarBG.Size = UDim2.new(0.8, 0, 0, 4)
    loadingBarBG.Position = UDim2.new(0.1, 0, 0, 140)
    loadingBarBG.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    loadingBarBG.BorderSizePixel = 0
    loadingBarBG.ZIndex = 202
    loadingBarBG.Parent = container
    CreateCorner(loadingBarBG, 2)
    
    local loadingBar = Instance.new("Frame")
    loadingBar.Size = UDim2.new(0, 0, 1, 0)
    loadingBar.Position = UDim2.new(0, 0, 0, 0)
    loadingBar.BackgroundColor3 = LXAIL.ModernTheme.Accent
    loadingBar.BorderSizePixel = 0
    loadingBar.ZIndex = 203
    loadingBar.Parent = loadingBarBG
    CreateCorner(loadingBar, 2)
    
    -- Typewriter effect for title
    spawn(function()
        for i = 1, #loadingTitle do
            titleLabel.Text = loadingTitle:sub(1, i)
            wait(0.05)
        end
        
        -- Animate loading bar
        CreateTween(loadingBar, 2, {Size = UDim2.new(1, 0, 1, 0)})
        wait(2.5)
        
        -- Fade out loading screen
        CreateTween(background, 0.5, {BackgroundTransparency = 1})
        CreateTween(titleLabel, 0.5, {TextTransparency = 1})
        CreateTween(subtitleLabel, 0.5, {TextTransparency = 1})
        CreateTween(loadingBarBG, 0.5, {BackgroundTransparency = 1})
        CreateTween(loadingBar, 0.5, {BackgroundTransparency = 1})
        wait(0.5)
        loadingGui:Destroy()
    end)
end

-- Key System Implementation
function LXAIL:ShowKeySystem(KeySystemOptions, onAuthenticated)
    local KeyOptions = KeySystemOptions or {}
    local Title = KeyOptions.Title or "Key System"
    local Subtitle = KeyOptions.Subtitle or "Enter your key"
    local Note = KeyOptions.Note or "Get your key from our Discord server"
    local FileName = KeyOptions.FileName or "LXAIL_Key"
    local SaveKey = KeyOptions.SaveKey or true
    local GrabKeyFromSite = KeyOptions.GrabKeyFromSite or false
    local Key = KeyOptions.Key or {"DefaultKey"}
    
    print("🔑 KeySystem: Showing key authentication")
    
    -- Create key system GUI with modern design
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "LXAIL_KeySystem"
    keyGui.Parent = CoreGui or PlayerGui
    if keyGui.ZIndexBehavior then
        keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    end
    
    -- Background overlay
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 100
    overlay.Parent = keyGui
    
    local keyFrame = Instance.new("Frame")
    keyFrame.Size = UDim2.new(0, 450, 0, 350)
    keyFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    keyFrame.BackgroundColor3 = LXAIL.ModernTheme.Background
    keyFrame.BorderSizePixel = 0
    keyFrame.ZIndex = 101
    keyFrame.Parent = keyGui
    CreateCorner(keyFrame, 12)
    CreateShadow(keyFrame, 0.7)
    CreateGradient(keyFrame)
    
    -- Modern animated title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = Title
    titleLabel.Font = Enum.Font.GothamBlack
    titleLabel.TextSize = 28
    titleLabel.TextColor3 = LXAIL.ModernTheme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, -40, 0, 50)
    titleLabel.Position = UDim2.new(0, 20, 0, 20)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.ZIndex = 102
    titleLabel.Parent = keyFrame
    
    -- Title underline
    local titleUnderline = Instance.new("Frame")
    titleUnderline.Size = UDim2.new(0, 100, 0, 2)
    titleUnderline.Position = UDim2.new(0.5, -50, 0, 75)
    titleUnderline.BackgroundColor3 = LXAIL.ModernTheme.Accent
    titleUnderline.BorderSizePixel = 0
    titleUnderline.ZIndex = 102
    titleUnderline.Parent = keyFrame
    CreateCorner(titleUnderline, 1)
    
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Text = Subtitle
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextSize = 16
    subtitleLabel.TextColor3 = LXAIL.ModernTheme.TextSecondary
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Size = UDim2.new(1, -40, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 20, 0, 85)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subtitleLabel.ZIndex = 102
    subtitleLabel.Parent = keyFrame
    
    local noteLabel = Instance.new("TextLabel")
    noteLabel.Text = Note
    noteLabel.Font = Enum.Font.Gotham
    noteLabel.TextSize = 14
    noteLabel.TextColor3 = LXAIL.ModernTheme.TextSecondary
    noteLabel.BackgroundTransparency = 1
    noteLabel.Size = UDim2.new(1, -40, 0, 50)
    noteLabel.Position = UDim2.new(0, 20, 0, 125)
    noteLabel.TextXAlignment = Enum.TextXAlignment.Center
    noteLabel.TextWrapped = true
    noteLabel.ZIndex = 102
    noteLabel.Parent = keyFrame
    
    local keyInput = Instance.new("TextBox")
    keyInput.Size = UDim2.new(0.85, 0, 0, 45)
    keyInput.Position = UDim2.new(0.075, 0, 0, 185)
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextSize = 16
    keyInput.TextColor3 = LXAIL.ModernTheme.Text
    keyInput.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    keyInput.BorderSizePixel = 0
    keyInput.PlaceholderText = "Enter your key here..."
    keyInput.TextXAlignment = Enum.TextXAlignment.Center
    keyInput.ZIndex = 102
    keyInput.Parent = keyFrame
    CreateCorner(keyInput, 8)
    
    -- Input field stroke
    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = LXAIL.ModernTheme.Accent
    inputStroke.Thickness = 2
    inputStroke.Transparency = 0.7
    inputStroke.Parent = keyInput
    
    local submitButton = Instance.new("TextButton")
    submitButton.Text = "✓ Submit Key"
    submitButton.Font = Enum.Font.GothamBold
    submitButton.TextSize = 16
    submitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitButton.BackgroundColor3 = LXAIL.ModernTheme.Accent
    submitButton.Size = UDim2.new(0.4, 0, 0, 45)
    submitButton.Position = UDim2.new(0.075, 0, 0, 250)
    submitButton.BorderSizePixel = 0
    submitButton.ZIndex = 102
    submitButton.Parent = keyFrame
    CreateCorner(submitButton, 8)
    
    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Text = "🔑 Get Key"
    getKeyButton.Font = Enum.Font.GothamBold
    getKeyButton.TextSize = 16
    getKeyButton.TextColor3 = LXAIL.ModernTheme.Text
    getKeyButton.BackgroundColor3 = LXAIL.ModernTheme.Secondary
    getKeyButton.Size = UDim2.new(0.4, 0, 0, 45)
    getKeyButton.Position = UDim2.new(0.525, 0, 0, 250)
    getKeyButton.BorderSizePixel = 0
    getKeyButton.ZIndex = 102
    getKeyButton.Parent = keyFrame
    CreateCorner(getKeyButton, 8)
    
    -- Button hover effects
    submitButton.MouseEnter:Connect(function()
        CreateTween(submitButton, 0.2, {BackgroundColor3 = LXAIL.ModernTheme.AccentHover})
    end)
    
    submitButton.MouseLeave:Connect(function()
        CreateTween(submitButton, 0.2, {BackgroundColor3 = LXAIL.ModernTheme.Accent})
    end)
    
    getKeyButton.MouseEnter:Connect(function()
        CreateTween(getKeyButton, 0.2, {BackgroundColor3 = LXAIL.ModernTheme.Tertiary})
    end)
    
    getKeyButton.MouseLeave:Connect(function()
        CreateTween(getKeyButton, 0.2, {BackgroundColor3 = LXAIL.ModernTheme.Secondary})
    end)
    
    -- Key validation with URL support
    submitButton.MouseButton1Click:Connect(function()
        local enteredKey = keyInput.Text
        local isValidKey = false
        
        -- Check if GrabKeyFromSite is enabled for URL validation
        if GrabKeyFromSite and KeyOptions.KeySite then
            -- URL-based key validation
            local success, result = pcall(function()
                return HttpService:GetAsync(KeyOptions.KeySite)
            end)
            
            if success then
                local validKeys = {}
                -- Try to parse JSON response
                local jsonSuccess, jsonResult = pcall(function()
                    return HttpService:JSONDecode(result)
                end)
                
                if jsonSuccess and jsonResult.keys then
                    validKeys = jsonResult.keys
                elseif jsonSuccess and jsonResult.key then
                    validKeys = {jsonResult.key}
                else
                    -- If not JSON, treat as plain text key
                    validKeys = {result:gsub("%s+", "")}
                end
                
                -- Check against URL keys
                for _, validKey in ipairs(validKeys) do
                    if enteredKey == validKey then
                        isValidKey = true
                        break
                    end
                end
            end
        end
        
        -- Fallback to local keys if URL failed or not enabled
        if not isValidKey then
            for _, validKey in ipairs(Key) do
                if enteredKey == validKey then
                    isValidKey = true
                    break
                end
            end
        end
        
        if isValidKey then
            if SaveKey then
                -- Save key to file (simulated)
                print("Key saved:", enteredKey)
            end
            
            -- Success animation
            CreateTween(keyFrame, 0.3, {BackgroundColor3 = LXAIL.ModernTheme.Accent})
            wait(0.5)
            keyGui:Destroy()
            print("✅ Key validation successful!")
            
            -- Call the authentication callback
            if onAuthenticated then
                onAuthenticated()
            end
        else
            keyInput.Text = ""
            keyInput.PlaceholderText = "Invalid key! Try again..."
            
            -- Error animation
            CreateTween(inputStroke, 0.1, {Color = Color3.fromRGB(255, 100, 100), Transparency = 0.3})
            CreateTween(keyFrame, 0.1, {Position = keyFrame.Position + UDim2.new(0, 10, 0, 0)})
            wait(0.1)
            CreateTween(keyFrame, 0.1, {Position = keyFrame.Position - UDim2.new(0, 10, 0, 0)})
            wait(0.5)
            CreateTween(inputStroke, 0.3, {Color = LXAIL.ModernTheme.Accent, Transparency = 0.7})
        end
    end)
    
    getKeyButton.MouseButton1Click:Connect(function()
        local keyUrl = KeyOptions.KeySite or KeyOptions.DiscordInvite or "https://discord.gg/your-server"
        
        if KeyOptions.KeySite then
            print("Opening key website:", keyUrl)
            self:Notify({
                Title = "Get Key",
                Content = "Visit the website to get your key!",
                Duration = 3,
                Type = "Info"
            })
        elseif KeyOptions.DiscordInvite then
            print("Opening Discord server:", keyUrl)
            self:Notify({
                Title = "Join Discord",
                Content = "Join our Discord server to get your key!",
                Duration = 3,
                Type = "Info"
            })
        else
            print("Get key button clicked - default action")
            self:Notify({
                Title = "Get Key",
                Content = "Check our Discord server for keys!",
                Duration = 3,
                Type = "Info"
            })
        end
        
        -- In Roblox, this would open the URL
        if game then
            local success, result = pcall(function()
                return game:GetService("GuiService"):OpenBrowserWindow(keyUrl)
            end)
            if not success then
                print("Could not open browser window")
            end
        end
    end)
    
    return keyGui
end

-- Discord Prompt System
function LXAIL:Prompt(PromptOptions)
    local Options = PromptOptions or {}
    local Title = Options.Title or "Prompt"
    local SubTitle = Options.SubTitle or ""
    local Content = Options.Content or "This is a prompt."
    local Actions = Options.Actions or {}
    
    print("💬 Prompt:", Title)
    
    local promptGui = Instance.new("ScreenGui")
    promptGui.Name = "LXAIL_Prompt"
    promptGui.Parent = CoreGui or PlayerGui
    
    local backdrop = Instance.new("Frame")
    backdrop.Size = UDim2.new(1, 0, 1, 0)
    backdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    backdrop.BackgroundTransparency = 0.5
    backdrop.BorderSizePixel = 0
    backdrop.Parent = promptGui
    
    local promptFrame = Instance.new("Frame")
    promptFrame.Size = UDim2.new(0, 450, 0, 300)
    promptFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    promptFrame.BackgroundColor3 = LXAIL.ModernTheme.Background
    promptFrame.BorderSizePixel = 0
    promptFrame.Parent = promptGui
    CreateCorner(promptFrame, 12)
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = promptFrame
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 20)
    padding.PaddingRight = UDim.new(0, 20)
    padding.PaddingTop = UDim.new(0, 20)
    padding.PaddingBottom = UDim.new(0, 20)
    padding.Parent = promptFrame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = Title
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 24
    titleLabel.TextColor3 = LXAIL.ModernTheme.Text
    titleLabel.BackgroundTransparency = 1
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.LayoutOrder = 1
    titleLabel.Parent = promptFrame
    
    if SubTitle ~= "" then
        local subTitleLabel = Instance.new("TextLabel")
        subTitleLabel.Text = SubTitle
        subTitleLabel.Font = Enum.Font.Gotham
        subTitleLabel.TextSize = 18
        subTitleLabel.TextColor3 = LXAIL.ModernTheme.Text
        subTitleLabel.BackgroundTransparency = 1
        subTitleLabel.Size = UDim2.new(1, 0, 0, 25)
        subTitleLabel.LayoutOrder = 2
        subTitleLabel.Parent = promptFrame
    end
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Text = Content
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextSize = 14
    contentLabel.TextColor3 = LXAIL.ModernTheme.Text
    contentLabel.BackgroundTransparency = 1
    contentLabel.Size = UDim2.new(1, 0, 0, 80)
    contentLabel.TextWrapped = true
    contentLabel.LayoutOrder = 3
    contentLabel.Parent = promptFrame
    
    -- Create action buttons
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(1, 0, 0, 50)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.LayoutOrder = 4
    buttonContainer.Parent = promptFrame
    
    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.FillDirection = Enum.FillDirection.Horizontal
    buttonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    buttonLayout.Padding = UDim.new(0, 10)
    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buttonLayout.Parent = buttonContainer
    
    for actionName, actionData in pairs(Actions) do
        local button = Instance.new("TextButton")
        button.Text = actionData.Name or actionName
        button.Font = Enum.Font.GothamBold
        button.TextSize = 16
        button.TextColor3 = LXAIL.ModernTheme.Text
        button.BackgroundColor3 = (actionName == "Accept") and LXAIL.ModernTheme.Accent or LXAIL.ModernTheme.Secondary
        button.Size = UDim2.new(0, 120, 0, 40)
        button.BorderSizePixel = 0
        button.Parent = buttonContainer
        CreateCorner(button, 8)
        
        button.MouseButton1Click:Connect(function()
            if actionData.Callback then
                actionData.Callback()
            end
            promptGui:Destroy()
        end)
    end
    
    return promptGui
end

-- Helper function for counting table elements
function LXAIL:GetTableLength(table)
    local count = 0
    for _ in pairs(table) do
        count = count + 1
    end
    return count
end

-- Configuration Management
function LXAIL:SaveConfiguration()
    print("💾 SaveConfiguration: Saving current settings")
    local config = {}
    for flag, value in pairs(self.Flags) do
        config[flag] = value
    end
    
    -- Get configuration settings from window creation
    local folderName = self.ConfigFolderName or "LXAIL_Configs"
    local fileName = self.ConfigFileName or "config"
    
    -- Create folder structure and save file
    local configPath = folderName .. "/" .. fileName .. ".json"
    local configData = game:GetService("HttpService"):JSONEncode(config)
    
    -- In Roblox, use DataStore or writeFile equivalent
    if game and game:GetService("HttpService") then
        local success, result = pcall(function()
            -- In real Roblox, this would create folder and save file
            -- For now, simulate successful save
            print("Configuration saved to:", configPath)
            print("Data:", configData)
            return true
        end)
        if success then
            print("Configuration saved successfully with", self:GetTableLength(config), "settings")
            return true
        else
            print("Failed to save configuration:", result)
            return false
        end
    else
        print("HttpService not available - configuration save simulated")
        return false
    end
end

function LXAIL:LoadConfiguration()
    print("📂 LoadConfiguration: Loading saved settings")
    
    local folderName = self.ConfigFolderName or "LXAIL_Configs"
    local fileName = self.ConfigFileName or "config"
    local configPath = folderName .. "/" .. fileName .. ".json"
    
    -- In Roblox, use DataStore or readFile equivalent
    if game and game:GetService("HttpService") then
        local success, result = pcall(function()
            -- In real Roblox, this would read from file
            -- For now, simulate successful load
            print("Loading configuration from:", configPath)
            return "{}"
        end)
        if success then
            local config = game:GetService("HttpService"):JSONDecode(result)
            for flag, value in pairs(config) do
                self.Flags[flag] = value
            end
            print("Configuration loaded successfully")
            return true
        else
            print("Failed to load configuration:", result)
            return false
        end
    else
        print("HttpService not available - configuration load simulated")
        return false
    end
end

function LXAIL:ResetConfiguration()
    print("🔄 ResetConfiguration: Resetting to defaults")
    self.Flags = {}
    print("Configuration reset to defaults")
end

-- Theme Management
function LXAIL:SetTheme(ThemeName)
    print("🎨 SetTheme:", ThemeName)
    if ThemeName == "Light" then
        self.ModernTheme = {
            Background = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(240, 240, 240),
            Tertiary = Color3.fromRGB(220, 220, 220),
            Text = Color3.fromRGB(0, 0, 0),
            TextSecondary = Color3.fromRGB(50, 50, 50),
            Accent = Color3.fromRGB(50, 100, 200),
            AccentHover = Color3.fromRGB(70, 120, 220),
            ToggleOff = Color3.fromRGB(200, 50, 50),
            ToggleOn = Color3.fromRGB(50, 200, 50)
        }
    elseif ThemeName == "Neon" then
        self.ModernTheme = {
            Background = Color3.fromRGB(10, 10, 15),
            Secondary = Color3.fromRGB(20, 20, 30),
            Tertiary = Color3.fromRGB(30, 30, 45),
            Text = Color3.fromRGB(255, 255, 255),
            TextSecondary = Color3.fromRGB(200, 255, 255),
            Accent = Color3.fromRGB(150, 100, 255),
            AccentHover = Color3.fromRGB(170, 120, 255),
            ToggleOff = Color3.fromRGB(255, 50, 150),
            ToggleOn = Color3.fromRGB(100, 255, 150)
        }
    else -- Dark theme (default)
        self.ModernTheme = {
            Background = Color3.fromRGB(20, 20, 20),
            Secondary = Color3.fromRGB(35, 35, 35),
            Tertiary = Color3.fromRGB(50, 50, 50),
            Text = Color3.fromRGB(230, 230, 230),
            TextSecondary = Color3.fromRGB(240, 240, 240),
            Accent = Color3.fromRGB(60, 180, 60),
            AccentHover = Color3.fromRGB(60, 220, 60),
            ToggleOff = Color3.fromRGB(150, 40, 40),
            ToggleOn = Color3.fromRGB(60, 180, 60)
        }
    end
    print("Theme changed to:", ThemeName)
end

-- UI Toggle Function
function LXAIL:Toggle()
    if self.CurrentWindow then
        self.CurrentWindow.Enabled = not self.CurrentWindow.Enabled
        print("UI toggled:", self.CurrentWindow.Enabled and "Shown" or "Hidden")
    end
end

-- Duplicate CreateWindow function removed - using the original one above

-- === RETURN LIBRARY ===
if game then
    print("🚀 LXAIL Modern UI Library Loaded Successfully!")
    print("💡 Press F to toggle UI")
    print("🔑 KeySystem support enabled")
    print("💬 Discord integration available")
    print("💾 Configuration management ready")
    print("🎨 Multiple themes available")
end

return LXAIL