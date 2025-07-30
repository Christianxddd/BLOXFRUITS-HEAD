local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local uis = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local runService = game:GetService("RunService")

-- Crear GUI Principal
local ScreenGui = Instance.new("ScreenGui", coreGui)
ScreenGui.Name = "XRNL_HUB"
ScreenGui.ResetOnSpawn = false

-- Función Rainbow
local function rainbowify(obj)
    local hue = 0
    runService.RenderStepped:Connect(function()
        hue = (hue + 0.001) % 1
        obj.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
    end)
end

-- Crear Frame del Panel
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 400, 0, 300)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- Título
local Title = Instance.new("TextLabel", Frame)
Title.Text = "🧠 XRNL HUB - Steal a Brainlol"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

-- Layout
local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Botón generador
local function crearBoton(nombre, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Position = UDim2.new(0, 5, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Text = nombre
	btn.Font = Enum.Font.Gotham
	btn.TextScaled = true
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(function()
		callback(btn)
	end)
	return btn
end

-- Estados
local speedOn, jumpOn, ragdollOff, espOn, autoGrabOn, autoDeliverOn = false, false, false, false, false, false

-- SPEED
crearBoton("🏃 Velocidad ON/OFF", function(btn)
	speedOn = not speedOn
	if speedOn then
		btn.Text = "Velocidad: ON"
		rainbowify(btn)
		while speedOn and task.wait() do
			player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 100
		end
	else
		btn.Text = "Velocidad: OFF"
		player.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
	end
end)

-- JUMP
crearBoton("🦘 Salto ON/OFF", function(btn)
	jumpOn = not jumpOn
	if jumpOn then
		btn.Text = "Salto: ON"
		rainbowify(btn)
		while jumpOn and task.wait() do
			player.Character:FindFirstChildOfClass("Humanoid").JumpPower = 120
		end
	else
		btn.Text = "Salto: OFF"
		player.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
	end
end)

-- NO RAGDOLL
crearBoton("🚫 No Ragdoll", function(btn)
	ragdollOff = not ragdollOff
	if ragdollOff then
		btn.Text = "No Ragdoll: ON"
		rainbowify(btn)
		while ragdollOff and task.wait(0.1) do
			if player.Character:FindFirstChild("Ragdoll") then
				player.Character.Ragdoll:Destroy()
			end
		end
	else
		btn.Text = "No Ragdoll: OFF"
	end
end)
