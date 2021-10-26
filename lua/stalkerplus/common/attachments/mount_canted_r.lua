ATT.PrintName = "Canted Mount (Right)"
ATT.CompactName = "45R-MOUNT"
ATT.Icon = Material("entities/stalkerplus_att_mount_canted_r.png", "mips smooth")
ATT.Description = "Mount that allows for attaching backup sights at a 45-degree cant."
ATT.SortOrder = 0

ATT.Model = "models/weapons/stalker/addons/mount_canted_r.mdl"

ATT.Category = "optic_picatinny" // can be "string" or {"list", "of", "strings"}

ATT.Attachments = {
    {
        PrintName = "OPTIC",
        Category = "optic_picatinny", // single or {"list", "of", "values"}
        Pos = Vector(0, 0.830524, -0.003798),
        Ang = Angle(0, 0, 45),
    }
}