ATT.PrintName = "PSO-1 4x Scope"
ATT.CompactName = "PSO1x4"
ATT.Icon = Material("entities/stalkerplus_att_optic_pso1.png", "mips smooth")
ATT.Description = "Optic specifically designed for the Dragunov sniper rifle. Can be equipped on a variety of Russian weapons."
ATT.SortOrder = 4

ATT.Model = "models/weapons/stalker/addons/pso1.mdl"

ATT.Category = "optic_dovetail" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.Sights = {
    {
        Pos = Vector(-0.523455, 12.5, -2.07457),
        Ang = Angle(0, 0, 0),
        Magnification = 2.5
    }
}

ATT.RTScope = true
ATT.RTScopeSubmatIndex = 1
ATT.RTScopeFOV = 6
ATT.RTScopeRes = 512
ATT.RTScopeSurface = Material("effects/stalkerplus_rt")
ATT.RTScopeReticle = Material("stalkerplus/pso1.png")

ATT.HugeAssScope = true