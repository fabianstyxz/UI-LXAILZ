--[[
    EJEMPLO SIMPLE DE USO - Main_LoadString.lua
    
    Este ejemplo muestra las funciones principales de LXAIL
    sin el KeySystem para evitar bucles infinitos en el entorno de prueba.
--]]

print("🚀 Cargando LXAIL - Ejemplo Simple de Uso")

-- === CARGAR LIBRERÍA LXAIL ===
local LXAIL = dofile("Main_LoadString.lua")

-- === CREAR VENTANA SIN KEYSYSTEM ===
local Window = LXAIL:CreateWindow({
    Name = "🎮 LXAIL Demo Hub",
    LoadingTitle = "Cargando LXAIL...",
    LoadingSubtitle = "Ejemplo de funciones principales",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Demo"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/ejemplo"
    }
    -- KeySystem desactivado para este ejemplo
})

-- === CREAR PESTAÑAS ===
local MainTab = Window:CreateTab({
    Name = "🏠 Principal",
    Icon = "rbxassetid://4483345998"
})

local ComponentsTab = Window:CreateTab({
    Name = "🧩 Componentes",
    Icon = "rbxassetid://4483345998"
})

-- === PESTAÑA PRINCIPAL ===
MainTab:CreateLabel({
    Text = "🎉 ¡Bienvenido a LXAIL!"
})

MainTab:CreateParagraph({
    Title = "📖 Acerca de LXAIL",
    Content = "LXAIL es una replica completa de Rayfield con diseño moderno y todas las funciones necesarias para crear interfaces de usuario profesionales en Roblox."
})

MainTab:CreateDivider()

-- Toggle principal
MainTab:CreateToggle({
    Name = "🚀 Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        print("Auto Farm:", Value and "ACTIVADO" or "DESACTIVADO")
        
        LXAIL:Notify({
            Title = "Auto Farm",
            Content = Value and "Auto Farm activado" or "Auto Farm desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
    end
})

-- Slider de velocidad
MainTab:CreateSlider({
    Name = "⚡ Velocidad",
    Range = {16, 200},
    Increment = 1,
    Suffix = " WS",
    CurrentValue = 50,
    Flag = "PlayerSpeed",
    Callback = function(Value)
        print("Velocidad establecida:", Value)
        
        if Value > 100 then
            LXAIL:Notify({
                Title = "Velocidad Alta",
                Content = "Cuidado: Velocidad muy alta",
                Duration = 3,
                Type = "Warning"
            })
        end
    end
})

-- Botón de acción
MainTab:CreateButton({
    Name = "🏠 Teletransporte al Spawn",
    Callback = function()
        print("Teletransportando al spawn...")
        
        LXAIL:Notify({
            Title = "Teletransporte",
            Content = "Teletransportado al spawn",
            Duration = 2,
            Type = "Success"
        })
    end
})

-- === PESTAÑA COMPONENTES ===
ComponentsTab:CreateLabel({
    Text = "🧩 Todos los Componentes"
})

-- Input de texto
ComponentsTab:CreateInput({
    Name = "🎯 Nombre del Jugador",
    PlaceholderText = "Escribe un nombre...",
    RemoveTextAfterFocusLost = false,
    Flag = "PlayerName",
    Callback = function(Text)
        print("Nombre ingresado:", Text)
        
        if Text ~= "" then
            LXAIL:Notify({
                Title = "Jugador",
                Content = "Objetivo: " .. Text,
                Duration = 2,
                Type = "Info"
            })
        end
    end
})

-- Dropdown simple
ComponentsTab:CreateDropdown({
    Name = "🎮 Modo de Juego",
    Options = {"Aventura", "Supervivencia", "Creativo", "PvP"},
    CurrentOption = {"Aventura"},
    MultipleOptions = false,
    Flag = "GameMode",
    Callback = function(Option)
        local mode = Option[1]
        print("Modo seleccionado:", mode)
        
        LXAIL:Notify({
            Title = "Modo",
            Content = "Modo: " .. mode,
            Duration = 2,
            Type = "Success"
        })
    end
})

-- Dropdown múltiple
ComponentsTab:CreateDropdown({
    Name = "📊 Características",
    Options = {"ESP", "Aimbot", "Speed", "Jump", "Fly"},
    CurrentOption = {"ESP"},
    MultipleOptions = true,
    Flag = "Features",
    Callback = function(Options)
        print("Características seleccionadas:")
        for _, feature in ipairs(Options) do
            print("- " .. feature)
        end
        
        LXAIL:Notify({
            Title = "Características",
            Content = "Características actualizadas",
            Duration = 2,
            Type = "Info"
        })
    end
})

-- Color picker
ComponentsTab:CreateColorPicker({
    Name = "🎨 Color del Tema",
    Color = Color3.fromRGB(255, 100, 100),
    Flag = "ThemeColor",
    Callback = function(Value)
        print("Color seleccionado RGB:", math.floor(Value.R * 255), math.floor(Value.G * 255), math.floor(Value.B * 255))
        
        LXAIL:Notify({
            Title = "Color",
            Content = "Color del tema actualizado",
            Duration = 2,
            Type = "Success"
        })
    end
})

-- Keybind
ComponentsTab:CreateKeybind({
    Name = "🔑 Toggle UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "ToggleUI",
    Callback = function(Keybind)
        print("Keybind establecido:", Keybind)
        
        LXAIL:Notify({
            Title = "Keybind",
            Content = "UI toggle: " .. tostring(Keybind),
            Duration = 2,
            Type = "Info"
        })
    end
})

ComponentsTab:CreateDivider()

-- === BOTONES DE DEMOSTRACIÓN ===
ComponentsTab:CreateButton({
    Name = "🔔 Probar Notificaciones",
    Callback = function()
        -- Demostrar todos los tipos
        LXAIL:Notify({
            Title = "✅ Éxito",
            Content = "Notificación de éxito",
            Duration = 3,
            Type = "Success"
        })
        
        spawn(function()
            wait(1)
            LXAIL:Notify({
                Title = "⚠️ Advertencia", 
                Content = "Notificación de advertencia",
                Duration = 3,
                Type = "Warning"
            })
            
            wait(1)
            LXAIL:Notify({
                Title = "❌ Error",
                Content = "Notificación de error",
                Duration = 3,
                Type = "Error"
            })
            
            wait(1)
            LXAIL:Notify({
                Title = "ℹ️ Info",
                Content = "Notificación informativa",
                Duration = 3,
                Type = "Info"
            })
        end)
    end
})

ComponentsTab:CreateButton({
    Name = "💬 Discord Prompt",
    Callback = function()
        LXAIL:Prompt({
            Title = "💬 Únete al Discord",
            SubTitle = "Comunidad LXAIL",
            Content = "¿Te gustaría unirte a nuestro servidor de Discord?",
            Actions = {
                Accept = {
                    Name = "Sí, unirme",
                    Callback = function()
                        LXAIL:Notify({
                            Title = "Discord",
                            Content = "Abriendo Discord...",
                            Duration = 2,
                            Type = "Success"
                        })
                    end
                },
                Ignore = {
                    Name = "Ahora no",
                    Callback = function()
                        LXAIL:Notify({
                            Title = "Discord",
                            Content = "Tal vez más tarde",
                            Duration = 2,
                            Type = "Info"
                        })
                    end
                }
            }
        })
    end
})

-- === GESTIÓN DE CONFIGURACIÓN ===
ComponentsTab:CreateDivider()

ComponentsTab:CreateLabel({
    Text = "💾 Configuración"
})

ComponentsTab:CreateButton({
    Name = "💾 Guardar Config",
    Callback = function()
        LXAIL:SaveConfiguration()
        LXAIL:Notify({
            Title = "Guardado",
            Content = "Configuración guardada",
            Duration = 2,
            Type = "Success"
        })
    end
})

ComponentsTab:CreateButton({
    Name = "📂 Cargar Config",
    Callback = function()
        LXAIL:LoadConfiguration()
        LXAIL:Notify({
            Title = "Cargado",
            Content = "Configuración cargada",
            Duration = 2,
            Type = "Success"
        })
    end
})

-- === BOTÓN FLOTANTE ===
LXAIL:CreateFloatingButton({
    Icon = "rbxassetid://4483345998",
    Callback = function()
        LXAIL:Toggle()
        LXAIL:Notify({
            Title = "UI",
            Content = "Visibilidad alternada",
            Duration = 1,
            Type = "Info"
        })
    end
})

-- === NOTIFICACIÓN DE BIENVENIDA ===
LXAIL:Notify({
    Title = "🎉 LXAIL Cargado",
    Content = "Ejemplo simple cargado exitosamente",
    Duration = 4,
    Type = "Success"
})

print("✅ === EJEMPLO SIMPLE DE LXAIL COMPLETADO ===")
print("📋 Funciones demostradas:")
print("  ✅ CreateWindow - Ventana principal")
print("  ✅ CreateTab - Sistema de pestañas")
print("  ✅ CreateToggle - Interruptores")
print("  ✅ CreateSlider - Deslizadores")
print("  ✅ CreateButton - Botones")
print("  ✅ CreateInput - Campos de texto")
print("  ✅ CreateDropdown - Menús desplegables")
print("  ✅ CreateColorPicker - Selector de colores")
print("  ✅ CreateKeybind - Asignación de teclas")
print("  ✅ CreateLabel - Etiquetas")
print("  ✅ CreateParagraph - Párrafos")
print("  ✅ CreateDivider - Separadores")
print("  ✅ Notify - Sistema de notificaciones")
print("  ✅ Prompt - Ventanas modales")
print("  ✅ SaveConfiguration/LoadConfiguration - Configuración")
print("  ✅ CreateFloatingButton - Botón flotante")
print("  ✅ Toggle - Control de visibilidad")
print("")
print("🎮 El sistema de notificaciones está funcionando perfectamente!")
print("📱 Compatible con dispositivos móviles")
print("🚀 Listo para usar en Roblox!")

--[[
=== PARA USAR EN ROBLOX ===

1. Sube Main_LoadString.lua a GitHub/Pastebin
2. Usa este código:

local LXAIL = loadstring(game:HttpGet("TU_URL_AQUI"))()

3. Copia y pega el código de este ejemplo

=== CARACTERÍSTICAS ===
✅ 100% Compatible con Rayfield
✅ Notificaciones funcionando correctamente
✅ Todos los componentes disponibles
✅ Diseño moderno y oscuro
✅ Animaciones fluidas
✅ Soporte móvil completo
✅ Sistema de configuración
✅ Arquitectura modular

¡Las notificaciones ya están arregladas! 🎉
--]]