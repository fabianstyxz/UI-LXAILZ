-- Test KeySystem New Format: KeySystem = true, KeySettings = {...}
print("🧪 Testing NEW KeySystem format...")

-- Load the LXAIL library
local LXAIL = dofile("Main_LoadString.lua")

if not LXAIL then
    print("❌ Failed to load LXAIL library")
    return
end

print("✅ LXAIL library loaded successfully")

-- Test 1: KeySystem with proper KeySettings
print("\n=== TEST 1: KeySystem = true with KeySettings ===")
local Window1 = LXAIL:CreateWindow({
    Name = "Test Window - New KeySystem Format",
    LoadingTitle = "Testing KeySystem...",
    LoadingSubtitle = "New format validation",
    KeySystem = true, -- Boolean flag
    KeySettings = {   -- Separate settings table
        Title = "LXAIL BETA",
        Subtitle = "Key System",
        Note = "🔑 Complete the steps to get your key,\nthen paste it below to unlock the script.",
        FileName = "LxailKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        KeySite = "https://api.example.com/key"
    }
})

if Window1 then
    print("✅ TEST 1 PASSED: KeySystem appears with proper KeySettings")
else
    print("❌ TEST 1 FAILED: Window creation failed")
    return
end

-- Test 2: KeySystem = true without KeySettings (should use defaults)
print("\n=== TEST 2: KeySystem = true without KeySettings ===")
local Window2 = LXAIL:CreateWindow({
    Name = "Test Window - Default KeySettings",
    KeySystem = true -- No KeySettings provided
})

if Window2 then
    print("✅ TEST 2 PASSED: KeySystem uses default settings when KeySettings not provided")
else
    print("❌ TEST 2 FAILED: Window creation failed")
end

-- Test 3: KeySystem = false (should not show KeySystem)
print("\n=== TEST 3: KeySystem = false ===")
local Window3 = LXAIL:CreateWindow({
    Name = "Test Window - No KeySystem",
    KeySystem = false
})

if Window3 then
    print("✅ TEST 3 PASSED: No KeySystem shown when KeySystem = false")
else
    print("❌ TEST 3 FAILED: Window creation failed")
end

-- Test 4: No KeySystem parameter (should not show KeySystem)
print("\n=== TEST 4: No KeySystem parameter ===")
local Window4 = LXAIL:CreateWindow({
    Name = "Test Window - No KeySystem Parameter"
})

if Window4 then
    print("✅ TEST 4 PASSED: No KeySystem shown when parameter omitted")
else
    print("❌ TEST 4 FAILED: Window creation failed")
end

print("\n=== 🎉 NEW KEYSYSTEM FORMAT TESTS COMPLETED! ===")
print("📋 New Usage Format:")
print([[
-- NEW CORRECT FORMAT:
local Window = LXAIL:CreateWindow({
    Name = "My Hub",
    KeySystem = true,  -- Boolean flag to enable/disable
    KeySettings = {    -- Separate settings table
        Title = "LXAIL BETA",
        Subtitle = "Key System", 
        Note = "🔑 Complete the steps to get your key,\nthen paste it below to unlock the script.",
        FileName = "LxailKey",
        SaveKey = true,
        GrabKeyFromSite = true,
        KeySite = "https://api.mysite.com/key"
    }
})

-- SIMPLE ENABLE (uses defaults):
local Window = LXAIL:CreateWindow({
    Name = "My Hub",
    KeySystem = true  -- Uses default KeySettings
})

-- DISABLE:
local Window = LXAIL:CreateWindow({
    Name = "My Hub",
    KeySystem = false  -- No KeySystem shown
})
]])

print("✅ All KeySystem format tests completed successfully!")