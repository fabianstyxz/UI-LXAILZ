-- === ROBLOX DEPLOYMENT TEST ===
print("Testing LXAIL deployment in Roblox...")

-- Load the library
local LXAIL = dofile("Main_LoadString.lua")

-- Create a simple window to test
local Window = LXAIL:CreateWindow({
    Name = "LXAIL BETA",
    KeySystem = {
        Enabled = false  -- Disable for quick testing
    },
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Test",
        FileName = "TestConfig"
    }
})

-- Create a test tab
local TestTab = Window:CreateTab({
    Name = "Test Tab",
    Visible = true
})

-- Add basic components
TestTab:CreateLabel({
    Text = "LXAIL Test UI"
})

TestTab:CreateToggle({
    Name = "Test Toggle",
    CurrentValue = false,
    Flag = "TestToggle",
    Callback = function(Value)
        print("Toggle:", Value)
    end
})

TestTab:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Button clicked!")
        LXAIL:Notify({
            Title = "Success",
            Content = "LXAIL is working correctly in Roblox!",
            Duration = 3,
            Type = "Success"
        })
    end
})

print("✅ LXAIL loaded successfully!")
print("📱 UI created with test components")
print("🎮 Press F to toggle UI visibility")