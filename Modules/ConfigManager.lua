--[[
    Configuration Manager for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local HttpService = {}

local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager:new(options)
    local self = setmetatable({}, ConfigManager)
    
    -- Options
    local opts = options or {}
    self.ConfigFolder = opts.ConfigFolder or "ModernUI_Configs"
    self.DefaultConfig = opts.DefaultConfig or "default"
    self.AutoSave = opts.AutoSave ~= false
    self.SaveInterval = opts.SaveInterval or 30 -- seconds
    
    -- Properties
    self.CurrentConfig = self.DefaultConfig
    self.ConfigData = {}
    self.AutoSaveConnection = nil
    
    -- Initialize
    self:Initialize()
    
    return self
end

function ConfigManager:Initialize()
    -- Create config folder if it doesn't exist
    self:CreateConfigFolder()
    
    -- Load default config
    self:LoadConfig(self.DefaultConfig)
    
    -- Start auto-save if enabled
    if self.AutoSave then
        self:StartAutoSave()
    end
end

function ConfigManager:CreateConfigFolder()
    if not isfolder then return end
    
    if not isfolder(self.ConfigFolder) then
        makefolder(self.ConfigFolder)
    end
end

function ConfigManager:GetConfigPath(configName)
    return self.ConfigFolder .. "/" .. configName .. ".json"
end

function ConfigManager:SaveConfig(configName, data)
    configName = configName or self.CurrentConfig
    data = data or self.ConfigData
    
    if not writefile then
        warn("ConfigManager: writefile not available")
        return false
    end
    
    local success, err = pcall(function()
        local jsonData = HttpService:JSONEncode(data)
        writefile(self:GetConfigPath(configName), jsonData)
    end)
    
    if not success then
        warn("ConfigManager: Failed to save config '" .. configName .. "': " .. tostring(err))
        return false
    end
    
    return true
end

function ConfigManager:LoadConfig(configName)
    configName = configName or self.CurrentConfig
    
    if not readfile or not isfile then
        warn("ConfigManager: readfile or isfile not available")
        return false
    end
    
    local configPath = self:GetConfigPath(configName)
    
    if not isfile(configPath) then
        -- Create default config if it doesn't exist
        self.ConfigData = {}
        self:SaveConfig(configName, self.ConfigData)
        return true
    end
    
    local success, result = pcall(function()
        local jsonData = readfile(configPath)
        return HttpService:JSONDecode(jsonData)
    end)
    
    if not success then
        warn("ConfigManager: Failed to load config '" .. configName .. "': " .. tostring(result))
        return false
    end
    
    self.ConfigData = result
    self.CurrentConfig = configName
    
    return true
end

function ConfigManager:DeleteConfig(configName)
    if not delfile or not isfile then
        warn("ConfigManager: delfile or isfile not available")
        return false
    end
    
    local configPath = self:GetConfigPath(configName)
    
    if not isfile(configPath) then
        warn("ConfigManager: Config '" .. configName .. "' does not exist")
        return false
    end
    
    local success, err = pcall(function()
        delfile(configPath)
    end)
    
    if not success then
        warn("ConfigManager: Failed to delete config '" .. configName .. "': " .. tostring(err))
        return false
    end
    
    return true
end

function ConfigManager:GetConfigList()
    if not listfiles then
        warn("ConfigManager: listfiles not available")
        return {}
    end
    
    local success, files = pcall(function()
        return listfiles(self.ConfigFolder)
    end)
    
    if not success then
        warn("ConfigManager: Failed to list configs: " .. tostring(files))
        return {}
    end
    
    local configs = {}
    for _, file in ipairs(files) do
        if file:sub(-5) == ".json" then
            local configName = file:match("([^/]+)%.json$")
            if configName then
                table.insert(configs, configName)
            end
        end
    end
    
    return configs
end

function ConfigManager:ConfigExists(configName)
    if not isfile then
        warn("ConfigManager: isfile not available")
        return false
    end
    
    return isfile(self:GetConfigPath(configName))
end

function ConfigManager:SetValue(key, value)
    self.ConfigData[key] = value
    
    -- Auto-save if enabled
    if self.AutoSave then
        self:SaveConfig()
    end
end

function ConfigManager:GetValue(key, defaultValue)
    if self.ConfigData[key] ~= nil then
        return self.ConfigData[key]
    end
    
    return defaultValue
end

function ConfigManager:RemoveValue(key)
    self.ConfigData[key] = nil
    
    -- Auto-save if enabled
    if self.AutoSave then
        self:SaveConfig()
    end
end

function ConfigManager:SetSection(section, data)
    self.ConfigData[section] = data
    
    -- Auto-save if enabled
    if self.AutoSave then
        self:SaveConfig()
    end
end

function ConfigManager:GetSection(section)
    return self.ConfigData[section] or {}
end

function ConfigManager:ClearConfig()
    self.ConfigData = {}
    
    -- Auto-save if enabled
    if self.AutoSave then
        self:SaveConfig()
    end
end

function ConfigManager:StartAutoSave()
    if self.AutoSaveConnection then
        self.AutoSaveConnection:Disconnect()
    end
    
    -- Mock connection for local environment compatibility
    self.AutoSaveConnection = {Disconnect = function() end}
    -- Note: Auto-save functionality disabled in local environment
end

function ConfigManager:StopAutoSave()
    if self.AutoSaveConnection then
        self.AutoSaveConnection:Disconnect()
        self.AutoSaveConnection = nil
    end
end

function ConfigManager:ExportConfig(configName)
    configName = configName or self.CurrentConfig
    
    if not self:ConfigExists(configName) then
        warn("ConfigManager: Config '" .. configName .. "' does not exist")
        return nil
    end
    
    if not readfile then
        warn("ConfigManager: readfile not available")
        return nil
    end
    
    local success, result = pcall(function()
        return readfile(self:GetConfigPath(configName))
    end)
    
    if not success then
        warn("ConfigManager: Failed to export config '" .. configName .. "': " .. tostring(result))
        return nil
    end
    
    return result
end

function ConfigManager:ImportConfig(configName, jsonData)
    if not writefile then
        warn("ConfigManager: writefile not available")
        return false
    end
    
    -- Validate JSON
    local success, data = pcall(function()
        return HttpService:JSONDecode(jsonData)
    end)
    
    if not success then
        warn("ConfigManager: Invalid JSON data for import")
        return false
    end
    
    -- Save imported config
    local importSuccess = pcall(function()
        writefile(self:GetConfigPath(configName), jsonData)
    end)
    
    if not importSuccess then
        warn("ConfigManager: Failed to import config '" .. configName .. "'")
        return false
    end
    
    return true
end

function ConfigManager:CopyConfig(sourceConfig, targetConfig)
    if not self:ConfigExists(sourceConfig) then
        warn("ConfigManager: Source config '" .. sourceConfig .. "' does not exist")
        return false
    end
    
    local exportData = self:ExportConfig(sourceConfig)
    if not exportData then
        return false
    end
    
    return self:ImportConfig(targetConfig, exportData)
end

function ConfigManager:GetCurrentConfig()
    return self.CurrentConfig
end

function ConfigManager:GetConfigData()
    return self.ConfigData
end

function ConfigManager:SetConfigData(data)
    self.ConfigData = data or {}
    
    -- Auto-save if enabled
    if self.AutoSave then
        self:SaveConfig()
    end
end

function ConfigManager:Destroy()
    self:StopAutoSave()
    
    -- Final save
    self:SaveConfig()
end

return ConfigManager
