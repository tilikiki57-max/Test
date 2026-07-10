-- LocalScript для Delta (Roblox)
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

-- Состояния
local flying = false
local auraRadius = 12
local particles = {}
local auraPart = nil
local bodyVel = nil
local moveConn = nil
local runConn = nil

-- Функция создания ауры
local function createAura()
    if auraPart then auraPart:Destroy() end
    auraPart = Instance.new("Part")
    auraPart.Shape = Enum.PartType.Ball
    auraPart.Size = Vector3.new(auraRadius, auraRadius, auraRadius)
    auraPart.BrickColor = BrickColor.new("Really red")
    auraPart.Material = Enum.Material.Neon
    auraPart.Anchored = true
    auraPart.CanCollide = false
    auraPart.Transparency = 0.4
    auraPart.Parent = workspace
    
    while flying and auraPart do
        auraPart.Position = root.Position
        auraPart.Transparency = 0.3 + 0.3 * math.sin(tick() * 5)
        auraPart.Size = Vector3.new(auraRadius, auraRadius, auraRadius) * (1 + 0.15 * math.sin(tick() * 4))
        task.wait()
    end
    if auraPart then auraPart:Destroy() end
end

-- Функция партиклов (килл-эффект)
local function spawnKillParticles()
    while flying do
        for i = 1, 4 do
            local part = Instance.new("Part")
            part.Size = Vector3.new(0.4, 0.4, 0.4)
            part.BrickColor = BrickColor.new("Bright red")
            part.Material = Enum.Material.Neon
            part.Anchored = true
            part.CanCollide = false
            part.Position = root.Position + Vector3.new(
                math.random(-8, 8),
                math.random(-3, 5),
                math.random(-8, 8)
            )
            part.Parent = workspace
            
            game:GetService("Debris"):AddItem(part, 1.2)
            local start = tick()
            game:GetService("RunService").Heartbeat:Connect(function()
                if not part.Parent then return end
                local life = (tick() - start) / 1.2
                if life >= 1 then part:Destroy() return end
                part.Transparency = life
                part.Size = Vector3.new(0.4, 0.4, 0.4) * (1 + life * 3)
            end)
        end
        task.wait(0.08)
    end
end

-- Включение/выключение полёта
local function toggleFlight()
    flying = not flying
    
    if flying then
        -- Отключаем гравитацию
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        
        -- BodyVelocity для полёта
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVel.Velocity = Vector3.new(0, 15, 0)
        bodyVel.Parent = root
        
        -- Управление WASD
        moveConn = game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
            if gp then return end
            local speed = 25
            if input.KeyCode == Enum.KeyCode.W then bodyVel.Velocity = Vector3.new(0, speed, 0) end
            if input.KeyCode == Enum.KeyCode.S then bodyVel.Velocity = Vector3.new(0, -speed, 0) end
            if input.KeyCode == Enum.KeyCode.A then bodyVel.Velocity = Vector3.new(-speed, 0, 0) end
            if input.KeyCode == Enum.KeyCode.D then bodyVel.Velocity = Vector3.new(speed, 0, 0) end
        end)
        
        -- Запуск эффектов
        task.spawn(createAura)
        task.spawn(spawnKillParticles)
        
    else
        -- Выключаем всё
        if bodyVel then bodyVel:Destroy() end
        if moveConn then moveConn:Disconnect() end
        if auraPart then auraPart:Destroy() end
        
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
end

-- Горячая клавиша (P)
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.P then
        toggleFlight()
    end
end)

-- Защита от вылета при респе
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    root = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
    flying = false
    if auraPart then auraPart:Destroy() end
end)
