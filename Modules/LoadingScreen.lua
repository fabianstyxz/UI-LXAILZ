--[[
    Loading Screen for the Modern UI Library
--]]

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Utils = loadstring(game:HttpGet("Modules/Utils.lua"))()

local LoadingScreen = {}
LoadingScreen.__index = LoadingScreen

function LoadingScreen:new(parent, options, theme)
    local self = setmetatable({}, LoadingScreen)
    
    -- Options
    local opts = options or {}
    self.Title = opts.Title or "Loading..."
    self.Subtitle = opts.Subtitle or "Please wait"
    self.AutoHide = opts.AutoHide ~= false
    self.Duration = opts.Duration or 3
    
    -- Properties
    self.Parent = parent
    self.Theme = theme or {
        GetColor = function(_, color)
            local colors = {
                Primary = Color3.fromRGB(25, 25, 25),
                Text = Color3.fromRGB(255, 255, 255),
                TextSecondary = Color3.fromRGB(200, 200, 200),
                Accent = Color3.fromRGB(0, 162, 255)
            }
            return colors[color] or Color3.fromRGB(255, 255, 255)
        end
    }
    self.Visible = false
    self.Progress = 0
    self.LoadingConnection = nil
    
    -- Create loading screen
    self:CreateLoadingScreen()
    
    return self
end

function LoadingScreen:CreateLoadingScreen()
    -- Background overlay
    self.Overlay = Instance.new("Frame")
    self.Overlay.Name = "LoadingOverlay"
    self.Overlay.Size = UDim2.new(1, 0, 1, 0)
    self.Overlay.Position = UDim2.new(0, 0, 0, 0)
    self.Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.Overlay.BackgroundTransparency = 0.3
    self.Overlay.BorderSizePixel = 0
    self.Overlay.ZIndex = 2000
    self.Overlay.Visible = false
    self.Overlay.Parent = self.Parent
    
    -- Main container
    self.Container = Instance.new("Frame")
    self.Container.Name = "LoadingContainer"
    self.Container.Size = UDim2.new(0, 300, 0, 150)
    self.Container.Position = UDim2.new(0.5, -150, 0.5, -75)
    self.Container.BackgroundColor3 = self.Theme:GetColor("Primary")
    self.Container.BorderSizePixel = 0
    self.Container.ZIndex = 2001
    self.Container.Parent = self.Overlay
    
    -- Container corner
    local containerCorner = Utils.CreateCorner(12)
    containerCorner.Parent = self.Container
    
    -- Create shadow
    self:CreateShadow()
    
    -- Loading spinner
    self.Spinner = Instance.new("Frame")
    self.Spinner.Name = "LoadingSpinner"
    self.Spinner.Size = UDim2.new(0, 40, 0, 40)
    self.Spinner.Position = UDim2.new(0.5, -20, 0, 20)
    self.Spinner.BackgroundTransparency = 1
    self.Spinner.Parent = self.Container
    
    -- Create spinner elements
    self:CreateSpinner()
    
    -- Title label
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "LoadingTitle"
    self.TitleLabel.Size = UDim2.new(1, -40, 0, 25)
    self.TitleLabel.Position = UDim2.new(0, 20, 0, 70)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = self.Theme:GetColor("Text")
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextSize = 16
    self.TitleLabel.Parent = self.Container
    
    -- Subtitle label
    self.SubtitleLabel = Instance.new("TextLabel")
    self.SubtitleLabel.Name = "LoadingSubtitle"
    self.SubtitleLabel.Size = UDim2.new(1, -40, 0, 20)
    self.SubtitleLabel.Position = UDim2.new(0, 20, 0, 95)
    self.SubtitleLabel.BackgroundTransparency = 1
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = self.Theme:GetColor("TextSecondary")
    self.SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.SubtitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.SubtitleLabel.Font = Enum.Font.Gotham
    self.SubtitleLabel.TextSize = 12
    self.SubtitleLabel.Parent = self.Container
    
    -- Progress bar
    self.ProgressBackground = Instance.new("Frame")
    self.ProgressBackground.Name = "ProgressBackground"
    self.ProgressBackground.Size = UDim2.new(1, -40, 0, 3)
    self.ProgressBackground.Position = UDim2.new(0, 20, 0, 125)
    self.ProgressBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    self.ProgressBackground.BorderSizePixel = 0
    self.ProgressBackground.Parent = self.Container
    
    -- Progress bar corner
    local progressCorner = Utils.CreateCorner(2)
    progressCorner.Parent = self.ProgressBackground
    
    -- Progress bar fill
    self.ProgressFill = Instance.new("Frame")
    self.ProgressFill.Name = "ProgressFill"
    self.ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    self.ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    self.ProgressFill.BackgroundColor3 = self.Theme:GetColor("Accent")
    self.ProgressFill.BorderSizePixel = 0
    self.ProgressFill.Parent = self.ProgressBackground
    
    -- Progress fill corner
    local fillCorner = Utils.CreateCorner(2)
    fillCorner.Parent = self.ProgressFill
end

function LoadingScreen:CreateShadow()
    local shadow = Instance.new("Frame")
    shadow.Name = "LoadingShadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, 5, 0, 5)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.Container.ZIndex - 1
    shadow.Parent = self.Container.Parent
    
    local shadowCorner = Utils.CreateCorner(12)
    shadowCorner.Parent = shadow
    
    self.Shadow = shadow
end

function LoadingScreen:CreateSpinner()
    -- Create spinner dots
    self.SpinnerDots = {}
    local dotCount = 8
    local radius = 15
    
    for i = 1, dotCount do
        local dot = Instance.new("Frame")
        dot.Name = "SpinnerDot" .. i
        dot.Size = UDim2.new(0, 4, 0, 4)
        dot.BackgroundColor3 = self.Theme:GetColor("Accent")
        dot.BorderSizePixel = 0
        dot.Parent = self.Spinner
        
        -- Position dot in circle
        local angle = (i - 1) / dotCount * 2 * math.pi
        local x = math.cos(angle) * radius + 20
        local y = math.sin(angle) * radius + 20
        dot.Position = UDim2.new(0, x - 2, 0, y - 2)
        
        -- Dot corner
        local dotCorner = Utils.CreateCorner(2)
        dotCorner.Parent = dot
        
        table.insert(self.SpinnerDots, dot)
    end
    
    -- Start spinner animation
    self:StartSpinnerAnimation()
end

function LoadingScreen:StartSpinnerAnimation()
    local currentDot = 1
    
    self.LoadingConnection = RunService.Heartbeat:Connect(function()
        if not self.Visible then return end
        
        -- Reset all dots
        for _, dot in ipairs(self.SpinnerDots) do
            dot.BackgroundTransparency = 0.7
            dot.Size = UDim2.new(0, 4, 0, 4)
        end
        
        -- Highlight current dot
        local dot = self.SpinnerDots[currentDot]
        if dot then
            dot.BackgroundTransparency = 0
            dot.Size = UDim2.new(0, 6, 0, 6)
        end
        
        -- Move to next dot
        currentDot = currentDot + 1
        if currentDot > #self.SpinnerDots then
            currentDot = 1
        end
        
        wait(0.1)
    end)
end

function LoadingScreen:Show()
    if self.Visible then return end
    
    self.Visible = true
    self.Overlay.Visible = true
    
    -- Start with container scaled down
    self.Container.Size = UDim2.new(0, 0, 0, 0)
    self.Container.BackgroundTransparency = 1
    
    -- Scale up animation
    local scaleUpTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 300, 0, 150),
        BackgroundTransparency = 0
    })
    
    scaleUpTween:Play()
    
    -- Typewriter effect for title
    spawn(function()
        wait(0.3)
        Utils.TypewriterEffect(self.TitleLabel, self.Title, 0.05)
    end)
    
    -- Auto-hide if enabled
    if self.AutoHide then
        spawn(function()
            wait(self.Duration)
            self:Hide()
        end)
    end
    
    -- Simulate loading progress
    self:SimulateProgress()
end

function LoadingScreen:SimulateProgress()
    spawn(function()
        local startTime = tick()
        local duration = self.Duration
        
        while self.Visible and tick() - startTime < duration do
            local elapsed = tick() - startTime
            local progress = math.min(elapsed / duration, 1)
            
            self:SetProgress(progress)
            wait(0.05)
        end
        
        self:SetProgress(1)
    end)
end

function LoadingScreen:SetProgress(progress)
    self.Progress = math.max(0, math.min(1, progress))
    
    -- Update progress bar
    local progressTween = Utils.CreateTween(self.ProgressFill, Utils.TweenInfo.Fast, {
        Size = UDim2.new(self.Progress, 0, 1, 0)
    })
    
    progressTween:Play()
end

function LoadingScreen:Hide()
    if not self.Visible then return end
    
    self.Visible = false
    
    -- Scale down animation
    local scaleDownTween = Utils.CreateTween(self.Container, Utils.TweenInfo.Medium, {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    scaleDownTween:Play()
    
    -- Fade out overlay
    local overlayFadeOut = Utils.CreateTween(self.Overlay, Utils.TweenInfo.Medium, {
        BackgroundTransparency = 1
    })
    
    overlayFadeOut:Play()
    
    -- Cleanup after animation
    scaleDownTween.Completed:Connect(function()
        self.Overlay.Visible = false
        self.Overlay.BackgroundTransparency = 0.3
    end)
end

function LoadingScreen:SetTitle(title)
    self.Title = title
    self.TitleLabel.Text = title
end

function LoadingScreen:SetSubtitle(subtitle)
    self.Subtitle = subtitle
    self.SubtitleLabel.Text = subtitle
end

function LoadingScreen:UpdateTheme(theme)
    self.Theme = theme
    
    -- Update colors
    self.Container.BackgroundColor3 = theme:GetColor("Primary")
    self.TitleLabel.TextColor3 = theme:GetColor("Text")
    self.SubtitleLabel.TextColor3 = theme:GetColor("TextSecondary")
    self.ProgressFill.BackgroundColor3 = theme:GetColor("Accent")
    
    -- Update spinner dots
    for _, dot in ipairs(self.SpinnerDots) do
        dot.BackgroundColor3 = theme:GetColor("Accent")
    end
end

function LoadingScreen:Destroy()
    if self.LoadingConnection then
        self.LoadingConnection:Disconnect()
    end
    
    if self.Shadow then
        self.Shadow:Destroy()
    end
    
    self.Overlay:Destroy()
end

return LoadingScreen
