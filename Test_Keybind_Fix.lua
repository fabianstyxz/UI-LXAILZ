-- Test for Keybind Fix - Key Detection Functionality
print("=== TEST: Keybind Key Detection Fix ===")

-- Load LXAIL
local LXAIL = loadfile("Main_LoadString.lua")()

-- Create window
local Window = LXAIL:CreateWindow({
    Name = "Keybind Test",
    LoadingTitle = "Testing Keybinds...",
    LoadingSubtitle = "Key Detection Fix"
})

-- Create tab
local TestTab = Window:CreateTab({
    Name = "Keybind Tests",
    Icon = "rbxassetid://4483345998"
})

-- Test regular keybind
TestTab:CreateKeybind({
    Name = "Regular Key Test",
    CurrentKeybind = "G",
    HoldToInteract = false,
    Callback = function()
        print("✅ G key was pressed - Regular keybind working!")
        LXAIL:Notify({
            Title = "Success",
            Content = "G key detected!",
            Duration = 2,
            Type = "Success"
        })
    end,
})

-- Test hold-to-interact keybind
TestTab:CreateKeybind({
    Name = "Hold Key Test", 
    CurrentKeybind = "H",
    HoldToInteract = true,
    Callback = function()
        print("✅ H key was released - Hold keybind working!")
        LXAIL:Notify({
            Title = "Success", 
            Content = "H key hold detected!",
            Duration = 2,
            Type = "Success"
        })
    end,
})

-- Test your AutoBlock example
local Autoblocksettings = {
    Enabled = false
}

TestTab:CreateKeybind({
    Name = "Toggle AutoBlock",
    CurrentKeybind = "Y",
    HoldToInteract = false,
    Callback = function()
        Autoblocksettings.Enabled = not Autoblocksettings.Enabled
        print("✅ Y key pressed - AutoBlock toggled:", Autoblocksettings.Enabled)
        LXAIL:Notify({
            Title = "AutoBlock",
            Content = Autoblocksettings.Enabled and "ON ✅" or "OFF ❌",
            Duration = 2,
            Type = "Info"
        })
    end,
})

print("✅ Keybind test setup completed!")
print("🔑 Press G to test regular keybind")
print("🔑 Hold and release H to test hold keybind") 
print("🔑 Press Y to test AutoBlock toggle")
print("📝 All keybind callbacks should execute when keys are pressed!")