--[[
    LXAIL - Ejemplo Completo con LoadString
    Librería UI completa para Roblox - Replica total de Rayfield
    
    Uso: Copia este código completo en Roblox Studio o executor
--]]

-- Cargar LXAIL via loadstring (reemplaza con tu URL real)
local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/tu-usuario/lxail/main/Main.lua"))()

-- === CONFIGURACIÓN INICIAL ===
-- Crear ventana principal con todas las opciones
local Window = LXAIL:CreateWindow({
    Name = "LXAIL Hub - Ejemplo Completo",
    LoadingTitle = "Cargando LXAIL...",
    LoadingSubtitle = "Librería UI Completa - Replica de Rayfield",
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
        Title = "Sistema de Acceso LXAIL",
        Subtitle = "Ingresa tu clave de acceso",
        Note = "Obtén tu clave en nuestro servidor de Discord",
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
        
        -- Lógica de auto farm aquí
        if Value then
            -- Iniciar auto farm
            spawn(function()
                while autoFarmActivo do
                    -- Tu código de auto farm aquí
                    wait(1)
                end
            end)
        end
        
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
        -- Aplicar velocidad de ataque
        -- game.Players.LocalPlayer.Character.Humanoid.AttackSpeed = Value
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
        
        -- Tu lógica para matar enemigos aquí
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                -- Lógica de eliminación
                print("Atacando a:", player.Name)
            end
        end
        
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
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
            LXAIL:Notify({
                Title = "Teleport",
                Content = "Teletransportado al spawn",
                Duration = 2,
                Type = "Success"
            })
        end
    end,
})

TeleportTab:CreateInput({
    Name = "Teletransporte a Jugador",
    PlaceholderText = "Nombre del jugador...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        if Text ~= "" then
            local targetPlayer = game.Players:FindFirstChild(Text)
            if targetPlayer and targetPlayer.Character then
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                    LXAIL:Notify({
                        Title = "Teleport",
                        Content = "Teletransportado a " .. targetPlayer.Name,
                        Duration = 2,
                        Type = "Success"
                    })
                end
            else
                LXAIL:Notify({
                    Title = "Error",
                    Content = "Jugador no encontrado: " .. Text,
                    Duration = 3,
                    Type = "Error"
                })
            end
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
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = Value
        end
        
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
        local player = game.Players.LocalPlayer
        
        if Value then
            -- Activar vuelo
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.Parent = player.Character.HumanoidRootPart
                bodyVelocity.Name = "LXAIL_FlyVelocity"
            end
        else
            -- Desactivar vuelo
            if player.Character and player.Character.HumanoidRootPart:FindFirstChild("LXAIL_FlyVelocity") then
                player.Character.HumanoidRootPart.LXAIL_FlyVelocity:Destroy()
            end
        end
        
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
        
        if Value then
            -- Crear ESP para todos los jugadores
            for _, player in pairs(game.Players:GetPlayers()) do
                if player ~= game.Players.LocalPlayer and player.Character then
                    -- Crear highlight o billboard GUI
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = player.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.Name = "LXAIL_ESP"
                end
            end
        else
            -- Remover ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Character and player.Character:FindFirstChild("LXAIL_ESP") then
                    player.Character.LXAIL_ESP:Destroy()
                end
            end
        end
        
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
        
        -- Aplicar color a elementos de la UI si es necesario
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
        local player = game.Players.LocalPlayer
        
        if Value then
            -- Activar noclip
            spawn(function()
                while noclipActivo do
                    if player.Character then
                        for _, part in pairs(player.Character:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                    wait(0.1)
                end
            end)
        else
            -- Desactivar noclip
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
        
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
        
        -- Aplicar tema
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
        -- Ejemplo de diferentes tipos de notificaciones
        LXAIL:Notify({
            Title = "Éxito",
            Content = "Esta es una notificación de éxito con duración personalizada",
            Duration = 4,
            Type = "Success"
        })
        
        wait(1)
        
        LXAIL:Notify({
            Title = "Advertencia",
            Content = "Esta es una notificación de advertencia",
            Duration = 3,
            Type = "Warning"
        })
        
        wait(1)
        
        LXAIL:Notify({
            Title = "Error",
            Content = "Esta es una notificación de error",
            Duration = 5,
            Type = "Error"
        })
        
        wait(1)
        
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
                        -- En Roblox real, esto abriría Discord
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
-- Crear botón flotante para móviles
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

-- === FUNCIÓN DE LIMPIEZA AL SALIR ===
game.Players.PlayerRemoving:Connect(function(player)
    if player == game.Players.LocalPlayer then
        -- Limpiar elementos antes de salir
        LXAIL:SaveConfiguration()
    end
end)

print("✅ LXAIL cargado completamente!")
print("📖 Todas las funciones de Rayfield están disponibles")
print("🎮 Usa F para mostrar/ocultar la UI")
print("💾 La configuración se guarda automáticamente")

--[[
=== INSTRUCCIONES DE USO ===

1. Reemplaza la URL en loadstring con tu enlace real de LXAIL
2. Personaliza las funciones según tu juego específico
3. Modifica las teclas, colores y opciones según tus preferencias
4. Toda la funcionalidad de Rayfield está replicada exactamente

=== FUNCIONES PRINCIPALES ===
- CreateWindow: Ventana principal con loading y opciones
- CreateTab: Pestañas organizadas
- CreateToggle: Interruptores on/off
- CreateSlider: Deslizadores de valores
- CreateButton: Botones con acciones
- CreateInput: Campos de entrada de texto
- CreateDropdown: Menús desplegables
- CreateColorPicker: Selector de colores
- CreateKeybind: Asignación de teclas
- CreateParagraph: Texto informativo
- CreateLabel: Etiquetas simples
- CreateDivider: Separadores visuales
- Notify: Sistema de notificaciones
- Prompt: Ventanas modales
- SaveConfiguration/LoadConfiguration: Gestión de configuración

=== COMPATIBILIDAD ===
✅ Roblox Studio
✅ Executors (Synapse, KRNL, etc.)
✅ Dispositivos móviles
✅ LoadString execution
✅ Modular architecture
✅ Rayfield API compatibility

--]]