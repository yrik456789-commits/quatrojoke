-- [[ quatrojoke Script | Fixed Intro Flow + Gun ESP + Dropped Gun Alert ]] --

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Защита от повторного запуска
if CoreGui:FindFirstChild("QuatrojokeUI") then
    CoreGui:FindFirstChild("QuatrojokeUI"):Destroy()
end

-- ==========================================
-- SCREEN GUI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuatrojokeUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- ==========================================
-- MAIN GUI FRAME (Hidden initially)
-- ==========================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 420)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 1 -- Скрыто до конца интро
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
MainStroke.Transparency = 1
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
TopBar.BackgroundTransparency = 1
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
TitleLabel.TextTransparency = 1
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 20, 25)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextColor3 = Color3.fromRGB(255, 60, 80)
CloseBtn.TextTransparency = 1
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
SideBar.BackgroundTransparency = 1
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
-- INTRO SYSTEM (GUI appears strictly AFTER intro)
-- ==========================================
local IntroFrame = Instance.new("Frame")
IntroFrame.Name = "IntroFrame"
IntroFrame.Size = UDim2.new(1, 0, 1, 0)
IntroFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
IntroFrame.Parent = ScreenGui

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Size = UDim2.new(0, 500, 0, 80)
IntroTitle.Position = UDim2.new(0.5, -250, 0.4, -40)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "quatrojoke"
IntroTitle.Font = Enum.Font.FredokaOne
IntroTitle.TextSize = 65
IntroTitle.TextColor3 = Color3.fromRGB(255, 30, 60)
IntroTitle.TextStrokeTransparency = 0.2
IntroTitle.TextStrokeColor3 = Color3.fromRGB(150, 0, 30)
IntroTitle.Parent = IntroFrame

local IntroSub = Instance.new("TextLabel")
IntroSub.Size = UDim2.new(0, 400, 0, 30)
IntroSub.Position = UDim2.new(0.5, -200, 0.4, 45)
IntroSub.BackgroundTransparency = 1
IntroSub.Text = "Murder Mystery 2 Edition"
IntroSub.Font = Enum.Font.GothamMedium
IntroSub.TextSize = 18
IntroSub.TextColor3 = Color3.fromRGB(200, 200, 200)
IntroSub.Parent = IntroFrame

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 350, 0, 8)
BarBg.Position = UDim2.new(0.5, -175, 0.55, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
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
StatusLabel.Size = UDim2.new(0, 350, 0, 25)
StatusLabel.Position = UDim2.new(0.5, -175, 0.55, 12)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Инициализация..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
StatusLabel.Parent = IntroFrame

math.randomseed(os.time())
local loadTime = math.random(4, 14)
local statuses = {"Загрузка ресурсов...", "Настройка вкладок...", "Загрузка красного неона...", "Проверка Gun ESP...", "Запуск quatrojoke..."}

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
    task.wait(0.4)
    
    local fadeTween = TweenService:Create(IntroFrame, TweenInfo.new(0.6), {BackgroundTransparency = 1})
    TweenService:Create(IntroTitle, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    TweenService:Create(IntroSub, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    TweenService:Create(BarBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(BarFill, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    TweenService:Create(StatusLabel, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    
    fadeTween:Play()
    fadeTween.Completed:Connect(function()
        IntroFrame:Destroy()
        
        -- Показываем главное окно GUI только сейчас!
        MainFrame.Visible = true
        TweenService:Create(MainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(MainStroke, TweenInfo.new(0.4), {Transparency = 0}):Play()
        TweenService:Create(TopBar, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
        TweenService:Create(SideBar, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
        TweenService:Create(TitleLabel, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
        TweenService:Create(CloseBtn, TweenInfo.new(0.4), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    end)
end)

-- ==========================================
-- DROPPED GUN NOTIFICATION (BOTTOM RIGHT)
-- ==========================================
local GunAlertFrame = Instance.new("Frame")
GunAlertFrame.Name = "GunAlertFrame"
GunAlertFrame.Size = UDim2.new(0, 240, 0, 45)
GunAlertFrame.Position = UDim2.new(1, 20, 1, -60) -- Позади экрана справа
GunAlertFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
GunAlertFrame.BorderSizePixel = 0
GunAlertFrame.Parent = ScreenGui

local AlertCorner = Instance.new("UICorner")
AlertCorner.CornerRadius = UDim.new(0, 8)
AlertCorner.Parent = GunAlertFrame

local AlertStroke = Instance.new("UIStroke")
AlertStroke.Color = Color3.fromRGB(255, 200, 0) -- Ярко-желтый неон
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
    
    -- Плавный выезд справа
    GunAlertFrame:TweenPosition(UDim2.new(1, -250, 1, -60), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
    
    task.delay(4, function()
        -- Плавный заезд обратно
        GunAlertFrame:TweenPosition(UDim2.new(1, 20, 1, -60), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.5, true, function()
            alertActive = false
        end)
    end)
end

-- ==========================================
-- ESP CONFIG DATA
-- ==========================================
local ESP_Settings = {
    Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
    Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
    Murder   = { Enabled = false, Color = Color3.fromRGB(255, 30, 60), Transparency = 1 },
    Gun      = { Enabled = false, Color = Color3.fromRGB(255, 200, 0), Transparency = 1, AlertEnabled = false }
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
    TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 10)
end)

local PaletteColors = {
    Color3.fromRGB(255, 30, 60),
    Color3.fromRGB(0, 255, 120),
    Color3.fromRGB(0, 140, 255),
    Color3.fromRGB(255, 200, 0),
    Color3.fromRGB(180, 0, 255),
    Color3.fromRGB(255, 255, 255)
}

-- Helper: Create Role & Gun Section with Sub-menu
local function CreateESPSection(roleKey, titleText, isGunSection)
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
    
    -- Main Toggle Bar
    local topToggle = Instance.new("Frame")
    topToggle.Size = UDim2.new(1, 0, 0, 38)
    topToggle.BackgroundTransparency = 1
    topToggle.Parent = sectionFrame
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(0.6, 0, 1, 0)
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
    
    -- Sub-Panel Container
    local subPanel = Instance.new("Frame")
    subPanel.Size = UDim2.new(1, -20, 0, isGunSection and 145 or 110)
    subPanel.Position = UDim2.new(0, 10, 0, 42)
    subPanel.BackgroundTransparency = 1
    subPanel.Parent = sectionFrame
    
    -- Outline Color
    local colorLbl = Instance.new("TextLabel")
    colorLbl.Size = UDim2.new(1, 0, 0, 20)
    colorLbl.BackgroundTransparency = 1
    colorLbl.Text = "Outline Color (Палитра):"
    colorLbl.Font = Enum.Font.Gotham
    colorLbl.TextSize = 12
    colorLbl.TextColor3 = Color3.fromRGB(170, 170, 170)
    colorLbl.TextXAlignment = Enum.TextXAlignment.Left
    colorLbl.Parent = subPanel
    
    local colorPreview = Instance.new("Frame")
    colorPreview.Size = UDim2.new(0, 22, 0, 22)
    colorPreview.Position = UDim2.new(1, -22, 0, 0)
    colorPreview.BackgroundColor3 = ESP_Settings[roleKey].Color
    colorPreview.Parent = subPanel
    
    local prevCorner = Instance.new("UICorner")
    prevCorner.CornerRadius = UDim.new(0, 4)
    prevCorner.Parent = colorPreview
    
    -- Palette
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
            ESP_Settings[roleKey].Color = col
            colorPreview.BackgroundColor3 = col
        end)
    end
    
    -- Transparency Slider
    local transLbl = Instance.new("TextLabel")
    transLbl.Size = UDim2.new(1, 0, 0, 20)
    transLbl.Position = UDim2.new(0, 0, 0, 56)
    transLbl.BackgroundTransparency = 1
    transLbl.Text = "Transparency Outline: 100%"
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
    sliderFill.Size = UDim2.new(1, 0, 1, 0)
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
        transLbl.Text = "Transparency Outline: " .. percent .. "%"
        ESP_Settings[roleKey].Transparency = pos
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
    
    -- Additional Option for Gun: Dropped Alert
    if isGunSection then
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
            ESP_Settings.Gun.AlertEnabled = not ESP_Settings.Gun.AlertEnabled
            local st = ESP_Settings.Gun.AlertEnabled
            TweenService:Create(alertBtn, TweenInfo.new(0.2), {BackgroundColor3 = st and Color3.fromRGB(255, 200, 0) or Color3.fromRGB(40, 40, 50)}):Play()
            TweenService:Create(aDot, TweenInfo.new(0.2), {Position = st and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6), BackgroundColor3 = st and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(150, 150, 150)}):Play()
        end)
    end
    
    -- Main Toggle Action
    toggleBtn.MouseButton1Click:Connect(function()
        ESP_Settings[roleKey].Enabled = not ESP_Settings[roleKey].Enabled
        local active = ESP_Settings[roleKey].Enabled
        TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(40, 40, 50)}):Play()
        TweenService:Create(togDot, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)}):Play()
    end)
    
    -- Expand / Collapse
    local expanded = false
    expandBtn.MouseButton1Click:Connect(function()
        expanded = not expanded
        expandBtn.Text = expanded and "▲" or "▼"
        secStroke.Color = expanded and Color3.fromRGB(255, 30, 60) or Color3.fromRGB(45, 45, 55)
        local targetHeight = expanded and (isGunSection and 195 or 160) or 38
        TweenService:Create(sectionFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, -8, 0, targetHeight)}):Play()
    end)
end

-- Create Sections
CreateESPSection("Innocent", "Outline Innocent", false)
CreateESPSection("Sheriff", "ESP Sheriff", false)
CreateESPSection("Murder", "ESP Murder", false)
CreateESPSection("Gun", "ESP Gun", true)

-- ==========================================
-- MM2 PLAYER ROLE ESP LOGIC
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

-- ==========================================
-- DROPPED GUN SEARCH & HIGHLIGHT
-- ==========================================
local function FindDroppedGun()
    -- Оружие на карте MM2 может лежать в workspace с именем GunDrop или в частях карты
    for _, item in pairs(workspace:GetChildren()) do
        if item:IsA("Tool") or item.Name == "GunDrop" or (item:IsA("Model") and item:FindFirstChild("Gun")) then
            if item.Name == "GunDrop" or item:FindFirstChild("Gun") or item.Name == "Gun" then
                return item
            end
        end
    end
    return nil
end

local gunWasOnMap = false

RunService.RenderStepped:Connect(function()
    -- 1. Player ESP
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local role = GetPlayerRole(plr)
            local cfg = ESP_Settings[role]
            
            local hl = plr.Character:FindFirstChild("QuatroESP")
            if cfg and cfg.Enabled and cfg.Transparency > 0 then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "QuatroESP"
                    hl.Parent = plr.Character
                end
                hl.Adornee = plr.Character
                hl.FillTransparency = 1
                hl.OutlineColor = cfg.Color
                hl.OutlineTransparency = 1 - cfg.Transparency
            else
                if hl then hl:Destroy() end
            end
        end
    end
    
    -- 2. Gun ESP & Alert Trigger
    local droppedGun = FindDroppedGun()
    
    if droppedGun then
        if not gunWasOnMap then
            gunWasOnMap = true
            if ESP_Settings.Gun.AlertEnabled then
                ShowGunAlert()
            end
        end
        
        -- Gun ESP Highlight
        local cfg = ESP_Settings.Gun
        local hl = droppedGun:FindFirstChild("QuatroGunESP")
        if cfg.Enabled and cfg.Transparency > 0 then
            if not hl then
                hl = Instance.new("Highlight")
                hl.Name = "QuatroGunESP"
                hl.Parent = droppedGun
            end
            hl.Adornee = droppedGun
            hl.FillTransparency = 1
            hl.OutlineColor = cfg.Color
            hl.OutlineTransparency = 1 - cfg.Transparency
        else
            if hl then hl:Destroy() end
        end
    else
        gunWasOnMap = false
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
