-- Test para verificar que los inputs de sliders son interactivos
print("=== TEST: Slider Input Interactivity ===")

-- Cargar la librería
local LXAIL = loadfile("Main_LoadString.lua")()

-- Crear ventana
local Window = LXAIL:CreateWindow({
    Name = "Slider Input Test",
    LoadingTitle = "Testing Sliders...",
    LoadingSubtitle = "Verificando interactividad de inputs"
})

-- Crear tab
local Tab = Window:CreateTab({
    Name = "Slider Tests",
    Icon = "rbxassetid://4483345998"
})

-- Crear varios sliders para probar
local speedSlider = Tab:CreateSlider({
    Name = "Player Speed",
    Range = {1, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = 50,
    Flag = "SpeedSlider",
    Callback = function(value)
        print("Speed slider changed to:", value)
    end
})

local volumeSlider = Tab:CreateSlider({
    Name = "Music Volume",
    Range = {0, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 75,
    Flag = "VolumeSlider",
    Callback = function(value)
        print("Volume slider changed to:", value, "%")
    end
})

local sensitivitySlider = Tab:CreateSlider({
    Name = "Mouse Sensitivity",
    Range = {0.1, 5.0},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = 1.5,
    Flag = "SensitivitySlider",
    Callback = function(value)
        print("Sensitivity slider changed to:", value, "x")
    end
})

-- Test programático de la funcionalidad
Tab:CreateLabel({
    Name = "Instructions",
    Text = "Test slider input functionality:"
})

Tab:CreateLabel({
    Name = "Step 1",
    Text = "1. Click on a slider input box"
})

Tab:CreateLabel({
    Name = "Step 2", 
    Text = "2. Type a new number within the range"
})

Tab:CreateLabel({
    Name = "Step 3",
    Text = "3. Press Enter or click outside to apply"
})

Tab:CreateLabel({
    Name = "Expected Result",
    Text = "✅ Slider should move to the typed value"
})

-- Mostrar notificación
LXAIL:Notify({
    Title = "Slider Input Test Ready",
    Content = "TextBox inputs should update sliders when typing values",
    Duration = 5,
    Type = "Info"
})

print("✅ SLIDER INPUT TEST SETUP COMPLETE:")
print("📊 Created 3 test sliders with different ranges:")
print("  • Speed: 1-200 (increment 1)")
print("  • Volume: 0-100% (increment 5)")  
print("  • Sensitivity: 0.1-5.0x (increment 0.1)")
print("")
print("🔍 FUNCTIONALITY TO TEST:")
print("  ✅ FocusLost: Type value → click outside → slider updates")
print("  ✅ Enter Key: Type value → press Enter → immediate update")
print("  ✅ Invalid Input: Type invalid → reverts to current value")
print("  ✅ Range Clamping: Type out-of-range → clamps to min/max")
print("")
print("📝 Test by typing numbers in the slider input boxes!")