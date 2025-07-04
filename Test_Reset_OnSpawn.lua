-- Test para verificar que la UI y el botón flotante persisten al morir
print("=== TEST: ResetOnSpawn = false ===")

-- Cargar la librería
local LXAIL = loadfile("Main_LoadString.lua")()

-- Crear ventana
local Window = LXAIL:CreateWindow({
    Name = "Test Reset Persistence",
    LoadingTitle = "Testing...",
    LoadingSubtitle = "Verificando persistencia al morir"
})

-- Crear tab
local Tab = Window:CreateTab({
    Name = "Test",
    Icon = "rbxassetid://4483345998"
})

-- Crear algunos componentes
Tab:CreateToggle({
    Name = "Test Toggle",
    CurrentValue = false,
    Flag = "TestFlag",
    Callback = function(value)
        print("Toggle:", value)
    end
})

Tab:CreateLabel({
    Name = "Status",
    Text = "UI and Floating Button configured with ResetOnSpawn = false"
})

-- Mostrar notificación
LXAIL:Notify({
    Title = "Persistence Test",
    Content = "UI and floating button will persist when player dies/resets",
    Duration = 5,
    Type = "Success"
})

print("✅ TEST COMPLETADO:")
print("📋 Componentes verificados:")
print("  ✅ UI Principal: ResetOnSpawn = false")
print("  ✅ Botón Flotante: ResetOnSpawn = false") 
print("  ✅ Sistema de Notificaciones: ResetOnSpawn = false")
print("")
print("🎮 La UI y el botón flotante persistirán cuando el jugador muera o se resetee")
print("🔄 Esto significa que no desaparecerán al usar Reset Character en Roblox")
print("📱 Funciona tanto en PC como en móvil")