ATT.PrintName = "Legacy RDS"
ATT.CompactName = "RDSx1"
ATT.Icon = Material("entities/acwatt_go_optic_barska.png", "mips smooth")
ATT.Description = "Red dot sight."
ATT.SortOrder = 1

ATT.Model = "models/weapons/arccw_go/atts/barska.mdl"

ATT.Category = "optic_picatinny" // can be "string" or {"list", "of", "strings"}

// Allows a custom sight position to be defined
ATT.SightPos = Vector(0, 10, -1.18694)
ATT.SightAng = Angle(0, 0, 0)

ATT.HoloSight = true
ATT.HoloSightReticle = Material("hud/holosight/go_barska.png", "mips smooth")
ATT.HoloSightSize = 32
ATT.HoloSightColor = Color(255, 0, 0)