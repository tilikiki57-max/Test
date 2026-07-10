-- GUI + DeltaKill System
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Функция убийства (ваша)
function DeltaKill(target)
    if not target or not target.Character then return end
    target.Character:SetAttribute("VisualState", 0)
    local humanoid = target.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = 0
    end
    target.Character:BreakJoints()
end

-- Создание GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -10, 1, -60)
list.Position = UDim2.new(0, 5, 0, 5)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.Parent = frame

local killBtn = Instance.new("TextButton")
killBtn.Size = UDim2.new(1, -10, 0, 40)
killBtn.Position = UDim2.new(0, 5, 1, -45)
killBtn.Text = "[ KILL SELECTED ]"
killBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
killBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
killBtn.Parent = frame

local selectedTarget = nil

-- Обновление списка
local function updateList()
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local y = 0
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Position = UDim2.new(0, 0, 0, y)
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            btn.Text = p.Name .. " | " .. (p.Character and p.Character.Name or "No Skin")
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Parent = list

            btn.MouseButton1Click:Connect(function()
                selectedTarget = p
                for _, b in ipairs(list:GetChildren()) do
                    if b:IsA("TextButton") then
                        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    end
                end
                btn.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
            end)

            y = y + 35
        end
    end
    list.CanvasSize = UDim2.new(0, 0, 0, y)
end

killBtn.MouseButton1Click:Connect(function()
    if selectedTarget then
        DeltaKill(selectedTarget.Character)
    end
end)

updateList()
Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
