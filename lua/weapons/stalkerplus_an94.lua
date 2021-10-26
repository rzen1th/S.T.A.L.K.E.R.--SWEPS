SWEP.Spawnable = true
SWEP.Base = "stalkerplus_base"

SWEP.Category = "STALKER+"

// Names

SWEP.PrintName = "AC-96/2 Obokan"
SWEP.TrueName = "AN-94 Abakan"

SWEP.ViewModel = "models/weapons/stalker/c_stalker_an94.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.ViewModelFOV = 75

SWEP.Slot = 3

SWEP.WorldModelOffset = {
    Pos = Vector(-1, 3, -5.5),
    Ang = Angle(-5, 0, 180),
    Scale = 1
}

// Damage Profile

SWEP.DamageMax = 30
SWEP.DamageMin = 20

SWEP.RangeMin = 1250
SWEP.RangeMax = 10000

SWEP.Penetration = 5

SWEP.RicochetAngleMax = 30 // maximum angle at which a ricochet can occur. Between 1 and 90. Angle of 0 is impossible but would theoretically always ricochet.
SWEP.RicochetChance = 0.3 // if the angle is right, what is the chance that a ricochet can occur?

SWEP.PhysMuzzleVelocity = 35400

SWEP.Num = 1
SWEP.TracerNum = 1
SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 2,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

SWEP.Firemodes = {
    {
        Mode = -1,
    },
    {
        Mode = 2,
        RunawayBurst = true,
    },
}

SWEP.PostBurstDelay = 0.1
SWEP.RPMMultFirstShot = 3
SWEP.RPM = 600

// Spread

SWEP.Spread = 0.0001

// new modifier system
// BaseStat + Mult/Add/Override/Hook + Condition (Optional)
// e.g. SpreadMultMove, RPMMult, RecoilMultFirstShot
SWEP.SpreadMultMove = 1.25
SWEP.SpreadMultMidAir = 2
SWEP.SpreadAddHipFire = 0.1
SWEP.SpreadAddRecoil = 0

// Recoil

SWEP.RecoilUp = 8
SWEP.RecoilSide = 3

SWEP.RecoilMultFirstShot = 1

SWEP.RecoilResetTime = 0 // time after you stop shooting + shoot delay for recoil to start going down

SWEP.RecoilKickSights = 1
SWEP.RecoilKickHipFire = 3.5

// Handling

SWEP.AimDownSightsTime = 0.325
SWEP.SprintToFireTime = 0.300

SWEP.SpeedMult = 0.95
SWEP.SpeedMultSights = 0.75
SWEP.SpeedMultShooting = 0.85

// Malfunction

SWEP.Malfunction = false
SWEP.MSBF = 400 // mean shots between failures

// Reload

SWEP.ClipSize = 30
SWEP.Ammo = "ar2"

SWEP.AmmoPerShot = 1

SWEP.SupplyAmmoType = false // overrides clipsize/ammo for ammo pickups
SWEP.SupplyAmmoAmount = false

SWEP.SupplyAmmoAmountUBGL = false

SWEP.ShotgunReload = false
SWEP.HybridReload = false

SWEP.ReloadTimeMult = 1
SWEP.DeployTimeMult = 1

SWEP.DropMagazineModel = false
SWEP.DropMagazineSkin = 0

SWEP.RandomMagsElements = {} // enable one attachmentelement at random each time we reload.

// Bullets

SWEP.DefaultBodygroups = "000000000000000"
SWEP.BulletBodygroups = {
    [1] = {6, 1} // Ammo left - go under this and enable this bodygroup. {index, bg}
}

SWEP.LoadInTime = 0.25 // how long to replenish the visible "belt" of ammo

// Hold Types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeCustomize = "slam"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, 0, 0)

SWEP.CustomizeAng = Angle(90, 0, 0)
SWEP.CustomizePos = Vector(12, 32, 4)

SWEP.SprintAng = Angle(30, -15, 0)
SWEP.SprintPos = Vector(2, 0, 1)

SWEP.BaseSights = {
    {
        Pos = Vector(-1.89, 0, 1.1),
        Ang = Angle(0, 0, 3)
    }
}

SWEP.StatCache = {}
SWEP.HookCache = {}
SWEP.AffectorsCache = nil

SWEP.SightMidPoint = {
    Pos = Vector(-1.89, -2, -1.1),
    Ang = Angle(0, 5, -15)
}

SWEP.SprintMidPoint = {
    Pos = Vector(0, 2, -2),
    Ang = Angle(0, 0, 5)
}

// Sounds

SWEP.SoundShoot = "weapons/stalker/abakan/abakan_example.ogg"
SWEP.SoundShootOverrideSilenced = nil

SWEP.SoundDryFire = "weapons/stalker/generic_empty.ogg"
SWEP.SoundFiremode = "weapons/stalker/groza_switch.ogg"

SWEP.VolumeShoot = 125
SWEP.ShootPitchVariance = 0.025

// Effects
// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = ""

SWEP.EjectEffect = ""
SWEP.EjectDelay = 0

// the .qc attachment for the muzzle
SWEP.QCA_Muzzle = 1
// ditto for shell
SWEP.QCA_Eject = 2

SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.EjectEffect = 1 // 1 = pistol, 2 = rifle, 3 = shotgun
SWEP.EjectDelay = 0

// anims

// VM:
// idle
// fire
// dryfire
// melee
// reload
// deploy
// ready
// firemode
// firemode_1, firemode_2... for each index on firemode table
// reload_start
// reload_insert
// reload_finish

// ubgl_equip
// ubgl_unequip
// ubgl_fire
// ubgl_reload
// ubgl_reload_start
// ubgl_reload_insert
// ubgl_reload_finish

// also + _sights + _empty in that order

SWEP.AnimationTranslationTable = {
    ["inspect"] = {"inspect_01", "inspect_02", "inspect_03"}
}

SWEP.LastShot = false

// Attachments

SWEP.AttachmentElements = {
    ["optic_dovetail"] = {
        Bodygroups = {
            {3, 1}
        },
    }
}

SWEP.Attachments = {
    [1] = {
        Installed = "optic_kobra",
        PrintName = "DTAIL",
        Category = "optic_dovetail",
        Bone = "body",
        Pos = Vector(0.6, 0.75, -0.1),
        Ang = Angle(90, 0, -90),
    }
}