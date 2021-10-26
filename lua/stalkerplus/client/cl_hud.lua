hook.Add("HUDShouldDraw", "STALKERPLUS_HideHUD", function(name)
    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn.STALKERPLUS then return end

    if wpn:GetCustomize() then return false end
end)