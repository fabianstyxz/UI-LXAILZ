--[[
    LXAIL - Complete Example Usage
    Modern UI Library for Roblox - Complete Rayfield Replica
    
    This example demonstrates ALL functionalities of LXAIL library
--]]

-- Load the LXAIL library
local LXAIL = require("Main") -- In Roblox: loadstring(game:HttpGet("your-script-url"))()

-- Create the main window with loading screen
local Window = LXAIL:CreateWindow({
    Name = "LXAIL Example Hub",
    LoadingTitle = "LXAIL Loading...",
    LoadingSubtitle = "Complete UI Library Example",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Configs",
        FileName = "ExampleConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = {
        Enabled = true,
        Title = "LXAIL Key System",
        Subtitle = "Enter your access key",
        Note = "Get your key from our Discord server",
        FileName = "LXAIL_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"LXAIL_DEMO_KEY", "ADMIN_ACCESS", "VIP_USER"}
    }
})

-- Create tabs to organize content
local MainTab = Window:CreateTab({
    Name = "Main Features",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local ComponentsTab = Window:CreateTab({
    Name = "Components",
    Icon = "rbxassetid://4483345998", 
    Visible = true
})

local SystemsTab = Window:CreateTab({
    Name = "Advanced Systems",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

-- Variables for examples
local exampleValue = 50
local toggleState = false
local selectedOption = "Option 1"
local userInput = ""
local selectedColor = Color3.fromRGB(255, 255, 255)
local currentKeybind = Enum.KeyCode.F

print("=== LXAIL Complete Example ===")

-- MAIN TAB - Core Components
MainTab:CreateLabel({
    Text = "Welcome to LXAIL - Complete Rayfield Replica"
})

MainTab:CreateParagraph({
    Title = "About LXAIL",
    Content = "LXAIL is a modern, dark, minimalist UI library that replicates all Rayfield functionality with custom design and smooth animations."
})

MainTab:CreateDivider()

-- Toggle Example
MainTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        toggleState = Value
        print("Auto Farm:", Value and "Enabled" or "Disabled")
        
        -- Show notification
        LXAIL:Notify({
            Title = "Auto Farm",
            Content = Value and "Auto Farm Enabled!" or "Auto Farm Disabled!",
            Duration = 3,
            Image = "rbxassetid://4483345998"
        })
    end,
})

-- Slider Example
MainTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = " WS",
    CurrentValue = 50,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        exampleValue = Value
        print("Walk Speed set to:", Value)
        
        -- In real Roblox usage:
        -- game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

-- Button Example
MainTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        print("Teleporting to spawn...")
        LXAIL:Notify({
            Title = "Teleport",
            Content = "Teleported to spawn point!",
            Duration = 2,
            Type = "Success"
        })
    end,
})

-- COMPONENTS TAB - All Interactive Elements
ComponentsTab:CreateLabel({
    Text = "All LXAIL Components Showcase"
})

-- Input Example
ComponentsTab:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Enter player name...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        userInput = Text
        print("Input received:", Text)
    end,
})

-- Dropdown Example
ComponentsTab:CreateDropdown({
    Name = "Game Mode",
    Options = {"Adventure", "Survival", "Creative", "Hardcore"},
    CurrentOption = {"Adventure"},
    MultipleOptions = false,
    Flag = "GameModeDropdown",
    Callback = function(Option)
        selectedOption = Option[1] or Option
        print("Selected game mode:", selectedOption)
    end,
})

-- Multi-Select Dropdown Example
ComponentsTab:CreateDropdown({
    Name = "Features (Multi-Select)",
    Options = {"ESP", "Aimbot", "Speed Hack", "Fly", "Noclip"},
    CurrentOption = {"ESP"},
    MultipleOptions = true,
    Flag = "FeaturesDropdown",
    Callback = function(Options)
        print("Selected features:", table.concat(Options, ", "))
    end,
})

-- Color Picker Example
ComponentsTab:CreateColorPicker({
    Name = "Theme Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "ThemeColorPicker",
    Callback = function(Value)
        selectedColor = Value
        print("Color selected:", Value.R, Value.G, Value.B)
    end
})

-- Keybind Example
ComponentsTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "ToggleUIKeybind",
    Callback = function(Keybind)
        currentKeybind = Keybind
        print("UI Toggle keybind set to:", Keybind)
    end,
})

-- Hold-to-interact Keybind
ComponentsTab:CreateKeybind({
    Name = "Sprint (Hold)",
    CurrentKeybind = "LeftShift",
    HoldToInteract = true,
    Flag = "SprintKeybind",
    Callback = function(Keybind)
        print("Sprint key:", Keybind)
    end,
})

ComponentsTab:CreateDivider()

-- Additional Examples
ComponentsTab:CreateParagraph({
    Title = "Advanced Features",
    Content = "LXAIL includes all modern UI features: smooth animations, mobile support, theme system, and complete Rayfield API compatibility."
})

-- SYSTEMS TAB - Advanced Functionality
SystemsTab:CreateLabel({
    Text = "Advanced LXAIL Systems"
})

-- Notification Examples
SystemsTab:CreateButton({
    Name = "Test Success Notification",
    Callback = function()
        LXAIL:Notify({
            Title = "Success!",
            Content = "This is a success notification with custom duration.",
            Duration = 4,
            Type = "Success"
        })
    end,
})

SystemsTab:CreateButton({
    Name = "Test Warning Notification", 
    Callback = function()
        LXAIL:Notify({
            Title = "Warning",
            Content = "This is a warning notification.",
            Duration = 3,
            Type = "Warning"
        })
    end,
})

SystemsTab:CreateButton({
    Name = "Test Error Notification",
    Callback = function()
        LXAIL:Notify({
            Title = "Error",
            Content = "This is an error notification.",
            Duration = 5,
            Type = "Error"
        })
    end,
})

-- Config Management Examples
SystemsTab:CreateButton({
    Name = "Save Configuration",
    Callback = function()
        LXAIL:SaveConfiguration()
        LXAIL:Notify({
            Title = "Configuration",
            Content = "Settings saved successfully!",
            Duration = 2,
            Type = "Success"
        })
    end,
})

SystemsTab:CreateButton({
    Name = "Load Configuration",
    Callback = function()
        LXAIL:LoadConfiguration()
        LXAIL:Notify({
            Title = "Configuration", 
            Content = "Settings loaded successfully!",
            Duration = 2,
            Type = "Info"
        })
    end,
})

-- Discord Integration Example
SystemsTab:CreateButton({
    Name = "Show Discord Invite",
    Callback = function()
        LXAIL:Prompt({
            Title = "Join Our Discord!",
            SubTitle = "Get support and updates",
            Content = "Click the button below to join our Discord server for help, updates, and community.",
            Actions = {
                Accept = {
                    Name = "Join Discord",
                    Callback = function()
                        print("Redirecting to Discord...")
                        -- In Roblox: Open Discord invite
                    end,
                },
                Ignore = {
                    Name = "Maybe Later",
                    Callback = function()
                        print("Discord invite dismissed")
                    end,
                }
            }
        })
    end,
})

SystemsTab:CreateDivider()

-- Theme System Example
SystemsTab:CreateLabel({
    Text = "Theme System"
})

SystemsTab:CreateButton({
    Name = "Switch to Light Theme",
    Callback = function()
        LXAIL:SetTheme("Light")
        LXAIL:Notify({
            Title = "Theme Changed",
            Content = "Switched to Light theme!",
            Duration = 2
        })
    end,
})

SystemsTab:CreateButton({
    Name = "Switch to Dark Theme", 
    Callback = function()
        LXAIL:SetTheme("Dark")
        LXAIL:Notify({
            Title = "Theme Changed",
            Content = "Switched to Dark theme!",
            Duration = 2
        })
    end,
})

SystemsTab:CreateButton({
    Name = "Switch to Neon Theme",
    Callback = function()
        LXAIL:SetTheme("Neon")
        LXAIL:Notify({
            Title = "Theme Changed", 
            Content = "Switched to Neon theme!",
            Duration = 2
        })
    end,
})

-- Floating Button Example (optional)
if LXAIL.CreateFloatingButton then
    LXAIL:CreateFloatingButton({
        Icon = "rbxassetid://4483345998",
        Callback = function()
            LXAIL:Toggle()
        end
    })
end

-- Final welcome notification
LXAIL:Notify({
    Title = "LXAIL Loaded!",
    Content = "All features are ready to use. Press F to toggle UI.",
    Duration = 5,
    Type = "Success"
})

print("✅ LXAIL Example completed successfully!")
print("📋 Features demonstrated:")
print("• Window creation with loading screen")
print("• Tab system with organization") 
print("• All interactive components")
print("• Notification system")
print("• Configuration management")
print("• Theme system")
print("• Discord integration")
print("• Key system (if enabled)")
print("• Mobile-friendly design")
print("• Smooth animations")
print("")
print("🎮 Ready for use in Roblox!")

-- Return the library instance for external access
return LXAIL