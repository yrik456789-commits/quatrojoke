-- [[ quatrojoke Script | Safe-Inject Edition ]] --

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
    MainFrame.Size = UDim2.new(0, 620, 0, 470)
    MainFrame.Position = UDim2.new(0.5, -310, 0.5, -235)
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner") MainCorner.CornerRadius = UDim.new(0, 12) MainCorner.Parent = MainFrame
    local MainStroke = Instance.new("UIStroke") MainStroke.Color = Color3.fromRGB(255, 40, 70) MainStroke.Thickness = 2.5 MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border MainStroke.Parent = MainFrame

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
    IntroFrame.Size = UDim2.new(0, 620, 0, 470)
    IntroFrame.Position = UDim2.new(0.5, -310, 0.5, -235)
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
    StatusLabel.Text = "Инициализация..."
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 13
    StatusLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    StatusLabel.Parent = IntroFrame

    math.randomseed(os.time())
    local loadTime = math.random(4, 10)
    local statuses = {"Проверка инжекции...", "Настройка функций...", "Подготовка GUI...", "Запуск quatrojoke..."}

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
    -- CONFIG DATA
    -- ==========================================
    local Config = {
        Outlines = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 },
            Gun      = { Enabled = false, Color = Color3.fromRGB(255, 200, 0), Transparency = 1, AlertEnabled = false }
        },
        Tracers = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 }
        },
        Boxes = {
            Innocent = { Enabled = false, Color = Color3.fromRGB(0, 255, 120), Transparency = 1 },
            Sheriff  = { Enabled = false, Color = Color3.fromRGB(0, 140, 255), Transparency = 1 },
            Murder   = { Enabled = false, Color = Color3.fromRGB(255, 40, 70), Transparency = 1 }
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

    CreateHeader(TabVisuals, "3D BOX ESP")
    CreateSection(TabVisuals, Config.Boxes.Innocent, "3D Box Innocent")
    CreateSection(TabVisuals, Config.Boxes.Sheriff, "3D Box Sheriff")
    CreateSection(TabVisuals, Config.Boxes.Murder, "3D Box Murder")

    -- Sounds Tab
    CreateHeader(TabSounds, "SOUNDS")
    CreateSection(TabSounds, Config.Sounds.Shoot, "Shoot Sound", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabSounds, Config.Sounds.Kill, "Kill Sound", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabSounds, Config.Sounds.MurderKill, "Kill Sound (Murder)", {Color = false, Transparency = false, ExpandedHeight = 40})

    -- Fling Tab
    CreateHeader(TabFling, "FLING TARGETS")

    local PlayerListFrame = Instance.new("ScrollingFrame")
    PlayerListFrame.Size = UDim2.new(1, -8, 0, 180)
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
                pBtn.Text = plr.DisplayName .. " (@" .. plr.Name .. ")"
                pBtn.Font = Enum.Font.GothamMedium
                pBtn.TextSize = 12
                pBtn.TextColor3 = Color3.fromRGB(220, 220, 230)
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
    FlingActionBtn.Text = "⚡ ВЫПОЛНИТЬ FLING"
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
                    
                    for i = 1, 40 do
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

    -- Visual FX
    CreateHeader(TabFX, "EFFECTS")
    CreateSection(TabFX, Config.Aura, "Player Aura")
    CreateSection(TabFX, Config.Angel, "3D Angel Wings")
    CreateSection(TabFX, Config.DemonArms, "Demon Arms (Клешни)")

    -- Movement Tab
    CreateHeader(TabMove, "MOVEMENT")
    CreateSection(TabMove, Config.Movement.Fly, "Fly (Полет)", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabMove, Config.Movement.Spin, "Spin (Вращение)", {Color = false, Transparency = false, ExpandedHeight = 40})
    CreateSection(TabMove, Config.Movement.Noclip, "Noclip (Сквозь стены)", {Color = false, Transparency = false, ExpandedHeight = 40})

    -- ==========================================
    -- ENGINE LOOP & DEMON ARMS CREATION (In-Engine)
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
        for _, obj in pairs(Workspace:GetDescendants()) do
            if obj.Name == "GunDrop" or (obj:IsA("Tool") and (obj.Name == "Gun" or obj.Name == "Revolver")) then
                if not obj:IsDescendantOf(Players) then return obj end
            end
        end
        return nil
    end

    -- Safe Demon Arms Setup (Without external MeshId crashes)
    local demonArmsParts = {}
    for side = -1, 1, 2 do
        local armUpper = Instance.new("Part")
        armUpper.Size = Vector3.new(0.5, 1.8, 0.5)
        armUpper.CanCollide = false armUpper.Anchored = true armUpper.Material = Enum.Material.SmoothPlastic armUpper.Transparency = 1 armUpper.Parent = FXContainer
        
        local clawBase = Instance.new("Part")
        clawBase.Size = Vector3.new(0.7, 0.5, 0.7)
        clawBase.CanCollide = false clawBase.Anchored = true clawBase.Material = Enum.Material.SmoothPlastic clawBase.Transparency = 1 clawBase.Parent = FXContainer
        
        table.insert(demonArmsParts, {Upper = armUpper, Claw = clawBase, Side = side})
    end

    -- Main Engine Loop
    local armBob = 0
    RunService.RenderStepped:Connect(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        
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
        
        -- Demon Arms Motion[cite: 3]
        local cfgDA = Config.DemonArms
        if cfgDA.Enabled and hrp then
            armBob = armBob + 0.04
            local bobY = math.sin(armBob) * 0.2
            
            for _, arm in ipairs(demonArmsParts) do
                local side = arm.Side
                local targetUpperCF = hrp.CFrame * CFrame.new(side * 1.8, 0.6 + bobY, 0.8) * CFrame.Angles(math.rad(20), 0, side * math.rad(-30))
                local targetClawCF = targetUpperCF * CFrame.new(0, 1.1, -0.3) * CFrame.Angles(math.rad(45), 0, 0)
                
                arm.Upper.CFrame = arm.Upper.CFrame:Lerp(targetUpperCF, 0.25)
                arm.Claw.CFrame = arm.Claw.CFrame:Lerp(targetClawCF, 0.25)
                
                arm.Upper.Color = cfgDA.Color
                arm.Claw.Color = cfgDA.Color
                arm.Upper.Transparency = 1 - cfgDA.Transparency
                arm.Claw.Transparency = 1 - cfgDA.Transparency
            end
        else
            for _, arm in ipairs(demonArmsParts) do
                arm.Upper.Transparency = 1
                arm.Claw.Transparency = 1
            end
        end
        
        -- Tracers & 3D Boxes
        DrawingCanvas:ClearAllChildren()
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local role = GetPlayerRole(plr)
                local p_hrp = plr.Character.HumanoidRootPart
                local pos, onScreen = Camera:WorldToScreenPoint(p_hrp.Position)
                
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
                        local cSize = plr.Character:GetExtentsSize()
                        local topCF = Camera:WorldToScreenPoint(p_hrp.Position + Vector3.new(0, cSize.Y / 2, 0))
                        local botCF = Camera:WorldToScreenPoint(p_hrp.Position - Vector3.new(0, cSize.Y / 2, 0))
                        local height = math.abs(topCF.Y - botCF.Y)
                        local width = height / 1.5
                        
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

    -- Keybind Toggle UI (Left Control)
    local minimized = false
    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.LeftControl then
            minimized = not minimized
            MainFrame.Visible = not minimized
        end
    end)
end)

if not success then
    warn("quatrojoke Load Error: " .. tostring(err))
end
