ATT.PrintName = "USP-1 'Tyulpan' 4x Scope"
ATT.CompactName = "USP1x4"
ATT.Icon = Material("entities/stalkerplus_att_optic_1p29.png", "mips smooth")
ATT.Description = "Universal magnified gunsight for use across a variety of Russian firearms. GRAU index 1P29."
ATT.SortOrder = 4

ATT.Model = "models/weapons/stalker/addons/1p29.mdl"

ATT.Category = "optic_dovetail" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.Sights = {
    {
        Pos = Vector(-0.727691, 10, -2.84961),
        Ang = Angle(0, 0, 0),
        Magnification = 2
    }
}

ATT.RTScope = true
ATT.RTScopeSubmatIndex = 1
ATT.RTScopeFOV = 8
ATT.RTScopeRes = 512
ATT.RTScopeSurface = Material("effects/stalkerplus_rt")
ATT.RTScopeReticle = Material("stalkerplus/1P29.png")

ATT.HugeAssScope = true