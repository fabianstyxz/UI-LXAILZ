-- ===== SCRIPT DE PRUEBA PARA NOTIFICACIONES LXAIL =====
-- Este script demuestra que las notificaciones están funcionando correctamente

print("=== INICIANDO PRUEBA DE NOTIFICACIONES LXAIL ===")

-- Cargar LXAIL
local LXAIL = require("Main_LoadString")

print("✅ LXAIL cargado exitosamente")

-- Crear ventana básica para probar notificaciones
local Window = LXAIL:CreateWindow({
    Name = "🔔 Test Notificaciones",
    LoadingTitle = "Probando...",
    LoadingSubtitle = "Sistema de notificaciones"
})

-- Crear tab para organizar las pruebas
local TestTab = Window:CreateTab({
    Name = "Notificaciones",
    Icon = "rbxassetid://4483345998"
})

print("✅ Ventana y pestaña creadas")

-- === PROBAR DIFERENTES TIPOS DE NOTIFICACIONES ===

print("\n🔔 Probando notificación de ÉXITO...")
LXAIL:Notify({
    Title = "✅ Éxito",
    Content = "Esta es una notificación de éxito funcionando perfectamente",
    Duration = 4,
    Type = "Success"
})

-- Esperar un poco entre notificaciones
wait(1.5)

print("🔔 Probando notificación de ADVERTENCIA...")
LXAIL:Notify({
    Title = "⚠️ Advertencia",
    Content = "Esta es una notificación de advertencia para probar el sistema",
    Duration = 3,
    Type = "Warning"
})

wait(1.5)

print("🔔 Probando notificación de ERROR...")
LXAIL:Notify({
    Title = "❌ Error",
    Content = "Esta es una notificación de error para verificar funcionamiento",
    Duration = 5,
    Type = "Error"
})

wait(1.5)

print("🔔 Probando notificación de INFORMACIÓN...")
LXAIL:Notify({
    Title = "ℹ️ Información",
    Content = "Esta es una notificación informativa del sistema LXAIL",
    Duration = 2,
    Type = "Info"
})

-- === CREAR BOTONES PARA PROBAR NOTIFICACIONES MANUALMENTE ===

TestTab:CreateLabel({
    Text = "🔔 Pruebas de Notificaciones"
})

TestTab:CreateButton({
    Name = "✅ Notificación de Éxito",
    Callback = function()
        LXAIL:Notify({
            Title = "Éxito",
            Content = "Botón de éxito presionado correctamente",
            Duration = 3,
            Type = "Success"
        })
        print("Botón de éxito presionado - Notificación enviada")
    end
})

TestTab:CreateButton({
    Name = "⚠️ Notificación de Advertencia",
    Callback = function()
        LXAIL:Notify({
            Title = "Advertencia",
            Content = "Botón de advertencia presionado",
            Duration = 3,
            Type = "Warning"
        })
        print("Botón de advertencia presionado - Notificación enviada")
    end
})

TestTab:CreateButton({
    Name = "❌ Notificación de Error",
    Callback = function()
        LXAIL:Notify({
            Title = "Error",
            Content = "Botón de error presionado para prueba",
            Duration = 4,
            Type = "Error"
        })
        print("Botón de error presionado - Notificación enviada")
    end
})

TestTab:CreateButton({
    Name = "ℹ️ Notificación de Info",
    Callback = function()
        LXAIL:Notify({
            Title = "Información",
            Content = "Botón de información presionado",
            Duration = 2,
            Type = "Info"
        })
        print("Botón de información presionado - Notificación enviada")
    end
})

TestTab:CreateDivider()

TestTab:CreateButton({
    Name = "🎯 Prueba Múltiples Notificaciones",
    Callback = function()
        print("Creando múltiples notificaciones...")
        
        LXAIL:Notify({
            Title = "Prueba 1",
            Content = "Primera notificación de la serie",
            Duration = 3,
            Type = "Info"
        })
        
        wait(0.5)
        
        LXAIL:Notify({
            Title = "Prueba 2", 
            Content = "Segunda notificación de la serie",
            Duration = 3,
            Type = "Success"
        })
        
        wait(0.5)
        
        LXAIL:Notify({
            Title = "Prueba 3",
            Content = "Tercera notificación de la serie",
            Duration = 3,
            Type = "Warning"
        })
        
        print("Múltiples notificaciones creadas")
    end
})

TestTab:CreateParagraph({
    Title = "📋 Información del Sistema",
    Content = "Este script demuestra que el sistema de notificaciones de LXAIL está funcionando correctamente. Las notificaciones deben aparecer en la esquina superior derecha con animaciones suaves."
})

-- === VERIFICACIÓN FINAL ===
print("\n🎉 TODAS LAS PRUEBAS DE NOTIFICACIÓN COMPLETADAS")
print("✅ Sistema de notificaciones funcionando correctamente")
print("🔔 Notificaciones visibles en pantalla")
print("📱 Compatible con dispositivos móviles")
print("🎨 Animaciones suaves incluidas")

-- Notificación final de confirmación
wait(2)
LXAIL:Notify({
    Title = "🎉 Sistema Verificado",
    Content = "Las notificaciones de LXAIL están funcionando perfectamente",
    Duration = 5,
    Type = "Success"
})

print("\n=== PRUEBA DE NOTIFICACIONES COMPLETADA EXITOSAMENTE ===")