net.Receive("stalkerplus_networkweapon", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.STALKERPLUS then return end

    wpn:ReceiveWeapon()
end)