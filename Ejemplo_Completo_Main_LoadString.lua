--[[
    EJEMPLO COMPLETO DE USO - Main_LoadString.lua
    
    Este ejemplo muestra cómo usar todas las funciones disponibles en LXAIL
    para crear una interfaz completa de usuario para Roblox.
    
    Funciones incluidas:
    - CreateWindow con todas las opciones
    - CreateTab con múltiples pestañas
    - Todos los componentes (Toggle, Slider, Button, Input, Dropdown, etc.)
    - Sistema de notificaciones
    - Sistema de configuración
    - Integración con Discord
    - Sistema de teclas (KeySystem)
    - Botón flotante
    - Sistema de temas
--]]

print("🚀 Cargando LXAIL - Ejemplo Completo de Uso")

-- === CARGAR LIBRERÍA LXAIL ===
local LXAIL = dofile("Main_LoadString.lua")

-- === CONFIGURACIÓN INICIAL ===
-- Crear ventana principal con todas las opciones disponibles
local Window = LXAIL:CreateWindow({
    Name = "🎮 LXAIL Hub Completo",
    LoadingTitle = "Cargando LXAIL...",
    LoadingSubtitle = "Ejemplo completo de todas las funciones",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Config",
        FileName = "EjemploCompleto"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/ejemplo",
        RememberJoins = true
    },
    KeySystem = {
        Enabled = true,
        Title = "🔑 Sistema de Autenticación",
        Subtitle = "Ingresa tu clave de acceso",
        Note = "Obtén tu clave en nuestro Discord",
        FileName = "LXAIL_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = {"LXAIL_DEMO_2024", "ADMIN_ACCESS", "VIP_USER", "FREE_KEY"}
    }
})

-- === CREAR PESTAÑAS ===
local MainTab = Window:CreateTab({
    Name = "🏠 Principal",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local CombatTab = Window:CreateTab({
    Name = "⚔️ Combate",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local PlayerTab = Window:CreateTab({
    Name = "👤 Jugador",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local VisualsTab = Window:CreateTab({
    Name = "👁️ Visuales",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

local MiscTab = Window:CreateTab({
    Name = "🔧 Varios",
    Icon = "rbxassetid://4483345998",
    Visible = true
})

-- === VARIABLES GLOBALES ===
local autoFarmEnabled = false
local playerSpeed = 16
local godModeEnabled = false
local espEnabled = false
local currentTheme = "Dark"
local targetPlayer = ""

-- === PESTAÑA PRINCIPAL ===
MainTab:CreateLabel({
    Text = "🎉 ¡Bienvenido a LXAIL!"
})

MainTab:CreateParagraph({
    Title = "📖 Acerca de LXAIL",
    Content = "LXAIL es una librería UI completa que replica toda la funcionalidad de Rayfield con un diseño moderno, oscuro y minimalista. Incluye soporte móvil, animaciones fluidas y arquitectura modular para una experiencia de usuario superior."
})

MainTab:CreateDivider()

MainTab:CreateLabel({
    Text = "🎮 Funciones Principales"
})

-- Toggle con callback
MainTab:CreateToggle({
    Name = "🚀 Auto Farm Global",
    CurrentValue = false,
    Flag = "GlobalAutoFarm",
    Callback = function(Value)
        autoFarmEnabled = Value
        print("Auto Farm Global:", Value and "ACTIVADO" or "DESACTIVADO")
        
        -- Notificación personalizada
        LXAIL:Notify({
            Title = "Auto Farm",
            Content = Value and "Sistema de auto farm activado correctamente" or "Sistema de auto farm desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
        
        -- Lógica del auto farm
        if Value then
            spawn(function()
                while autoFarmEnabled do
                    print("Auto Farm ejecutándose...")
                    wait(1)
                end
            end)
        end
    end
})

-- Slider con sufijo personalizado
MainTab:CreateSlider({
    Name = "⚡ Velocidad del Auto Farm",
    Range = {1, 10},
    Increment = 0.5,
    Suffix = "x",
    CurrentValue = 2,
    Flag = "AutoFarmSpeed",
    Callback = function(Value)
        print("Velocidad del Auto Farm:", Value .. "x")
        
        LXAIL:Notify({
            Title = "Velocidad",
            Content = "Velocidad del auto farm: " .. Value .. "x",
            Duration = 2,
            Type = "Info"
        })
    end
})

-- Botón con acción
MainTab:CreateButton({
    Name = "🔄 Reiniciar Todos los Sistemas",
    Callback = function()
        print("Reiniciando todos los sistemas...")
        
        -- Reiniciar variables
        autoFarmEnabled = false
        playerSpeed = 16
        godModeEnabled = false
        espEnabled = false
        
        LXAIL:Notify({
            Title = "Sistema",
            Content = "Todos los sistemas han sido reiniciados correctamente",
            Duration = 4,
            Type = "Success"
        })
    end
})

-- === PESTAÑA COMBATE ===
CombatTab:CreateLabel({
    Text = "⚔️ Funciones de Combate"
})

-- Toggle de god mode
CombatTab:CreateToggle({
    Name = "🛡️ Modo Dios",
    CurrentValue = false,
    Flag = "GodMode",
    Callback = function(Value)
        godModeEnabled = Value
        print("Modo Dios:", Value and "ACTIVADO" or "DESACTIVADO")
        
        -- Lógica del modo dios
        if Value then
            -- Activar modo dios
            print("Aplicando invulnerabilidad...")
        else
            -- Desactivar modo dios
            print("Removiendo invulnerabilidad...")
        end
        
        LXAIL:Notify({
            Title = "Modo Dios",
            Content = Value and "Invulnerabilidad activada" or "Invulnerabilidad desactivada",
            Duration = 3,
            Type = Value and "Success" or "Warning"
        })
    end
})

-- Slider de daño
CombatTab:CreateSlider({
    Name = "💥 Multiplicador de Daño",
    Range = {1, 50},
    Increment = 1,
    Suffix = "x",
    CurrentValue = 1,
    Flag = "DamageMultiplier",
    Callback = function(Value)
        print("Multiplicador de daño:", Value .. "x")
        
        if Value > 10 then
            LXAIL:Notify({
                Title = "Advertencia",
                Content = "Multiplicador muy alto puede causar detección",
                Duration = 4,
                Type = "Warning"
            })
        end
    end
})

-- Dropdown de armas
CombatTab:CreateDropdown({
    Name = "🗡️ Arma Preferida",
    Options = {"Espada", "Hacha", "Arco", "Varita Mágica", "Pistola"},
    CurrentOption = {"Espada"},
    MultipleOptions = false,
    Flag = "PreferredWeapon",
    Callback = function(Option)
        local weapon = Option[1]
        print("Arma seleccionada:", weapon)
        
        LXAIL:Notify({
            Title = "Arma",
            Content = "Arma equipada: " .. weapon,
            Duration = 2,
            Type = "Info"
        })
    end
})

-- === PESTAÑA JUGADOR ===
PlayerTab:CreateLabel({
    Text = "👤 Configuración del Jugador"
})

-- Slider de velocidad
PlayerTab:CreateSlider({
    Name = "🏃 Velocidad de Movimiento",
    Range = {16, 500},
    Increment = 1,
    Suffix = " WS",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        playerSpeed = Value
        print("Velocidad establecida:", Value)
        
        -- Aplicar velocidad al jugador (en Roblox)
        -- game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        
        if Value > 100 then
            LXAIL:Notify({
                Title = "Velocidad Alta",
                Content = "Velocidad muy alta puede causar detección",
                Duration = 3,
                Type = "Warning"
            })
        end
    end
})

-- Botón de teletransporte
PlayerTab:CreateButton({
    Name = "🏠 Teletransporte al Spawn",
    Callback = function()
        print("Teletransportando al spawn...")
        
        -- Lógica de teletransporte
        -- game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        
        LXAIL:Notify({
            Title = "Teletransporte",
            Content = "Teletransportado al spawn correctamente",
            Duration = 2,
            Type = "Success"
        })
    end
})

-- Input para teletransporte a jugador
PlayerTab:CreateInput({
    Name = "🎯 Teletransporte a Jugador",
    PlaceholderText = "Nombre del jugador...",
    RemoveTextAfterFocusLost = false,
    Flag = "TeleportTarget",
    Callback = function(Text)
        targetPlayer = Text
        if Text ~= "" then
            print("Objetivo de teletransporte:", Text)
            
            -- Lógica de teletransporte a jugador
            -- local target = game.Players:FindFirstChild(Text)
            -- if target then... end
            
            LXAIL:Notify({
                Title = "Objetivo",
                Content = "Objetivo establecido: " .. Text,
                Duration = 2,
                Type = "Info"
            })
        end
    end
})

-- === PESTAÑA VISUALES ===
VisualsTab:CreateLabel({
    Text = "👁️ Efectos Visuales"
})

-- Toggle de ESP
VisualsTab:CreateToggle({
    Name = "🎯 ESP de Jugadores",
    CurrentValue = false,
    Flag = "PlayerESP",
    Callback = function(Value)
        espEnabled = Value
        print("ESP de jugadores:", Value and "ACTIVADO" or "DESACTIVADO")
        
        -- Lógica del ESP
        if Value then
            print("Activando ESP para todos los jugadores...")
        else
            print("Desactivando ESP...")
        end
        
        LXAIL:Notify({
            Title = "ESP",
            Content = Value and "ESP activado para todos los jugadores" or "ESP desactivado",
            Duration = 3,
            Type = Value and "Success" or "Info"
        })
    end
})

-- Color picker para ESP
VisualsTab:CreateColorPicker({
    Name = "🎨 Color del ESP",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor",
    Callback = function(Value)
        print("Color del ESP cambiado a RGB:", Value.R * 255, Value.G * 255, Value.B * 255)
        
        LXAIL:Notify({
            Title = "Color",
            Content = "Color del ESP actualizado",
            Duration = 2,
            Type = "Success"
        })
    end
})

-- Dropdown múltiple para características ESP
VisualsTab:CreateDropdown({
    Name = "📊 Características del ESP",
    Options = {"Nombres", "Distancia", "Salud", "Armas", "Rango"},
    CurrentOption = {"Nombres"},
    MultipleOptions = true,
    Flag = "ESPFeatures",
    Callback = function(Options)
        print("Características ESP seleccionadas:")
        for _, feature in ipairs(Options) do
            print("- " .. feature)
        end
        
        LXAIL:Notify({
            Title = "ESP",
            Content = "Características ESP actualizadas",
            Duration = 2,
            Type = "Info"
        })
    end
})

-- === PESTAÑA VARIOS ===
MiscTab:CreateLabel({
    Text = "🔧 Configuración Adicional"
})

-- Keybind para toggle UI
MiscTab:CreateKeybind({
    Name = "🔑 Mostrar/Ocultar UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "ToggleUI",
    Callback = function(Keybind)
        print("Tecla para toggle UI:", Keybind)
        
        LXAIL:Notify({
            Title = "Keybind",
            Content = "UI se mostrará/ocultará con: " .. tostring(Keybind),
            Duration = 3,
            Type = "Info"
        })
    end
})

-- Keybind de mantenimiento
MiscTab:CreateKeybind({
    Name = "🏃 Correr Rápido (Mantener)",
    CurrentKeybind = "LeftShift",
    HoldToInteract = true,
    Flag = "FastRun",
    Callback = function(Keybind)
        print("Tecla de correr rápido:", Keybind)
    end
})

-- Dropdown de temas
MiscTab:CreateDropdown({
    Name = "🎨 Tema de la Interfaz",
    Options = {"Dark", "Light", "Neon", "Custom"},
    CurrentOption = {"Dark"},
    MultipleOptions = false,
    Flag = "UITheme",
    Callback = function(Option)
        currentTheme = Option[1]
        print("Tema cambiado a:", currentTheme)
        
        -- Aplicar tema
        LXAIL:SetTheme(currentTheme)
        
        LXAIL:Notify({
            Title = "Tema",
            Content = "Tema cambiado a: " .. currentTheme,
            Duration = 2,
            Type = "Success"
        })
    end
})

MiscTab:CreateDivider()

-- === GESTIÓN DE CONFIGURACIÓN ===
MiscTab:CreateLabel({
    Text = "💾 Gestión de Configuración"
})

-- Botones de configuración
MiscTab:CreateButton({
    Name = "💾 Guardar Configuración",
    Callback = function()
        LXAIL:SaveConfiguration()
        
        LXAIL:Notify({
            Title = "Configuración",
            Content = "Configuración guardada exitosamente",
            Duration = 3,
            Type = "Success"
        })
    end
})

MiscTab:CreateButton({
    Name = "📂 Cargar Configuración",
    Callback = function()
        LXAIL:LoadConfiguration()
        
        LXAIL:Notify({
            Title = "Configuración",
            Content = "Configuración cargada exitosamente",
            Duration = 3,
            Type = "Success"
        })
    end
})

MiscTab:CreateButton({
    Name = "🔄 Resetear Configuración",
    Callback = function()
        LXAIL:ResetConfiguration()
        
        LXAIL:Notify({
            Title = "Reset",
            Content = "Configuración restablecida a valores por defecto",
            Duration = 4,
            Type = "Warning"
        })
    end
})

-- === SISTEMA DE NOTIFICACIONES DEMO ===
MiscTab:CreateDivider()

MiscTab:CreateLabel({
    Text = "🔔 Sistema de Notificaciones"
})

MiscTab:CreateButton({
    Name = "🔔 Probar Todas las Notificaciones",
    Callback = function()
        -- Demostrar todos los tipos de notificaciones
        LXAIL:Notify({
            Title = "✅ Éxito",
            Content = "Esta es una notificación de éxito",
            Duration = 4,
            Type = "Success"
        })
        
        spawn(function()
            wait(1)
            LXAIL:Notify({
                Title = "⚠️ Advertencia",
                Content = "Esta es una notificación de advertencia",
                Duration = 3,
                Type = "Warning"
            })
            
            wait(1)
            LXAIL:Notify({
                Title = "❌ Error",
                Content = "Esta es una notificación de error",
                Duration = 5,
                Type = "Error"
            })
            
            wait(1)
            LXAIL:Notify({
                Title = "ℹ️ Información",
                Content = "Esta es una notificación informativa",
                Duration = 2,
                Type = "Info"
            })
        end)
    end
})

-- === INTEGRACIÓN CON DISCORD ===
MiscTab:CreateDivider()

MiscTab:CreateLabel({
    Text = "💬 Integración con Discord"
})

MiscTab:CreateButton({
    Name = "💬 Mostrar Invitación Discord",
    Callback = function()
        LXAIL:Prompt({
            Title = "🎮 ¡Únete a Nuestro Discord!",
            SubTitle = "Comunidad y Soporte",
            Content = "Únete a nuestro servidor de Discord para obtener ayuda, actualizaciones, reportar bugs y conectar con otros usuarios de LXAIL.",
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
                    end
                },
                Ignore = {
                    Name = "Tal vez después",
                    Callback = function()
                        print("Invitación de Discord ignorada")
                        
                        LXAIL:Notify({
                            Title = "Discord",
                            Content = "Puedes unirte más tarde desde el menú",
                            Duration = 2,
                            Type = "Info"
                        })
                    end
                }
            }
        })
    end
})

-- === BOTÓN FLOTANTE ===
-- Crear botón flotante para fácil acceso
LXAIL:CreateFloatingButton({
    Icon = "rbxassetid://4483345998",
    Callback = function()
        LXAIL:Toggle()
        
        LXAIL:Notify({
            Title = "UI",
            Content = "Visibilidad de la UI alternada",
            Duration = 1,
            Type = "Info"
        })
    end
})

-- === NOTIFICACIÓN DE BIENVENIDA ===
LXAIL:Notify({
    Title = "🎉 ¡LXAIL Cargado!",
    Content = "Ejemplo completo cargado exitosamente. Todas las funciones están disponibles.",
    Duration = 5,
    Type = "Success"
})

-- === INFORMACIÓN DE FINALIZACIÓN ===
print("✅ === EJEMPLO COMPLETO DE LXAIL CARGADO ===")
print("📋 Funciones disponibles:")
print("  • CreateWindow - Ventana principal con configuración completa")
print("  • CreateTab - Pestañas organizadas por categorías")
print("  • CreateToggle - Interruptores on/off con callbacks")
print("  • CreateSlider - Deslizadores de valores con rangos")
print("  • CreateButton - Botones con acciones personalizadas")
print("  • CreateInput - Campos de entrada de texto")
print("  • CreateDropdown - Menús desplegables simples y múltiples")
print("  • CreateColorPicker - Selector de colores RGB")
print("  • CreateKeybind - Asignación de teclas con soporte hold")
print("  • CreateParagraph - Texto informativo con títulos")
print("  • CreateLabel - Etiquetas simples")
print("  • CreateDivider - Separadores visuales")
print("  • Notify - Sistema de notificaciones con 4 tipos")
print("  • Prompt - Ventanas modales con acciones")
print("  • SaveConfiguration/LoadConfiguration - Gestión de configuración")
print("  • SetTheme - Sistema de temas")
print("  • CreateFloatingButton - Botón flotante móvil")
print("  • Toggle - Control de visibilidad de UI")
print("")
print("🎮 Presiona F para mostrar/ocultar la UI")
print("📱 Compatible con dispositivos móviles")
print("💾 Configuración se guarda automáticamente")
print("🔔 Sistema de notificaciones completamente funcional")
print("")
print("🚀 ¡Listo para usar en Roblox con loadstring()!")

--[[
=== INSTRUCCIONES DE USO EN ROBLOX ===

1. Sube Main_LoadString.lua a tu repositorio (GitHub, Pastebin, etc.)
2. Usa este código en tu executor:

local LXAIL = loadstring(game:HttpGet("TU_URL_AQUÍ"))()
-- Luego copia y pega este ejemplo completo

=== CARACTERÍSTICAS PRINCIPALES ===

✅ COMPATIBILIDAD COMPLETA CON RAYFIELD
- Todos los métodos funcionan igual que Rayfield
- Mismos parámetros y callbacks
- Migración directa sin cambios de código

✅ DISEÑO MODERNO
- Interfaz oscura y minimalista
- Animaciones fluidas con TweenService
- Efectos visuales avanzados

✅ FUNCIONALIDAD COMPLETA
- Sistema de pestañas organizado
- Todos los componentes interactivos
- Notificaciones animadas
- Gestión de configuración
- Sistema de temas
- Integración con Discord
- Sistema de autenticación con claves

✅ COMPATIBILIDAD MÓVIL
- Diseño responsive
- Controles táctiles
- Botón flotante para fácil acceso

✅ ARQUITECTURA MODULAR
- Código organizado y limpio
- Fácil personalización
- Extensible para nuevas funciones

=== SOPORTE ===
- Compatible con todos los executors populares
- Funciona en Roblox Studio y en juego
- Soporte para dispositivos móviles
- Optimizado para rendimiento

¡Disfruta usando LXAIL! 🎮
--]]