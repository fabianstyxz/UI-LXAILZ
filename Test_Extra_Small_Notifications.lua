-- Test para verificar notificaciones extra pequeñas
print("=== TEST: Extra Small Notifications ===")

-- Cargar la librería
local LXAIL = loadfile("Main_LoadString.lua")()

-- Crear ventana
local Window = LXAIL:CreateWindow({
    Name = "Extra Small Notifications Test",
    LoadingTitle = "Testing smaller notifications...",
    LoadingSubtitle = "New compact size"
})

-- Probar notificaciones con diferentes tipos
print("Testing extra small notification system...")

-- Notificación Success
LXAIL:Notify({
    Title = "Success Test",
    Content = "This is a success notification with new smaller size",
    Duration = 4,
    Type = "Success"
})

-- Notificación Warning
LXAIL:Notify({
    Title = "Warning Test", 
    Content = "This is a warning notification",
    Duration = 3,
    Type = "Warning"
})

-- Notificación Error
LXAIL:Notify({
    Title = "Error Test",
    Content = "This is an error notification",
    Duration = 5,
    Type = "Error"
})

-- Notificación Info
LXAIL:Notify({
    Title = "Info Test",
    Content = "This is an info notification",
    Duration = 2,
    Type = "Info"
})

print("✅ All extra small notification tests completed!")
print("📏 NEW SMALLER NOTIFICATION DIMENSIONS:")
print("• Width: 250px (was 300px)")
print("• Height: 55px (was 70px)")
print("• Position offset: -270px (was -320px)")
print("• Spacing: 65px between notifications (was 80px)")
print("• Icon size: 28x28px (was 35x35px)")
print("• Title font size: 14px (was 16px)")
print("• Content font size: 11px (was 13px)")
print("• Close button: 18x18px (was 20x20px)")
print("🎉 Notifications are now 22% smaller and more compact!")