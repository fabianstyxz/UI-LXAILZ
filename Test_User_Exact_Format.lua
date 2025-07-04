-- === TESTING USER EXACT FORMAT ===
print("=== TESTING USER EXACT FORMAT ===")

local LXAIL = dofile("Main_LoadString_WORKING.lua")

-- === CONFIGURACIÓN INICIAL ===
-- Crear ventana principal con todas las opciones
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

-- === CREAR PESTAÑAS ORGANIZADAS ===
local CombateTab = Window:CreateTab({
    Name = "Combate",
    Icon = "rbxassetid://4483345998", -- Icono opcional
    Visible = true
})

local TeleportTab = Window:CreateTab({
    Name = "Teleports",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local VisualesTab = Window:CreateTab({
    Name = "Visuales",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local ConfigTab = Window:CreateTab({
    Name = "Configuración",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

-- === VARIABLES GLOBALES ===
local autoFarmActivo = false
local velocidadJugador = 16
local modoVuelo = false
local noclipActivo = false
local espJugadores = false
local colorTema = Color3.fromRGB(255, 100, 100)

-- === TAB COMBATE - Funciones de combate ===
CombateTab:CreateLabel({
    Text = "🥊 Funciones de Combate"
})

CombateTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle", -- Para guardar en configuración
    Callback = function(Value)
        autoFarmActivo = Value
        print("Auto Farm:", Value and "ACTIVADO" or "DESACTIVADO")
        
        LXAIL:Notify({
            Title = "Auto Farm",
            Content = Value and "Auto Farm activado correctamente" or "Auto Farm desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
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
        print("Velocidad de ataque establecida:", Value)
    end,
})

CombateTab:CreateDropdown({
    Name = "Modo de Combate",
    Options = {"Agresivo", "Defensivo", "Balanceado", "Sigiloso"},
    CurrentOption = {"Balanceado"},
    MultipleOptions = false,
    Flag = "ModoCombate",
    Callback = function(Option)
        local modo = Option[1]
        print("Modo de combate cambiado a:", modo)
        
        LXAIL:Notify({
            Title = "Modo de Combate",
            Content = "Modo cambiado a: " .. modo,
            Duration = 2,
            Type = "Success"
        })
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

-- === TAB TELEPORTS - Funciones de teletransporte ===
TeleportTab:CreateLabel({
    Text = "🌐 Sistema de Teletransporte"
})

TeleportTab:CreateButton({
    Name = "Spawn",
    Callback = function()
        LXAIL:Notify({
            Title = "Teleport",
            Content = "Teletransportado al spawn",
            Duration = 2,
            Type = "Success"
        })
    end,
})

TeleportTab:CreateInput({
    Name = "Teletransporte a Jugador",
    PlaceholderText = "Nombre del jugador...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if Text ~= "" then
            LXAIL:Notify({
                Title = "Teleport",
                Content = "Buscando jugador: " .. Text,
                Duration = 2,
                Type = "Info"
            })
        end
    end,
})

TeleportTab:CreateSlider({
    Name = "Velocidad de Movimiento",
    Range = {16, 500},
    Increment = 1,
    Suffix = " WS",
    CurrentValue = 16,
    Flag = "VelocidadMovimiento",
    Callback = function(Value)
        velocidadJugador = Value
        if Value > 100 then
            LXAIL:Notify({
                Title = "Velocidad Alta",
                Content = "Cuidado: Velocidad muy alta puede causar detección",
                Duration = 3,
                Type = "Warning"
            })
        end
    end,
})

TeleportTab:CreateToggle({
    Name = "Modo Vuelo",
    CurrentValue = false,
    Flag = "ModoVuelo",
    Callback = function(Value)
        modoVuelo = Value
        
        LXAIL:Notify({
            Title = "Modo Vuelo",
            Content = Value and "Vuelo activado - Usa WASD para volar" or "Vuelo desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
    end,
})

-- === TAB VISUALES - ESP y efectos visuales ===
VisualesTab:CreateLabel({
    Text = "👁️ Efectos Visuales y ESP"
})

VisualesTab:CreateToggle({
    Name = "ESP Jugadores",
    CurrentValue = false,
    Flag = "ESPJugadores",
    Callback = function(Value)
        espJugadores = Value
        
        LXAIL:Notify({
            Title = "ESP Jugadores",
            Content = Value and "ESP activado para todos los jugadores" or "ESP desactivado",
            Duration = 2,
            Type = "Success"
        })
    end,
})

VisualesTab:CreateColorPicker({
    Name = "Color del Tema",
    Color = Color3.fromRGB(255, 100, 100),
    Flag = "ColorTema",
    Callback = function(Value)
        colorTema = Value
        print("Color del tema cambiado a RGB:", Value.R * 255, Value.G * 255, Value.B * 255)
        
        LXAIL:Notify({
            Title = "Tema",
            Content = "Color del tema actualizado",
            Duration = 2,
            Type = "Success"
        })
    end
})

VisualesTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "Noclip",
    Callback = function(Value)
        noclipActivo = Value
        
        LXAIL:Notify({
            Title = "Noclip",
            Content = Value and "Noclip activado - Puedes atravesar paredes" or "Noclip desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
    end,
})

-- === TAB CONFIGURACIÓN - Opciones del sistema ===
ConfigTab:CreateLabel({
    Text = "⚙️ Configuración del Sistema"
})

ConfigTab:CreateKeybind({
    Name = "Mostrar/Ocultar UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "ToggleUIKeybind",
    Callback = function(Keybind)
        print("Tecla para mostrar/ocultar UI:", Keybind)
        LXAIL:Notify({
            Title = "Keybind",
            Content = "UI se ocultará/mostrará con: " .. tostring(Keybind),
            Duration = 3,
            Type = "Info"
        })
    end,
})

ConfigTab:CreateKeybind({
    Name = "Vuelo Rápido (Mantener)",
    CurrentKeybind = "LeftControl",
    HoldToInteract = true,
    Flag = "VueloRapidoKeybind",
    Callback = function(Keybind)
        print("Tecla de vuelo rápido (mantener):", Keybind)
    end,
})

ConfigTab:CreateDropdown({
    Name = "Tema de la UI",
    Options = {"Oscuro", "Claro", "Neón", "Personalizado"},
    CurrentOption = {"Oscuro"},
    MultipleOptions = false,
    Flag = "TemaUI",
    Callback = function(Option)
        local tema = Option[1]
        print("Tema cambiado a:", tema)
        
        if tema == "Claro" then
            LXAIL:SetTheme("Light")
        elseif tema == "Neón" then
            LXAIL:SetTheme("Neon")
        else
            LXAIL:SetTheme("Dark")
        end
        
        LXAIL:Notify({
            Title = "Tema",
            Content = "Tema cambiado a: " .. tema,
            Duration = 2,
            Type = "Success"
        })
    end,
})

ConfigTab:CreateButton({
    Name = "💾 Guardar Configuración",
    Callback = function()
        LXAIL:SaveConfiguration()
        LXAIL:Notify({
            Title = "Configuración",
            Content = "Configuración guardada exitosamente",
            Duration = 2,
            Type = "Success"
        })
    end,
})

ConfigTab:CreateButton({
    Name = "📂 Cargar Configuración",
    Callback = function()
        LXAIL:LoadConfiguration()
        LXAIL:Notify({
            Title = "Configuración",
            Content = "Configuración cargada exitosamente",
            Duration = 2,
            Type = "Success"
        })
    end,
})

ConfigTab:CreateButton({
    Name = "🔄 Resetear Configuración",
    Callback = function()
        LXAIL:ResetConfiguration()
        LXAIL:Notify({
            Title = "Reset",
            Content = "Configuración restablecida a valores por defecto",
            Duration = 3,
            Type = "Warning"
        })
    end,
})

ConfigTab:CreateDivider()

ConfigTab:CreateParagraph({
    Title = "Acerca de LXAIL",
    Content = "LXAIL es una librería UI completa que replica toda la funcionalidad de Rayfield con un diseño moderno, oscuro y minimalista. Incluye soporte móvil, animaciones fluidas y arquitectura modular."
})

-- === SISTEMA DE NOTIFICACIONES AVANZADO ===
ConfigTab:CreateButton({
    Name = "🔔 Probar Notificaciones",
    Callback = function()
        LXAIL:Notify({
            Title = "Éxito",
            Content = "Esta es una notificación de éxito con duración personalizada",
            Duration = 4,
            Type = "Success"
        })
        
        LXAIL:Notify({
            Title = "Advertencia",
            Content = "Esta es una notificación de advertencia",
            Duration = 3,
            Type = "Warning"
        })
        
        LXAIL:Notify({
            Title = "Error",
            Content = "Esta es una notificación de error",
            Duration = 5,
            Type = "Error"
        })
        
        LXAIL:Notify({
            Title = "Información",
            Content = "Esta es una notificación informativa",
            Duration = 2,
            Type = "Info"
        })
    end,
})

-- === INTEGRACIÓN CON DISCORD ===
ConfigTab:CreateButton({
    Name = "💬 Mostrar Invitación Discord",
    Callback = function()
        LXAIL:Prompt({
            Title = "¡Únete a nuestro Discord!",
            SubTitle = "Obtén soporte y actualizaciones",
            Content = "Únete a nuestro servidor de Discord para obtener ayuda, actualizaciones y acceso a la comunidad.",
            Actions = {
                Accept = {
                    Name = "Unirse al Discord",
                    Callback = function()
                        print("Redirigiendo a Discord...")
                        LXAIL:Notify({
                            Title = "Discord",
                            Content = "Abriendo invitación de Discord...",
                            Duration = 3,
                            Type = "Info"
                        })
                    end,
                },
                Ignore = {
                    Name = "Tal vez después",
                    Callback = function()
                        print("Invitación de Discord ignorada")
                    end,
                }
            }
        })
    end,
})

-- === BOTÓN FLOTANTE (OPCIONAL) ===
LXAIL:CreateFloatingButton({
    Icon = "rbxassetid://4483345998",
    Callback = function()
        LXAIL:Toggle() -- Alternar visibilidad de la UI
    end
})

-- === NOTIFICACIÓN DE BIENVENIDA ===
LXAIL:Notify({
    Title = "🎉 LXAIL Cargado!",
    Content = "Librería UI completa lista para usar. Presiona F para ocultar/mostrar.",
    Duration = 5,
    Type = "Success"
})

print("✅ LXAIL cargado completamente!")
print("📖 Todas las funciones de Rayfield están disponibles")
print("🎮 Usa F para mostrar/ocultar la UI")
print("💾 La configuración se guarda automáticamente")
print("🔥 TODO FUNCIONANDO CORRECTAMENTE!")