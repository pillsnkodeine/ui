local Library = {}

function Library:CreateGUI(name)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local playerGui = localPlayer:WaitForChild("PlayerGui")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name or "Hexulon GUI"
    screenGui.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 800, 0, 500)
    mainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    mainFrame.Parent = screenGui

    local window = {
        Gui = screenGui,
        Main = mainFrame,
        Tabs = {}
    }

    function window:NewTab(tabName)
        local tab = {}
        tab.Name = tabName

        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, -30)
        tabFrame.Position = UDim2.new(0, 0, 0, 30)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = mainFrame
        tab.Frame = tabFrame

        -- Ordenar hijos
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = tabFrame

        function tab:Show()
            for _, t in pairs(window.Tabs) do
                t.Frame.Visible = false
            end
            tabFrame.Visible = true
        end

        function tab:SetName(newName)
            tab.Name = newName
            button.Text = newName
        end

        function tab:CreateCheckbox(text)
            local cb = Instance.new("TextButton")
            cb.Size = UDim2.new(0, 200, 0, 25)
            cb.BackgroundColor3 = Color3.fromRGB(30,30,30)
            cb.Text = "[ ] " .. text
            cb.TextColor3 = Color3.fromRGB(200,200,200)
            cb.Parent = tabFrame

            local state = false
            cb.MouseButton1Click:Connect(function()
                state = not state
                cb.Text = (state and "[X] " or "[ ] ") .. text
            end)
            return cb
        end

        function tab:CreateDropdown(label, options)
            local dd = Instance.new("TextButton")
            dd.Size = UDim2.new(0, 200, 0, 25)
            dd.BackgroundColor3 = Color3.fromRGB(40,40,40)
            dd.Text = label .. ": None"
            dd.TextColor3 = Color3.fromRGB(200,200,200)
            dd.Parent = tabFrame

            dd.MouseButton1Click:Connect(function()
                -- aquí puedes abrir un menú de opciones
                dd.Text = label .. ": " .. options[1]
            end)

            return dd
        end

        function tab:CreateSlider(label, min, max, default)
            local slider = Instance.new("TextLabel")
            slider.Size = UDim2.new(0, 200, 0, 25)
            slider.BackgroundColor3 = Color3.fromRGB(50,50,50)
            slider.Text = label .. ": " .. tostring(default)
            slider.TextColor3 = Color3.fromRGB(200,200,200)
            slider.Parent = tabFrame
            return slider
        end

        -- Crear botón para este tab
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0, 100, 0, 25)
        button.Position = UDim2.new(0, #window.Tabs * 110, 0, 0)
        button.BackgroundColor3 = Color3.fromRGB(25,25,25)
        button.TextColor3 = Color3.fromRGB(200,200,200)
        button.Text = tabName
        button.Parent = mainFrame

        button.MouseButton1Click:Connect(function()
            tab:Show()
        end)

        table.insert(window.Tabs, tab)
        return tab
    end

    return window
end

return Library
