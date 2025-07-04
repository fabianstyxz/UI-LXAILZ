--[[
    Key System for the Modern UI Library
--]]

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local KeySystem = {}
KeySystem.__index = KeySystem

function KeySystem:new(parent, options, theme)
    local self = setmetatable({}, KeySystem)
    
    -- Options
    local opts = options or {}
    self.Title = opts.Title or "Key System"
    self.Subtitle = opts.Subtitle or "Enter your key to continue"
    self.KeyNote = opts.KeyNote or "Get your key from our Discord server"
    self.SaveKey = opts.SaveKey ~= false
    self.AcceptKey = opts.AcceptKey or "DEMO_KEY_123"
    self.Key = opts.Key or ""
    self.KeyLink = opts.KeyLink or "https://discord.gg/example"
    self.ValidateKey = opts.ValidateKey or nil -- Function to validate key
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Visible = true
    self.KeyValid = false
    
    -- Create key system
    self:CreateKeySystem()
    
    return self
end

function KeySystem:CreateKeySystem()
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "KeySystemContainer"
    self.Container.Size = UDim2.new(0, 400, 0, 300)
    self.Container.Position = UDim2.new(0.5, -200, 0.5, -150)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Primary")
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 1000
    self.Container.Parent = self.Parent
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    containerCorner.Parent = self.Container
    
    -- Container stroke
    local containerStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    containerStroke.Parent = self.Container
    
    -- Create shadow
    self:CreateShadow()
    
    -- Background overlay
    self.Overlay = Instance.new("Frame")
    self.Overlay.Name = "KeySystemOverlay"
    self.Overlay.Size = UDim2.new(1, 0, 1, 0)
    self.Overlay.Position = UDim2.new(0, 0, 0, 0)
    self.Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.Overlay.BackgroundTransparency = 0.5
    self.Overlay.BorderSizePixel = 0
    self.Overlay.ZIndex = 999
    self.Overlay.Parent = self.Parent
    
    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "KeySystemTitle"
    self.TitleLabel.Size = UDim2.new(1, -40, 0, 40)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 20)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Font = self.Theme:GetTextProperties("Title").Font
    self.TitleLabel.TextSize = self.Theme:GetTextProperties("Title").TextSize
    self.TitleLabel.Parent = self.Container
    
    -- Subtitle label
    self.SubtitleLabel = Instance.new("TextLabel")
    self.SubtitleLabel.Name = "KeySystemSubtitle"
    self.SubtitleLabel.Size = UDim2.new(1, -40, 0, 20)
    self.SubtitleLabel.Position = UDim2.new(0, 20, 0, 60)
    self.SubtitleLabel.BackgroundTransparency = 1
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.SubtitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.SubtitleLabel.Font = self.Theme:GetTextProperties("Body").Font
    self.SubtitleLabel.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.SubtitleLabel.Parent = self.Container
    
    -- Key input
    self.KeyInput = Instance.new("TextBox")
    self.KeyInput.Name = "KeyInput"
    self.KeyInput.Size = UDim2.new(1, -40, 0, 40)
    self.KeyInput.Position = UDim2.new(0, 20, 0, 100)
    self.KeyInput.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.KeyInput.BorderSizePixel = 0
    self.KeyInput.PlaceholderText = "Enter your key here..."
    self.KeyInput.Text = ""
    self.KeyInput.TextColor3 = self.Theme:GetColor("Text")
    self.KeyInput.PlaceholderColor3 = self.Theme:GetColor("TextDisabled")
    self.KeyInput.TextXAlignment = Enum.TextXAlignment.Center
    self.KeyInput.TextYAlignment = Enum.TextYAlignment.Center
    self.KeyInput.Font = self.Theme:GetTextProperties("Body").Font
    self.KeyInput.TextSize = self.Theme:GetTextProperties("Body").TextSize
    self.KeyInput.ClearButtonMode = Enum.ClearButtonMode.WhileEditing
    self.KeyInput.Parent = self.Container
    
    -- Key input corner
    local inputCorner = Utils.CreateCorner(6)
    inputCorner.Parent = self.KeyInput
    
    -- Key input stroke
    local inputStroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    inputStroke.Parent = self.KeyInput
    
    -- Validate button
    self.ValidateButton = Instance.new("TextButton")
    self.ValidateButton.Name = "ValidateButton"
    self.ValidateButton.Size = UDim2.new(0, 150, 0, 35)
    self.ValidateButton.Position = UDim2.new(0.5, -75, 0, 160)
    self.ValidateButton.BackgroundColor3 = self.Theme:GetColor("Success")
    self.ValidateButton.BorderSizePixel = 0
    self.ValidateButton.Text = "Validate Key"
    self.ValidateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.ValidateButton.Font = self.Theme:GetTextProperties("Button").Font
    self.ValidateButton.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.ValidateButton.AutoButtonColor = false
    self.ValidateButton.Parent = self.Container
    
    -- Validate button corner
    local validateCorner = Utils.CreateCorner(6)
    validateCorner.Parent = self.ValidateButton
    
    -- Get key button
    self.GetKeyButton = Instance.new("TextButton")
    self.GetKeyButton.Name = "GetKeyButton"
    self.GetKeyButton.Size = UDim2.new(0, 150, 0, 35)
    self.GetKeyButton.Position = UDim2.new(0.5, -75, 0, 210)
    self.GetKeyButton.BackgroundColor3 = self.Theme:GetColor("Info")
    self.GetKeyButton.BorderSizePixel = 0
    self.GetKeyButton.Text = "Get Key"
    self.GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.GetKeyButton.Font = self.Theme:GetTextProperties("Button").Font
    self.GetKeyButton.TextSize = self.Theme:GetTextProperties("Button").TextSize
    self.GetKeyButton.AutoButtonColor = false
    self.GetKeyButton.Parent = self.Container
    
    -- Get key button corner
    local getKeyCorner = Utils.CreateCorner(6)
    getKeyCorner.Parent = self.GetKeyButton
    
    -- Key note label
    self.KeyNoteLabel = Instance.new("TextLabel")
    self.KeyNoteLabel.Name = "KeyNote"
    self.KeyNoteLabel.Size = UDim2.new(1, -40, 0, 20)
    self.KeyNoteLabel.Position = UDim2.new(0, 20, 0, 260)
    self.KeyNoteLabel.BackgroundTransparency = 1
    self.KeyNoteLabel.Text = self.KeyNote
    self.KeyNoteLabel.TextColor3 = self.Theme:GetColor("TextDisabled")
    self.KeyNoteLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.KeyNoteLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.KeyNoteLabel.Font = self.Theme:GetTextProperties("Caption").Font
    self.KeyNoteLabel.TextSize = self.Theme:GetTextProperties("Caption").TextSize
    self.KeyNoteLabel.Parent = self.Container
    
    -- Button events
    self.ValidateButton.MouseButton1Click:Connect(function()
        self:ValidateKey()
    end)
    
    self.GetKeyButton.MouseButton1Click:Connect(function()
        self:GetKey()
    end)
    
    -- Enter key validation
    self.KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            self:ValidateKey()
        end
    end)
    
    -- Hover effects
    Utils.SetupHoverEffect(self.ValidateButton, Color3.fromRGB(0, 180, 60), self.Theme:GetColor("Success"))
    Utils.SetupHoverEffect(self.GetKeyButton, Color3.fromRGB(50, 130, 200), self.Theme:GetColor("Info"))
    
    -- Load saved key
    self:LoadSavedKey()
end

function KeySystem:CreateShadow()
    local shadow = Instance.new("Frame")
    shadow.Name = "KeySystemShadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.Container.ZIndex - 1
    shadow.Parent = self.Container.Parent
    
    local shadowCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    shadowCorner.Parent = shadow
    
    self.Shadow = shadow
end

function KeySystem:ValidateKey()
    local inputKey = self.KeyInput.Text
    
    if inputKey == "" then
        self:ShowError("Please enter a key")
        return
    end
    
    -- Show loading state
    self.ValidateButton.Text = "Validating..."
    self.ValidateButton.BackgroundColor3 = self.Theme:GetColor("Warning")
    
    -- Custom validation function
    if self.ValidateKey then
        local isValid = self.ValidateKey(inputKey)
        self:HandleValidationResult(isValid, inputKey)
    else
        -- Default validation
        local isValid = inputKey == self.AcceptKey
        self:HandleValidationResult(isValid, inputKey)
    end
end

function KeySystem:HandleValidationResult(isValid, key)
    if isValid then
        self.KeyValid = true
        self.Key = key
        
        -- Save key if enabled
        if self.SaveKey then
            self:SaveKey(key)
        end
        
        -- Show success state
        self.ValidateButton.Text = "Key Valid!"
        self.ValidateButton.BackgroundColor3 = self.Theme:GetColor("Success")
        
        -- Hide key system after delay
        wait(1)
        self:Hide()
    else
        -- Show error state
        self.ValidateButton.Text = "Invalid Key"
        self.ValidateButton.BackgroundColor3 = self.Theme:GetColor("Error")
        
        -- Reset button after delay
        wait(2)
        self.ValidateButton.Text = "Validate Key"
        self.ValidateButton.BackgroundColor3 = self.Theme:GetColor("Success")
    end
end

function KeySystem:GetKey()
    -- Copy key link to clipboard (if supported)
    if setclipboard then
        setclipboard(self.KeyLink)
        self:ShowSuccess("Key link copied to clipboard!")
    end
    
    -- Open key link in browser (if supported)
    if syn and syn.request then
        syn.request({
            Url = self.KeyLink,
            Method = "GET"
        })
    end
    
    -- Show feedback
    self.GetKeyButton.Text = "Opening Link..."
    self.GetKeyButton.BackgroundColor3 = self.Theme:GetColor("Warning")
    
    wait(1)
    self.GetKeyButton.Text = "Get Key"
    self.GetKeyButton.BackgroundColor3 = self.Theme:GetColor("Info")
end

function KeySystem:SaveKey(key)
    if writefile then
        local keyData = {
            key = key,
            timestamp = os.time()
        }
        
        writefile("key_system_data.json", HttpService:JSONEncode(keyData))
    end
end

function KeySystem:LoadSavedKey()
    if readfile and isfile and isfile("key_system_data.json") then
        local success, data = pcall(function()
            return HttpService:JSONDecode(readfile("key_system_data.json"))
        end)
        
        if success and data.key then
            self.KeyInput.Text = data.key
        end
    end
end

function KeySystem:ShowError(message)
    self.SubtitleLabel.Text = message
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("Error")
    
    -- Reset after delay
    wait(2)
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
end

function KeySystem:ShowSuccess(message)
    self.SubtitleLabel.Text = message
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("Success")
    
    -- Reset after delay
    wait(2)
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
end

function KeySystem:Hide()
    self.Visible = false
    
    -- Fade out animation
    local fadeOutTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        BackgroundTransparency = 1
    })
    
    local overlayFadeOut = Utils.CreateTween(self.Overlay, Utils.TweenInfo.Medium, {
        BackgroundTransparency = 1
    })
    
    fadeOutTween:Play()
    overlayFadeOut:Play()
    
    -- Scale down animation
    local scaleDownTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 0, 0, 0)
    })
    
    scaleDownTween:Play()
    
    -- Cleanup after animation
    scaleDownTween.Completed:Connect(function()
        self:Destroy()
    end)
end

function KeySystem:Show()
    self.Visible = true
    
    -- Show with scale animation
    self.Container.Size = UDim2.new(0, 0, 0, 0)
    self.Container.BackgroundTransparency = 1
    
    local scaleUpTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 400, 0, 300),
        BackgroundTransparency = 0
    })
    
    scaleUpTween:Play()
end

function KeySystem:IsKeyValid()
    return self.KeyValid
end

function KeySystem:GetKey()
    return self.Key
end

function KeySystem:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Primary")
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    self.SubtitleLabel.TextColor3 = theme:GetColor("TextSecondary")
    self.KeyInput.BackgroundColor3 = theme:GetColor("Surface")
    self.KeyInput.TextColor3 = theme:GetColor("Text")
    self.KeyInput.PlaceholderColor3 = theme:GetColor("TextDisabled")
    self.KeyNoteLabel.TextColor3 = theme:GetColor("TextDisabled")
end

function KeySystem:Destroy()
    if self.Shadow then
        self.Shadow:Destroy()
    end
    
    if self.Overlay then
        self.Overlay:Destroy()
    end
    
    self.Container:Destroy()
end

return KeySystem
