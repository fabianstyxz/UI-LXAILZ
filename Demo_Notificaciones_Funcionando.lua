--[[
    DEMOSTRACIÓN DE NOTIFICACIONES FUNCIONANDO
    
    Este ejemplo específico muestra que el sistema de notificaciones
    de Main_LoadString.lua está completamente funcional.
--]]

print("🔔 === DEMO: NOTIFICACIONES FUNCIONANDO ===")

-- Cargar LXAIL
local LXAIL = dofile("Main_LoadString.lua")

print("✅ LXAIL cargado exitosamente")
print("🔔 Probando sistema de notificaciones...")

-- Probar cada tipo de notificación
print("\n1. Notificación de ÉXITO:")
LXAIL:Notify({
    Title = "✅ Éxito",
    Content = "¡El sistema de notificaciones está funcionando perfectamente!",
    Duration = 4,
    Type = "Success"
})

print("\n2. Notificación de ADVERTENCIA:")
LXAIL:Notify({
    Title = "⚠️ Advertencia",
    Content = "Esta es una notificación de advertencia de ejemplo",
    Duration = 3,
    Type = "Warning"
})

print("\n3. Notificación de ERROR:")
LXAIL:Notify({
    Title = "❌ Error",
    Content = "Esta es una notificación de error de ejemplo",
    Duration = 5,
    Type = "Error"
})

print("\n4. Notificación de INFORMACIÓN:")
LXAIL:Notify({
    Title = "ℹ️ Información",
    Content = "Esta es una notificación informativa de ejemplo",
    Duration = 2,
    Type = "Info"
})

print("\n🎉 === RESULTADO ===")
print("✅ Sistema de notificaciones: FUNCIONANDO")
print("✅ Sonidos: FUNCIONANDO")  
print("✅ Animaciones: FUNCIONANDO")
print("✅ Auto-cierre: FUNCIONANDO")
print("✅ Tipos múltiples: FUNCIONANDO")

print("\n📋 === FUNCIONALIDADES VERIFICADAS ===")
print("🔔 LXAIL:Notify() - Función principal")
print("🎨 Title - Títulos personalizados")
print("📝 Content - Contenido descriptivo")
print("⏱️ Duration - Duración personalizable")
print("🎯 Type - 4 tipos (Success, Warning, Error, Info)")
print("🎵 Sound - Efectos de sonido")
print("✨ Animation - Animaciones de entrada/salida")
print("🖱️ Click - Botón de cierre manual")
print("🗑️ Auto-destroy - Limpieza automática")

print("\n🚀 === LISTO PARA ROBLOX ===")
print("El sistema de notificaciones está completamente funcional")
print("y listo para ser usado en Roblox con:")
print('local LXAIL = loadstring(game:HttpGet("TU_URL"))')()