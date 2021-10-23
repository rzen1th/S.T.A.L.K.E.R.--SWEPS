STALKERPLUS.Attachments = {}
STALKERPLUS.Attachments_Index = {}

STALKERPLUS.Attachments_Count = 0

STALKERPLUS.Attachments_Bits = 16

function STALKERPLUS.LoadAtts()
    STALKERPLUS.Attachments_Count = 0
    STALKERPLUS.Attachments = {}
    STALKERPLUS.Attachments_Index = {}

    local searchdir = "STALKERPLUS/common/attachments/"

    local files = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        AddCSLuaFile(searchdir .. filename)
    end

    files = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        if filename == "default.lua" then continue end

        ATT = {}

        local shortname = string.sub(filename, 1, -5)

        include(searchdir .. filename)

        if ATT.Ignore then continue end

        STALKERPLUS.Attachments_Count = STALKERPLUS.Attachments_Count + 1

        ATT.ShortName = shortname
        ATT.ID = STALKERPLUS.Attachments_Count

        STALKERPLUS.Attachments[shortname] = ATT
        STALKERPLUS.Attachments_Index[STALKERPLUS.Attachments_Count] = shortname

        if GetConVar("STALKERPLUS_generateattentities"):GetBool() and !ATT.DoNotRegister and !ATT.InvAtt and !ATT.Free then
            local attent = {}
            attent.Base = "STALKERPLUS_att"
            attent.Icon = ATT.Icon
            attent.PrintName = ATT.PrintName or shortname
            attent.Spawnable = true
            attent.AdminOnly = ATT.AdminOnly or false
            attent.AttToGive = shortname
            attent.Category = "Tactical RP - Attachments"

            print("Registering entity for " .. shortname)

            scripted_ents.Register(attent, "STALKERPLUS_att_" .. shortname)
        end
    end

    STALKERPLUS.Attachments_Bits = math.min(math.ceil(math.log(STALKERPLUS.Attachments_Count + 1, 2)), 32)
end

STALKERPLUS.LoadAtts()

function STALKERPLUS.GetAttTable(name) 
    local shortname = name
    if isnumber(shortname) then
        shortname = STALKERPLUS.Attachments_Index[name]
    end

    if STALKERPLUS.Attachments[shortname] then
        return STALKERPLUS.Attachments[shortname]
    else
        assert(false, "!!!! STALKERPLUS tried to access invalid attachment " .. (shortname or "NIL") .. "!!!")
        return {}
    end
end

function STALKERPLUS.GetAttsForCats(cats)
    if !istable(cats) then
        cats = {cats}
    end

    local atts = {}

    for i, k in pairs(STALKERPLUS.Attachments) do
        local attcats = k.Category
        if !istable(attcats) then
            attcats = {attcats}
        end

        for _, cat in pairs(cats) do
            if table.HasValue(attcats, cat) then
                table.insert(atts, k.ShortName)
                break
            end
        end
    end

    return atts
end

if CLIENT then

concommand.Add("STALKERPLUS_reloadatts", function()
    if !LocalPlayer():IsSuperAdmin() then return end

    net.Start("STALKERPLUS_reloadatts")
    net.SendToServer()
end)

net.Receive("STALKERPLUS_reloadatts", function(len, ply)
    STALKERPLUS.LoadAtts()
end)

elseif SERVER then

net.Receive("STALKERPLUS_reloadatts", function(len, ply)
    if !ply:IsSuperAdmin() then return end

    STALKERPLUS.LoadAtts()

    net.Start("STALKERPLUS_reloadatts")
    net.Broadcast()
end)

end