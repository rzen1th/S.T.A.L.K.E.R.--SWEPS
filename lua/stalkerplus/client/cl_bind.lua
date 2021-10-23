hook.Add("PlayerBindPress", "STALKERPLUS_Binds", function(ply, bind, pressed, code)
    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.STALKERPLUS then return end

    if !pressed then return end

    -- print(bind)

    if bind == "+menu_context" then
        if !LocalPlayer():KeyDown(IN_USE) then
            if wpn:GetCustomize() then
                net.Start("STALKERPLUS_togglecustomize")
                net.WriteBool(false)
                net.SendToServer()
            else
                net.Start("STALKERPLUS_togglecustomize")
                net.WriteBool(true)
                net.SendToServer()
            end

            return true
        end
    end
end)