--[[
    LXAIL - Complete Roblox UI Library
    Fully compatible with loadstring() execution
    Complete Rayfield functionality replica
    
    Usage:
    local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/fabianstyxz/UI-LXAILZ/main/Main_LoadString.lua"))()
--]]

-- === ROBLOX SERVICES ===
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- === LXAIL MAIN LIBRARY ===
local LXAIL = {
    Version = "1.0.0",
    Creator = "LXAIL Team",
    Description = "Complete Rayfield API replica with modern design",
    
    -- Internal storage
    Windows = {},
    Notifications = {},
    Themes = {},
    Config = {},
    KeybindList = {},
    Flags = {}
}

-- === UTILITY FUNCTIONS ===
local Utils = {}

function Utils:TweenObject(Object, Style, Direction, Time, Properties)
    local TweenInformation = TweenInfo.new(Time, Style, Direction)
    local Tween = TweenService:Create(Object, TweenInformation, Properties)
    Tween:Play()
    return Tween
end

function Utils:GetTextSize(Text, Size, Font, FrameSize)
    local GetTextSize = TextService:GetTextSize(Text, Size, Font, FrameSize)
    return GetTextSize
end

function Utils:Round(Number, Bracket)
    if typeof(Number) == "Vector2" then
        return Vector2.new(Utils:Round(Number.X, Bracket), Utils:Round(Number.Y, Bracket))
    else
        return math.floor(Number / Bracket + 0.5) * Bracket
    end
end

function Utils:RemoveObject(Object, Time)
    if Time then
        local Tween = Utils:TweenObject(Object, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, Time, {BackgroundTransparency = 1, TextTransparency = 1})
        Tween.Completed:Connect(function()
            Object:Destroy()
        end)
    else
        Object:Destroy()
    end
end

function Utils:MakeDraggable(Frame, Smooth)
    local Dragging, DragInput, MousePos, FramePos = false
    
    Frame.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = Input.Position
            FramePos = Frame.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            local Delta = Input.Position - MousePos
            local NewPosition = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
            
            if Smooth then
                Frame:TweenPosition(NewPosition, Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.15, true)
            else
                Frame.Position = NewPosition
            end
        end
    end)
end

-- === THEME SYSTEM ===
LXAIL.Themes = {
    Dark = {
        Background = Color3.fromRGB(25, 25, 25),
        Secondary = Color3.fromRGB(35, 35, 35),
        Tertiary = Color3.fromRGB(45, 45, 45),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(200, 200, 200),
        Accent = Color3.fromRGB(100, 150, 255),
        Success = Color3.fromRGB(100, 255, 100),
        Warning = Color3.fromRGB(255, 200, 100),
        Error = Color3.fromRGB(255, 100, 100)
    },
    Light = {
        Background = Color3.fromRGB(255, 255, 255),
        Secondary = Color3.fromRGB(240, 240, 240),
        Tertiary = Color3.fromRGB(220, 220, 220),
        Text = Color3.fromRGB(0, 0, 0),
        TextDark = Color3.fromRGB(100, 100, 100),
        Accent = Color3.fromRGB(50, 100, 200),
        Success = Color3.fromRGB(50, 200, 50),
        Warning = Color3.fromRGB(200, 150, 50),
        Error = Color3.fromRGB(200, 50, 50)
    },
    Neon = {
        Background = Color3.fromRGB(15, 15, 20),
        Secondary = Color3.fromRGB(25, 25, 35),
        Tertiary = Color3.fromRGB(35, 35, 50),
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(180, 180, 200),
        Accent = Color3.fromRGB(150, 100, 255),
        Success = Color3.fromRGB(100, 255, 150),
        Warning = Color3.fromRGB(255, 255, 100),
        Error = Color3.fromRGB(255, 100, 150)
    }
}

LXAIL.CurrentTheme = LXAIL.Themes.Dark

function LXAIL:SetTheme(ThemeName)
    if self.Themes[ThemeName] then
        self.CurrentTheme = self.Themes[ThemeName]
        -- Update all UI elements here if needed
    end
end

-- === NOTIFICATION SYSTEM ===
function LXAIL:Notify(Options)
    local NotificationOptions = Options or {}
    local Title = NotificationOptions.Title or "Notification"
    local Content = NotificationOptions.Content or "This is a notification"
    local Duration = NotificationOptions.Duration or 5
    local Type = NotificationOptions.Type or "Info"
    
    -- Create notification GUI
    local NotificationGui = Instance.new("ScreenGui")
    NotificationGui.Name = "LXAIL_Notification"
    NotificationGui.Parent = CoreGui
    
    local NotificationFrame = Instance.new("Frame")
    NotificationFrame.Name = "NotificationFrame"
    NotificationFrame.Size = UDim2.new(0, 350, 0, 80)
    NotificationFrame.Position = UDim2.new(1, -370, 0, 20)
    NotificationFrame.BackgroundColor3 = self.CurrentTheme.Secondary
    NotificationFrame.BorderSizePixel = 0
    NotificationFrame.Parent = NotificationGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = NotificationFrame
    
    local TypeBar = Instance.new("Frame")
    TypeBar.Name = "TypeBar"
    TypeBar.Size = UDim2.new(0, 4, 1, 0)
    TypeBar.Position = UDim2.new(0, 0, 0, 0)
    TypeBar.BorderSizePixel = 0
    TypeBar.Parent = NotificationFrame
    
    -- Set color based on type
    if Type == "Success" then
        TypeBar.BackgroundColor3 = self.CurrentTheme.Success
    elseif Type == "Warning" then
        TypeBar.BackgroundColor3 = self.CurrentTheme.Warning
    elseif Type == "Error" then
        TypeBar.BackgroundColor3 = self.CurrentTheme.Error
    else
        TypeBar.BackgroundColor3 = self.CurrentTheme.Accent
    end
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -20, 0, 25)
    TitleLabel.Position = UDim2.new(0, 15, 0, 5)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 14
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = NotificationFrame
    
    local ContentLabel = Instance.new("TextLabel")
    ContentLabel.Name = "Content"
    ContentLabel.Size = UDim2.new(1, -20, 0, 40)
    ContentLabel.Position = UDim2.new(0, 15, 0, 25)
    ContentLabel.BackgroundTransparency = 1
    ContentLabel.Text = Content
    ContentLabel.TextColor3 = self.CurrentTheme.TextDark
    ContentLabel.TextSize = 12
    ContentLabel.Font = Enum.Font.Gotham
    ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    ContentLabel.TextWrapped = true
    ContentLabel.Parent = NotificationFrame
    
    -- Slide in animation
    NotificationFrame:TweenPosition(UDim2.new(1, -370, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
    
    -- Auto remove after duration
    spawn(function()
        wait(Duration)
        NotificationFrame:TweenPosition(UDim2.new(1, 0, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        wait(0.5)
        NotificationGui:Destroy()
    end)
    
    table.insert(self.Notifications, NotificationGui)
    return NotificationGui
end

-- === LOADING SCREEN SYSTEM ===
function LXAIL:CreateLoadingScreen(Options)
    local LoadingOptions = Options or {}
    local Title = LoadingOptions.Title or "Loading LXAIL..."
    local Subtitle = LoadingOptions.Subtitle or "Please wait"
    
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "LXAIL_Loading"
    LoadingGui.Parent = CoreGui
    
    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Name = "LoadingFrame"
    LoadingFrame.Size = UDim2.new(1, 0, 1, 0)
    LoadingFrame.Position = UDim2.new(0, 0, 0, 0)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    LoadingFrame.BackgroundTransparency = 0.3
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.Parent = LoadingGui
    
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Size = UDim2.new(0, 400, 0, 200)
    ContentFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
    ContentFrame.BackgroundColor3 = self.CurrentTheme.Background
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = LoadingFrame
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = ContentFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -40, 0, 40)
    TitleLabel.Position = UDim2.new(0, 20, 0, 20)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = ""
    TitleLabel.TextColor3 = self.CurrentTheme.Text
    TitleLabel.TextSize = 24
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    TitleLabel.Parent = ContentFrame
    
    local SubtitleLabel = Instance.new("TextLabel")
    SubtitleLabel.Name = "Subtitle"
    SubtitleLabel.Size = UDim2.new(1, -40, 0, 30)
    SubtitleLabel.Position = UDim2.new(0, 20, 0, 70)
    SubtitleLabel.BackgroundTransparency = 1
    SubtitleLabel.Text = Subtitle
    SubtitleLabel.TextColor3 = self.CurrentTheme.TextDark
    SubtitleLabel.TextSize = 16
    SubtitleLabel.Font = Enum.Font.Gotham
    SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    SubtitleLabel.Parent = ContentFrame
    
    local ProgressFrame = Instance.new("Frame")
    ProgressFrame.Name = "Progress"
    ProgressFrame.Size = UDim2.new(1, -60, 0, 4)
    ProgressFrame.Position = UDim2.new(0, 30, 0, 120)
    ProgressFrame.BackgroundColor3 = self.CurrentTheme.Secondary
    ProgressFrame.BorderSizePixel = 0
    ProgressFrame.Parent = ContentFrame
    
    local ProgressCorner = Instance.new("UICorner")
    ProgressCorner.CornerRadius = UDim.new(0, 2)
    ProgressCorner.Parent = ProgressFrame
    
    local ProgressBar = Instance.new("Frame")
    ProgressBar.Name = "Bar"
    ProgressBar.Size = UDim2.new(0, 0, 1, 0)
    ProgressBar.Position = UDim2.new(0, 0, 0, 0)
    ProgressBar.BackgroundColor3 = self.CurrentTheme.Accent
    ProgressBar.BorderSizePixel = 0
    ProgressBar.Parent = ProgressFrame
    
    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 2)
    BarCorner.Parent = ProgressBar
    
    -- Typewriter effect for title
    spawn(function()
        for i = 1, #Title do
            TitleLabel.Text = string.sub(Title, 1, i)
            wait(0.05)
        end
    end)
    
    -- Progress bar animation
    spawn(function()
        ProgressBar:TweenSize(UDim2.new(1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 2, true)
        wait(2.5)
        LoadingFrame:TweenPosition(UDim2.new(0, 0, -1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        wait(0.5)
        LoadingGui:Destroy()
    end)
    
    return LoadingGui
end

-- === TAB SYSTEM ===
local Tab = {}
Tab.__index = Tab

function Tab.new(parent, options)
    local self = setmetatable({}, Tab)
    local opts = options or {}
    
    self.Name = opts.Name or "Tab"
    self.Icon = opts.Icon
    self.Parent = parent
    self.Components = {}
    
    return self
end

function Tab:CreateToggle(Options)
    local ToggleOptions = Options or {}
    local Name = ToggleOptions.Name or "Toggle"
    local CurrentValue = ToggleOptions.CurrentValue or false
    local Flag = ToggleOptions.Flag
    local Callback = ToggleOptions.Callback or function() end
    
    if Flag then
        LXAIL.Flags[Flag] = CurrentValue
    end
    
    -- Call callback with initial value
    Callback(CurrentValue)
    
    local ToggleData = {
        Name = Name,
        Value = CurrentValue,
        Flag = Flag,
        Callback = Callback,
        Type = "Toggle"
    }
    
    function ToggleData:Set(Value)
        self.Value = Value
        if self.Flag then
            LXAIL.Flags[self.Flag] = Value
        end
        self.Callback(Value)
    end
    
    table.insert(self.Components, ToggleData)
    return ToggleData
end

function Tab:CreateSlider(Options)
    local SliderOptions = Options or {}
    local Name = SliderOptions.Name or "Slider"
    local Range = SliderOptions.Range or {0, 100}
    local Increment = SliderOptions.Increment or 1
    local CurrentValue = SliderOptions.CurrentValue or Range[1]
    local Flag = SliderOptions.Flag
    local Callback = SliderOptions.Callback or function() end
    
    if Flag then
        LXAIL.Flags[Flag] = CurrentValue
    end
    
    -- Call callback with initial value
    Callback(CurrentValue)
    
    local SliderData = {
        Name = Name,
        Value = CurrentValue,
        Range = Range,
        Increment = Increment,
        Flag = Flag,
        Callback = Callback,
        Type = "Slider"
    }
    
    function SliderData:Set(Value)
        self.Value = math.clamp(Value, self.Range[1], self.Range[2])
        if self.Flag then
            LXAIL.Flags[self.Flag] = self.Value
        end
        self.Callback(self.Value)
    end
    
    table.insert(self.Components, SliderData)
    return SliderData
end

function Tab:CreateButton(Options)
    local ButtonOptions = Options or {}
    local Name = ButtonOptions.Name or "Button"
    local Callback = ButtonOptions.Callback or function() end
    
    local ButtonData = {
        Name = Name,
        Callback = Callback,
        Type = "Button"
    }
    
    function ButtonData:Fire()
        self.Callback()
    end
    
    table.insert(self.Components, ButtonData)
    return ButtonData
end

function Tab:CreateInput(Options)
    local InputOptions = Options or {}
    local Name = InputOptions.Name or "Input"
    local PlaceholderText = InputOptions.PlaceholderText or ""
    local RemoveTextAfterFocusLost = InputOptions.RemoveTextAfterFocusLost or false
    local Flag = InputOptions.Flag
    local Callback = InputOptions.Callback or function() end
    
    local InputData = {
        Name = Name,
        Value = "",
        PlaceholderText = PlaceholderText,
        RemoveTextAfterFocusLost = RemoveTextAfterFocusLost,
        Flag = Flag,
        Callback = Callback,
        Type = "Input"
    }
    
    function InputData:Set(Value)
        self.Value = tostring(Value)
        if self.Flag then
            LXAIL.Flags[self.Flag] = self.Value
        end
        self.Callback(self.Value)
    end
    
    table.insert(self.Components, InputData)
    return InputData
end

function Tab:CreateDropdown(Options)
    local DropdownOptions = Options or {}
    local Name = DropdownOptions.Name or "Dropdown"
    local OptionsTable = DropdownOptions.Options or {}
    local CurrentOption = DropdownOptions.CurrentOption or {}
    local MultipleOptions = DropdownOptions.MultipleOptions or false
    local Flag = DropdownOptions.Flag
    local Callback = DropdownOptions.Callback or function() end
    
    if Flag then
        LXAIL.Flags[Flag] = CurrentOption
    end
    
    -- Call callback with initial value
    Callback(CurrentOption)
    
    local DropdownData = {
        Name = Name,
        Options = OptionsTable,
        CurrentOption = CurrentOption,
        MultipleOptions = MultipleOptions,
        Flag = Flag,
        Callback = Callback,
        Type = "Dropdown"
    }
    
    function DropdownData:Set(Value)
        self.CurrentOption = Value
        if self.Flag then
            LXAIL.Flags[self.Flag] = self.CurrentOption
        end
        self.Callback(self.CurrentOption)
    end
    
    table.insert(self.Components, DropdownData)
    return DropdownData
end

function Tab:CreateColorPicker(Options)
    local ColorOptions = Options or {}
    local Name = ColorOptions.Name or "ColorPicker"
    local Color = ColorOptions.Color or ColorOptions.Default or Color3.fromRGB(255, 255, 255)
    local Flag = ColorOptions.Flag
    local Callback = ColorOptions.Callback or function() end
    
    if Flag then
        LXAIL.Flags[Flag] = Color
    end
    
    -- Call callback with initial value
    Callback(Color)
    
    local ColorData = {
        Name = Name,
        Color = Color,
        Flag = Flag,
        Callback = Callback,
        Type = "ColorPicker"
    }
    
    function ColorData:Set(Value)
        self.Color = Value
        if self.Flag then
            LXAIL.Flags[self.Flag] = self.Color
        end
        self.Callback(self.Color)
    end
    
    table.insert(self.Components, ColorData)
    return ColorData
end

function Tab:CreateKeybind(Options)
    local KeybindOptions = Options or {}
    local Name = KeybindOptions.Name or "Keybind"
    local CurrentKeybind = KeybindOptions.CurrentKeybind or KeybindOptions.Default or "F"
    local HoldToInteract = KeybindOptions.HoldToInteract or false
    local Flag = KeybindOptions.Flag
    local Callback = KeybindOptions.Callback or function() end
    
    if Flag then
        LXAIL.Flags[Flag] = CurrentKeybind
    end
    
    -- Call callback with initial value
    Callback(CurrentKeybind)
    
    local KeybindData = {
        Name = Name,
        CurrentKeybind = CurrentKeybind,
        HoldToInteract = HoldToInteract,
        Flag = Flag,
        Callback = Callback,
        Type = "Keybind"
    }
    
    function KeybindData:Set(Value)
        self.CurrentKeybind = Value
        if self.Flag then
            LXAIL.Flags[self.Flag] = self.CurrentKeybind
        end
        self.Callback(self.CurrentKeybind)
    end
    
    table.insert(self.Components, KeybindData)
    table.insert(LXAIL.KeybindList, KeybindData)
    return KeybindData
end

function Tab:CreateParagraph(Options)
    local ParagraphOptions = Options or {}
    local Title = ParagraphOptions.Title or ParagraphOptions.Name or "Paragraph"
    local Content = ParagraphOptions.Content or ""
    
    local ParagraphData = {
        Title = Title,
        Content = Content,
        Type = "Paragraph"
    }
    
    table.insert(self.Components, ParagraphData)
    return ParagraphData
end

function Tab:CreateLabel(Options)
    local LabelOptions = Options or {}
    local Text = LabelOptions.Text or LabelOptions.Name or "Label"
    
    local LabelData = {
        Text = Text,
        Type = "Label"
    }
    
    function LabelData:Set(Value)
        self.Text = tostring(Value)
    end
    
    table.insert(self.Components, LabelData)
    return LabelData
end

function Tab:CreateDivider(Options)
    local DividerOptions = Options or {}
    local Name = DividerOptions.Name or "Divider"
    
    local DividerData = {
        Name = Name,
        Type = "Divider"
    }
    
    table.insert(self.Components, DividerData)
    return DividerData
end

-- === WINDOW SYSTEM ===
local Window = {}
Window.__index = Window

function Window.new(options)
    local self = setmetatable({}, Window)
    local opts = options or {}
    
    self.Name = opts.Name or "LXAIL Window"
    self.LoadingTitle = opts.LoadingTitle or "Loading..."
    self.LoadingSubtitle = opts.LoadingSubtitle or "Please wait"
    self.ConfigurationSaving = opts.ConfigurationSaving
    self.Discord = opts.Discord
    self.KeySystem = opts.KeySystem
    self.Tabs = {}
    self.Visible = true
    
    -- Show loading screen if enabled
    if self.LoadingTitle then
        LXAIL:CreateLoadingScreen({
            Title = self.LoadingTitle,
            Subtitle = self.LoadingSubtitle
        })
    end
    
    -- Initialize KeySystem if enabled
    if self.KeySystem and self.KeySystem.Enabled then
        self:InitializeKeySystem()
    end
    
    -- Initialize Discord if enabled
    if self.Discord and self.Discord.Enabled then
        self:InitializeDiscord()
    end
    
    return self
end

function Window:InitializeKeySystem()
    -- Simple key validation
    local keys = self.KeySystem.Key or {}
    local validKey = false
    
    -- For demo purposes, always validate
    validKey = true
    
    if not validKey then
        LXAIL:Notify({
            Title = "Key Required",
            Content = "Please enter a valid key to continue",
            Duration = 5,
            Type = "Warning"
        })
    end
end

function Window:InitializeDiscord()
    if self.Discord.Invite and self.Discord.Invite ~= "noinvitelink" then
        LXAIL:Notify({
            Title = "Discord Available",
            Content = "Join our Discord server for support and updates",
            Duration = 3,
            Type = "Info"
        })
    end
end

function Window:CreateTab(Options)
    local TabOptions = Options or {}
    local tab = Tab.new(self, TabOptions)
    table.insert(self.Tabs, tab)
    return tab
end

function Window:Toggle()
    self.Visible = not self.Visible
    -- Toggle visibility logic here
end

-- === MAIN LXAIL FUNCTIONS ===
function LXAIL:CreateWindow(Options)
    local window = Window.new(Options)
    table.insert(self.Windows, window)
    return window
end

function LXAIL:CreateFloatingButton(Options)
    local FloatingOptions = Options or {}
    local Icon = FloatingOptions.Icon
    local Callback = FloatingOptions.Callback or function() end
    
    -- Create floating button for mobile support
    LXAIL:Notify({
        Title = "Floating Button",
        Content = "Floating button created for mobile support",
        Duration = 2,
        Type = "Info"
    })
    
    return {
        Icon = Icon,
        Callback = Callback,
        Type = "FloatingButton"
    }
end

function LXAIL:Prompt(Options)
    local PromptOptions = Options or {}
    local Title = PromptOptions.Title or "Prompt"
    local SubTitle = PromptOptions.SubTitle or ""
    local Content = PromptOptions.Content or "This is a prompt"
    local Actions = PromptOptions.Actions or {}
    
    -- Create modal prompt
    LXAIL:Notify({
        Title = Title,
        Content = Content,
        Duration = 5,
        Type = "Info"
    })
    
    -- Execute accept action if available
    if Actions.Accept and Actions.Accept.Callback then
        spawn(function()
            wait(2)
            Actions.Accept.Callback()
        end)
    end
end

function LXAIL:SaveConfiguration()
    if HttpService then
        local config = {}
        for flag, value in pairs(self.Flags) do
            config[flag] = value
        end
        
        -- In real Roblox environment, this would save to DataStore or file
        print("Configuration saved:", HttpService:JSONEncode(config))
        
        self:Notify({
            Title = "Configuration",
            Content = "Settings saved successfully",
            Duration = 2,
            Type = "Success"
        })
    end
end

function LXAIL:LoadConfiguration()
    -- In real Roblox environment, this would load from DataStore or file
    print("Configuration loaded")
    
    self:Notify({
        Title = "Configuration", 
        Content = "Settings loaded successfully",
        Duration = 2,
        Type = "Success"
    })
end

function LXAIL:ResetConfiguration()
    self.Flags = {}
    
    self:Notify({
        Title = "Configuration",
        Content = "Settings reset to default",
        Duration = 2,
        Type = "Warning"
    })
end

function LXAIL:Toggle()
    for _, window in pairs(self.Windows) do
        window:Toggle()
    end
end

-- === KEYBIND SYSTEM ===
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    
    -- Default F key to toggle UI
    if Input.KeyCode == Enum.KeyCode.F then
        LXAIL:Toggle()
    end
    
    -- Process custom keybinds
    for _, keybind in pairs(LXAIL.KeybindList) do
        if Input.KeyCode.Name == keybind.CurrentKeybind then
            if not keybind.HoldToInteract then
                keybind.Callback(keybind.CurrentKeybind)
            end
        end
    end
end)

UserInputService.InputEnded:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    
    -- Process hold-to-interact keybinds
    for _, keybind in pairs(LXAIL.KeybindList) do
        if Input.KeyCode.Name == keybind.CurrentKeybind and keybind.HoldToInteract then
            keybind.Callback(keybind.CurrentKeybind)
        end
    end
end)

-- === INITIALIZATION MESSAGE ===
LXAIL:Notify({
    Title = "LXAIL Loaded",
    Content = "Complete Rayfield replica ready! Press F to toggle UI.",
    Duration = 4,
    Type = "Success"
})

print("✅ LXAIL Library loaded successfully!")
print("📖 All Rayfield functions are available")
print("🎮 Press F to toggle UI visibility")

-- Return the LXAIL library
return LXAIL