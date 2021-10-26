ATT.PrintName = "Trijicon ACOG TA11"
ATT.CompactName = "ACOGx3.5"
ATT.Icon = Material("entities/stalkerplus_att_optic_acog.png", "mips smooth")
ATT.Description = "Magnified combat scope."
ATT.SortOrder = 1

ATT.Model = "models/weapons/stalker/addons/acog.mdl"

ATT.Category = "optic_picatinny" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.Sights = {
    {
        Pos = Vector(0, 7.5, -0.991123),
        Ang = Angle(0, 0, 0),
        Magnification = 2.5
    }
}

ATT.RTScope = true
ATT.RTScopeSubmatIndex = 1
ATT.RTScopeFOV = 10
ATT.RTScopeReticle = Material("stalkerplus/acog.png")
