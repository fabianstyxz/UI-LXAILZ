-- Test con el formato EXACTO del usuario
print("🧪 Testing with USER's EXACT FORMAT...")

-- Load the LXAIL library
local LXAIL = dofile("Main_LoadString.lua")

if not LXAIL then
    print("❌ Failed to load LXAIL library")
    return
end

print("✅ LXAIL library loaded successfully")

-- Usar EXACTAMENTE el mismo formato que el usuario
local Window = LXAIL:CreateWindow({
    Name = "LXAIL BETA",
    LoadingTitle = "Loading LXAIL...",
    LoadingSubtitle = "by fabianstyz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Configs", -- Carpeta donde se guardan configs
        FileName = "ConfigEjemplo"     -- Nombre del archivo de configuración
    },
    Discord = {
        Enabled = true,
        Invite = "noinvitelink",       -- Reemplaza con tu invite de Discord
        RememberJoins = true
    },
    KeySystem = {  -- ❗ FORMATO EXACTO DEL USUARIO
        Enabled = true,
        Title = "Keysystem",
        Subtitle = "by fabianstyx",
        Note = "get your key in the web",
        FileName = "LXAIL_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"LXAIL_DEMO_2024", "ADMIN_ACCESS", "VIP_USER", "FREE_KEY"}
    }
})

print("📝 Testing KeySystem format:")
print("   KeySystem.Enabled =", Window and "true" or "false")
print("   KeySystem should appear automatically if Enabled = true")

if Window then
    print("✅ Window created with KeySystem format!")
    
    -- Test creating a tab
    local TestTab = Window:CreateTab({
        Name = "Test Tab",
        Icon = "rbxassetid://4483345998",
        Visible = true
    })
    
    if TestTab then
        print("✅ Tab created successfully!")
        
        -- Test a toggle
        TestTab:CreateToggle({
            Name = "Test Toggle",
            CurrentValue = false,
            Flag = "TestToggle",
            Callback = function(Value)
                print("Toggle clicked:", Value)
            end,
        })
        
        -- Test floating button
        LXAIL:CreateFloatingButton({
            Icon = "rbxassetid://4483345998",
            Callback = function()
                print("🔘 Floating button clicked - should toggle UI!")
                LXAIL:Toggle() -- Toggle UI visibility
            end
        })
        
        print("✅ All components created!")
    else
        print("❌ Failed to create tab")
    end
else
    print("❌ Failed to create window")
end

print("\n=== USER FORMAT TEST COMPLETED ===")
print("Expected behavior:")
print("1. KeySystem should appear immediately (Enabled = true)")
print("2. Floating button should be draggable")
print("3. Floating button click should toggle UI visibility")
print("4. All components should work exactly as shown")