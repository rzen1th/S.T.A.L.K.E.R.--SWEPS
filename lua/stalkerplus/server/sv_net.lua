if CLIENT then return end

util.AddNetworkString("stalkerplus_togglecustomize")
util.AddNetworkString("stalkerplus_networkweapon")
util.AddNetworkString("stalkerplus_attach")
util.AddNetworkString("stalkerplus_sendattinv")
util.AddNetworkString("stalkerplus_sendbullet")

net.Receive("stalkerplus_togglecustomize", function(len, ply)
    local bf = net.ReadBool()

    local wpn = ply:GetActiveWeapon()

    if !wpn or !IsValid(wpn) or !wpn.STALKERPLUS then return end

    wpn:ToggleCustomize(bf)
end)

net.Receive("stalkerplus_attach", function(len, ply)
    // TODO
end)

net.Receive("stalkerplus_receivepreset", function(len, ply)
    local wpn = net.ReadEntity()

    if !wpn.STALKERPLUS then return end

    wpn:ReceivePreset()
end)