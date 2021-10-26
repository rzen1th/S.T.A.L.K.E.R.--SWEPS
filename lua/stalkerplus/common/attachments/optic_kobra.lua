ATT.PrintName = "Kobra EKP-8-02 Reflex"
ATT.CompactName = "KOBRAx1"
ATT.Icon = Material("entities/stalkerplus_att_optic_kobra.png", "mips smooth")
ATT.Description = "Red dot sight."
ATT.SortOrder = 1

ATT.Model = "models/weapons/stalker/addons/cobra.mdl"

ATT.Category = "optic_dovetail" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.Sights = {
    {
        Pos = Vector(-0.562441, 10, -2.28104),
        Ang = Angle(0, 0, 0),
        Magnification = 1.15
    }
}

ATT.HoloSight = true
ATT.HoloSightReticle = Material("stalkerplus/kobra.png", "additive")
ATT.HoloSightSize = 512
ATT.HoloSightColor = Color(255, 0, 0)