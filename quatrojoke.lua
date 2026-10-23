-- [[ quatrojoke Script | Visuals Deluxe Edition (Tracers, Boxes, Aura) ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Защита от повторного запуска
if CoreGui:FindFirstChild("QuatrojokeUI") then
    CoreGui:FindFirstChild("QuatrojokeUI"):Destroy()
end

-- ==========================================
-- SCREEN GUI & CONTAINERS
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuatrojokeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Canvas for Tracers & Boxes
local DrawingCanvas = Instance.new("Frame")
DrawingCanvas.Name = "DrawingCanvas"
DrawingCanvas.Size = UDim2.new(1, 0, 1, 0)
DrawingCanvas.BackgroundTransparency = 1
DrawingCanvas.Parent = ScreenGui

-- ==========================================
-- MAIN GUI FRAME
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 420)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 30, 60)
MainStroke.Thickness = 2
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

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

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

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

-- Sidebar (Left)
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 140, 1, -40)
SideBar.Position = UDim2.new(0, 0, 0, 40)
SideBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideList = Instance.new("UIListLayout")
SideList.Padding = UDim.new(0, 5)
SideList.SortOrder = Enum.SortOrder.LayoutOrder
SideList.Parent = SideBar

local SidePadding = Instance.new("UIPadding")
SidePadding.PaddingTop = UDim.new(0, 8)
SidePadding.PaddingLeft = UDim.new(0, 8)
SidePadding.PaddingRight = UDim.new(0, 8)
SidePadding.Parent = SideBar

-- Content Area (Right)
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -140, 1, -40)
ContentArea.Position = UDim2.new(0, 140, 0, 40)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- ==========================================
-- INTRO FRAME
-- ==========================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(0, 560, 0, 420)
IntroFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
IntroFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IntroFrame.BackgroundTransparency = 0.05
IntroFrame.ClipsDescendants = true
IntroFrame.Parent = ScreenGui

local IntroCorner = Instance.new("UICorner")
IntroCorner.CornerRadius = UDim.new(0, 10)
IntroCorner.Parent = IntroFrame

local IntroStroke = Instance.new("UIStroke")
IntroStroke.Color = Color3.fromRGB(255, 30, 60)
IntroStroke.Thickness = 2
IntroStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
IntroStroke.Parent = IntroFrame

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

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = BarBg

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(1, 0)
FillCorner.Parent = BarFill

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
local statuses = {"Загрузка Visuals...", "Настройка Tracers & Boxes...", "Подготовка эффекта Aura...", "Оптимизация кадров...", "Запуск quatrojoke..."}

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

local AlertCorner = Instance.new("UICorner")
AlertCorner.CornerRadius = UDim.new(0, 8)
AlertCorner.Parent = GunAlertFrame

local AlertStroke = Instance.new("UIStroke")
AlertStroke.Color = Color3.fromRGB(255, 200, 0)
AlertStroke.Thickness = 2
AlertStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
AlertStroke.Parent = GunAlertFrame

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
-- FULL CONFIG DATA
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
    Aura = { Enabled = false, Color = Color3.fromRGB(180, 0, 255), Transparency = 0.5, Neon = false }
}

-- Tab Button
local TabBtn = Instance.new("TextButton")
TabBtn.Size = UDim2.new(1, 0, 0, 36)
TabBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 30)
TabBtn.Text = "Visuals / ESP"
TabBtn.Font = Enum.Font.GothamBold
TabBtn.TextSize = 13
TabBtn.TextColor3 = Color3.fromRGB(255, 30, 60)
TabBtn.Parent = SideBar

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabBtn

-- Scroll Content Frame
local TabContent = Instance.new("ScrollingFrame")
TabContent.Size = UDim2.new(1, -16, 1, -16)
TabContent.Position = UDim2.new(0, 8, 0, 8)
TabContent.BackgroundTransparency = 1
TabContent.ScrollBarThickness = 4
TabContent.ScrollBarImageColor3 = Color3.fromRGB(255, 30, 60)
TabContent.Parent = ContentArea

local ContentList = Instance.new("UIListLayout")
ContentList.Padding = UDim.new(0, 8)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Parent = TabContent

ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 15)
end)

local PaletteColors = {
    Color3.fromRGB(255, 30, 60),
    Color3.fromRGB(0, 255, 120),
    Color3.fromRGB(0, 140, 255),
    Color3.fromRGB(255, 200, 0),
    Color3.fromRGB(180, 0, 255),
    Color3.fromRGB(255, 255, 255)
}

-- UI Builder Helper
local function CreateSubSection(cfgRef, titleText, isGun, isAura)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Size = UDim2.new(1, -8, 0, 38)
    sectionFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    sectionFrame.ClipsDescendants = true
    sectionFrame.Parent = TabContent
    
    local secCorner = Instance.new("UICorner")
    secCorner.CornerRadius = UDim.new(0, 6)
    secCorner.Parent = sectionFrame
    
    local secStroke = Instance.new("UIStroke")
    secStroke.Color = Color3.fromRGB(45, 45, 55)
    secStroke.Thickness = 1
    secStroke.Parent = sectionFrame
    
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
    
    local togCorner = Instance.new("UICorner")
    togCorner.CornerRadius = UDim.new(1, 0)
    togCorner.Parent = toggleBtn
    
    local togDot = Instance.new("Frame")
    togDot.Size = UDim2.new(0, 16, 0, 16)
    togDot.Position = UDim2.new(0, 3, 0.5, -8)
    togDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
    togDot.Parent = toggleBtn
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = togDot
    
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
    subPanel.Size = UDim2.new(1, -20, 0, isGun and 145 or (isAura and 145 or 110))
    subPanel.Position = UDim2.new(0, 10, 0, 42)
    subPanel.BackgroundTransparency = 1
    subPanel.Parent = sectionFrame
    
    local colorLbl = Instance.new("TextLabel")
    colorLbl.Size = UDim2.new(1, 0, 0, 20)
    colorLbl.BackgroundTransparency = 1
    colorLbl.Text = "Color (Палитра):"
    colorLbl.Font = Enum.Font.Gotham
    colorLbl.TextSize = 12
    colorLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
    colorLbl.TextXAlignment = Enum.TextXAlignment.Left
    colorLbl.Parent = subPanel
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Size = UDim2.new(0, 22, 0, 22)
    colorPreview.Position = UDim2.new(1, -22, 0, 0)
    colorPreview.BackgroundColor3 = cfgRef.Color
    colorPreview.Parent = subPanel
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 4)
    prevCorner.Parent = colorPreview
    
    local paletteFrame = Instance.new("Frame")
    paletteFrame.Size = UDim2.new(1, 0, 0, 26)
    paletteFrame.Position = UDim2.new(0, 0, 0, 24)
    paletteFrame.BackgroundTransparency = 1
    paletteFrame.Parent = subPanel
    
    local palLayout = Instance.new("UIListLayout")
    palLayout.FillDirection = Enum.FillDirection.Horizontal
    palLayout.Padding = UDim.new(0, 6)
    palLayout.Parent = paletteFrame
    
    for _, col in ipairs(PaletteColors) do
        local pBtn = Instance.new("TextButton")
        pBtn.Size = UDim2.new(0, 24, 0, 24)
        pBtn.BackgroundColor3 = col
        pBtn.Text = ""
        pBtn.Parent = paletteFrame
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 4)
        pCorner.Parent = pBtn
        
        pBtn.MouseButton1Click:Connect(function()
            cfgRef.Color = col
            colorPreview.BackgroundColor3 = col
        end)
    end
    
    local transLbl = Instance.new("TextLabel")
    transLbl.Size = UDim2.new(1, 0, 0, 20)
    transLbl.Position = UDim2.new(0, 0, 0, 56)
    transLbl.BackgroundTransparency = 1
    transLbl.Text = "Transparency: " .. math.floor(cfgRef.Transparency * 100) .. "%"
    transLbl.Font = Enum.Font.Gotham
    transLbl.TextSize = 12
    transLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
    transLbl.TextXAlignment = Enum.TextXAlignment.Left
    transLbl.Parent = subPanel
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, 0, 0, 8)
    sliderBg.Position = UDim2.new(0, 0, 0, 80)
    sliderBg.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    sliderBg.Parent = subPanel
    
    local sBgCorner = Instance.new("UICorner")
    sBgCorner.CornerRadius = UDim.new(1, 0)
    sBgCorner.Parent = sliderBg
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(cfgRef.Transparency, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(255, 30, 60)
    sliderFill.Parent = sliderBg
    
    local sFillCorner = Instance.new("UICorner")
    sFillCorner.CornerRadius = UDim.new(1, 0)
    sFillCorner.Parent = sliderFill
    
    local sliding = false
    local function UpdateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local percent = math.floor(pos * 100)
        transLbl.Text = "Transparency: " .. percent .. "%"
        cfgRef.Transparency = pos
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true UpdateSlider(input) end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then UpdateSlider(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
    end)
    
    if isGun then
        local alertLbl = Instance.new("TextLabel")
        alertLbl.Size = UDim2.new(0.7, 0, 0, 22)
        alertLbl.Position = UDim2.new(0, 0, 0, 108)
        alertLbl.BackgroundTransparency = 1
        alertLbl.Text = "Сообщать что упал пистолет"
        alertLbl.Font = Enum.Font.GothamMedium
        alertLbl.TextSize = 12
        alertLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        alertLbl.TextXAlignment = Enum.TextXAlignment.Left
        alertLbl.Parent = subPanel
        
        local alertBtn = Instance.new("TextButton")
        alertBtn.Size = UDim2.new(0, 36, 0, 18)
        alertBtn.Position = UDim2.new(1, -36, 0, 110)
        alertBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        alertBtn.Text = ""
        alertBtn.Parent = subPanel
        
        local aCorner = Instance.new("UICorner")
        aCorner.CornerRadius = UDim.new(1, 0)
        aCorner.Parent = alertBtn
        
        local aDot = Instance.new("Frame")
        aDot.Size = UDim2.new(0, 12, 0, 12)
        aDot.Position = UDim2.new(0, 3, 0.5, -6)
        aDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        aDot.Parent = alertBtn
        
        local adCorner = Instance.new("UICorner")
        adCorner.CornerRadius = UDim.new(1, 0)
        adCorner.Parent = aDot
        
        alertBtn.MouseButton1Click:Connect(function()
            cfgRef.AlertEnabled = not cfgRef.AlertEnabled
            local st = cfgRef.AlertEnabled
            TweenService:Create(alertBtn, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(aDot, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = st and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(150, 150, 150)}):Play()
        end)
    elseif isAura then
        local neonLbl = Instance.new("TextLabel")
        neonLbl.Size = UDim2.new(0.7, 0, 0, 22)
        neonLbl.Position = UDim2.new(0, 0, 0, 108)
        neonLbl.BackgroundTransparency = 1
        neonLbl.Text = "Neon Glow (Неоновый блеск)"
        neonLbl.Font = Enum.Font.GothamMedium
        neonLbl.TextSize = 12
        neonLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        neonLbl.TextXAlignment = Enum.TextXAlignment.Left
        neonLbl.Parent = subPanel
        
        local neonBtn = Instance.new("TextButton")
        neonBtn.Size = UDim2.new(0, 36, 0, 18)
        neonBtn.Position = UDim2.new(1, -36, 0, 110)
        neonBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        neonBtn.Text = ""
        neonBtn.Parent = subPanel
        
        local nCorner = Instance.new("UICorner")
        nCorner.CornerRadius = UDim.new(1, 0)
        nCorner.Parent = neonBtn
        
        local nDot = Instance.new("Frame")
        nDot.Size = UDim2.new(0, 12, 0, 12)
        nDot.Position = UDim2.new(0, 3, 0.5, -6)
        nDot.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        nDot.Parent = neonBtn
        
        local ndCorner = Instance.new("UICorner")
        ndCorner.CornerRadius = UDim.new(1, 0)
        ndCorner.Parent = nDot
        
        neonBtn.MouseButton1Click:Connect(function()
            cfgRef.Neon = not cfgRef.Neon
            local st = cfgRef.Neon
            TweenService:Create(neonBtn, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(nDot, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = st and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)}):Play()
        end)
    end
    
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
        local targetHeight = expanded and ((isGun or isAura) and 195 or 160) or 38
        TweenService:Create(sectionFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, -8, 0, targetHeight)}):Play()
    end)
end

-- Category Titles
local function CreateHeader(text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = "--- " .. text .. " ---"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 12
    lbl.TextColor3 = Color3.fromRGB(255, 30, 60)
    lbl.Parent = TabContent
end

-- Create Sections
CreateHeader("OUTLINES")
CreateSubSection(Config.Outlines.Innocent, "Outline Innocent", false, false)
CreateSubSection(Config.Outlines.Sheriff, "ESP Sheriff", false, false)
CreateSubSection(Config.Outlines.Murder, "ESP Murder", false, false)
CreateSubSection(Config.Outlines.Gun, "ESP Gun", true, false)

CreateHeader("TRACERS")
CreateSubSection(Config.Tracers.Innocent, "Tracer Innocent", false, false)
CreateSubSection(Config.Tracers.Sheriff, "Tracer Sheriff", false, false)
CreateSubSection(Config.Tracers.Murder, "Tracer Murder", false, false)

CreateHeader("BOXES")
CreateSubSection(Config.Boxes.Innocent, "Box Innocent", false, false)
CreateSubSection(Config.Boxes.Sheriff, "Box Sheriff", false, false)
CreateSubSection(Config.Boxes.Murder, "Box Murder", false, false)

CreateHeader("EFFECTS")
CreateSubSection(Config.Aura, "Player Aura Effect", false, true)

-- ==========================================
-- LOGIC & VISUAL RENDER LOOPS
-- ==========================================
local function GetPlayerRole(plr)
    if not plr or not plr.Character then return "Innocent" end
    local backpack = plr:FindFirstChild("Backpack")
    local char = plr.Character
    
    local hasKnife = (backpack and backpack:FindFirstChild("Knife")) or (char and char:FindFirstChild("Knife"))
    local hasGun = (backpack and (backpack:FindFirstChild("Gun") or backpack:FindFirstChild("Revolver"))) or 
                   (char and (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")))
                   
    if hasKnife then return "Murder" end
    if hasGun then return "Sheriff" end
    return "Innocent"
end

local function GetDroppedGun()
    for _, obj in pairs(workspace:GetChildren()) do
        if obj.Name == "GunDrop" or (obj:IsA("Tool") and obj.Name == "Gun") then
            return obj
        end
    end
    return nil
end

local TracerGUIElements = {}
local BoxGUIElements = {}

-- Clean GUI Elements
local function ClearDrawings()
    DrawingCanvas:ClearAllChildren()
    TracerGUIElements = {}
    BoxGUIElements = {}
end

-- Throttle Loop (Outlines, Gun Alert & Aura) - 10 times/sec
local gunWasOnMap = false
task.spawn(function()
    while task.wait(0.1) do
        if not ScreenGui.Parent then break end
        
        -- Outlines & Aura
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(plr)
                
                -- Outlines
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
                
                -- Aura Effect
                local cfgA = Config.Aura
                local auraP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("QuatroAura")
                if cfgA.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if not auraP then
                        local part = Instance.new("Part")
                        part.Name = "QuatroAura"
                        part.Shape = Enum.PartType.Ball
                        part.Size = Vector3.new(8, 8, 8)
                        part.CanCollide = false
                        part.Anchored = false
                        part.Material = cfgA.Neon and Enum.Material.Neon or Enum.Material.SmoothPlastic
                        
                        local weld = Instance.new("Weld")
                        weld.Part0 = LocalPlayer.Character.HumanoidRootPart
                        weld.Part1 = part
                        weld.Parent = part
                        
                        part.Parent = LocalPlayer.Character
                        auraP = part
                    end
                    auraP.Color = cfgA.Color
                    auraP.Transparency = 1 - cfgA.Transparency
                    auraP.Material = cfgA.Neon and Enum.Material.Neon or Enum.Material.SmoothPlastic
                else
                    if auraP then auraP:Destroy() end
                end
            end
        end
        
        -- Gun ESP & Alert
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

-- RenderStepped for Tracers & Boxes (Smooth Drawing)
RunService.RenderStepped:Connect(function()
    ClearDrawings()
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetPlayerRole(plr)
            local hrp = plr.Character.HumanoidRootPart
            local head = plr.Character:FindFirstChild("Head") or hrp
            
            local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            
            if onScreen then
                -- Tracers
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
                    
                    line.Size = UDim2.new(0, distance, 0, 1.5)
                    line.Position = UDim2.new(0, startPos.X, 0, startPos.Y)
                    line.Rotation = math.deg(angle)
                    line.AnchorPoint = Vector2.new(0, 0.5)
                    line.Parent = DrawingCanvas
                end
                
                -- Boxes
                local cfgB = Config.Boxes[role]
                if cfgB and cfgB.Enabled and cfgB.Transparency > 0 then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.8, 0))
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    
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
                    stroke.Thickness = 1.5
                    stroke.Parent = box
                end
            end
        end
    end
end)

-- Minimize Keybind (LeftControl)
local minimized = false
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
        minimized = not minimized
        MainFrame.Visible = not minimized
    end
end)
