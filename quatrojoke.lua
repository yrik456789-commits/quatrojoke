-- [[ quatrojoke Script | Ultimate MM2 Suite ]] --

local success, err = pcall(function()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    local Workspace = game:GetService("Workspace")
    local SoundService = game:GetService("SoundService")

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    -- Cleanup
    if CoreGui:FindFirstChild("QuatrojokeUI") then CoreGui:FindFirstChild("QuatrojokeUI"):Destroy() end
    if Workspace:FindFirstChild("QuatroFXContainer") then Workspace:FindFirstChild("QuatroFXContainer"):Destroy() end

    -- ==========================================
    -- CONTAINERS & SCREEN GUI
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
    -- MAIN FRAME & RAINBOW HUD
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 640, 0, 480)
    MainFrame.Position = UDim2.new(0.5, -320, 0.5, -240)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 12) MainCorner.Parent = MainFrame
    local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(255, 40, 70) MainStroke.Thickness = 2.5 MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border MainStroke.Parent = MainFrame

    -- Rainbow Minimized Widget
    local RainbowWidget = Instance.new("Frame")
    RainbowWidget.Name = "RainbowWidget"
    RainbowWidget.Size = UDim2.new(0, 160, 0, 36)
    RainbowWidget.Position = UDim2.new(0.5, -80, 0, 15)
    RainbowWidget.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
    RainbowWidget.BorderSizePixel = 0
    RainbowWidget.Visible = false
    RainbowWidget.Parent = ScreenGui

    local WidgetCorner = Instance.new("UICorner") WidgetCorner.CornerRadius = UDim.new(0, 10) WidgetCorner.Parent = RainbowWidget
    local WidgetStroke = Instance.new("UIStroke") WidgetStroke.Thickness = 2 WidgetStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border WidgetStroke.Parent = RainbowWidget

    local WidgetText = Instance.new("TextLabel")
    WidgetText.Size = UDim2.new(1, 0, 1, 0)
    WidgetText.BackgroundTransparency = 1
    WidgetText.Text = "quatrojoke"
    WidgetText.Font = Enum.Font.FredokaOne
    WidgetText.TextSize = 16
    WidgetText.TextColor3 = Color3.fromRGB(255, 255, 255)
    WidgetText.Parent = RainbowWidget

    local WidgetBtn = Instance.new("TextButton")
    WidgetBtn.Size = UDim2.new(1, 0, 1, 0)
    WidgetBtn.BackgroundTransparency = 1
    WidgetBtn.Text = ""
    WidgetBtn.Parent = RainbowWidget

    -- Notification Toast
    local ToastFrame = Instance.new("Frame")
    ToastFrame.Name = "ToastFrame"
    ToastFrame.Size = UDim2.new(0, 260, 0, 42)
    ToastFrame.Position = UDim2.new(1, 20, 1, -55)
    ToastFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    ToastFrame.BorderSizePixel = 0
    ToastFrame.Parent = ScreenGui

    local ToastCorner = Instance.new("UICorner") ToastCorner.CornerRadius = UDim.new(0, 8) ToastCorner.Parent = ToastFrame
    local ToastStroke = Instance.new("UIStroke") ToastStroke.Color = Color3.fromRGB(255, 40, 70) ToastStroke.Thickness = 1.5 ToastStroke.Parent = ToastFrame

    local ToastText = Instance.new("TextLabel")
    ToastText.Size = UDim2.new(1, 0, 1, 0)
    ToastText.BackgroundTransparency = 1
    ToastText.Text = "📌 Скрипт скрыт (нажми LeftControl)"
    ToastText.Font = Enum.Font.GothamMedium
    ToastText.TextSize = 11
    ToastText.TextColor3 = Color3.fromRGB(220, 220, 230)
    ToastText.Parent = ToastFrame

    local function ShowToast()
        ToastFrame:TweenPosition(UDim2.new(1, -270, 1, -55), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.4, true)
        task.delay(3, function()
            ToastFrame:TweenPosition(UDim2.new(1, 20, 1, -55), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.4, true)
        end)
    end

    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 44)
    TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(0, 240, 1, 0)
    TitleLabel.Position = UDim2.new(0, 16, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "quatrojoke <font color=\"#8C8C9E\">| MM2 Suite</font>"
    TitleLabel.RichText = true
    TitleLabel.Font = Enum.Font.FredokaOne
    TitleLabel.TextSize = 22
    TitleLabel.TextColor3 = Color3.fromRGB(255, 50, 80)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -38, 0, 7)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(45, 20, 28)
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 100)
    CloseBtn.TextSize = 14
    CloseBtn.Parent = TopBar
    local CloseCorner = Instance.new("UICorner") CloseCorner.CornerRadius = UDim.new(0, 8) CloseCorner.Parent = CloseBtn

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -74, 0, 7)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MinimizeBtn.Text = "—"
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 220)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.Parent = TopBar
    local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 8) MinCorner.Parent = MinimizeBtn

    local function ToggleMinimize()
        if MainFrame.Visible then
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            MainFrame.Visible = false
            MainFrame.Size = UDim2.new(0, 640, 0, 480)
            MainFrame.BackgroundTransparency = 0.05
            RainbowWidget.Visible = true
            ShowToast()
        else
            RainbowWidget.Visible = false
            MainFrame.Visible = true
            MainFrame.Size = UDim2.new(0, 0, 0, 0)
            MainFrame.BackgroundTransparency = 1
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 640, 0, 480), BackgroundTransparency = 0.05}):Play()
        end
    end

    MinimizeBtn.MouseButton1Click:Connect(ToggleMinimize)
    WidgetBtn.MouseButton1Click:Connect(ToggleMinimize)

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
    SideBar.Size = UDim2.new(0, 160, 1, -44)
    SideBar.Position = UDim2.new(0, 0, 0, 44)
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    SideBar.BorderSizePixel = 0
    SideBar.Parent = MainFrame

    local SideList = Instance.new("UIListLayout") SideList.Padding = UDim.new(0, 6) SideList.SortOrder = Enum.SortOrder.LayoutOrder SideList.Parent = SideBar
    local SidePadding = Instance.new("UIPadding") SidePadding.PaddingTop = UDim.new(0, 10) SidePadding.PaddingLeft = UDim.new(0, 10) SidePadding.PaddingRight = UDim.new(0, 10) SidePadding.Parent = SideBar

    -- Content Area
    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -160, 1, -44)
    ContentArea.Position = UDim2.new(0, 160, 0, 44)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    -- ==========================================
    -- INTRO FRAME
    -- ==========================================
    local IntroFrame = Instance.new("Frame")
    IntroFrame.Name = "IntroFrame"
    IntroFrame.Size = UDim2.new(0, 640, 0, 480)
    IntroFrame.Position = UDim2.new(0.5, -320, 0.5, -240)
    IntroFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
    IntroFrame.BackgroundTransparency = 0.05
    IntroFrame.ClipsDescendants = true
    IntroFrame.Parent = ScreenGui

    local IntroCorner = Instance.new("UICorner") IntroCorner.CornerRadius = UDim.new(0, 12) IntroCorner.Parent = IntroFrame
    local IntroStroke = Instance.new("UIStroke") IntroStroke.Color = Color3.fromRGB(255, 40, 70) IntroStroke.Thickness = 2.5 IntroStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border IntroStroke.Parent = IntroFrame

    local IntroTitle = Instance.new("TextLabel")
    IntroTitle.Size = UDim2.new(1, 0, 0, 60)
    IntroTitle.Position = UDim2.new(0, 0, 0.3, -30)
    IntroTitle.BackgroundTransparency = 1
    IntroTitle.Text = "quatrojoke"
    IntroTitle.Font = Enum.Font.FredokaOne
    IntroTitle.TextSize = 54
    IntroTitle.TextColor3 = Color3.fromRGB(255, 40, 70)
    IntroTitle.TextStrokeTransparency = 0.2
    IntroTitle.TextStrokeColor3 = Color3.fromRGB(140, 0, 30)
    IntroTitle.Parent = IntroFrame

    local IntroSub = Instance.new("TextLabel")
    IntroSub.Size = UDim2.new(1, 0, 0, 25)
    IntroSub.Position = UDim2.new(0, 0, 0.3, 32)
    IntroSub.BackgroundTransparency = 1
    IntroSub.Text = "Murder Mystery 2 Suite"
    IntroSub.Font = Enum.Font.GothamMedium
    IntroSub.TextSize = 15
    IntroSub.TextColor3 = Color3.fromRGB(180, 180, 190)
    IntroSub.Parent = IntroFrame

    local BarBg = Instance.new("Frame")
    BarBg.Size = UDim2.new(0, 400, 0, 8)
    BarBg.Position = UDim2.new(0.5, -200, 0.6, 0)
    BarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    BarBg.BorderSizePixel = 0
    BarBg.Parent = IntroFrame

    local BarCorner = Instance.new("UICorner") BarCorner.CornerRadius = UDim.new(1, 0) BarCorner.Parent = BarBg
    local BarFill = Instance.new("Frame") BarFill.Size = UDim2.new(0, 0, 1, 0) BarFill.BackgroundColor3 = Color3.fromRGB(255, 40, 70) BarFill.BorderSizePixel = 0 BarFill.Parent = BarBg
    local FillCorner = Instance.new("UICorner") FillCorner.CornerRadius = UDim.new(1, 0) FillCorner.Parent = BarFill

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, 0, 0, 25)
    StatusLabel.Position = UDim2.new(0, 0, 0.6, 12)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Загрузка..."
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 13
    StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    StatusLabel.Parent = IntroFrame

    math.randomseed(os.time())
    local loadTime = math.random(3, 6)
    local statuses = {"Загрузка модулей...", "Калибровка 3D боксов...", "Инициализация Nicks...", "Запуск quatrojoke..."}

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
        task.wait(0.2)
        
        local fadeTween = TweenService:Create(IntroFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1})
        TweenService:Create(IntroTitle, TweenInfo.new(0.3), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        TweenService:Create(IntroSub, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(BarBg, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(BarFill, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(StatusLabel, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        TweenService:Create(IntroStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        
        fadeTween:Play()
        fadeTween.Completed:Connect(function()
            IntroFrame:Destroy()
            MainFrame.Visible = true
        end)
    end)

    -- ==========================================
    -- CONFIG DATA
    -- ==========================================
    local Config = {
        Outlines = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 },
            Gun      = { Enabled = false, Color = Color3.fromRGB(255, 200, 0), Transparency = 1 }
        },
        Tracers = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 }
        },
        Boxes3D = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 }
        },
        Nicks = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120) },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255) },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70) }
        },
        Aura = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 0.8 },
        Angel = { Enabled = false, Color = Color3.fromRGB(255, 255, 255), Transparency = 0.8 },
        DemonArms = { Enabled = false, Color = Color3.fromRGB(230, 160, 120), Transparency = 0.9 },
        Sounds = {
            Shoot = { Enabled = false, SoundId = "rbxassetid://9064292110" },
            Kill = { Enabled = false, SoundId = "rbxassetid://4590657391" },
            MurderKill = { Enabled = false, SoundId = "rbxassetid://6026985010" }
        },
        AntiFling = { Enabled = false },
        Movement = {
            Fly = { Enabled = false, Speed = 50, BatmanAnim = false },
            Spin = { Enabled = false, Speed = 20 },
            Noclip = { Enabled = false }
        }
    }

    local SelectedFlingTarget = nil

    -- ==========================================
    -- TABS & UI BUILDER
    -- ==========================================
    local Tabs = {}
    local CurrentTab = nil

    local function CreateTab(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
        btn.Text = name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 13
        btn.TextColor3 = Color3.fromRGB(170, 170, 185)
        btn.Parent = SideBar
        
        local corner = Instance.new("UICorner") corner.CornerRadius = UDim.new(0, 8) corner.Parent = btn
        
        local container = Instance.new("ScrollingFrame")
        container.Size = UDim2.new(1, -16, 1, -16)
        container.Position = UDim2.new(0, 8, 0, 8)
        container.BackgroundTransparency = 1
        container.ScrollBarThickness = 4
        container.ScrollBarImageColor3 = Color3.fromRGB(255, 40, 70)
        container.Visible = false
        container.Parent = ContentArea
        
        local layout = Instance.new("UIListLayout") layout.Padding = UDim.new(0, 10) layout.SortOrder = Enum.SortOrder.LayoutOrder layout.Parent = container
        
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        end)
        
        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Container.Visible = false
                TweenService:Create(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 30), TextColor3 = Color3.fromRGB(170, 170, 185)}):Play()
            end
            container.Visible = true
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 20, 35), TextColor3 = Color3.fromRGB(255, 50, 80)}):Play()
            CurrentTab = container
        end)
        
        table.insert(Tabs, {Button = btn, Container = container})
        if not CurrentTab then
            container.Visible = true
            btn.BackgroundColor3 = Color3.fromRGB(50, 20, 35)
            btn.TextColor3 = Color3.fromRGB(255, 50, 80)
            CurrentTab = container
        end
        return container
    end

    local TabVisuals = CreateTab("Visuals / ESP")
    local TabSounds = CreateTab("Sounds")
    local TabFling = CreateTab("Fling")
    local TabMisc = CreateTab("Misc")
    local TabFX = CreateTab("Visual Effects")
    local TabMove = CreateTab("Movement")

    local PaletteColors = {
        Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(255, 40, 70),
        Color3.fromRGB(230, 160, 120),
        Color3.fromRGB(0, 255, 120),
        Color3.fromRGB(0, 140, 255),
        Color3.fromRGB(180, 0, 255)
    }

    local function CreateSection(parentTab, cfgRef, titleText, options)
        options = options or {}
        local hasColor = options.Color ~= false
        local hasTrans = options.Transparency ~= false
        local customSub = options.CustomSub
        local expandedHeight = options.ExpandedHeight or 170

        local sectionFrame = Instance.new("Frame")
        sectionFrame.Size = UDim2.new(1, -8, 0, 40)
        sectionFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
        sectionFrame.ClipsDescendants = true
        sectionFrame.Parent = parentTab
        
        local secCorner = Instance.new("UICorner") secCorner.CornerRadius = UDim.new(0, 8) secCorner.Parent = sectionFrame
        local secStroke = Instance.new("UIStroke") secStroke.Color = Color3.fromRGB(40, 40, 52) secStroke.Thickness = 1.2 secStroke.Parent = sectionFrame
        
        local topToggle = Instance.new("Frame")
        topToggle.Size = UDim2.new(1, 0, 0, 40)
        topToggle.BackgroundTransparency = 1
        topToggle.Parent = sectionFrame
        
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size = UDim2.new(0.65, 0, 1, 0)
        titleLbl.Position = UDim2.new(0, 14, 0, 0)
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = titleText
        titleLbl.Font = Enum.Font.GothamMedium
        titleLbl.TextSize = 13
        titleLbl.TextColor3 = Color3.fromRGB(220, 220, 230)
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.Parent = topToggle
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 44, 0, 22)
        toggleBtn.Position = UDim2.new(1, -94, 0.5, -11)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        toggleBtn.Text = ""
        toggleBtn.Parent = topToggle
        
        local togCorner = Instance.new("UICorner") togCorner.CornerRadius = UDim.new(1, 0) togCorner.Parent = toggleBtn
        local togDot = Instance.new("Frame") togDot.Size = UDim2.new(0, 16, 0, 16) togDot.Position = UDim2.new(0, 3, 0.5, -8) togDot.BackgroundColor3 = Color3.fromRGB(140, 140, 150) togDot.Parent = toggleBtn
        local dotCorner = Instance.new("UICorner") dotCorner.CornerRadius = UDim.new(1, 0) dotCorner.Parent = togDot
        
        local expandBtn = Instance.new("TextButton")
        expandBtn.Size = UDim2.new(0, 32, 0, 40)
        expandBtn.Position = UDim2.new(1, -40, 0, 0)
        expandBtn.BackgroundTransparency = 1
        expandBtn.Text = "▼"
        expandBtn.Font = Enum.Font.GothamBold
        expandBtn.TextSize = 11
        expandBtn.TextColor3 = Color3.fromRGB(170, 170, 185)
        expandBtn.Parent = topToggle
        
        local subPanel = Instance.new("Frame")
        subPanel.Size = UDim2.new(1, -24, 0, expandedHeight - 44)
        subPanel.Position = UDim2.new(0, 12, 0, 44)
        subPanel.BackgroundTransparency = 1
        subPanel.Parent = sectionFrame
        
        local yOffset = 0
        
        if hasColor then
            local colorLbl = Instance.new("TextLabel")
            colorLbl.Size = UDim2.new(1, 0, 0, 20)
            colorLbl.Position = UDim2.new(0, 0, 0, yOffset)
            colorLbl.BackgroundTransparency = 1
            colorLbl.Text = "Цветовая палитра:"
            colorLbl.Font = Enum.Font.Gotham
            colorLbl.TextSize = 12
            colorLbl.TextColor3 = Color3.fromRGB(160, 160, 175)
            colorLbl.TextXAlignment = Enum.TextXAlignment.Left
            colorLbl.Parent = subPanel
            
            local colorPreview = Instance.new("Frame")
            colorPreview.Size = UDim2.new(0, 22, 0, 22)
            colorPreview.Position = UDim2.new(1, -22, 0, yOffset)
            colorPreview.BackgroundColor3 = cfgRef.Color or Color3.fromRGB(255, 40, 70)
            colorPreview.Parent = subPanel
            
            local prevCorner = Instance.new("UICorner") prevCorner.CornerRadius = UDim.new(0, 6) prevCorner.Parent = colorPreview
            
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
                local pCorner = Instance.new("UICorner") pCorner.CornerRadius = UDim.new(0, 6) pCorner.Parent = pBtn
                pBtn.MouseButton1Click:Connect(function()
                    cfgRef.Color = col
                    colorPreview.BackgroundColor3 = col
                end)
            end
            yOffset = yOffset + 56
        end
        
        if hasTrans then
            local transLbl = Instance.new("TextLabel")
            transLbl.Size = UDim2.new(1, 0, 0, 20)
            transLbl.Position = UDim2.new(0, 0, 0, yOffset)
            transLbl.BackgroundTransparency = 1
            transLbl.Text = "Прозрачность: " .. math.floor((cfgRef.Transparency or 0.5) * 100) .. "%"
            transLbl.Font = Enum.Font.Gotham
            transLbl.TextSize = 12
            transLbl.TextColor3 = Color3.fromRGB(160, 160, 175)
            transLbl.TextXAlignment = Enum.TextXAlignment.Left
            transLbl.Parent = subPanel
            
            local sliderBg = Instance.new("Frame")
            sliderBg.Size = UDim2.new(1, 0, 0, 8)
            sliderBg.Position = UDim2.new(0, 0, 0, yOffset + 24)
            sliderBg.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
            sliderBg.Parent = subPanel
            
            local sBgCorner = Instance.new("UICorner") sBgCorner.CornerRadius = UDim.new(1, 0) sBgCorner.Parent = sliderBg
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new(cfgRef.Transparency or 0.5, 0, 1, 0)
            sliderFill.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
            sliderFill.Parent = sliderBg
            local sFillCorner = Instance.new("UICorner") sFillCorner.CornerRadius = UDim.new(1, 0) sFillCorner.Parent = sliderFill
            
            local sliding = false
            sliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end end)
            UserInputService.InputChanged:Connect(function(input)
                if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    transLbl.Text = "Прозрачность: " .. math.floor(pos * 100) .. "%"
                    cfgRef.Transparency = pos
                end
            end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end end)
            yOffset = yOffset + 42
        end
        
        if customSub then customSub(subPanel, yOffset) end
        
        toggleBtn.MouseButton1Click:Connect(function()
            cfgRef.Enabled = not cfgRef.Enabled
            local active = cfgRef.Enabled
            TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(255, 40, 70) or Color3.fromRGB(35, 35, 45)}):Play()
            TweenService:Create(togDot, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8), BackgroundColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 150)}):Play()
        end)
        
        local expanded = false
        expandBtn.MouseButton1Click:Connect(function()
            expanded = not expanded
            expandBtn.Text = expanded and "▲" or "▼"
            secStroke.Color = expanded and Color3.fromRGB(255, 40, 70) or Color3.fromRGB(40, 40, 52)
            TweenService:Create(sectionFrame, TweenInfo.new(0.25), {Size = UDim2.new(1, -8, 0, expanded and expandedHeight or 40)}):Play()
        end)
    end

    local function CreateHeader(parentTab, text)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 22)
        lbl.BackgroundTransparency = 1
        lbl.Text = "--- " .. text .. " ---"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 12
        lbl.TextColor3 = Color3.fromRGB(255, 50, 80)
        lbl.Parent = parentTab
    end

    -- Visuals Tab
    CreateHeader(TabVisuals, "OUTLINES")
    CreateSection(TabVisuals, Config.Outlines.Innocent, "Outline Innocent")
    CreateSection(TabVisuals, Config.Outlines.Sheriff, "ESP Sheriff")
    CreateSection(TabVisuals, Config.Outlines.Murder, "ESP Murder")
    CreateSection(TabVisuals, Config.Outlines.Gun, "ESP Gun")

    CreateHeader(TabVisuals, "TRACERS & LINES")
    CreateSection(TabVisuals, Config.Tracers.Innocent, "Tracer Innocent")
    CreateSection(TabVisuals, Config.Tracers.Sheriff, "Tracer Sheriff")
    CreateSection(TabVisuals, Config.Tracers.Murder, "Tracer Murder")

    CreateHeader(TabVisuals, "TRUE 3D BOXES")
    CreateSection(TabVisuals, Config.Boxes3D.Innocent, "3D Box Innocent")
    CreateSection(TabVisuals, Config.Boxes3D.Sheriff, "3D Box Sheriff")
    CreateSection(TabVisuals, Config.Boxes3D.Murder, "3D Box Murder")

    CreateHeader(TabVisuals, "NICKS PEOPLES")
    CreateSection(TabVisuals, Config.Nicks.Innocent, "Nick Innocent", {Transparency = false, ExpandedHeight = 90})
    CreateSection(TabVisuals, Config.Nicks.Sheriff, "Nick Sheriff", {Transparency = false, ExpandedHeight = 90})
    CreateSection(TabVisuals, Config.Nicks.Murder, "Nick Murder", {Transparency = false, ExpandedHeight = 90})

    -- Sounds Tab
    CreateHeader(TabSounds, "SOUNDS")
    CreateSection(TabSounds, Config.Sounds.Shoot, "Shoot Sound", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabSounds, Config.Sounds.Kill, "Kill Sound", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabSounds, Config.Sounds.MurderKill, "Kill Sound (Murder)", {Color = false, Transparency = false, ExpandedHeight = 40})

    -- Fling Tab
    CreateHeader(TabFling, "PLAYER SELECTOR FLING")

    local PlayerListFrame = Instance.new("ScrollingFrame")
    PlayerListFrame.Size = UDim2.new(1, -8, 0, 160)
    PlayerListFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
    PlayerListFrame.ScrollBarThickness = 4
    PlayerListFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 40, 70)
    PlayerListFrame.Parent = TabFling

    local pListCorner = Instance.new("UICorner") pListCorner.CornerRadius = UDim.new(0, 8) pListCorner.Parent = PlayerListFrame
    local pListLayout = Instance.new("UIListLayout") pListLayout.Padding = UDim.new(0, 4) pListLayout.Parent = PlayerListFrame

    local function RefreshPlayerList()
        PlayerListFrame:ClearAllChildren()
        local layout = Instance.new("UIListLayout") layout.Padding = UDim.new(0, 4) layout.Parent = PlayerListFrame
        
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local pBtn = Instance.new("TextButton")
                pBtn.Size = UDim2.new(1, -8, 0, 28)
                pBtn.BackgroundColor3 = (SelectedFlingTarget == plr) and Color3.fromRGB(50, 20, 35) or Color3.fromRGB(25, 25, 35)
                pBtn.Text = "  " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                pBtn.Font = Enum.Font.GothamMedium
                pBtn.TextSize = 12
                pBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
                pBtn.TextXAlignment = Enum.TextXAlignment.Left
                pBtn.Parent = PlayerListFrame
                
                local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0, 6) c.Parent = pBtn
                pBtn.MouseButton1Click:Connect(function()
                    SelectedFlingTarget = plr
                    RefreshPlayerList()
                end)
            end
        end
        PlayerListFrame.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 32)
    end

    RefreshPlayerList()
    Players.PlayerAdded:Connect(RefreshPlayerList)
    Players.PlayerRemoving:Connect(RefreshPlayerList)

    local FlingActionBtn = Instance.new("TextButton")
    FlingActionBtn.Size = UDim2.new(1, -8, 0, 36)
    FlingActionBtn.BackgroundColor3 = Color3.fromRGB(255, 40, 70)
    FlingActionBtn.Text = "⚡ ЗАПУСТИТЬ FLING НА ЦЕЛЬ"
    FlingActionBtn.Font = Enum.Font.GothamBold
    FlingActionBtn.TextSize = 13
    FlingActionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FlingActionBtn.Parent = TabFling

    local faCorner = Instance.new("UICorner") faCorner.CornerRadius = UDim.new(0, 8) faCorner.Parent = FlingActionBtn

    FlingActionBtn.MouseButton1Click:Connect(function()
        if SelectedFlingTarget and SelectedFlingTarget.Character and SelectedFlingTarget.Character:FindFirstChild("HumanoidRootPart") then
            local targetHrp = SelectedFlingTarget.Character.HumanoidRootPart
            local myChar = LocalPlayer.Character
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
            
            if myHrp then
                task.spawn(function()
                    local bV = Instance.new("BodyAngularVelocity")
                    bV.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
                    bV.AngularVelocity = Vector3.new(99999, 99999, 99999)
                    bV.Parent = myHrp
                    
                    for i = 1, 45 do
                        if not targetHrp or not targetHrp.Parent then break end
                        myHrp.CFrame = targetHrp.CFrame
                        task.wait(0.02)
                    end
                    bV:Destroy()
                end)
            end
        end
    end)

    CreateHeader(TabFling, "PROTECTION")
    CreateSection(TabFling, Config.AntiFling, "Anti Fling (Защита)", {Color = false, Transparency = false, ExpandedHeight = 40})

    -- Misc Tab
    CreateHeader(TabMisc, "ENHANCED FEATURES")
    CreateSection(TabMisc, Config.DemonArms, "Demon Arms (Плавные клешни)", {ExpandedHeight = 170})

    -- Visual FX Tab
    CreateHeader(TabFX, "EFFECTS")
    CreateSection(TabFX, Config.Aura, "Player Aura Effect")
    CreateSection(TabFX, Config.Angel, "3D Angel Wings")

    -- Movement Tab
    CreateHeader(TabMove, "MOVEMENT")
    CreateSection(TabMove, Config.Movement.Fly, "Fly (Полет)", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabMove, Config.Movement.Spin, "Spin (Вращение)", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabMove, Config.Movement.Noclip, "Noclip (Сквозь стены)", {Color = false, Transparency = false, ExpandedHeight = 40})

    -- ==========================================
    -- VISUAL FX GENERATORS (Wings, Aura, Demon Arms)
    -- ==========================================
    local auraBars = {}
    for i = 1, 6 do
        local bar = Instance.new("Part")
        bar.Size = Vector3.new(0.2, 1.8, 0.2)
        bar.CanCollide = false bar.Anchored = true bar.Material = Enum.Material.Neon bar.Transparency = 1 bar.Parent = FXContainer
        table.insert(auraBars, bar)
    end

    local wing3DFeathers = {}
    for side = -1, 1, 2 do
        for layer = 1, 3 do
            for i = 1, 4 do
                local feather = Instance.new("Part")
                feather.CanCollide = false feather.Anchored = true feather.Material = Enum.Material.SmoothPlastic feather.Transparency = 1 feather.Parent = FXContainer
                
                local mesh = Instance.new("SpecialMesh")
                mesh.MeshType = Enum.MeshType.Wedge
                mesh.Scale = Vector3.new(0.1, 1.5 + (i * 0.3), 0.3)
                mesh.Parent = feather
                
                table.insert(wing3DFeathers, {Part = feather, Side = side, Layer = layer, Index = i})
            end
        end
    end

    -- Super smooth and high quality Demon Arms (Lego Claws)
    local demonArmsParts = {}
    for side = -1, 1, 2 do
        local armUpper = Instance.new("Part")
        armUpper.Size = Vector3.new(0.4, 1.7, 0.4)
        armUpper.CanCollide = false armUpper.Anchored = true armUpper.Material = Enum.Material.SmoothPlastic armUpper.Transparency = 1 armUpper.Parent = FXContainer
        
        local clawLeft = Instance.new("Part")
        clawLeft.Size = Vector3.new(0.18, 0.7, 0.25)
        clawLeft.CanCollide = false clawLeft.Anchored = true clawLeft.Material = Enum.Material.SmoothPlastic clawLeft.Transparency = 1 clawLeft.Parent = FXContainer
        
        local clawRight = clawLeft:Clone() clawRight.Parent = FXContainer
        
        table.insert(demonArmsParts, {Upper = armUpper, ClawL = clawLeft, ClawR = clawRight, Side = side})
    end

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

    -- ==========================================
    -- ENGINE RENDER LOOP (True 3D Boxes & Nicks)
    -- ==========================================
    local auraAngle = 0
    local wingFlap = 0
    local armBob = 0
    local hue = 0

    local bodyVel = Instance.new("BodyVelocity") bodyVel.MaxForce = Vector3.new(0, 0, 0)
    local bodyGyro = Instance.new("BodyGyro") bodyGyro.MaxTorque = Vector3.new(0, 0, 0)

    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")

        if RainbowWidget.Visible then
            hue = (hue + 0.005) % 1
            WidgetStroke.Color = Color3.fromHSV(hue, 0.8, 1)
        end

        -- Anti-Fling
        if Config.AntiFling.Enabled and hrp then
            for _, v in pairs(Workspace:GetChildren()) do
                if v:IsA("Model") and v ~= char and v:FindFirstChild("HumanoidRootPart") then
                    local oHrp = v.HumanoidRootPart
                    if (oHrp.Position - hrp.Position).Magnitude < 8 then
                        if oHrp.Velocity.Magnitude > 80 or oHrp.RotVelocity.Magnitude > 80 then
                            for _, p in pairs(char:GetDescendants()) do
                                if p:IsA("BasePart") then p.CanCollide = false end
                            end
                        end
                    end
                end
            end
        end

        -- Spiral Aura
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

        -- Angel Wings
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

        -- Ultra Smooth Demon Arms
        local cfgDA = Config.DemonArms
        if cfgDA.Enabled and hrp then
            armBob = armBob + 0.05
            local bobY = math.sin(armBob) * 0.15
            
            for _, arm in ipairs(demonArmsParts) do
                local side = arm.Side
                local targetUpperCF = hrp.CFrame * CFrame.new(side * 1.5, 0.4 + bobY, 0.6) * CFrame.Angles(math.rad(15), 0, side * math.rad(-20))
                local targetClawLCF = targetUpperCF * CFrame.new(-0.2, 0.8, -0.25) * CFrame.Angles(math.rad(35), math.rad(-15), 0)
                local targetClawRCF = targetUpperCF * CFrame.new(0.2, 0.8, -0.25) * CFrame.Angles(math.rad(35), math.rad(15), 0)
                
                arm.Upper.CFrame = arm.Upper.CFrame:Lerp(targetUpperCF, 0.3)
                arm.ClawL.CFrame = arm.ClawL.CFrame:Lerp(targetClawLCF, 0.3)
                arm.ClawR.CFrame = arm.ClawR.CFrame:Lerp(targetClawRCF, 0.3)
                
                arm.Upper.Color = cfgDA.Color
                arm.ClawL.Color = cfgDA.Color
                arm.ClawR.Color = cfgDA.Color
                arm.Upper.Transparency = 1 - cfgDA.Transparency
                arm.ClawL.Transparency = 1 - cfgDA.Transparency
                arm.ClawR.Transparency = 1 - cfgDA.Transparency
            end
        else
            for _, arm in ipairs(demonArmsParts) do
                arm.Upper.Transparency = 1
                arm.ClawL.Transparency = 1
                arm.ClawR.Transparency = 1
            end
        end

        -- ESP Rendering (True 3D Corners & Nicks Peoples)
        DrawingCanvas:ClearAllChildren()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(plr)
                local p_hrp = plr.Character.HumanoidRootPart
                local head = plr.Character:FindFirstChild("Head")
                local pos, onScreen = Camera:WorldToScreenPoint(p_hrp.Position)
                
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
                        line.Size = UDim2.new(0, distance, 0, 1.2)
                        line.Position = UDim2.new(0, startPos.X, 0, startPos.Y)
                        line.Rotation = math.deg(angle)
                        line.AnchorPoint = Vector2.new(0, 0.5)
                        line.Parent = DrawingCanvas
                    end
                    
                    -- True 3D Box ESP (Volumetric Corner Frame)
                    local cfgB = Config.Boxes3D[role]
                    if cfgB and cfgB.Enabled and cfgB.Transparency > 0 then
                        local cSize = plr.Character:GetExtentsSize()
                        local topCF = Camera:WorldToScreenPoint(p_hrp.Position + Vector3.new(0, cSize.Y / 2, 0))
                        local botCF = Camera:WorldToScreenPoint(p_hrp.Position - Vector3.new(0, cSize.Y / 2, 0))
                        local height = math.abs(topCF.Y - botCF.Y)
                        local width = height / 1.6
                        
                        local bX, bY = pos.X - width / 2, pos.Y - height / 2
                        local col3D = cfgB.Color
                        local trans3D = 1 - cfgB.Transparency
                        
                        -- Render 4 Corner Lines for 3D effect
                        for _, cornerData in ipairs({
                            {UDim2.new(0, bX, 0, bY), UDim2.new(0, width * 0.25, 0, 1.5)}, -- Top-Left H
                            {UDim2.new(0, bX, 0, bY), UDim2.new(0, 1.5, 0, height * 0.25)}, -- Top-Left V
                            {UDim2.new(0, bX + width * 0.75, 0, bY), UDim2.new(0, width * 0.25, 0, 1.5)}, -- Top-Right H
                            {UDim2.new(0, bX + width, 0, bY), UDim2.new(0, 1.5, 0, height * 0.25)}, -- Top-Right V
                            {UDim2.new(0, bX, 0, bY + height), UDim2.new(0, width * 0.25, 0, 1.5)}, -- Bot-Left H
                            {UDim2.new(0, bX, 0, bY + height * 0.75), UDim2.new(0, 1.5, 0, height * 0.25)}, -- Bot-Left V
                            {UDim2.new(0, bX + width * 0.75, 0, bY + height), UDim2.new(0, width * 0.25, 0, 1.5)}, -- Bot-Right H
                            {UDim2.new(0, bX + width, 0, bY + height * 0.75), UDim2.new(0, 1.5, 0, height * 0.25)} -- Bot-Right V
                        }) do
                            local ln = Instance.new("Frame")
                            ln.BackgroundColor3 = col3D
                            ln.BackgroundTransparency = trans3D
                            ln.BorderSizePixel = 0
                            ln.Position = cornerData[1]
                            ln.Size = cornerData[2]
                            ln.Parent = DrawingCanvas
                        end
                    end

                    -- Nicks Peoples feature
                    local cfgN = Config.Nicks[role]
                    if cfgN and cfgN.Enabled and head then
                        local headPos = Camera:WorldToScreenPoint(head.Position + Vector3.new(0, 0.8, 0))
                        local nickLbl = Instance.new("TextLabel")
                        nickLbl.Size = UDim2.new(0, 150, 0, 20)
                        nickLbl.Position = UDim2.new(0, headPos.X - 75, 0, headPos.Y - 10)
                        nickLbl.BackgroundTransparency = 1
                        nickLbl.Text = plr.Name .. " [" .. role .. "]"
                        nickLbl.Font = Enum.Font.GothamBold
                        nickLbl.TextSize = 12
                        nickLbl.TextColor3 = cfgN.Color
                        nickLbl.TextStrokeTransparency = 0.3
                        nickLbl.Parent = DrawingCanvas
                    end
                end
            end
        end
    end)

    -- Keybind LeftControl Toggle
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
            ToggleMinimize()
        end
    end)
end)

if not success then warn("quatrojoke Error: " .. tostring(err)) end
