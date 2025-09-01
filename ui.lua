-- hexulon_gui_lib.lua
-- Librería de GUI modular (para hostear en GitHub y cargar con loadstring/httpget)
-- Uso:
-- local Library = loadstring(game:HttpGet("RAW_GITHUB_URL"))()
-- local Window = Library.Create("Hexulon")
-- local Tab = Window:NewTab("Main", "Aimbot")
-- Tab:CreateCheckbox("Enabled")
-- Tab:CreateDropdown("Aimbot Type", {"None","Camera","Mouse"})
-- Tab:CreateSlider("FOV", 90, 1, 180)

local Library = {}

-- util
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer

local function new(name, class)
	local obj = Instance.new(class)
	if name then obj.Name = name end
	return obj
end

-- default styles (puedes ajustar)
local STY = {
	Background = Color3.fromRGB(11,11,11),
	Panel = Color3.fromRGB(12,12,12),
	Accent = Color3.fromRGB(180,105,135),
	TextBase = Color3.fromRGB(66,66,66),
	TextOn = Color3.fromRGB(255,255,255),
	Button = Color3.fromRGB(26,26,26),
}

-- Create main GUI and Window API
function Library.Create(title)
	-- ScreenGui
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	local screenGui = new("Hexulon GUI", "ScreenGui")
	screenGui.Name = "Hexulon_GUI_Loaded"
	screenGui.Parent = playerGui
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	-- Main frame
	local main = new("GUI", "Frame")
	main.Size = UDim2.new(0, 840, 0, 586)
	main.Position = UDim2.new(0.166, 0, 0.135, 0)
	main.BackgroundColor3 = STY.Background
	main.BorderSizePixel = 0
	main.Parent = screenGui

	-- Top bar (page buttons)
	local topBar = new("TopBar", "Frame")
	topBar.Size = UDim2.new(1, 0, 0, 40)
	topBar.Position = UDim2.new(0, 0, 0, 0)
	topBar.BackgroundTransparency = 1
	topBar.Parent = main

	local titleLabel = new("Title", "TextLabel")
	titleLabel.Parent = topBar
	titleLabel.Text = title or "Hexulon"
	titleLabel.Size = UDim2.new(0, 240, 1, 0)
	titleLabel.Position = UDim2.new(0.02, 0, 0, 0)
	titleLabel.BackgroundTransparency = 1
	titleLabel.TextColor3 = STY.Accent
	titleLabel.TextSize = 20
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.Font = Enum.Font.SourceSans

	-- Page buttons container
	local pageButtons = new("PageButtons", "Frame")
	pageButtons.Parent = topBar
	pageButtons.Size = UDim2.new(0.5, 0, 1, 0)
	pageButtons.Position = UDim2.new(0.18, 0, 0, 0)
	pageButtons.BackgroundTransparency = 1

	-- Content area (pages)
	local contentRoot = new("ContentRoot", "Frame")
	contentRoot.Parent = main
	contentRoot.Size = UDim2.new(1, 0, 1, -40)
	contentRoot.Position = UDim2.new(0, 0, 0, 40)
	contentRoot.BackgroundTransparency = 1

	-- function to build a new page (Aimbot/Visuals)
	local function makePage(name)
		local page = new(name, "Frame")
		page.Size = UDim2.new(1, 0, 1, 0)
		page.Position = UDim2.new(0,0,0,0)
		page.BackgroundTransparency = 1
		page.Visible = false
		page.Parent = contentRoot

		-- left section area (like sections in your original)
		local left = new("Left", "Frame")
		left.Size = UDim2.new(0, 140, 1, 0)
		left.Position = UDim2.new(0.012, 0, 0, 0)
		left.BackgroundColor3 = STY.Panel
		left.BorderSizePixel = 0
		left.Parent = page

		-- main content area (scrolling)
		local content = new("Content", "ScrollingFrame")
		content.Size = UDim2.new(0, 684, 1, 0)
		content.Position = UDim2.new(0.17, 0, 0, 0)
		content.BackgroundColor3 = STY.Panel
		content.BorderSizePixel = 0
		content.CanvasSize = UDim2.new(0, 0, 0, 0)
		content.AutomaticCanvasSize = Enum.AutomaticSize.Y
		content.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
		content.Parent = page

		local list = new("List", "UIListLayout")
		list.Parent = content
		list.SortOrder = Enum.SortOrder.LayoutOrder
		list.Padding = UDim.new(0, 6)

		-- helper to update canvas size if needed (robust)
		content:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(function()
			-- nothing required (AutomaticCanvasSize handles)
		end)

		return {
			Page = page,
			Left = left,
			Content = content,
			List = list,
		}
	end

	-- create only the two required parents
	local pages = {
		Aimbot = makePage("AimbotPage"),
		Visuals = makePage("VisualsPage"),
	}

	-- create page buttons (to switch between Aimbot and Visuals)
	local function makePageButton(name)
		local btn = new(name .. "_BTN", "TextButton")
		btn.Size = UDim2.new(0, 90, 0, 30)
		btn.BackgroundTransparency = 1
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Parent = pageButtons

		local lbl = new("Label", "TextLabel")
		lbl.Parent = btn
		lbl.Size = UDim2.new(1, 0, 1, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = name
		lbl.TextSize = 18
		lbl.Font = Enum.Font.SourceSans
		lbl.TextColor3 = STY.TextBase

		btn.MouseButton1Click:Connect(function()
			-- hide all pages of interest
			for k,v in pairs(pages) do
				v.Page.Visible = false
			end
			-- show the one
			pages[name].Page.Visible = true
			-- animate label colors
			for _, child in ipairs(pageButtons:GetChildren()) do
				if child:IsA("TextButton") then
					for _, c2 in ipairs(child:GetChildren()) do
						if c2:IsA("TextLabel") then
							TweenService:Create(c2, TweenInfo.new(0.12), {TextColor3 = STY.TextBase}):Play()
						end
					end
				end
			end
			TweenService:Create(lbl, TweenInfo.new(0.12), {TextColor3 = STY.Accent}):Play()
		end)
		return btn
	end

	local aBtn = makePageButton("Aimbot")
	local vBtn = makePageButton("Visuals")

	-- show default page (Aimbot)
	pages.Aimbot.Page.Visible = true
	for _, c in ipairs(pageButtons:GetChildren()) do
		if c:IsA("TextButton") then
			for _, l in ipairs(c:GetChildren()) do
				if l:IsA("TextLabel") then
					if l.Text == "Aimbot" then l.TextColor3 = STY.Accent end
				end
			end
		end
	end

	-- Window API
	local Window = {}
	Window._gui = screenGui
	Window._pages = pages
	Window._main = main

	-- Tab factory (creates a "group" inside a page's content container)
	function Window:NewTab(name, pageName)
		pageName = pageName or "Aimbot"
		local page = self._pages[pageName]
		if not page then
			warn("Page '".. tostring(pageName) .."' no existe. Usa 'Aimbot' o 'Visuals'.")
			return
		end

		-- container frame for this tab/group
		local groupFrame = new(name or "Tab", "Frame")
		groupFrame.BackgroundColor3 = STY.Panel
		groupFrame.Size = UDim2.new(1, -12, 0, 40) -- height auto by content
		groupFrame.LayoutOrder = (#page.Content:GetChildren()) + 1
		groupFrame.BorderSizePixel = 0
		groupFrame.Parent = page.Content

		-- header label
		local header = new("Header", "TextLabel")
		header.Parent = groupFrame
		header.Size = UDim2.new(1, 0, 0, 24)
		header.Position = UDim2.new(0, 6, 0, 6)
		header.BackgroundTransparency = 1
		header.Text = name or "Tab"
		header.TextSize = 20
		header.Font = Enum.Font.SourceSans
		header.TextColor3 = STY.TextBase
		header.TextXAlignment = Enum.TextXAlignment.Left

		-- inner container for items (vertical stack)
		local inner = new("Inner", "Frame")
		inner.Parent = groupFrame
		inner.Size = UDim2.new(1, -12, 0, 0)
		inner.Position = UDim2.new(0, 6, 0, 36)
		inner.BackgroundTransparency = 1

		local innerCanvas = new("InnerList", "UIListLayout")
		innerCanvas.Parent = inner
		innerCanvas.SortOrder = Enum.SortOrder.LayoutOrder
		innerCanvas.Padding = UDim.new(0, 6)

		-- helper to recalc groupFrame size based on children
		local function recalc()
			local total = 36 -- top + header
			for _, child in ipairs(inner:GetChildren()) do
				if child:IsA("Frame") or child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("ImageLabel") then
					-- use AbsoluteSize when possible:
					local h = child.AbsoluteSize.Y
					if h and h > 0 then
						total = total + h + 6
					else
						total = total + 40
					end
				end
			end
			groupFrame.Size = UDim2.new(1, -12, 0, total)
		end

		-- watch for layout changes
		inner.CanvasSize = UDim2.new(0,0,0,0)
		inner:GetPropertyChangedSignal("AbsoluteSize"):Connect(recalc)
		inner.ChildAdded:Connect(recalc)
		inner.ChildRemoved:Connect(recalc)

		-- Element creators for this Tab
		local TabAPI = {}

		function TabAPI:SetName(newName)
			header.Text = tostring(newName or header.Text)
		end

		function TabAPI:CreateLabel(text)
			local lbl = new("Label", "TextLabel")
			lbl.Parent = inner
			lbl.Size = UDim2.new(1, 0, 0, 24)
			lbl.BackgroundTransparency = 1
			lbl.Text = text or ""
			lbl.Font = Enum.Font.SourceSans
			lbl.TextSize = 18
			lbl.TextColor3 = STY.TextBase
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			recalc()
			return lbl
		end

		function TabAPI:CreateCheckbox(text)
			local container = new("CheckboxContainer", "Frame")
			container.Parent = inner
			container.Size = UDim2.new(1, 0, 0, 24)
			container.BackgroundTransparency = 1

			local box = new("Box", "TextButton")
			box.Parent = container
			box.Size = UDim2.new(0, 16, 0, 16)
			box.Position = UDim2.new(0, 0, 0, 4)
			box.Text = ""
			box.BackgroundColor3 = Color3.fromRGB(30,30,30)
			box.BorderSizePixel = 0
			box.AutoButtonColor = false

			local corner = Instance.new("UICorner", box)
			corner.CornerRadius = UDim.new(0, 3)

			local lbl = new("Label", "TextLabel")
			lbl.Parent = container
			lbl.BackgroundTransparency = 1
			lbl.Size = UDim2.new(1, -24, 1, 0)
			lbl.Position = UDim2.new(0, 24, 0, 0)
			lbl.Text = text or "Checkbox"
			lbl.TextSize = 16
			lbl.TextColor3 = STY.TextBase
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Font = Enum.Font.SourceSans

			local state = false
			box.MouseButton1Click:Connect(function()
				state = not state
				if state then
					box.BackgroundColor3 = STY.Accent
					lbl.TextColor3 = STY.TextOn
				else
					box.BackgroundColor3 = Color3.fromRGB(30,30,30)
					lbl.TextColor3 = STY.TextBase
				end
			end)
			recalc()
			return {
				Frame = container,
				Get = function() return state end,
				Set = function(val)
					state = not not val
					box.BackgroundColor3 = state and STY.Accent or Color3.fromRGB(30,30,30)
					lbl.TextColor3 = state and STY.TextOn or STY.TextBase
				end,
			}
		end

		function TabAPI:CreateDropdown(label, options)
			options = options or {}
			local container = new("DropdownContainer", "Frame")
			container.Parent = inner
			container.Size = UDim2.new(1, 0, 0, 28)
			container.BackgroundTransparency = 1

			local title = new("Label", "TextLabel")
			title.Parent = container
			title.Size = UDim2.new(0.5, 0, 1, 0)
			title.BackgroundTransparency = 1
			title.Text = label or "Dropdown"
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.Font = Enum.Font.SourceSans
			title.TextSize = 16
			title.TextColor3 = STY.TextBase

			local btn = new("Btn", "TextButton")
			btn.Parent = container
			btn.Size = UDim2.new(0.45, 0, 1, 0)
			btn.Position = UDim2.new(0.52, 0, 0, 0)
			btn.Text = "None ▾"
			btn.Font = Enum.Font.SourceSans
			btn.TextSize = 14
			btn.TextColor3 = STY.TextBase
			btn.BackgroundColor3 = STY.Button
			btn.BorderSizePixel = 0
			btn.AutoButtonColor = false

			local corner = Instance.new("UICorner", btn)
			corner.CornerRadius = UDim.new(0, 4)

			local menu = new("Menu", "Frame")
			menu.Parent = container
			menu.Position = UDim2.new(0.52, 0, 1, 4)
			menu.Size = UDim2.new(0.45, 0, 0, 0)
			menu.ClipsDescendants = true
			menu.BackgroundColor3 = STY.Button
			menu.BorderSizePixel = 0
			menu.Visible = false

			local menuList = new("MenuList", "UIListLayout")
			menuList.Parent = menu
			menuList.SortOrder = Enum.SortOrder.LayoutOrder
			menuList.Padding = UDim.new(0, 2)

			local open = false
			local selected = nil

			local function refreshOptions()
				for _, c in ipairs(menu:GetChildren()) do
					if c:IsA("TextButton") then c:Destroy() end
				end
				for i,opt in ipairs(options) do
					local o = new("Opt"..i, "TextButton")
					o.Parent = menu
					o.Size = UDim2.new(1, 0, 0, 22)
					o.BackgroundTransparency = 1
					o.Text = tostring(opt)
					o.Font = Enum.Font.SourceSans
					o.TextSize = 14
					o.TextColor3 = STY.TextBase
					o.AutoButtonColor = false
					o.MouseButton1Click:Connect(function()
						selected = opt
						btn.Text = tostring(selected) .. " ▾"
						-- close
						open = false
						menu.Visible = false
						menu.Size = UDim2.new(0.45, 0, 0, 0)
					end)
				end
			end

			btn.MouseButton1Click:Connect(function()
				open = not open
				if open then
					menu.Visible = true
					menu.Size = UDim2.new(0.45, 0, 0, #options * 22)
				else
					menu.Size = UDim2.new(0.45, 0, 0, 0)
					task.delay(0.15, function() menu.Visible = false end)
				end
			end)

			refreshOptions()
			recalc()
			return {
				Frame = container,
				Get = function() return selected end,
				SetOptions = function(newOptions)
					options = newOptions or {}
					refreshOptions()
				end
			}
		end

		function TabAPI:CreateSlider(label, initial, min, max)
			min = min or 0
			max = max or 100
			local value = initial or min

			local container = new("SliderContainer", "Frame")
			container.Parent = inner
			container.Size = UDim2.new(1, 0, 0, 40)
			container.BackgroundTransparency = 1

			local lbl = new("Label", "TextLabel")
			lbl.Parent = container
			lbl.Size = UDim2.new(0.6, 0, 0, 16)
			lbl.Position = UDim2.new(0, 0, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = label or "Slider"
			lbl.TextSize = 16
			lbl.Font = Enum.Font.SourceSans
			lbl.TextColor3 = STY.TextBase
			lbl.TextXAlignment = Enum.TextXAlignment.Left

			local valLbl = new("Value", "TextLabel")
			valLbl.Parent = container
			valLbl.Size = UDim2.new(0.4, 0, 0, 16)
			valLbl.Position = UDim2.new(0.6, 0, 0, 0)
			valLbl.BackgroundTransparency = 1
			valLbl.Text = tostring(value)
			valLbl.TextSize = 16
			valLbl.Font = Enum.Font.SourceSans
			valLbl.TextColor3 = STY.TextBase
			valLbl.TextXAlignment = Enum.TextXAlignment.Right

			local bar = new("Bar", "Frame")
			bar.Parent = container
			bar.Size = UDim2.new(1, 0, 0, 10)
			bar.Position = UDim2.new(0, 0, 0, 22)
			bar.BackgroundColor3 = STY.Button
			bar.BorderSizePixel = 0
			local barCorner = Instance.new("UICorner", bar)
			barCorner.CornerRadius = UDim.new(0, 4)

			local fill = new("Fill", "Frame")
			fill.Parent = bar
			fill.Size = UDim2.new( (value - min) / math.max(1, (max - min)), 0, 1, 0)
			fill.BackgroundColor3 = STY.Accent
			fill.BorderSizePixel = 0
			local fillCorner = Instance.new("UICorner", fill)
			fillCorner.CornerRadius = UDim.new(0, 4)

			local dragging = false

			local function updateFromX(px)
				local absPos = bar.AbsolutePosition.X
				local absSize = bar.AbsoluteSize.X
				if absSize <= 0 then return end
				local rel = (px - absPos) / absSize
				rel = math.clamp(rel, 0, 1)
				value = min + rel * (max - min)
				fill.Size = UDim2.new(rel, 0, 1, 0)
				valLbl.Text = tostring(math.floor(value))
			end

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					if input.Position then updateFromX(input.Position.X) end
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					updateFromX(input.Position.X)
				end
			end)
			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			recalc()
			return {
				Frame = container,
				Get = function() return value end,
				Set = function(v)
					value = math.clamp(v, min, max)
					local rel = (value - min) / math.max(1, (max - min))
					fill.Size = UDim2.new(rel, 0, 1, 0)
					valLbl.Text = tostring(math.floor(value))
				end
			}
		end

		-- expose container references if needed
		TabAPI._container = groupFrame
		TabAPI._inner = inner

		-- default: return TabAPI
		return TabAPI
	end

	-- return the Window object to user
	return Window
end

return Library
