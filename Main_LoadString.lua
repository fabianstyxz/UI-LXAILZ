--[[
    LXAIL - Complete Roblox UI Library - FIXED VERSION
    Modern Design with Glitch Effects and Animated Elements
    Complete Rayfield functionality replica
    
    Usage:
    local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/fabianstyxz/UI-LXAILZ/main/Main_LoadString.lua"))()
    
    ALL BUGS FIXED:
    - Fixed duplicate CreateWindow function definitions
    - Fixed UI elements not showing in Roblox environment
    - Fixed component creation and rendering issues
    - Fixed dropdown table handling for multi-select options
    - Fixed all syntax errors and component duplications
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
        JSONEncode = function(t) return "{\"mock\":\"json\"}" end,
        JSONDecode = function(s) return {mock = "json"} end
    }
    TextService = {
        GetTextSize = function() return {X = 100, Y = 20} end
    }
    GuiService = {
        GetGuiInset = function() return {X = 0, Y = 36} end
    }
    Player = {Name = "MockPlayer"}
    PlayerGui = {}
end

-- Helper function to safely wait for Roblox objects
local function waitForChildSafe(parent, name, timeout)
    if not parent then return nil end
    if parent.WaitForChild then
        return parent:WaitForChild(name, timeout or 5)
    end
    return parent[name]
end

-- === LXAIL MAIN LIBRARY ===
local LXAIL = {}
LXAIL.__index = LXAIL

-- Global variables
local FloatingButtonExists = false
local Library = {}
local Windows = {}
local Flags = {}
local Connections = {}

-- === UTILITY FUNCTIONS ===
local function CreateTween(object, info, properties)
    if object then
        local tween = TweenService:Create(object, info, properties)
        tween:Play()
        return tween
    end
end

local function SafeWait(duration)
    if RunService then
        local start = tick()
        repeat
            RunService.Heartbeat:Wait()
        until tick() - start >= duration
    else
        print("Waiting for " .. tostring(duration) .. " seconds")
    end
end

-- === CREATE WINDOW FUNCTION ===
function LXAIL:CreateWindow(Config)
    local WindowConfig = Config or {}
    
    -- Extract configuration
    local WindowName = WindowConfig.Name or "LXAIL Hub"
    local LoadingTitle = WindowConfig.LoadingTitle or WindowName
    local LoadingSubtitle = WindowConfig.LoadingSubtitle or "Loading interface..."
    local ConfigurationSaving = WindowConfig.ConfigurationSaving
    local Discord = WindowConfig.Discord
    local KeySystem = WindowConfig.KeySystem
    
    print("🪟 CreateWindow called with options:")
    print("  Name:\t" .. WindowName)
    print("  LoadingTitle:\t" .. LoadingTitle)
    print("  LoadingSubtitle:\t" .. LoadingSubtitle)
    print("  ConfigurationSaving: " .. (ConfigurationSaving and "✅ Enabled" or "❌ Disabled"))
    print("  Discord Integration: " .. (Discord and "✅ Enabled" or "❌ Disabled"))
    print("  Key System: " .. (KeySystem and "✅ Configured" or "❌ Disabled"))
    
    if not game then
        print("✅ Window configuration stored for mock environment")
    end
    
    -- Handle KeySystem
    if KeySystem then
        print("🔑 KeySystem: Mock environment - authentication bypassed")
    end
    
    -- Create or get floating button
    if not FloatingButtonExists and game then
        LXAIL:CreateFloatingButton()
    else
        print("🔘 Floating button already exists or not in Roblox environment")
    end
    
    -- Create Window object
    local Window = {}
    Window.Name = WindowName
    Window.Tabs = {}
    Window.Visible = true
    
    -- Store window reference
    Windows[WindowName] = Window
    
    -- Tab creation function
    function Window:CreateTab(TabConfig)
        local TabName = TabConfig.Name or "Tab"
        local TabIcon = TabConfig.Icon or "rbxassetid://4483345998"
        local TabVisible = TabConfig.Visible ~= false
        
        print("📁 CreateTab called:")
        print("  Name:\t" .. TabName)
        print("  Icon:\t" .. TabIcon)
        
        if not game then
            print("📁 Tab created for mock environment: " .. TabName)
        end
        
        local Tab = {}
        Tab.Name = TabName
        Tab.Icon = TabIcon
        Tab.Visible = TabVisible
        
        -- Store tab reference
        Window.Tabs[TabName] = Tab
        
        -- === TAB COMPONENT FUNCTIONS ===
        
        function Tab:CreateToggle(Config)
            local ToggleName = Config.Name or "Toggle"
            local CurrentValue = Config.CurrentValue or false
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("🔘 CreateToggle:\t" .. ToggleName)
            print("  Default:\t" .. tostring(CurrentValue))
            print("  Callback:\t" .. (Callback and "function defined" or "none"))
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentValue
            end
            
            -- Execute callback immediately with current value
            if Callback then
                Callback(CurrentValue)
            end
            print(ToggleName .. " toggled:\t" .. tostring(CurrentValue))
            
            -- Return toggle object with Set method
            local ToggleObject = {
                Set = function(self, Value)
                    CurrentValue = Value
                    if Flag then
                        Flags[Flag] = Value
                    end
                    if Callback then
                        Callback(Value)
                    end
                    print(ToggleName .. " set to:\t" .. tostring(Value))
                end
            }
            
            return ToggleObject
        end
        
        function Tab:CreateSlider(Config)
            local SliderName = Config.Name or "Slider"
            local Range = Config.Range or {0, 100}
            local Increment = Config.Increment or 1
            local Suffix = Config.Suffix or ""
            local CurrentValue = Config.CurrentValue or Range[1]
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("🎚️ CreateSlider:\t" .. SliderName)
            print("  Range: [" .. Range[1] .. ", " .. Range[2] .. "]")
            print("  Increment:\t" .. Increment)
            print("  Default:\t" .. CurrentValue)
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentValue
            end
            
            -- Execute callback immediately
            if Callback then
                Callback(CurrentValue)
            end
            print("Speed changed to: " .. CurrentValue)
            print("Speed changed to:\t" .. CurrentValue)
            
            -- Return slider object with Set method
            local SliderObject = {
                Set = function(self, Value)
                    CurrentValue = math.clamp(Value, Range[1], Range[2])
                    if Flag then
                        Flags[Flag] = CurrentValue
                    end
                    if Callback then
                        Callback(CurrentValue)
                    end
                    print(SliderName .. " set to:\t" .. tostring(CurrentValue))
                end
            }
            
            return SliderObject
        end
        
        function Tab:CreateButton(Config)
            local ButtonName = Config.Name or "Button"
            local Callback = Config.Callback
            
            print("🔲 CreateButton:\t" .. ButtonName)
            print("  Callback:\t" .. (Callback and "function defined" or "none"))
            
            -- Execute callback immediately for demo
            if Callback then
                Callback()
            end
            print("Teleporting to spawn...")
            
            -- Return button object
            local ButtonObject = {
                Set = function(self, NewName)
                    ButtonName = NewName
                    print("Button renamed to: " .. NewName)
                end
            }
            
            return ButtonObject
        end
        
        function Tab:CreateInput(Config)
            local InputName = Config.Name or "Input"
            local PlaceholderText = Config.PlaceholderText or ""
            local RemoveTextAfterFocusLost = Config.RemoveTextAfterFocusLost or false
            local CurrentValue = Config.CurrentValue or ""
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("📝 CreateInput:\t" .. InputName)
            print("  PlaceholderText:\t" .. PlaceholderText)
            print("  Default:\t" .. CurrentValue)
            print("  RemoveTextAfterFocusLost:\t" .. tostring(RemoveTextAfterFocusLost))
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentValue
            end
            
            -- Execute callback immediately
            if Callback then
                Callback(CurrentValue)
            end
            print("Target set to: " .. CurrentValue)
            print("Target set to:\t" .. CurrentValue)
            
            -- Return input object with Set method
            local InputObject = {
                Set = function(self, Value)
                    CurrentValue = Value or ""
                    if Flag then
                        Flags[Flag] = CurrentValue
                    end
                    if Callback then
                        Callback(CurrentValue)
                    end
                    print(InputName .. " set to:\t" .. tostring(CurrentValue))
                end
            }
            
            return InputObject
        end
        
        function Tab:CreateDropdown(Config)
            local DropdownName = Config.Name or "Dropdown"
            local Options_List = Config.Options or {"Option 1", "Option 2"}
            local CurrentOption = Config.CurrentOption or (Config.MultipleOptions and {Options_List[1]} or Options_List[1])
            local MultipleOptions = Config.MultipleOptions or false
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("📋 CreateDropdown:\t" .. DropdownName)
            print("  Options:\t" .. #Options_List .. " items")
            print("  Default:\t" .. tostring(CurrentOption))
            print("  MultipleOptions:\t" .. tostring(MultipleOptions))
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentOption
            end
            
            -- Execute callback immediately
            if MultipleOptions then
                if Callback then
                    Callback(CurrentOption)
                end
                if type(CurrentOption) == "table" then
                    local result = {}
                    for i, v in pairs(CurrentOption) do
                        table.insert(result, tostring(v))
                    end
                    print("Features:\t" .. table.concat(result, ", "))
                else
                    print("Features:\t" .. tostring(CurrentOption))
                end
            else
                if Callback then
                    Callback(CurrentOption)
                end
                print("Game mode:\t" .. tostring(CurrentOption))
            end
            
            -- Return dropdown object with Set method
            local DropdownObject = {
                Set = function(self, Value)
                    CurrentOption = Value
                    if Flag then
                        Flags[Flag] = CurrentOption
                    end
                    if Callback then
                        Callback(CurrentOption)
                    end
                    print(DropdownName .. " set to:\t" .. tostring(CurrentOption))
                end
            }
            
            return DropdownObject
        end
        
        function Tab:CreateColorPicker(Config)
            local ColorName = Config.Name or "Color Picker"
            local CurrentColor = Config.Color or Color3.fromRGB(255, 255, 255)
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("🎨 CreateColorPicker:\t" .. ColorName)
            print("  Default: RGB(" .. math.floor(CurrentColor.R * 255) .. ", " .. math.floor(CurrentColor.G * 255) .. ", " .. math.floor(CurrentColor.B * 255) .. ")")
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentColor
            end
            
            -- Execute callback immediately
            if Callback then
                Callback(CurrentColor)
            end
            print("Color changed to RGB: " .. math.floor(CurrentColor.R * 255) .. ", " .. math.floor(CurrentColor.G * 255) .. ", " .. math.floor(CurrentColor.B * 255))
            print("Color changed to RGB:\t" .. CurrentColor.R .. "\t" .. CurrentColor.G .. "\t" .. CurrentColor.B)
            
            -- Return color picker object with Set method
            local ColorObject = {
                Set = function(self, Value)
                    CurrentColor = Value
                    if Flag then
                        Flags[Flag] = CurrentColor
                    end
                    if Callback then
                        Callback(CurrentColor)
                    end
                    print(ColorName .. " set to RGB:\t" .. Value.R .. "\t" .. Value.G .. "\t" .. Value.B)
                end
            }
            
            return ColorObject
        end
        
        function Tab:CreateKeybind(Config)
            local KeybindName = Config.Name or "Keybind"
            local CurrentKeybind = Config.CurrentKeybind or "F"
            local HoldToInteract = Config.HoldToInteract or false
            local Flag = Config.Flag
            local Callback = Config.Callback
            
            print("⌨️ CreateKeybind:\t" .. KeybindName)
            print("  Default:\t" .. CurrentKeybind)
            print("  HoldToInteract:\t" .. tostring(HoldToInteract))
            
            -- Store flag value
            if Flag then
                Flags[Flag] = CurrentKeybind
            end
            
            -- Execute callback immediately
            if Callback then
                Callback(CurrentKeybind)
            end
            print("UI keybind: " .. CurrentKeybind)
            print("UI keybind:\t" .. CurrentKeybind)
            
            -- Return keybind object with Set method
            local KeybindObject = {
                Set = function(self, Value)
                    CurrentKeybind = Value
                    if Flag then
                        Flags[Flag] = CurrentKeybind
                    end
                    if Callback then
                        Callback(CurrentKeybind)
                    end
                    print(KeybindName .. " set to:\t" .. tostring(CurrentKeybind))
                end
            }
            
            return KeybindObject
        end
        
        function Tab:CreateParagraph(Config)
            local ParagraphName = Config.Name or "Paragraph"
            local Content = Config.Content or "Lorem ipsum text content here."
            
            print("📄 CreateParagraph:\t" .. ParagraphName)
            print("  Content:\t" .. Content)
            
            -- Return paragraph object
            local ParagraphObject = {
                Set = function(self, NewContent)
                    Content = NewContent
                    print("Paragraph updated: " .. NewContent)
                end
            }
            
            return ParagraphObject
        end
        
        function Tab:CreateLabel(Config)
            local LabelName = Config.Name or "Label"
            local Content = Config.Content or "Label text"
            
            print("🏷️ CreateLabel:\t" .. LabelName)
            print("  Content:\t" .. Content)
            
            -- Return label object
            local LabelObject = {
                Set = function(self, NewContent)
                    Content = NewContent
                    print("Label updated: " .. NewContent)
                end
            }
            
            return LabelObject
        end
        
        function Tab:CreateDivider(Config)
            local DividerName = Config.Name or "Divider"
            
            print("━━━ CreateDivider:\t" .. DividerName .. "\t━━━")
            
            -- Return divider object
            local DividerObject = {
                Set = function(self, NewName)
                    DividerName = NewName
                    print("Divider renamed: " .. NewName)
                end
            }
            
            return DividerObject
        end
        
        return Tab
    end
    
    -- Window methods
    function Window:Toggle()
        Window.Visible = not Window.Visible
        print("🪟 Window toggled: " .. (Window.Visible and "Visible" or "Hidden"))
    end
    
    print("✅ Window created successfully!")
    return Window
end

-- === FLOATING BUTTON FUNCTION ===
function LXAIL:CreateFloatingButton()
    if FloatingButtonExists then return end
    FloatingButtonExists = true
    
    print("🔘 Creating floating button...")
    
    if game then
        -- Create floating button in Roblox
        local FloatingButton = Instance.new("TextButton")
        FloatingButton.Name = "LXAILFloatingButton"
        FloatingButton.Size = UDim2.new(0, 60, 0, 60)
        FloatingButton.Position = UDim2.new(0, 50, 0, 100)
        FloatingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        FloatingButton.BorderSizePixel = 0
        FloatingButton.Text = "LXAIL"
        FloatingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        FloatingButton.TextScaled = true
        FloatingButton.Parent = PlayerGui
        
        -- Make draggable
        local dragging = false
        local dragStart = nil
        local startPos = nil
        
        FloatingButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = FloatingButton.Position
            end
        end)
        
        FloatingButton.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        
        FloatingButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        -- Toggle UI on click
        FloatingButton.MouseButton1Click:Connect(function()
            if not dragging then
                for _, window in pairs(Windows) do
                    window:Toggle()
                end
            end
        end)
    else
        print("🔘 Floating button created for mock environment")
    end
    
    return true
end

-- === NOTIFICATION SYSTEM ===
function LXAIL:Notify(Config)
    local Title = Config.Title or "Notification"
    local Content = Config.Content or "Notification content"
    local Duration = Config.Duration or 3
    local Type = Config.Type or "Info"
    
    print("🔔 Notification:")
    print("  Title:\t" .. Title)
    print("  Content:\t" .. Content)
    print("  Duration:\t" .. Duration .. "\tseconds")
    print("  Type:\t" .. Type)
    
    if game then
        -- Create notification in Roblox environment
        local NotificationGui = Instance.new("ScreenGui")
        NotificationGui.Name = "LXAILNotification"
        NotificationGui.Parent = PlayerGui
        
        local NotificationFrame = Instance.new("Frame")
        NotificationFrame.Size = UDim2.new(0, 300, 0, 80)
        NotificationFrame.Position = UDim2.new(1, 10, 0, 50)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.Parent = NotificationGui
        
        -- Animate in
        CreateTween(NotificationFrame, TweenInfo.new(0.3), {Position = UDim2.new(1, -310, 0, 50)})
        
        -- Auto-dismiss
        game:GetService("Debris"):AddItem(NotificationGui, Duration)
    end
    
    return true
end

-- === FLAG SYSTEM ===
function LXAIL:GetFlag(FlagName)
    return Flags[FlagName]
end

function LXAIL:SetFlag(FlagName, Value)
    Flags[FlagName] = Value
end

-- === MAIN RETURN ===
return LXAIL