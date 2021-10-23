function STALKERPLUS:PlayerGetAtts(ply, att)
    if !IsValid(ply) then return 0 end
    if GetConVar("STALKERPLUS_free_atts"):GetBool() then return 999 end

    if att == "" then return 999 end

    local atttbl = STALKERPLUS.GetAttTable(att)

    if !atttbl then return 0 end

    if atttbl.Free then return 999 end

    if !IsValid(ply) then return 0 end

    if !ply:IsAdmin() and atttbl.AdminOnly then
        return 0
    end

    if atttbl.InvAtt then att = atttbl.InvAtt end

    if !ply.STALKERPLUS_AttInv then return 0 end

    if !ply.STALKERPLUS_AttInv[att] then return 0 end

    return ply.STALKERPLUS_AttInv[att]
end

function STALKERPLUS:PlayerGiveAtt(ply, att, amt)
    amt = amt or 1

    if !IsValid(ply) then return end

    if !ply.STALKERPLUS_AttInv then
        ply.STALKERPLUS_AttInv = {}
    end

    local atttbl = STALKERPLUS.GetAttTable(att)

    if !atttbl then print("Invalid att " .. att) return end
    if atttbl.Free then return end -- You can't give a free attachment, silly
    if atttbl.AdminOnly and !(ply:IsPlayer() and ply:IsAdmin()) then return false end

    if atttbl.InvAtt then att = atttbl.InvAtt end

    if GetConVar("STALKERPLUS_lock_atts"):GetBool() then
        if ply.STALKERPLUS_AttInv[att] == 1 then return end
        ply.STALKERPLUS_AttInv[att] = 1
    else
        ply.STALKERPLUS_AttInv[att] = (ply.STALKERPLUS_AttInv[att] or 0) + amt
    end
end


function STALKERPLUS:PlayerTakeAtt(ply, att, amt)
    amt = amt or 1

    if GetConVar("STALKERPLUS_lock_atts"):GetBool() then return end

    if !IsValid(ply) then return end

    if !ply.STALKERPLUS_AttInv then
        ply.STALKERPLUS_AttInv = {}
    end

    local atttbl = STALKERPLUS.GetAttTable(att)
    if !atttbl or atttbl.Free then return end

    if atttbl.InvAtt then att = atttbl.InvAtt end

    ply.STALKERPLUS_AttInv[att] = ply.STALKERPLUS_AttInv[att] or 0

    if ply.STALKERPLUS_AttInv[att] < amt then
        return false
    end

    ply.STALKERPLUS_AttInv[att] = ply.STALKERPLUS_AttInv[att] - amt
    if ply.STALKERPLUS_AttInv[att] <= 0 then
        ply.STALKERPLUS_AttInv[att] = nil
    end
    return true
end

if CLIENT then

net.Receive("STALKERPLUS_sendattinv", function(len, ply)
    LocalPlayer().STALKERPLUS_AttInv = {}

    local count = net.ReadUInt(32)

    for i = 1, count do
        local attid = net.ReadUInt(STALKERPLUS.Attachments_Bits)
        local acount = net.ReadUInt(32)

        local att = STALKERPLUS.Attachments_Index[attid]

        LocalPlayer().STALKERPLUS_AttInv[att] = acount
    end
end)

elseif SERVER then

hook.Add("PlayerDeath", "STALKERPLUS_DeathAttInv", function(ply)
    -- if GetConVar("STALKERPLUS_loseattsondie"):GetBool() then
    --     ply.STALKERPLUS_AttInv = ply.STALKERPLUS_AttInv or {}
    -- end
    -- if table.Count(ply.STALKERPLUS_AttInv) > 0
    --         and GetConVar("STALKERPLUS_attinv_loseondie"):GetInt() >= 2
    --         and !GetConVar("STALKERPLUS_free_atts"):GetBool() then
    --     local boxEnt = ents.Create("STALKERPLUS_att_dropped")
    --     boxEnt:SetPos(ply:GetPos() + Vector(0, 0, 4))
    --     boxEnt.GiveAttachments = ply.STALKERPLUS_AttInv
    --     boxEnt:Spawn()
    --     boxEnt:SetNWString("boxname", ply:GetName() .. "'s Death Box")
    --     local count = 0
    --     for i, v in pairs(boxEnt.GiveAttachments) do count = count + v end
    --     boxEnt:SetNWInt("boxcount", count)
    -- end
end)

hook.Add("PlayerSpawn", "STALKERPLUS_SpawnAttInv", function(ply, trans)
    if trans then return end

    if GetConVar("STALKERPLUS_loseattsondie"):GetInt() >= 1 then
        ply.STALKERPLUS_AttInv = {}

        STALKERPLUS:PlayerSendAttInv(ply)
    end
end)

function STALKERPLUS:PlayerSendAttInv(ply)
    if GetConVar("STALKERPLUS_free_atts"):GetBool() then return end

    if !IsValid(ply) then return end

    if !ply.STALKERPLUS_AttInv then return end

    net.Start("STALKERPLUS_sendattinv")

    net.WriteUInt(table.Count(ply.STALKERPLUS_AttInv), 32)

    for att, count in pairs(ply.STALKERPLUS_AttInv) do
        local atttbl = STALKERPLUS.GetAttTable(att)
        local attid = atttbl.ID
        net.WriteUInt(attid, STALKERPLUS.Attachments_Bits)
        net.WriteUInt(count, 32)
    end

    net.Send(ply)
end

end
