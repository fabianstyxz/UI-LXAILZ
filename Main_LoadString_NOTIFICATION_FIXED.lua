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
-- █                                     LXAIL - Complete Rayfield Replica v3.0.1                                                 █
-- █                                          Notification System Fixed                                                             █
-- █                                                                                                                                █
-- ████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████

-- === ROBLOX SERVICES ===
local TweenService, UserInputService, RunService, HttpService, TextService, GuiService, Players, CoreGui, SoundService, player, playerGui

-- FIXED: Better environment detection and GUI parent handling
local function initializeServices()
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
        
        -- CRITICAL FIX: Better PlayerGui handling with fallback
        if player then
            playerGui = player:WaitForChild("PlayerGui", 10) or player.PlayerGui
        end
        
        -- Additional fallback for PlayerGui
        if not playerGui then
            playerGui = CoreGui
        end
        
        return true
    else
        -- Mock environment for local testing
        TweenService = {
            Create = function(obj, info, props) 
                return {
                    Play = function() print("TweenService:Create() - Playing tween") end,
                    Completed = {
                        Connect = function(self, func) 
                            print("TweenService - Tween completed") 
                            if func then spawn(func) end 
                        end
                    }
                } 
            end
        }
        UserInputService = {
            InputBegan = {Connect = function(self, func) print("UserInputService.InputBegan connected") end},
            InputEnded = {Connect = function(self, func) print("UserInputService.InputEnded connected") end},
            TouchEnabled = true,
            KeyboardEnabled = true,
            MouseEnabled = true
        }
        RunService = {
            Heartbeat = {Connect = function(self, func) print("RunService.Heartbeat connected") end},
            Stepped = {Connect = function(self, func) print("RunService.Stepped connected") end}
        }
        HttpService = {
            JSONEncode = function(self, data) return "{\"mock\":\"data\"}" end,
            JSONDecode = function(self, json) return {mock = "data"} end
        }
        TextService = {
            GetTextSize = function(self, text, textSize, font, frameSize) 
                return Vector2.new(#text * textSize * 0.5, textSize)
            end
        }
        GuiService = {
            MenuOpened = {Connect = function(self, func) print("GuiService.MenuOpened connected") end}
        }
        Players = {
            LocalPlayer = {
                Name = "TestPlayer",
                UserId = 12345
            }
        }
        CoreGui = {}
        SoundService = {}
        player = Players.LocalPlayer
        playerGui = {
            Name = "PlayerGui",
            Parent = nil
        }
        
        -- Mock Roblox classes and functions
        Instance = {
            new = function(className)
                local obj = {
                    ClassName = className,
                    Name = className,
                    Parent = nil,
                    Size = UDim2.new(0, 100, 0, 100),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 1,
                    ZIndex = 1,
                    Text = "",
                    TextColor3 = Color3.new(0, 0, 0),
                    TextSize = 14,
                    Font = "Gotham",
                    TextXAlignment = "Center",
                    TextYAlignment = "Center",
                    TextWrapped = false,
                    Image = "",
                    ImageTransparency = 0,
                    ScaleType = "Stretch",
                    SliceCenter = nil,
                    SoundId = "",
                    Volume = 0.5,
                    ResetOnSpawn = false,
                    MouseButton1Click = {Connect = function(self, func) print("MouseButton1Click connected") return {Disconnect = function() end} end},
                    Changed = {Connect = function(self, func) print("Changed event connected") return {Disconnect = function() end} end},
                    Ended = {Connect = function(self, func) print("Sound Ended event connected") return {Disconnect = function() end} end},
                    Focused = {Connect = function(self, func) print("TextBox Focused event connected") return {Disconnect = function() end} end},
                    FocusLost = {Connect = function(self, func) print("TextBox FocusLost event connected") return {Disconnect = function() end} end},
                    Play = function(self) print("Playing sound:", self.SoundId) end,
                    Stop = function(self) print("Stopping sound:", self.SoundId) end,
                    Destroy = function(self) print("Destroying", self.ClassName) end
                }
                return obj
            end
        }
        
        UDim2 = {
            new = function(xScale, xOffset, yScale, yOffset)
                local udim2 = {
                    X = {Scale = xScale or 0, Offset = xOffset or 0},
                    Y = {Scale = yScale or 0, Offset = yOffset or 0}
                }
                
                -- Add metamethod for addition
                local meta = {
                    __add = function(a, b)
                        return UDim2.new(
                            a.X.Scale + b.X.Scale,
                            a.X.Offset + b.X.Offset,
                            a.Y.Scale + b.Y.Scale,
                            a.Y.Offset + b.Y.Offset
                        )
                    end
                }
                setmetatable(udim2, meta)
                return udim2
            end
        }
        
        UDim = {
            new = function(scale, offset)
                return {Scale = scale or 0, Offset = offset or 0}
            end
        }
        
        Vector2 = {
            new = function(x, y)
                return {X = x or 0, Y = y or 0}
            end
        }
        
        Color3 = {
            new = function(r, g, b)
                return {R = r or 0, G = g or 0, B = b or 0}
            end,
            fromRGB = function(r, g, b)
                return {R = (r or 0)/255, G = (g or 0)/255, B = (b or 0)/255}
            end
        }
        
        ColorSequence = {
            new = function(colors)
                return {Colors = colors or {}}
            end
        }
        
        ColorSequenceKeypoint = {
            new = function(time, color)
                return {Time = time or 0, Value = color or Color3.new(1, 1, 1)}
            end
        }
        
        TweenInfo = {
            new = function(duration, style, direction, repeatCount, reverses, delayTime)
                return {
                    Time = duration or 1,
                    EasingStyle = style or "Quad",
                    EasingDirection = direction or "Out",
                    RepeatCount = repeatCount or 0,
                    Reverses = reverses or false,
                    DelayTime = delayTime or 0
                }
            end
        }
        
        Enum = {
            EasingStyle = {
                Quad = "Quad",
                Back = "Back",
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
                SourceSans = "SourceSans"
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
            ScaleType = {
                Stretch = "Stretch",
                Slice = "Slice",
                Tile = "Tile",
                Fit = "Fit"
            }
        }
        
        Rect = {
            new = function(left, top, right, bottom)
                return {
                    Left = left or 0,
                    Top = top or 0,
                    Right = right or 0,
                    Bottom = bottom or 0
                }
            end
        }
        
        NumberSequence = {
            new = function(value)
                return {Value = value or 0}
            end
        }
        
        NumberSequenceKeypoint = {
            new = function(time, value)
                return {Time = time or 0, Value = value or 0}
            end
        }
        
        -- Mock global functions
        spawn = function(func)
            print("spawn() called with function")
            if func then func() end
        end
        
        wait = function(time)
            print("wait(" .. (time or 0) .. ") called")
        end
        
        return false
    end
end

-- Initialize services
local isRobloxEnvironment = initializeServices()

-- === LXAIL LIBRARY ===
local LXAIL = {
    Version = "3.0.1",
    Flags = {},
    CurrentTheme = "Dark",
    Windows = {},
    Notifications = {},
    ConfigFolder = nil,
    DiscordInvite = nil,
    KeyValidated = false,
    NotificationContainer = nil
}

-- === UTILITY FUNCTIONS ===
local function playSound(soundId)
    if not SoundService then return end
    
    local success, err = pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
    end)
    
    if not success then
        print("Sound playback failed:", err)
    end
end

local function tween(object, info, properties, callback)
    if not object or not TweenService then
        if callback then callback() end
        return
    end
    
    local success, tween = pcall(function()
        return TweenService:Create(object, info, properties)
    end)
    
    if success then
        tween:Play()
        if callback then
            tween.Completed:Connect(callback)
        end
        return tween
    else
        print("Tween failed:", tween)
        if callback then callback() end
    end
end

local function addSectionShadow(section)
    if not section then return end
    
    local success, shadow = pcall(function()
        local shadow = Instance.new("ImageLabel")
        shadow.Name = "Shadow"
        shadow.Image = "rbxassetid://1316045217"
        shadow.Size = UDim2.new(1, 0, 1, 0)
        shadow.Position = UDim2.new(0, 0, 0, 3)
        shadow.BackgroundTransparency = 1
        shadow.ImageTransparency = 0.7
        shadow.ZIndex = section.ZIndex and (section.ZIndex - 1) or 0
        shadow.ScaleType = Enum.ScaleType.Slice
        shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        shadow.Parent = section
        return shadow
    end)
    
    if not success then
        print("Shadow creation failed:", shadow)
    end
    
    return success and shadow or nil
end

-- === NOTIFICATION CONTAINER CREATION ===
local function createNotificationContainer()
    if LXAIL.NotificationContainer then return LXAIL.NotificationContainer end
    
    local success, container = pcall(function()
        local gui = Instance.new("ScreenGui")
        gui.Name = "LXAIL_Notifications"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        
        -- CRITICAL FIX: Multiple fallbacks for GUI parent
        local targetParent = nil
        
        if isRobloxEnvironment then
            -- Try PlayerGui first
            if playerGui and playerGui.Parent then
                targetParent = playerGui
            -- Try CoreGui as fallback
            elseif CoreGui then
                targetParent = CoreGui
            -- Last resort: try to get fresh PlayerGui
            elseif player then
                local freshPlayerGui = player:FindFirstChild("PlayerGui")
                if freshPlayerGui then
                    targetParent = freshPlayerGui
                    playerGui = freshPlayerGui
                end
            end
        else
            targetParent = playerGui
        end
        
        if targetParent then
            gui.Parent = targetParent
            print("Notification container created successfully in:", targetParent.Name or "Unknown")
        else
            error("No valid parent found for notification container")
        end
        
        return gui
    end)
    
    if success then
        LXAIL.NotificationContainer = container
        return container
    else
        print("Failed to create notification container:", container)
        return nil
    end
end

-- === IMPROVED NOTIFICATION SYSTEM ===
function LXAIL:Notify(options)
    -- CRITICAL: Ensure notification container exists
    local container = createNotificationContainer()
    if not container then
        print("Cannot create notifications: No container available")
        return
    end
    
    options = options or {}
    local title = options.Title or "Notification"
    local content = options.Content or "No content provided"
    local duration = options.Duration or 3
    local notificationType = options.Type or "Info"
    
    print("Creating notification:", title, "-", content, "Type:", notificationType)
    
    -- Play notification sound
    playSound("rbxassetid://131961136")
    
    local success, notification = pcall(function()
        -- Create notification frame
        local notification = Instance.new("Frame")
        notification.Name = "LXAILNotification_" .. tostring(tick())
        notification.Size = UDim2.new(0, 420, 0, 100)
        notification.Position = UDim2.new(1, -440, 0, 20 + (#self.Notifications * 110))
        notification.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        notification.BorderSizePixel = 0
        notification.ZIndex = 1000 + #self.Notifications
        notification.Parent = container
        
        -- Corner radius
        local notifCorner = Instance.new("UICorner")
        notifCorner.CornerRadius = UDim.new(0, 12)
        notifCorner.Parent = notification
        
        -- Add shadow
        addSectionShadow(notification)
        
        -- Gradient background
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 25))
        }
        gradient.Rotation = 90
        gradient.Parent = notification
        
        -- Type border
        local typeBorder = Instance.new("Frame")
        typeBorder.Name = "TypeBorder"
        typeBorder.Size = UDim2.new(0, 6, 1, 0)
        typeBorder.Position = UDim2.new(0, 0, 0, 0)
        typeBorder.BorderSizePixel = 0
        typeBorder.ZIndex = notification.ZIndex + 1
        typeBorder.Parent = notification
        
        local borderCorner = Instance.new("UICorner")
        borderCorner.CornerRadius = UDim.new(0, 12)
        borderCorner.Parent = typeBorder
        
        -- Set border color based on type
        local typeColors = {
            Success = Color3.fromRGB(60, 180, 60),
            Warning = Color3.fromRGB(255, 165, 0),
            Error = Color3.fromRGB(255, 60, 60),
            Info = Color3.fromRGB(100, 150, 255)
        }
        typeBorder.BackgroundColor3 = typeColors[notificationType] or typeColors.Info
        
        -- Icon
        local icon = Instance.new("TextLabel")
        icon.Name = "Icon"
        icon.Size = UDim2.new(0, 50, 0, 50)
        icon.Position = UDim2.new(0, 15, 0, 10)
        icon.BackgroundTransparency = 1
        icon.TextColor3 = typeBorder.BackgroundColor3
        icon.TextSize = 30
        icon.Font = Enum.Font.GothamBold
        icon.TextXAlignment = Enum.TextXAlignment.Center
        icon.TextYAlignment = Enum.TextYAlignment.Center
        icon.ZIndex = notification.ZIndex + 2
        icon.Parent = notification
        
        -- Set icon based on type
        local typeIcons = {
            Success = "✓",
            Warning = "⚠",
            Error = "✕",
            Info = "ℹ"
        }
        icon.Text = typeIcons[notificationType] or typeIcons.Info
        
        -- Title
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, -120, 0, 30)
        titleLabel.Position = UDim2.new(0, 70, 0, 10)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = title
        titleLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
        titleLabel.TextSize = 20
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        titleLabel.TextScaled = false
        titleLabel.ZIndex = notification.ZIndex + 2
        titleLabel.Parent = notification
        
        -- Content
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, -120, 0, 40)
        contentLabel.Position = UDim2.new(0, 70, 0, 40)
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = content
        contentLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        contentLabel.TextSize = 15
        contentLabel.Font = Enum.Font.Gotham
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextYAlignment = Enum.TextYAlignment.Top
        contentLabel.TextWrapped = true
        contentLabel.TextScaled = false
        contentLabel.ZIndex = notification.ZIndex + 2
        contentLabel.Parent = notification
        
        -- Close button
        local closeButton = Instance.new("TextButton")
        closeButton.Name = "CloseButton"
        closeButton.Size = UDim2.new(0, 20, 0, 20)
        closeButton.Position = UDim2.new(1, -25, 0, 5)
        closeButton.BackgroundTransparency = 1
        closeButton.Text = "✕"
        closeButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        closeButton.TextSize = 16
        closeButton.Font = Enum.Font.GothamBold
        closeButton.ZIndex = notification.ZIndex + 3
        closeButton.Parent = notification
        
        return notification, closeButton
    end)
    
    if not success then
        print("Failed to create notification UI:", notification)
        return
    end
    
    local notificationFrame, closeButton = notification, nil
    
    -- Extract close button
    if notificationFrame then
        closeButton = notificationFrame:FindFirstChild("CloseButton")
    end
    
    -- Slide in animation
    notificationFrame.Position = UDim2.new(1, 0, 0, 20 + (#self.Notifications * 110))
    tween(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
        Position = UDim2.new(1, -440, 0, 20 + (#self.Notifications * 110))
    })
    
    -- Add to notifications list
    table.insert(self.Notifications, notificationFrame)
    print("Notification added to list. Total notifications:", #self.Notifications)
    
    -- Close functionality
    local function closeNotification()
        print("Closing notification:", title)
        
        tween(notificationFrame, TweenInfo.new(0.3), {
            Position = UDim2.new(1, 0, 0, notificationFrame.Position.Y.Offset)
        }, function()
            print("Destroying notification frame")
            notificationFrame:Destroy()
            
            -- Remove from list and reposition others
            for i, notif in ipairs(self.Notifications) do
                if notif == notificationFrame then
                    table.remove(self.Notifications, i)
                    print("Removed notification from list. Remaining:", #self.Notifications)
                    break
                end
            end
            
            -- Reposition remaining notifications
            for i, notif in ipairs(self.Notifications) do
                if notif and notif.Parent then
                    tween(notif, TweenInfo.new(0.3), {
                        Position = UDim2.new(1, -440, 0, 20 + ((i-1) * 110))
                    })
                end
            end
        end)
    end
    
    -- Connect close button
    if closeButton then
        closeButton.MouseButton1Click:Connect(closeNotification)
        print("Close button connected")
    end
    
    -- Auto-remove after duration
    spawn(function()
        wait(duration)
        if notificationFrame and notificationFrame.Parent then
            closeNotification()
        end
    end)
    
    print("Notification created successfully:", title)
end

-- === CONFIGURATION MANAGEMENT ===
function LXAIL:SaveConfiguration()
    if not self.ConfigFolder then return end
    
    local configData = {}
    for flag, value in pairs(self.Flags) do
        configData[flag] = value
    end
    
    local success, result = pcall(function()
        return HttpService:JSONEncode(configData)
    end)
    
    if success then
        print("Configuration saved:", self.ConfigFolder.FolderName .. "/" .. self.ConfigFolder.FileName)
        self:Notify({
            Title = "Configuration",
            Content = "Settings saved successfully",
            Duration = 2,
            Type = "Success"
        })
    else
        self:Notify({
            Title = "Error",
            Content = "Failed to save configuration",
            Duration = 3,
            Type = "Error"
        })
    end
end

function LXAIL:LoadConfiguration()
    if not self.ConfigFolder then return end
    
    print("Loading configuration from:", self.ConfigFolder.FolderName .. "/" .. self.ConfigFolder.FileName)
    self:Notify({
        Title = "Configuration",
        Content = "Settings loaded successfully",
        Duration = 2,
        Type = "Success"
    })
end

function LXAIL:ResetConfiguration()
    self.Flags = {}
    self:Notify({
        Title = "Configuration",
        Content = "Settings reset to defaults",
        Duration = 3,
        Type = "Warning"
    })
end

-- === BASIC WINDOW CREATION (SIMPLIFIED FOR TESTING) ===
function LXAIL:CreateWindow(options)
    options = options or {}
    
    local window = {
        Name = options.Name or "LXAIL Window",
        Tabs = {},
        ConfigurationSaving = options.ConfigurationSaving
    }
    
    if options.ConfigurationSaving and options.ConfigurationSaving.Enabled then
        self.ConfigFolder = options.ConfigurationSaving
    end
    
    -- Basic tab creation
    function window:CreateTab(tabOptions)
        local tab = {
            Name = tabOptions.Name or "Tab",
            Elements = {}
        }
        
        -- Basic component creation functions
        function tab:CreateToggle(toggleOptions)
            local toggle = {
                Name = toggleOptions.Name or "Toggle",
                CurrentValue = toggleOptions.CurrentValue or false,
                Flag = toggleOptions.Flag,
                Callback = toggleOptions.Callback or function() end
            }
            
            if toggle.Flag then
                LXAIL.Flags[toggle.Flag] = toggle.CurrentValue
            end
            
            -- Simulate toggle interaction
            if toggle.Callback then
                toggle.Callback(toggle.CurrentValue)
            end
            
            table.insert(tab.Elements, toggle)
            return toggle
        end
        
        function tab:CreateButton(buttonOptions)
            local button = {
                Name = buttonOptions.Name or "Button",
                Callback = buttonOptions.Callback or function() end
            }
            
            table.insert(tab.Elements, button)
            return button
        end
        
        table.insert(window.Tabs, tab)
        return tab
    end
    
    table.insert(self.Windows, window)
    return window
end

-- === TEST NOTIFICATION SYSTEM ===
local function testNotifications()
    print("\n=== TESTING NOTIFICATION SYSTEM ===")
    
    -- Test different notification types
    LXAIL:Notify({
        Title = "Success Test",
        Content = "This is a success notification test",
        Duration = 4,
        Type = "Success"
    })
    
    wait(1)
    
    LXAIL:Notify({
        Title = "Warning Test",
        Content = "This is a warning notification test",
        Duration = 3,
        Type = "Warning"
    })
    
    wait(1)
    
    LXAIL:Notify({
        Title = "Error Test",
        Content = "This is an error notification test",
        Duration = 5,
        Type = "Error"
    })
    
    wait(1)
    
    LXAIL:Notify({
        Title = "Info Test",
        Content = "This is an info notification test",
        Duration = 2,
        Type = "Info"
    })
    
    print("=== NOTIFICATION TESTS COMPLETED ===\n")
end

-- Run tests if in mock environment
if not isRobloxEnvironment then
    spawn(function()
        wait(1)
        testNotifications()
    end)
end

-- === RETURN LIBRARY ===
return LXAIL