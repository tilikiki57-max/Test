--[[
    NoClip Script (Дельта)
    E - включить/выключить
]]

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local noclip = false
local connection

local function enableNoclip()
    if connection then connection:Disconnect() end
    connection = RunService.Stepped:Connect(function()
        if Character and Character:FindFirstChild("HumanoidRootPart") then
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide == true then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function disableNoclip()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    if Character then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        noclip = not noclip
        if noclip then
            enableNoclip()
        else
            disableNoclip()
        end
    end
end)

Player.CharacterAdded:Connect(function(newChar)
    Character = newChar
    if noclip then
        enableNoclip()
    end
end)

print("NoClip загружен. Нажимай E для включения/выключения.")
