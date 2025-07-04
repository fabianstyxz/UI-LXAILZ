-- TEST WITH USER'S EXACT FORMAT
-- This test uses the exact format as the user provided

-- Load the library
local function loadLibrary()
    local library = require('Main_LoadString')
    return library
end

-- Test with user's exact format
local success, LXAIL = pcall(loadLibrary)
if not success then
    print("Error loading library:", LXAIL)
    return
end

print("🧪 Testing with user's exact format")
print("=" .. string.rep("=", 50))

-- Create Window with KeySystem (using user's format)
local Window = LXAIL:CreateWindow({
    Name = "LXAIL | Test Script",
    LoadingTitle = "LXAIL Interface",
    LoadingSubtitle = "by YourName",
    Theme = "Dark",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_TEST",
        FileName = "Hub"
    },
    KeySystem = {
        Enabled = true,
        Title = "Key System",
        Subtitle = "LXAIL Hub",
        Note = "Join Discord for the key",
        Key = {"test123", "admin456", "user789"},
        Keys = {"test123", "admin456", "user789"}, -- Alternative format
        SaveKey = true,
        GrabKeyFromSite = false,
        Actions = {
            [1] = {
                Text = "Join Discord",
                OnPress = function()
                    print("🔗 Opening Discord...")
                end
            }
        }
    }
})

-- Test Tab Creation
local Tab1 = Window:CreateTab("🏠 Home", "home")
local Tab2 = Window:CreateTab("⚙️ Settings", "settings")
local Tab3 = Window:CreateTab("📊 Stats", "stats")

-- Test all components with user's format
print("\n📋 Testing Components...")

-- Toggle Test
local Toggle1 = Tab1:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        print("🔄 Auto Farm toggled:", Value)
    end
})

-- Slider Test
local Slider1 = Tab1:CreateSlider({
    Name = "Farm Speed",
    Range = {0, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 50,
    Flag = "FarmSpeed",
    Callback = function(Value)
        print("📊 Farm Speed set to:", Value)
    end
})

-- Dropdown Test
local Dropdown1 = Tab1:CreateDropdown({
    Name = "Select Method",
    Options = {"Fast", "Normal", "Slow", "Custom"},
    CurrentOption = "Normal",
    MultipleOptions = false,
    Flag = "FarmMethod",
    Callback = function(Value)
        print("📋 Method selected:", Value)
    end
})

-- Button Test
local Button1 = Tab1:CreateButton({
    Name = "Execute Script",
    Callback = function()
        print("⚡ Script executed!")
    end
})

-- Input Test
local Input1 = Tab2:CreateInput({
    Name = "Player Name",
    PlaceholderText = "Enter name...",
    RemoveTextAfterFocusLost = false,
    Flag = "PlayerName",
    Callback = function(Text)
        print("💬 Player name set to:", Text)
    end
})

-- ColorPicker Test
local ColorPicker1 = Tab2:CreateColorPicker({
    Name = "Theme Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ThemeColor",
    Callback = function(Value)
        print("🎨 Theme color changed to:", Value)
    end
})

-- Keybind Test
local Keybind1 = Tab2:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "UIToggle",
    Callback = function(Keybind)
        print("⌨️ UI keybind set to:", Keybind)
    end
})

-- Label Test
local Label1 = Tab3:CreateLabel("📊 Statistics Panel")

-- Paragraph Test
local Paragraph1 = Tab3:CreateParagraph({
    Title = "Info",
    Content = "This is a test paragraph showing detailed information about the current state of the application."
})

-- Divider Test
local Divider1 = Tab3:CreateDivider()

-- Test Configuration Functions
print("\n💾 Testing Configuration...")

-- Set some flag values
LXAIL.Flags["AutoFarm"] = true
LXAIL.Flags["FarmSpeed"] = 75
LXAIL.Flags["FarmMethod"] = "Fast"

-- Save Configuration
LXAIL:SaveConfiguration()
print("✅ Configuration saved")

-- Load Configuration
LXAIL:LoadConfiguration()
print("✅ Configuration loaded")

-- Test Notification System
print("\n📢 Testing Notifications...")

LXAIL:Notify({
    Title = "Success!",
    Content = "All tests completed successfully.",
    Duration = 3,
    Image = "success"
})

-- Test Theme System
print("\n🎨 Testing Theme System...")

LXAIL:SetTheme("Light")
wait(2)
LXAIL:SetTheme("Dark")
wait(2)
LXAIL:SetTheme("Neon")
wait(2)
LXAIL:SetTheme("Dark")

-- Test Floating Button
print("\n🔘 Testing Floating Button...")

local FloatingButton = LXAIL:CreateFloatingButton({
    Icon = "🎮",
    Callback = function()
        print("🔘 Floating button pressed - Toggling UI")
        LXAIL:Toggle()
    end
})

-- Test Multiple Dropdowns
print("\n📋 Testing Multiple Dropdowns...")

local Dropdown2 = Tab2:CreateDropdown({
    Name = "Multi Select",
    Options = {"Option A", "Option B", "Option C", "Option D"},
    CurrentOption = {"Option A", "Option B"},
    MultipleOptions = true,
    Flag = "MultiSelect",
    Callback = function(Value)
        print("📋 Multi-select changed:", table.concat(Value, ", "))
    end
})

-- Test Toggle with initial value
local Toggle2 = Tab2:CreateToggle({
    Name = "Advanced Mode",
    CurrentValue = true,
    Flag = "AdvancedMode",
    Callback = function(Value)
        print("🔧 Advanced Mode:", Value)
    end
})

-- Test Slider with different range
local Slider2 = Tab2:CreateSlider({
    Name = "Volume",
    Range = {0, 1},
    Increment = 0.1,
    Suffix = "",
    CurrentValue = 0.5,
    Flag = "Volume",
    Callback = function(Value)
        print("🔊 Volume set to:", Value)
    end
})

print("\n🎯 All tests completed!")
print("🔍 Check the UI for proper rendering and functionality")
print("🎮 Use the floating button to toggle the UI")
print("⌨️ Press F to toggle UI (if keybind is working)")
print("=" .. string.rep("=", 50))