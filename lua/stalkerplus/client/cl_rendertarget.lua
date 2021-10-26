hook.Add("PreRender", "STALKERPLUS_PreRender", function()
    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn.STALKERPLUS then return end

    local sight = wpn:GetSight()

    if sight.atttbl and sight.atttbl.RTScope and wpn:GetSightAmount() > 0 then
        wpn:DoRT(sight.atttbl.RTScopeFOV)
    end
end)