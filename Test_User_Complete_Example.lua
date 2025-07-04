-- === TESTING COMPLETE USER EXAMPLE ===
print("=== TESTING COMPLETE USER EXAMPLE ===")

-- Load the library
local LXAIL = dofile("Main_LoadString.lua")

-- Test the exact user format
local Window = LXAIL:CreateWindow({
    Name = "LXAIL BETA",
    LoadingTitle = "Loading LXAIL...",
    LoadingSubtitle = "by fabianstyz",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Configs",
        FileName = "ConfigEjemplo"
    },
    Discord = {
        Enabled = true,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = {
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

-- Test CreateTab
local CombateTab = Window:CreateTab({
    Name = "Combate",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local TeleportTab = Window:CreateTab({
    Name = "Teleports", 
    Icon = "rbxassetid://4483345998",
    Visible = true
})

-- Test components
CombateTab:CreateLabel({
    Text = "🥊 Funciones de Combate"
})

CombateTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        print("Auto Farm:", Value and "ACTIVADO" or "DESACTIVADO")
    end,
})

CombateTab:CreateSlider({
    Name = "Velocidad de Ataque",
    Range = {1, 20},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 5,
    Flag = "VelocidadAtaque",
    Callback = function(Value)
        print("Velocidad de ataque:", Value)
    end,
})

CombateTab:CreateButton({
    Name = "Matar Todos los Enemigos",
    Callback = function()
        print("Ejecutando: Matar todos los enemigos")
        LXAIL:Notify({
            Title = "Combate",
            Content = "Atacando a todos los enemigos cercanos",
            Duration = 3,
            Type = "Warning"
        })
    end,
})

-- Test notifications
LXAIL:Notify({
    Title = "🎉 LXAIL Cargado!",
    Content = "Librería UI completa lista para usar. Presiona F para ocultar/mostrar.",
    Duration = 5,
    Type = "Success"
})

print("✅ Test completo terminado!")
print("📖 Todas las funciones probadas")
print("🎮 UI debería estar visible")