-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
-- █                                                                                                                                █
-- █           ██╗     ██╗  ██╗ █████╗ ██╗██╗         ██╗   ██╗██╗    ██╗██╗██████╗ ██████╗  █████╗ ██████╗ ██╗   ██╗           █
-- █           ██║     ╚██╗██╔╝██╔══██╗██║██║         ██║   ██║██║    ██║██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝           █
-- █           ██║      ╚███╔╝ ███████║██║██║         ██║   ██║██║    ██║██║██████╔╝██████╔╝███████║██████╔╝ ╚████╔╝            █
-- █           ██║      ██╔██╗ ██╔══██║██║██║         ██║   ██║██║    ██║██║██╔══██╗██╔══██╗██╔══██║██╔══██╗  ╚██╔╝             █
-- █           ███████╗██╔╝ ██╗██║  ██║██║███████╗    ╚██████╔╝██║    ██║██║██████╔╝██║  ██║██║  ██║██║  ██║   ██║              █
-- █           ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚══════╝     ╚═════╝ ╚═╝    ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝              █
-- █                                                                                                                                █
-- █                                        Rayfield UI Library Replica - Custom LXAIL Design                                     █
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
                Play = function() print("TweenService:Create() - Playing tween") end,
                Completed = {
                    Connect = function(callback) 
                        print("TweenService - Tween completed") 
                        if callback and type(callback) == "function" then 
                            callback() 
                        end 
                    end,
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
    
    -- Mock Enum for compatibility
    _G.Enum = _G.Enum or {
        Font = {
            Gotham = "Gotham",
            GothamBold = "GothamBold",
            GothamBlack = "GothamBlack"
        },
        EasingStyle = {
            Quad = "Quad",
            Linear = "Linear"
        },
        EasingDirection = {
            Out = "Out",
            In = "In"
        },
        UserInputType = {
            MouseButton1 = "MouseButton1",
            Touch = "Touch",
            MouseMovement = "MouseMovement"
        },
        UserInputState = {
            End = "End"
        },
        KeyCode = {
            F = "F"
        },
        TextXAlignment = {
            Left = "Left",
            Center = "Center"
        },
        TextYAlignment = {
            Center = "Center",
            Top = "Top"
        },
        ScaleType = {
            Slice = "Slice"
        }
    }
    
    -- Mock global functions
    _G.wait = _G.wait or function(t) 
        print("Waiting " .. (t or 0) .. " seconds...")
    end
    
    _G.spawn = _G.spawn or function(func)
        print("Spawning function...")
        if func then func() end
    end
    
    -- Mock Instance for compatibility
    _G.Instance = _G.Instance or {
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
                ResetOnSpawn = false,
                Enabled = true,
                IgnoreGuiInset = true,
                ZIndex = 1,
                AutoButtonColor = true,
                MouseButton1Click = {Connect = function(f) print("MouseButton1Click connected") end},
                MouseEnter = {Connect = function(f) print("MouseEnter connected") end},
                MouseLeave = {Connect = function(f) print("MouseLeave connected") end},
                FocusLost = {Connect = function(f) print("FocusLost connected") end},
                InputBegan = {Connect = function(f) print("InputBegan connected") end},
                InputChanged = {Connect = function(f) print("InputChanged connected") end},
                Changed = {Connect = function(f) print("Changed connected") end},
                Ended = {Connect = function(f) print("Ended connected") end},
                Play = function() print("Playing " .. className) end,
                Destroy = function() print("Destroying " .. className) end
            }
            return obj
        end
    }
    
    -- Mock Color3 for compatibility  
    _G.Color3 = _G.Color3 or {
        fromRGB = function(r, g, b)
            return {R = r/255, G = g/255, B = b/255}
        end
    }
    
    -- Mock UDim for compatibility
    _G.UDim = _G.UDim or {
        new = function(scale, offset)
            return {Scale = scale or 0, Offset = offset or 0}
        end
    }
    
    -- Mock UDim2 for compatibility
    _G.UDim2 = _G.UDim2 or {
        new = function(xScale, xOffset, yScale, yOffset)
            return {
                X = {Scale = xScale or 0, Offset = xOffset or 0},
                Y = {Scale = yScale or 0, Offset = yOffset or 0}
            }
        end
    }
    
    -- Mock Vector2 for compatibility
    _G.Vector2 = _G.Vector2 or {
        new = function(x, y)
            return {X = x or 0, Y = y or 0}
        end
    }
    
    -- Mock TweenInfo for compatibility
    _G.TweenInfo = _G.TweenInfo or {
        new = function(duration, easingStyle, easingDirection)
            return {
                Time = duration or 1,
                EasingStyle = easingStyle or "Quad",
                EasingDirection = easingDirection or "Out"
            }
        end
    }
    
    -- Mock Rect for compatibility
    _G.Rect = _G.Rect or {
        new = function(x1, y1, x2, y2)
            return {
                Min = {X = x1 or 0, Y = y1 or 0},
                Max = {X = x2 or 0, Y = y2 or 0}
            }
        end
    }
    
    -- Mock ColorSequence for compatibility
    _G.ColorSequence = _G.ColorSequence or {
        new = function(colors)
            return {Colors = colors or {}}
        end
    }
    
    -- Mock ColorSequenceKeypoint for compatibility
    _G.ColorSequenceKeypoint = _G.ColorSequenceKeypoint or {
        new = function(time, color)
            return {Time = time or 0, Value = color or {R = 1, G = 1, B = 1}}
        end
    }
    
    -- Mock NumberSequence for compatibility
    _G.NumberSequence = _G.NumberSequence or {
        new = function(value)
            return {Value = value or 0}
        end
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
            TertiaryColor = Color3.fromRGB(50, 50, 50),
            AccentColor = Color3.fromRGB(60, 180, 60),
            TextColor = Color3.fromRGB(230, 230, 230),
            SubTextColor = Color3.fromRGB(180, 180, 180),
            ErrorColor = Color3.fromRGB(255, 100, 100),
            WarningColor = Color3.fromRGB(255, 180, 60),
            SuccessColor = Color3.fromRGB(60, 180, 60),
            InfoColor = Color3.fromRGB(100, 150, 255),
            BackgroundTransparency = 0.3,
            ShadowTransparency = 0.85
        }
    },
    CurrentTheme = "Default",
    Notifications = {},
    Configurations = {},
    Windows = {},
    KeySystems = {},
    Sounds = {
        Click = "rbxassetid://421058925",
        Hover = "rbxassetid://421058925",
        Toggle = "rbxassetid://421058925",
        Notification = "rbxassetid://421058925"
    }
}

-- Utility Functions
local function getTheme()
    return LXAIL.Themes[LXAIL.CurrentTheme]
end

local function playSound(soundId)
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createShadow(parent, size, pos, transparency)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.Size = size or UDim2.new(1, 10, 1, 10)
    shadow.Position = pos or UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.ImageTransparency = transparency or getTheme().ShadowTransparency
    shadow.ZIndex = 0
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Parent = parent
    return shadow
end

local function createGradient(parent, colors, rotation, transparency)
    local gradient = Instance.new("UIGradient")
    gradient.Color = colors or ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    }
    gradient.Rotation = rotation or 90
    gradient.Transparency = transparency or NumberSequence.new(0.2)
    gradient.Parent = parent
    return gradient
end

local function tween(object, info, properties, callback)
    local tween = TweenService:Create(object, info, properties)
    tween:Play()
    if callback then
        tween.Completed:Connect(callback)
    end
    return tween
end

local function rippleEffect(button, x, y)
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.Position = UDim2.new(0, x, 0, y)
    ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ripple.BackgroundTransparency = 0.8
    ripple.BorderSizePixel = 0
    ripple.Parent = button
    ripple.ZIndex = 10
    
    createCorner(ripple, 100)
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    tween(ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, size, 0, size),
        Position = UDim2.new(0, x - size/2, 0, y - size/2),
        BackgroundTransparency = 1
    }, function()
        ripple:Destroy()
    end)
end

local function saveConfiguration(configName, data)
    local success, error = pcall(function()
        if not isfolder("LXAIL_Configs") then
            makefolder("LXAIL_Configs")
        end
        writefile("LXAIL_Configs/" .. configName .. ".json", HttpService:JSONEncode(data))
    end)
    return success
end

local function loadConfiguration(configName)
    local success, data = pcall(function()
        if isfile("LXAIL_Configs/" .. configName .. ".json") then
            return HttpService:JSONDecode(readfile("LXAIL_Configs/" .. configName .. ".json"))
        end
        return nil
    end)
    return success and data or nil
end

-- Key System Functions
local function validateKey(keys, inputKey)
    if type(keys) == "string" then
        return inputKey == keys
    elseif type(keys) == "table" then
        for _, key in pairs(keys) do
            if inputKey == key then
                return true
            end
        end
    end
    return false
end

local function getKeyFromSite(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        return response:gsub("%s+", "")
    end
    return nil
end

local function createKeySystem(config)
    local keySystemGui = Instance.new("ScreenGui")
    keySystemGui.Name = "LXAIL_KeySystem"
    keySystemGui.Parent = playerGui
    keySystemGui.IgnoreGuiInset = true
    keySystemGui.ResetOnSpawn = false
    
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.3
    overlay.BorderSizePixel = 0
    overlay.Parent = keySystemGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 450, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
    mainFrame.BackgroundColor3 = getTheme().MainColor
    mainFrame.BackgroundTransparency = getTheme().BackgroundTransparency
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = keySystemGui
    
    createCorner(mainFrame, 12)
    createShadow(mainFrame)
    createGradient(mainFrame)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 60)
    titleLabel.Position = UDim2.new(0, 0, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "Key System"
    titleLabel.TextColor3 = getTheme().TextColor
    titleLabel.TextSize = 28
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = mainFrame
    
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 0, 0, 70)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = config.Subtitle or "Enter your key to continue"
    subtitleLabel.TextColor3 = getTheme().SubTextColor
    subtitleLabel.TextSize = 16
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.Parent = mainFrame
    
    local noteLabel = Instance.new("TextLabel")
    noteLabel.Name = "Note"
    noteLabel.Size = UDim2.new(1, -40, 0, 80)
    noteLabel.Position = UDim2.new(0, 20, 0, 110)
    noteLabel.BackgroundTransparency = 1
    noteLabel.Text = config.Note or "Get your key from the website or Discord server"
    noteLabel.TextColor3 = getTheme().SubTextColor
    noteLabel.TextSize = 14
    noteLabel.Font = Enum.Font.Gotham
    noteLabel.TextWrapped = true
    noteLabel.Parent = mainFrame
    
    local keyInput = Instance.new("TextBox")
    keyInput.Name = "KeyInput"
    keyInput.Size = UDim2.new(1, -40, 0, 45)
    keyInput.Position = UDim2.new(0, 20, 0, 200)
    keyInput.BackgroundColor3 = getTheme().SecondaryColor
    keyInput.BackgroundTransparency = 0.2
    keyInput.BorderSizePixel = 0
    keyInput.PlaceholderText = "Enter key here..."
    keyInput.PlaceholderColor3 = getTheme().SubTextColor
    keyInput.Text = ""
    keyInput.TextColor3 = getTheme().TextColor
    keyInput.TextSize = 16
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextXAlignment = Enum.TextXAlignment.Left
    keyInput.Parent = mainFrame
    
    createCorner(keyInput, 8)
    
    local keyInputBorder = Instance.new("Frame")
    keyInputBorder.Name = "Border"
    keyInputBorder.Size = UDim2.new(1, 2, 1, 2)
    keyInputBorder.Position = UDim2.new(0, -1, 0, -1)
    keyInputBorder.BackgroundColor3 = getTheme().AccentColor
    keyInputBorder.BackgroundTransparency = 0.8
    keyInputBorder.BorderSizePixel = 0
    keyInputBorder.Parent = keyInput
    keyInputBorder.ZIndex = keyInput.ZIndex - 1
    
    createCorner(keyInputBorder, 8)
    
    local validateButton = Instance.new("TextButton")
    validateButton.Name = "ValidateButton"
    validateButton.Size = UDim2.new(0, 150, 0, 40)
    validateButton.Position = UDim2.new(0, 20, 0, 270)
    validateButton.BackgroundColor3 = getTheme().AccentColor
    validateButton.BorderSizePixel = 0
    validateButton.Text = "Validate Key"
    validateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    validateButton.TextSize = 16
    validateButton.Font = Enum.Font.GothamBold
    validateButton.AutoButtonColor = false
    validateButton.Parent = mainFrame
    
    createCorner(validateButton, 8)
    
    local getKeyButton = Instance.new("TextButton")
    getKeyButton.Name = "GetKeyButton"
    getKeyButton.Size = UDim2.new(0, 150, 0, 40)
    getKeyButton.Position = UDim2.new(1, -170, 0, 270)
    getKeyButton.BackgroundColor3 = getTheme().SecondaryColor
    getKeyButton.BorderSizePixel = 0
    getKeyButton.Text = "Get Key"
    getKeyButton.TextColor3 = getTheme().TextColor
    getKeyButton.TextSize = 16
    getKeyButton.Font = Enum.Font.GothamBold
    getKeyButton.AutoButtonColor = false
    getKeyButton.Parent = mainFrame
    
    createCorner(getKeyButton, 8)
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -40, 0, 25)
    statusLabel.Position = UDim2.new(0, 20, 0, 320)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = getTheme().SubTextColor
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = mainFrame
    
    -- Load saved key
    if config.SaveKey then
        local savedKey = loadConfiguration(config.FileName or "LXAIL_Key")
        if savedKey and savedKey.key then
            keyInput.Text = savedKey.key
            statusLabel.Text = "Saved key loaded"
            statusLabel.TextColor3 = getTheme().SuccessColor
        end
    end
    
    -- Button hover effects
    validateButton.MouseEnter:Connect(function()
        tween(validateButton, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().AccentColor:lerp(Color3.fromRGB(255, 255, 255), 0.2)})
    end)
    
    validateButton.MouseLeave:Connect(function()
        tween(validateButton, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().AccentColor})
    end)
    
    getKeyButton.MouseEnter:Connect(function()
        tween(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().SecondaryColor:lerp(Color3.fromRGB(255, 255, 255), 0.1)})
    end)
    
    getKeyButton.MouseLeave:Connect(function()
        tween(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().SecondaryColor})
    end)
    
    -- Input focus effects
    keyInput.Focused:Connect(function()
        tween(keyInputBorder, TweenInfo.new(0.2), {BackgroundTransparency = 0.4})
    end)
    
    keyInput.FocusLost:Connect(function()
        tween(keyInputBorder, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
    end)
    
    -- Button events
    validateButton.MouseButton1Click:Connect(function()
        local inputKey = keyInput.Text
        local isValid = false
        
        playSound(LXAIL.Sounds.Click)
        statusLabel.Text = "Validating key..."
        statusLabel.TextColor3 = getTheme().WarningColor
        
        -- Ripple effect
        local mouse = game.Players.LocalPlayer:GetMouse()
        local relativeX = mouse.X - validateButton.AbsolutePosition.X
        local relativeY = mouse.Y - validateButton.AbsolutePosition.Y
        rippleEffect(validateButton, relativeX, relativeY)
        
        wait(1)
        
        if config.GrabKeyFromSite and config.Keysite then
            local siteKey = getKeyFromSite(config.Keysite)
            if siteKey and inputKey == siteKey then
                isValid = true
            end
        else
            isValid = validateKey(config.Key or {}, inputKey)
        end
        
        if isValid then
            statusLabel.Text = "Key validated successfully!"
            statusLabel.TextColor3 = getTheme().SuccessColor
            
            if config.SaveKey then
                saveConfiguration(config.FileName or "LXAIL_Key", {key = inputKey})
            end
            
            wait(1)
            keySystemGui:Destroy()
            return true
        else
            statusLabel.Text = "Invalid key. Please try again."
            statusLabel.TextColor3 = getTheme().ErrorColor
            keyInput.Text = ""
            
            -- Shake animation
            local originalPos = mainFrame.Position
            for i = 1, 3 do
                tween(mainFrame, TweenInfo.new(0.1), {Position = originalPos + UDim2.new(0, 5, 0, 0)})
                wait(0.1)
                tween(mainFrame, TweenInfo.new(0.1), {Position = originalPos + UDim2.new(0, -5, 0, 0)})
                wait(0.1)
            end
            tween(mainFrame, TweenInfo.new(0.1), {Position = originalPos})
        end
    end)
    
    getKeyButton.MouseButton1Click:Connect(function()
        playSound(LXAIL.Sounds.Click)
        
        if config.GrabKeyFromSite and config.Keysite then
            setclipboard(config.Keysite)
            statusLabel.Text = "Key site URL copied to clipboard!"
            statusLabel.TextColor3 = getTheme().SuccessColor
        elseif config.Discord and config.Discord.Enabled then
            setclipboard(config.Discord.Invite)
            statusLabel.Text = "Discord link copied to clipboard!"
            statusLabel.TextColor3 = getTheme().SuccessColor
        else
            statusLabel.Text = "No key source available"
            statusLabel.TextColor3 = getTheme().ErrorColor
        end
    end)
    
    -- Make draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Enter key validation
    keyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            validateButton.MouseButton1Click:Fire()
        end
    end)
    
    return keySystemGui
end

-- Notification System
function LXAIL:Notify(config)
    local notificationGui = Instance.new("ScreenGui")
    notificationGui.Name = "LXAIL_Notification"
    notificationGui.Parent = playerGui
    notificationGui.IgnoreGuiInset = true
    notificationGui.ResetOnSpawn = false
    
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 420, 0, 100)
    notification.Position = UDim2.new(1, 10, 0, 100 + (#self.Notifications * 110))
    notification.BackgroundColor3 = getTheme().MainColor
    notification.BackgroundTransparency = 0.05
    notification.BorderSizePixel = 0
    notification.Parent = notificationGui
    
    createCorner(notification, 12)
    createShadow(notification, UDim2.new(1, 20, 1, 20), UDim2.new(0, -10, 0, -10), 0.7)
    createGradient(notification, ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 25, 25)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15))
    }, 45)
    
    local colorAccent = Instance.new("Frame")
    colorAccent.Name = "ColorAccent"
    colorAccent.Size = UDim2.new(0, 6, 1, 0)
    colorAccent.Position = UDim2.new(0, 0, 0, 0)
    colorAccent.BorderSizePixel = 0
    colorAccent.Parent = notification
    
    local accentColor = getTheme().AccentColor
    if config.Type == "Error" then
        accentColor = getTheme().ErrorColor
    elseif config.Type == "Warning" then
        accentColor = getTheme().WarningColor
    elseif config.Type == "Info" then
        accentColor = getTheme().InfoColor
    elseif config.Type == "Success" then
        accentColor = getTheme().SuccessColor
    end
    
    colorAccent.BackgroundColor3 = accentColor
    createCorner(colorAccent, 2)
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Name = "Icon"
    iconLabel.Size = UDim2.new(0, 50, 0, 50)
    iconLabel.Position = UDim2.new(0, 18, 0, 25)
    iconLabel.BackgroundTransparency = 1
    iconLabel.TextColor3 = accentColor
    iconLabel.TextSize = 28
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.TextYAlignment = Enum.TextYAlignment.Center
    iconLabel.Parent = notification
    
    local iconText = "ℹ"
    if config.Type == "Error" then
        iconText = "❌"
    elseif config.Type == "Warning" then
        iconText = "⚠"
    elseif config.Type == "Success" then
        iconText = "✅"
    end
    iconLabel.Text = iconText
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -120, 0, 35)
    titleLabel.Position = UDim2.new(0, 75, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.Title or "Notification"
    titleLabel.TextColor3 = getTheme().TextColor
    titleLabel.TextSize = 20
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Top
    titleLabel.Parent = notification
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, -120, 0, 35)
    contentLabel.Position = UDim2.new(0, 75, 0, 48)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = config.Content or "Content"
    contentLabel.TextColor3 = getTheme().SubTextColor
    contentLabel.TextSize = 15
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.Parent = notification
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -35, 0, 10)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = getTheme().SubTextColor
    closeButton.TextSize = 20
    closeButton.Font = Enum.Font.GothamBold
    closeButton.AutoButtonColor = false
    closeButton.Parent = notification
    
    table.insert(self.Notifications, {gui = notificationGui, frame = notification})
    
    -- Slide in animation
    tween(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -430, 0, 100 + ((#self.Notifications - 1) * 110))
    })
    
    -- Auto close
    local duration = config.Duration or 5
    local closeConnection
    
    local function closeNotification()
        if closeConnection then
            closeConnection:Disconnect()
        end
        
        -- Remove from table
        for i, notif in ipairs(self.Notifications) do
            if notif.gui == notificationGui then
                table.remove(self.Notifications, i)
                break
            end
        end
        
        -- Reposition other notifications
        for i, notif in ipairs(self.Notifications) do
            tween(notif.frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(1, -430, 0, 100 + ((i - 1) * 110))
            })
        end
        
        tween(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 10, 0, notification.Position.Y.Offset),
            BackgroundTransparency = 1
        }, function()
            notificationGui:Destroy()
        end)
    end
    
    closeButton.MouseButton1Click:Connect(closeNotification)
    
    closeButton.MouseEnter:Connect(function()
        tween(closeButton, TweenInfo.new(0.2), {TextColor3 = getTheme().ErrorColor})
    end)
    
    closeButton.MouseLeave:Connect(function()
        tween(closeButton, TweenInfo.new(0.2), {TextColor3 = getTheme().SubTextColor})
    end)
    
    if duration > 0 then
        if game then
            closeConnection = game:GetService("Debris"):AddItem(notificationGui, duration)
        end
        spawn(function()
            wait(duration)
            closeNotification()
        end)
    end
    
    -- Play notification sound
    playSound(LXAIL.Sounds.Notification)
    
    return notificationGui
end

-- Window Creation
function LXAIL:CreateWindow(config)
    local window = {
        Tabs = {},
        CurrentTab = nil,
        Visible = true,
        Flags = {},
        Config = config
    }
    
    -- Handle key system
    if config.KeySystem and config.KeySystem.Enabled then
        local keySystemGui = createKeySystem(config.KeySystem)
        repeat
            wait()
        until not keySystemGui.Parent
    end
    
    -- Create main GUI
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "LXAIL_UI"
    mainGui.Parent = playerGui
    mainGui.IgnoreGuiInset = true
    mainGui.ResetOnSpawn = false
    mainGui.Enabled = true
    
    -- Background frame
    local bg = Instance.new("Frame")
    bg.Name = "MainContainer"
    bg.Size = UDim2.new(0, 800, 0, 600)
    bg.Position = UDim2.new(0.5, -400, 0.5, -300)
    bg.BackgroundColor3 = getTheme().MainColor
    bg.BackgroundTransparency = getTheme().BackgroundTransparency
    bg.AnchorPoint = Vector2.new(0, 0)
    bg.BorderSizePixel = 0
    bg.Parent = mainGui
    
    createCorner(bg, 12)
    createShadow(bg)
    createGradient(bg)
    
    -- Animated title
    local titleText = config.Name or "LXAIL - BETA"
    local startPosTitle = UDim2.new(0, 60, 0, 10)
    local letterSpacing = 22
    local letters = {}
    
    for i = 1, #titleText do
        local char = titleText:sub(i, i)
        local letterLabel = Instance.new("TextLabel")
        letterLabel.Parent = bg
        letterLabel.BackgroundTransparency = 1
        letterLabel.Text = char
        letterLabel.Font = Enum.Font.GothamBlack
        letterLabel.TextSize = 28
        letterLabel.TextColor3 = getTheme().TextColor
        letterLabel.Size = UDim2.new(0, 20, 0, 40)
        letterLabel.Position = startPosTitle + UDim2.new(0, (i-1)*letterSpacing, 0, 0)
        letterLabel.TextXAlignment = Enum.TextXAlignment.Center
        letterLabel.TextYAlignment = Enum.TextYAlignment.Center
        letterLabel.TextTransparency = 1
        letters[#letters+1] = letterLabel
    end
    
    local function animateLetters()
        local fadeInInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local fadeOutInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        
        spawn(function()
            while mainGui.Parent and window.Visible do
                for _, letter in ipairs(letters) do
                    if mainGui.Parent and window.Visible then
                        TweenService:Create(letter, fadeInInfo, {TextTransparency = 0}):Play()
                        wait(0.1)
                    end
                end
                wait(0.6)
                for _, letter in ipairs(letters) do
                    if mainGui.Parent and window.Visible then
                        TweenService:Create(letter, fadeOutInfo, {TextTransparency = 1}):Play()
                        wait(0.1)
                    end
                end
                wait(0.6)
            end
        end)
    end
    
    animateLetters()
    
    -- Close button
    local closeButton = Instance.new("TextButton")
    closeButton.Text = "✕"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextSize = 24
    closeButton.TextColor3 = getTheme().TextColor
    closeButton.BackgroundTransparency = 1
    closeButton.Position = UDim2.new(1, -45, 0, 10)
    closeButton.Size = UDim2.new(0, 35, 0, 35)
    closeButton.ZIndex = 2
    closeButton.AutoButtonColor = false
    closeButton.Parent = bg
    
    closeButton.MouseEnter:Connect(function()
        tween(closeButton, TweenInfo.new(0.15), {TextColor3 = getTheme().ErrorColor})
    end)
    
    closeButton.MouseLeave:Connect(function()
        tween(closeButton, TweenInfo.new(0.15), {TextColor3 = getTheme().TextColor})
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        playSound(LXAIL.Sounds.Click)
        mainGui.Enabled = false
        window.Visible = false
    end)
    
    -- Minimize button
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Text = "_"
    minimizeButton.Font = Enum.Font.GothamBold
    minimizeButton.TextSize = 24
    minimizeButton.TextColor3 = getTheme().TextColor
    minimizeButton.BackgroundTransparency = 1
    minimizeButton.Position = UDim2.new(1, -85, 0, 10)
    minimizeButton.Size = UDim2.new(0, 35, 0, 35)
    minimizeButton.ZIndex = 2
    minimizeButton.AutoButtonColor = false
    minimizeButton.Parent = bg
    
    minimizeButton.MouseEnter:Connect(function()
        tween(minimizeButton, TweenInfo.new(0.15), {TextColor3 = getTheme().WarningColor})
    end)
    
    minimizeButton.MouseLeave:Connect(function()
        tween(minimizeButton, TweenInfo.new(0.15), {TextColor3 = getTheme().TextColor})
    end)
    
    minimizeButton.MouseButton1Click:Connect(function()
        playSound(LXAIL.Sounds.Click)
        local isMinimized = bg.Size.Y.Offset <= 60
        
        if isMinimized then
            tween(bg, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 800, 0, 600)})
            minimizeButton.Text = "_"
        else
            tween(bg, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 800, 0, 60)})
            minimizeButton.Text = "□"
        end
    end)
    
    -- Drag bar
    local dragBar = Instance.new("Frame")
    dragBar.BackgroundTransparency = 1
    dragBar.Size = UDim2.new(1, 0, 0, 50)
    dragBar.Position = UDim2.new(0, 0, 0, 0)
    dragBar.ZIndex = 10
    dragBar.Parent = bg
    
    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.BackgroundColor3 = getTheme().SecondaryColor
    sidebar.BackgroundTransparency = 0.25
    sidebar.Size = UDim2.new(0, 200, 1, -50)
    sidebar.Position = UDim2.new(0, 0, 0, 43)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = bg
    
    createCorner(sidebar, 10)
    
    local sidebarLayout = Instance.new("UIListLayout")
    sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sidebarLayout.Padding = UDim.new(0, 8)
    sidebarLayout.Parent = sidebar
    
    -- Content area
    local content = Instance.new("Frame")
    content.BackgroundColor3 = getTheme().TertiaryColor
    content.BackgroundTransparency = 0.3
    content.Size = UDim2.new(1, -210, 1, -60)
    content.Position = UDim2.new(0, 210, 0, 55)
    content.BorderSizePixel = 0
    content.Parent = bg
    
    createCorner(content, 10)
    
    -- Profile section
    local profileSection = Instance.new("Frame")
    profileSection.BackgroundColor3 = getTheme().SecondaryColor
    profileSection.BackgroundTransparency = 0.25
    profileSection.Size = UDim2.new(1, 0, 0, 70)
    profileSection.BorderSizePixel = 0
    profileSection.LayoutOrder = 1000
    profileSection.Parent = sidebar
    
    createCorner(profileSection, 10)
    
    local avatar = Instance.new("ImageLabel")
    avatar.Size = UDim2.new(0, 45, 0, 45)
    avatar.Position = UDim2.new(0, 10, 0, 12)
    avatar.BackgroundTransparency = 1
    avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..player.UserId.."&width=420&height=420&format=png"
    avatar.Parent = profileSection
    
    createCorner(avatar, 45)
    
    local playerName = Instance.new("TextLabel")
    playerName.Text = player.DisplayName
    playerName.Font = Enum.Font.GothamBold
    playerName.TextSize = 16
    playerName.TextColor3 = getTheme().TextColor
    playerName.BackgroundTransparency = 1
    playerName.Position = UDim2.new(0, 65, 0, 15)
    playerName.Size = UDim2.new(1, -75, 0, 20)
    playerName.TextXAlignment = Enum.TextXAlignment.Left
    playerName.Parent = profileSection
    
    local playerUsername = Instance.new("TextLabel")
    playerUsername.Text = "@" .. player.Name
    playerUsername.Font = Enum.Font.Gotham
    playerUsername.TextSize = 12
    playerUsername.TextColor3 = getTheme().SubTextColor
    playerUsername.BackgroundTransparency = 1
    playerUsername.Position = UDim2.new(0, 65, 0, 35)
    playerUsername.Size = UDim2.new(1, -75, 0, 20)
    playerUsername.TextXAlignment = Enum.TextXAlignment.Left
    playerUsername.Parent = profileSection
    
    -- Make window draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        bg.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = bg.Position
            
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
            update(input)
        end
    end)
    
    -- Toggle key
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.F then
            window.Visible = not window.Visible
            mainGui.Enabled = window.Visible
        end
    end)
    
    -- Create floating toggle button
    local buttonGui = Instance.new("ScreenGui")
    buttonGui.Name = "LXAIL_ToggleButton"
    buttonGui.Parent = playerGui
    buttonGui.IgnoreGuiInset = true
    buttonGui.ResetOnSpawn = false
    
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Image = "rbxassetid://100710776166961"
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 20, 0, 200)
    toggleButton.BackgroundTransparency = 1
    toggleButton.ZIndex = 1000
    toggleButton.Parent = buttonGui
    
    createCorner(toggleButton, 12)
    
    -- Toggle button functionality
    local buttonDragging = false
    local buttonDragInput, buttonDragStart, buttonStartPos
    
    local function updateButton(input)
        local delta = input.Position - buttonDragStart
        toggleButton.Position = UDim2.new(buttonStartPos.X.Scale, buttonStartPos.X.Offset + delta.X, buttonStartPos.Y.Scale, buttonStartPos.Y.Offset + delta.Y)
    end
    
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            buttonDragging = true
            buttonDragStart = input.Position
            buttonStartPos = toggleButton.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    buttonDragging = false
                end
            end)
        end
    end)
    
    toggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            buttonDragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == buttonDragInput and buttonDragging then
            updateButton(input)
        end
    end)
    
    toggleButton.MouseButton1Click:Connect(function()
        playSound(LXAIL.Sounds.Click)
        window.Visible = not window.Visible
        mainGui.Enabled = window.Visible
        
        -- Button click animation
        tween(toggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 40, 0, 40)})
        tween(toggleButton, TweenInfo.new(0.1), {Size = UDim2.new(0, 50, 0, 50)})
    end)
    
    -- Tab creation function
    function window:CreateTab(config)
        local tab = {
            Name = config.Name or "Tab",
            Icon = config.Icon,
            Visible = config.Visible ~= false,
            Elements = {}
        }
        
        -- Create tab button
        local tabButton = Instance.new("TextButton")
        tabButton.Name = "Tab"
        tabButton.Text = tab.Name
        tabButton.Font = Enum.Font.GothamBold
        tabButton.TextSize = 16
        tabButton.TextColor3 = getTheme().TextColor
        tabButton.BackgroundColor3 = getTheme().SecondaryColor
        tabButton.BackgroundTransparency = 0.3
        tabButton.Size = UDim2.new(1, -10, 0, 45)
        tabButton.BorderSizePixel = 0
        tabButton.AutoButtonColor = false
        tabButton.LayoutOrder = #self.Tabs + 1
        tabButton.Parent = sidebar
        
        createCorner(tabButton, 8)
        
        -- Tab icon
        if tab.Icon then
            local iconLabel = Instance.new("ImageLabel")
            iconLabel.Name = "Icon"
            iconLabel.Size = UDim2.new(0, 20, 0, 20)
            iconLabel.Position = UDim2.new(0, 10, 0, 12)
            iconLabel.BackgroundTransparency = 1
            iconLabel.Image = tab.Icon
            iconLabel.ImageColor3 = getTheme().TextColor
            iconLabel.Parent = tabButton
            
            -- Adjust text position
            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "Text"
            textLabel.Text = tab.Name
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 16
            textLabel.TextColor3 = getTheme().TextColor
            textLabel.BackgroundTransparency = 1
            textLabel.Position = UDim2.new(0, 35, 0, 0)
            textLabel.Size = UDim2.new(1, -45, 1, 0)
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.Parent = tabButton
            
            tabButton.Text = ""
        end
        
        -- Create tab content
        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = tab.Name .. "Content"
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Visible = false
        tabContent.BorderSizePixel = 0
        tabContent.ScrollBarThickness = 8
        tabContent.ScrollingDirection = Enum.ScrollingDirection.Y
        tabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarImageColor3 = getTheme().AccentColor
        tabContent.Parent = content
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        contentLayout.Parent = tabContent
        
        local contentPadding = Instance.new("UIPadding")
        contentPadding.PaddingTop = UDim.new(0, 10)
        contentPadding.PaddingBottom = UDim.new(0, 10)
        contentPadding.PaddingLeft = UDim.new(0, 10)
        contentPadding.PaddingRight = UDim.new(0, 10)
        contentPadding.Parent = tabContent
        
        -- Tab selection
        tabButton.MouseButton1Click:Connect(function()
            playSound(LXAIL.Sounds.Click)
            
            -- Update tab appearances
            for _, existingTab in pairs(self.Tabs) do
                existingTab.Button.BackgroundColor3 = getTheme().SecondaryColor
                existingTab.Button.BackgroundTransparency = 0.3
                existingTab.Content.Visible = false
            end
            
            -- Activate current tab
            tabButton.BackgroundColor3 = getTheme().AccentColor
            tabButton.BackgroundTransparency = 0.1
            tabContent.Visible = true
            self.CurrentTab = tab
            
            -- Tab switch animation
            tween(tabContent, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                BackgroundTransparency = 0,
                Position = UDim2.new(0, 0, 0, 0)
            })
        end)
        
        -- Hover effects
        tabButton.MouseEnter:Connect(function()
            if self.CurrentTab ~= tab then
                tween(tabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.1})
            end
        end)
        
        tabButton.MouseLeave:Connect(function()
            if self.CurrentTab ~= tab then
                tween(tabButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.3})
            end
        end)
        
        tab.Button = tabButton
        tab.Content = tabContent
        table.insert(self.Tabs, tab)
        
        -- Auto-select first tab
        if #self.Tabs == 1 then
            tabButton.MouseButton1Click:Fire()
        end
        
        -- Element creation functions
        function tab:CreateLabel(config)
            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Text = config.Text or "Label"
            label.Font = Enum.Font.GothamBold
            label.TextSize = config.TextSize or 18
            label.TextColor3 = config.TextColor or getTheme().TextColor
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(0.95, 0, 0, 40)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.TextWrapped = true
            label.LayoutOrder = #self.Elements + 1
            label.Parent = tabContent
            
            table.insert(self.Elements, label)
            return label
        end
        
        function tab:CreateButton(config)
            local buttonFrame = Instance.new("Frame")
            buttonFrame.Name = "ButtonFrame"
            buttonFrame.BackgroundColor3 = getTheme().TertiaryColor
            buttonFrame.BackgroundTransparency = 0.3
            buttonFrame.Size = UDim2.new(0.95, 0, 0, 50)
            buttonFrame.BorderSizePixel = 0
            buttonFrame.LayoutOrder = #self.Elements + 1
            buttonFrame.Parent = tabContent
            
            createCorner(buttonFrame, 8)
            createShadow(buttonFrame)
            
            local buttonLabel = Instance.new("TextLabel")
            buttonLabel.Name = "Label"
            buttonLabel.Text = config.Name or "Button"
            buttonLabel.Font = Enum.Font.GothamBold
            buttonLabel.TextSize = 18
            buttonLabel.TextColor3 = getTheme().TextColor
            buttonLabel.BackgroundTransparency = 1
            buttonLabel.Position = UDim2.new(0, 15, 0, 0)
            buttonLabel.Size = UDim2.new(0.7, -15, 1, 0)
            buttonLabel.TextXAlignment = Enum.TextXAlignment.Left
            buttonLabel.Parent = buttonFrame
            
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Text = config.Text or "Click"
            button.Font = Enum.Font.GothamBold
            button.TextSize = 16
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.BackgroundColor3 = getTheme().AccentColor
            button.Size = UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(1, -110, 0.5, -15)
            button.BorderSizePixel = 0
            button.AutoButtonColor = false
            button.Parent = buttonFrame
            
            createCorner(button, 6)
            
            button.MouseEnter:Connect(function()
                playSound(LXAIL.Sounds.Hover)
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().AccentColor:lerp(Color3.fromRGB(255, 255, 255), 0.2)})
            end)
            
            button.MouseLeave:Connect(function()
                tween(button, TweenInfo.new(0.2), {BackgroundColor3 = getTheme().AccentColor})
            end)
            
            button.MouseButton1Click:Connect(function()
                playSound(LXAIL.Sounds.Click)
                
                -- Ripple effect
                local relativeX = mouse.X - button.AbsolutePosition.X
                local relativeY = mouse.Y - button.AbsolutePosition.Y
                rippleEffect(button, relativeX, relativeY)
                
                if config.Callback then
                    config.Callback()
                end
            end)
            
            table.insert(self.Elements, buttonFrame)
            return buttonFrame
        end
        
        function tab:CreateToggle(config)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Name = "ToggleFrame"
            toggleFrame.BackgroundColor3 = getTheme().TertiaryColor
            toggleFrame.BackgroundTransparency = 0.3
            toggleFrame.Size = UDim2.new(0.95, 0, 0, 50)
            toggleFrame.BorderSizePixel = 0
            toggleFrame.LayoutOrder = #self.Elements + 1
            toggleFrame.Parent = tabContent
            
            createCorner(toggleFrame, 8)
            createShadow(toggleFrame)
            
            local toggleLabel = Instance.new("TextLabel")
            toggleLabel.Name = "Label"
            toggleLabel.Text = config.Name or "Toggle"
            toggleLabel.Font = Enum.Font.GothamBold
            toggleLabel.TextSize = 18
            toggleLabel.TextColor3 = getTheme().TextColor
            toggleLabel.BackgroundTransparency = 1
            toggleLabel.Position = UDim2.new(0, 15, 0, 0)
            toggleLabel.Size = UDim2.new(0.7, -15, 1, 0)
            toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            toggleLabel.Parent = toggleFrame
            
            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle"
            toggle.Text = ""
            toggle.Size = UDim2.new(0, 50, 0, 26)
            toggle.Position = UDim2.new(1, -65, 0.5, -13)
            toggle.BackgroundColor3 = getTheme().ErrorColor
            toggle.BorderSizePixel = 0
            toggle.AutoButtonColor = false
            toggle.Parent = toggleFrame
            
            createCorner(toggle, 13)
            
            local circle = Instance.new("Frame")
            circle.Name = "Circle"
            circle.Size = UDim2.new(0, 22, 0, 22)
            circle.Position = UDim2.new(0, 2, 0, 2)
            circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            circle.BorderSizePixel = 0
            circle.Parent = toggle
            
            createCorner(circle, 11)
            
            local icon = Instance.new("TextLabel")
            icon.Name = "Icon"
            icon.Size = UDim2.new(1, 0, 1, 0)
            icon.BackgroundTransparency = 1
            icon.Text = ""
            icon.TextColor3 = getTheme().AccentColor
            icon.Font = Enum.Font.GothamBold
            icon.TextSize = 12
            icon.Parent = circle
            
            local currentValue = config.CurrentValue or false
            local flag = config.Flag
            
            if flag then
                LXAIL.Flags[flag] = currentValue
            end
            
            local function updateToggle(value)
                currentValue = value
                
                if flag then
                    LXAIL.Flags[flag] = value
                end
                
                local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                
                if value then
                    tween(circle, tweenInfo, {Position = UDim2.new(1, -24, 0, 2)})
                    tween(toggle, tweenInfo, {BackgroundColor3 = getTheme().AccentColor})
                    icon.Text = "✓"
                else
                    tween(circle, tweenInfo, {Position = UDim2.new(0, 2, 0, 2)})
                    tween(toggle, tweenInfo, {BackgroundColor3 = getTheme().ErrorColor})
                    icon.Text = ""
                end
                
                if config.Callback then
                    config.Callback(value)
                end
            end
            
            toggle.MouseButton1Click:Connect(function()
                playSound(LXAIL.Sounds.Toggle)
                updateToggle(not currentValue)
            end)
            
            toggle.MouseEnter:Connect(function()
                tween(toggle, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
            end)
            
            toggle.MouseLeave:Connect(function()
                tween(toggle, TweenInfo.new(0.2), {BackgroundTransparency = 0})
            end)
            
            -- Initialize
            updateToggle(currentValue)
            
            table.insert(self.Elements, toggleFrame)
            return toggleFrame
        end
        
        function tab:CreateSlider(config)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Name = "SliderFrame"
            sliderFrame.BackgroundColor3 = getTheme().TertiaryColor
            sliderFrame.BackgroundTransparency = 0.3
            sliderFrame.Size = UDim2.new(0.95, 0, 0, 60)
            sliderFrame.BorderSizePixel = 0
            sliderFrame.LayoutOrder = #self.Elements + 1
            sliderFrame.Parent = tabContent
            
            createCorner(sliderFrame, 8)
            createShadow(sliderFrame)
            
            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Name = "Label"
            sliderLabel.Text = config.Name or "Slider"
            sliderLabel.Font = Enum.Font.GothamBold
            sliderLabel.TextSize = 16
            sliderLabel.TextColor3 = getTheme().TextColor
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Position = UDim2.new(0, 15, 0, 5)
            sliderLabel.Size = UDim2.new(0.6, -15, 0, 20)
            sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
            sliderLabel.Parent = sliderFrame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Name = "ValueLabel"
            valueLabel.Text = tostring(config.CurrentValue or config.Min or 0)
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 14
            valueLabel.TextColor3 = getTheme().AccentColor
            valueLabel.BackgroundTransparency = 1
            valueLabel.Position = UDim2.new(0.6, 0, 0, 5)
            valueLabel.Size = UDim2.new(0.4, -15, 0, 20)
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = sliderFrame
            
            local sliderBG = Instance.new("Frame")
            sliderBG.Name = "SliderBG"
            sliderBG.Size = UDim2.new(1, -30, 0, 6)
            sliderBG.Position = UDim2.new(0, 15, 0, 35)
            sliderBG.BackgroundColor3 = getTheme().SecondaryColor
            sliderBG.BorderSizePixel = 0
            sliderBG.Parent = sliderFrame
            
            createCorner(sliderBG, 3)
            
            local sliderFG = Instance.new("Frame")
            sliderFG.Name = "SliderFG"
            sliderFG.Size = UDim2.new(0, 0, 1, 0)
            sliderFG.BackgroundColor3 = getTheme().AccentColor
            sliderFG.BorderSizePixel = 0
            sliderFG.Parent = sliderBG
            
            createCorner(sliderFG, 3)
            
            local knob = Instance.new("Frame")
            knob.Name = "Knob"
            knob.Size = UDim2.new(0, 16, 0, 16)
            knob.Position = UDim2.new(0, -8, 0.5, -8)
            knob.AnchorPoint = Vector2.new(0.5, 0.5)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.BorderSizePixel = 0
            knob.Parent = sliderBG
            
            createCorner(knob, 8)
            createShadow(knob, UDim2.new(1, 4, 1, 4), UDim2.new(0, -2, 0, -2), 0.6)
            
            local min = config.Min or 0
            local max = config.Max or 100
            local currentValue = config.CurrentValue or min
            local increment = config.Increment or 1
            local suffix = config.Suffix or ""
            local flag = config.Flag
            
            if flag then
                LXAIL.Flags[flag] = currentValue
            end
            
            local dragging = false
            
            local function updateSlider(value)
                value = math.clamp(value, min, max)
                
                if increment > 0 then
                    value = math.floor(value / increment) * increment
                end
                
                currentValue = value
                
                if flag then
                    LXAIL.Flags[flag] = value
                end
                
                local percentage = (value - min) / (max - min)
                
                tween(sliderFG, TweenInfo.new(0.1), {Size = UDim2.new(percentage, 0, 1, 0)})
                tween(knob, TweenInfo.new(0.1), {Position = UDim2.new(percentage, 0, 0.5, -8)})
                
                valueLabel.Text = tostring(value) .. suffix
                
                if config.Callback then
                    config.Callback(value)
                end
            end
            
            local function handleInput(input)
                if not dragging then return end
                
                local relativeX = math.clamp(input.Position.X - sliderBG.AbsolutePosition.X, 0, sliderBG.AbsoluteSize.X)
                local percentage = relativeX / sliderBG.AbsoluteSize.X
                local value = min + (max - min) * percentage
                
                updateSlider(value)
            end
            
            sliderBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    handleInput(input)
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    handleInput(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)
            
            -- Initialize
            updateSlider(currentValue)
            
            table.insert(self.Elements, sliderFrame)
            return sliderFrame
        end
        
        function tab:CreateInput(config)
            local inputFrame = Instance.new("Frame")
            inputFrame.Name = "InputFrame"
            inputFrame.BackgroundColor3 = getTheme().TertiaryColor
            inputFrame.BackgroundTransparency = 0.3
            inputFrame.Size = UDim2.new(0.95, 0, 0, 60)
            inputFrame.BorderSizePixel = 0
            inputFrame.LayoutOrder = #self.Elements + 1
            inputFrame.Parent = tabContent
            
            createCorner(inputFrame, 8)
            createShadow(inputFrame)
            
            local inputLabel = Instance.new("TextLabel")
            inputLabel.Name = "Label"
            inputLabel.Text = config.Name or "Input"
            inputLabel.Font = Enum.Font.GothamBold
            inputLabel.TextSize = 16
            inputLabel.TextColor3 = getTheme().TextColor
            inputLabel.BackgroundTransparency = 1
            inputLabel.Position = UDim2.new(0, 15, 0, 5)
            inputLabel.Size = UDim2.new(1, -30, 0, 20)
            inputLabel.TextXAlignment = Enum.TextXAlignment.Left
            inputLabel.Parent = inputFrame
            
            local input = Instance.new("TextBox")
            input.Name = "Input"
            input.Size = UDim2.new(1, -30, 0, 25)
            input.Position = UDim2.new(0, 15, 0, 28)
            input.BackgroundColor3 = getTheme().SecondaryColor
            input.BackgroundTransparency = 0.2
            input.BorderSizePixel = 0
            input.PlaceholderText = config.PlaceholderText or "Enter text..."
            input.PlaceholderColor3 = getTheme().SubTextColor
            input.Text = config.Text or ""
            input.TextColor3 = getTheme().TextColor
            input.TextSize = 14
            input.Font = Enum.Font.Gotham
            input.TextXAlignment = Enum.TextXAlignment.Left
            input.Parent = inputFrame
            
            createCorner(input, 4)
            
            local inputBorder = Instance.new("Frame")
            inputBorder.Name = "Border"
            inputBorder.Size = UDim2.new(1, 2, 1, 2)
            inputBorder.Position = UDim2.new(0, -1, 0, -1)
            inputBorder.BackgroundColor3 = getTheme().AccentColor
            inputBorder.BackgroundTransparency = 0.8
            inputBorder.BorderSizePixel = 0
            inputBorder.Parent = input
            inputBorder.ZIndex = input.ZIndex - 1
            
            createCorner(inputBorder, 4)
            
            local flag = config.Flag
            
            if flag then
                LXAIL.Flags[flag] = input.Text
            end
            
            input.Focused:Connect(function()
                tween(inputBorder, TweenInfo.new(0.2), {BackgroundTransparency = 0.4})
            end)
            
            input.FocusLost:Connect(function(enterPressed)
                tween(inputBorder, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
                
                if flag then
                    LXAIL.Flags[flag] = input.Text
                end
                
                if config.Callback then
                    config.Callback(input.Text)
                end
            end)
            
            table.insert(self.Elements, inputFrame)
            return inputFrame
        end
        
        function tab:CreateDropdown(config)
            local dropdownFrame = Instance.new("Frame")
            dropdownFrame.Name = "DropdownFrame"
            dropdownFrame.BackgroundColor3 = getTheme().TertiaryColor
            dropdownFrame.BackgroundTransparency = 0.3
            dropdownFrame.Size = UDim2.new(0.95, 0, 0, 50)
            dropdownFrame.BorderSizePixel = 0
            dropdownFrame.LayoutOrder = #self.Elements + 1
            dropdownFrame.Parent = tabContent
            
            createCorner(dropdownFrame, 8)
            createShadow(dropdownFrame)
            
            local dropdownLabel = Instance.new("TextLabel")
            dropdownLabel.Name = "Label"
            dropdownLabel.Text = config.Name or "Dropdown"
            dropdownLabel.Font = Enum.Font.GothamBold
            dropdownLabel.TextSize = 16
            dropdownLabel.TextColor3 = getTheme().TextColor
            dropdownLabel.BackgroundTransparency = 1
            dropdownLabel.Position = UDim2.new(0, 15, 0, 5)
            dropdownLabel.Size = UDim2.new(0.6, -15, 0, 20)
            dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
            dropdownLabel.Parent = dropdownFrame
            
            local dropdown = Instance.new("TextButton")
            dropdown.Name = "Dropdown"
            dropdown.Text = config.CurrentOption or "Select..."
            dropdown.Font = Enum.Font.Gotham
            dropdown.TextSize = 14
            dropdown.TextColor3 = getTheme().TextColor
            dropdown.BackgroundColor3 = getTheme().SecondaryColor
            dropdown.BackgroundTransparency = 0.2
            dropdown.Size = UDim2.new(0.4, -15, 0, 25)
            dropdown.Position = UDim2.new(0.6, 0, 0, 20)
            dropdown.BorderSizePixel = 0
            dropdown.AutoButtonColor = false
            dropdown.Parent = dropdownFrame
            
            createCorner(dropdown, 4)
            
            local arrow = Instance.new("TextLabel")
            arrow.Name = "Arrow"
            arrow.Text = "▼"
            arrow.Font = Enum.Font.Gotham
            arrow.TextSize = 12
            arrow.TextColor3 = getTheme().SubTextColor
            arrow.BackgroundTransparency = 1
            arrow.Position = UDim2.new(1, -20, 0, 0)
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Parent = dropdown
            
            local optionsList = Instance.new("Frame")
            optionsList.Name = "OptionsList"
            optionsList.BackgroundColor3 = getTheme().SecondaryColor
            optionsList.BackgroundTransparency = 0.1
            optionsList.Size = UDim2.new(1, 0, 0, 0)
            optionsList.Position = UDim2.new(0, 0, 1, 2)
            optionsList.BorderSizePixel = 0
            optionsList.Visible = false
            optionsList.ZIndex = 100
            optionsList.Parent = dropdown
            
            createCorner(optionsList, 4)
            createShadow(optionsList, UDim2.new(1, 6, 1, 6), UDim2.new(0, -3, 0, -3), 0.7)
            
            local optionsLayout = Instance.new("UIListLayout")
            optionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            optionsLayout.Parent = optionsList
            
            local currentOption = config.CurrentOption or ""
            local options = config.Options or {}
            local isOpen = false
            local flag = config.Flag
            
            if flag then
                LXAIL.Flags[flag] = currentOption
            end
            
            local function updateDropdown(option)
                currentOption = option
                dropdown.Text = option
                
                if flag then
                    LXAIL.Flags[flag] = option
                end
                
                if config.Callback then
                    config.Callback(option)
                end
            end
            
            local function toggleDropdown()
                isOpen = not isOpen
                
                if isOpen then
                    optionsList.Visible = true
                    optionsList.Size = UDim2.new(1, 0, 0, #options * 30)
                    tween(arrow, TweenInfo.new(0.2), {Rotation = 180})
                    tween(optionsList, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 0.1
                    })
                else
                    tween(arrow, TweenInfo.new(0.2), {Rotation = 0})
                    tween(optionsList, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                        BackgroundTransparency = 1
                    }, function()
                        optionsList.Visible = false
                        optionsList.Size = UDim2.new(1, 0, 0, 0)
                    end)
                end
            end
            
            dropdown.MouseButton1Click:Connect(function()
                playSound(LXAIL.Sounds.Click)
                toggleDropdown()
            end)
            
            -- Create option buttons
            for i, option in ipairs(options) do
                local optionButton = Instance.new("TextButton")
                optionButton.Name = "Option" .. i
                optionButton.Text = option
                optionButton.Font = Enum.Font.Gotham
                optionButton.TextSize = 14
                optionButton.TextColor3 = getTheme().TextColor
                optionButton.BackgroundColor3 = getTheme().SecondaryColor
                optionButton.BackgroundTransparency = 0.8
                optionButton.Size = UDim2.new(1, 0, 0, 30)
                optionButton.BorderSizePixel = 0
                optionButton.AutoButtonColor = false
                optionButton.LayoutOrder = i
                optionButton.Parent = optionsList
                
                optionButton.MouseEnter:Connect(function()
                    tween(optionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.4})
                end)
                
                optionButton.MouseLeave:Connect(function()
                    tween(optionButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.8})
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    playSound(LXAIL.Sounds.Click)
                    updateDropdown(option)
                    toggleDropdown()
                end)
            end
            
            table.insert(self.Elements, dropdownFrame)
            return dropdownFrame
        end
        
        function tab:CreateColorPicker(config)
            local colorFrame = Instance.new("Frame")
            colorFrame.Name = "ColorFrame"
            colorFrame.BackgroundColor3 = getTheme().TertiaryColor
            colorFrame.BackgroundTransparency = 0.3
            colorFrame.Size = UDim2.new(0.95, 0, 0, 50)
            colorFrame.BorderSizePixel = 0
            colorFrame.LayoutOrder = #self.Elements + 1
            colorFrame.Parent = tabContent
            
            createCorner(colorFrame, 8)
            createShadow(colorFrame)
            
            local colorLabel = Instance.new("TextLabel")
            colorLabel.Name = "Label"
            colorLabel.Text = config.Name or "Color Picker"
            colorLabel.Font = Enum.Font.GothamBold
            colorLabel.TextSize = 16
            colorLabel.TextColor3 = getTheme().TextColor
            colorLabel.BackgroundTransparency = 1
            colorLabel.Position = UDim2.new(0, 15, 0, 0)
            colorLabel.Size = UDim2.new(0.7, -15, 1, 0)
            colorLabel.TextXAlignment = Enum.TextXAlignment.Left
            colorLabel.Parent = colorFrame
            
            local colorDisplay = Instance.new("Frame")
            colorDisplay.Name = "ColorDisplay"
            colorDisplay.Size = UDim2.new(0, 30, 0, 30)
            colorDisplay.Position = UDim2.new(1, -45, 0.5, -15)
            colorDisplay.BackgroundColor3 = config.Color or getTheme().AccentColor
            colorDisplay.BorderSizePixel = 0
            colorDisplay.Parent = colorFrame
            
            createCorner(colorDisplay, 4)
            
            local colorButton = Instance.new("TextButton")
            colorButton.Name = "ColorButton"
            colorButton.Text = ""
            colorButton.Size = UDim2.new(1, 0, 1, 0)
            colorButton.BackgroundTransparency = 1
            colorButton.Parent = colorDisplay
            
            local currentColor = config.Color or getTheme().AccentColor
            local flag = config.Flag
            
            if flag then
                LXAIL.Flags[flag] = currentColor
            end
            
            colorButton.MouseButton1Click:Connect(function()
                playSound(LXAIL.Sounds.Click)
                
                -- Create color picker window (simplified)
                local colorPickerGui = Instance.new("ScreenGui")
                colorPickerGui.Name = "ColorPicker"
                colorPickerGui.Parent = playerGui
                
                local colorPickerFrame = Instance.new("Frame")
                colorPickerFrame.Size = UDim2.new(0, 300, 0, 200)
                colorPickerFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
                colorPickerFrame.BackgroundColor3 = getTheme().MainColor
                colorPickerFrame.BorderSizePixel = 0
                colorPickerFrame.Parent = colorPickerGui
                
                createCorner(colorPickerFrame, 8)
                createShadow(colorPickerFrame)
                
                local closeBtn = Instance.new("TextButton")
                closeBtn.Text = "×"
                closeBtn.Size = UDim2.new(0, 30, 0, 30)
                closeBtn.Position = UDim2.new(1, -35, 0, 5)
                closeBtn.BackgroundTransparency = 1
                closeBtn.TextColor3 = getTheme().TextColor
                closeBtn.TextSize = 18
                closeBtn.Font = Enum.Font.GothamBold
                closeBtn.Parent = colorPickerFrame
                
                closeBtn.MouseButton1Click:Connect(function()
                    colorPickerGui:Destroy()
                end)
                
                -- Simple color selection (you can expand this)
                local colors = {
                    Color3.fromRGB(255, 0, 0),
                    Color3.fromRGB(0, 255, 0),
                    Color3.fromRGB(0, 0, 255),
                    Color3.fromRGB(255, 255, 0),
                    Color3.fromRGB(255, 0, 255),
                    Color3.fromRGB(0, 255, 255),
                    Color3.fromRGB(255, 255, 255),
                    Color3.fromRGB(0, 0, 0)
                }
                
                for i, color in ipairs(colors) do
                    local colorOption = Instance.new("TextButton")
                    colorOption.Size = UDim2.new(0, 30, 0, 30)
                    colorOption.Position = UDim2.new(0, 10 + ((i-1) % 4) * 35, 0, 40 + math.floor((i-1) / 4) * 35)
                    colorOption.BackgroundColor3 = color
                    colorOption.BorderSizePixel = 0
                    colorOption.Text = ""
                    colorOption.Parent = colorPickerFrame
                    
                    createCorner(colorOption, 4)
                    
                    colorOption.MouseButton1Click:Connect(function()
                        currentColor = color
                        colorDisplay.BackgroundColor3 = color
                        
                        if flag then
                            LXAIL.Flags[flag] = color
                        end
                        
                        if config.Callback then
                            config.Callback(color)
                        end
                        
                        colorPickerGui:Destroy()
                    end)
                end
            end)
            
            table.insert(self.Elements, colorFrame)
            return colorFrame
        end
        
        function tab:CreateSection(config)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = "SectionFrame"
            sectionFrame.BackgroundColor3 = getTheme().TertiaryColor
            sectionFrame.BackgroundTransparency = 0.5
            sectionFrame.Size = UDim2.new(0.95, 0, 0, 30)
            sectionFrame.BorderSizePixel = 0
            sectionFrame.LayoutOrder = #self.Elements + 1
            sectionFrame.Parent = tabContent
            
            createCorner(sectionFrame, 6)
            
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Name = "SectionLabel"
            sectionLabel.Text = config.Name or "Section"
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 16
            sectionLabel.TextColor3 = getTheme().AccentColor
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Size = UDim2.new(1, 0, 1, 0)
            sectionLabel.Parent = sectionFrame
            
            table.insert(self.Elements, sectionFrame)
            return sectionFrame
        end
        
        function tab:CreateKeybind(config)
            local keybindFrame = Instance.new("Frame")
            keybindFrame.Name = "KeybindFrame"
            keybindFrame.BackgroundColor3 = getTheme().TertiaryColor
            keybindFrame.BackgroundTransparency = 0.3
            keybindFrame.Size = UDim2.new(0.95, 0, 0, 50)
            keybindFrame.BorderSizePixel = 0
            keybindFrame.LayoutOrder = #self.Elements + 1
            keybindFrame.Parent = tabContent
            
            createCorner(keybindFrame, 8)
            createShadow(keybindFrame)
            
            local keybindLabel = Instance.new("TextLabel")
            keybindLabel.Name = "Label"
            keybindLabel.Text = config.Name or "Keybind"
            keybindLabel.Font = Enum.Font.GothamBold
            keybindLabel.TextSize = 16
            keybindLabel.TextColor3 = getTheme().TextColor
            keybindLabel.BackgroundTransparency = 1
            keybindLabel.Position = UDim2.new(0, 15, 0, 0)
            keybindLabel.Size = UDim2.new(0.6, -15, 1, 0)
            keybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            keybindLabel.Parent = keybindFrame
            
            local keybindButton = Instance.new("TextButton")
            keybindButton.Name = "KeybindButton"
            keybindButton.Text = config.CurrentKeybind or "None"
            keybindButton.Font = Enum.Font.GothamBold
            keybindButton.TextSize = 14
            keybindButton.TextColor3 = getTheme().TextColor
            keybindButton.BackgroundColor3 = getTheme().SecondaryColor
            keybindButton.BackgroundTransparency = 0.2
            keybindButton.Size = UDim2.new(0, 80, 0, 25)
            keybindButton.Position = UDim2.new(1, -95, 0.5, -12)
            keybindButton.BorderSizePixel = 0
            keybindButton.AutoButtonColor = false
            keybindButton.Parent = keybindFrame
            
            createCorner(keybindButton, 4)
            
            local currentKeybind = config.CurrentKeybind or "None"
            local flag = config.Flag
            local listening = false
            
            if flag then
                LXAIL.Flags[flag] = currentKeybind
            end
            
            local function updateKeybind(keyCode)
                currentKeybind = keyCode.Name
                keybindButton.Text = currentKeybind
                
                if flag then
                    LXAIL.Flags[flag] = currentKeybind
                end
            end
            
            keybindButton.MouseButton1Click:Connect(function()
                if listening then return end
                
                listening = true
                keybindButton.Text = "Press a key..."
                keybindButton.BackgroundColor3 = getTheme().WarningColor
                
                local connection
                connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if gameProcessed then return end
                    
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        updateKeybind(input.KeyCode)
                        keybindButton.BackgroundColor3 = getTheme().SecondaryColor
                        listening = false
                        connection:Disconnect()
                    end
                end)
            end)
            
            -- Listen for keybind activation
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if gameProcessed or listening then return end
                
                if input.KeyCode.Name == currentKeybind and currentKeybind ~= "None" then
                    if config.Callback then
                        config.Callback()
                    end
                end
            end)
            
            table.insert(self.Elements, keybindFrame)
            return keybindFrame
        end
        
        return tab
    end
    
    -- Configuration system
    function window:SaveConfiguration()
        if self.Config.ConfigurationSaving and self.Config.ConfigurationSaving.Enabled then
            local configData = {
                Flags = LXAIL.Flags,
                Theme = LXAIL.CurrentTheme,
                WindowVisible = self.Visible
            }
            
            saveConfiguration(self.Config.ConfigurationSaving.FileName, configData)
            
            LXAIL:Notify({
                Title = "Configuration Saved",
                Content = "Settings saved successfully!",
                Type = "Success",
                Duration = 3
            })
        end
    end
    
    function window:LoadConfiguration()
        if self.Config.ConfigurationSaving and self.Config.ConfigurationSaving.Enabled then
            local configData = loadConfiguration(self.Config.ConfigurationSaving.FileName)
            
            if configData then
                if configData.Flags then
                    for flag, value in pairs(configData.Flags) do
                        LXAIL.Flags[flag] = value
                    end
                end
                
                if configData.Theme then
                    LXAIL.CurrentTheme = configData.Theme
                end
                
                if configData.WindowVisible ~= nil then
                    self.Visible = configData.WindowVisible
                    mainGui.Enabled = self.Visible
                end
                
                LXAIL:Notify({
                    Title = "Configuration Loaded",
                    Content = "Settings loaded successfully!",
                    Type = "Success",
                    Duration = 3
                })
            end
        end
    end
    
    -- Auto-save configuration
    if window.Config.ConfigurationSaving and window.Config.ConfigurationSaving.Enabled then
        spawn(function()
            while mainGui.Parent do
                window:SaveConfiguration()
                wait(30) -- Auto-save every 30 seconds
            end
        end)
        
        -- Load configuration on startup
        window:LoadConfiguration()
    end
    
    -- Store window reference
    table.insert(LXAIL.Windows, window)
    
    return window
end

-- Loading screen
function LXAIL:ShowLoadingScreen(config)
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "LXAIL_Loading"
    loadingGui.Parent = playerGui
    loadingGui.IgnoreGuiInset = true
    loadingGui.ResetOnSpawn = false
    
    local overlay = Instance.new("Frame")
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.2
    overlay.BorderSizePixel = 0
    overlay.Parent = loadingGui
    
    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 400, 0, 200)
    loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    loadingFrame.BackgroundColor3 = getTheme().MainColor
    loadingFrame.BackgroundTransparency = 0.1
    loadingFrame.BorderSizePixel = 0
    loadingFrame.Parent = loadingGui
    
    createCorner(loadingFrame, 12)
    createShadow(loadingFrame)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.Position = UDim2.new(0, 0, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = config.LoadingTitle or "Loading LXAIL..."
    titleLabel.TextColor3 = getTheme().TextColor
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = loadingFrame
    
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(1, 0, 0, 30)
    subtitleLabel.Position = UDim2.new(0, 0, 0, 70)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = config.LoadingSubtitle or "Please wait..."
    subtitleLabel.TextColor3 = getTheme().SubTextColor
    subtitleLabel.TextSize = 16
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.Parent = loadingFrame
    
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(1, -60, 0, 6)
    progressBar.Position = UDim2.new(0, 30, 0, 120)
    progressBar.BackgroundColor3 = getTheme().SecondaryColor
    progressBar.BorderSizePixel = 0
    progressBar.Parent = loadingFrame
    
    createCorner(progressBar, 3)
    
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = getTheme().AccentColor
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar
    
    createCorner(progressFill, 3)
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0, 140)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Initializing..."
    statusLabel.TextColor3 = getTheme().SubTextColor
    statusLabel.TextSize = 14
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = loadingFrame
    
    -- Animate progress
    local loadingSteps = {
        {text = "Loading UI components...", progress = 0.2},
        {text = "Initializing systems...", progress = 0.4},
        {text = "Setting up configuration...", progress = 0.6},
        {text = "Preparing interface...", progress = 0.8},
        {text = "Ready!", progress = 1.0}
    }
    
    spawn(function()
        for i, step in ipairs(loadingSteps) do
            statusLabel.Text = step.text
            tween(progressFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
                Size = UDim2.new(step.progress, 0, 1, 0)
            })
            wait(0.6)
        end
        
        wait(0.5)
        
        tween(loadingFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        
        tween(overlay, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        }, function()
            loadingGui:Destroy()
        end)
    end)
    
    return loadingGui
end

-- Initialize LXAIL
function LXAIL:Init()
    -- Show loading screen
    if self.ShowLoading then
        self:ShowLoadingScreen({
            LoadingTitle = "LXAIL UI Library",
            LoadingSubtitle = "Loading interface..."
        })
    end
    
    -- Initialize notification system
    self.Notifications = {}
    
    -- Set up theme
    self.CurrentTheme = "Default"
    
    -- Welcome notification
    self:Notify({
        Title = "LXAIL UI Library",
        Content = "Welcome to LXAIL v" .. self.Version .. "!",
        Type = "Success",
        Duration = 4
    })
    
    return self
end

-- Return library
return LXAIL:Init()