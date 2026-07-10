--[[
    Draggable Button для NoClip (Дельта)
    Использовать через loadstring / вставить в execute
]]

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DraggableButtonGUI"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local Button = Instance.new("TextButton")
Button.Name = "DraggableButton"
Button.Size = UDim2.new(0, 160, 0, 45)
Button.Position = UDim2.new(0.5, -80, 0.5, -22)
Button.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
Button.Text = "НАЖМИ"
Button.TextColor3 = Color3.fromRGB(255, 255, 255)
Button.Font = Enum.Font.GothamBold
Button.TextSize = 17
Button.BorderSizePixel = 0
Button.AutoButtonColor = false
Button.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Button

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.5
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Transparency = 0.3
UIStroke.Parent = Button

-- ===== ПЕРЕТАСКИВАНИЕ =====
local dragging = false
local dragStart = Vector2.new()
local startPos = Vector2.new()

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Button.AbsolutePosition
        Button.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Button.Position = UDim2.new(0, startPos.X + delta.X, 0, startPos.Y + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        Button.BackgroundColor3 = Color3.fromRGB(233, 69, 96)
    end
end)

-- ===== КЛИК =====
Button.MouseButton1Click:Connect(function()
    print("Кнопка нажата!")
    -- Добавь сюда свой функционал
end)

print("Draggable Button загружен. Перетаскивай!")
