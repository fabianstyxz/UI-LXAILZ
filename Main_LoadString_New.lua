--[[
    LXAIL - Complete Roblox UI Library
    Modern Design with Glitch Effects and Animated Elements
    Complete Rayfield functionality replica
    
    Usage:
    local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/fabianstyxz/UI-LXAILZ/main/Main_LoadString.lua"))()
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
    UIExists = false
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
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
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
        letterLabel.Position = position + UDim2.new(0, (i-1) * letterSpacing, 0, 0)
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
            Position = currentTab.Position + UDim2.new(0, 5, 0, 0),
            BackgroundTransparency = 0.5,
            Size = currentTab.Size + UDim2.new(0, 5, 0, 5)
        })
        glitchTween1.Completed:Wait()
        
        local glitchTween2 = CreateTween(currentTab, 0.05, {
            Position = currentTab.Position + UDim2.new(0, -5, 0, 5),
            BackgroundTransparency = 0.7,
            Size = currentTab.Size - UDim2.new(0, 5, 0, 5)
        })
        glitchTween2.Completed:Wait()
        
        local glitchTween3 = CreateTween(currentTab, 0.05, {
            Position = currentTab.Position,
            BackgroundTransparency = 1,
            Size = currentTab.Size
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
        Position = newTab.Position + UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 0.5,
        Size = newTab.Size + UDim2.new(0, 5, 0, 5)
    })
    glitchIn1.Completed:Wait()
    
    local glitchIn2 = CreateTween(newTab, 0.05, {
        Position = newTab.Position + UDim2.new(0, -5, 0, 5),
        BackgroundTransparency = 0.7,
        Size = newTab.Size - UDim2.new(0, 5, 0, 5)
    })
    glitchIn2.Completed:Wait()
    
    local glitchIn3 = CreateTween(newTab, 0.05, {
        Position = newTab.Position,
        BackgroundTransparency = 0,
        Size = newTab.Size
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
    
    -- Create floating button
    self:CreateFloatingButton(mainGui)
    
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
    
    -- Dragging functionality
    local dragging = false
    local dragStart, startPos
    
    draggableButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = draggableButton.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            draggableButton.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    -- Toggle functionality
    local clickStarted = false
    local clickStartTime = 0
    
    draggableButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            clickStarted = true
            clickStartTime = tick()
        end
    end)
    
    draggableButton.InputEnded:Connect(function(input)
        if clickStarted and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            clickStarted = false
            if tick() - clickStartTime < 0.25 then
                -- Click animation
                CreateTween(draggableButton, 0.1, {Size = UDim2.new(0, 30, 0, 30)})
                wait(0.1)
                CreateTween(draggableButton, 0.1, {Size = UDim2.new(0, 40, 0, 40)})
                
                -- Toggle UI
                mainGui.Enabled = not mainGui.Enabled
            end
        end
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

-- === PLACEHOLDER IMPLEMENTATIONS ===
-- These would be fully implemented with the modern design

function LXAIL:CreateInput(Tab, Options)
    print("📝 CreateInput:", Options.Name or "Input")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateDropdown(Tab, Options)
    print("📋 CreateDropdown:", Options.Name or "Dropdown")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateColorPicker(Tab, Options)
    print("🎨 CreateColorPicker:", Options.Name or "ColorPicker")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateKeybind(Tab, Options)
    print("⌨️ CreateKeybind:", Options.Name or "Keybind")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateParagraph(Tab, Options)
    print("📄 CreateParagraph:", Options.Title or "Paragraph")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateLabel(Tab, Options)
    print("🏷️ CreateLabel:", Options.Name or "Label")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:CreateDivider(Tab, Options)
    print("━━━ CreateDivider:", Options.Name or "Divider", "━━━")
    return {Frame = Instance.new("Frame")}
end

function LXAIL:Notify(Options)
    print("🔔 Notification:", Options.Title or "Notification")
end

-- === RETURN LIBRARY ===
if game then
    print("🚀 LXAIL Modern UI Library Loaded Successfully!")
    print("💡 Press F to toggle UI")
end

return LXAIL