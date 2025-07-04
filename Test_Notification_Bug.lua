-- Test to debug notification system
print("🧪 Testing LXAIL Notification System...")

-- Load the main library
local success, LXAIL = pcall(function()
    return dofile("Main_LoadString.lua")
end)

if not success then
    print("❌ Error loading library:", LXAIL)
    return
end

print("✅ Library loaded successfully")

-- Test notification directly
print("🔔 Testing notification system...")

local testSuccess, testError = pcall(function()
    LXAIL:Notify({
        Title = "Test Notification",
        Content = "This is a test notification to debug the issue",
        Duration = 3,
        Type = "Success"
    })
end)

if not testSuccess then
    print("❌ Notification error:", testError)
else
    print("✅ Notification called successfully")
end

-- Check if Notifications table exists
print("📊 Notifications table status:", type(LXAIL.Notifications))
print("📊 Notifications count:", #LXAIL.Notifications)

-- Test with different types
print("🔔 Testing different notification types...")

spawn(function()
    wait(1)
    pcall(function()
        LXAIL:Notify({
            Title = "Warning Test",
            Content = "Warning notification test",
            Duration = 2,
            Type = "Warning"
        })
    end)
    
    wait(1)
    pcall(function()
        LXAIL:Notify({
            Title = "Error Test", 
            Content = "Error notification test",
            Duration = 2,
            Type = "Error"
        })
    end)
    
    wait(1)
    pcall(function()
        LXAIL:Notify({
            Title = "Info Test",
            Content = "Info notification test", 
            Duration = 2,
            Type = "Info"
        })
    end)
end)

print("🧪 Notification test completed")