-- Test for Profile Position Fix
print("=== TEST: Profile Position with Multiple Tabs ===")

-- Load LXAIL
local LXAIL = loadfile("Main_LoadString.lua")()

-- Create window
local Window = LXAIL:CreateWindow({
    Name = "Test Profile Position",
    LoadingTitle = "Testing...",
    LoadingSubtitle = "Profile Position Fix"
})

-- Create multiple tabs to test scrolling
for i = 1, 8 do
    local tab = Window:CreateTab({
        Name = "Tab " .. i,
        Icon = "rbxassetid://4483345998"
    })
    
    -- Add some components to verify functionality
    tab:CreateToggle({
        Name = "Toggle " .. i,
        CurrentValue = false,
        Callback = function(value)
            print("Tab " .. i .. " toggle:", value)
        end
    })
    
    tab:CreateButton({
        Name = "Button " .. i,
        Callback = function()
            print("Tab " .. i .. " button clicked!")
        end
    })
end

print("✅ Created 8 tabs successfully")
print("🔲 Profile should be positioned at bottom of sidebar")
print("📜 Tabs should be scrollable if they exceed available space")
print("📝 Test completed - check UI layout!")