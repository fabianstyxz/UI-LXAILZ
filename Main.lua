--[[
    Modern UI Library for Roblox
    Replicates Rayfield functionality with custom modern design
    Compatible with loadstring() execution
--]]

-- This is a demo of the Modern UI Library for Roblox
-- In Roblox, replace these with actual game services
local Players = {LocalPlayer = {}}
local TweenService = {}
local UserInputService = {}
local RunService = {}
local HttpService = {}
local GuiService = {}
local CoreGui = {}

local Player = Players.LocalPlayer
local PlayerGui = Player

-- Load modules
local Utils = require("Modules.Utils")
local Theme = require("Modules.Theme")
local Window = require("Modules.Window")
local Notification = require("Modules.Notification")
local KeySystem = require("Modules.KeySystem")
local LoadingScreen = require("Modules.LoadingScreen")
local ConfigManager = require("Modules.ConfigManager")
local DiscordPrompt = require("Modules.DiscordPrompt")
local FloatingButton = require("Modules.FloatingButton")

-- Main Library Class
local Library = {}
Library.__index = Library

function Library:new()
    local self = setmetatable({}, Library)
    
    -- Initialize core properties
    self.Windows = {}
    self.Notifications = {}
    self.KeySystemEnabled = false
    self.ConfigManager = ConfigManager:new()
    self.Theme = Theme:new()
    self.FloatingButton = nil
    self.MainScreenGui = nil
    self.KeybindConnection = nil
    self.ShowKeybind = Enum.KeyCode.F
    
    -- Initialize GUI container
    self:InitializeGUI()
    
    return self
end

function Library:InitializeGUI()
    -- Create main ScreenGui
    self.MainScreenGui = Instance.new("ScreenGui")
    self.MainScreenGui.Name = "ModernUILibrary"
    self.MainScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.MainScreenGui.ResetOnSpawn = false
    
    -- Parent to appropriate GUI container
    if gethui then
        self.MainScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(self.MainScreenGui)
        self.MainScreenGui.Parent = CoreGui
    else
        self.MainScreenGui.Parent = CoreGui
    end
    
    -- Setup global keybind
    self:SetupGlobalKeybind()
end

function Library:SetupGlobalKeybind()
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    self.KeybindConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == self.ShowKeybind then
            self:ToggleUI()
        end
    end)
end

function Library:ToggleUI()
    for _, window in pairs(self.Windows) do
        window:Toggle()
    end
end

function Library:CreateWindow(options)
    local opts = options or {}
    
    -- Show loading screen if specified
    if opts.LoadingTitle or opts.LoadingSubtitle then
        local loadingScreen = LoadingScreen:new(self.MainScreenGui, {
            Title = opts.LoadingTitle or "Loading...",
            Subtitle = opts.LoadingSubtitle or "Please wait..."
        })
        loadingScreen:Show()
        
        -- Auto-hide loading screen after 2 seconds
        wait(2)
        loadingScreen:Hide()
    end
    
    -- Create window instance
    local window = Window:new(self.MainScreenGui, opts, self.Theme)
    table.insert(self.Windows, window)
    
    -- Create floating button if this is the first window
    if #self.Windows == 1 and not self.FloatingButton then
        self.FloatingButton = FloatingButton:new(self.MainScreenGui, self.Theme)
        self.FloatingButton:SetCallback(function()
            self:ToggleUI()
        end)
    end
    
    return window
end

function Library:Notify(options)
    local opts = options or {}
    local notification = Notification:new(self.MainScreenGui, opts, self.Theme)
    table.insert(self.Notifications, notification)
    
    notification:Show()
    
    -- Auto-remove notification after duration
    local duration = opts.Duration or 5
    wait(duration)
    notification:Hide()
    
    -- Remove from notifications table
    for i, notif in ipairs(self.Notifications) do
        if notif == notification then
            table.remove(self.Notifications, i)
            break
        end
    end
end

function Library:CreateKeySystem(options)
    local opts = options or {}
    self.KeySystemEnabled = true
    
    local keySystem = KeySystem:new(self.MainScreenGui, opts, self.Theme)
    
    return keySystem
end

function Library:CreateDiscordPrompt(options)
    local opts = options or {}
    local discordPrompt = DiscordPrompt:new(self.MainScreenGui, opts, self.Theme)
    
    return discordPrompt
end

function Library:SetKeybind(keyCode)
    self.ShowKeybind = keyCode
    self:SetupGlobalKeybind()
end

function Library:SetTheme(themeName)
    self.Theme:SetTheme(themeName)
    
    -- Update all windows with new theme
    for _, window in pairs(self.Windows) do
        window:UpdateTheme(self.Theme)
    end
    
    -- Update floating button
    if self.FloatingButton then
        self.FloatingButton:UpdateTheme(self.Theme)
    end
end

function Library:SaveConfig(configName)
    return self.ConfigManager:SaveConfig(configName or "default")
end

function Library:LoadConfig(configName)
    return self.ConfigManager:LoadConfig(configName or "default")
end

function Library:Destroy()
    -- Disconnect keybind
    if self.KeybindConnection then
        self.KeybindConnection:Disconnect()
    end
    
    -- Destroy all windows
    for _, window in pairs(self.Windows) do
        window:Destroy()
    end
    
    -- Destroy floating button
    if self.FloatingButton then
        self.FloatingButton:Destroy()
    end
    
    -- Destroy main GUI
    if self.MainScreenGui then
        self.MainScreenGui:Destroy()
    end
    
    -- Clear tables
    self.Windows = {}
    self.Notifications = {}
end

-- Export the library
return Library
