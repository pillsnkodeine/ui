local PlayersService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = PlayersService.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Library setup
local HexulonLib = {}
HexulonLib.__index = HexulonLib

-- Colors and constants
local disabledBoxColor = Color3.fromRGB(30, 30, 30)
local enabledBoxColor = Color3.fromRGB(180, 105, 135)
local disabledTextColor = Color3.fromRGB(70, 70, 70)
local enabledTextColor = Color3.fromRGB(200, 200, 200)
local highlightColor = Color3.fromRGB(180, 105, 135)
local baseColor = Color3.fromRGB(16, 16, 16)
local textBaseColor = Color3.fromRGB(70, 70, 70)
local clickTweenTime = 0.15
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Utility function for tweens
local function t(object, props, time)
    time = time or clickTweenTime
    TweenService:Create(object, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

-- Create the main GUI
function HexulonLib.new()
    local self = setmetatable({}, HexulonLib)
    
    -- ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Hexulon GUI"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    
    -- Main Frame
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    self.MainFrame.Size = UDim2.new(0, 840, 0, 586)
    self.MainFrame.Position = UDim2.new(0.16612, 0, 0.13557, 0)
    self.MainFrame.Name = "GUI"
    
    -- Gradient
    local gradientFrame = Instance.new("Frame")
    gradientFrame.Parent = self.MainFrame
    gradientFrame.BorderSizePixel = 0
    gradientFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    gradientFrame.Size = UDim2.new(0, 840, 0, 1)
    gradientFrame.Position = UDim2.new(0, 0, 0.07, 0)
    gradientFrame.Name = "gradient"
    local gradientUI = Instance.new("UIGradient")
    gradientUI.Parent = gradientFrame
    gradientUI.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 26, 26)),
        ColorSequenceKeypoint.new(0.557, Color3.fromRGB(26, 26, 26)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 212))
    }
    
    -- Separator
    local separatorFrame = Instance.new("Frame")
    separatorFrame.Parent = self.MainFrame
    separatorFrame.BorderSizePixel = 0
    separatorFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    separatorFrame.Size = UDim2.new(0, 840, 0, 1)
    separatorFrame.Position = UDim2.new(0, 0, 0.94, 0)
    separatorFrame.Name = "separator"
    
    -- Footer Labels
    local labels = {
        {Name = "cheat name at bottom", Text = "Hexulon", Position = UDim2.new(0.08419, 0, 0.94198, 0), Size = UDim2.new(0, 60, 0, 35)},
        {Name = "Build", Text = "Build", Position = UDim2.new(0.01998, 0, 0.94198, 0), Size = UDim2.new(0, 35, 0, 35), TextColor = Color3.fromRGB(91, 91, 91)},
        {Name = "|", Text = "|", Position = UDim2.new(0.16743, 0, 0.94198, 0), Size = UDim2.new(0, 100, 0, 35)},
        {Name = "discord.gg/", Text = "discord.gg/", Position = UDim2.new(0.18407, 0, 0.94198, 0), Size = UDim2.new(0, 80, 0, 35)},
        {Name = "Autor", Text = "pillsnkodeine", Position = UDim2.new(0.88086, 0, 0.94198, 0), Size = UDim2.new(0, 100, 0, 35)}
    }
    
    for _, label in ipairs(labels) do
        local lbl = Instance.new("TextLabel")
        lbl.Parent = self.MainFrame
        lbl.BorderSizePixel = 0
        lbl.TextSize = 20
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        lbl.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        lbl.TextColor3 = label.TextColor or Color3.fromRGB(181, 106, 136)
        lbl.BackgroundTransparency = 1
        lbl.Size = label.Size
        lbl.Position = label.Position
        lbl.Text = label.Text
        lbl.Name = label.Name
    end
    
    -- Top Label
    local topNameLabel = Instance.new("TextLabel")
    topNameLabel.Parent = self.MainFrame
    topNameLabel.BorderSizePixel = 0
    topNameLabel.TextSize = 20
    topNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    topNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    topNameLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    topNameLabel.TextColor3 = Color3.fromRGB(181, 106, 136)
    topNameLabel.BackgroundTransparency = 1
    topNameLabel.Size = UDim2.new(0, 100, 0, 35)
    topNameLabel.Position = UDim2.new(0.01998, 0, -0.00683, 0)
    topNameLabel.Name = "cheat name at top"
    
    self.Tabs = {}
    self.TabButtons = {}
    self.CurrentTab = nil
    self.ElementYOffsets = {} -- Tracks Y offset for elements per tab
    
    -- Initialize default tabs
    self:NewTab("Aimbot")
    self:NewTab("Visuals")
    
    -- Add default elements to Aimbot tab
    local aimbotTab = self.Tabs.AIMBOT
    self:NewCheckbox(aimbotTab, "Enabled")
    self:NewCheckbox(aimbotTab, "Enabled")
    self:NewCheckbox(aimbotTab, "Enabled")
    self:NewDropdown(aimbotTab, "Aimbot Type", {"Camera", "Mouse"})
    self:NewSlider(aimbotTab, "Camera Smoothing", 0.45)
    self:NewSlider(aimbotTab, "Sensitivity", 1.00)
    self:NewSlider(aimbotTab, "FOV", 1.00)
    
    return self
end

-- Create a new tab
function HexulonLib:NewTab(tabName)
    local tabFrame = Instance.new("Frame")
    tabFrame.Parent = self.MainFrame
    tabFrame.BorderSizePixel = 0
    tabFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tabFrame.Size = UDim2.new(0, 840, 0, 545)
    tabFrame.Position = UDim2.new(0, 0, 0.06826, 0)
    tabFrame.Name = tabName .. " tab"
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    
    -- Tab Button
    local tabButton = Instance.new("TextButton")
    tabButton.Parent = self.MainFrame
    tabButton.BorderSizePixel = 0
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    tabButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    tabButton.BackgroundTransparency = 1
    tabButton.Size = UDim2.new(0, 80, 0, 25)
    tabButton.Position = UDim2.new(0.18354 + (#self.Tabs * 0.098), 0, 0.015, 0)
    tabButton.Text = ""
    tabButton.Name = tabName:upper()
    
    local tabLabel = Instance.new("TextLabel")
    tabLabel.Parent = tabButton
    tabLabel.BorderSizePixel = 0
    tabLabel.TextSize = 20
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    tabLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    tabLabel.TextColor3 = textBaseColor
    tabLabel.BackgroundTransparency = 1
    tabLabel.Size = UDim2.new(0, 50, 0, 50)
    tabLabel.Position = UDim2.new(0.1674, 0, -0.52, 0)
    tabLabel.Text = tabName
    tabLabel.Name = tabName
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.Parent = tabButton
    
    -- Tab Content (Tab 1)
    local contentFrame = Instance.new("Frame")
    contentFrame.Parent = tabFrame
    contentFrame.BorderSizePixel = 0
    contentFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    contentFrame.Size = UDim2.new(0, 325, 0, 480)
    contentFrame.Position = UDim2.new(0.195, 0, 0.03, 0)
    contentFrame.Name = "Tab 1"
    
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Parent = contentFrame
    contentLabel.BorderSizePixel = 0
    contentLabel.TextSize = 20
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    contentLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    contentLabel.TextColor3 = Color3.fromRGB(71, 71, 71)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Size = UDim2.new(0, 80, 0, 50)
    contentLabel.Position = UDim2.new(0.025, 0, -0.02, 0)
    contentLabel.Text = "Main group"
    
    local contentStroke = Instance.new("UIStroke")
    contentStroke.Parent = contentFrame
    contentStroke.Color = Color3.fromRGB(26, 26, 26)
    
    -- Tab Content (Tab 2)
    local tabTwoFrame = Instance.new("Frame")
    tabTwoFrame.Parent = tabFrame
    tabTwoFrame.BorderSizePixel = 0
    tabTwoFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    tabTwoFrame.Size = UDim2.new(0, 325, 0, 480)
    tabTwoFrame.Position = UDim2.new(0.6, 0, 0.03, 0)
    tabTwoFrame.Name = "Tab 2"
    
    local tabTwoLabel = Instance.new("TextLabel")
    tabTwoLabel.Parent = tabTwoFrame
    tabTwoLabel.BorderSizePixel = 0
    tabTwoLabel.TextSize = 20
    tabTwoLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabTwoLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabTwoLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    tabTwoLabel.TextColor3 = Color3.fromRGB(71, 71, 71)
    tabTwoLabel.BackgroundTransparency = 1
    tabTwoLabel.Size = UDim2.new(0, 80, 0, 50)
    tabTwoLabel.Position = UDim2.new(0.025, 0, -0.02, 0)
    tabTwoLabel.Text = "Modifiers"
    
    local tabTwoStroke = Instance.new("UIStroke")
    tabTwoStroke.Parent = tabTwoFrame
    tabTwoStroke.Color = Color3.fromRGB(26, 26, 26)
    
    -- Section Panel
    local sectionPanelFrame = Instance.new("Frame")
    sectionPanelFrame.Parent = tabFrame
    sectionPanelFrame.BorderSizePixel = 0
    sectionPanelFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    sectionPanelFrame.Size = UDim2.new(0, 140, 0, 480)
    sectionPanelFrame.Position = UDim2.new(0.012, 0, 0.03, 0)
    sectionPanelFrame.Name = "Section"
    
    local sectionPanelStroke = Instance.new("UIStroke")
    sectionPanelStroke.Parent = sectionPanelFrame
    sectionPanelStroke.Color = Color3.fromRGB(26, 26, 26)
    
    local generalButton = Instance.new("TextButton")
    generalButton.Parent = sectionPanelFrame
    generalButton.BorderSizePixel = 0
    generalButton.TextSize = 14
    generalButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    generalButton.BackgroundColor3 = baseColor
    generalButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    generalButton.BackgroundTransparency = 1
    generalButton.Size = UDim2.new(0, 100, 0, 40)
    generalButton.Position = UDim2.new(0.145, 0, 0.03, 0)
    generalButton.Text = ""
    generalButton.Name = "General"
    
    local generalLabel = Instance.new("TextLabel")
    generalLabel.Parent = generalButton
    generalLabel.BorderSizePixel = 0
    generalLabel.TextSize = 20
    generalLabel.TextXAlignment = Enum.TextXAlignment.Left
    generalLabel.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    generalLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    generalLabel.TextColor3 = textBaseColor
    generalLabel.BackgroundTransparency = 1
    generalLabel.Size = UDim2.new(0, 50, 0, 50)
    generalLabel.Position = UDim2.new(0.1105, 0, -0.13333, 0)
    generalLabel.Text = "General"
    
    -- Tab switching logic
    local function makeLeftBar(button)
        local existing = button:FindFirstChild("LeftBar")
        if existing then return existing end
        local leftBar = Instance.new("Frame")
        leftBar.Name = "LeftBar"
        leftBar.Size = UDim2.new(0, 2, 0.5, 0)
        leftBar.Position = UDim2.new(0, 0, 0.25, 0)
        leftBar.BackgroundColor3 = highlightColor
        leftBar.BackgroundTransparency = 1
        leftBar.BorderSizePixel = 0
        leftBar.ZIndex = 2
        leftBar.Parent = button
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 2)
        corner.Parent = leftBar
        return leftBar
    end
    
    local function resetVisuals(button)
        t(button, {BackgroundColor3 = baseColor})
        t(tabLabel, {TextColor3 = textBaseColor})
        local bar = makeLeftBar(button)
        t(bar, {BackgroundTransparency = 1})
    end
    
    local function highlightVisuals(button)
        t(button, {BackgroundColor3 = baseColor})
        t(tabLabel, {TextColor3 = highlightColor})
        local bar = makeLeftBar(button)
        t(bar, {BackgroundTransparency = 0})
    end
    
    tabButton.AutoButtonColor = false
    tabButton.BackgroundColor3 = baseColor
    makeLeftBar(tabButton)
    
    tabButton.MouseButton1Click:Connect(function()
        if self.CurrentTab and self.CurrentTab ~= tabButton then
            resetVisuals(self.CurrentTab)
            self.Tabs[self.CurrentTab.Name].Visible = false
        end
        self.CurrentTab = tabButton
        highlightVisuals(tabButton)
        tabFrame.Visible = true
    end)
    
    -- Section logic
    local function runSectionLogic()
        local buttons = {generalButton}
        local lastButton = generalButton
        highlightVisuals(generalButton)
        
        for _, button in ipairs(buttons) do
            button.MouseButton1Click:Connect(function()
                if lastButton and lastButton ~= button then
                    resetVisuals(lastButton)
                end
                lastButton = button
                highlightVisuals(button)
            end)
        end
    end
    
    task.spawn(runSectionLogic)
    
    self.Tabs[tabButton.Name] = tabFrame
    self.TabButtons[tabButton.Name] = tabButton
    self.ElementYOffsets[tabName] = 55
    
    if not self.CurrentTab then
        self.CurrentTab = tabButton
        highlightVisuals(tabButton)
        tabFrame.Visible = true
    end
    
    return tabFrame
end

-- Create a checkbox
function HexulonLib:NewCheckbox(tabFrame, labelText)
    local tabName = tabFrame.Name:gsub(" tab$", "")
    local yOffset = self.ElementYOffsets[tabName] or 55
    local startX = 20
    local boxSize = 10
    local spacingY = 30
    
    local box = Instance.new("TextButton")
    box.Name = "Checkbox_" .. tostring(yOffset)
    box.Parent = tabFrame:FindFirstChild("Tab 1")
    box.AutoButtonColor = false
    box.BackgroundColor3 = disabledBoxColor
    box.BorderSizePixel = 0
    box.Size = UDim2.new(0, boxSize, 0, boxSize)
    box.Position = UDim2.new(0, startX, 0, yOffset)
    box.Text = ""
    box.ZIndex = 5
    
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0, 2)
    
    local boxStroke = Instance.new("UIStroke", box)
    boxStroke.Thickness = 1.2
    boxStroke.Color = enabledBoxColor
    boxStroke.Transparency = 1
    
    local label = Instance.new("TextButton")
    label.Name = "CheckboxLabel_" .. tostring(yOffset)
    label.Parent = tabFrame:FindFirstChild("Tab 1")
    label.AutoButtonColor = false
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Text = labelText or "Enabled"
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = disabledTextColor
    label.Size = UDim2.new(0, 80, 0, 18)
    label.Position = UDim2.new(0, startX + boxSize + 8, 0, yOffset - 3)
    label.ZIndex = 5
    
    local entry = { box = box, label = label, state = false, stroke = boxStroke }
    
    local function setCheckboxVisual(on, instant)
        if on then
            if instant then
                box.BackgroundColor3 = enabledBoxColor
                label.TextColor3 = enabledTextColor
                boxStroke.Transparency = 0
            else
                t(box, { BackgroundColor3 = enabledBoxColor })
                t(label, { TextColor3 = enabledTextColor })
                t(boxStroke, { Transparency = 0 })
            end
        else
            if instant then
                box.BackgroundColor3 = disabledBoxColor
                label.TextColor3 = disabledTextColor
                boxStroke.Transparency = 1
            else
                t(box, { BackgroundColor3 = disabledBoxColor })
                t(label, { TextColor3 = disabledTextColor })
                t(boxStroke, { Transparency = 1 })
            end
        end
    end
    
    local function toggle()
        entry.state = not entry.state
        setCheckboxVisual(entry.state, false)
    end
    
    box.MouseButton1Click:Connect(toggle)
    label.MouseButton1Click:Connect(toggle)
    setCheckboxVisual(false, true)
    
    self.ElementYOffsets[tabName] = yOffset + spacingY
    return entry
end

-- Create a dropdown
function HexulonLib:NewDropdown(tabFrame, labelText, options)
    local tabName = tabFrame.Name:gsub(" tab$", "")
    local yOffset = self.ElementYOffsets[tabName] or 55
    local startX = 20
    local spacingY = 40
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Parent = tabFrame:FindFirstChild("Tab 2")
    dropdownButton.BorderSizePixel = 0
    dropdownButton.TextSize = 14
    dropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    dropdownButton.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    dropdownButton.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    dropdownButton.Size = UDim2.new(0, 260, 0, 25)
    dropdownButton.Position = UDim2.new(0.105, 0, 0, yOffset)
    dropdownButton.Text = ""
    dropdownButton.Name = "dropdown_" .. tostring(yOffset)
    
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Parent = tabFrame:FindFirstChild("Tab 2")
    dropdownLabel.BorderSizePixel = 0
    dropdownLabel.TextSize = 20
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    dropdownLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    dropdownLabel.TextColor3 = Color3.fromRGB(66, 66, 66)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.Size = UDim2.new(0, 90, 0, 50)
    dropdownLabel.Position = UDim2.new(0.1, 0, 0, yOffset - 30)
    dropdownLabel.Text = labelText or "Dropdown"
    
    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Parent = dropdownButton
    selectedLabel.BorderSizePixel = 0
    selectedLabel.TextSize = 20
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    selectedLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    selectedLabel.TextColor3 = Color3.fromRGB(66, 66, 66)
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.Size = UDim2.new(0, 40, 0, 50)
    selectedLabel.Position = UDim2.new(0, 5, -0.53, 0)
    selectedLabel.Text = "None"
    selectedLabel.Name = "SelectedLabel"
    
    local dropdownUICorner = Instance.new("UICorner")
    dropdownUICorner.Parent = dropdownButton
    dropdownUICorner.CornerRadius = UDim.new(0, 3)
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Parent = dropdownButton
    menuFrame.Visible = false
    menuFrame.BorderSizePixel = 0
    menuFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    menuFrame.Size = UDim2.new(0, 260, 0, 0)
    menuFrame.Position = UDim2.new(0, 0, 1.06818, 0)
    menuFrame.Name = "menu"
    menuFrame.ClipsDescendants = true
    
    local menuListLayout = Instance.new("UIListLayout")
    menuListLayout.Parent = menuFrame
    menuListLayout.Padding = UDim.new(0, 3)
    menuListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    for i, optionText in ipairs(options or {"Select 1", "Select 2"}) do
        local option = Instance.new("TextButton")
        option.Parent = menuFrame
        option.BorderSizePixel = 0
        option.TextSize = 20
        option.TextColor3 = Color3.fromRGB(96, 96, 96)
        option.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        option.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        option.Size = UDim2.new(0, 260, 0, 20)
        option.Position = UDim2.new(0, 0, 0, (i-1) * 23)
        option.Text = optionText
        option.Name = optionText
        option.BackgroundTransparency = 1
        
        local optionCorner = Instance.new("UICorner")
        optionCorner.Parent = option
        optionCorner.CornerRadius = UDim.new(0, 6)
    end
    
    local openState = false
    local openTween = TweenService:Create(menuFrame, tweenInfo, { Size = UDim2.new(0, 260, 0, #options * 23) })
    local closeTween = TweenService:Create(menuFrame, tweenInfo, { Size = UDim2.new(1, 0, 0, 0) })
    
    dropdownButton.MouseButton1Click:Connect(function()
        openState = not openState
        if openState then
            menuFrame.Visible = true
            openTween:Play()
        else
            closeTween:Play()
            task.delay(tweenInfo.Time, function() menuFrame.Visible = false end)
        end
    end)
    
    for _, option in ipairs(menuFrame:GetChildren()) do
        if option:IsA("TextButton") then
            option.MouseButton1Click:Connect(function()
                selectedLabel.Text = option.Text
                openState = false
                closeTween:Play()
                task.delay(tweenInfo.Time, function() menuFrame.Visible = false end)
            end)
        end
    end
    
    self.ElementYOffsets[tabName] = yOffset + spacingY + (#options * 23)
    return dropdownButton
end

-- Create a slider
function HexulonLib:NewSlider(parent, nameText, initialPercent)
    local tabName = parent.Name:gsub(" tab$", "")
    local yOffset = self.ElementYOffsets[tabName] or 55
    local barWidth = 250
    local barHeight = 6
    local value = math.clamp(initialPercent or 0, 0, 1)
    local baseTextColor = Color3.fromRGB(66, 66, 66)
    local hoverTextColor = Color3.fromRGB(255, 255, 255)
    local tweenTime = 0.25
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = parent:FindFirstChild("Tab 2")
    nameLabel.AnchorPoint = Vector2.new(0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Size = UDim2.new(0, 170, 0, 26)
    nameLabel.Position = UDim2.new(0.1, 0, 0, yOffset - 30)
    nameLabel.Text = nameText
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextSize = 20
    nameLabel.Font = Enum.Font.SourceSans
    nameLabel.TextColor3 = baseTextColor
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Parent = parent:FindFirstChild("Tab 2")
    valueLabel.BackgroundTransparency = 1
    valueLabel.Size = UDim2.new(0, 52, 0, 26)
    valueLabel.AnchorPoint = Vector2.new(1, 0)
    valueLabel.Position = UDim2.new(0.1, barWidth, 0, yOffset - 25)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.TextSize = 20
    valueLabel.Font = Enum.Font.SourceSans
    valueLabel.TextColor3 = baseTextColor
    valueLabel.Text = tostring(math.floor(value * 100))
    
    local barBack = Instance.new("Frame")
    barBack.Parent = parent:FindFirstChild("Tab 2")
    barBack.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    barBack.BorderSizePixel = 0
    barBack.Size = UDim2.new(0, barWidth, 0, barHeight)
    barBack.Position = UDim2.new(0.1, 0, 0, yOffset)
    
    local barCorner = Instance.new("UICorner", barBack)
    barCorner.CornerRadius = UDim.new(0, 3)
    
    local fill = Instance.new("Frame")
    fill.Parent = barBack
    fill.BackgroundColor3 = highlightColor
    fill.BorderSizePixel = 0
    fill.Size = UDim2.new(value, 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    
    local fillCorner = Instance.new("UICorner", fill)
    fillCorner.CornerRadius = UDim.new(0, 3)
    
    local dragging = false
    local conn
    
    local function setHoverActive(active)
        local target = active and hoverTextColor or baseTextColor
        t(nameLabel, { TextColor3 = target })
        t(valueLabel, { TextColor3 = target })
    end
    
    local function updateFromX(px)
        local barPosX = barBack.AbsolutePosition.X
        local barSizeX = barBack.AbsoluteSize.X
        if barSizeX <= 0 then return end
        local relative = (px - barPosX) / barSizeX
        relative = math.clamp(relative, 0, 1)
        value = relative
        fill.Size = UDim2.new(value, 0, 1, 0)
        valueLabel.Text = tostring(math.floor(value * 100))
    end
    
    barBack.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            if input.Position then updateFromX(input.Position.X) end
            setHoverActive(true)
        end
    end)
    
    parent.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mouseX, mouseY = input.Position.X, input.Position.Y
            local absPos = barBack.AbsolutePosition
            local absSize = barBack.AbsoluteSize
            if mouseX >= absPos.X and mouseX <= absPos.X + absSize.X and mouseY >= absPos.Y and mouseY <= absPos.Y + absSize.Y then
                dragging = true
                updateFromX(mouseX)
                setHoverActive(true)
            end
        end
    end)
    
    conn = UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromX(input.Position.X)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if dragging then
                dragging = false
                setHoverActive(false)
            end
        end
    end)
    
    self.ElementYOffsets[tabName] = yOffset + 40
    return { GetValue = function() return value end, SetValue = function(v) value = math.clamp(v, 0, 1) fill.Size = UDim2.new(value, 0, 1, 0) valueLabel.Text = tostring(math.floor(value * 100)) end }
end

-- Initialize GUI
local Window = HexulonLib.new()
return Window
