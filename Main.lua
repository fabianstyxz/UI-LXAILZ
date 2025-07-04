--[[
    LXAIL - Modern UI Library for Roblox
    Complete Rayfield functionality replica with custom modern design
    Compatible with loadstring() execution
    
    Created by: LXAIL Team
    Version: 1.0.0
--]]

-- LXAIL - Complete UI Library for Roblox
-- In Roblox, replace these with actual game services

-- Mock global services for local environment
_G.Instance = {
    new = function(className)
        return {
            ClassName = className,
            Name = "",
            Parent = nil,
            Font = "Gotham",
            TextSize = 14,
            Text = "",
            TextWrapped = false,
            Size = {X = 0, Y = 0},
            Position = {X = 0, Y = 0},
            BackgroundColor3 = {R = 1, G = 1, B = 1},
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            ZIndex = 1,
            TextXAlignment = "Center",
            TextYAlignment = "Center",
            TextColor3 = {R = 1, G = 1, B = 1},
            BorderColor3 = {R = 0, G = 0, B = 0},
            AutomaticSize = "None",
            Visible = true,
            Active = true,
            ClipsDescendants = false,
            Selectable = true,
            ZIndexBehavior = "Sibling",
            ResetOnSpawn = false,
            SortOrder = "LayoutOrder",
            LayoutOrder = 0,
            FillDirection = "Horizontal",
            HorizontalAlignment = "Left",
            VerticalAlignment = "Top",
            Padding = {Scale = 0, Offset = 0},
            ClearButtonMode = "Never",
            PlaceholderText = "",
            TextEditable = true,
            TextTruncate = "None",
            MouseButton1Click = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            MouseButton1Down = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            MouseButton1Up = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            MouseEnter = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            MouseLeave = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            InputBegan = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            InputEnded = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            InputChanged = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            Focused = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            FocusLost = {
                Connect = function(func)
                    return {Disconnect = function() end}
                end
            },
            GetPropertyChangedSignal = function(property)
                return {
                    Connect = function(func)
                        return {Disconnect = function() end}
                    end
                }
            end,
            Destroy = function() end
        }
    end
}

_G.UDim2 = {
    new = function(xScale, xOffset, yScale, yOffset)
        return {
            X = {Scale = xScale, Offset = xOffset},
            Y = {Scale = yScale, Offset = yOffset}
        }
    end
}

_G.Color3 = {
    new = function(r, g, b)
        return {R = r, G = g, B = b}
    end,
    fromRGB = function(r, g, b)
        return {R = r/255, G = g/255, B = b/255}
    end
}

_G.Vector2 = {
    new = function(x, y)
        return {X = x, Y = y}
    end
}

_G.UDim = {
    new = function(scale, offset)
        return {Scale = scale, Offset = offset}
    end
}

_G.TweenInfo = {
    new = function(duration, style, direction, repeatCount, reverses, delayTime)
        return {
            Duration = duration or 1,
            Style = style or Enum.EasingStyle.Quad,
            Direction = direction or Enum.EasingDirection.Out,
            RepeatCount = repeatCount or 0,
            Reverses = reverses or false,
            DelayTime = delayTime or 0
        }
    end
}

_G.ColorSequenceKeypoint = {
    new = function(time, color)
        return {Time = time, Value = color}
    end
}

_G.ColorSequence = {
    new = function(keypoints)
        return {Keypoints = keypoints or {}}
    end
}

_G.NumberSequenceKeypoint = {
    new = function(time, value, envelope)
        return {Time = time, Value = value, Envelope = envelope or 0}
    end
}

_G.NumberSequence = {
    new = function(keypoints)
        return {Keypoints = keypoints or {}}
    end
}

_G.Enum = {
    KeyCode = {F = "F", LeftShift = "LeftShift"},
    EasingStyle = {Quad = "Quad", Sine = "Sine"},
    EasingDirection = {In = "In", Out = "Out", InOut = "InOut"},
    Font = {Gotham = "Gotham", GothamBold = "GothamBold"},
    TextXAlignment = {Left = "Left", Center = "Center", Right = "Right"},
    TextYAlignment = {Top = "Top", Center = "Center", Bottom = "Bottom"},
    AutomaticSize = {None = "None", X = "X", Y = "Y", XY = "XY"},
    SizeConstraint = {RelativeXY = "RelativeXY", RelativeXX = "RelativeXX", RelativeYY = "RelativeYY"},
    ZIndexBehavior = {Sibling = "Sibling", Global = "Global"},
    SortOrder = {LayoutOrder = "LayoutOrder", Name = "Name"},
    FillDirection = {Horizontal = "Horizontal", Vertical = "Vertical"},
    HorizontalAlignment = {Left = "Left", Center = "Center", Right = "Right"},
    VerticalAlignment = {Top = "Top", Center = "Center", Bottom = "Bottom"},
    UserInputType = {MouseButton1 = "MouseButton1", Touch = "Touch", MouseMovement = "MouseMovement"},
    ClearButtonMode = {Never = "Never", WhileEditing = "WhileEditing", UnlessEditing = "UnlessEditing", Always = "Always"},
    TextTruncate = {None = "None", AtEnd = "AtEnd"}
}

-- Make globals available
Instance = _G.Instance
UDim2 = _G.UDim2
UDim = _G.UDim
Color3 = _G.Color3
Vector2 = _G.Vector2
Enum = _G.Enum
TweenInfo = _G.TweenInfo
ColorSequence = _G.ColorSequence
ColorSequenceKeypoint = _G.ColorSequenceKeypoint
NumberSequence = _G.NumberSequence
NumberSequenceKeypoint = _G.NumberSequenceKeypoint

local Players = {LocalPlayer = {}}
local TweenService = {
    Create = function(object, info, properties)
        return Utils.CreateTween(object, info, properties)
    end
}
local UserInputService = {
    TouchEnabled = false,
    KeyboardEnabled = true,
    InputBegan = {
        Connect = function(func)
            return {Disconnect = function() end}
        end
    },
    InputChanged = {
        Connect = function(func)
            return {Disconnect = function() end}
        end
    },
    InputEnded = {
        Connect = function(func)
            return {Disconnect = function() end}
        end
    }
}
local RunService = {
    Heartbeat = {
        Connect = function(func)
            return {Disconnect = function() end}
        end
    }
}
local HttpService = {
    JSONEncode = function(data) return "{}" end,
    JSONDecode = function(json) return {} end
}
local GuiService = {}
local CoreGui = {}

local Player = Players.LocalPlayer
local PlayerGui = Player

-- Add missing global functions
_G.spawn = function(func)
    func()
end

_G.wait = function(time)
    -- Mock wait function for testing
    return time or 0
end

_G.tick = function()
    -- Mock tick function that returns current time
    return os.clock()
end

_G.warn = function(...)
    -- Mock warn function for testing
    print("WARNING:", ...)
end

spawn = _G.spawn
wait = _G.wait
tick = _G.tick
warn = _G.warn

-- Load modules
local Utils = require("Modules.Utils")
local Theme = require("Modules.Theme")
local Window = require("Modules.Window")
local Notification = require("Modules.Notification")
local KeySystem = require("Modules.KeySystem")
local LoadingScreen = require("Modules.LoadingScreen")
local ConfigManager = require("Modules.ConfigManager")
local DiscordPrompt = require("Modules.DiscordPrompt")
local FloatingButton = require("Modules.FloatingButton")

-- LXAIL Main Library Class
local LXAIL = {}
LXAIL.__index = LXAIL

function LXAIL:new()
    local self = setmetatable({}, LXAIL)
    
    -- Initialize core properties
    self.Windows = {}
    self.Notifications = {}
    self.KeySystemEnabled = false
    self.ConfigManager = ConfigManager:new()
    self.Theme = Theme:new()
    print("Theme initialized:", self.Theme and "SUCCESS" or "FAILED")
    if self.Theme then
        print("Theme GetColor test:", self.Theme:GetColor("Primary"))
    end
    self.FloatingButton = nil
    self.MainScreenGui = nil
    self.KeybindConnection = nil
    self.ShowKeybind = Enum.KeyCode.F
    
    -- Initialize GUI container
    self:InitializeGUI()
    
    return self
end

function LXAIL:InitializeGUI()
    -- Create main ScreenGui
    self.MainScreenGui = Instance.new("ScreenGui")
    self.MainScreenGui.Name = "LXAIL_UI"
    self.MainScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.MainScreenGui.ResetOnSpawn = false
    
    -- Parent to appropriate GUI container
    if gethui then
        self.MainScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(self.MainScreenGui)
        self.MainScreenGui.Parent = CoreGui
    else
        self.MainScreenGui.Parent = CoreGui
    end
    
    -- Setup global keybind
    self:SetupGlobalKeybind()
end

function LXAIL:SetupGlobalKeybind()
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    self.KeybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == self.ShowKeybind then
            self:ToggleUI()
        end
    end)
end

function LXAIL:ToggleUI()
    for _, window in pairs(self.Windows) do
        window:Toggle()
    end
end

function LXAIL:CreateWindow(options)
    local opts = options or {}
    
    -- Show loading screen if specified
    if opts.LoadingTitle or opts.LoadingSubtitle then
        local loadingScreen = LoadingScreen:new(self.MainScreenGui, {
            Title = opts.LoadingTitle or "Loading...",
            Subtitle = opts.LoadingSubtitle or "Please wait..."
        })
        loadingScreen:Show()
        
        -- Auto-hide loading screen after 2 seconds
        wait(2)
        loadingScreen:Hide()
    end
    
    -- Create window instance
    local window = Window:new(self.MainScreenGui, opts, self.Theme)
    table.insert(self.Windows, window)
    
    -- Create floating button if this is the first window
    if #self.Windows == 1 and not self.FloatingButton then
        self.FloatingButton = FloatingButton:new(self.MainScreenGui, self.Theme)
        self.FloatingButton:SetCallback(function()
            self:ToggleUI()
        end)
    end
    
    return window
end

function LXAIL:Notify(options)
    local opts = options or {}
    local notification = Notification:new(self.MainScreenGui, opts, self.Theme)
    table.insert(self.Notifications, notification)
    
    notification:Show()
    
    -- Auto-remove notification after duration
    local duration = opts.Duration or 5
    wait(duration)
    notification:Hide()
    
    -- Remove from notifications table
    for i, notif in ipairs(self.Notifications) do
        if notif == notification then
            table.remove(self.Notifications, i)
            break
        end
    end
end

function LXAIL:CreateKeySystem(options)
    local opts = options or {}
    self.KeySystemEnabled = true
    
    local keySystem = KeySystem:new(self.MainScreenGui, opts, self.Theme)
    
    return keySystem
end

function LXAIL:CreateDiscordPrompt(options)
    local opts = options or {}
    local discordPrompt = DiscordPrompt:new(self.MainScreenGui, opts, self.Theme)
    
    return discordPrompt
end

function LXAIL:SetKeybind(keyCode)
    self.ShowKeybind = keyCode
    self:SetupGlobalKeybind()
end

function LXAIL:SetTheme(themeName)
    self.Theme:SetTheme(themeName)
    
    -- Update all windows with new theme
    for _, window in pairs(self.Windows) do
        window:UpdateTheme(self.Theme)
    end
    
    -- Update floating button
    if self.FloatingButton then
        self.FloatingButton:UpdateTheme(self.Theme)
    end
end

function LXAIL:SaveConfig(configName)
    return self.ConfigManager:SaveConfig(configName or "default")
end

function LXAIL:LoadConfig(configName)
    return self.ConfigManager:LoadConfig(configName or "default")
end

function LXAIL:Destroy()
    -- Disconnect keybind
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    -- Destroy all windows
    for _, window in pairs(self.Windows) do
        window:Destroy()
    end
    
    -- Destroy floating button
    if self.FloatingButton then
        self.FloatingButton:Destroy()
    end
    
    -- Destroy main GUI
    if self.MainScreenGui then
        self.MainScreenGui:Destroy()
    end
    
    -- Clear tables
    self.Windows = {}
    self.Notifications = {}
end

-- Export an instance of the library
return LXAIL:new()
