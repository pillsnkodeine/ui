-- Servicios
local PlayersService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- Variables principales
local localPlayer = PlayersService.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Framework GUI
local Hexulon = {}
Hexulon.__index = Hexulon

-- Función para cargar desde GitHub
function Hexulon:LoadFromGitHub(url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        return loadstring(result)()
    else
        warn("Error al cargar desde GitHub: " .. result)
        return nil
    end
end

-- Crear nueva instancia de GUI
function Hexulon.new()
    local self = setmetatable({}, Hexulon)
    
    -- Crear GUI principal
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "Hexulon GUI"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    
    -- Frame principal
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Parent = self.ScreenGui
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 11)
    self.MainFrame.Size = UDim2.new(0, 840, 0, 586)
    self.MainFrame.Position = UDim2.new(0.16612, 0, 0.13557, 0)
    self.MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    self.MainFrame.Name = "GUI"
    
    -- Tabs container (para cambiar entre tabs)
    self.TabsContainer = Instance.new("Frame")
    self.TabsContainer.Parent = self.MainFrame
    self.TabsContainer.BorderSizePixel = 0
    self.TabsContainer.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    self.TabsContainer.Size = UDim2.new(0, 840, 0, 545)
    self.TabsContainer.Position = UDim2.new(0, 0, 0.06826, 0)
    self.TabsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
    self.TabsContainer.Name = "TabsContainer"
    self.TabsContainer.BackgroundTransparency = 1
    
    -- Barra de tabs (botones para cambiar entre tabs)
    self.TabsBar = Instance.new("Frame")
    self.TabsBar.Parent = self.MainFrame
    self.TabsBar.BorderSizePixel = 0
    self.TabsBar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    self.TabsBar.Size = UDim2.new(0, 140, 0, 480)
    self.TabsBar.Position = UDim2.new(0.012, 0, 0.03, 0)
    self.TabsBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
    self.TabsBar.Name = "TabsBar"
    
    local tabBarStroke = Instance.new("UIStroke")
    tabBarStroke.Parent = self.TabsBar
    tabBarStroke.Color = Color3.fromRGB(26, 26, 26)
    
    -- Lista para tabs
    self.TabsListLayout = Instance.new("UIListLayout")
    self.TabsListLayout.Parent = self.TabsBar
    self.TabsListLayout.Padding = UDim.new(0, 5)
    self.TabsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    -- Almacenar tabs y elementos
    self.Tabs = {}
    self.CurrentTab = nil
    
    -- Configurar elementos de la interfaz (footer, etc.)
    self:SetupInterface()
    
    return self
end

-- Configurar elementos de la interfaz
function Hexulon:SetupInterface()
    -- (Aquí iría el código para crear el footer, separadores, etc.
    -- Similar al código original pero adaptado para la estructura de clases)
    
    -- Separador
    local separatorFrame = Instance.new("Frame")
    separatorFrame.Parent = self.MainFrame
    separatorFrame.BorderSizePixel = 0
    separatorFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    separatorFrame.Size = UDim2.new(0, 840, 0, 1)
    separatorFrame.Position = UDim2.new(0, 0, 0.94, 0)
    separatorFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    separatorFrame.Name = "separator"
    
    -- Footer labels
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Parent = self.MainFrame
    discordLabel.BorderSizePixel = 0
    discordLabel.TextSize = 20
    discordLabel.TextXAlignment = Enum.TextXAlignment.Left
    discordLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    discordLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    discordLabel.TextColor3 = Color3.fromRGB(181, 106, 136)
    discordLabel.BackgroundTransparency = 1
    discordLabel.Size = UDim2.new(0, 80, 0, 35)
    discordLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    discordLabel.Text = "discord.gg/"
    discordLabel.Name = "discord.gg/"
    discordLabel.Position = UDim2.new(0.18407, 0, 0.94198, 0)
    
    -- ... (otros elementos del footer)
end

-- Crear una nueva tab
function Hexulon:NewTab(tabName)
    local tab = {}
    tab.Name = tabName
    tab.Id = HttpService:GenerateGUID(false)
    
    -- Crear frame para la tab
    tab.Frame = Instance.new("Frame")
    tab.Frame.Parent = self.TabsContainer
    tab.Frame.BorderSizePixel = 0
    tab.Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    tab.Frame.Size = UDim2.new(0, 840, 0, 545)
    tab.Frame.Position = UDim2.new(0, 0, 0, 0)
    tab.Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tab.Frame.Name = tabName .. " Tab"
    tab.Frame.BackgroundTransparency = 1
    tab.Frame.Visible = false
    
    -- Crear botón para la tab en la barra
    tab.Button = Instance.new("TextButton")
    tab.Button.Parent = self.TabsBar
    tab.Button.BorderSizePixel = 0
    tab.Button.TextSize = 14
    tab.Button.TextColor3 = Color3.fromRGB(0, 0, 0)
    tab.Button.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    tab.Button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    tab.Button.BackgroundTransparency = 1
    tab.Button.Size = UDim2.new(0, 100, 0, 40)
    tab.Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tab.Button.Text = ""
    tab.Button.Name = tabName
    tab.Button.LayoutOrder = #self.Tabs + 1
    
    local tabLabel = Instance.new("TextLabel")
    tabLabel.Parent = tab.Button
    tabLabel.BorderSizePixel = 0
    tabLabel.TextSize = 20
    tabLabel.TextXAlignment = Enum.TextXAlignment.Left
    tabLabel.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    tabLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    tabLabel.TextColor3 = Color3.fromRGB(71, 71, 71)
    tabLabel.BackgroundTransparency = 1
    tabLabel.Size = UDim2.new(0, 100, 0, 40)
    tabLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabLabel.Text = tabName
    tabLabel.Name = "Label"
    tabLabel.Position = UDim2.new(0.1, 0, 0, 0)
    
    -- Barra lateral para indicar tab seleccionada
    local leftBar = Instance.new("Frame")
    leftBar.Name = "LeftBar"
    leftBar.Size = UDim2.new(0, 2, 0.5, 0)
    leftBar.Position = UDim2.new(0, 0, 0.25, 0)
    leftBar.BackgroundColor3 = Color3.fromRGB(180, 105, 135)
    leftBar.BackgroundTransparency = 1
    leftBar.BorderSizePixel = 0
    leftBar.ZIndex = 2
    leftBar.Parent = tab.Button
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 2)
    corner.Parent = leftBar
    
    -- Configurar evento de clic
    tab.Button.MouseButton1Click:Connect(function()
        self:SwitchTab(tab.Id)
    end)
    
    -- Almacenar la tab
    self.Tabs[tab.Id] = tab
    
    -- Si es la primera tab, hacerla visible
    if #self.Tabs == 1 then
        self:SwitchTab(tab.Id)
    end
    
    -- Devolver objeto tab para añadir elementos
    return setmetatable({
        AddCheckbox = function(displayName, defaultValue, callback)
            return self:AddCheckbox(tab, displayName, defaultValue, callback)
        end,
        AddDropdown = function(displayName, options, defaultOption, callback)
            return self:AddDropdown(tab, displayName, options, defaultOption, callback)
        end,
        AddSlider = function(displayName, minValue, maxValue, defaultValue, callback)
            return self:AddSlider(tab, displayName, minValue, maxValue, defaultValue, callback)
        end,
        -- Más métodos para añadir otros elementos...
    }, {
        __index = function(_, key)
            error("Método " .. key .. " no está disponible para Tab")
        end
    })
end

-- Cambiar entre tabs
function Hexulon:SwitchTab(tabId)
    -- Ocultar todas las tabs
    for id, tab in pairs(self.Tabs) do
        tab.Frame.Visible = false
        
        -- Restablecer apariencia de todos los botones
        if tab.Button then
            TweenService:Create(tab.Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(17, 17, 17)}):Play()
            
            local label = tab.Button:FindFirstChild("Label")
            if label then
                TweenService:Create(label, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(71, 71, 71)}):Play()
            end
            
            local leftBar = tab.Button:FindFirstChild("LeftBar")
            if leftBar then
                TweenService:Create(leftBar, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
            end
        end
    end
    
    -- Mostrar la tab seleccionada
    if self.Tabs[tabId] then
        self.Tabs[tabId].Frame.Visible = true
        self.CurrentTab = self.Tabs[tabId]
        
        -- Resaltar botón de la tab seleccionada
        if self.Tabs[tabId].Button then
            TweenService:Create(self.Tabs[tabId].Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(16, 16, 16)}):Play()
            
            local label = self.Tabs[tabId].Button:FindFirstChild("Label")
            if label then
                TweenService:Create(label, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(180, 105, 135)}):Play()
            end
            
            local leftBar = self.Tabs[tabId].Button:FindFirstChild("LeftBar")
            if leftBar then
                TweenService:Create(leftBar, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
            end
        end
    end
end

-- Añadir checkbox a una tab
function Hexulon:AddCheckbox(tab, displayName, defaultValue, callback)
    -- Implementar lógica para crear checkbox
    -- Similar al código original pero adaptado
    
    local checkbox = {}
    checkbox.Value = defaultValue or false
    
    -- Crear elementos visuales del checkbox
    local container = Instance.new("Frame")
    container.Parent = tab.Frame
    container.BackgroundTransparency = 1
    container.Size = UDim2.new(0, 300, 0, 20)
    container.Position = UDim2.new(0.1, 0, 0.1 + (#tab.Frame:GetChildren() * 0.05), 0)
    
    local box = Instance.new("TextButton")
    box.Name = "Checkbox"
    box.Parent = container
    box.AutoButtonColor = false
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    box.BorderSizePixel = 0
    box.Size = UDim2.new(0, 10, 0, 10)
    box.Position = UDim2.new(0, 0, 0, 5)
    box.Text = ""
    
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0, 2)
    
    local boxStroke = Instance.new("UIStroke", box)
    boxStroke.Thickness = 1.2
    boxStroke.Color = Color3.fromRGB(180, 105, 135)
    boxStroke.Transparency = checkbox.Value and 0 or 1
    
    local label = Instance.new("TextButton")
    label.Name = "CheckboxLabel"
    label.Parent = container
    label.AutoButtonColor = false
    label.BackgroundTransparency = 1
    label.BorderSizePixel = 0
    label.Text = displayName
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextColor3 = checkbox.Value and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(70, 70, 70)
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 18, 0, 0)
    
    -- Configurar valor inicial
    if checkbox.Value then
        box.BackgroundColor3 = Color3.fromRGB(180, 105, 135)
    else
        box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    end
    
    -- Función para alternar
    local function toggle()
        checkbox.Value = not checkbox.Value
        
        if checkbox.Value then
            TweenService:Create(box, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(180, 105, 135)}):Play()
            TweenService:Create(label, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            TweenService:Create(boxStroke, TweenInfo.new(0.15), {Transparency = 0}):Play()
        else
            TweenService:Create(box, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
            TweenService:Create(label, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(70, 70, 70)}):Play()
            TweenService:Create(boxStroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
        end
        
        if callback then
            callback(checkbox.Value)
        end
    end
    
    -- Conectar eventos
    box.MouseButton1Click:Connect(toggle)
    label.MouseButton1Click:Connect(toggle)
    
    checkbox.SetValue = function(value)
        if checkbox.Value ~= value then
            toggle()
        end
    end
    
    checkbox.GetValue = function()
        return checkbox.Value
    end
    
    return checkbox
end

-- Añadir dropdown a una tab (implementación similar)
function Hexulon:AddDropdown(tab, displayName, options, defaultOption, callback)
    -- Implementación similar a AddCheckbox pero para dropdowns
    -- Manteniendo el orden de creación
    
    local dropdown = {}
    dropdown.Value = defaultOption or (options and options[1]) or "None"
    dropdown.Options = options or {}
    dropdown.Open = false
    
    -- Crear elementos visuales del dropdown
    -- (Código similar al original pero adaptado)
    
    return dropdown
end

-- Añadir slider a una tab (implementación similar)
function Hexulon:AddSlider(tab, displayName, minValue, maxValue, defaultValue, callback)
    -- Implementación similar a AddCheckbox pero para sliders
    -- Manteniendo el orden de creación
    
    local slider = {}
    slider.Value = defaultValue or minValue
    slider.Min = minValue or 0
    slider.Max = maxValue or 100
    
    -- Crear elementos visuales del slider
    -- (Código similar al original pero adaptado)
    
    return slider
end

-- Función para exponer la API globalmente
getgenv().Hexulon = Hexulon

return Hexulon
