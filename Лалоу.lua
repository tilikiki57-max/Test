-- Delta Kill (Non-Visual)
function DeltaKill(target)
    if not target or not target.Character then return end
    target.Character:SetAttribute("VisualState", 0) -- скрыть модель
    local humanoid = target.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = 0 -- или прямой урон через BreakJoints()
    end
    target.Character:BreakJoints() -- гарантированный летал
end
