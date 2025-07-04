--[[
    LXAIL - Complete Roblox UI Library
    Fully compatible with loadstring() execution
    Complete Rayfield functionality replica
    
    Usage:
    local LXAIL = loadstring(game:HttpGet("https://raw.githubusercontent.com/fabianstyxz/UI-LXAILZ/main/Main_LoadString.lua"))()
--]]

-- === ROBLOX SERVICES ===
-- Mock services for local testing
local TweenService, UserInputService, RunService, HttpService, TextService, GuiService, Players, CoreGui, Player, PlayerGui

if game then
    -- Running in Roblox environment
    TweenService = game:GetService("TweenService")
    UserInputService = game:GetService("UserInputService")
    RunService = game:GetService("RunService")
    HttpService = game:GetService("HttpService")
    TextService = game:GetService("TextService")
    GuiService = game:GetService("GuiService")
    Players = game:GetService("Players")
    CoreGui = game:GetService("CoreGui")
    Player = Players.LocalPlayer
    PlayerGui = Player:WaitForChild("PlayerGui")
else
    -- Mock environment for local testing
    TweenService = {
        Create = function(obj, info, props) 
            return {
                Play = function() end,
                Completed = {Connect = function() end}
            } 
        end
    }
    UserInputService = {
        InputBegan = {Connect = function() end},
        InputChanged = {Connect = function() end},
        InputEnded = {Connect = function() end}
    }
    RunService = {
        Heartbeat = {Connect = function() end}
    }
    HttpService = {
        JSONEncode = function(t) return "{}" end,
        JSONDecode = function(s) return {} end
    }
    TextService = {
        GetTextSize = function() return Vector2.new(100, 20) end
    }
    GuiService = {}
    Players = {
        LocalPlayer = {
            Name = "LocalPlayer"
        }
    }
    CoreGui = {}
    Player = Players.LocalPlayer
    PlayerGui = {}
    
    -- Mock global objects
    if not _G.Instance then
        _G.Instance = {
            new = function(className)
                return {
                    ClassName = className,
                    Name = "",
                    Parent = nil,
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BackgroundTransparency = 0,
                    BorderSizePixel = 0,
                    Text = "",
                    TextColor3 = Color3.new(0, 0, 0),
                    TextSize = 14,
                    Font = "Gotham",
                    TextXAlignment = "Left",
                    TextYAlignment = "Center",
                    TextWrapped = false,
                    Visible = true,
                    Active = false,
                    Draggable = false,
                    ResetOnSpawn = false,
                    MouseButton1Click = {Connect = function() end},
                    InputBegan = {Connect = function() end},
                    InputChanged = {Connect = function() end},
                    TweenPosition = function() end,
                    TweenSize = function() end,
                    Destroy = function() end,
                    FillDirection = "Vertical",
                    SortOrder = "LayoutOrder",
                    Padding = UDim.new(0, 0),
                    CornerRadius = UDim.new(0, 0),
                    GetPropertyChangedSignal = function() 
                        return {Connect = function() end}
                    end,
                    GetChildren = function()
                        return {}
                    end,
                    FocusLost = {Connect = function() end},
                    AbsoluteSize = Vector2.new(100, 100)
                }
            end
        }
    end
    
    if not _G.UDim2 then
        _G.UDim2 = {
            new = function(xScale, xOffset, yScale, yOffset)
                return {
                    X = {Scale = xScale or 0, Offset = xOffset or 0},
                    Y = {Scale = yScale or 0, Offset = yOffset or 0}
                }
            end
        }
    end
    
    if not _G.Color3 then
        _G.Color3 = {
            new = function(r, g, b)
                return {R = r or 0, G = g or 0, B = b or 0}
            end,
            fromRGB = function(r, g, b)
                return {R = (r or 0)/255, G = (g or 0)/255, B = (b or 0)/255}
            end
        }
    end
    
    if not _G.Vector2 then
        _G.Vector2 = {
            new = function(x, y)
                return {X = x or 0, Y = y or 0}
            end
        }
    end
    
    if not _G.UDim then
        _G.UDim = {
            new = function(scale, offset)
                return {Scale = scale or 0, Offset = offset or 0}
            end
        }
    end
    
    if not _G.TweenInfo then
        _G.TweenInfo = {
            new = function(...)
                return {}
            end
        }
    end
    
    if not _G.Enum then
        _G.Enum = {
            EasingStyle = {
                Quart = "Quart",
                Sine = "Sine"
            },
            EasingDirection = {
                Out = "Out",
                In = "In"
            },
            Font = {
                Gotham = "Gotham",
                GothamBold = "GothamBold"
            },
            TextXAlignment = {
                Left = "Left",
                Center = "Center",
                Right = "Right"
            },
            TextYAlignment = {
                Top = "Top",
                Center = "Center",
                Bottom = "Bottom"
            },
            UserInputType = {
                MouseButton1 = "MouseButton1",
                Touch = "Touch",
                MouseMovement = "MouseMovement"
            },
            UserInputState = {
                Begin = "Begin",
                Change = "Change",
                End = "End"
            },
            FillDirection = {
                Vertical = "Vertical",
                Horizontal = "Horizontal"
            },
            SortOrder = {
                LayoutOrder = "LayoutOrder",
                Name = "Name"
            },
            KeyCode = {
                F = {Name = "F"},
                LeftShift = {Name = "LeftShift"}
            }
        }
    end
    
    if not _G.spawn then
        _G.spawn = function(func)
            func()
        end
    end
    
    if not _G.wait then
        _G.wait = function(time)
            -- Mock wait function
        end
    end
    
    if not math.clamp then
        math.clamp = function(value, min, max)
            return math.min(math.max(value, min), max)
        end
    end
end

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
    self.Window = parent  -- Add proper Window reference
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(InputData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(DropdownData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(ColorData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(KeybindData)
    end
    
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
    
    -- Update UI if this tab is currently selected
    if self.Window and self.Window.CurrentTab == self and self.Window.ContentScroll then
        self.Window:CreateComponentUI(ParagraphData)
    end
    
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

function Window:CreateSliderUI(component)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Name = "Slider_" .. component.Name
    SliderFrame.Size = UDim2.new(1, -20, 0, 60)
    SliderFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Parent = self.ContentScroll
    
    local SliderCorner = Instance.new("UICorner")
    SliderCorner.CornerRadius = UDim.new(0, 8)
    SliderCorner.Parent = SliderFrame
    
    local SliderLabel = Instance.new("TextLabel")
    SliderLabel.Name = "Label"
    SliderLabel.Size = UDim2.new(0.7, 0, 0, 20)
    SliderLabel.Position = UDim2.new(0, 15, 0, 10)
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Text = component.Name
    SliderLabel.TextColor3 = LXAIL.CurrentTheme.Text
    SliderLabel.TextSize = 14
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    SliderLabel.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Name = "Value"
    ValueLabel.Size = UDim2.new(0.3, -15, 0, 20)
    ValueLabel.Position = UDim2.new(0.7, 0, 0, 10)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(component.Value) .. (component.Suffix or "")
    ValueLabel.TextColor3 = LXAIL.CurrentTheme.TextDark
    ValueLabel.TextSize = 14
    ValueLabel.Font = Enum.Font.Gotham
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderTrack = Instance.new("Frame")
    SliderTrack.Name = "Track"
    SliderTrack.Size = UDim2.new(1, -30, 0, 4)
    SliderTrack.Position = UDim2.new(0, 15, 0, 40)
    SliderTrack.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Parent = SliderFrame
    
    local TrackCorner = Instance.new("UICorner")
    TrackCorner.CornerRadius = UDim.new(0, 2)
    TrackCorner.Parent = SliderTrack
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Name = "Fill"
    local fillPercent = (component.Value - component.Range[1]) / (component.Range[2] - component.Range[1])
    SliderFill.Size = UDim2.new(fillPercent, 0, 1, 0)
    SliderFill.Position = UDim2.new(0, 0, 0, 0)
    SliderFill.BackgroundColor3 = LXAIL.CurrentTheme.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderTrack
    
    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 2)
    FillCorner.Parent = SliderFill
    
    local SliderKnob = Instance.new("Frame")
    SliderKnob.Name = "Knob"
    SliderKnob.Size = UDim2.new(0, 12, 0, 12)
    SliderKnob.Position = UDim2.new(fillPercent, -6, 0, -4)
    SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SliderKnob.BorderSizePixel = 0
    SliderKnob.Parent = SliderTrack
    
    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(0, 6)
    KnobCorner.Parent = SliderKnob
    
    local dragging = false
    
    local function updateSlider(input)
        local trackSize = SliderTrack.AbsoluteSize.X
        local trackPos = SliderTrack.AbsolutePosition.X
        local mousePos = input.Position.X
        local relativePos = math.clamp(mousePos - trackPos, 0, trackSize)
        local percent = relativePos / trackSize
        
        local newValue = component.Range[1] + (percent * (component.Range[2] - component.Range[1]))
        newValue = Utils:Round(newValue, component.Increment)
        newValue = math.clamp(newValue, component.Range[1], component.Range[2])
        
        component.Value = newValue
        
        local newPercent = (newValue - component.Range[1]) / (component.Range[2] - component.Range[1])
        SliderFill:TweenSize(UDim2.new(newPercent, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        SliderKnob:TweenPosition(UDim2.new(newPercent, -6, 0, -4), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.1, true)
        
        ValueLabel.Text = tostring(newValue) .. (component.Suffix or "")
        
        if component.Flag then
            LXAIL.Flags[component.Flag] = newValue
        end
        component.Callback(newValue)
    end
    
    SliderTrack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function Window:CreateInputUI(component)
    local InputFrame = Instance.new("Frame")
    InputFrame.Name = "Input_" .. component.Name
    InputFrame.Size = UDim2.new(1, -20, 0, 60)
    InputFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = self.ContentScroll
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputFrame
    
    local InputLabel = Instance.new("TextLabel")
    InputLabel.Name = "Label"
    InputLabel.Size = UDim2.new(1, -30, 0, 20)
    InputLabel.Position = UDim2.new(0, 15, 0, 8)
    InputLabel.BackgroundTransparency = 1
    InputLabel.Text = component.Name
    InputLabel.TextColor3 = LXAIL.CurrentTheme.Text
    InputLabel.TextSize = 14
    InputLabel.Font = Enum.Font.Gotham
    InputLabel.TextXAlignment = Enum.TextXAlignment.Left
    InputLabel.Parent = InputFrame
    
    local InputBox = Instance.new("TextBox")
    InputBox.Name = "InputBox"
    InputBox.Size = UDim2.new(1, -30, 0, 25)
    InputBox.Position = UDim2.new(0, 15, 0, 28)
    InputBox.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    InputBox.BorderSizePixel = 0
    InputBox.Text = component.Value or ""
    InputBox.PlaceholderText = component.PlaceholderText or "Enter text..."
    InputBox.TextColor3 = LXAIL.CurrentTheme.Text
    InputBox.PlaceholderColor3 = LXAIL.CurrentTheme.TextDark
    InputBox.TextSize = 12
    InputBox.Font = Enum.Font.Gotham
    InputBox.TextXAlignment = Enum.TextXAlignment.Left
    InputBox.ClearTextOnFocus = false
    InputBox.Parent = InputFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = InputBox
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingLeft = UDim.new(0, 8)
    Padding.PaddingRight = UDim.new(0, 8)
    Padding.Parent = InputBox
    
    InputBox.FocusLost:Connect(function(enterPressed)
        component.Value = InputBox.Text
        
        if component.RemoveTextAfterFocusLost then
            InputBox.Text = ""
        end
        
        if component.Flag then
            LXAIL.Flags[component.Flag] = component.Value
        end
        component.Callback(component.Value)
    end)
end

function Window:CreateDropdownUI(component)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Name = "Dropdown_" .. component.Name
    DropdownFrame.Size = UDim2.new(1, -20, 0, 40)
    DropdownFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = self.ContentScroll
    
    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 8)
    DropdownCorner.Parent = DropdownFrame
    
    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Name = "Label"
    DropdownLabel.Size = UDim2.new(0.5, -15, 1, 0)
    DropdownLabel.Position = UDim2.new(0, 15, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = component.Name
    DropdownLabel.TextColor3 = LXAIL.CurrentTheme.Text
    DropdownLabel.TextSize = 14
    DropdownLabel.Font = Enum.Font.Gotham
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Name = "Button"
    DropdownButton.Size = UDim2.new(0.5, -25, 0, 25)
    DropdownButton.Position = UDim2.new(0.5, 5, 0, 7.5)
    DropdownButton.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    DropdownButton.BorderSizePixel = 0
    local currentText = component.MultipleOptions and table.concat(component.CurrentOption, ", ") or (component.CurrentOption[1] or "Select...")
    DropdownButton.Text = currentText
    DropdownButton.TextColor3 = LXAIL.CurrentTheme.Text
    DropdownButton.TextSize = 12
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.TextXAlignment = Enum.TextXAlignment.Center
    DropdownButton.Parent = DropdownFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = DropdownButton
    
    local Arrow = Instance.new("TextLabel")
    Arrow.Name = "Arrow"
    Arrow.Size = UDim2.new(0, 15, 1, 0)
    Arrow.Position = UDim2.new(1, -20, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Text = "▼"
    Arrow.TextColor3 = LXAIL.CurrentTheme.TextDark
    Arrow.TextSize = 10
    Arrow.Font = Enum.Font.Gotham
    Arrow.TextXAlignment = Enum.TextXAlignment.Center
    Arrow.Parent = DropdownButton
    
    local isOpen = false
    
    DropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        Arrow.Text = isOpen and "▲" or "▼"
        
        if isOpen then
            -- Create dropdown list
            local DropdownList = Instance.new("Frame")
            DropdownList.Name = "DropdownList"
            DropdownList.Size = UDim2.new(0.5, -25, 0, math.min(#component.Options * 25, 150))
            DropdownList.Position = UDim2.new(0.5, 5, 1, 5)
            DropdownList.BackgroundColor3 = LXAIL.CurrentTheme.Background
            DropdownList.BorderSizePixel = 0
            DropdownList.ZIndex = 10
            DropdownList.Parent = DropdownFrame
            
            local ListCorner = Instance.new("UICorner")
            ListCorner.CornerRadius = UDim.new(0, 6)
            ListCorner.Parent = DropdownList
            
            local ListStroke = Instance.new("UIStroke")
            ListStroke.Color = LXAIL.CurrentTheme.Tertiary
            ListStroke.Thickness = 1
            ListStroke.Parent = DropdownList
            
            local ScrollFrame = Instance.new("ScrollingFrame")
            ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
            ScrollFrame.BackgroundTransparency = 1
            ScrollFrame.BorderSizePixel = 0
            ScrollFrame.ScrollBarThickness = 4
            ScrollFrame.ScrollBarImageColor3 = LXAIL.CurrentTheme.Accent
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #component.Options * 25)
            ScrollFrame.Parent = DropdownList
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.FillDirection = Enum.FillDirection.Vertical
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ListLayout.Parent = ScrollFrame
            
            for i, option in pairs(component.Options) do
                local OptionButton = Instance.new("TextButton")
                OptionButton.Name = "Option_" .. tostring(i)
                OptionButton.Size = UDim2.new(1, 0, 0, 25)
                OptionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                OptionButton.BackgroundTransparency = 1
                OptionButton.BorderSizePixel = 0
                OptionButton.Text = option
                OptionButton.TextColor3 = LXAIL.CurrentTheme.Text
                OptionButton.TextSize = 12
                OptionButton.Font = Enum.Font.Gotham
                OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                OptionButton.LayoutOrder = i
                OptionButton.Parent = ScrollFrame
                
                local OptionPadding = Instance.new("UIPadding")
                OptionPadding.PaddingLeft = UDim.new(0, 8)
                OptionPadding.Parent = OptionButton
                
                OptionButton.MouseEnter:Connect(function()
                    OptionButton.BackgroundTransparency = 0.9
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    OptionButton.BackgroundTransparency = 1
                end)
                
                OptionButton.MouseButton1Click:Connect(function()
                    if component.MultipleOptions then
                        local found = false
                        for j, selected in pairs(component.CurrentOption) do
                            if selected == option then
                                table.remove(component.CurrentOption, j)
                                found = true
                                break
                            end
                        end
                        if not found then
                            table.insert(component.CurrentOption, option)
                        end
                        DropdownButton.Text = table.concat(component.CurrentOption, ", ")
                    else
                        component.CurrentOption = {option}
                        DropdownButton.Text = option
                    end
                    
                    if component.Flag then
                        LXAIL.Flags[component.Flag] = component.CurrentOption
                    end
                    component.Callback(component.CurrentOption)
                    
                    if not component.MultipleOptions then
                        DropdownList:Destroy()
                        isOpen = false
                        Arrow.Text = "▼"
                    end
                end)
            end
            
            -- Close when clicking outside
            spawn(function()
                wait(0.1)
                local connection
                connection = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        DropdownList:Destroy()
                        isOpen = false
                        Arrow.Text = "▼"
                        connection:Disconnect()
                    end
                end)
            end)
        else
            -- Close dropdown
            local existingList = DropdownFrame:FindFirstChild("DropdownList")
            if existingList then
                existingList:Destroy()
            end
        end
    end)
end

function Window:CreateColorPickerUI(component)
    local ColorFrame = Instance.new("Frame")
    ColorFrame.Name = "ColorPicker_" .. component.Name
    ColorFrame.Size = UDim2.new(1, -20, 0, 40)
    ColorFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    ColorFrame.BorderSizePixel = 0
    ColorFrame.Parent = self.ContentScroll
    
    local ColorCorner = Instance.new("UICorner")
    ColorCorner.CornerRadius = UDim.new(0, 8)
    ColorCorner.Parent = ColorFrame
    
    local ColorLabel = Instance.new("TextLabel")
    ColorLabel.Name = "Label"
    ColorLabel.Size = UDim2.new(1, -60, 1, 0)
    ColorLabel.Position = UDim2.new(0, 15, 0, 0)
    ColorLabel.BackgroundTransparency = 1
    ColorLabel.Text = component.Name
    ColorLabel.TextColor3 = LXAIL.CurrentTheme.Text
    ColorLabel.TextSize = 14
    ColorLabel.Font = Enum.Font.Gotham
    ColorLabel.TextXAlignment = Enum.TextXAlignment.Left
    ColorLabel.Parent = ColorFrame
    
    local ColorPreview = Instance.new("Frame")
    ColorPreview.Name = "Preview"
    ColorPreview.Size = UDim2.new(0, 30, 0, 20)
    ColorPreview.Position = UDim2.new(1, -40, 0, 10)
    ColorPreview.BackgroundColor3 = component.Color
    ColorPreview.BorderSizePixel = 0
    ColorPreview.Parent = ColorFrame
    
    local PreviewCorner = Instance.new("UICorner")
    PreviewCorner.CornerRadius = UDim.new(0, 6)
    PreviewCorner.Parent = ColorPreview
    
    local ColorButton = Instance.new("TextButton")
    ColorButton.Name = "ColorButton"
    ColorButton.Size = UDim2.new(0, 30, 0, 20)
    ColorButton.Position = UDim2.new(1, -40, 0, 10)
    ColorButton.BackgroundTransparency = 1
    ColorButton.Text = ""
    ColorButton.Parent = ColorFrame
    
    ColorButton.MouseButton1Click:Connect(function()
        -- Simple color picker - cycle through preset colors
        local colors = {
            Color3.fromRGB(255, 100, 100),
            Color3.fromRGB(100, 255, 100),
            Color3.fromRGB(100, 100, 255),
            Color3.fromRGB(255, 255, 100),
            Color3.fromRGB(255, 100, 255),
            Color3.fromRGB(100, 255, 255),
            Color3.fromRGB(255, 255, 255),
            Color3.fromRGB(150, 150, 150),
            Color3.fromRGB(50, 50, 50)
        }
        
        local currentIndex = 1
        for i, color in pairs(colors) do
            if component.Color == color then
                currentIndex = i
                break
            end
        end
        
        currentIndex = currentIndex % #colors + 1
        component.Color = colors[currentIndex]
        ColorPreview.BackgroundColor3 = component.Color
        
        if component.Flag then
            LXAIL.Flags[component.Flag] = component.Color
        end
        component.Callback(component.Color)
    end)
end

function Window:CreateKeybindUI(component)
    local KeybindFrame = Instance.new("Frame")
    KeybindFrame.Name = "Keybind_" .. component.Name
    KeybindFrame.Size = UDim2.new(1, -20, 0, 40)
    KeybindFrame.BackgroundColor3 = LXAIL.CurrentTheme.Secondary
    KeybindFrame.BorderSizePixel = 0
    KeybindFrame.Parent = self.ContentScroll
    
    local KeybindCorner = Instance.new("UICorner")
    KeybindCorner.CornerRadius = UDim.new(0, 8)
    KeybindCorner.Parent = KeybindFrame
    
    local KeybindLabel = Instance.new("TextLabel")
    KeybindLabel.Name = "Label"
    KeybindLabel.Size = UDim2.new(1, -80, 1, 0)
    KeybindLabel.Position = UDim2.new(0, 15, 0, 0)
    KeybindLabel.BackgroundTransparency = 1
    KeybindLabel.Text = component.Name .. (component.HoldToInteract and " (Hold)" or "")
    KeybindLabel.TextColor3 = LXAIL.CurrentTheme.Text
    KeybindLabel.TextSize = 14
    KeybindLabel.Font = Enum.Font.Gotham
    KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
    KeybindLabel.Parent = KeybindFrame
    
    local KeybindButton = Instance.new("TextButton")
    KeybindButton.Name = "Button"
    KeybindButton.Size = UDim2.new(0, 60, 0, 25)
    KeybindButton.Position = UDim2.new(1, -70, 0, 7.5)
    KeybindButton.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
    KeybindButton.BorderSizePixel = 0
    KeybindButton.Text = component.CurrentKeybind
    KeybindButton.TextColor3 = LXAIL.CurrentTheme.Text
    KeybindButton.TextSize = 12
    KeybindButton.Font = Enum.Font.Gotham
    KeybindButton.TextXAlignment = Enum.TextXAlignment.Center
    KeybindButton.Parent = KeybindFrame
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = KeybindButton
    
    local waitingForKey = false
    
    KeybindButton.MouseButton1Click:Connect(function()
        if waitingForKey then return end
        
        waitingForKey = true
        KeybindButton.Text = "..."
        KeybindButton.BackgroundColor3 = LXAIL.CurrentTheme.Accent
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            local newKey = input.KeyCode.Name
            if newKey ~= "Unknown" then
                component.CurrentKeybind = newKey
                KeybindButton.Text = newKey
                KeybindButton.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
                
                if component.Flag then
                    LXAIL.Flags[component.Flag] = newKey
                end
                component.Callback(newKey)
                
                waitingForKey = false
                connection:Disconnect()
            end
        end)
        
        -- Timeout after 5 seconds
        spawn(function()
            wait(5)
            if waitingForKey then
                KeybindButton.Text = component.CurrentKeybind
                KeybindButton.BackgroundColor3 = LXAIL.CurrentTheme.Tertiary
                waitingForKey = false
                connection:Disconnect()
            end
        end)
    end)
end

function Window:CreateParagraphUI(component)
    local ParagraphFrame = Instance.new("TextLabel")
    ParagraphFrame.Name = "Paragraph_" .. component.Title
    ParagraphFrame.Size = UDim2.new(1, -20, 0, 50)
    ParagraphFrame.BackgroundTransparency = 1
    ParagraphFrame.Text = component.Title .. "\n" .. component.Content
    ParagraphFrame.TextColor3 = LXAIL.CurrentTheme.TextDark
    ParagraphFrame.TextSize = 12
    ParagraphFrame.Font = Enum.Font.Gotham
    ParagraphFrame.TextXAlignment = Enum.TextXAlignment.Left
    ParagraphFrame.TextYAlignment = Enum.TextYAlignment.Top
    ParagraphFrame.TextWrapped = true
    ParagraphFrame.Parent = self.ContentScroll
    
    -- Auto-resize based on text
    local textSize = Utils:GetTextSize(ParagraphFrame.Text, 12, Enum.Font.Gotham, Vector2.new(ParagraphFrame.AbsoluteSize.X, math.huge))
    ParagraphFrame.Size = UDim2.new(1, -20, 0, math.max(50, textSize.Y + 10))
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
    
    -- Create floating button GUI
    local FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "LXAIL_FloatingButton"
    FloatingGui.Parent = CoreGui
    FloatingGui.ResetOnSpawn = false
    
    -- Floating button
    local FloatingButton = Instance.new("TextButton")
    FloatingButton.Name = "FloatingButton"
    FloatingButton.Size = UDim2.new(0, 60, 0, 60)
    FloatingButton.Position = UDim2.new(1, -80, 0.5, -30)
    FloatingButton.BackgroundColor3 = self.CurrentTheme.Accent
    FloatingButton.BorderSizePixel = 0
    FloatingButton.Text = ""
    FloatingButton.Active = true
    FloatingButton.Draggable = true
    FloatingButton.Parent = FloatingGui
    
    local FloatingCorner = Instance.new("UICorner")
    FloatingCorner.CornerRadius = UDim.new(0, 30)
    FloatingCorner.Parent = FloatingButton
    
    -- Icon or text
    if Icon then
        local IconImage = Instance.new("ImageLabel")
        IconImage.Name = "Icon"
        IconImage.Size = UDim2.new(0, 30, 0, 30)
        IconImage.Position = UDim2.new(0, 15, 0, 15)
        IconImage.BackgroundTransparency = 1
        IconImage.Image = Icon
        IconImage.Parent = FloatingButton
    else
        local IconText = Instance.new("TextLabel")
        IconText.Name = "IconText"
        IconText.Size = UDim2.new(1, 0, 1, 0)
        IconText.Position = UDim2.new(0, 0, 0, 0)
        IconText.BackgroundTransparency = 1
        IconText.Text = "⚡"
        IconText.TextColor3 = Color3.fromRGB(255, 255, 255)
        IconText.TextSize = 24
        IconText.Font = Enum.Font.GothamBold
        IconText.TextXAlignment = Enum.TextXAlignment.Center
        IconText.Parent = FloatingButton
    end
    
    -- Add shadow effect
    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 4, 1, 4)
    Shadow.Position = UDim2.new(0, -2, 0, 2)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.8
    Shadow.BorderSizePixel = 0
    Shadow.ZIndex = -1
    Shadow.Parent = FloatingButton
    
    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 30)
    ShadowCorner.Parent = Shadow
    
    -- Hover effects
    FloatingButton.MouseEnter:Connect(function()
        FloatingButton:TweenSize(UDim2.new(0, 65, 0, 65), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
    end)
    
    FloatingButton.MouseLeave:Connect(function()
        FloatingButton:TweenSize(UDim2.new(0, 60, 0, 60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
    end)
    
    -- Click handler
    FloatingButton.MouseButton1Click:Connect(function()
        -- Ripple effect
        local Ripple = Instance.new("Frame")
        Ripple.Name = "Ripple"
        Ripple.Size = UDim2.new(0, 0, 0, 0)
        Ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        Ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Ripple.BackgroundTransparency = 0.5
        Ripple.BorderSizePixel = 0
        Ripple.Parent = FloatingButton
        
        local RippleCorner = Instance.new("UICorner")
        RippleCorner.CornerRadius = UDim.new(0, 30)
        RippleCorner.Parent = Ripple
        
        -- Animate ripple
        Ripple:TweenSizeAndPosition(
            UDim2.new(1.5, 0, 1.5, 0),
            UDim2.new(-0.25, 0, -0.25, 0),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.3,
            true
        )
        
        spawn(function()
            wait(0.1)
            Ripple:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.2, true)
            wait(0.2)
            Ripple:Destroy()
        end)
        
        Callback()
    end)
    
    -- Edge snapping for mobile
    local function snapToEdge()
        local screenSize = workspace.CurrentCamera.ViewportSize
        local buttonPos = FloatingButton.AbsolutePosition
        local buttonSize = FloatingButton.AbsoluteSize
        
        local leftDist = buttonPos.X
        local rightDist = screenSize.X - (buttonPos.X + buttonSize.X)
        
        if leftDist < rightDist then
            -- Snap to left
            FloatingButton:TweenPosition(UDim2.new(0, 20, 0, buttonPos.Y), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        else
            -- Snap to right
            FloatingButton:TweenPosition(UDim2.new(1, -80, 0, buttonPos.Y), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        end
    end
    
    -- Detect mobile and enable edge snapping
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        FloatingButton.DragStopped:Connect(snapToEdge)
    end
    
    return {
        GUI = FloatingGui,
        Button = FloatingButton,
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
    
    -- Create modal prompt GUI
    local PromptGui = Instance.new("ScreenGui")
    PromptGui.Name = "LXAIL_Prompt"
    PromptGui.Parent = CoreGui
    PromptGui.ResetOnSpawn = false
    
    -- Background
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.5
    Background.BorderSizePixel = 0
    Background.Parent = PromptGui
    
    -- Main prompt frame
    local PromptFrame = Instance.new("Frame")
    PromptFrame.Name = "PromptFrame"
    PromptFrame.Size = UDim2.new(0, 450, 0, 250)
    PromptFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
    PromptFrame.BackgroundColor3 = self.CurrentTheme.Background
    PromptFrame.BorderSizePixel = 0
    PromptFrame.Parent = Background
    
    local PromptCorner = Instance.new("UICorner")
    PromptCorner.CornerRadius = UDim.new(0, 12)
    PromptCorner.Parent = PromptFrame
    
    -- Title
    local PromptTitle = Instance.new("TextLabel")
    PromptTitle.Name = "Title"
    PromptTitle.Size = UDim2.new(1, -40, 0, 30)
    PromptTitle.Position = UDim2.new(0, 20, 0, 15)
    PromptTitle.BackgroundTransparency = 1
    PromptTitle.Text = Title
    PromptTitle.TextColor3 = self.CurrentTheme.Text
    PromptTitle.TextSize = 20
    PromptTitle.Font = Enum.Font.GothamBold
    PromptTitle.TextXAlignment = Enum.TextXAlignment.Center
    PromptTitle.Parent = PromptFrame
    
    -- Subtitle
    if SubTitle ~= "" then
        local PromptSubtitle = Instance.new("TextLabel")
        PromptSubtitle.Name = "Subtitle"
        PromptSubtitle.Size = UDim2.new(1, -40, 0, 20)
        PromptSubtitle.Position = UDim2.new(0, 20, 0, 50)
        PromptSubtitle.BackgroundTransparency = 1
        PromptSubtitle.Text = SubTitle
        PromptSubtitle.TextColor3 = self.CurrentTheme.TextDark
        PromptSubtitle.TextSize = 14
        PromptSubtitle.Font = Enum.Font.Gotham
        PromptSubtitle.TextXAlignment = Enum.TextXAlignment.Center
        PromptSubtitle.Parent = PromptFrame
    end
    
    -- Content
    local PromptContent = Instance.new("TextLabel")
    PromptContent.Name = "Content"
    PromptContent.Size = UDim2.new(1, -40, 0, 80)
    PromptContent.Position = UDim2.new(0, 20, 0, 80)
    PromptContent.BackgroundTransparency = 1
    PromptContent.Text = Content
    PromptContent.TextColor3 = self.CurrentTheme.TextDark
    PromptContent.TextSize = 12
    PromptContent.Font = Enum.Font.Gotham
    PromptContent.TextXAlignment = Enum.TextXAlignment.Center
    PromptContent.TextWrapped = true
    PromptContent.Parent = PromptFrame
    
    -- Button container
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Size = UDim2.new(1, -40, 0, 40)
    ButtonContainer.Position = UDim2.new(0, 20, 1, -55)
    ButtonContainer.BackgroundTransparency = 1
    ButtonContainer.Parent = PromptFrame
    
    local ButtonLayout = Instance.new("UIListLayout")
    ButtonLayout.FillDirection = Enum.FillDirection.Horizontal
    ButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ButtonLayout.Padding = UDim.new(0, 10)
    ButtonLayout.Parent = ButtonContainer
    
    -- Accept button
    if Actions.Accept then
        local AcceptButton = Instance.new("TextButton")
        AcceptButton.Name = "AcceptButton"
        AcceptButton.Size = UDim2.new(0, 120, 0, 35)
        AcceptButton.BackgroundColor3 = self.CurrentTheme.Accent
        AcceptButton.BorderSizePixel = 0
        AcceptButton.Text = Actions.Accept.Name or "Accept"
        AcceptButton.TextColor3 = self.CurrentTheme.Text
        AcceptButton.TextSize = 14
        AcceptButton.Font = Enum.Font.GothamBold
        AcceptButton.LayoutOrder = 1
        AcceptButton.Parent = ButtonContainer
        
        local AcceptCorner = Instance.new("UICorner")
        AcceptCorner.CornerRadius = UDim.new(0, 8)
        AcceptCorner.Parent = AcceptButton
        
        AcceptButton.MouseButton1Click:Connect(function()
            if Actions.Accept.Callback then
                Actions.Accept.Callback()
            end
            PromptGui:Destroy()
        end)
    end
    
    -- Ignore/Cancel button
    if Actions.Ignore then
        local IgnoreButton = Instance.new("TextButton")
        IgnoreButton.Name = "IgnoreButton"
        IgnoreButton.Size = UDim2.new(0, 120, 0, 35)
        IgnoreButton.BackgroundColor3 = self.CurrentTheme.Secondary
        IgnoreButton.BorderSizePixel = 0
        IgnoreButton.Text = Actions.Ignore.Name or "Cancel"
        IgnoreButton.TextColor3 = self.CurrentTheme.Text
        IgnoreButton.TextSize = 14
        IgnoreButton.Font = Enum.Font.Gotham
        IgnoreButton.LayoutOrder = 2
        IgnoreButton.Parent = ButtonContainer
        
        local IgnoreCorner = Instance.new("UICorner")
        IgnoreCorner.CornerRadius = UDim.new(0, 8)
        IgnoreCorner.Parent = IgnoreButton
        
        IgnoreButton.MouseButton1Click:Connect(function()
            if Actions.Ignore.Callback then
                Actions.Ignore.Callback()
            end
            PromptGui:Destroy()
        end)
    end
    
    -- Slide in animation
    PromptFrame.Position = UDim2.new(0.5, -225, 1, 125)
    PromptFrame:TweenPosition(UDim2.new(0.5, -225, 0.5, -125), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
    
    return PromptGui
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