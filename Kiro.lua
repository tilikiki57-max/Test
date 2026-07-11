-- Credits to girl00kidd
local ScreenGui = Instance.new("ScreenGui")
local ImageLabel = Instance.new("ImageLabel")
local ParticleButton = Instance.new("TextButton")
local SkyboxButton = Instance.new("TextButton")
local CreditsLabel = Instance.new("TextLabel")

ScreenGui.Name = "ImageInterface"
ScreenGui.Parent = game.CoreGui

CreditsLabel.Name = "CreditsLabel"
CreditsLabel.Parent = ScreenGui
CreditsLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
CreditsLabel.BackgroundTransparency = 0
CreditsLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
CreditsLabel.Size = UDim2.new(0, 400, 0, 50)
CreditsLabel.Font = Enum.Font.SourceSans
CreditsLabel.Text = "Credits to girl00kidd"
CreditsLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
CreditsLabel.TextSize = 24

ImageLabel.Name = "ImageDisplay"
ImageLabel.Parent = ScreenGui
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
ImageLabel.BackgroundTransparency = 0
ImageLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
ImageLabel.Size = UDim2.new(0, 400, 0, 400)
ImageLabel.Image = "rbxassetid://132704730281717"

ParticleButton.Name = "OldParticlesButton"
ParticleButton.Parent = ScreenGui
ParticleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
ParticleButton.Position = UDim2.new(0.05, 0, 0.65, 0)
ParticleButton.Size = UDim2.new(0, 400, 0, 50)
ParticleButton.Font = Enum.Font.SourceSans
ParticleButton.Text = "Old Particles"
ParticleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
ParticleButton.TextSize = 20

SkyboxButton.Name = "SkyboxButton"
SkyboxButton.Parent = ScreenGui
SkyboxButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
SkyboxButton.Position = UDim2.new(0.05, 0, 0.75, 0)
SkyboxButton.Size = UDim2.new(0, 400, 0, 50)
SkyboxButton.Font = Enum.Font.SourceSans
SkyboxButton.Text = "Skybox"
SkyboxButton.TextColor3 = Color3.fromRGB(0, 0, 0)
SkyboxButton.TextSize = 20

ParticleButton.MouseButton1Click:Connect(function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Texture = "rbxassetid://134964139950"
        particleEmitter.Lifetime = NumberRange.new(2)
        particleEmitter.Rate = 50
        particleEmitter.Speed = NumberRange.new(5, 10)
        particleEmitter.Parent = character:FindFirstChild("HumanoidRootPart")
        wait(10)
        particleEmitter:Destroy()
    end
end)ect(updateList)
