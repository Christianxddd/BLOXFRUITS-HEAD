-- XRNL HUB - STEAL A BRAINLOL | By Christianxddd
-- Totalmente compatible con KRNL Android y PC

local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local mouse = plr:GetMouse()
local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "XRNL_HUB"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 420, 0, 320)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "🧠 XRNL HUB - Steal a Brainlol"
title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.VerticalAlignment = Enum.VerticalAlignment.Top

local function rainbowify(obj)
	local hue = 0
	local connection
	connection = runService.RenderStepped:Connect(function()
		if obj.BackgroundColor3 == Color3.fromRGB(40,40,40) then
			connection:Disconnect()
			return
		end
		hue = (hue + 0.005) % 1
		obj.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
	end)
end

local function crearBoton(nombre, func)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Text = nombre
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		func(btn)
	end)
	return btn
end

-- ESTADOS
local speedOn = false
local jumpOn = false
local noRagdoll = false
local autoGrab = false
local autoDeliver = false
local espOn = false

crearBoton("🏃 Velocidad ON/OFF", function(btn)
	speedOn = not speedOn
	if speedOn then
		btn.Text = "Velocidad: ON"
		rainbowify(btn)
		while speedOn and task.wait() do
			if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
				plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 100
			end
		end
	else
		btn.Text = "Velocidad: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
			plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
		end
	end
end)

crearBoton("🦘 Salto ON/OFF", function(btn)
	jumpOn = not jumpOn
	if jumpOn then
		btn.Text = "Salto: ON"
		rainbowify(btn)
		while jumpOn and task.wait() do
			if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
				plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = 120
			end
		end
	else
		btn.Text = "Salto: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
			plr.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
		end
	end
end)

crearBoton("🚫 No Ragdoll ON/OFF", function(btn)
	noRagdoll = not noRagdoll
	if noRagdoll then
		btn.Text = "No Ragdoll: ON"
		rainbowify(btn)
		while noRagdoll and task.wait(0.1) do
			local rag = plr.Character and plr.Character:FindFirstChild("Ragdoll")
			if rag then rag:Destroy() end
		end
	else
		btn.Text = "No Ragdoll: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end
end)

crearBoton("🔍 ESP Jugadores/Cerebros", function(btn)
	espOn = not espOn
	if espOn then
		btn.Text = "ESP: ON"
		rainbowify(btn)
		for _,v in pairs(game:GetService("Players"):GetPlayers()) do
			if v ~= plr and v.Character then
				local esp = Instance.new("Highlight", v.Character)
				esp.FillColor = Color3.fromRGB(255, 0, 0)
				esp.Name = "XRNL_ESP"
			end
		end
		for _,brain in pairs(workspace:GetDescendants()) do
			if brain:IsA("Part") and brain.Name:lower():find("brain") then
				local esp = Instance.new("Highlight", brain)
				esp.FillColor = Color3.fromRGB(0, 255, 0)
				esp.Name = "XRNL_ESP"
			end
		end
	else
		btn.Text = "ESP: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		for _,v in pairs(workspace:GetDescendants()) do
			if v:IsA("Highlight") and v.Name == "XRNL_ESP" then
				v:Destroy()
			end
		end
	end
end)

crearBoton("🧠 Auto Grab Brain", function(btn)
	autoGrab = not autoGrab
	if autoGrab then
		btn.Text = "Auto Grab: ON"
		rainbowify(btn)
		while autoGrab and task.wait(0.5) do
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("Part") and v.Name:lower():find("brain") and (v.Position - char.HumanoidRootPart.Position).Magnitude < 10 then
					firetouchinterest(char.HumanoidRootPart, v, 0)
					firetouchinterest(char.HumanoidRootPart, v, 1)
				end
			end
		end
	else
		btn.Text = "Auto Grab: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end
end)

crearBoton("📤 Auto Deliver Brain", function(btn)
	autoDeliver = not autoDeliver
	if autoDeliver then
		btn.Text = "Auto Deliver: ON"
		rainbowify(btn)
		while autoDeliver and task.wait(1) do
			for _,v in pairs(workspace:GetDescendants()) do
				if v:IsA("Part") and v.Name:lower():find("score") then
					firetouchinterest(char.HumanoidRootPart, v, 0)
					firetouchinterest(char.HumanoidRootPart, v, 1)
				end
			end
		end
	else
		btn.Text = "Auto Deliver: OFF"
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	end
end)

crearBoton("❌ Cerrar Panel", function()
	gui:Destroy()
		-- Mostrar automáticamente el panel al cargar
frame.Visible = true

end)
