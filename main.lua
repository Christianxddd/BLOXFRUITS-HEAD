-- XRNL HUB – Android/PC | Steal a Brainlol
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Crear gui
local gui = Instance.new("ScreenGui")
gui.Name = "XRNL_HUB"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- Frame principal
local frame = Instance.new("Frame", gui)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Size = UDim2.new(0,420,0,340)
frame.Position = UDim2.new(0.3,0,0.2,0)
frame.Active = true
frame.Draggable = true

-- Título
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(15,15,15)
title.Text = "🧠 XRNL HUB - Steal a Brainlol"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Layout
local layout = Instance.new("UIListLayout", frame)
layout.Padding = UDim.new(0,5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.VerticalAlignment = Enum.VerticalAlignment.Top

-- Rainbow effect
local function rainbowify(btn)
    local hue = 0
    local conn
    conn = RunService.RenderStepped:Connect(function()
        if not btn or not btn.Parent then conn:Disconnect(); return end
        hue = (hue + 0.005) % 1
        btn.BackgroundColor3 = Color3.fromHSV(hue,1,1)
    end)
end

-- Botón generador
local function crearBtn(text,callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,-10,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- Estados
local speedOn, jumpOn, ragdollOff, espOn, autoGrab, autoDeliver = false,false,false,false,false,false

-- Funciones
crearBtn("🏃 Velocidad ON/OFF", function(b)
    speedOn = not speedOn
    b.Text = speedOn and "Velocidad: ON" or "Velocidad: OFF"
    speedOn and rainbowify(b)
    task.spawn(function()
        while speedOn do
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").WalkSpeed = 100
            end
            task.wait(0.2)
        end
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end)
end)

crearBtn("🦘 Salto ON/OFF", function(b)
    jumpOn = not jumpOn
    b.Text = jumpOn and "Salto: ON" or "Salto: OFF"
    jumpOn and rainbowify(b)
    task.spawn(function()
        while jumpOn do
            local char = LocalPlayer.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                char:FindFirstChildOfClass("Humanoid").JumpPower = 120
            end
            task.wait(0.2)
        end
        if LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
        end
    end)
end)

crearBtn("🚫 No Ragdoll ON/OFF", function(b)
    ragdollOff = not ragdollOff
    b.Text = ragdollOff and "No Ragdoll: ON" or "No Ragdoll: OFF"
    ragdollOff and rainbowify(b)
    task.spawn(function()
        while ragdollOff do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Ragdoll") then
                char.Ragdoll:Destroy()
            end
            task.wait(0.1)
        end
    end)
end)

crearBtn("🔍 ESP Jugadores/Cerebros", function(b)
    espOn = not espOn
    b.Text = espOn and "ESP: ON" or "ESP: OFF"
    espOn and rainbowify(b)
    if espOn then
        for _,v in pairs(Players:GetPlayers()) do
            if v~=LocalPlayer and v.Character then
                local h=Instance.new("Highlight",v.Character)
                h.FillColor=Color3.fromRGB(255,0,0)
                h.Name="XRNL_ESP"
            end
        end
        for _,obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Part") and obj.Name:lower():find("brain") then
                local h=Instance.new("Highlight",obj)
                h.FillColor=Color3.fromRGB(0,255,0)
                h.Name="XRNL_ESP"
            end
        end
    else
        for _,h in pairs(workspace:GetDescendants()) do
            if h:IsA("Highlight") and h.Name=="XRNL_ESP" then
                h:Destroy()
            end
        end
    end
end)

crearBtn("🧠 Auto Grab Brain", function(b)
    autoGrab = not autoGrab
    b.Text = autoGrab and "Auto Grab: ON" or "Auto Grab: OFF"
    autoGrab and rainbowify(b)
    task.spawn(function()
        while autoGrab do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") and v.Name:lower():find("brain") and (v.Position-char.HumanoidRootPart.Position).Magnitude<10 then
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                    end
                end
            end
            task.wait(0.7)
        end
    end)
end)

crearBtn("📤 Auto Deliver Brain", function(b)
    autoDeliver = not autoDeliver
    b.Text = autoDeliver and "Auto Deliver: ON" or "Auto Deliver: OFF"
    autoDeliver and rainbowify(b)
    task.spawn(function()
        while autoDeliver do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _,v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Part") and v.Name:lower():find("score") and (v.Position-char.HumanoidRootPart.Position).Magnitude<8 then
                        firetouchinterest(char.HumanoidRootPart, v, 0)
                        firetouchinterest(char.HumanoidRootPart, v, 1)
                    end
                end
            end
            task.wait(0.7)
        end
    end)
end)

crearBtn("❌ Cerrar Panel", function()
    gui:Destroy()
end)
