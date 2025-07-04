-- Test simple del botón flotante
print("=== TEST: Simple Floating Button ===")

-- Cargar la librería
local LXAIL = loadfile("Main_LoadString.lua")()

-- Crear ventana simple
local Window = LXAIL:CreateWindow({
    Name = "Button Test"
})

print("✅ Window created successfully")
print("🔲 Floating button should be visible")
print("🎯 Button functionality should work properly")
print("📝 Test completed")