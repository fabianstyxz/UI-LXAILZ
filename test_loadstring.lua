-- Test the Main_LoadString implementation
local LXAIL = dofile("Main_LoadString.lua")

print("Testing LXAIL LoadString Implementation")
print("=======================================")

-- Test basic library loading
print("✓ LXAIL library loaded successfully")

-- Test CreateWindow
local Window = LXAIL:CreateWindow({
    Name = "Test Window",
    LoadingTitle = "Test Loading",
    LoadingSubtitle = "Testing implementation"
})

print("✓ Window created:", Window.Name)

-- Test CreateTab
local Tab = Window:CreateTab({
    Name = "Test Tab",
    Icon = "rbxassetid://4483345998"
})

print("✓ Tab created:", Tab.Name)

-- Test CreateToggle
local Toggle = Tab:CreateToggle({
    Name = "Test Toggle",
    CurrentValue = false,
    Flag = "TestToggle",
    Callback = function(Value)
        print("Toggle changed to:", Value)
    end
})

print("✓ Toggle created:", Toggle.Name)

-- Test CreateSlider
local Slider = Tab:CreateSlider({
    Name = "Test Slider",
    Range = {0, 100},
    CurrentValue = 50,
    Flag = "TestSlider",
    Callback = function(Value)
        print("Slider changed to:", Value)
    end
})

print("✓ Slider created:", Slider.Name)

-- Test CreateButton
local Button = Tab:CreateButton({
    Name = "Test Button",
    Callback = function()
        print("Button clicked!")
    end
})

print("✓ Button created:", Button.Name)

print("=======================================")
print("All tests passed! LoadString implementation is working.")