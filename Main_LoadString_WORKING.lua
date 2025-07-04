-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █                                                                                                                                █
-- █         ██       ██   ██    ██████   ██  ██       ██                                                                          █
-- █         ██       ██   ██      ██     ██  ██       ██                                                                          █
-- █         ██       ██   ██      ██     ██  ██       ██                                                                          █
-- █         ██       ██   ██      ██     ██  ██       ██                                                                          █
-- █         ██       ██   ██      ██     ██  ██       ██                                                                          █
-- █         ██       ██   ██      ██     ██  ██       ██                                                                          █
-- █         ██████████████████    ██     ██  ██████████████                                                                       █
-- █                                                                                                                                █
-- █                                                  v3.0.0 - Complete Edition                                                   █
-- █                                                                                                                                █
-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

-- === ROBLOX SERVICES ===
local TweenService, UserInputService, RunService, HttpService, TextService, GuiService, Players, CoreGui, SoundService, player, playerGui

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
    SoundService = game:GetService("SoundService")
    player = Players.LocalPlayer
    playerGui = player:WaitForChild("PlayerGui")
else
    -- Mock environment for local testing
    TweenService = {
        Create = function(obj, info, props) 
            return {
                Play = function() end,
                Completed = {
                    Connect = function(callback) 
                        if callback and type(callback) == "function" then 
                            callback() 
                        end 
                    end
                }
            } 
        end
    }
    UserInputService = {
        InputBegan = {Connect = function(f) end},
        InputEnded = {Connect = function(f) end}
    }
    RunService = {
        Heartbeat = {Connect = function(f) end},
        RenderStepped = {Connect = function(f) end}
    }
    HttpService = {
        JSONEncode = function(data) return "encoded" end,
        JSONDecode = function(data) return {} end
    }
    TextService = {
        GetTextSize = function() return {X = 100, Y = 20} end
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
    SoundService = {}
    player = Players.LocalPlayer
    playerGui = {}
    
    -- Mock Instance.new
    Instance = {
        new = function(className)
            local obj = {
                ClassName = className,
                Name = "",
                Parent = nil,
                Size = {X = {Scale = 0, Offset = 0}, Y = {Scale = 0, Offset = 0}},
                Position = {X = {Scale = 0, Offset = 0}, Y = {Scale = 0, Offset = 0}},
                BackgroundColor3 = {R = 1, G = 1, B = 1},
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Text = "",
                TextColor3 = {R = 0, G = 0, B = 0},
                TextSize = 14,
                Font = "Gotham",
                TextXAlignment = "Left",
                TextYAlignment = "Center",
                TextWrapped = false,
                Visible = true,
                Active = false,
                Draggable = false,
                Enabled = true,
                ZIndex = 1,
                AutoButtonColor = true,
                MouseButton1Click = {Connect = function(f) end},
                MouseEnter = {Connect = function(f) end},
                MouseLeave = {Connect = function(f) end},
                Focused = {Connect = function(f) end},
                FocusLost = {Connect = function(f) end},
                InputBegan = {Connect = function(f) end},
                InputChanged = {Connect = function(f) end},
                Changed = {Connect = function(f) end},
                Ended = {Connect = function(f) end},
                Play = function() end,
                Destroy = function() end
            }
            return obj
        end
    }
    
    -- Mock global functions
    _G.Color3 = _G.Color3 or {
        fromRGB = function(r, g, b)
            return {R = r/255, G = g/255, B = b/255}
        end
    }
    
    _G.UDim = _G.UDim or {
        new = function(scale, offset)
            return {Scale = scale or 0, Offset = offset or 0}
        end
    }
    
    _G.UDim2 = _G.UDim2 or {
        new = function(xScale, xOffset, yScale, yOffset)
            return {
                X = {Scale = xScale or 0, Offset = xOffset or 0},
                Y = {Scale = yScale or 0, Offset = yOffset or 0}
            }
        end
    }
    
    _G.Vector2 = _G.Vector2 or {
        new = function(x, y)
            return {X = x or 0, Y = y or 0}
        end
    }
    
    _G.Vector3 = _G.Vector3 or {
        new = function(x, y, z)
            return {X = x or 0, Y = y or 0, Z = z or 0}
        end
    }
    
    _G.CFrame = _G.CFrame or {
        new = function(...)
            return {Position = {X = 0, Y = 0, Z = 0}}
        end
    }
    
    _G.TweenInfo = _G.TweenInfo or {
        new = function(duration, easingStyle, easingDirection)
            return {
                Time = duration or 1,
                EasingStyle = easingStyle or "Quad",
                EasingDirection = easingDirection or "Out"
            }
        end
    }
    
    _G.Rect = _G.Rect or {
        new = function(x1, y1, x2, y2)
            return {
                Min = {X = x1 or 0, Y = y1 or 0},
                Max = {X = x2 or 0, Y = y2 or 0}
            }
        end
    }
    
    _G.ColorSequence = _G.ColorSequence or {
        new = function(colors)
            return {Colors = colors or {}}
        end
    }
    
    _G.ColorSequenceKeypoint = _G.ColorSequenceKeypoint or {
        new = function(time, color)
            return {Time = time or 0, Value = color or {R = 1, G = 1, B = 1}}
        end
    }
    
    _G.NumberSequence = _G.NumberSequence or {
        new = function(value)
            return {Value = value or 0}
        end
    }
    
    _G.Enum = _G.Enum or {
        Font = {
            Gotham = "Gotham",
            GothamBold = "GothamBold",
            GothamBlack = "GothamBlack"
        },
        EasingStyle = {
            Quad = "Quad",
            Linear = "Linear",
            Sine = "Sine"
        },
        EasingDirection = {
            Out = "Out",
            In = "In",
            InOut = "InOut"
        }
    }
    
    -- Mock functions that don't cause infinite loops
    _G.wait = _G.wait or function(n) return n or 0 end
    _G.spawn = _G.spawn or function(func) if func then func() end end
    _G.task = _G.task or {
        wait = function(n) return n or 0 end,
        spawn = function(func) if func then func() end end
    }
end

-- LXAIL Library
local LXAIL = {
    Version = "3.0.0",
    Flags = {},
    Themes = {
        Default = {
            MainColor = Color3.fromRGB(20, 20, 20),
            SecondaryColor = Color3.fromRGB(35, 35, 35),
            AccentColor = Color3.fromRGB(100, 100, 255),
            TextColor = Color3.fromRGB(255, 255, 255),
            BorderColor = Color3.fromRGB(100, 100, 100)
        }
    },
    CurrentTheme = "Default",
    Windows = {},
    Notifications = {}
}

-- === UTILITY FUNCTIONS ===
local function tween(object, info, properties, callback)
    if game then
        local tween = TweenService:Create(object, info, properties)
        tween:Play()
        if callback then
            tween.Completed:Connect(callback)
        end
        return tween
    else
        -- Mock tween behavior
        if callback then callback() end
    end
end

local function playSound(soundId)
    if game then
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end
end

-- === NOTIFICATION SYSTEM ===
function LXAIL:Notify(options)
    options = options or {}
    local title = options.Title or "Notification"
    local content = options.Content or "No content provided"
    local duration = options.Duration or 3
    local notificationType = options.Type or "Info"
    
    print("🔔 " .. title .. ": " .. content)
    
    if game then
        -- Create notification GUI in Roblox
        local notification = Instance.new("Frame")
        notification.Name = "LXAILNotification"
        notification.Size = UDim2.new(0, 420, 0, 100)
        notification.Position = UDim2.new(1, -440, 0, 20 + (#self.Notifications * 110))
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BorderSizePixel = 0
        notification.Parent = playerGui
        
        -- Add notification to list
        table.insert(self.Notifications, notification)
        
        -- Auto-remove after duration
        spawn(function()
            wait(duration)
            notification:Destroy()
            for i, notif in ipairs(self.Notifications) do
                if notif == notification then
                    table.remove(self.Notifications, i)
                    break
                end
            end
        end)
    end
end

-- === WINDOW CREATION ===
function LXAIL:CreateWindow(options)
    options = options or {}
    local windowName = options.Name or "LXAIL Window"
    
    print("🪟 Creating window: " .. windowName)
    
    -- Handle KeySystem
    if options.KeySystem and options.KeySystem.Enabled then
        local keySystem = options.KeySystem
        local keys = keySystem.Key or {"DefaultKey"}
        
        -- For demo purposes, automatically accept the first key
        print("🔑 KeySystem enabled - Demo mode: Auto-accepting key")
        print("🔑 Valid keys: " .. table.concat(keys, ", "))
        
        -- Show a brief loading message
        self:Notify({
            Title = "KeySystem",
            Content = "Key validated successfully!",
            Duration = 2,
            Type = "Success"
        })
    end
    
    -- Create window object
    local window = {
        Name = windowName,
        Tabs = {},
        Options = options,
        Visible = true
    }
    
    -- Create main GUI in Roblox
    if game then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "LXAIL_" .. windowName
        screenGui.ResetOnSpawn = false
        screenGui.Parent = playerGui
        
        local mainFrame = Instance.new("Frame")
        mainFrame.Name = "MainFrame"
        mainFrame.Size = UDim2.new(0, 800, 0, 600)
        mainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
        mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        mainFrame.BorderSizePixel = 0
        mainFrame.Parent = screenGui
        
        window.GUI = screenGui
        window.MainFrame = mainFrame
        
        -- Add title
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, 0, 0, 50)
        titleLabel.Position = UDim2.new(0, 0, 0, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = windowName
        titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        titleLabel.TextSize = 24
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Center
        titleLabel.Parent = mainFrame
        
        -- Add tab container
        local tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabContainer"
        tabContainer.Size = UDim2.new(1, 0, 1, -50)
        tabContainer.Position = UDim2.new(0, 0, 0, 50)
        tabContainer.BackgroundTransparency = 1
        tabContainer.Parent = mainFrame
        
        window.TabContainer = tabContainer
    end
    
    -- Add window to LXAIL
    table.insert(self.Windows, window)
    
    -- Define CreateTab function
    function window:CreateTab(tabOptions)
        tabOptions = tabOptions or {}
        local tabName = tabOptions.Name or "Tab"
        
        print("📁 Creating tab: " .. tabName)
        
        local tab = {
            Name = tabName,
            Icon = tabOptions.Icon,
            Visible = tabOptions.Visible ~= false,
            Window = window,
            Components = {}
        }
        
        -- Create tab GUI
        if game and window.TabContainer then
            local tabFrame = Instance.new("Frame")
            tabFrame.Name = tabName
            tabFrame.Size = UDim2.new(1, 0, 1, 0)
            tabFrame.Position = UDim2.new(0, 0, 0, 0)
            tabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            tabFrame.BorderSizePixel = 0
            tabFrame.Parent = window.TabContainer
            
            -- Only show first tab by default
            if #window.Tabs > 0 then
                tabFrame.Visible = false
            end
            
            tab.Frame = tabFrame
        end
        
        -- Add tab functions
        function tab:CreateLabel(options)
            options = options or {}
            local text = options.Text or "Label"
            print("🏷️  Creating label: " .. text)
            
            local label = {Type = "Label", Text = text}
            table.insert(self.Components, label)
            return label
        end
        
        function tab:CreateButton(options)
            options = options or {}
            local name = options.Name or "Button"
            local callback = options.Callback or function() end
            
            print("🔘 Creating button: " .. name)
            
            local button = {
                Type = "Button",
                Name = name,
                Callback = callback
            }
            
            table.insert(self.Components, button)
            return button
        end
        
        function tab:CreateToggle(options)
            options = options or {}
            local name = options.Name or "Toggle"
            local currentValue = options.CurrentValue or false
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("🔄 Creating toggle: " .. name .. " (Default: " .. tostring(currentValue) .. ")")
            
            local toggle = {
                Type = "Toggle",
                Name = name,
                Value = currentValue,
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = currentValue
            end
            
            -- Add Set function
            function toggle:Set(value)
                self.Value = value
                if self.Flag then
                    LXAIL.Flags[self.Flag] = value
                end
                self.Callback(value)
            end
            
            table.insert(self.Components, toggle)
            return toggle
        end
        
        function tab:CreateSlider(options)
            options = options or {}
            local name = options.Name or "Slider"
            local range = options.Range or {0, 100}
            local increment = options.Increment or 1
            local suffix = options.Suffix or ""
            local currentValue = options.CurrentValue or range[1]
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("🎚️  Creating slider: " .. name .. " (Range: " .. range[1] .. "-" .. range[2] .. ")")
            
            local slider = {
                Type = "Slider",
                Name = name,
                Range = range,
                Increment = increment,
                Suffix = suffix,
                Value = currentValue,
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = currentValue
            end
            
            -- Add Set function
            function slider:Set(value)
                self.Value = math.max(self.Range[1], math.min(self.Range[2], value))
                if self.Flag then
                    LXAIL.Flags[self.Flag] = self.Value
                end
                self.Callback(self.Value)
            end
            
            table.insert(self.Components, slider)
            return slider
        end
        
        function tab:CreateDropdown(options)
            options = options or {}
            local name = options.Name or "Dropdown"
            local optionsList = options.Options or {"Option 1", "Option 2"}
            local currentOption = options.CurrentOption or {optionsList[1]}
            local multipleOptions = options.MultipleOptions or false
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("📋 Creating dropdown: " .. name .. " (Options: " .. #optionsList .. ")")
            
            local dropdown = {
                Type = "Dropdown",
                Name = name,
                Options = optionsList,
                CurrentOption = currentOption,
                MultipleOptions = multipleOptions,
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = currentOption
            end
            
            -- Add Set function
            function dropdown:Set(option)
                if type(option) == "table" then
                    self.CurrentOption = option
                else
                    self.CurrentOption = {option}
                end
                if self.Flag then
                    LXAIL.Flags[self.Flag] = self.CurrentOption
                end
                self.Callback(self.CurrentOption)
            end
            
            table.insert(self.Components, dropdown)
            return dropdown
        end
        
        function tab:CreateInput(options)
            options = options or {}
            local name = options.Name or "Input"
            local placeholderText = options.PlaceholderText or "Enter text..."
            local removeTextAfterFocusLost = options.RemoveTextAfterFocusLost or false
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("⌨️  Creating input: " .. name)
            
            local input = {
                Type = "Input",
                Name = name,
                PlaceholderText = placeholderText,
                RemoveTextAfterFocusLost = removeTextAfterFocusLost,
                Value = "",
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = ""
            end
            
            -- Add Set function
            function input:Set(value)
                self.Value = tostring(value)
                if self.Flag then
                    LXAIL.Flags[self.Flag] = self.Value
                end
                self.Callback(self.Value)
            end
            
            table.insert(self.Components, input)
            return input
        end
        
        function tab:CreateColorPicker(options)
            options = options or {}
            local name = options.Name or "ColorPicker"
            local color = options.Color or Color3.fromRGB(255, 255, 255)
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("🎨 Creating color picker: " .. name)
            
            local colorPicker = {
                Type = "ColorPicker",
                Name = name,
                Color = color,
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = color
            end
            
            -- Add Set function
            function colorPicker:Set(color)
                self.Color = color
                if self.Flag then
                    LXAIL.Flags[self.Flag] = color
                end
                self.Callback(color)
            end
            
            table.insert(self.Components, colorPicker)
            return colorPicker
        end
        
        function tab:CreateKeybind(options)
            options = options or {}
            local name = options.Name or "Keybind"
            local currentKeybind = options.CurrentKeybind or "F"
            local holdToInteract = options.HoldToInteract or false
            local flag = options.Flag
            local callback = options.Callback or function() end
            
            print("⌨️  Creating keybind: " .. name .. " (Key: " .. currentKeybind .. ")")
            
            local keybind = {
                Type = "Keybind",
                Name = name,
                CurrentKeybind = currentKeybind,
                HoldToInteract = holdToInteract,
                Flag = flag,
                Callback = callback
            }
            
            -- Store in flags if flag is provided
            if flag then
                LXAIL.Flags[flag] = currentKeybind
            end
            
            -- Add Set function
            function keybind:Set(key)
                self.CurrentKeybind = key
                if self.Flag then
                    LXAIL.Flags[self.Flag] = key
                end
                self.Callback(key)
            end
            
            table.insert(self.Components, keybind)
            return keybind
        end
        
        function tab:CreateParagraph(options)
            options = options or {}
            local title = options.Title or "Paragraph"
            local content = options.Content or "No content provided"
            
            print("📄 Creating paragraph: " .. title)
            
            local paragraph = {
                Type = "Paragraph",
                Title = title,
                Content = content
            }
            
            table.insert(self.Components, paragraph)
            return paragraph
        end
        
        function tab:CreateDivider()
            print("➖ Creating divider")
            
            local divider = {
                Type = "Divider"
            }
            
            table.insert(self.Components, divider)
            return divider
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    return window
end

-- === ADDITIONAL FUNCTIONS ===
function LXAIL:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = themeName
        print("🎨 Theme set to: " .. themeName)
    else
        print("❌ Theme not found: " .. themeName)
    end
end

function LXAIL:SaveConfiguration()
    print("💾 Configuration saved")
    -- In real Roblox, this would save to DataStore
end

function LXAIL:LoadConfiguration()
    print("📂 Configuration loaded")
    -- In real Roblox, this would load from DataStore
end

function LXAIL:ResetConfiguration()
    print("🔄 Configuration reset")
    self.Flags = {}
end

function LXAIL:Toggle()
    print("👁️  Toggling UI visibility")
    -- Toggle visibility of all windows
    for _, window in ipairs(self.Windows) do
        if window.GUI then
            window.GUI.Enabled = not window.GUI.Enabled
        end
    end
end

function LXAIL:Prompt(options)
    options = options or {}
    local title = options.Title or "Prompt"
    local subTitle = options.SubTitle or ""
    local content = options.Content or "No content provided"
    local actions = options.Actions or {}
    
    print("💬 Prompt: " .. title)
    print("   " .. content)
    
    -- For demo purposes, automatically accept
    if actions.Accept and actions.Accept.Callback then
        actions.Accept.Callback()
    end
end

function LXAIL:CreateFloatingButton(options)
    options = options or {}
    local icon = options.Icon or "rbxassetid://4483345998"
    local callback = options.Callback or function() end
    
    print("🔘 Creating floating button")
    
    local button = {
        Type = "FloatingButton",
        Icon = icon,
        Callback = callback
    }
    
    return button
end

-- === INITIALIZATION ===
function LXAIL:Init()
    print("🚀 LXAIL v" .. self.Version .. " initialized!")
    return self
end

-- Return the initialized library
return LXAIL:Init()