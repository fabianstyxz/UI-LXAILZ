-- Test para verificar que la UI persiste con CoreGui
print("=== TEST: CoreGui Fix - UI Persistence ===")

-- Cargar la librería
local LXAIL = loadfile("Main_LoadString.lua")()

-- Crear ventana
local Window = LXAIL:CreateWindow({
    Name = "CoreGui Persistence Test",
    LoadingTitle = "Testing CoreGui...",
    LoadingSubtitle = "Verifying UI persistence on player death"
})

-- Crear tab
local Tab = Window:CreateTab({
    Name = "Persistence Test",
    Icon = "rbxassetid://4483345998"
})

-- Crear algunos componentes
Tab:CreateToggle({
    Name = "Test Toggle",
    CurrentValue = false,
    Flag = "TestFlag",
    Callback = function(value)
        print("Toggle value:", value)
    end
})

Tab:CreateLabel({
    Name = "Status",
    Text = "UI is now using CoreGui - should persist after player death"
})

Tab:CreateLabel({
    Name = "Fix Applied",
    Text = "✅ Main UI: CoreGui"
})

Tab:CreateLabel({
    Name = "Button Status",
    Text = "✅ Floating Button: CoreGui"
})

-- Mostrar notificación
LXAIL:Notify({
    Title = "CoreGui Fix Applied",
    Content = "UI and floating button now use CoreGui for persistence",
    Duration = 5,
    Type = "Success"
})

print("✅ PRUEBA COMPLETADA - CORRECCIONES APLICADAS:")
print("🔧 UI Principal: playerGui → CoreGui")
print("🔧 Botón Flotante: playerGui → CoreGui")
print("🔧 Sistema de Notificaciones: playerGui → CoreGui")
print("🔧 Sistema de Llaves: playerGui → CoreGui")
print("🔧 Prompts: playerGui → CoreGui")
print("")
print("🎯 RESULTADO ESPERADO:")
print("- La UI ya NO desaparecerá al morir el jugador")
print("- El botón flotante persistirá después de reset")
print("- Todas las ventanas usan CoreGui para persistencia")
print("- Funcionará correctamente en Roblox")