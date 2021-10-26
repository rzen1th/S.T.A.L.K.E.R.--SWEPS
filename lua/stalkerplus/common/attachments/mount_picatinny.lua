ATT.PrintName = "Dovetail Receiver Mount"
ATT.CompactName = "DT.MOUNT"
ATT.Icon = Material("entities/stalkerplus_att_mount_picatinny.png", "mips smooth")
ATT.Description = "Mounting bracket for attaching NATO standard rail attachments to rifles with Warsaw Pact dovetail mounting points."
ATT.SortOrder = 0

ATT.Model = "models/weapons/stalker/addons/mount_picatinny.mdl"

ATT.Category = "optic_dovetail" // can be "string" or {"list", "of", "strings"}

ATT.Attachments = {
    {
        PrintName = "Optic",
        Category = "optic_picatinny", // single or {"list", "of", "values"}
        Pos = Vector(0.623702, 0.513325, -1.48806),
        Ang = Angle(0, 0, 0),
    }
}