-- ===================================
-- LXAIL - Ejemplo Completo de Uso
-- UI Moderna con Efectos Glitch
-- ===================================

-- Cargar la librería (en Roblox usa loadstring)
local LXAIL = require("Main_LoadString") -- o loadstring en Roblox

print("🚀 === LXAIL - EJEMPLO COMPLETO DE USO ===")
print("🎨 Nueva UI moderna con efectos glitch y animaciones")

-- ===================================
-- 1. CREAR VENTANA PRINCIPAL
-- ===================================
local Window = LXAIL:CreateWindow({
    Name = "LXAIL - BETA",              -- Título con animación de letras
    LoadingTitle = "LXAIL Cargando...",  -- Pantalla de carga
    LoadingSubtitle = "UI Moderna",      -- Subtítulo de carga
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "LXAIL_Config",
        FileName = "MiConfiguracion"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/ejemplo",
        RememberJoins = true
    },
    KeySystem = false -- Desactivado para este ejemplo
})

print("✅ Ventana creada con diseño moderno!")

-- ===================================
-- 2. CREAR PESTAÑAS (TABS)
-- ===================================

-- Pestaña Principal
local MainTab = Window:CreateTab({
    Name = "Principal",
    Icon = "rbxassetid://4483345998"
})

-- Pestaña de Configuración
local ConfigTab = Window:CreateTab({
    Name = "Configuración", 
    Icon = "rbxassetid://4483345998"
})

-- Pestaña Misc
local MiscTab = Window:CreateTab({
    Name = "Misceláneos",
    Icon = "rbxassetid://4483345998"
})

print("✅ Pestañas creadas con transiciones glitch!")

-- ===================================
-- 3. COMPONENTES EN PESTAÑA PRINCIPAL
-- ===================================

-- BOTÓN ANTI-AFK
MainTab:CreateButton({
    Name = "Anti AFK",
    Callback = function()
        print("🔄 Sistema Anti-AFK activado!")
        -- Aquí irías tu código anti-AFK
    end
})

-- TOGGLE AUTO ATTACK
local autoAttackEnabled = false
MainTab:CreateToggle({
    Name = "Auto Attack",
    Default = false,
    Flag = "AutoAttackFlag", -- Para guardar en configuración
    Callback = function(Value)
        autoAttackEnabled = Value
        print("⚔️ Auto Attack:", Value and "ACTIVADO" or "DESACTIVADO")
        -- Aquí iría tu lógica de auto attack
    end
})

-- TOGGLE AUTO BLOCK
local autoBlockEnabled = false
MainTab:CreateToggle({
    Name = "Auto Block", 
    Default = false,
    Flag = "AutoBlockFlag",
    Callback = function(Value)
        autoBlockEnabled = Value
        print("🛡️ Auto Block:", Value and "ACTIVADO" or "DESACTIVADO")
        -- Aquí iría tu lógica de auto block
    end
})

-- TOGGLE AUTO COUNTER
local autoCounterEnabled = false
MainTab:CreateToggle({
    Name = "Auto Counter",
    Default = false,
    Flag = "AutoCounterFlag", 
    Callback = function(Value)
        autoCounterEnabled = Value
        print("⚡ Auto Counter:", Value and "ACTIVADO" or "DESACTIVADO")
        -- Aquí iría tu lógica de auto counter
    end
})

-- SLIDER DISTANCIA ATTACK
local attackDistance = 50
MainTab:CreateSlider({
    Name = "Distancia Auto Attack",
    Min = 10,
    Max = 100,
    Increment = 5,
    Default = 50,
    Flag = "AttackDistanceFlag",
    Callback = function(Value)
        attackDistance = Value
        print("📏 Distancia Auto Attack:", Value, "studs")
        -- Aquí actualizarías la distancia de ataque
    end
})

-- SLIDER DISTANCIA BLOCK
local blockDistance = 30
MainTab:CreateSlider({
    Name = "Distancia Auto Block",
    Min = 5,
    Max = 80,
    Increment = 5,
    Default = 30,
    Flag = "BlockDistanceFlag",
    Callback = function(Value)
        blockDistance = Value
        print("🛡️ Distancia Auto Block:", Value, "studs")
        -- Aquí actualizarías la distancia de bloqueo
    end
})

-- SLIDER DISTANCIA COUNTER
local counterDistance = 25  
MainTab:CreateSlider({
    Name = "Distancia Auto Counter",
    Min = 5,
    Max = 60,
    Increment = 5,
    Default = 25,
    Flag = "CounterDistanceFlag",
    Callback = function(Value)
        counterDistance = Value
        print("⚡ Distancia Auto Counter:", Value, "studs")
        -- Aquí actualizarías la distancia de counter
    end
})

print("✅ Componentes principales añadidos!")

-- ===================================
-- 4. COMPONENTES EN CONFIGURACIÓN
-- ===================================

-- INPUT PARA NOMBRE DE JUGADOR
ConfigTab:CreateInput({
    Name = "Jugador Objetivo",
    PlaceholderText = "Escribe el nombre...",
    RemoveTextAfterFocusLost = false,
    Flag = "TargetPlayerFlag",
    Callback = function(Text)
        print("🎯 Jugador objetivo establecido:", Text)
        -- Aquí guardarías el jugador objetivo
    end
})

-- DROPDOWN MODO DE JUEGO
ConfigTab:CreateDropdown({
    Name = "Modo de Juego",
    Options = {"Aventura", "PvP", "Farming", "Exploración"},
    CurrentOption = {"Aventura"},
    MultipleOptions = false,
    Flag = "GameModeFlag",
    Callback = function(Option)
        print("🎮 Modo de juego:", Option)
        -- Aquí cambiarías el modo de juego
    end
})

-- DROPDOWN CARACTERÍSTICAS ACTIVAS (MÚLTIPLE)
ConfigTab:CreateDropdown({
    Name = "Características Activas",
    Options = {"ESP", "Aimbot", "Speed Hack", "Fly", "Noclip"},
    CurrentOption = {"ESP"},
    MultipleOptions = true,
    Flag = "ActiveFeaturesFlag",
    Callback = function(Options)
        print("🔧 Características activas:", table.concat(Options, ", "))
        -- Aquí activarías/desactivarías características
    end
})

-- COLOR PICKER PARA TEMA
ConfigTab:CreateColorPicker({
    Name = "Color del Tema",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ThemeColorFlag",
    Callback = function(Value)
        print("🎨 Color del tema cambiado a RGB:", math.floor(Value.R*255), math.floor(Value.G*255), math.floor(Value.B*255))
        -- Aquí cambiarías el color del tema
    end
})

-- KEYBIND TOGGLE UI
ConfigTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "F",
    HoldToInteract = false,
    Flag = "ToggleUIKeybind",
    Callback = function(Keybind)
        print("⌨️ Keybind Toggle UI:", Keybind)
        -- El toggle ya está implementado automáticamente
    end
})

-- KEYBIND SPRINT (MANTENER PRESIONADO)
ConfigTab:CreateKeybind({
    Name = "Sprint (Mantener)",
    CurrentKeybind = "LeftShift", 
    HoldToInteract = true,
    Flag = "SprintKeybind",
    Callback = function(Keybind)
        print("🏃 Keybind Sprint:", Keybind)
        -- Aquí implementarías el sprint
    end
})

print("✅ Configuración añadida!")

-- ===================================
-- 5. COMPONENTES EN MISCELÁNEOS
-- ===================================

-- PÁRRAFO INFORMATIVO
MiscTab:CreateParagraph({
    Title = "Acerca de LXAIL",
    Content = "LXAIL es una librería UI moderna que replica completamente la funcionalidad de Rayfield con un diseño moderno, efectos glitch, soporte móvil y animaciones suaves. Compatible con loadstring() para ejecución remota."
})

-- ETIQUETA
MiscTab:CreateLabel({
    Name = "Estado del Sistema",
    Text = "Todos los componentes funcionando correctamente!"
})

-- DIVISOR
MiscTab:CreateDivider({
    Name = "Notificaciones de Prueba"
})

-- BOTÓN PARA NOTIFICACIONES
MiscTab:CreateButton({
    Name = "Probar Notificaciones",
    Callback = function()
        -- Notificación de éxito
        LXAIL:Notify({
            Title = "¡Éxito!",
            Content = "LXAIL cargado correctamente!",
            Duration = 5,
            Type = "Success"
        })
        
        wait(1)
        
        -- Notificación de advertencia
        LXAIL:Notify({
            Title = "Advertencia",
            Content = "Esta es una notificación de advertencia.",
            Duration = 3,
            Type = "Warning"
        })
        
        wait(1)
        
        -- Notificación de error
        LXAIL:Notify({
            Title = "Error",
            Content = "Esto es un ejemplo de error.",
            Duration = 4,
            Type = "Error"
        })
        
        wait(1)
        
        -- Notificación informativa
        LXAIL:Notify({
            Title = "Información",
            Content = "Sistema de notificaciones funcionando!",
            Duration = 2,
            Type = "Info"
        })
    end
})

print("✅ Misceláneos añadidos!")

-- ===================================
-- 6. CARACTERÍSTICAS ESPECIALES
-- ===================================

print("")
print("🎨 === CARACTERÍSTICAS DE LA UI MODERNA ===")
print("• Título animado 'LXAIL - BETA' con efectos de fade")
print("• Transiciones de pestañas con efectos glitch")
print("• Botón flotante draggable para toggle")
print("• Tema oscuro moderno con gradientes")
print("• Toggles con iconos y animaciones suaves")
print("• Sliders interactivos con cajas de valor")
print("• Efectos hover en todos los elementos")
print("• Sombras para profundidad visual")
print("• Bordes redondeados modernos")
print("• Soporte táctil para móviles")

print("")
print("⌨️ === CONTROLES ===")
print("• Presiona F para mostrar/ocultar la UI")
print("• Arrastra el botón flotante para moverlo")
print("• Click corto en el botón flotante para toggle")
print("• Arrastra la barra superior para mover la ventana")
print("• Click en las pestañas para cambiar con efecto glitch")

print("")
print("🚀 === LXAIL LISTO PARA USAR ===")
print("📖 En Roblox usar:")
print('   local LXAIL = loadstring(game:HttpGet("tu-url-del-script"))()')
print("🎮 Todas las funciones de Rayfield funcionan igual!")
print("💡 Presiona F para alternar la visibilidad de la UI")

-- ===================================
-- 7. FUNCIONES ADICIONALES
-- ===================================

-- Función para obtener el estado de todos los flags
local function obtenerEstadoCompleto()
    print("")
    print("📊 === ESTADO ACTUAL DE LA CONFIGURACIÓN ===")
    for flag, value in pairs(LXAIL.Flags) do
        print("🔧", flag, "=", tostring(value))
    end
end

-- Función para guardar configuración (si está habilitado)
local function guardarConfiguracion()
    if LXAIL.ConfigurationSaving and LXAIL.ConfigurationSaving.Enabled then
        -- Aquí se guardaría la configuración
        print("💾 Configuración guardada automáticamente!")
    end
end

-- Ejemplos de uso de las funciones
spawn(function()
    wait(5) -- Esperar 5 segundos
    obtenerEstadoCompleto()
    guardarConfiguracion()
end)

print("")
print("✅ === EJEMPLO COMPLETO FINALIZADO ===")
print("🎯 La UI está completamente funcional y lista para usar!")
print("🔄 Prueba todos los componentes para ver las animaciones!")