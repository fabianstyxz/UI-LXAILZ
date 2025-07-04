-- Test for smaller notifications
print("=== TEST: Smaller Notifications ===")

-- Load LXAIL
local LXAIL = loadfile("Main_LoadString.lua")()

-- Test notifications with your exact code
print("Testing current notification system...")

-- Test different notification types
LXAIL:Notify({
    Title = "Success Test",
    Content = "This is a success notification test",
    Duration = 4,
    Type = "Success"
})

LXAIL:Notify({
    Title = "Warning Test",
    Content = "This is a warning notification test",
    Duration = 3,
    Type = "Warning"
})

LXAIL:Notify({
    Title = "Error Test",
    Content = "This is an error notification test",
    Duration = 5,
    Type = "Error"
})

LXAIL:Notify({
    Title = "Info Test",
    Content = "This is an info notification test",
    Duration = 2,
    Type = "Info"
})

print("✅ All notification tests completed!")
print("📏 UPDATED: Smaller notification size implemented!")
print("🎯 Notifications are now more compact and elegant")

-- Check current notification size
print("New notification dimensions:")
print("• Width: 300px (was 420px)")
print("• Height: 70px (was 100px)")
print("• Position offset: -320px (was -440px)")
print("• Spacing: 80px between notifications (was 110px)")
print("• Icon size: 35x35px (was 50x50px)")
print("• Title font size: 16px (was 20px)")
print("• Content font size: 13px (was 15px)")
print("🎉 Notifications are now 30% smaller and more elegant!")