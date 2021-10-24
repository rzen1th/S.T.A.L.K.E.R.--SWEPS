if CLIENT then return end

util.AddNetworkString("stalkerplus_togglecustomize")
util.AddNetworkString("stalkerplus_networkweapon")
util.AddNetworkString("stalkerplus_sendattinv")
util.AddNetworkString("stalkerplus_sendbullet")

net.Receive("stalkerplus_togglecustomize", function(len, ply)
    local bf = net.ReadBool()

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.STALKERPLUS then return end

    wpn:ToggleCustomize(bf)
end)

net.Receive("stalkerplus_networkweapon", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.STALKERPLUS then return end

    wpn:ReceiveWeapon()
end)