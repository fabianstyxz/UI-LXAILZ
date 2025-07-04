--[[
    Window component for the Modern UI Library
--]]

-- Mock services for local environment compatibility
local TweenService = {}
local UserInputService = {}
local RunService = {}

local Utils = require("Modules.Utils")
local Tab = require("Modules.Tab")

local Window = {}
Window.__index = Window

function Window:new(parent, options, theme)
    local self = setmetatable({}, Window)
    
    -- Options
    local opts = options or {}
    self.Name = opts.Name or "Window"
    self.KeySystem = opts.KeySystem or false
    self.Icon = opts.Icon or nil
    self.IntroEnabled = opts.IntroEnabled ~= false
    self.CloseCallback = opts.CloseCallback or function() end
    self.Size = opts.Size or UDim2.new(0, 580, 0, 460)
    self.Position = opts.Position or UDim2.new(0.5, -290, 0.5, -230)
    
    -- Properties
    self.Parent = parent
    self.Theme = theme
    self.Tabs = {}
    self.CurrentTab = nil
    self.Visible = true
    self.Dragging = false
    self.DragStart = nil
    self.StartPos = nil
    
    -- Create window frame
    self:CreateWindow()
    
    -- Setup dragging
    self:SetupDragging()
    
    -- Intro animation
    if self.IntroEnabled then
        self:PlayIntroAnimation()
    end
    
    return self
end

function Window:CreateWindow()
    -- Main frame
    self.Frame = Instance.new("Frame")
    self.Frame.Name = "Window"
    self.Frame.Size = self.Size
    self.Frame.Position = self.Position
    self.Frame.BackgroundColor3 = self.Theme:GetColor("Primary")
    self.Frame.BorderSizePixel = 0
    self.Frame.ClipsDescendants = true
    self.Frame.Parent = self.Parent
    
    -- Add corner radius
    local corner = Utils.CreateCorner(self.Theme.CornerRadius)
    corner.Parent = self.Frame
    
    -- Add stroke
    local stroke = Utils.CreateStroke(1, self.Theme:GetColor("Border"))
    stroke.Parent = self.Frame
    
    -- Create shadow
    self:CreateShadow()
    
    -- Title bar
    self:CreateTitleBar()
    
    -- Tab container
    self:CreateTabContainer()
    
    -- Content area
    self:CreateContentArea()
    
    -- Resize grip
    self:CreateResizeGrip()
end

function Window:CreateShadow()
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, 4, 0, 4)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.Frame.ZIndex - 1
    shadow.Parent = self.Frame.Parent
    
    local shadowCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    shadowCorner.Parent = shadow
    
    self.Shadow = shadow
end

function Window:CreateTitleBar()
    -- Title bar frame
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 50)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0)
    self.TitleBar.BackgroundColor3 = self.Theme:GetColor("Secondary")
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.Frame
    
    -- Title bar corner (only top corners)
    local titleCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    titleCorner.Parent = self.TitleBar
    
    -- Title text
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "Title"
    self.TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Name
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.Font = self.Theme:GetTextProperties("Title").Font
    self.TitleLabel.TextSize = self.Theme:GetTextProperties("Title").TextSize
    self.TitleLabel.Parent = self.TitleBar
    
    -- Minimize button
    self.MinimizeButton = Instance.new("TextButton")
    self.MinimizeButton.Name = "MinimizeButton"
    self.MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    self.MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
    self.MinimizeButton.BackgroundColor3 = self.Theme:GetColor("Surface")
    self.MinimizeButton.BorderSizePixel = 0
    self.MinimizeButton.Text = "−"
    self.MinimizeButton.TextColor3 = self.Theme:GetColor("Text")
    self.MinimizeButton.Font = Enum.Font.GothamBold
    self.MinimizeButton.TextSize = 16
    self.MinimizeButton.Parent = self.TitleBar
    
    local minimizeCorner = Utils.CreateCorner(6)
    minimizeCorner.Parent = self.MinimizeButton
    
    -- Close button
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 30, 0, 30)
    self.CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
    self.CloseButton.BackgroundColor3 = self.Theme:GetColor("Error")
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.TextSize = 16
    self.CloseButton.Parent = self.TitleBar
    
    local closeCorner = Utils.CreateCorner(6)
    closeCorner.Parent = self.CloseButton
    
    -- Button events
    self.MinimizeButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    self.CloseButton.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    -- Hover effects
    Utils.SetupHoverEffect(self.MinimizeButton, self.Theme:GetColor("BorderHover"), self.Theme:GetColor("Surface"))
    Utils.SetupHoverEffect(self.CloseButton, Color3.fromRGB(200, 50, 50), self.Theme:GetColor("Error"))
end

function Window:CreateTabContainer()
    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Name = "TabContainer"
    self.TabContainer.Size = UDim2.new(1, 0, 0, 40)
    self.TabContainer.Position = UDim2.new(0, 0, 0, 50)
    self.TabContainer.BackgroundColor3 = self.Theme:GetColor("Background")
    self.TabContainer.BorderSizePixel = 0
    self.TabContainer.Parent = self.Frame
    
    -- Tab list layout
    self.TabList = Instance.new("UIListLayout")
    self.TabList.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabList.FillDirection = Enum.FillDirection.Horizontal
    self.TabList.HorizontalAlignment = Enum.HorizontalAlignment.Left
    self.TabList.VerticalAlignment = Enum.VerticalAlignment.Center
    self.TabList.Padding = UDim.new(0, 5)
    self.TabList.Parent = self.TabContainer
    
    -- Tab container padding
    local tabPadding = Utils.CreatePadding(10)
    tabPadding.Parent = self.TabContainer
end

function Window:CreateContentArea()
    self.ContentArea = Instance.new("Frame")
    self.ContentArea.Name = "ContentArea"
    self.ContentArea.Size = UDim2.new(1, 0, 1, -90)
    self.ContentArea.Position = UDim2.new(0, 0, 0, 90)
    self.ContentArea.BackgroundColor3 = self.Theme:GetColor("Background")
    self.ContentArea.BorderSizePixel = 0
    self.ContentArea.Parent = self.Frame
    
    -- Content area corner (only bottom corners)
    local contentCorner = Utils.CreateCorner(self.Theme.CornerRadius)
    contentCorner.Parent = self.ContentArea
end

function Window:CreateResizeGrip()
    -- Resize grip (bottom-right corner)
    self.ResizeGrip = Instance.new("Frame")
    self.ResizeGrip.Name = "ResizeGrip"
    self.ResizeGrip.Size = UDim2.new(0, 20, 0, 20)
    self.ResizeGrip.Position = UDim2.new(1, -20, 1, -20)
    self.ResizeGrip.BackgroundTransparency = 1
    self.ResizeGrip.Parent = self.Frame
    
    -- Resize lines
    for i = 1, 3 do
        local line = Instance.new("Frame")
        line.Size = UDim2.new(0, 2, 0, 10 - i * 2)
        line.Position = UDim2.new(0, 15 - i * 3, 1, -10 + i * 2)
        line.BackgroundColor3 = self.Theme:GetColor("Border")
        line.BorderSizePixel = 0
        line.Parent = self.ResizeGrip
    end
end

function Window:SetupDragging()
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    -- Title bar dragging
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.Frame.Position
        end
    end)
    
    self.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            self.Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            
            -- Update shadow position
            if self.Shadow then
                self.Shadow.Position = UDim2.new(self.Frame.Position.X.Scale, self.Frame.Position.X.Offset + 4, self.Frame.Position.Y.Scale, self.Frame.Position.Y.Offset + 4)
            end
        end
    end)
end

function Window:PlayIntroAnimation()
    -- Start with window scaled down and transparent
    self.Frame.Size = UDim2.new(0, 0, 0, 0)
    self.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.Frame.BackgroundTransparency = 1
    
    -- Animate to full size
    local introTween = Utils.CreateTween(self.Frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = self.Size,
        Position = self.Position,
        BackgroundTransparency = 0
    })
    
    introTween:Play()
    
    -- Typewriter effect for title
    spawn(function()
        wait(0.3)
        Utils.TypewriterEffect(self.TitleLabel, self.Name, 0.03)
    end)
end

function Window:CreateTab(options)
    local tab = Tab:new(self, options, self.Theme)
    table.insert(self.Tabs, tab)
    
    -- Set as current tab if it's the first one
    if #self.Tabs == 1 then
        self:SetCurrentTab(tab)
    end
    
    return tab
end

function Window:SetCurrentTab(tab)
    -- Hide current tab content
    if self.CurrentTab then
        self.CurrentTab:SetVisible(false)
    end
    
    -- Show new tab content
    self.CurrentTab = tab
    tab:SetVisible(true)
end

function Window:Toggle()
    self.Visible = not self.Visible
    
    local targetSize = self.Visible and self.Size or UDim2.new(self.Size.X.Scale, self.Size.X.Offset, 0, 50)
    local targetTransparency = self.Visible and 0 or 0.5
    
    local toggleTween = Utils.CreateTween(self.Frame, Utils.TweenInfo.Medium, {
        Size = targetSize,
        BackgroundTransparency = targetTransparency
    })
    
    toggleTween:Play()
    
    -- Hide/show content area
    self.ContentArea.Visible = self.Visible
    self.TabContainer.Visible = self.Visible
end

function Window:Close()
    self.CloseCallback()
    self:Destroy()
end

function Window:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update window colors
    self.Frame.BackgroundColor3 = theme:GetColor("Primary")
    self.TitleBar.BackgroundColor3 = theme:GetColor("Secondary")
    self.ContentArea.BackgroundColor3 = theme:GetColor("Background")
    self.TabContainer.BackgroundColor3 = theme:GetColor("Background")
    
    -- Update text colors
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    
    -- Update button colors
    self.MinimizeButton.BackgroundColor3 = theme:GetColor("Surface")
    self.MinimizeButton.TextColor3 = theme:GetColor("Text")
    self.CloseButton.BackgroundColor3 = theme:GetColor("Error")
    
    -- Update tabs
    for _, tab in pairs(self.Tabs) do
        tab:UpdateTheme(theme)
    end
end

function Window:Destroy()
    if self.Shadow then
        self.Shadow:Destroy()
    end
    
    for _, tab in pairs(self.Tabs) do
        tab:Destroy()
    end
    
    self.Frame:Destroy()
end

return Window
