-- XRNL Redz Replica - Parte 1: Icono, protección base y panel
local iconID = "rbxassetid://120008128829681"
local player = game.Players.LocalPlayer
local guiService = game:GetService("StarterGui")
local coreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Protección básica
local function protect()
    if setfflag then
        setfflag("AbuseReportScreenshot", "False")
        setfflag("AbuseReportScreenshotPercentage", "0")
        setfflag("DFFlagAbuseReportScreenshot", "False")
    end
    if hookfunction then
        pcall(function()
            hookfunction(game:GetService("Players").LocalPlayer.Kick, function() end)
        end)
    end
end
protect()

-- Crear ícono flotante
local iconButton = Instance.new("ImageButton")
iconButton.Name = "XRNLIcon"
iconButton.Size = UDim2.new(0, 60, 0, 60)
iconButton.Position = UDim2.new(0, 20, 0.5, -30)
iconButton.Image = iconID
iconButton.BackgroundTransparency = 1
iconButton.Draggable = true
iconButton.Active = true
iconButton.Parent = coreGui

-- Crear el panel base
local panel = Instance.new("Frame")
panel.Name = "XRNLPanel"
panel.Size = UDim2.new(0, 500, 0, 400)
panel.Position = UDim2.new(0.5, -250, 0.5, -200)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = coreGui

-- Borde rainbow (decorativo)
local function rainbowBorder(frame)
    local border = Instance.new("UIStroke", frame)
    border.Thickness = 2
    task.spawn(function()
        while task.wait() do
            for hue = 0, 1, 0.01 do
                border.Color = Color3.fromHSV(hue, 1, 1)
                wait(0.02)
            end
        end
    end)
end
rainbowBorder(panel)

-- Título
local title = Instance.new("TextLabel")
title.Text = "XRNL HUB | Redz Style"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = panel

-- Mostrar/Ocultar panel
iconButton.MouseButton1Click:Connect(function()
    panel.Visible = not panel.Visible
end)

-- Continuará en Parte 2...
-- === XRNL HUB REDZ Style (PARTE 2) ===

-- Función: ESP para enemigos y jugadores
function CreateESP(target, color)
    local Billboard = Instance.new("BillboardGui", target)
    Billboard.Adornee = target
    Billboard.Size = UDim2.new(0, 100, 0, 40)
    Billboard.StudsOffset = Vector3.new(0, 3, 0)
    Billboard.AlwaysOnTop = true

    local Name = Instance.new("TextLabel", Billboard)
    Name.Size = UDim2.new(1, 0, 1, 0)
    Name.Text = target.Name
    Name.TextColor3 = color
    Name.BackgroundTransparency = 1
    Name.TextStrokeTransparency = 0.5
end

function ActivateESP()
    for i,v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            CreateESP(v.Character:FindFirstChild("Head"), Color3.new(1, 0, 0))
        end
    end

    for i,v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Head") then
            CreateESP(v.Head, Color3.new(0, 1, 0))
        end
    end
end

-- Función: AutoFarm enemigos por nombre
function AutoFarm(enemyName)
    while _G.AutoFarm do
        local enemy = nil
        for i,v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == enemyName then
                enemy = v
                break
            end
        end

        if enemy and enemy:FindFirstChild("HumanoidRootPart") then
            pcall(function()
                repeat wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
                    local args = {
                        [1] = enemy
                    }
                    game:GetService("ReplicatedStorage").Remotes.Combat:FireServer(unpack(args))
                until enemy.Humanoid.Health <= 0 or not _G.AutoFarm
            end)
        end

        wait(0.5)
    end
end

-- Función: AutoHaki
function AutoHaki()
    while _G.AutoHaki do
        wait(1)
        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
            game:GetService("ReplicatedStorage").Remotes.Combat:FireServer("Buso")
        end
    end
end

-- Función: AutoSkill Z,X,C,V
function AutoSkills()
    while _G.AutoSkills do
        wait(1)
        for _, key in ipairs({"Z", "X", "C", "V"}) do
            keypress(Enum.KeyCode[key])
            wait(0.1)
            keyrelease(Enum.KeyCode[key])
        end
    end
end

-- Función: Teleport a zona
function TeleportTo(place)
    if place and place:FindFirstChild("CFrame") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = place.CFrame
    end
end

-- Función: Auto recoger fruta
function AutoFruitGrab()
    while _G.AutoFruit do
        for i,v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and v.Name:lower():find("fruit") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
            end
        end
        wait(3)
    end
end

-- Función: No Clip
function EnableNoClip()
    game:GetService("RunService").Stepped:Connect(function()
        if _G.NoClip then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end

-- Anticheat bypass (simple)
pcall(function()
    local old
    old = hookmetamethod(game, "__namecall", function(self, ...)
        local args = {...}
        local method = getnamecallmethod()
        if tostring(self) == "Kick" or tostring(method) == "Kick" then
            return
        end
        return old(self, unpack(args))
    end)
end)

-- Opcional: Invisibilidad simple
function BecomeInvisible()
    local character = game.Players.LocalPlayer.Character
    character.HumanoidRootPart.Transparency = 1
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
end

-- === FIN DE PARTE 2 ===
-- FUNCIONES EXTRA DE FARMEO INTELIGENTE
function FindEnemy()
    local closest, distance = nil, math.huge
    for _,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local dist = (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if dist < distance then
                closest = v
                distance = dist
            end
        end
    end
    return closest
end

spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            local target = FindEnemy()
            if target then
                pcall(function()
                    repeat task.wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0,10,0)
                        game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
                    until not target:FindFirstChild("Humanoid") or target.Humanoid.Health <= 0 or not _G.AutoFarm
                end)
            end
        end
    end
end)

-- DEVIL FRUIT NOTIFICADOR Y AUTO-COLLECT
local function NotifyFruit(msg)
    game.StarterGui:SetCore("SendNotification", {
        Title = "🍍 Fruta Detectada",
        Text = msg,
        Duration = 10
    })
end

local function AutoFruitCollector()
    for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v:IsA("Tool") and string.find(v.Name:lower(),"fruit") then
            NotifyFruit("¡Fruta encontrada!: "..v.Name)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
        end
    end
end

spawn(function()
    while task.wait(15) do
        if _G.AutoFruit then
            AutoFruitCollector()
        end
    end
end)

-- PROTECCIÓN ANTICHEAT BÁSICA (ANTI-DETECCIÓN)
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt,false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self,...)
        local method = getnamecallmethod()
        if method == "Kick" then
            return wait(9e9)
        end
        return old(self,...)
    end)
end)

-- MONEDA ILIMITADA / FARM DE BERRIES (SOLO SI POSIBLE)
function AutoMoneyFarm()
    -- función depende del enemigo que da más reward en el momento
    -- o en bosses
end

-- AUTO-HAKI
spawn(function()
    while task.wait(1) do
        if _G.AutoHaki then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.Combat.ActivateHaki:FireServer()
            end)
        end
    end
end)

-- AUTO-SKILLS
spawn(function()
    while task.wait() do
        if _G.AutoSkill then
            local skills = {"Z", "X", "C", "V"}
            for _, key in pairs(skills) do
                game:GetService("VirtualInputManager"):SendKeyEvent(true,key,false,game)
                wait(1)
            end
        end
    end
end)

-- FINAL DE PARTE 3
print("Parte 3 cargada correctamente")
-- Auto Haki Toggle
local autoHaki = false
spawn(function()
	while wait(1) do
		if autoHaki and not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, "J", false, game)
			wait(0.2)
			game:GetService("VirtualInputManager"):SendKeyEvent(false, "J", false, game)
		end
	end
end)

createToggle("Auto Haki", function(state)
	autoHaki = state
end)

-- Auto Skill Spam
local autoSkills = false
createToggle("Auto Skills", function(state)
	autoSkills = state
end)

spawn(function()
	while wait(0.5) do
		if autoSkills then
			for _, skill in ipairs({"Z", "X", "C", "V", "F"}) do
				game:GetService("VirtualInputManager"):SendKeyEvent(true, skill, false, game)
				wait(0.2)
				game:GetService("VirtualInputManager"):SendKeyEvent(false, skill, false, game)
			end
		end
	end
end)

-- Anti-AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- FPS Boost
createButton("FPS Boost", function()
	for _, v in pairs(game:GetDescendants()) do
		if v:IsA("BasePart") and not v:IsA("MeshPart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("Decal") then
			v.Transparency = 1
		elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
			v.Lifetime = NumberRange.new(0)
		end
	end
	sethiddenproperty(game:GetService("Lighting"), "Technology", Enum.Technology.Compatibility)
end)

-- Anti-Cheat Bypass
local function disableAntiCheat()
	for _,v in pairs(getgc(true)) do
		if type(v) == "function" and getfenv(v).script and tostring(getfenv(v).script):find("AntiCheat") then
			pcall(function() hookfunction(v, function() return wait(9e9) end) end)
		end
	end
end

createButton("Bypass Anti-Cheat", disableAntiCheat)

-- Notification
local function Notify(text)
	game.StarterGui:SetCore("SendNotification", {
		Title = "XRNL Hub (Redz-Style)",
		Text = text,
		Duration = 5
	})
end

Notify("Hub Redz Style Cargado ✅")
-- 🟣 FINAL DEL SCRIPT (Parte 5)
-- 🟢 Auto Collect Devil Fruits
local function autoFruitCollector()
    spawn(function()
        while getgenv().AutoFruit do
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(v.Name:lower(), "fruit") then
                    pcall(function()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                        wait(1)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 0)
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Handle, 1)
                    end)
                end
            end
            wait(3)
        end
    end)
end

FruitCollectorToggle.MouseButton1Click:Connect(function()
    getgenv().AutoFruit = not getgenv().AutoFruit
    FruitCollectorToggle.BackgroundColor3 = getgenv().AutoFruit and Color3.fromRGB(85, 255, 85) or Color3.fromRGB(255, 85, 85)
    autoFruitCollector()
end)

-- 🟢 Anti AFK
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- 🟢 Protección Básica Anti-Detección (Anti-Cheat Bypass)
local function basicBypass()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt,false)

    mt.__namecall = newcclosure(function(self,...)
        local args = {...}
        local method = getnamecallmethod()
        if tostring(self) == "RemoteEvent" and method == "FireServer" and args[1] == "Ban" then
            return warn("Anticheat bloqueado: intento de baneo bloqueado.")
        end
        return old(self,...)
    end)
end

pcall(basicBypass)

-- 🟢 Créditos
Credits.MouseButton1Click:Connect(function()
    setclipboard("https://tiktok.com/@christianxdd")
    notify("Créditos", "TikTok copiado al portapapeles", 5)
end)

-- 🟢 Aviso Final
notify("XRNL HUB Cargado", "Todas las funciones están activas.\nDisfruta Blox Fruits con protección.", 8)
