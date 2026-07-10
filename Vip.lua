local player = game.Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")
local core = game:GetService("CoreGui")

-- 1. Визуальная подмена имени
player.DisplayName = "★ VIP ★ " .. player.Name
player.Name = "★ VIP ★ " .. player.Name

-- 2. Поиск и активация VIP-интерфейса
pcall(function()
    local vipFrame = gui:FindFirstChild("VIPFrame", true) or core:FindFirstChild("VIPFrame", true)
    if vipFrame then
        vipFrame.Visible = true
        vipFrame.Enabled = true
        for _, child in ipairs(vipFrame:GetDescendants()) do
            if child:IsA("TextButton") or child:IsA("ImageButton") then
                child:FireAllClients()  -- Имитация нажатия
            end
        end
    end
end)

-- 3. Поддельный RemoteEvent для сервера (если такой существует)
local remote = game:GetService("ReplicatedStorage"):FindFirstChild("VIPCheckRemote")
if remote then
    remote:FireServer({["vip"] = true, ["token"] = "FAKE_VIP_2026"})
end

-- 4. Перехват и блокировка серверных проверок (мок)
local oldMet = getmetatable(player)
local newIndex = oldMet and oldMet.__index
if newIndex then
    oldMet.__index = function(t, k)
        if k == "VIPStatus" or k == "IsVIP" then
            return true
        end
        return newIndex(t, k)
    end
end

print("[Ryzen] VIP-статус активирован (клиентская симуляция)")
