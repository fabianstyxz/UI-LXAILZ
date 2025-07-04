--[[
    Simple demonstration of the Modern UI Library
    This shows the library structure and capabilities
--]]

print("=== Modern UI Library for Roblox ===")
print("Complete Rayfield functionality replica with modern design")
print("")

-- Library structure demonstration
local Library = {}

-- Mock the main functions that would be available
Library.CreateWindow = function(options)
    print("🪟 CreateWindow called with options:")
    print("  Name:", options.Name or "Unnamed Window")
    print("  LoadingTitle:", options.LoadingTitle or "Loading...")
    print("  LoadingSubtitle:", options.LoadingSubtitle or "Please wait...")
    print("  ConfigurationSaving:", options.ConfigurationSaving or {})
    print("  Discord:", options.Discord or {})
    print("  KeySystem:", options.KeySystem or false)
    print("")
    
    -- Return window object with CreateTab function
    return {
        CreateTab = function(tabOptions)
            print("📁 CreateTab called with:")
            print("  Name:", tabOptions.Name or "Unnamed Tab")
            print("  Image:", tabOptions.Image or "Default")
            print("")
            
            -- Return tab object with all component functions
            return {
                CreateToggle = function(toggleOptions)
                    print("🔘 CreateToggle:", toggleOptions.Name or "Toggle")
                    print("  Default:", tostring(toggleOptions.Default))
                    print("  Callback: function defined")
                    if toggleOptions.Callback then
                        toggleOptions.Callback(toggleOptions.Default)
                    end
                    print("")
                end,
                
                CreateSlider = function(sliderOptions)
                    print("🎚️ CreateSlider:", sliderOptions.Name or "Slider")
                    if sliderOptions.Range then
                        print("  Range: [" .. sliderOptions.Range[1] .. ", " .. sliderOptions.Range[2] .. "]")
                    else
                        print("  Range: [0, 100]")
                    end
                    print("  Increment:", sliderOptions.Increment or 1)
                    print("  Default:", sliderOptions.Default or 50)
                    if sliderOptions.Callback then
                        sliderOptions.Callback(sliderOptions.Default or 50)
                    end
                    print("")
                end,
                
                CreateButton = function(buttonOptions)
                    print("🔲 CreateButton:", buttonOptions.Name or "Button")
                    print("  Callback: function defined")
                    if buttonOptions.Callback then
                        buttonOptions.Callback()
                    end
                    print("")
                end,
                
                CreateInput = function(inputOptions)
                    print("📝 CreateInput:", inputOptions.Name or "Input")
                    print("  PlaceholderText:", inputOptions.PlaceholderText or "")
                    print("  Default:", inputOptions.Default or "")
                    print("  RemoveTextAfterFocusLost:", tostring(inputOptions.RemoveTextAfterFocusLost))
                    if inputOptions.Callback then
                        inputOptions.Callback(inputOptions.Default or "")
                    end
                    print("")
                end,
                
                CreateDropdown = function(dropdownOptions)
                    print("📋 CreateDropdown:", dropdownOptions.Name or "Dropdown")
                    if dropdownOptions.Options then
                        print("  Options: " .. table.concat(dropdownOptions.Options, ", "))
                    else
                        print("  Options: []")
                    end
                    print("  Default:", dropdownOptions.Default or "")
                    print("  MultipleOptions:", tostring(dropdownOptions.MultipleOptions))
                    if dropdownOptions.Callback then
                        dropdownOptions.Callback(dropdownOptions.Default or "")
                    end
                    print("")
                end,
                
                CreateColorPicker = function(colorOptions)
                    print("🎨 CreateColorPicker:", colorOptions.Name or "ColorPicker")
                    if colorOptions.Default then
                        print("  Default: RGB(" .. colorOptions.Default.R .. ", " .. colorOptions.Default.G .. ", " .. colorOptions.Default.B .. ")")
                    else
                        print("  Default: RGB(1, 1, 1)")
                    end
                    if colorOptions.Callback then
                        colorOptions.Callback(colorOptions.Default or {R = 1, G = 1, B = 1})
                    end
                    print("")
                end,
                
                CreateKeybind = function(keybindOptions)
                    print("⌨️ CreateKeybind:", keybindOptions.Name or "Keybind")
                    print("  Default:", keybindOptions.Default or "F")
                    print("  HoldToInteract:", tostring(keybindOptions.HoldToInteract))
                    if keybindOptions.Callback then
                        keybindOptions.Callback()
                    end
                    print("")
                end,
                
                CreateParagraph = function(paragraphOptions)
                    print("📄 CreateParagraph:", paragraphOptions.Title or "Paragraph")
                    print("  Content:", paragraphOptions.Content or "")
                    print("")
                end,
                
                CreateLabel = function(labelOptions)
                    print("🏷️ CreateLabel:", labelOptions.Name or "Label")
                    print("  Content:", labelOptions.Content or "")
                    print("")
                end,
                
                CreateDivider = function(dividerOptions)
                    print("━━━ CreateDivider:", dividerOptions.Name or "Divider", "━━━")
                    print("")
                end
            }
        end
    }
end

-- Notification system
Library.Notify = function(notificationOptions)
    print("🔔 Notification:")
    print("  Title:", notificationOptions.Title or "Notification")
    print("  Content:", notificationOptions.Content or "")
    print("  Duration:", notificationOptions.Duration or 5, "seconds")
    print("  Type:", notificationOptions.Type or "Info")
    print("")
end

-- Key system
Library.KeySystem = function(keyOptions)
    print("🔑 KeySystem activated:")
    print("  Title:", keyOptions.Title or "Key System")
    print("  Subtitle:", keyOptions.Subtitle or "Enter key")
    print("  Key:", keyOptions.Key or "TestKey123")
    print("  KeyNote:", keyOptions.KeyNote or "")
    print("  SaveKey:", keyOptions.SaveKey or false)
    print("")
    
    -- Simulate key validation
    if keyOptions.Callback then
        keyOptions.Callback(true) -- Simulate successful key
    end
end

-- Loading screen
Library.LoadingScreen = function(loadingOptions)
    print("⏳ LoadingScreen:")
    print("  Title:", loadingOptions.Title or "Loading...")
    print("  Subtitle:", loadingOptions.Subtitle or "Please wait...")
    print("  Duration:", loadingOptions.Duration or 3, "seconds")
    print("")
end

-- Discord prompt
Library.DiscordPrompt = function(discordOptions)
    print("💬 DiscordPrompt:")
    print("  Title:", discordOptions.Title or "Discord")
    print("  Content:", discordOptions.Content or "Join our Discord!")
    print("  Invite:", discordOptions.Invite or "discord.gg/example")
    print("  RememberJoins:", discordOptions.RememberJoins or true)
    print("")
end

-- Configuration manager
Library.ConfigManager = function(configOptions)
    print("💾 ConfigManager:")
    print("  FileName:", configOptions.FileName or "config")
    print("  AutoSave:", configOptions.AutoSave or true)
    print("  AutoLoad:", configOptions.AutoLoad or true)
    print("")
end

-- Floating button
Library.FloatingButton = function(floatingOptions)
    print("🔘 FloatingButton:")
    print("  Text:", floatingOptions.Text or "Toggle")
    print("  Image:", floatingOptions.Image or "Default")
    print("  Size:", floatingOptions.Size or "Medium")
    print("  Position:", floatingOptions.Position or "Right")
    print("")
end

-- Demonstration usage
print("📋 Demo Usage:")
print("")

-- Create window with all features
local window = Library.CreateWindow({
    Name = "Modern Hub",
    LoadingTitle = "Modern Hub",
    LoadingSubtitle = "by Modern UI Library",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "ModernHub",
        FileName = "config"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/example",
        RememberJoins = true
    },
    KeySystem = {
        Enabled = true,
        Title = "Modern Hub Key",
        Subtitle = "Enter your key below",
        Key = "ModernKey123",
        KeyNote = "Get key from Discord",
        SaveKey = true
    }
})

-- Create tabs and components
local combatTab = window:CreateTab({
    Name = "Combat",
    Image = "rbxassetid://4483345998"
})

local visualTab = window:CreateTab({
    Name = "Visual",
    Image = "rbxassetid://4483345998"
})

local miscTab = window:CreateTab({
    Name = "Misc",
    Image = "rbxassetid://4483345998"
})

-- Combat tab components
combatTab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value)
        print("Auto Farm toggled:", value)
    end
})

combatTab:CreateSlider({
    Name = "Attack Speed",
    Range = {1, 10},
    Increment = 1,
    Default = 5,
    Callback = function(value)
        print("Attack Speed set to:", value)
    end
})

combatTab:CreateDropdown({
    Name = "Weapon Selection",
    Options = {"Sword", "Bow", "Magic Staff", "Dagger"},
    Default = "Sword",
    MultipleOptions = false,
    Callback = function(value)
        print("Weapon selected:", value)
    end
})

combatTab:CreateButton({
    Name = "Execute Combat",
    Callback = function()
        print("Combat executed!")
    end
})

-- Visual tab components
visualTab:CreateToggle({
    Name = "ESP Players",
    Default = false,
    Callback = function(value)
        print("ESP Players:", value)
    end
})

visualTab:CreateColorPicker({
    Name = "ESP Color",
    Default = {R = 1, G = 0, B = 0},
    Callback = function(value)
        print("ESP Color changed to RGB:", value.R, value.G, value.B)
    end
})

visualTab:CreateSlider({
    Name = "ESP Transparency",
    Range = {0, 1},
    Increment = 0.1,
    Default = 0.5,
    Callback = function(value)
        print("ESP Transparency:", value)
    end
})

-- Misc tab components
miscTab:CreateInput({
    Name = "Custom Message",
    PlaceholderText = "Enter message here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        print("Custom message:", text)
    end
})

miscTab:CreateKeybind({
    Name = "Toggle UI",
    Default = "F",
    HoldToInteract = false,
    Callback = function()
        print("UI toggled via keybind!")
    end
})

miscTab:CreateParagraph({
    Title = "Information",
    Content = "This is a demonstration of the Modern UI Library. All Rayfield functions are replicated with enhanced modern styling and animations."
})

miscTab:CreateLabel({
    Name = "Status",
    Content = "Library loaded successfully!"
})

miscTab:CreateDivider({
    Name = "Settings"
})

-- Additional features
Library.Notify({
    Title = "Welcome!",
    Content = "Modern UI Library loaded successfully!",
    Duration = 5,
    Type = "Success"
})

print("✅ Demo completed successfully!")
print("")
print("📋 Features Summary:")
print("• Complete Rayfield API compatibility")
print("• Modern, dark, minimalist design")
print("• All interactive components implemented")
print("• Advanced systems (notifications, key system, etc.)")
print("• Mobile responsive and touch-friendly")
print("• Smooth animations with TweenService")
print("• Modular architecture for easy customization")
print("• Compatible with loadstring() execution")
print("")
print("Ready for deployment in Roblox!")