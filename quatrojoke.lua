-- [[ quatrojoke Script | Tung Tung Sahur Update ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Cleanup
if CoreGui:FindFirstChild("QuatrojokeUI") then CoreGui:FindFirstChild("QuatrojokeUI"):Destroy() end
if Workspace:FindFirstChild("QuatroFXContainer") then Workspace:FindFirstChild("QuatroFXContainer"):Destroy() end

-- ==========================================
-- SCREEN GUI & CONTAINERS
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuatrojokeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local DrawingCanvas = Instance.new("Frame")
DrawingCanvas.Name = "DrawingCanvas"
DrawingCanvas.Size = UDim2.new(1, 0, 1, 0)
DrawingCanvas.BackgroundTransparency = 1
DrawingCanvas.Parent = ScreenGui

local FXContainer = Instance.new("Folder")
FXContainer.Name = "QuatroFXContainer"
FXContainer.Parent = Workspace

-- ==========================================
-- MAIN FRAME
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 440)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -220)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 10) MainCorner.Parent = MainFrame
local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(255, 30, 60) MainStroke.Thickness = 2 MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 12, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "quatrojoke <font color=\"#B4B4B4\">| MM2</font>"
TitleLabel.RichText = true
TitleLabel.Font = Enum.Font.FredokaOne
TitleLabel.TextSize = 22
TitleLabel.TextColor3 = Color3.fromRGB(255, 30, 60)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 25)
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 80)
CloseBtn.TextSize = 13
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(0, 6) CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() 
    FXContainer:Destroy()
    ScreenGui:Destroy() 
end)

-- Dragging
local dragging, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
TopBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Sidebar
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 150, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideList = Instance.new("UIListLayout") SideList.Padding = UDim.new(0, 6) SideList.SortOrder = Enum.SortOrder.LayoutOrder SideList.Parent = SideBar
local SidePadding = Instance.new("UIPadding") SidePadding.PaddingTop = UDim.new(0, 8) SidePadding.PaddingLeft = UDim.new(0, 8) SidePadding.PaddingRight = UDim.new(0, 8) SidePadding.Parent = SideBar

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -150, 1, -40)
ContentArea.Position = UDim2.new(0, 150, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ==========================================
-- INTRO FRAME
-- ==========================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(0, 580, 0, 440)
IntroFrame.Position = UDim2.new(0.5, -290, 0.5, -220)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IntroFrame.BackgroundTransparency = 0.05
IntroFrame.ClipsDescendants = true
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner") IntroCorner.CornerRadius = UDim.new(0, 10) IntroCorner.Parent = IntroFrame
local IntroStroke = Instance.new("UIStroke") IntroStroke.Color = Color3.fromRGB(255, 30, 60) IntroStroke.Thickness = 2 IntroStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border IntroStroke.Parent = IntroFrame

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Size = UDim2.new(1, 0, 0, 60)
IntroTitle.Position = UDim2.new(0, 0, 0.3, -30)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "quatrojoke"
IntroTitle.Font = Enum.Font.FredokaOne
IntroTitle.TextSize = 52
IntroTitle.TextColor3 = Color3.fromRGB(255, 30, 60)
IntroTitle.TextStrokeTransparency = 0.2
IntroTitle.TextStrokeColor3 = Color3.fromRGB(150, 0, 30)
IntroTitle.Parent = IntroFrame

local IntroSub = Instance.new("TextLabel")
IntroSub.Size = UDim2.new(1, 0, 0, 25)
IntroSub.Position = UDim2.new(0, 0, 0.3, 30)
IntroSub.BackgroundTransparency = 1
IntroSub.Text = "Murder Mystery 2 Edition"
IntroSub.Font = Enum.Font.GothamMedium
IntroSub.TextSize = 16
IntroSub.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroSub.Parent = IntroFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 380, 0, 8)
BarBg.Position = UDim2.new(0.5, -190, 0.6, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
BarBg.BorderSizePixel = 0
BarBg.Parent = IntroFrame

local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(1, 0) BarCorner.Parent = BarBg
local BarFill = Instance.new("Frame") BarFill.Size = UDim2.new(0, 0, 1, 0) BarFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60) BarFill.BorderSizePixel = 0 BarFill.Parent = BarBg
local FillCorner = Instance.new("UICorner") FillCorner.CornerRadius = UDim.new(1, 0) FillCorner.Parent = BarFill

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0.6, 12)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Инициализация..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 13
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Parent = IntroFrame

math.randomseed(os.time())
local loadTime = math.random(4, 14)
local statuses = {"Загрузка Tung Tung Sahur...", "Скрытие оригинального тела...", "Подключение анимации...", "Запуск quatrojoke..."}

task.spawn(function()
    local elapsed = 0
    while elapsed < loadTime do
        task.wait(0.1)
        elapsed = elapsed + 0.1
        local progress = math.clamp(elapsed / loadTime, 0, 1)
        BarFill.Size = UDim2.new(progress, 0, 1, 0)
        local statusIndex = math.clamp(math.floor(progress * #statuses) + 1, 1, #statuses)
        StatusLabel.Text = statuses[statusIndex] .. " (" .. math.floor(progress * 100) .. "%)"
    end
    
    StatusLabel.Text = "Готово!"
    task.wait(0.3)
    
    local fadeTween = TweenService:Create(IntroFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1})
    TweenService:Create(IntroTitle, TweenInfo.new(0.4), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    TweenService:Create(IntroSub, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(BarBg, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    TweenService:Create(StatusLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
    TweenService:Create(IntroStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
    
    fadeTween:Play()
    fadeTween.Completed:Connect(function()
        IntroFrame:Destroy()
        MainFrame.Visible = true
    end)
end)

-- ==========================================
-- DROPPED GUN NOTIFICATION
-- ==========================================
local GunAlertFrame = Instance.new("Frame")
GunAlertFrame.Name = "GunAlertFrame"
GunAlertFrame.Size = UDim2.new(0, 240, 0, 45)
GunAlertFrame.Position = UDim2.new(1, 20, 1, -60)
GunAlertFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
GunAlertFrame.BorderSizePixel = 0
GunAlertFrame.Parent = ScreenGui

local AlertCorner = Instance.new("UICorner") AlertCorner.CornerRadius = UDim.new(0, 8) AlertCorner.Parent = GunAlertFrame
local AlertStroke = Instance.new("UIStroke") AlertStroke.Color = Color3.fromRGB(255, 200, 0) AlertStroke.Thickness = 2 AlertStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border AlertStroke.Parent = GunAlertFrame

local AlertText = Instance.new("TextLabel")
AlertText.Size = UDim2.new(1, 0, 1, 0)
AlertText.BackgroundTransparency = 1
AlertText.Text = "⚠️ Пистолет на карте!"
AlertText.Font = Enum.Font.GothamBold
AlertText.TextSize = 14
AlertText.TextColor3 = Color3.fromRGB(255, 220, 50)
AlertText.Parent = GunAlertFrame

local alertActive = false
local function ShowGunAlert()
    if alertActive then return end
    alertActive = true
    GunAlertFrame:TweenPosition(UDim2.new(1, -250, 1, -60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
    task.delay(4, function()
        GunAlertFrame:TweenPosition(UDim2.new(1, 20, 1, -60), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.5, true, function()
            alertActive = false
        end)
    end)
end

-- ==========================================
-- CONFIG DATA
-- ==========================================
local Config = {
    Outlines = {
        Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
        Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
        Murder   = { Enabled = false, Color = Color3.fromRGB(255, 30, 60), Transparency = 1 },
        Gun      = { Enabled = false, Color = Color3.fromRGB(255, 200, 0), Transparency = 1, AlertEnabled = false }
    },
    Tracers = {
        Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
        Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
        Murder   = { Enabled = false, Color = Color3.fromRGB(255, 30, 60), Transparency = 1 }
    },
    Boxes = {
        Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
        Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
        Murder   = { Enabled = false, Color = Color3.fromRGB(255, 30, 60), Transparency = 1 }
    },
    Aura = { Enabled = false, Color = Color3.fromRGB(255, 30, 60), Transparency = 0.8 },
    Angel = { Enabled = false, Color = Color3.fromRGB(255, 255, 255), Transparency = 0.8 },
    TungTung = { Enabled = false }, -- Функция Tung Tung Sahur
    Movement = {
        Fly = { Enabled = false, Speed = 50, BatmanAnim = false },
        Spin = { Enabled = false, Speed = 20 },
        Noclip = { Enabled = false }
    }
}

-- ==========================================
-- TABS & UI BUILDER
-- ==========================================
local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Parent = SideBar
    
    local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 6) corner.Parent = btn
    
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -16, 1, -16)
    container.Position = UDim2.new(0, 8, 0, 8)
    container.BackgroundTransparency = 1
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 60)
    container.Visible = false
    container.Parent = ContentArea
    
    local layout = Instance.new("UIListLayout") layout.Padding = UDim.new(0, 8) layout.SortOrder = Enum.SortOrder.LayoutOrder layout.Parent = container
    
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Container.Visible = false
            TweenService:Create(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 34), TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
        end
        container.Visible = true
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 20, 30), TextColor3 = Color3.fromRGB(255, 30, 60)}):Play()
        CurrentTab = container
    end)
    
    table.insert(Tabs, {Button = btn, Container = container})
    if not CurrentTab then
        container.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(45, 20, 30)
        btn.TextColor3 = Color3.fromRGB(255, 30, 60)
        CurrentTab = container
    end
    return container
end

local TabVisuals = CreateTab("Visuals / ESP")
local TabFX = CreateTab("Visual Effects")
local TabMove = CreateTab("Movement")

local PaletteColors = {
    Color3.fromRGB(255, 255, 255),
    Color3.fromRGB(255, 30, 60),
    Color3.fromRGB(0, 255, 120),
    Color3.fromRGB(0, 140, 255),
    Color3.fromRGB(255, 200, 0),
    Color3.fromRGB(180, 0, 255)
}

local function CreateSection(parentTab, cfgRef, titleText, options)
    options = options or {}
    local hasColor = options.Color ~= false
    local hasTrans = options.Transparency ~= false
    local customSub = options.CustomSub
    local expandedHeight = options.ExpandedHeight or 170

    local sectionFrame = Instance.new("Frame")
    sectionFrame.Size = UDim2.new(1, -8, 0, 38)
    sectionFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    sectionFrame.ClipsDescendants = true
    sectionFrame.Parent = parentTab
    
    local secCorner = Instance.new("UICorner") secCorner.CornerRadius = UDim.new(0, 6) secCorner.Parent = sectionFrame
    local secStroke = Instance.new("UIStroke") secStroke.Color = Color3.fromRGB(45, 45, 55) secStroke.Thickness = 1 secStroke.Parent = sectionFrame
    
    local topToggle = Instance.new("Frame")
    topToggle.Size = UDim2.new(1, 0, 0, 38)
    topToggle.BackgroundTransparency = 1
    topToggle.Parent = sectionFrame
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0.65, 0, 1, 0)
    titleLbl.Position = UDim2.new(0, 12, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = titleText
    titleLbl.Font = Enum.Font.GothamMedium
    titleLbl.TextSize = 13
    titleLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = topToggle
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 42, 0, 22)
    toggleBtn.Position = UDim2.new(1, -90, 0.5, -11)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    toggleBtn.Text = ""
    toggleBtn.Parent = topToggle
    
    local togCorner = Instance.new("UICorner") togCorner.CornerRadius = UDim.new(1, 0) togCorner.Parent = toggleBtn
    local togDot = Instance.new("Frame") togDot.Size = UDim2.new(0, 16, 0, 16) togDot.Position = UDim2.new(0, 3, 0.5, -8) togDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150) togDot.Parent = toggleBtn
    local dotCorner = Instance.new("UICorner") dotCorner.CornerRadius = UDim.new(1, 0) dotCorner.Parent = togDot
    
    local expandBtn = Instance.new("TextButton")
    expandBtn.Size = UDim2.new(0, 30, 0, 38)
    expandBtn.Position = UDim2.new(1, -38, 0, 0)
    expandBtn.BackgroundTransparency = 1
    expandBtn.Text = "▼"
    expandBtn.Font = Enum.Font.GothamBold
    expandBtn.TextSize = 11
    expandBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    expandBtn.Parent = topToggle
    
    local subPanel = Instance.new("Frame")
    subPanel.Size = UDim2.new(1, -20, 0, expandedHeight - 40)
    subPanel.Position = UDim2.new(0, 10, 0, 42)
    subPanel.BackgroundTransparency = 1
    subPanel.Parent = sectionFrame
    
    local yOffset = 0
    
    if hasColor then
        local colorLbl = Instance.new("TextLabel")
        colorLbl.Size = UDim2.new(1, 0, 0, 20)
        colorLbl.Position = UDim2.new(0, 0, 0, yOffset)
        colorLbl.BackgroundTransparency = 1
        colorLbl.Text = "Color (Палитра):"
        colorLbl.Font = Enum.Font.Gotham
        colorLbl.TextSize = 12
        colorLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
        colorLbl.TextXAlignment = Enum.TextXAlignment.Left
        colorLbl.Parent = subPanel
        
        local colorPreview = Instance.new("Frame")
        colorPreview.Size = UDim2.new(0, 22, 0, 22)
        colorPreview.Position = UDim2.new(1, -22, 0, yOffset)
        colorPreview.BackgroundColor3 = cfgRef.Color or Color3.fromRGB(255, 30, 60)
        colorPreview.Parent = subPanel
        
        local prevCorner = Instance.new("UICorner") prevCorner.CornerRadius = UDim.new(0, 4) prevCorner.Parent = colorPreview
        
        local paletteFrame = Instance.new("Frame")
        paletteFrame.Size = UDim2.new(1, 0, 0, 26)
        paletteFrame.Position = UDim2.new(0, 0, 0, yOffset + 24)
        paletteFrame.BackgroundTransparency = 1
        paletteFrame.Parent = subPanel
        
        local palLayout = Instance.new("UIListLayout") palLayout.FillDirection = Enum.FillDirection.Horizontal palLayout.Padding = UDim.new(0, 6) palLayout.Parent = paletteFrame
        
        for _, col in ipairs(PaletteColors) do
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(0, 24, 0, 24)
            pBtn.BackgroundColor3 = col
            pBtn.Text = ""
            pBtn.Parent = paletteFrame
            local pCorner = Instance.new("UICorner") pCorner.CornerRadius = UDim.new(0, 4) pCorner.Parent = pBtn
            pBtn.MouseButton1Click:Connect(function()
                cfgRef.Color = col
                colorPreview.BackgroundColor3 = col
            end)
        end
        yOffset = yOffset + 54
    end
    
    if hasTrans then
        local transLbl = Instance.new("TextLabel")
        transLbl.Size = UDim2.new(1, 0, 0, 20)
        transLbl.Position = UDim2.new(0, 0, 0, yOffset)
        transLbl.BackgroundTransparency = 1
        transLbl.Text = "Transparency: " .. math.floor((cfgRef.Transparency or 0.5) * 100) .. "%"
        transLbl.Font = Enum.Font.Gotham
        transLbl.TextSize = 12
        transLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
        transLbl.TextXAlignment = Enum.TextXAlignment.Left
        transLbl.Parent = subPanel
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, 8)
        sliderBg.Position = UDim2.new(0, 0, 0, yOffset + 24)
        sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        sliderBg.Parent = subPanel
        
        local sBgCorner = Instance.new("UICorner") sBgCorner.CornerRadius = UDim.new(1, 0) sBgCorner.Parent = sliderBg
        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new(cfgRef.Transparency or 0.5, 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
        sliderFill.Parent = sliderBg
        local sFillCorner = Instance.new("UICorner") sFillCorner.CornerRadius = UDim.new(1, 0) sFillCorner.Parent = sliderFill
        
        local sliding = false
        sliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end end)
        UserInputService.InputChanged:Connect(function(input)
            if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                transLbl.Text = "Transparency: " .. math.floor(pos * 100) .. "%"
                cfgRef.Transparency = pos
            end
        end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
        yOffset = yOffset + 40
    end
    
    if customSub then customSub(subPanel, yOffset) end
    
    toggleBtn.MouseButton1Click:Connect(function()
        cfgRef.Enabled = not cfgRef.Enabled
        local active = cfgRef.Enabled
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        TweenService:Create(togDot, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)}):Play()
    end)
    
    local expanded = false
    expandBtn.MouseButton1Click:Connect(function()
        expanded = not expanded
        expandBtn.Text = expanded and "▲" or "▼"
        secStroke.Color = expanded and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(45, 45, 55)
        TweenService:Create(sectionFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, -8, 0, expanded and expandedHeight or 38)}):Play()
    end)
end

local function CreateHeader(parentTab, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = "--- " .. text .. " ---"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(255, 30, 60)
    lbl.Parent = parentTab
end

-- Populate Visuals Tab
CreateHeader(TabVisuals, "OUTLINES")
CreateSection(TabVisuals, Config.Outlines.Innocent, "Outline Innocent")
CreateSection(TabVisuals, Config.Outlines.Sheriff, "ESP Sheriff")
CreateSection(TabVisuals, Config.Outlines.Murder, "ESP Murder")
CreateSection(TabVisuals, Config.Outlines.Gun, "ESP Gun", {
    ExpandedHeight = 190,
    CustomSub = function(panel, y)
        local alertLbl = Instance.new("TextLabel")
        alertLbl.Size = UDim2.new(0.7, 0, 0, 22)
        alertLbl.Position = UDim2.new(0, 0, 0, y)
        alertLbl.BackgroundTransparency = 1
        alertLbl.Text = "Сообщать что упал пистолет"
        alertLbl.Font = Enum.Font.GothamMedium
        alertLbl.TextSize = 12
        alertLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        alertLbl.TextXAlignment = Enum.TextXAlignment.Left
        alertLbl.Parent = panel
        
        local alertBtn = Instance.new("TextButton")
        alertBtn.Size = UDim2.new(0, 36, 0, 18)
        alertBtn.Position = UDim2.new(1, -36, 0, y + 2)
        alertBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        alertBtn.Text = ""
        alertBtn.Parent = panel
        
        local aCorner = Instance.new("UICorner") aCorner.CornerRadius = UDim.new(1, 0) aCorner.Parent = alertBtn
        local aDot = Instance.new("Frame") aDot.Size = UDim2.new(0, 12, 0, 12) aDot.Position = UDim2.new(0, 3, 0.5, -6) aDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150) aDot.Parent = alertBtn
        local adCorner = Instance.new("UICorner") adCorner.CornerRadius = UDim.new(1, 0) adCorner.Parent = aDot
        
        alertBtn.MouseButton1Click:Connect(function()
            Config.Outlines.Gun.AlertEnabled = not Config.Outlines.Gun.AlertEnabled
            local st = Config.Outlines.Gun.AlertEnabled
            TweenService:Create(alertBtn, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(aDot, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = st and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(150, 150, 150)}):Play()
        end)
    end
})

CreateHeader(TabVisuals, "TRACERS & LINES")
CreateSection(TabVisuals, Config.Tracers.Innocent, "Tracer Innocent")
CreateSection(TabVisuals, Config.Tracers.Sheriff, "Tracer Sheriff")
CreateSection(TabVisuals, Config.Tracers.Murder, "Tracer Murder")

CreateHeader(TabVisuals, "CLEAN BOXES")
CreateSection(TabVisuals, Config.Boxes.Innocent, "Box Innocent")
CreateSection(TabVisuals, Config.Boxes.Sheriff, "Box Sheriff")
CreateSection(TabVisuals, Config.Boxes.Murder, "Box Murder")

-- Populate Visual Effects Tab
CreateHeader(TabFX, "MEME AVATARS")
CreateSection(TabFX, Config.TungTung, "Tung Tung Sahur Model", {Color = false, Transparency = false, ExpandedHeight = 40})

CreateHeader(TabFX, "EFFECTS & AURA")
CreateSection(TabFX, Config.Aura, "Player Aura Effect")
CreateSection(TabFX, Config.Angel, "3D Volumetric Angel Wings")

-- Populate Movement Tab
CreateHeader(TabMove, "MOVEMENT MODES")
CreateSection(TabMove, Config.Movement.Fly, "Fly (Полет)", {
    Color = false, Transparency = false, ExpandedHeight = 120,
    CustomSub = function(panel, y)
        local speedLbl = Instance.new("TextLabel")
        speedLbl.Size = UDim2.new(1, 0, 0, 20)
        speedLbl.Position = UDim2.new(0, 0, 0, y)
        speedLbl.BackgroundTransparency = 1
        speedLbl.Text = "Fly Speed: " .. Config.Movement.Fly.Speed
        speedLbl.Font = Enum.Font.Gotham
        speedLbl.TextSize = 12
        speedLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
        speedLbl.TextXAlignment = Enum.TextXAlignment.Left
        speedLbl.Parent = panel
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, 8)
        sliderBg.Position = UDim2.new(0, 0, 0, y + 22)
        sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        sliderBg.Parent = panel
        
        local sFill = Instance.new("Frame")
        sFill.Size = UDim2.new(Config.Movement.Fly.Speed / 150, 0, 1, 0)
        sFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
        sFill.Parent = sliderBg
        
        local sliding = false
        sliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end end)
        UserInputService.InputChanged:Connect(function(input)
            if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0.05, 1)
                sFill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(pos * 150)
                speedLbl.Text = "Fly Speed: " .. val
                Config.Movement.Fly.Speed = val
            end
        end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
        
        local animLbl = Instance.new("TextLabel")
        animLbl.Size = UDim2.new(0.7, 0, 0, 22)
        animLbl.Position = UDim2.new(0, 0, 0, y + 36)
        animLbl.BackgroundTransparency = 1
        animLbl.Text = "Batman Fly Animation"
        animLbl.Font = Enum.Font.GothamMedium
        animLbl.TextSize = 12
        animLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        animLbl.TextXAlignment = Enum.TextXAlignment.Left
        animLbl.Parent = panel
        
        local animBtn = Instance.new("TextButton")
        animBtn.Size = UDim2.new(0, 36, 0, 18)
        animBtn.Position = UDim2.new(1, -36, 0, y + 38)
        animBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        animBtn.Text = ""
        animBtn.Parent = panel
        
        local ac = Instance.new("UICorner") ac.CornerRadius = UDim.new(1, 0) ac.Parent = animBtn
        local ad = Instance.new("Frame") ad.Size = UDim2.new(0, 12, 0, 12) ad.Position = UDim2.new(0, 3, 0.5, -6) ad.BackgroundColor3 = Color3.fromRGB(150, 150, 150) ad.Parent = animBtn
        local adc = Instance.new("UICorner") adc.CornerRadius = UDim.new(1, 0) adc.Parent = ad
        
        animBtn.MouseButton1Click:Connect(function()
            Config.Movement.Fly.BatmanAnim = not Config.Movement.Fly.BatmanAnim
            local st = Config.Movement.Fly.BatmanAnim
            TweenService:Create(animBtn, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(ad, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = st and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)}):Play()
        end)
    end
})

CreateSection(TabMove, Config.Movement.Spin, "Spin (Вращение)", {
    Color = false, Transparency = false, ExpandedHeight = 90,
    CustomSub = function(panel, y)
        local spinLbl = Instance.new("TextLabel")
        spinLbl.Size = UDim2.new(1, 0, 0, 20)
        spinLbl.Position = UDim2.new(0, 0, 0, y)
        spinLbl.BackgroundTransparency = 1
        spinLbl.Text = "Spin Speed: " .. Config.Movement.Spin.Speed
        spinLbl.Font = Enum.Font.Gotham
        spinLbl.TextSize = 12
        spinLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
        spinLbl.TextXAlignment = Enum.TextXAlignment.Left
        spinLbl.Parent = panel
        
        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, 0, 0, 8)
        sliderBg.Position = UDim2.new(0, 0, 0, y + 22)
        sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        sliderBg.Parent = panel
        
        local sFill = Instance.new("Frame")
        sFill.Size = UDim2.new(Config.Movement.Spin.Speed / 100, 0, 1, 0)
        sFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
        sFill.Parent = sliderBg
        
        local sliding = false
        sliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end end)
        UserInputService.InputChanged:Connect(function(input)
            if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0.05, 1)
                sFill.Size = UDim2.new(pos, 0, 1, 0)
                local val = math.floor(pos * 100)
                spinLbl.Text = "Spin Speed: " .. val
                Config.Movement.Spin.Speed = val
            end
        end)
        UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
    end
})

CreateSection(TabMove, Config.Movement.Noclip, "Noclip (Сквозь стены)", {Color = false, Transparency = false, ExpandedHeight = 40})

-- ==========================================
-- TUNG TUNG SAHUR MODEL & EFFECTS ARCHITECTURE
-- ==========================================
local function GetPlayerRole(plr)
    if not plr or not plr.Character then return "Innocent" end
    local backpack = plr:FindFirstChild("Backpack")
    local char = plr.Character
    local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))
    local hasGun = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")))
    if hasKnife then return "Murder" end
    if hasGun then return "Sheriff" end
    return "Innocent"
end

local function GetDroppedGun()
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj.Name == "GunDrop" or (obj:IsA("Tool") and obj.Name == "Gun") then return obj end
    end
    return nil
end

-- Create Spiral Aura
local auraBars = {}
for i = 1, 6 do
    local bar = Instance.new("Part")
    bar.Size = Vector3.new(0.2, 1.8, 0.2)
    bar.CanCollide = false
    bar.Anchored = true
    bar.Material = Enum.Material.Neon
    bar.Transparency = 1
    bar.Parent = FXContainer
    table.insert(auraBars, bar)
end

-- Create 3D Angel Wings Parts
local wing3DFeathers = {}
for side = -1, 1, 2 do
    for layer = 1, 4 do
        for i = 1, 5 do
            local feather = Instance.new("Part")
            feather.CanCollide = false
            feather.Anchored = true
            feather.Material = Enum.Material.SmoothPlastic
            feather.Transparency = 1
            feather.Parent = FXContainer
            
            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.Wedge
            local len = (layer == 1 and 0.9) or (layer == 2 and 1.6) or (layer == 3 and 2.4) or (3.2 + (i * 0.35))
            mesh.Scale = Vector3.new(0.12, len, 0.35)
            mesh.Parent = feather
            
            table.insert(wing3DFeathers, {
                Part = feather,
                Side = side,
                Layer = layer,
                Index = i
            })
        end
    end
end

-- Create Custom Tung Tung Sahur Model
local tungModel = Instance.new("Model")
tungModel.Name = "TungTungSahurModel"

local woodColor = Color3.fromRGB(180, 115, 60)

-- Main Wooden Pillar Body
local tungBody = Instance.new("Part")
tungBody.Size = Vector3.new(1.6, 4.2, 1.2)
tungBody.Color = woodColor
tungBody.Material = Enum.Material.Wood
tungBody.CanCollide = false
tungBody.Anchored = true
tungBody.Parent = tungModel

local bodyMesh = Instance.new("SpecialMesh")
bodyMesh.MeshType = Enum.MeshType.Cylinder
bodyMesh.Scale = Vector3.new(1, 1, 1)
bodyMesh.Parent = tungBody

-- Head Cap
local tungHead = Instance.new("Part")
tungHead.Size = Vector3.new(1.6, 0.6, 1.2)
tungHead.Color = Color3.fromRGB(150, 90, 45)
tungHead.Material = Enum.Material.Wood
tungHead.CanCollide = false
tungHead.Anchored = true
tungHead.Parent = tungModel

-- Eyes
local eyeL = Instance.new("Part")
eyeL.Size = Vector3.new(0.4, 0.4, 0.1)
eyeL.Color = Color3.fromRGB(255, 255, 255)
eyeL.Material = Enum.Material.SmoothPlastic
eyeL.CanCollide = false eyeL.Anchored = true eyeL.Parent = tungModel

local pupilL = Instance.new("Part")
pupilL.Size = Vector3.new(0.2, 0.2, 0.12)
pupilL.Color = Color3.fromRGB(10, 10, 10)
pupilL.Material = Enum.Material.SmoothPlastic
pupilL.CanCollide = false pupilL.Anchored = true pupilL.Parent = tungModel

local eyeR = eyeL:Clone() eyeR.Parent = tungModel
local pupilR = pupilL:Clone() pupilR.Parent = tungModel

-- Legs
local legL = Instance.new("Part")
legL.Size = Vector3.new(0.35, 1.8, 0.35)
legL.Color = woodColor
legL.Material = Enum.Material.Wood
legL.CanCollide = false legL.Anchored = true legL.Parent = tungModel

local legR = legL:Clone() legR.Parent = tungModel

-- Bat Tool
local batPart = Instance.new("Part")
batPart.Size = Vector3.new(0.3, 3.2, 0.3)
batPart.Color = Color3.fromRGB(140, 80, 40)
batPart.Material = Enum.Material.Wood
batPart.CanCollide = false batPart.Anchored = true batPart.Parent = tungModel

tungModel.Parent = FXContainer

-- Helper for transparency
local function SetCharTransparency(char, trans)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("Decal") then
            if v.Name ~= "HumanoidRootPart" then
                v.Transparency = trans
            end
        elseif v:IsA("Accessory") and v:FindFirstChild("Handle") then
            v.Handle.Transparency = trans
        end
    end
end

-- ==========================================
-- MAIN ENGINE LOOP
-- ==========================================
local auraAngle = 0
local wingFlap = 0

local bodyVel = Instance.new("BodyVelocity") bodyVel.MaxForce = Vector3.new(0, 0, 0)
local bodyGyro = Instance.new("BodyGyro") bodyGyro.MaxTorque = Vector3.new(0, 0, 0)

RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    
    -- 1. Fly System
    if Config.Movement.Fly.Enabled and hrp and hum then
        bodyVel.Parent = hrp
        bodyGyro.Parent = hrp
        bodyVel.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
        
        bodyVel.Velocity = moveDir * Config.Movement.Fly.Speed
        bodyGyro.CFrame = Camera.CFrame
        hum.PlatformStand = Config.Movement.Fly.BatmanAnim
    else
        bodyVel.MaxForce = Vector3.new(0, 0, 0)
        bodyGyro.MaxTorque = Vector3.new(0, 0, 0)
        if hum and not Config.Movement.Fly.Enabled and not Config.TungTung.Enabled then hum.PlatformStand = false end
    end
    
    -- 2. Tung Tung Sahur Avatar & Animation Override
    if Config.TungTung.Enabled and hrp and char then
        SetCharTransparency(char, 1) -- Скрываем Roblox аватар
        if hum then hum.PlatformStand = true end -- Отключаем анимацию ходьбы/прыжка
        
        -- Позиционирование Tung Tung Sahur
        local cf = hrp.CFrame
        tungBody.CFrame = cf * CFrame.new(0, 0.4, 0) * CFrame.Angles(0, math.rad(90), 0)
        tungHead.CFrame = cf * CFrame.new(0, 2.4, 0) * CFrame.Angles(0, math.rad(90), 0)
        
        eyeL.CFrame = cf * CFrame.new(-0.35, 1.5, -0.6)
        pupilL.CFrame = cf * CFrame.new(-0.35, 1.5, -0.65)
        eyeR.CFrame = cf * CFrame.new(0.35, 1.5, -0.6)
        pupilR.CFrame = cf * CFrame.new(0.35, 1.5, -0.65)
        
        legL.CFrame = cf * CFrame.new(-0.4, -1.8, 0)
        legR.CFrame = cf * CFrame.new(0.4, -1.8, 0)
        
        batPart.CFrame = cf * CFrame.new(0.9, -0.6, -0.4) * CFrame.Angles(math.rad(25), 0, math.rad(-15))
    else
        if char then SetCharTransparency(char, 0) end
        tungBody.CFrame = CFrame.new(0, -999, 0)
        tungHead.CFrame = CFrame.new(0, -999, 0)
        eyeL.CFrame = CFrame.new(0, -999, 0)
        pupilL.CFrame = CFrame.new(0, -999, 0)
        eyeR.CFrame = CFrame.new(0, -999, 0)
        pupilR.CFrame = CFrame.new(0, -999, 0)
        legL.CFrame = CFrame.new(0, -999, 0)
        legR.CFrame = CFrame.new(0, -999, 0)
        batPart.CFrame = CFrame.new(0, -999, 0)
    end
    
    -- 3. Spiral Aura
    local cfgA = Config.Aura
    if cfgA.Enabled and hrp then
        auraAngle = auraAngle + 0.05
        for i, bar in ipairs(auraBars) do
            local offset = auraAngle + (i * (math.pi / 3))
            local radius = 3.2
            local x = math.cos(offset) * radius
            local z = math.sin(offset) * radius
            local y = math.sin(auraAngle * 2 + i) * 1.5
            bar.CFrame = CFrame.new(hrp.Position + Vector3.new(x, y, z)) * CFrame.Angles(offset, offset * 0.5, 0)
            bar.Color = cfgA.Color
            bar.Transparency = 1 - cfgA.Transparency
        end
    else
        for _, bar in ipairs(auraBars) do bar.Transparency = 1 end
    end
    
    -- 4. Angel Wings
    local cfgW = Config.Angel
    if cfgW.Enabled and hrp then
        local isMoving = (hum and hum.MoveDirection.Magnitude > 0) or Config.Movement.Fly.Enabled
        wingFlap = wingFlap + (isMoving and 0.05 or 0.025)
        local flapRad = math.sin(wingFlap) * (isMoving and 0.25 or 0.1)
        
        for _, fData in ipairs(wing3DFeathers) do
            local p = fData.Part
            local side = fData.Side
            local layer = fData.Layer
            local i = fData.Index
            
            local archX = side * (0.5 + (i * 0.42) + (layer * 0.12))
            local archY = 0.6 + (i * 0.38) - (layer * 0.35) + flapRad
            local archZ = 0.6 + (layer * 0.18) + (i * 0.08)
            
            local rotX = math.rad(-20 + (i * 6))
            local rotY = side * (math.rad(35 + i * 10) + (flapRad * 20))
            local rotZ = side * (math.rad(-45 - i * 8) + (flapRad * 12))
            
            local targetCF = hrp.CFrame * CFrame.new(archX, archY, archZ) * CFrame.Angles(rotX, rotY, rotZ)
            p.CFrame = p.CFrame:Lerp(targetCF, 0.25)
            p.Color = cfgW.Color
            p.Transparency = 1 - cfgW.Transparency
        end
    else
        for _, fData in ipairs(wing3DFeathers) do fData.Part.Transparency = 1 end
    end
    
    -- 5. Spin
    if Config.Movement.Spin.Enabled and hrp then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(Config.Movement.Spin.Speed), 0)
    end
    
    -- 6. Noclip
    if Config.Movement.Noclip.Enabled and char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    
    -- 7. Clean Canvas ESP
    DrawingCanvas:ClearAllChildren()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetPlayerRole(plr)
            local p_hrp = plr.Character.HumanoidRootPart
            local p_head = plr.Character:FindFirstChild("Head") or p_hrp
            local pos, onScreen = Camera:WorldToViewportPoint(p_hrp.Position)
            
            if onScreen then
                local cfgT = Config.Tracers[role]
                if cfgT and cfgT.Enabled and cfgT.Transparency > 0 then
                    local line = Instance.new("Frame")
                    line.BorderSizePixel = 0
                    line.BackgroundColor3 = cfgT.Color
                    line.BackgroundTransparency = 1 - cfgT.Transparency
                    local startPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local endPos = Vector2.new(pos.X, pos.Y)
                    local distance = (endPos - startPos).Magnitude
                    local angle = math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)
                    line.Size = UDim2.new(0, distance, 0, 1.2)
                    line.Position = UDim2.new(0, startPos.X, 0, startPos.Y)
                    line.Rotation = math.deg(angle)
                    line.AnchorPoint = Vector2.new(0, 0.5)
                    line.Parent = DrawingCanvas
                end
                
                local cfgB = Config.Boxes[role]
                if cfgB and cfgB.Enabled and cfgB.Transparency > 0 then
                    local headPos = Camera:WorldToViewportPoint(p_head.Position + Vector3.new(0, 0.8, 0))
                    local legPos = Camera:WorldToViewportPoint(p_hrp.Position - Vector3.new(0, 3, 0))
                    local height = math.abs(headPos.Y - legPos.Y)
                    local width = height / 1.6
                    
                    local box = Instance.new("Frame")
                    box.Size = UDim2.new(0, width, 0, height)
                    box.Position = UDim2.new(0, pos.X - width / 2, 0, pos.Y - height / 2)
                    box.BackgroundTransparency = 1
                    box.Parent = DrawingCanvas
                    
                    local stroke = Instance.new("UIStroke")
                    stroke.Color = cfgB.Color
                    stroke.Transparency = 1 - cfgB.Transparency
                    stroke.Thickness = 1.2
                    stroke.Parent = box
                end
            end
        end
    end
end)

-- Throttle Loop for Outlines & Gun Alerts (10 times/sec)
local gunWasOnMap = false
task.spawn(function()
    while task.wait(0.1) do
        if not ScreenGui.Parent then break end
        
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(plr)
                local cfgO = Config.Outlines[role]
                local hl = plr.Character:FindFirstChild("QuatroESP")
                if cfgO and cfgO.Enabled and cfgO.Transparency > 0 then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "QuatroESP"
                        hl.Parent = plr.Character
                    end
                    hl.Adornee = plr.Character
                    hl.FillTransparency = 1
                    hl.OutlineColor = cfgO.Color
                    hl.OutlineTransparency = 1 - cfgO.Transparency
                else
                    if hl then hl:Destroy() end
                end
            end
        end
        
        local droppedGun = GetDroppedGun()
        if droppedGun then
            if not gunWasOnMap then
                gunWasOnMap = true
                if Config.Outlines.Gun.AlertEnabled then ShowGunAlert() end
            end
            local cfgG = Config.Outlines.Gun
            local hlG = droppedGun:FindFirstChild("QuatroGunESP")
            if cfgG.Enabled and cfgG.Transparency > 0 then
                if not hlG then
                    hlG = Instance.new("Highlight")
                    hlG.Name = "QuatroGunESP"
                    hlG.Parent = droppedGun
                end
                hlG.Adornee = droppedGun
                hlG.FillTransparency = 1
                hlG.OutlineColor = cfgG.Color
                hlG.OutlineTransparency = 1 - cfgG.Transparency
            else
                if hlG then hlG:Destroy() end
            end
        else
            gunWasOnMap = false
        end
    end
end)

-- Keybind Minimize (LeftControl)
local minimized = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
        minimized = not minimized
        MainFrame.Visible = not minimized
    end
end)
