ATT.PrintName = "Konstantin Red Dot"
ATT.CompactName = "RDSx1"
ATT.Icon = Material("")
ATT.Description = "Collimated red dot optic sight."
ATT.SortOrder = 0

ATT.AdminOnly = false
ATT.Free = false
ATT.Ignore = true

ATT.Model = ""
ATT.WorldModel = "" // optional
ATT.Scale = 1
ATT.ModelOffset = Vector(0, 0, 0)

ATT.InvAtt = "" // Having this other attachment will grant access to this one.

ATT.Category = "" // can be "string" or {"list", "of", "strings"}

ATT.ActivateElements = {""}

ATT.MuzzleDevice = false // set to true if you want to use this to emit particles

ATT.Flashlight = false
ATT.FlashlightColor = Color(255, 255, 255)
ATT.FlashlightMaterial = Material("")
ATT.FlashlightDistance = 1024
ATT.FlashlightFOV = 70

ATT.Laser = false
ATT.LaserColor = Color(255, 0, 0)

// Allows a custom sight position to be defined
ATT.SightPos = Vector(0, 0, 0)
ATT.SightAng = Angle(0, 0, 0)

ATT.HoloSight = false
ATT.HoloSightReticle = Material("")
ATT.HoloSightSize = 32
ATT.HoloSightColor = Color(255, 255, 255)

ATT.RTScope = true
ATT.RTScopeSubmatIndex = 1
ATT.RTScopeFOV = 2.5
ATT.RTScopeRes = 512
ATT.RTScopeLensMat = Material("")
ATT.RTScopeSurface = Material("effects/stalkerplus_rt")
ATT.RTScopeOffset = Vector(0, 0, 0)
ATT.RTScopeReticle = Material("")

ATT.Attachments = {
    {
        PrintName = "",
        DefaultIcon = Material(""),
        Default = nil, // only works if installed by default on default
        InstalledElements = "", // single or list of elements to activate when something is installed here
        UnInstalledElements = "",
        Integral = false, // cannot be removed
        Category = "", // single or {"list", "of", "values"}
        Bone = "",
        Pos = Vector(0, 0, 0),
        Ang = Angle(0, 0, 0),
        KeepBaseIrons = false,
    }
}