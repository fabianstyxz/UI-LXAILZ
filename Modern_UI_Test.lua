-- Test the new modern UI design
local success, content = pcall(function()
    local file = io.open("Main_LoadString.lua", "r")
    if file then
        local content = file:read("*a")
        file:close()
        return content
    end
    return nil
end)

if not success or not content then
    print("Failed to load Main_LoadString.lua")
    return
end

local LXAIL = loadstring(content)()

print("=== LXAIL Modern UI Test ===")
print("🚀 Testing new glitch effect design...")

-- Create window with modern design
local Window = LXAIL:CreateWindow({
    Name = "LXAIL - BETA",
    LoadingTitle = "LXAIL Loading...",
    LoadingSubtitle = "Modern Design with Glitch Effects",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL",
        FileName = "BigHub"
    },
    Discord = {
        Enabled = true,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false
})

-- Create Main tab
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998"
})

-- Create Misc tab  
local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998"
})

print("✅ Window and tabs created successfully!")

-- Add components to Main tab
MainTab:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        print("Anti AFK activated!")
    end
})

MainTab:CreateToggle({
    Name = "Auto Attack", 
    Default = false,
    Callback = function(Value)
        print("Auto Attack:", Value)
    end
})

MainTab:CreateToggle({
    Name = "Auto Block",
    Default = false,
    Callback = function(Value)
        print("Auto Block:", Value)
    end
})

MainTab:CreateToggle({
    Name = "Auto Counter",
    Default = false,
    Callback = function(Value)
        print("Auto Counter:", Value)
    end
})

MainTab:CreateSlider({
    Name = "Auto Attack Distance",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(Value)
        print("Auto Attack Distance:", Value)
    end
})

MainTab:CreateSlider({
    Name = "Auto Block Distance", 
    Min = 0,
    Max = 100,
    Default = 30,
    Callback = function(Value)
        print("Auto Block Distance:", Value)
    end
})

MainTab:CreateSlider({
    Name = "Auto Counter Distance",
    Min = 0, 
    Max = 100,
    Default = 25,
    Callback = function(Value)
        print("Auto Counter Distance:", Value)
    end
})

print("✅ Main tab components created!")

-- Add content to Misc tab
MiscTab:CreateLabel({
    Name = "More Options",
    Content = "Additional features and settings will be added here..."
})

print("✅ Misc tab content added!")

print("🎨 === Modern UI Features ===")
print("• Animated title with glitch effects")
print("• Modern dark theme with gradients") 
print("• Smooth tab transitions with glitch animations")
print("• Floating draggable toggle button")
print("• F key toggle functionality")
print("• Mobile-friendly touch support")
print("• Modern toggle switches with icons")
print("• Interactive sliders with value boxes")
print("• Hover effects on all interactive elements")
print("• Shadow effects for depth")

print("🚀 === Test Complete ===")
print("Ready for Roblox deployment!")
print("Press F to toggle UI visibility")