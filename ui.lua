-- gui.lua
-- Hexulon GUI Library
local Library = {}
Library.Flags = {} -- Tabla global para guardar estados de elementos

-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Función para crear la ventana principal
function Library:CreateWindow(title)
    local Window = {}
    
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HexulonGUI"
    screenGui.Parent = playerGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
    mainFrame.Parent = screenGui
    mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
    mainFrame.ClipsDescendants = true

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1,0,0,40)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.TextSize = 20
    titleLabel.Parent = mainFrame

    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1,0,1,-40)
    tabContainer.Position = UDim2.new(0,0,0,40)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    -- Tab buttons
    local tabButtonsFrame = Instance.new("Frame")
    tabButtonsFrame.Size = UDim2.new(1,0,0,30)
    tabButtonsFrame.BackgroundTransparency = 1
    tabButtonsFrame.Position = UDim2.new(0,0,0,0)
    tabButtonsFrame.Parent = tabContainer

    local tabList = {}
    local currentTab

    -- Función para crear nuevas pestañas
    function Window:NewTab(tabName)
        local Tab = {}

        -- Botón de tab
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(0,100,1,0)
        tabButton.Text = tabName
        tabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
        tabButton.TextColor3 = Color3.fromRGB(255,255,255)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.TextSize = 16
        tabButton.Parent = tabButtonsFrame

        -- ScrollingFrame para contenido
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1,0,1,-30)
        scrollFrame.Position = UDim2.new(0,0,0,30)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
        scrollFrame.ScrollBarThickness = 6
        scrollFrame.Parent = tabContainer
        scrollFrame.Visible = false

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0,5)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = scrollFrame

        -- Cambiar tab al hacer click
        tabButton.MouseButton1Click:Connect(function()
            for _,t in pairs(tabList) do
                t.Scroll.Visible = false
            end
            scrollFrame.Visible = true
            currentTab = Tab
        end)

        Tab.Scroll = scrollFrame

        -- Función genérica para crear elementos
        local function createElement(type, label, ...)
            if type == "Checkbox" then
                local default, callback = ...
                Library.Flags[label] = default or false

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,25)
                frame.BackgroundTransparency = 1
                frame.Parent = scrollFrame

                local box = Instance.new("TextButton")
                box.Size = UDim2.new(0,20,1,0)
                box.BackgroundColor3 = Color3.fromRGB(80,80,80)
                box.Position = UDim2.new(0,0,0,0)
                box.Text = ""
                box.Parent = frame

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = label
                textLabel.Size = UDim2.new(1,-25,1,0)
                textLabel.Position = UDim2.new(0,25,0,0)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.fromRGB(255,255,255)
                textLabel.Font = Enum.Font.SourceSans
                textLabel.TextSize = 16
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.Parent = frame

                local function update()
                    if Library.Flags[label] then
                        box.BackgroundColor3 = Color3.fromRGB(0,170,255)
                    else
                        box.BackgroundColor3 = Color3.fromRGB(80,80,80)
                    end
                end

                update()

                box.MouseButton1Click:Connect(function()
                    Library.Flags[label] = not Library.Flags[label]
                    update()
                    if callback then callback(Library.Flags[label]) end
                end)
            elseif type == "Slider" then
                local min, max, default, callback = ...
                Library.Flags[label] = default or min

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,25)
                frame.BackgroundTransparency = 1
                frame.Parent = scrollFrame

                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1,0,0,6)
                bar.Position = UDim2.new(0,0,0.5,-3)
                bar.BackgroundColor3 = Color3.fromRGB(80,80,80)
                bar.Parent = frame

                local fill = Instance.new("Frame")
                fill.Size = UDim2.new((Library.Flags[label]-min)/(max-min),0,1,0)
                fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
                fill.Parent = bar

                local textLabel = Instance.new("TextLabel")
                textLabel.Text = label.." : "..Library.Flags[label]
                textLabel.Size = UDim2.new(1,0,0,25)
                textLabel.BackgroundTransparency = 1
                textLabel.TextColor3 = Color3.fromRGB(255,255,255)
                textLabel.Font = Enum.Font.SourceSans
                textLabel.TextSize = 16
                textLabel.TextXAlignment = Enum.TextXAlignment.Left
                textLabel.Parent = frame

                local dragging = false
                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local relative = math.clamp((input.Position.X - bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
                        Library.Flags[label] = math.floor(min + (max-min)*relative)
                        fill.Size = UDim2.new(relative,0,1,0)
                        textLabel.Text = label.." : "..Library.Flags[label]
                        if callback then callback(Library.Flags[label]) end
                    end
                end)
            elseif type == "Dropdown" then
                local options, callback = ...
                Library.Flags[label] = options[1]

                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1,0,0,25)
                frame.BackgroundTransparency = 1
                frame.Parent = scrollFrame

                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1,0,1,0)
                button.Text = label.." : "..Library.Flags[label]
                button.BackgroundColor3 = Color3.fromRGB(80,80,80)
                button.TextColor3 = Color3.fromRGB(255,255,255)
                button.Font = Enum.Font.SourceSans
                button.TextSize = 16
                button.Parent = frame

                local dropdownFrame = Instance.new("Frame")
                dropdownFrame.Size = UDim2.new(1,0,0,#options*25)
                dropdownFrame.Position = UDim2.new(0,0,1,0)
                dropdownFrame.BackgroundColor3 = Color3.fromRGB(50,50,50)
                dropdownFrame.Visible = false
                dropdownFrame.Parent = frame

                for i,opt in ipairs(options) do
                    local optButton = Instance.new("TextButton")
                    optButton.Size = UDim2.new(1,0,0,25)
                    optButton.Position = UDim2.new(0,0,0,(i-1)*25)
                    optButton.Text = opt
                    optButton.BackgroundColor3 = Color3.fromRGB(80,80,80)
                    optButton.TextColor3 = Color3.fromRGB(255,255,255)
                    optButton.Font = Enum.Font.SourceSans
                    optButton.TextSize = 16
                    optButton.Parent = dropdownFrame

                    optButton.MouseButton1Click:Connect(function()
                        Library.Flags[label] = opt
                        button.Text = label.." : "..opt
                        dropdownFrame.Visible = false
                        if callback then callback(opt) end
                    end)
                end

                button.MouseButton1Click:Connect(function()
                    dropdownFrame.Visible = not dropdownFrame.Visible
                end)
            end
        end

        -- Funciones públicas para cada tipo
        function Tab:CreateCheckbox(label, default, callback)
            createElement("Checkbox", label, default, callback)
        end
        function Tab:CreateSlider(label, min, max, default, callback)
            createElement("Slider", label, min, max, default, callback)
        end
        function Tab:CreateDropdown(label, options, callback)
            createElement("Dropdown", label, options, callback)
        end

        table.insert(tabList, Tab)
        if #tabList == 1 then
            tabButton:MouseButton1Click()
        end

        return Tab
    end

    return Window
end

return Library
