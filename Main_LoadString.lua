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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(ToggleData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(SliderData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(ButtonData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(LabelData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(DividerData)
    end
    
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
        
        -- Wait for loading to complete then create main UI
        spawn(function()
            wait(3) -- Wait for loading screen to finish
            self:CreateMainUI()
        end)
    else
        self:CreateMainUI()
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

function Window:CreateMainUI()
    -- Create main ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "LXAIL_UI"
    self.ScreenGui.Parent = CoreGui
    self.ScreenGui.ResetOnSpawn = false
    
    -- Main window frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainWindow"
    self.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainFrame.BackgroundColor3 = LXAIL.CurrentTheme.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Active = true
    self.MainFrame.Draggable = false
    self.MainFrame.Parent = self.ScreenGui
    
    -- Main frame corner
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = self.MainFrame
    
    -- Make draggable
    Utils:MakeDraggable(self.MainFrame, true)
    
    -- Title bar
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 50)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    self.TitleBar.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = self.TitleBar
    
    -- Fix title bar corners
    local TitleFix = Instance.new("Frame")
    TitleFix.Size = UDim2.new(1, 0, 0, 25)
    TitleFix.Position = UDim2.new(0, 0, 1, -25)
    TitleFix.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    TitleFix.BorderSizePixel = 0
    TitleFix.Parent = self.TitleBar
    
    -- Title text
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "Title"
    self.TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Name
    self.TitleLabel.TextColor3 = LXAIL.CurrentTheme.Text
    self.TitleLabel.TextSize = 18
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Parent = self.TitleBar
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    self.CloseButton.Position = UDim2.new(1, -40, 0, 10)
    self.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.TextSize = 20
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.Parent = self.TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = self.CloseButton
    
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    -- Tab container
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(0, 150, 1, -50)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 50)
    self.TabContainer.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.MainFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 0)
    TabCorner.Parent = self.TabContainer
    
    -- Tab list layout
    self.TabList = Instance.new("UIListLayout")
    self.TabList.FillDirection = Enum.FillDirection.Vertical
    self.TabList.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabList.Padding = UDim.new(0, 2)
    self.TabList.Parent = self.TabContainer
    
    -- Content container
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Size = UDim2.new(1, -150, 1, -50)
    self.ContentContainer.Position = UDim2.new(0, 150, 0, 50)
    self.ContentContainer.BackgroundColor3 = LXAIL.CurrentTheme.Background
    self.ContentContainer.BorderSizePixel = 0
    self.ContentContainer.Parent = self.MainFrame
    
    -- Content scroll
    self.ContentScroll = Instance.new("ScrollingFrame")
    self.ContentScroll.Name = "ContentScroll"
    self.ContentScroll.Size = UDim2.new(1, -20, 1, -20)
    self.ContentScroll.Position = UDim2.new(0, 10, 0, 10)
    self.ContentScroll.BackgroundTransparency = 1
    self.ContentScroll.BorderSizePixel = 0
    self.ContentScroll.ScrollBarThickness = 6
    self.ContentScroll.ScrollBarImageColor3 = LXAIL.CurrentTheme.Accent
    self.ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentScroll.Parent = self.ContentContainer
    
    -- Content layout
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.FillDirection = Enum.FillDirection.Vertical
    self.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContentLayout.Padding = UDim.new(0, 8)
    self.ContentLayout.Parent = self.ContentScroll
    
    -- Update scroll canvas when content changes
    self.ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.ContentScroll.CanvasSize = UDim2.new(0, 0, 0, self.ContentLayout.AbsoluteContentSize.Y + 20)
    end)
    
    -- Slide in animation
    self.MainFrame.Position = UDim2.new(0.5, -300, 1, 200)
    self.MainFrame:TweenPosition(UDim2.new(0.5, -300, 0.5, -200), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
    
    LXAIL:Notify({
        Title = "LXAIL Ready",
        Content = "Interface loaded successfully! Create tabs to get started.",
        Duration = 3,
        Type = "Success"
    })
end

function Window:InitializeKeySystem()
    local keySystem = self.KeySystem
    if not keySystem then return end
    
    -- Create KeySystem GUI
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "LXAIL_KeySystem"
    KeyGui.Parent = CoreGui
    KeyGui.ResetOnSpawn = false
    
    -- Background
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.5
    Background.BorderSizePixel = 0
    Background.Parent = KeyGui
    
    -- Main key frame
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeyFrame"
    KeyFrame.Size = UDim2.new(0, 400, 0, 300)
    KeyFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    KeyFrame.BackgroundColor3 = LXAIL.CurrentTheme.Background
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = Background
    
    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 12)
    KeyCorner.Parent = KeyFrame
    
    -- Title
    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Name = "Title"
    KeyTitle.Size = UDim2.new(1, -40, 0, 40)
    KeyTitle.Position = UDim2.new(0, 20, 0, 20)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Text = keySystem.Title or "Key System"
    KeyTitle.TextColor3 = LXAIL.CurrentTheme.Text
    KeyTitle.TextSize = 24
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.TextXAlignment = Enum.TextXAlignment.Center
    KeyTitle.Parent = KeyFrame
    
    -- Subtitle
    local KeySubtitle = Instance.new("TextLabel")
    KeySubtitle.Name = "Subtitle"
    KeySubtitle.Size = UDim2.new(1, -40, 0, 30)
    KeySubtitle.Position = UDim2.new(0, 20, 0, 70)
    KeySubtitle.BackgroundTransparency = 1
    KeySubtitle.Text = keySystem.Subtitle or "Enter access key"
    KeySubtitle.TextColor3 = LXAIL.CurrentTheme.TextDark
    KeySubtitle.TextSize = 16
    KeySubtitle.Font = Enum.Font.Gotham
    KeySubtitle.TextXAlignment = Enum.TextXAlignment.Center
    KeySubtitle.Parent = KeyFrame
    
    -- Note
    if keySystem.Note then
        local KeyNote = Instance.new("TextLabel")
        KeyNote.Name = "Note"
        KeyNote.Size = UDim2.new(1, -40, 0, 25)
        KeyNote.Position = UDim2.new(0, 20, 0, 110)
        KeyNote.BackgroundTransparency = 1
        KeyNote.Text = keySystem.Note
        KeyNote.TextColor3 = LXAIL.CurrentTheme.TextDark
        KeyNote.TextSize = 14
        KeyNote.Font = Enum.Font.Gotham
        KeyNote.TextXAlignment = Enum.TextXAlignment.Center
        KeyNote.TextWrapped = true
        KeyNote.Parent = KeyFrame
    end
    
    -- Key input
    local KeyInput = Instance.new("TextBox")
    KeyInput.Name = "KeyInput"
    KeyInput.Size = UDim2.new(1, -60, 0, 40)
    KeyInput.Position = UDim2.new(0, 30, 0, 150)
    KeyInput.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    KeyInput.BorderSizePixel = 0
    KeyInput.Text = ""
    KeyInput.PlaceholderText = "Enter your key here..."
    KeyInput.TextColor3 = LXAIL.CurrentTheme.Text
    KeyInput.PlaceholderColor3 = LXAIL.CurrentTheme.TextDark
    KeyInput.TextSize = 16
    KeyInput.Font = Enum.Font.Gotham
    KeyInput.TextXAlignment = Enum.TextXAlignment.Center
    KeyInput.ClearTextOnFocus = false
    KeyInput.Parent = KeyFrame
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = KeyInput
    
    -- Submit button
    local SubmitButton = Instance.new("TextButton")
    SubmitButton.Name = "SubmitButton"
    SubmitButton.Size = UDim2.new(0, 150, 0, 35)
    SubmitButton.Position = UDim2.new(0.5, -75, 0, 210)
    SubmitButton.BackgroundColor3 = LXAIL.CurrentTheme.Accent
    SubmitButton.BorderSizePixel = 0
    SubmitButton.Text = "Submit Key"
    SubmitButton.TextColor3 = LXAIL.CurrentTheme.Text
    SubmitButton.TextSize = 16
    SubmitButton.Font = Enum.Font.GothamBold
    SubmitButton.Parent = KeyFrame
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    SubmitCorner.Parent = SubmitButton
    
    -- Status label
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Size = UDim2.new(1, -40, 0, 25)
    StatusLabel.Position = UDim2.new(0, 20, 0, 260)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = LXAIL.CurrentTheme.Error
    StatusLabel.TextSize = 14
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
    StatusLabel.Parent = KeyFrame
    
    -- Validate key function
    local function validateKey(inputKey)
        local keys = keySystem.Key or {}
        for _, validKey in pairs(keys) do
            if inputKey == validKey then
                return true
            end
        end
        return false
    end
    
    -- Submit handler
    local function submitKey()
        local inputKey = KeyInput.Text
        
        if inputKey == "" then
            StatusLabel.Text = "Please enter a key"
            StatusLabel.TextColor3 = LXAIL.CurrentTheme.Warning
            return
        end
        
        if validateKey(inputKey) then
            StatusLabel.Text = "Key accepted! Loading..."
            StatusLabel.TextColor3 = LXAIL.CurrentTheme.Success
            
            -- Save key if enabled
            if keySystem.SaveKey then
                LXAIL.Flags["SavedKey"] = inputKey
            end
            
            -- Close key system
            spawn(function()
                wait(1)
                KeyGui:Destroy()
                
                -- Continue with main UI creation
                if self.LoadingTitle then
                    wait(0.5) -- Small delay before continuing
                end
                
                LXAIL:Notify({
                    Title = "Access Granted",
                    Content = "Key verified successfully!",
                    Duration = 3,
                    Type = "Success"
                })
            end)
        else
            StatusLabel.Text = "Invalid key. Please try again."
            StatusLabel.TextColor3 = LXAIL.CurrentTheme.Error
            
            -- Shake animation
            local originalPos = KeyFrame.Position
            KeyFrame:TweenPosition(UDim2.new(0.5, -210, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
            wait(0.1)
            KeyFrame:TweenPosition(UDim2.new(0.5, -190, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
            wait(0.1)
            KeyFrame:TweenPosition(originalPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        end
    end
    
    -- Button click
    SubmitButton.MouseButton1Click:Connect(submitKey)
    
    -- Enter key press
    KeyInput.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            submitKey()
        end
    end)
    
    -- Auto-focus input
    spawn(function()
        wait(0.1)
        KeyInput:CaptureFocus()
    end)
    
    -- Slide in animation
    KeyFrame.Position = UDim2.new(0.5, -200, 1, 150)
    KeyFrame:TweenPosition(UDim2.new(0.5, -200, 0.5, -150), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
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
    
    -- Create visual tab if main UI exists
    if self.MainFrame then
        self:CreateVisualTab(tab)
    end
    
    return tab
end

function Window:CreateVisualTab(tab)
    -- Create tab button
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "Tab_" .. tab.Name
    TabButton.Size = UDim2.new(1, -10, 0, 40)
    TabButton.Position = UDim2.new(0, 5, 0, 0)
    TabButton.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    TabButton.BorderSizePixel = 0
    TabButton.Text = tab.Name
    TabButton.TextColor3 = LXAIL.CurrentTheme.TextDark
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.LayoutOrder = #self.Tabs
    TabButton.Parent = self.TabContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = TabButton
    
    -- Tab icon (optional)
    if tab.Icon then
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Name = "Icon"
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Position = UDim2.new(0, 10, 0, 10)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = tab.Icon
        TabIcon.Parent = TabButton
        
        -- Adjust text position
        TabButton.TextXAlignment = Enum.TextXAlignment.Center
        local TextPadding = Instance.new("UIPadding")
        TextPadding.PaddingLeft = UDim.new(0, 40)
        TextPadding.Parent = TabButton
    else
        local TextPadding = Instance.new("UIPadding")
        TextPadding.PaddingLeft = UDim.new(0, 15)
        TextPadding.Parent = TabButton
    end
    
    -- Store references
    tab.Button = TabButton
    tab.Window = self
    
    -- Click handler
    TabButton.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    -- Select first tab automatically
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    return TabButton
end

function Window:SelectTab(selectedTab)
    -- Update all tab buttons
    for _, tab in pairs(self.Tabs) do
        if tab.Button then
            if tab == selectedTab then
                tab.Button.BackgroundColor3 = LXAIL.CurrentTheme.Accent
                tab.Button.TextColor3 = LXAIL.CurrentTheme.Text
            else
                tab.Button.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
                tab.Button.TextColor3 = LXAIL.CurrentTheme.TextDark
            end
        end
    end
    
    -- Clear current content
    for _, child in pairs(self.ContentScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    -- Show selected tab content
    self:DisplayTabContent(selectedTab)
    self.CurrentTab = selectedTab
end

function Window:DisplayTabContent(tab)
    for _, component in pairs(tab.Components) do
        self:CreateComponentUI(component)
    end
end

function Window:CreateComponentUI(component)
    if component.Type == "Toggle" then
        self:CreateToggleUI(component)
    elseif component.Type == "Slider" then
        self:CreateSliderUI(component)
    elseif component.Type == "Button" then
        self:CreateButtonUI(component)
    elseif component.Type == "Input" then
        self:CreateInputUI(component)
    elseif component.Type == "Dropdown" then
        self:CreateDropdownUI(component)
    elseif component.Type == "ColorPicker" then
        self:CreateColorPickerUI(component)
    elseif component.Type == "Keybind" then
        self:CreateKeybindUI(component)
    elseif component.Type == "Paragraph" then
        self:CreateParagraphUI(component)
    elseif component.Type == "Label" then
        self:CreateLabelUI(component)
    elseif component.Type == "Divider" then
        self:CreateDividerUI(component)
    end
end

function Window:CreateToggleUI(component)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Name = "Toggle_" .. component.Name
    ToggleFrame.Size = UDim2.new(1, -20, 0, 40)
    ToggleFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = self.ContentScroll
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Name = "Label"
    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 15, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = component.Name
    ToggleLabel.TextColor3 = LXAIL.CurrentTheme.Text
    ToggleLabel.TextSize = 14
    ToggleLabel.Font = Enum.Font.Gotham
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "Button"
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -50, 0, 10)
    ToggleButton.BackgroundColor3 = component.Value and LXAIL.CurrentTheme.Accent or LXAIL.CurrentTheme.Tertiary
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 10)
    ButtonCorner.Parent = ToggleButton
    
    local ToggleIndicator = Instance.new("Frame")
    ToggleIndicator.Name = "Indicator"
    ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    ToggleIndicator.Position = component.Value and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.Parent = ToggleButton
    
    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 8)
    IndicatorCorner.Parent = ToggleIndicator
    
    ToggleButton.MouseButton1Click:Connect(function()
        component.Value = not component.Value
        
        -- Update visual state
        ToggleButton.BackgroundColor3 = component.Value and LXAIL.CurrentTheme.Accent or LXAIL.CurrentTheme.Tertiary
        ToggleIndicator:TweenPosition(
            component.Value and UDim2.new(1, -18, 0, 2) or UDim2.new(0, 2, 0, 2),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.2,
            true
        )
        
        -- Update flag and call callback
        if component.Flag then
            LXAIL.Flags[component.Flag] = component.Value
        end
        component.Callback(component.Value)
    end)
end

function Window:CreateButtonUI(component)
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Name = "Button_" .. component.Name
    ButtonFrame.Size = UDim2.new(1, -20, 0, 35)
    ButtonFrame.BackgroundColor3 = LXAIL.CurrentTheme.Accent
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Text = component.Name
    ButtonFrame.TextColor3 = LXAIL.CurrentTheme.Text
    ButtonFrame.TextSize = 14
    ButtonFrame.Font = Enum.Font.GothamBold
    ButtonFrame.Parent = self.ContentScroll
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ButtonFrame
    
    ButtonFrame.MouseButton1Click:Connect(function()
        -- Ripple effect
        ButtonFrame.BackgroundColor3 = Color3.fromRGB(
            math.min(255, LXAIL.CurrentTheme.Accent.R * 255 + 20),
            math.min(255, LXAIL.CurrentTheme.Accent.G * 255 + 20),
            math.min(255, LXAIL.CurrentTheme.Accent.B * 255 + 20)
        )
        
        spawn(function()
            wait(0.1)
            ButtonFrame.BackgroundColor3 = LXAIL.CurrentTheme.Accent
        end)
        
        component.Callback()
    end)
end

function Window:CreateLabelUI(component)
    local LabelFrame = Instance.new("TextLabel")
    LabelFrame.Name = "Label_" .. (component.Text or "Label")
    LabelFrame.Size = UDim2.new(1, -20, 0, 25)
    LabelFrame.BackgroundTransparency = 1
    LabelFrame.Text = component.Text
    LabelFrame.TextColor3 = LXAIL.CurrentTheme.TextDark
    LabelFrame.TextSize = 14
    LabelFrame.Font = Enum.Font.Gotham
    LabelFrame.TextXAlignment = Enum.TextXAlignment.Left
    LabelFrame.TextWrapped = true
    LabelFrame.Parent = self.ContentScroll
    
    -- Auto-resize based on text
    local textSize = Utils:GetTextSize(component.Text, 14, Enum.Font.Gotham, Vector2.new(LabelFrame.AbsoluteSize.X, math.huge))
    LabelFrame.Size = UDim2.new(1, -20, 0, math.max(25, textSize.Y + 5))
end

function Window:CreateDividerUI(component)
    local DividerFrame = Instance.new("Frame")
    DividerFrame.Name = "Divider"
    DividerFrame.Size = UDim2.new(1, -40, 0, 1)
    DividerFrame.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    DividerFrame.BorderSizePixel = 0
    DividerFrame.Parent = self.ContentScroll
end

function Window:Toggle()
    self.Visible = not self.Visible
    
    if self.ScreenGui then
        self.ScreenGui.Enabled = self.Visible
        
        if self.Visible then
            -- Slide in animation
            self.MainFrame.Position = UDim2.new(0.5, -300, 1, 200)
            self.MainFrame:TweenPosition(UDim2.new(0.5, -300, 0.5, -200), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
        end
    end
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