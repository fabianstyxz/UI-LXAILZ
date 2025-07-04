--[[
    Keybind component for the Modern UI Library
--]]

local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local Keybind = {}
Keybind.__index = Keybind

function Keybind:new(parent, options, theme)
    local self = setmetatable({}, Keybind)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Keybind"
    self.Default = opts.Default or Enum.KeyCode.F
    self.Callback = opts.Callback or function() end
    self.Description = opts.Description or nil
    self.Hold = opts.Hold or false
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Value = self.Default
    self.Enabled = true
    self.Listening = false
    self.KeyConnection = nil
    
    -- Create keybind
    self:CreateKeybind()
    self:SetupKeybindListener()
    
    return self
end

function Keybind:CreateKeybind()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "KeybindContainer"
    self.Container.Size = UDim2.new(1, 0, 0, 50)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Keybind label
    self.Label = Instance.new("TextLabel")
    self.Label.Name = "KeybindLabel"
    self.Label.Size = UDim2.new(1, -100, 1, 0)
    self.Label.Position = UDim2.new(0, 15, 0, 0)
    self.Label.BackgroundTransparency = 1
    self.Label.Text = self.Name
    self.Label.TextColor3 = self.Theme:GetColor("Text")
    self.Label.TextXAlignment = Enum.TextXAlignment.Left
    self.Label.TextYAlignment = Enum.TextYAlignment.Center
    self.Label.Font = self.Theme:GetTextProperties("Body").Font
    self.Label.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.Label.Parent = self.Container
    
    -- Keybind button
    self.KeybindButton = Instance.new("TextButton")
    self.KeybindButton.Name = "KeybindButton"
    self.KeybindButton.Size = UDim2.new(0, 80, 0, 30)
    self.KeybindButton.Position = UDim2.new(1, -95, 0.5, -15)
    self.KeybindButton.BackgroundColor3 = self.Theme:GetColor("Accent")
    self.KeybindButton.BorderSizePixel = 0
    self.KeybindButton.Text = self:GetKeyText()
    self.KeybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.KeybindButton.Font = self.Theme:GetTextProperties("Button").Font
    self.KeybindButton.TextSize = 12
    self.KeybindButton.AutoButtonColor = false
    self.KeybindButton.Parent = self.Container
    
    -- Keybind button corner
    local buttonCorner = Utils.CreateCorner(6)
    buttonCorner.Parent = self.KeybindButton
    
    -- Description label (if provided)
    if self.Description then
        self.Container.Size = UDim2.new(1, 0, 0, 70)
        
        self.DescriptionLabel = Instance.new("TextLabel")
        self.DescriptionLabel.Name = "Description"
        self.DescriptionLabel.Size = UDim2.new(1, -30, 0, 15)
        self.DescriptionLabel.Position = UDim2.new(0, 15, 1, -20)
        self.DescriptionLabel.BackgroundTransparency = 1
        self.DescriptionLabel.Text = self.Description
        self.DescriptionLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
        self.DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
        self.DescriptionLabel.TextYAlignment = Enum.TextYAlignment.Center
        self.DescriptionLabel.Font = self.Theme:GetTextProperties("Caption").Font
        self.DescriptionLabel.TextSize = self.Theme:GetTextProperties("Caption").TextSize
        self.DescriptionLabel.Parent = self.Container
    end
    
    -- Keybind button click event
    self.KeybindButton.MouseButton1Click:Connect(function()
        if self.Enabled then
            self:StartListening()
        end
    end)
    
    -- Hover effect
    Utils.SetupHoverEffect(self.Container, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
    Utils.SetupHoverEffect(self.KeybindButton, self.Theme:GetColor("AccentHover"), self.Theme:GetColor("Accent"))
end

function Keybind:GetKeyText()
    if self.Listening then
        return "..."
    end
    
    -- Convert KeyCode to readable text
    local keyName = tostring(self.Value):gsub("Enum.KeyCode.", "")
    
    -- Handle special keys
    local specialKeys = {
        LeftShift = "LShift",
        RightShift = "RShift",
        LeftControl = "LCtrl",
        RightControl = "RCtrl",
        LeftAlt = "LAlt",
        RightAlt = "RAlt",
        Space = "Space",
        Return = "Enter",
        Backspace = "Backspace",
        Delete = "Delete",
        Insert = "Insert",
        Home = "Home",
        End = "End",
        PageUp = "PgUp",
        PageDown = "PgDn",
        Up = "↑",
        Down = "↓",
        Left = "←",
        Right = "→"
    }
    
    return specialKeys[keyName] or keyName
end

function Keybind:StartListening()
    if self.Listening then return end
    
    self.Listening = true
    self.KeybindButton.Text = "..."
    self.KeybindButton.BackgroundColor3 = self.Theme:GetColor("Warning")
    
    -- Listen for next key press
    local connection
    connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            self:SetValue(input.KeyCode)
            self:StopListening()
            connection:Disconnect()
        end
    end)
    
    -- Auto-stop listening after 5 seconds
    spawn(function()
        wait(5)
        if self.Listening then
            self:StopListening()
            connection:Disconnect()
        end
    end)
end

function Keybind:StopListening()
    self.Listening = false
    self.KeybindButton.Text = self:GetKeyText()
    self.KeybindButton.BackgroundColor3 = self.Theme:GetColor("Accent")
end

function Keybind:SetupKeybindListener()
    if self.KeyConnection then
        self.KeyConnection:Disconnect()
    end
    
    self.KeyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == self.Value then
            if self.Hold then
                -- Hold mode - call callback while held
                spawn(function()
                    self.Callback(true)
                end)
                
                -- Listen for key release
                local releaseConnection
                releaseConnection = UserInputService.InputEnded:Connect(function(releaseInput)
                    if releaseInput.KeyCode == self.Value then
                        spawn(function()
                            self.Callback(false)
                        end)
                        releaseConnection:Disconnect()
                    end
                end)
            else
                -- Normal mode - call callback once
                spawn(function()
                    self.Callback()
                end)
            end
        end
    end)
end

function Keybind:SetValue(value)
    self.Value = value
    self.KeybindButton.Text = self:GetKeyText()
    
    -- Update listener
    self:SetupKeybindListener()
    
    -- Call callback
    spawn(function()
        self.Callback(self.Value)
    end)
end

function Keybind:SetEnabled(enabled)
    self.Enabled = enabled
    
    -- Update visual state
    local transparency = enabled and 0 or 0.5
    self.Container.BackgroundTransparency = transparency
    self.Label.TextTransparency = transparency
    self.KeybindButton.BackgroundTransparency = transparency
    self.KeybindButton.TextTransparency = transparency
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextTransparency = transparency
    end
    
    -- Disable/enable listener
    if self.KeyConnection then
        if not enabled then
            self.KeyConnection:Disconnect()
            self.KeyConnection = nil
        else
            self:SetupKeybindListener()
        end
    end
end

function Keybind:GetValue()
    return self.Value
end

function Keybind:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Surface")
    self.Label.TextColor3 = theme:GetColor("Text")
    
    if not self.Listening then
        self.KeybindButton.BackgroundColor3 = theme:GetColor("Accent")
    end
    
    if self.DescriptionLabel then
        self.DescriptionLabel.TextColor3 = theme:GetColor("TextSecondary")
    end
end

function Keybind:Destroy()
    if self.KeyConnection then
        self.KeyConnection:Disconnect()
    end
    
    self.Container:Destroy()
end

return Keybind
