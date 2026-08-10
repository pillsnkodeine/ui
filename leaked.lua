local C3, U2, U1 = Color3.fromRGB, UDim2.new, UDim.new
local CS, CSK = ColorSequence.new, ColorSequenceKeypoint.new
local NS, NSK = NumberSequence.new, NumberSequenceKeypoint.new
local FNT = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

local function create(cls, props)
	local inst = Instance.new(cls)
	for k, v in pairs(props) do inst[k] = v end
	return inst
end

local ScreenGUI = create("ScreenGui", {Name="ScreenGUI", ZIndexBehavior=Enum.ZIndexBehavior.Sibling, Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")})
local flessia = create("Frame", {Name="flessia", BorderSizePixel=0, BackgroundColor3=C3(16,16,16), Size=U2(0,633,0,410), Position=U2(0.06189,0,0.10782,0), BorderColor3=C3(0,0,0), Parent=ScreenGUI})
local flessia_LocalScript = create("LocalScript", {Parent=flessia})
create("UICorner", {CornerRadius=U1(0,5), Parent=flessia})
local CanvasGroup_1 = create("CanvasGroup", {BorderSizePixel=0, BackgroundColor3=C3(21,21,21), Size=U2(0,633,0,410), BorderColor3=C3(0,0,0), BackgroundTransparency=1, Parent=flessia})
local Buttons = create("Frame", {Name="Buttons", BorderSizePixel=0, BackgroundColor3=C3(11,11,11), Size=U2(0,130,0,410), BorderColor3=C3(0,0,0), Parent=CanvasGroup_1})
local tab_switching = create("LocalScript", {Name="tab switching", Parent=Buttons})
create("UIListLayout", {HorizontalAlignment=Enum.HorizontalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder, Padding=U1(0,5), Parent=Buttons})
create("UICorner", {Parent=Buttons})
create("Frame", {Name="line separator", BorderSizePixel=0, BackgroundColor3=C3(26,26,26), Size=U2(0,1,0,410), Position=U2(0.20472,0,0,0), BorderColor3=C3(0,0,0), Parent=CanvasGroup_1})
local CanvasGroup_2 = create("CanvasGroup", {BorderSizePixel=0, BackgroundColor3=C3(21,21,21), Size=U2(0,503,0,410), Position=U2(0.205,0,0,0), BorderColor3=C3(0,0,0), BackgroundTransparency=1, Parent=CanvasGroup_1})

create("UIStroke", {Color=C3(21,21,21), Parent=flessia})

local Library = {}

function Library.CreateTabSeparator(text)
	local idx = #Buttons:GetChildren()
	local sep = create("TextLabel", {Name=idx..". separator", LayoutOrder=idx, BorderSizePixel=0, BackgroundTransparency=1, Size=U2(0,120,0,20), TextSize=13, TextColor3=C3(115,115,115), FontFace=FNT, TextXAlignment=Enum.TextXAlignment.Left, Text=text, Parent=Buttons})
	create("UIPadding", {PaddingLeft=U1(0,5), Parent=sep})
	return sep
end

function Library.CreateTab(name, iconId)
	local idx = #Buttons:GetChildren()
	local btn = create("TextButton", {Name=idx..". "..name:lower().." button", LayoutOrder=idx, BorderSizePixel=0, TextSize=14, TextColor3=C3(255,255,255), BackgroundColor3=C3(16,16,16), FontFace=FNT, Size=U2(0,115,0,30), Text=name, Parent=Buttons})
	if iconId then create("ImageLabel", {Name="Icon", BorderSizePixel=0, BackgroundTransparency=1, Image=iconId, Size=U2(0,25,0,25), Position=U2(0.057,0,0.1,0), Parent=btn}) end
	local f = create("Frame", {Name="TabFrame_"..idx, BorderSizePixel=0, BackgroundColor3=C3(16,16,16), Size=U2(0,495,0,410), Position=U2(0.0159,0,0,0), Visible=false, Parent=CanvasGroup_2})
	create("UIListLayout", {Padding=U1(0,5), VerticalAlignment=Enum.VerticalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder, FillDirection=Enum.FillDirection.Horizontal, Parent=f})
	create("UICorner", {Parent=f})
	create("ObjectValue", {Name="LinkedFrame", Value=f, Parent=btn})
	return f
end

function Library.CreatePanel(tF, pName)
	local panelSize = (pName == "Checks") and U2(0, 250, 0, 320) or U2(0, 250, 0, 100)
	local p = create("Frame", {Name="Panel", LayoutOrder=#tF:GetChildren(), BorderSizePixel=0, BackgroundColor3=C3(18,18,18), Size=panelSize, Position=U2(0,0,0.0122,0), Parent=tF})
	create("UICorner", {Parent=p}); create("UIStroke", {Color=C3(26,26,26), Parent=p})
	local h = create("Frame", {Name="Header", BorderSizePixel=0, Size=U2(0,240,0,30), BackgroundTransparency=1, Parent=p})
	create("TextLabel", {Name="Panel Name", BorderSizePixel=0, TextSize=14, FontFace=FNT, TextColor3=C3(201,201,201), BackgroundTransparency=1, Size=U2(0,240,0,30), Text=pName, Parent=h})
	local sep = create("Frame", {Name="Separator", BorderSizePixel=0, BackgroundColor3=C3(255,255,255), Size=U2(0,240,0,1), Position=U2(0,0,1,0), Parent=h})
	create("UIGradient", {Color=CS({CSK(0,C3(26,26,26)), CSK(0.5,C3(39,39,39)), CSK(1,C3(26,26,26))}), Parent=sep})
	local s = create("ScrollingFrame", {Name="Settings", Active=true, ScrollingDirection=Enum.ScrollingDirection.Y, BorderSizePixel=0, CanvasSize=U2(0,0,0,0), ElasticBehavior=Enum.ElasticBehavior.Always, ScrollBarImageTransparency=1, BackgroundColor3=C3(21,21,21), AutomaticCanvasSize=Enum.AutomaticSize.Y, Size=U2(0,240,0,350), ScrollBarImageColor3=C3(21,21,21), Position=U2(0,0,0.08,0), ScrollBarThickness=1, BackgroundTransparency=1, Parent=p})
	create("UIListLayout", {HorizontalAlignment=Enum.HorizontalAlignment.Center, SortOrder=Enum.SortOrder.LayoutOrder, Padding=U1(0,2), ItemLineAlignment=Enum.ItemLineAlignment.Center, Parent=s})
	create("Frame", {Name="0. Dummy frame/start pos", LayoutOrder=-1, BorderSizePixel=0, Size=U2(0,240,0,1), BackgroundTransparency=1, Parent=s})
	create("Frame", {Name="99999. Dummy frame/start pos", LayoutOrder=99999, BorderSizePixel=0, Size=U2(0,240,0,1), BackgroundTransparency=1, Parent=s})
	return s
end

function Library.CreateSeparator(pSet, text, pad)
	local f = create("Frame", {Name="Separator", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, Size=U2(0,220,0,25), BackgroundTransparency=1, Parent=pSet})
	local lL = create("Frame", {Name="LeftLine", BorderSizePixel=0, BackgroundColor3=C3(36,36,36), Size=U2(0.5,0,0,1), Position=U2(0,0,0.5,0), AnchorPoint=Vector2.new(0,0.5), Parent=f})
	local rL = create("Frame", {Name="RightLine", BorderSizePixel=0, BackgroundColor3=C3(36,36,36), Size=U2(0.5,0,0,1), Position=U2(1,0,0.5,0), AnchorPoint=Vector2.new(1,0.5), Parent=f})
	local tC = create("Frame", {Name="TextContainer", Size=U2(1,0,1,0), BackgroundTransparency=1, Parent=f})
	create("UIListLayout", {HorizontalAlignment=Enum.HorizontalAlignment.Center, VerticalAlignment=Enum.VerticalAlignment.Center, Parent=tC})
	local t = create("TextLabel", {Name="Title", BorderSizePixel=0, TextSize=12, BackgroundTransparency=1, FontFace=FNT, TextColor3=C3(115,115,115), Size=U2(0,0,1,0), AutomaticSize=Enum.AutomaticSize.X, Text=string.upper(text), Parent=tC})
	create("UIPadding", {PaddingLeft=UDim.new(0,pad or 10), PaddingRight=UDim.new(0,pad or 10), Parent=t})
	local function upd() local hG = t.AbsoluteSize.X/2; lL.Size = U2(0.5,-hG,0,1); rL.Size = U2(0.5,-hG,0,1) end
	t:GetPropertyChangedSignal("AbsoluteSize"):Connect(upd); upd()
	return f
end

function Library.CreateCheckbox(pSet, text, cb)
	local cF = create("Frame", {Name="Checkbox", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, Size=U2(0,220,0,30), BackgroundTransparency=1, Parent=pSet})
	local cB = create("ImageButton", {Name="Checkbox", BorderSizePixel=0, BackgroundColor3=C3(18,18,18), Size=U2(0,20,0,20), Position=U2(0.886,0,0.3,0), Parent=cF})
	local cS = create("LocalScript", {Name="checkbox script", Parent=cB})
	create("UICorner", {CornerRadius=U1(0,4), Parent=cB})
	create("TextLabel", {Name="TextLabel", BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(76,76,76), BackgroundTransparency=1, Size=U2(0,0,0,30), AutomaticSize=Enum.AutomaticSize.X, Text=text, Position=U2(0,0,0.1,0), Parent=cF})

	task.spawn(function()
		local sq, TS = cS.Parent, game:GetService("TweenService"); local tL = sq.Parent:WaitForChild("TextLabel")
		local chk = create("TextLabel", {Name="Checkmark", Parent=sq, Size=U2(0.6,0,0.6,0), Position=U2(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, Text="✔", TextScaled=true, TextColor3=C3(0,0,0), Visible=false, Font=Enum.Font.SourceSansBold, ZIndex=2})
		local gl = create("ImageLabel", {Name="GlowEffect", Parent=sq, BackgroundTransparency=1, Image="rbxassetid://12812846813", Size=U2(1,6,1,6), Position=U2(0.5,0,0.5,0), AnchorPoint=Vector2.new(0.5,0.5), ImageTransparency=0.6, ZIndex=0})
		local str = create("UIStroke", {Name="InnerStroke", Parent=sq, Color=C3(25,25,25), ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Thickness=1})
		if sq:IsA("GuiButton") then sq.AutoButtonColor = false end

		local isEn, lastT = false, 0
		local function upd(a)
			chk.Visible = isEn; local sC, tC = isEn and C3(255,135,135) or C3(17,17,17), isEn and C3(200,200,200) or C3(70,70,70)
			if a then
				local tI = TweenInfo.new(0.35)
				TS:Create(sq, tI, {BackgroundColor3=sC}):Play(); TS:Create(tL, tI, {TextColor3=tC}):Play()
				TS:Create(str, tI, {Transparency=isEn and 1 or 0.3}):Play(); TS:Create(gl, tI, {ImageTransparency=isEn and 1 or 0.6}):Play()
			else sq.BackgroundColor3, tL.TextColor3, str.Transparency, gl.ImageTransparency = sC, tC, isEn and 1 or 0.3, isEn and 1 or 0.6 end
		end
		local function tgl()
			if os.clock()-lastT < 0.15 then return end
			lastT = os.clock(); isEn = not isEn; upd(true); if cb then cb(isEn) end
		end
		local MB1 = Enum.UserInputType.MouseButton1
		sq.InputBegan:Connect(function(i) if i.UserInputType==MB1 then tgl() end end)
		tL.Active = true; tL.InputBegan:Connect(function(i) if i.UserInputType==MB1 then tgl() end end)
		sq.MouseEnter:Connect(function() if not isEn then TS:Create(sq, TweenInfo.new(0.15), {BackgroundColor3=C3(50,50,50)}):Play() end end)
		sq.MouseLeave:Connect(function() if not isEn then TS:Create(sq, TweenInfo.new(0.15), {BackgroundColor3=C3(17,17,17)}):Play() end end)
		upd(false)
	end)
end

function Library.CreateSlider(pSet, text, min, max, start, mode, cb)
	min, max, start, mode = min or 0, max or 1, start or (min or 0), mode or "Limited"
	local sF = create("Frame", {Name="slider", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, Size=U2(0,220,0,30), Position=U2(0.05,0,0.2327,0), BackgroundTransparency=1, Parent=pSet})
	local sS = create("LocalScript", {Name="slider logic", Parent=sF})
	local sB = create("TextButton", {Name="background", Text="", AutoButtonColor=false, BorderSizePixel=0, AnchorPoint=Vector2.new(0,0.5), Size=U2(0,105,0,5), Position=U2(0.345,0,0.55,0), Parent=sF})
	local btn = create("ImageButton", {BorderSizePixel=0, BackgroundTransparency=1, BackgroundColor3=C3(255,255,255), Image="rbxasset://textures/ui/GuiImagePlaceholder.png", Size=U2(0,8,0,8), Position=U2(0,0,-0.4,0), Parent=sB})
	create("UICorner", {CornerRadius=U1(1,0), Parent=btn}); create("UIGradient", {Rotation=90, Color=CS({CSK(0,C3(61,61,61)), CSK(1,C3(41,41,41))}), Parent=btn})
	create("UICorner", {CornerRadius=U1(1,0), Parent=sB}); create("UIGradient", {Rotation=90, Color=CS({CSK(0,C3(36,36,36)), CSK(1,C3(26,26,26))}), Parent=sB})
	create("TextLabel", {Name="SliderText", TextWrapped=true, BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(66,66,66), BackgroundTransparency=1, Size=U2(0,70,0,30), Text=text, Parent=sF})
	create("TextBox", {Name="Value", BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, TextColor3=C3(255,255,255), FontFace=FNT, Size=U2(0,35,0,30), Position=U2(0.85,0,0,0), Text="", BackgroundTransparency=1, Parent=sF})

	task.spawn(function()
		local mF = sS.Parent; local sld, hand, vLbl, sTxt = mF:WaitForChild("background"), mF.background:WaitForChild("ImageButton"), mF:WaitForChild("Value"), mF:WaitForChild("SliderText")
		local UIS, TS, TxS = game:GetService("UserInputService"), game:GetService("TweenService"), game:GetService("TextService")
		local cAct, cIna, cBg = C3(200,200,200), C3(65,65,65), C3(255,255,255)
		local tM, tF, tC = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		local function tw(o, i, p) TS:Create(o, i, p):Play() end

		sld.BackgroundTransparency, sld.BorderSizePixel, sld.BackgroundColor3 = 0, 0, cBg
		hand.BackgroundTransparency, hand.ImageTransparency, hand.ZIndex, hand.BackgroundColor3, hand.AutoButtonColor = 0, 1, 10, cBg, false
		local hOvr = create("Frame", {Name="WhiteOverlay", Size=U2(1,0,1,0), BackgroundColor3=cBg, BackgroundTransparency=1, ZIndex=11, BorderSizePixel=0, Parent=hand}); create("UICorner", {CornerRadius=U1(1,0), Parent=hOvr})
		local gF = create("Frame", {Name="ProgressBar", ClipsDescendants=true, ZIndex=5, Size=U2(0,0,1,0), BackgroundTransparency=1, Parent=sld}); create("UICorner", {Parent=gF})
		local fill = create("Frame", {Name="Fill", BackgroundColor3=cBg, BorderSizePixel=0, ZIndex=6, Size=U2(1,0,1,0), Parent=gF}); create("UICorner", {Parent=fill}); create("UIGradient", {Color=CS({CSK(0,C3(255,255,255)), CSK(1,C3(155,155,155))}), Parent=fill})
		local vL = create("TextLabel", {Name="VisibleValue", Size=vLbl.Size, Position=vLbl.Position, AnchorPoint=vLbl.AnchorPoint, BackgroundTransparency=1, Font=vLbl.Font, TextSize=vLbl.TextSize, TextColor3=vLbl.TextColor3, TextXAlignment=vLbl.TextXAlignment, Text=vLbl.Text, ZIndex=vLbl.ZIndex, Parent=vLbl.Parent})
		vLbl.TextTransparency, vLbl.Selectable, vLbl.BackgroundTransparency = 1, false, 1
		local sCar = create("Frame", {Name="SmoothCaret", Size=U2(0,1,0,vL.TextSize*0.8), AnchorPoint=Vector2.new(0,0.5), BackgroundColor3=cAct, BorderSizePixel=0, BackgroundTransparency=1, ZIndex=vL.ZIndex+1, Parent=vL})
		local fB = create("TextButton", {Name="BlockHoverBar", Size=U2(1,0,1,0), BackgroundTransparency=1, Text="", AutoButtonColor=false, ZIndex=vLbl.ZIndex+2, Parent=vLbl})

		local drag, cVal = false, start
		local function fmt(v) return mode=="Degree" and math.round(v).."°" or string.format("%.3f", v) end
		local function updCar()
			task.defer(function()
				if not vLbl:IsFocused() then return end
				local tS = TxS:GetTextSize(vLbl.CursorPosition>-1 and vLbl.Text:sub(1,math.max(0,vLbl.CursorPosition-1)) or vLbl.Text, vL.TextSize, vL.Font, Vector2.new(1e4,1e4))
				local fS = TxS:GetTextSize(vL.Text, vL.TextSize, vL.Font, Vector2.new(1e4,1e4))
				local xO = vL.TextXAlignment==Enum.TextXAlignment.Center and (vL.AbsoluteSize.X-fS.X)/2+tS.X or (vL.TextXAlignment==Enum.TextXAlignment.Right and vL.AbsoluteSize.X-fS.X+tS.X or tS.X)
				task.delay(0.04, function() tw(sCar, tC, {Position=U2(0,xO+2,0.5,0)}) end)
			end)
		end

		local function updPos(x, fV)
			if fV then cVal = mode=="Degree" and math.round(math.clamp(fV,min,max)) or (mode=="Limited" and math.clamp(fV,min,max) or fV)
			elseif x then 
				local mV = min + (math.clamp((x-sld.AbsolutePosition.X)/sld.AbsoluteSize.X, 0, 1) * (max-min))
				cVal = mode=="Degree" and math.round(mV) or math.floor(mV*1000+0.5)/1000
			end
			local alp = max>min and math.clamp((cVal-min)/(max-min),0,1) or 0
			local nX = alp * sld.AbsoluteSize.X; local tCol = cVal==0 and cIna or cAct
			tw(hand, tM, {Position=U2(0, math.clamp(nX-(hand.AbsoluteSize.X/2),0,sld.AbsoluteSize.X-hand.AbsoluteSize.X), 0.5, -hand.AbsoluteSize.Y/2)}) 
			tw(hOvr, tM, {BackgroundTransparency=alp>0 and 0 or 1}); tw(vL, tM, {TextColor3=tCol}); tw(sTxt, tM, {TextColor3=tCol}); tw(gF, tM, {Size=U2(0,nX,1,0)})
			if not vLbl:IsFocused() then vLbl.Text = fmt(cVal) end
			if cb then cb(cVal) end
		end

		local function fdC() local c=vL:Clone(); c.Name, c.ZIndex, c.Parent = "FdC", vL.ZIndex+1, vL.Parent; for _,ch in ipairs(c:GetChildren()) do ch:Destroy() end; tw(c, tF, {TextTransparency=1}); task.delay(tF.Time, function() c:Destroy() end) end
		fB.MouseButton1Click:Connect(function() if not vLbl:IsFocused() then fdC(); vLbl.Text, vL.TextTransparency = "", 1; vLbl:CaptureFocus() end end)
		vLbl:GetPropertyChangedSignal("Text"):Connect(function() if vLbl:IsFocused() then if vLbl.Text~="" then vL.Text = vLbl.Text; tw(vL, tF, {TextTransparency=0}); tw(sCar, tF, {BackgroundTransparency=0}) else if vL.Text~="" then fdC() end; vL.Text, vL.TextTransparency = "", 1; tw(sCar, tF, {BackgroundTransparency=1}) end else vL.Text = vLbl.Text end; updCar() end)
		vLbl:GetPropertyChangedSignal("TextTransparency"):Connect(function() vLbl.TextTransparency = 1 end); vLbl:GetPropertyChangedSignal("CursorPosition"):Connect(updCar)
		vLbl.Focused:Connect(function() tw(sCar, tF, {BackgroundTransparency=vLbl.Text=="" and 1 or 0}); updCar() end)
		vLbl.FocusLost:Connect(function() tw(sCar, tF, {BackgroundTransparency=1}); vL.TextTransparency=1; updPos(nil, tonumber(mode=="Degree" and vLbl.Text:gsub("[^%d%.%-]","") or vLbl.Text) or cVal); tw(vL, tF, {TextTransparency=0}) end)
		local MB1 = Enum.UserInputType.MouseButton1
		hand.InputBegan:Connect(function(i) if i.UserInputType==MB1 then drag=true end end)
		sld.InputBegan:Connect(function(i) if i.UserInputType==MB1 then drag=true; updPos(i.Position.X) end end)
		UIS.InputEnded:Connect(function(i) if drag and i.UserInputType==MB1 then drag=false end end)
		UIS.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then updPos(i.Position.X) end end)
		updPos(nil, start)
	end)
end

function Library.CreateDropdown(pSet, text, opts, cb)
	local dF = create("Frame", {Name="dropdown", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, Size=U2(0,220,0,30), BackgroundTransparency=1, Parent=pSet})
	local dT = create("TextLabel", {Name="dropdown text", BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(66,66,66), BackgroundTransparency=1, Size=U2(0,60,0,30), Text=text, Parent=dF})
	local dB = create("TextButton", {Name="dropdown", BorderSizePixel=0, BackgroundColor3=C3(21,21,21), ZIndex=2, Size=U2(0,140,0,20), Position=U2(0.34,0,0.25,0), Text="", Parent=dF})
	create("UICorner", {CornerRadius=U1(0,2), Parent=dB}); create("UIStroke", {Color=C3(255,255,255), Parent=dB})
	local sL = create("TextLabel", {Name="SelectedLabel", BorderSizePixel=0, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(66,66,66), BackgroundTransparency=1, Size=U2(0,30,0,20), Position=U2(0.035,0,0,0), Text="None", Parent=dB})
	local aC = create("ImageLabel", {Name="dropdown closed arrow", BorderSizePixel=0, ImageColor3=C3(201,201,201), Image="rbxassetid://85316361226936", Size=U2(0,15,0,15), Position=U2(0.86,0,0.15,0), BackgroundTransparency=1, Parent=dB})
	local aO = create("ImageLabel", {Name="dropdown open arrow", BorderSizePixel=0, ImageColor3=C3(201,201,201), Image="rbxassetid://112266947102317", Size=U2(0,15,0,15), Position=U2(0.86,0,0.15,0), BackgroundTransparency=1, Visible=false, Parent=dB})
	local dM = create("ScrollingFrame", {Name="menu", Visible=false, BorderSizePixel=0, BackgroundColor3=C3(21,21,21), Size=U2(0,140,0,60), Position=U2(0,0,1.05,0), ScrollBarThickness=1, ScrollBarImageTransparency=1, AutomaticCanvasSize=Enum.AutomaticSize.Y, CanvasSize=U2(0,0,0,0), ScrollingDirection=Enum.ScrollingDirection.Y, Parent=dB})
	create("UIListLayout", {SortOrder=Enum.SortOrder.LayoutOrder, Parent=dM})

	task.spawn(function()
		local TS = game:GetService("TweenService"); local tI = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local cDef, cHov, cSel = C3(65,65,65), C3(200,200,200), C3(75,75,75)
		local opn, sOpt, bSz, mH = false, "None", dF.Size, dM.Size.Y.Offset
		local function tw(o, p) if o then TS:Create(o, tI, p):Play() end end

		dB.AnchorPoint = Vector2.new(dB.AnchorPoint.X, 0); dB.Position = U2(dB.Position.X.Scale, dB.Position.X.Offset, 0, (dB.Position.Y.Scale * bSz.Y.Offset) + dB.Position.Y.Offset)
		dT.AnchorPoint = Vector2.new(dT.AnchorPoint.X, 0); dT.Position = U2(dT.Position.X.Scale, dT.Position.X.Offset, 0, (dT.Position.Y.Scale * bSz.Y.Offset) + dT.Position.Y.Offset)
		dM.Visible, dM.Size, dM.BackgroundTransparency, dM.ClipsDescendants = false, U2(1,0,0,0), 1, true
		dB.AutoButtonColor, sL.TextColor3, sL.Text, dT.TextColor3, dF.ClipsDescendants = false, cSel, sOpt, cDef, false
		aO.Visible, aC.Visible, aO.ImageColor3, aC.ImageColor3 = false, true, cSel, cSel

		local setMenu, btns = nil, {}
		for i, n in ipairs(opts) do
			local o = create("TextButton", {BorderSizePixel=0, BackgroundColor3=C3(21,21,21), ZIndex=3, Size=U2(1,0,0,20), LayoutOrder=i, AutoButtonColor=false, BackgroundTransparency=1, Text="", Parent=dM})
			local l = create("TextLabel", {BorderSizePixel=0, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=cDef, BackgroundTransparency=1, Size=U2(1,-10,1,0), Position=U2(0.065,0,0,0), Text=n, ZIndex=3, TextTransparency=1, Parent=o})
			table.insert(btns, {o=o, l=l, n=n})
			o.MouseButton1Click:Connect(function() if n~=sOpt then sOpt, sL.Text = n, n; setMenu(false); if cb then cb(n) end end end)
			o.MouseEnter:Connect(function() if opn then tw(l, {TextColor3 = cHov}) end end)
			o.MouseLeave:Connect(function() if opn then tw(l, {TextColor3 = n==sOpt and cSel or cDef}) end end)
		end

		setMenu = function(st)
			opn = st
			if opn then 
				dM.Visible = true 
				for _, s in ipairs(dF.Parent:GetChildren()) do
					local m = s~=dF and s:IsA("GuiObject") and s:FindFirstChild("dropdown") and s.dropdown:FindFirstChild("menu")
					if m then m.Visible = false end
				end
			end
			local tH = opn and mH or 0
			tw(dM, {Size=U2(1,0,0,tH), BackgroundTransparency=opn and 0 or 1}); tw(dF, {Size=U2(bSz.X.Scale, bSz.X.Offset, bSz.Y.Scale, bSz.Y.Offset+tH)})
			local scr = dF:FindFirstAncestorOfClass("ScrollingFrame")
			if scr and opn then
				local tBot = (dF.AbsolutePosition.Y - scr.AbsolutePosition.Y) + scr.CanvasPosition.Y + bSz.Y.Offset + tH + 5 
				if tBot > scr.CanvasPosition.Y + scr.AbsoluteWindowSize.Y then tw(scr, {CanvasPosition = Vector2.new(scr.CanvasPosition.X, scr.CanvasPosition.Y + (tBot - (scr.CanvasPosition.Y + scr.AbsoluteWindowSize.Y)))}) end
			end
			local act = opn or (sOpt~="Disabled" and sOpt~="None")
			local c, tc = act and cHov or cSel, act and cHov or cDef
			tw(aO, {ImageColor3=c}); tw(aC, {ImageColor3=c}); tw(sL, {TextColor3=tc}); tw(dT, {TextColor3=tc})
			aO.Visible, aC.Visible = opn, not opn
			for _, b in ipairs(btns) do tw(b.l, {TextTransparency=opn and 0 or 1, TextColor3=b.n==sOpt and cSel or cDef}) end
			if not opn then task.delay(tI.Time, function() if not opn then dM.Visible = false end end) end
		end
		dB.MouseButton1Click:Connect(function() setMenu(not opn) end)
	end)
end

function Library.CreateColorPicker(pSet, txt, defC, mSz, cb)
	if type(mSz)=="function" then cb, mSz = mSz, 95 end
	mSz, defC = mSz or 65, defC or C3(0,0,0)
	local h,s,v = defC:ToHSV(); local opn, exH = false, mSz+75 
	local cF = create("Frame", {Name="ColorPicker", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, BackgroundColor3=C3(21,21,21), Size=U2(0,220,0,30), BackgroundTransparency=1, Parent=pSet, ClipsDescendants=true})
	local cT = create("TextButton", {Name="Toggle", Size=U2(1,0,0,30), BackgroundTransparency=1, Text="", AutoButtonColor=false, Parent=cF})
	local cLbl = create("TextLabel", {Name="Title", BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(66,66,66), BackgroundTransparency=1, Size=U2(0,100,1,0), Text=txt, Parent=cT})
	local pC = create("Frame", {Name="Container", Size=U2(0,220,0,mSz+40), Position=U2(0,0,0,30), BackgroundTransparency=1, Parent=cF})
	local sM = create("TextButton", {Name="SV_Map", Size=U2(1,0,0,mSz), BackgroundColor3=Color3.fromHSV(h,1,1), Text="", AutoButtonColor=false, Parent=pC})
	local sW = create("Frame", {Size=U2(1,0,1,0), BackgroundColor3=C3(255,255,255), BorderSizePixel=0, Parent=sM}); create("UIGradient", {Color=CS(C3(255,255,255)), Transparency=NS({NSK(0,0), NSK(1,1)}), Parent=sW})
	local sB = create("Frame", {Size=U2(1,0,1,0), BackgroundColor3=C3(0,0,0), BorderSizePixel=0, Parent=sM}); create("UIGradient", {Color=CS(C3(0,0,0)), Transparency=NS({NSK(0,1), NSK(1,0)}), Rotation=90, Parent=sB})
	local sSel = create("Frame", {Size=U2(0,6,0,6), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, Position=U2(s,0,1-v,0), Parent=sM}); create("UICorner", {CornerRadius=U1(1,0), Parent=sSel}); create("UIStroke", {Color=C3(255,255,255), Thickness=1.5, Parent=sSel})
	local hS = create("TextButton", {Name="Hue_Slider", Size=U2(1,0,0,10), Position=U2(0,0,0,mSz+5), Text="", AutoButtonColor=false, Parent=pC}); create("UIGradient", {Color=CS({CSK(0,C3(255,0,0)), CSK(0.167,C3(255,255,0)), CSK(0.333,C3(0,255,0)), CSK(0.5,C3(0,255,255)), CSK(0.667,C3(0,0,255)), CSK(0.833,C3(255,0,255)), CSK(1,C3(255,0,0))}), Parent=hS})
	local hSel = create("Frame", {Size=U2(0,14,0,14), AnchorPoint=Vector2.new(0.5,0.5), BackgroundColor3=Color3.fromHSV(h,1,1), Position=U2(h,0,0.5,0), Parent=hS}); create("UICorner", {CornerRadius=U1(1,0), Parent=hSel}); create("UIStroke", {Color=C3(255,255,255), Thickness=1.5, Parent=hSel})
	local cPrv = create("Frame", {Name="Preview", Size=U2(0,95,0,20), Position=U2(0,0,0,mSz+20), BackgroundColor3=defC, BorderSizePixel=0, Parent=pC})

	local function cRGB(xO)
		local b = create("TextBox", {Size=U2(0,34,0,20), Position=U2(1,xO,0,mSz+20), BackgroundColor3=C3(45,45,45), TextTransparency=1, FontFace=FNT, TextSize=14, ClearTextOnFocus=false, BorderSizePixel=0, Parent=pC})
		create("UICorner", {CornerRadius=U1(0,3), Parent=b})
		local l = create("TextLabel", {Size=U2(1,0,1,0), BackgroundTransparency=1, TextColor3=C3(200,200,200), FontFace=FNT, TextSize=14, Parent=b})
		local cBtn = create("TextButton", {Size=U2(1,0,1,0), BackgroundTransparency=1, Text="", Parent=b}); cBtn.MouseButton1Click:Connect(function() b:CaptureFocus() end)
		return b, l
	end
	local rB, rL = cRGB(-110); local gB, gL = cRGB(-72); local bB, bL = cRGB(-34)

	task.spawn(function()
		local TS, UIS = game:GetService("TweenService"), game:GetService("UserInputService")
		local function tw(o, i, pr) if o then TS:Create(o, i, pr):Play() end end
		local qE = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

		local function updDisp(isT)
			local cl, hC = Color3.fromHSV(h,s,v), Color3.fromHSV(h,1,1)
			local t2 = TweenInfo.new(0.2)
			tw(sM, t2, {BackgroundColor3=hC}); tw(hSel, t2, {BackgroundColor3=hC}); tw(cPrv, t2, {BackgroundColor3=cl})
			tw(sSel, qE, {Position=U2(s, (0.5-s)*9, 1-v, (0.5-(1-v))*9)}); tw(hSel, qE, {Position=U2(h, (0.5-h)*17, 0.5, 0)})
			if not isT then rB.Text=math.round(cl.R*255); rL.Text=rB.Text; gB.Text=math.round(cl.G*255); gL.Text=gB.Text; bB.Text=math.round(cl.B*255); bL.Text=bB.Text end
			if cb then cb(cl) end
		end
		updDisp(false)

		cT.MouseButton1Click:Connect(function()
			opn = not opn
			tw(cF, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = U2(0,220,0,opn and exH or 30)})
			tw(cLbl, TweenInfo.new(0.3), {TextColor3 = opn and C3(200,200,200) or C3(66,66,66)})
			if opn then
				local scr = cF:FindFirstAncestorOfClass("ScrollingFrame")
				if scr then task.delay(0.05, function()
						local tBot = cF.AbsolutePosition.Y - scr.AbsolutePosition.Y + scr.CanvasPosition.Y + exH 
						local vBot = scr.CanvasPosition.Y + scr.AbsoluteWindowSize.Y
						if tBot > vBot then tw(scr, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CanvasPosition=Vector2.new(0, scr.CanvasPosition.Y + (tBot - vBot) + 10)}) end
					end) end
			end
		end)

		local dSV, dH = false, false
		local function mSV(i) s = math.clamp((i.Position.X - sM.AbsolutePosition.X)/sM.AbsoluteSize.X, 0, 1); v = 1 - math.clamp((i.Position.Y - sM.AbsolutePosition.Y)/sM.AbsoluteSize.Y, 0, 1); updDisp(false) end
		local function mH(i) h = math.clamp((i.Position.X - hS.AbsolutePosition.X)/hS.AbsoluteSize.X, 0, 1); updDisp(false) end

		local MB1 = Enum.UserInputType.MouseButton1
		sM.InputBegan:Connect(function(i) if i.UserInputType==MB1 then dSV = true; mSV(i) end end)
		hS.InputBegan:Connect(function(i) if i.UserInputType==MB1 then dH = true; mH(i) end end)
		UIS.InputEnded:Connect(function(i) if i.UserInputType==MB1 then dSV, dH = false, false end end)
		UIS.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement then if dSV then mSV(i) elseif dH then mH(i) end end end)

		local function updRGB(isT)
			local cl = Color3.fromHSV(h,s,v)
			local function gV(bx, df) return tonumber(bx.Text) or math.round(df*255) end
			h,s,v = Color3.fromRGB(math.clamp(gV(rB,cl.R),0,255), math.clamp(gV(gB,cl.G),0,255), math.clamp(gV(bB,cl.B),0,255)):ToHSV()
			updDisp(isT)
		end

		local function hk(bx, lb)
			local lV, isF = "", false
			bx:GetPropertyChangedSignal("Text"):Connect(function()
				if not isF then return end
				local f = bx.Text:gsub("%D",""):sub(1,3)
				if tonumber(f) and tonumber(f)>255 then f="255" end
				if bx.Text~=f then bx.Text=f; return end
				if bx.Text~="" then if lb.Text~=bx.Text then lb.Text, lb.TextTransparency = bx.Text, 1; tw(lb, qE, {TextTransparency=0}) end else tw(lb, TweenInfo.new(0.15), {TextTransparency=1}) end
				updRGB(true)
				if #bx.Text==3 then bx:ReleaseFocus() end
			end)
			bx.Focused:Connect(function() isF, lV = true, lb.Text; tw(lb, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency=1}); task.defer(function() bx.Text="" end) end)
			bx.FocusLost:Connect(function() isF = false; if bx.Text=="" or not tonumber(bx.Text) then bx.Text, lb.Text = lV, lV end; tw(lb, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {TextTransparency=0}); updRGB(false) end)
		end
		hk(rB, rL); hk(gB, gL); hk(bB, bL)
	end)
end

function Library.CreateKeybind(pSet, txt, defB, md, cb)
	md = md or "Mouse"
	local bindFrame = create("Frame", {Name="KeyBind", LayoutOrder=#pSet:GetChildren(), BorderSizePixel=0, Size=U2(0,220,0,30), BackgroundTransparency=1, Parent=pSet})
	local textLabel = create("TextLabel", {Name="Bind", BorderSizePixel=0, TextSize=14, TextXAlignment=Enum.TextXAlignment.Left, FontFace=FNT, TextColor3=C3(75,75,75), BackgroundTransparency=1, Size=U2(0,60,0,30), Text=txt, Parent=bindFrame})
	local hasD = (defB~=nil and defB~="")
	local kB = create("TextBox", {Name="TextBox", PlaceholderColor3=C3(201,201,201), BorderSizePixel=0, TextSize=12, TextDirection=Enum.TextDirection.RightToLeft, TextColor3=C3(201,201,201), BackgroundColor3=C3(21,21,21), FontFace=Font.new("rbxasset://fonts/families/Arial.json"), ClearTextOnFocus=false, Size=U2(0,75,0,20), Position=U2(0.635,0,0.25,0), Text=defB or "", BackgroundTransparency=hasD and 0 or 1, Visible=hasD, TextTransparency=hasD and 0 or 1, TextEditable=false, Interactable=false, Parent=bindFrame})
	create("UICorner", {CornerRadius=U1(0,2), Parent=kB})

	task.spawn(function()
		local TS, UIS = game:GetService("TweenService"), game:GetService("UserInputService")
		local function tw(o, t, p) return TS:Create(o, TweenInfo.new(t, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), p) end
		local hovT, unhT, shoT, hidT = tw(textLabel, 0.35, {TextColor3=C3(200,200,200)}), tw(textLabel, 0.35, {TextColor3=C3(75,75,75)}), tw(kB, 0.5, {TextTransparency=0, BackgroundTransparency=0}), tw(kB, 0.5, {TextTransparency=1, BackgroundTransparency=1})
		local iConn, hov, lastK = nil, false, defB
		if lastK then textLabel.TextColor3 = C3(200,200,200) end
		local function clConn() if iConn then iConn:Disconnect(); iConn = nil end end

		local function onInp(i, gP)
			if not hov then return end
			local fN = nil
			if md=="KeyBind" or md=="Both" then
				if i.UserInputType==Enum.UserInputType.Keyboard and i.KeyCode.Name~="Unknown" then fN = i.KeyCode.Name end
			end
			if (md=="Mouse" or md=="Both") and not fN then
				local iN = i.UserInputType.Name
				if string.find(iN, "MouseButton") then
					local bNum = tonumber(string.match(iN, "%d+"))
					fN = bNum and ("xbutton"..bNum) or string.lower(iN)
					if fN=="unknown" then fN=nil end
				end
			end
			if fN and fN~=lastK then
				lastK, kB.Text, kB.Visible, kB.TextTransparency, kB.BackgroundTransparency = fN, fN, true, 1, 1
				shoT:Cancel(); hidT:Cancel(); shoT:Play(); hovT:Play(); if cb then cb(fN) end
			end
		end

		bindFrame.MouseEnter:Connect(function() hov = true; clConn(); iConn = UIS.InputBegan:Connect(onInp); if lastK then shoT:Play(); kB.Visible = true; hovT:Play() end end)
		bindFrame.MouseLeave:Connect(function() hov = false; clConn(); if not lastK then unhT:Play(); hidT:Play(); task.delay(0.52, function() if not hov and not lastK then kB.Visible = false end end) else hovT:Play() end end)
		local pg = bindFrame:FindFirstAncestorOfClass("PlayerGui")
		if pg then pg.AncestryChanged:Connect(function(_, p) if not p then clConn() end end) end
	end)
end

-- scripts
local UIS, RS, TS, T = game:GetService("UserInputService"), game:GetService("RunService"), game:GetService("TweenService"), Enum.UserInputType
local mb1, tch, mm, twI = T.MouseButton1, T.Touch, T.MouseMovement, TweenInfo.new(0.2, Enum.EasingStyle.Quad)

task.spawn(function()
	local f = flessia_LocalScript.Parent
	f.Visible = false -- Forces the GUI to be hidden on startup
	local vis, pos, drag, dSt, sSt = false, f.Position, false, nil, nil

	UIS.InputBegan:Connect(function(i, gp) if not gp and i.KeyCode == Enum.KeyCode.Insert then vis = not vis; f.Visible = vis; if vis then pos = f.Position end end end)
	f.InputBegan:Connect(function(i) if i.UserInputType == mb1 or i.UserInputType == tch then drag, dSt, sSt = true, i.Position, pos end end)
	UIS.InputEnded:Connect(function(i) if i.UserInputType == mb1 or i.UserInputType == tch then drag = false end end)
	UIS.InputChanged:Connect(function(i) if drag and (i.UserInputType == mm or i.UserInputType == tch) then local d = i.Position - dSt; pos = U2(sSt.X.Scale, sSt.X.Offset + d.X, sSt.Y.Scale, sSt.Y.Offset + d.Y) end end)
	RS.RenderStepped:Connect(function() if f.Visible then f.Position = f.Position:Lerp(pos, 0.2) end end)
end)

task.spawn(function()
	local btns, cg, cur = tab_switching.Parent, tab_switching.Parent.Parent:WaitForChild("CanvasGroup")
	local function set(b, a)
		local tc, bg = a and C3(200,200,200) or C3(65,65,65), a and C3(20,20,20) or C3(10,10,10)
		local link = b:FindFirstChild("LinkedFrame")
		local t = link and link.Value 

		TS:Create(b, twI, {TextColor3 = tc, BackgroundColor3 = bg, BackgroundTransparency = a and 0 or 1}):Play()
		if b:FindFirstChild("Icon") then TS:Create(b.Icon, twI, {ImageColor3 = tc}):Play() end
		if b:FindFirstChild("SelectionBar") then TS:Create(b.SelectionBar, twI, {BackgroundTransparency = a and 0 or 1}):Play() end
		if t then t.Visible = a end
	end

	for _, t in ipairs(cg:GetChildren()) do if t:IsA("GuiObject") then t.Visible = false end end
	for _, c in ipairs(btns:GetChildren()) do
		if c:IsA("TextButton") then
			c.AutoButtonColor = false
			create("UICorner", {CornerRadius = U1(0,3), Parent = c})
			create("Frame", {Name = "SelectionBar", Size = U2(0,2,0.6,0), Position = U2(0,0,0.5,0), AnchorPoint = Vector2.new(0,0.5), BackgroundColor3 = C3(255,255,255), BorderSizePixel = 0, BackgroundTransparency = 1, Parent = c})
			set(c, false)
			c.MouseButton1Click:Connect(function() if cur ~= c then if cur then set(cur, false) end; cur = c; set(c, true) end end)
			if not cur then cur = c; set(c, true) end
		end
	end
end)

return Library
