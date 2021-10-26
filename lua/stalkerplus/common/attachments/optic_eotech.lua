ATT.PrintName = "EOTech XPS3-0 Holographic Sight"
ATT.CompactName = "HOLOx1"
ATT.Icon = Material("entities/stalkerplus_att_optic_eotech.png", "mips smooth")
ATT.Description = "Holographic sight."
ATT.SortOrder = 1

ATT.Model = "models/weapons/stalker/addons/eotech.mdl"

ATT.Category = "optic_picatinny" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.Sights = {
    {
        Pos = Vector(0, 10, -2.64833),
        Ang = Angle(0, 0, 0),
        Magnification = 1.15
    }
}

ATT.HoloSight = true
ATT.HoloSightReticle = Material("stalkerplus/kobra.png", "additive")
ATT.HoloSightSize = 512
ATT.HoloSightColor = Color(255, 0, 0)