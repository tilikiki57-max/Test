-- Fly Script | Delta Executor
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Flying = false
local Speed = 50
local BodyGyro, BodyVelocity
local Keys = {W = false, S = false, A = false, D = false, Space = false, Ctrl = false}

local function StartFly()
    local Char = Player.Character
    if not Char then return end
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    
    BodyGyro = Instance.new("BodyGyro")
    BodyGyro.P = 9e4
    BodyGyro.MaxTorque = Vector3.new(9e4, 9e4, 9e4)
    BodyGyro.Parent = HRP
    
    BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
    BodyVelocity.Parent = HRP
    
    Flying = true
end

local function StopFly()
    if BodyGyro then BodyGyro:Destroy() end
    if BodyVelocity then BodyVelocity:Destroy() end
    Flying = false
end

UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and Flying then
        if input.KeyCode == Enum.KeyCode.W then Keys.W = true
        elseif input.KeyCode == Enum.KeyCode.S then Keys.S = true
        elseif input.KeyCode == Enum.KeyCode.A then Keys.A = true
        elseif input.KeyCode == Enum.KeyCode.D then Keys.D = true
        elseif input.KeyCode == Enum.KeyCode.Space then Keys.Space = true
        elseif input.KeyCode == Enum.KeyCode.LeftControl then Keys.Ctrl = true
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then Keys.W = false
    elseif input.KeyCode == Enum.KeyCode.S then Keys.S = false
    elseif input.KeyCode == Enum.KeyCode.A then Keys.A = false
    elseif input.KeyCode == Enum.KeyCode.D then Keys.D = false
    elseif input.KeyCode == Enum.KeyCode.Space then Keys.Space = false
    elseif input.KeyCode == Enum.KeyCode.LeftControl then Keys.Ctrl = false
    end
end)

RunService.RenderStepped:Connect(function()
    if not Flying then return end
    local Char = Player.Character
    if not Char then return end
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    
    local Cam = workspace.CurrentCamera
    local MoveDir = Vector3.new(0, 0, 0)
    
    if Keys.W then MoveDir += Cam.CFrame.LookVector end
    if Keys.S then MoveDir -= Cam.CFrame.LookVector end
    if Keys.D then MoveDir += Cam.CFrame.RightVector end
    if Keys.A then MoveDir -= Cam.CFrame.RightVector end
    if Keys.Space then MoveDir += Vector3.new(0, 1, 0) end
    if Keys.Ctrl then MoveDir -= Vector3.new(0, 1, 0) end
    
    if MoveDir.Magnitude > 0 then
        BodyVelocity.Velocity = MoveDir.Unit * Speed
    else
        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    end
    
    BodyGyro.CFrame = CFrame.new(HRP.Position, HRP.Position + Cam.CFrame.LookVector)
end)

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 180, 0, 60)
Frame.Position = UDim2.new(0.5, -90, 0.1, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local FlyBtn = Instance.new("TextButton", Frame)
FlyBtn.Size = UDim2.new(1, -20, 0, 40)
FlyBtn.Position = UDim2.new(0, 10, 0, 10)
FlyBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Text = "FLY: OFF"
FlyBtn.BorderSizePixel = 0
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 18

FlyBtn.MouseButton1Click:Connect(function()
    if not Flying then
        StartFly()
        FlyBtn.Text = "FLY: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        StopFly()
        FlyBtn.Text = "FLY: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
    end
end)
