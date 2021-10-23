SWEP.Spawnable = false
SWEP.AdminOnly = false

// Stat system:
// The stat system is extremely powerful can be used to build all sorts of interesting functionality with minimum effort.
// You have base stats, like DamageMax or Spread.
// You then add a modifier on: Add, Mult, Hook, Override.
// You can then add a condition to this, optionally, meaning that only under certain circumstances will the attachment activate.
// For example: SpreadMultSights, RecoilMultFirstShot, DamageMultFirstShot, PenetrationOverride.

// Use GetProcessedValue("Spread") to get the total Spread with all the conditions taken into account.
// Use GetValue("Spread") to get only base modified Spread - modified by attachments with "SpreadMult" or "SpreadAdd", etc. but no conditions.

// Conditions, in this order:
// Silenced (Silencer is attached)
// MidAir
// Crouch
// FirstShot
// LastShot
// EvenShot (Every second shot)
// OddShot (Every second shot, but on odd ones)
// EvenReload
// OddReload
// Sights
// HipFire
// Shooting (While you are shooting)
// Recoil (Increases with your recoil amount)
// Move (When you are moving)

// HOOKS:

-- SWEP.Hook_BulletImpact = function(self, data) end
// data: tr, dmg, range, penleft, alreadypenned
// Run code when a bullet impacts a surface.

-- SWEP.Hook_TranslateMode = function(self, mode) end
// Allows you to translate firemode

-- SWEP.Hook_TranslateSequence = function(self, seq) end
// Translate sequences before _sights or _empty are applied
// Runs before AnimationTranslationTable takes effect

-- SWEP.Hook_TranslateAnimSpeed = function(self, data) end
// data: mult, seq
// Modify the speed of animations when they play.

-- SWEP.Hook_BlockFire = function(self) end
// Return true to block weapon from shooting.



// Names

SWEP.PrintName = "Stalker+ Base"
SWEP.TrueName = nil

SWEP.ViewModel = ""
SWEP.MirrorModel = "" // low quality version of viewmodel for use as a worldmodel
SWEP.WorldModelOffset = {
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0),
    Scale = 1
}

SWEP.ViewModelFOV = 65

SWEP.Slot = 1

// Damage Profile

// You can use Damage as a base stat to modify both damage values at once.

SWEP.DamageMax = 35
SWEP.DamageMin = 30

SWEP.RangeMin = 1000
SWEP.RangeMax = 8000

SWEP.Penetration = 0

SWEP.RicochetAngleMax = 45 // maximum angle at which a ricochet can occur. Between 1 and 90. Angle of 0 is impossible but would theoretically always ricochet.
SWEP.RicochetChance = 1 // if the angle is right, what is the chance that a ricochet can occur?

SWEP.ShootEnt = false
SWEP.ShootEntForce = 10000

SWEP.PhysMuzzleVelocity = 15000
SWEP.PhysBulletDrag = 1
SWEP.PhysBulletGravity = 1

SWEP.Num = 1
SWEP.TracerNum = 1
SWEP.BodyDamageMultipliers = {
    [HITGROUP_HEAD] = 1.25,
    [HITGROUP_CHEST] = 1,
    [HITGROUP_STOMACH] = 1,
    [HITGROUP_LEFTARM] = 1,
    [HITGROUP_RIGHTARM] = 1,
    [HITGROUP_LEFTLEG] = 0.9,
    [HITGROUP_RIGHTLEG] = 0.9,
    [HITGROUP_GEAR] = 0.9
}

// Works different to ArcCW

// -1: Automatic
// 0: Safe. Don't use this for safety.
// 1: Semi.
// 2: Two-round burst.
// 3: Three-round burst.
// n: n-round burst.
SWEP.Firemodes = {
    {
        Mode = 1,
        // add other attachment modifiers
    }
}

SWEP.RPM = 600

SWEP.RunawayBurst = false
SWEP.AutoBurst = false
SWEP.PostBurstDelay = 0

// Spread

SWEP.Spread = 0.01

// new modifier system
// BaseStat + Mult/Add/Override/Hook + Condition (Optional)
// e.g. SpreadMultMove, RPMMult, RecoilMultFirstShot
-- SWEP.SpreadMultMove = 1
-- SWEP.SpreadMultMidAir = 1
-- SWEP.SpreadMultSights = 1
-- SWEP.SpreadMultHipFire = 1
-- SWEP.SpreadAddRecoil = 0

// Recoil

SWEP.Recoil = 1

SWEP.RecoilUp = 1
SWEP.RecoilSide = 0.5

SWEP.RecoilKick = 1

SWEP.RecoilMultFirstShot = 1

SWEP.RecoilResetTime = 0.1 // time after you stop shooting + shoot delay for recoil to start going down
SWEP.RecoilDissipationRate = 100

SWEP.RecoilMaximum = 100

// Handling

SWEP.AimDownSightsTime = 0.25
SWEP.SprintToFireTime = 0.25

SWEP.SpeedMult = 1
SWEP.SpeedMultSights = 0.75

// UBGL

SWEP.UBGL = false

// Use UBGL as a condition

// Many functions use UBGLWeapon to substitute the base weapon while the UBGL is equipped.
// This allows for use of most stats on UBGLs.
// Some exceptions are made, such as Spread, which uses UBGLSpread.
SWEP.UBGLWeapon = {
    -- DamageMin = 100,
    -- DamageMax = 50,
    -- RangeMin = 1000,
    -- RangeMax = 8000,
    -- ShootEnt = nil,
    -- ShootEntForce = 10000,
    -- Num = 1,
    -- BodyDamageMultipliers = {},
    -- RecoilUp = 1, -- Affected by base gun attachments
    -- RecoilSide = 0.5,
    -- SpreadUBGL = 0.01 -- Only affected by UBGLSpread base stat, e.g. UBGLSpreadMultSights
}

SWEP.UBGLClipSize = 1
SWEP.UBGLAmmo = "smg_grenade"

SWEP.UBGLSoundShoot = ""
SWEP.UBGLVolumeShoot = 115

// Malfunction

SWEP.Malfunction = false
SWEP.MSBF = 500 // mean shots between failures

// Overheat

SWEP.Overheat = false
SWEP.HeatCapacity = 100
SWEP.HeatResetTime = 0.5 // time that gun needs to start cooling
SWEP.HeatDissipateTime = 1 // seconds needed to dissipate all heat capacity

// Reload

SWEP.Chamber = 1
SWEP.ClipSize = 30
SWEP.Ammo = "pistol"

SWEP.AmmoPerShot = 1

SWEP.SupplyAmmoType = false // overrides clipsize/ammo for ammo pickups
SWEP.SupplyAmmoAmount = 6
SWEP.SupplyAmmoAmountUBGL = 2

SWEP.ShotgunReload = false
SWEP.HybridReload = false

SWEP.ManualAction = false

SWEP.ReloadTime = 1
SWEP.DeployTime = 1

SWEP.DropMagazineModel = false
SWEP.DropMagazineSkin = 0

SWEP.RandomMagsElements = {} // enable one attachmentelement at random each time we reload.

// Bullets

SWEP.DefaultBodygroups = "000000000000000"
SWEP.BulletBodygroups = {
    -- [1] = {4, 1} // Ammo left - go under this and enable this bodygroup. {index, bg}
}

SWEP.LoadInTime = 0.25 // how long to replenish the visible "belt" of ammo

// Hold Types

SWEP.HoldType = "ar2"
SWEP.HoldTypeSprint = "passive"
SWEP.HoldTypeCustomize = "slam"

SWEP.GestureShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2
SWEP.GestureReload = ACT_HL2MP_GESTURE_RELOAD_AR2

SWEP.PassiveAng = Angle(0, 0, 0)
SWEP.PassivePos = Vector(0, 0, 0)

SWEP.SprintAng = Angle(0, 45, 0)
SWEP.SprintPos = Vector(0, 0, 0)

SWEP.CustomizeAng = Angle(30, 15, 0)
SWEP.CustomizePos = Vector(5, 0, -6)

SWEP.SightAng = Angle(0, 0, 0)
SWEP.SightPos = Vector(0, 1, 1)

SWEP.SightMidPoint = {
    Pos = Vector(-1, 15, -6),
    Ang = Angle(0, 0, -45)
}

SWEP.SprintMidPoint = {
    Pos = Vector(4, 10, 2),
    Ang = Angle(0, -10, -45)
}

// Sounds

SWEP.SoundShoot = ""
SWEP.SoundShootOverrideSilenced = nil

SWEP.Silencer = false

SWEP.SoundDryFire = ""
SWEP.SoundFiremode = ""

SWEP.VolumeShoot = 125
SWEP.PitchShoot = 100
SWEP.ShootPitchVariance = 0.025

SWEP.SoundEnterSights = ""
SWEP.SoundExitSights = ""

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
    ["melee"] = {"melee1", "melee2"}
} // translates ["fire"] = "shoot"; key = translates from, value = translates to
// e.g. you have a "shoot1" sequence and need "fire"
// so ["fire"] = "shoot1"
// can be ["fire"] = {"list", "of", "values"}

SWEP.AnimationTranslateHook = nil
-- function(self, animation) return animation end

SWEP.LastShot = false

// Attachments

SWEP.AttachmentElements = {
    ["bg_name"] = {
        Bodygroups = {
            {1, 1}
        },
        -- Other attachment parameters work here
    }
}

SWEP.Attachments = nil
-- {
--     [1] = {
--         PrintName = "",
--         DefaultIcon = Material(""),
--         Default = nil,
--         InstalledElements = "", // single or list of elements to activate when something is installed here
--         UnInstalledElements = "",
--         Integral = false, // cannot be removed
--         Category = "", // single or {"list", "of", "values"}
--         Bone = "",
--         Pos = Vector(0, 0, 0),
--         Ang = Angle(0, 0, 0),
--         KeepBaseIrons = false,
--         Installed = nil,
--         SubAttachments = {
--             {
--                 Installed = nil,
--                 SubAttachments = {}
--             },
--             {
--                 Installed = nil,
--                 SubAttachments = {}
--             }
--         }
--     }
-- }

// Boilerplate

SWEP.STALKERPLUS = true
SWEP.DrawCrosshair = false
SWEP.AccurateCrosshair = false
SWEP.DrawWeaponInfoBox = false
SWEP.UseHands = true

SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = ""
SWEP.Primary.DefaultClip = 0

SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo = ""

SWEP.GaveDefaultAmmo = false

SWEP.BounceWeaponIcon = false

SWEP.SwayScale = 1
SWEP.BobScale = 1

AddCSLuaFile()

local searchdir = "weapons/stalkerplus_base"

local function autoinclude(dir)
    local files, dirs = file.Find(searchdir .. "/*.lua", "LUA")

    for _, filename in pairs(files) do
        if filename == "shared.lua" then continue end
        local luatype = string.sub(filename, 1, 2)

        if luatype == "sv" then
            if SERVER then
                include(dir .. "/" .. filename)
            end
        elseif luatype == "cl" then
            AddCSLuaFile(dir .. "/" .. filename)
            if CLIENT then
                include(dir .. "/" .. filename)
            end
        else
            AddCSLuaFile(dir .. "/" .. filename)
            include(dir .. "/" .. filename)
        end
    end

    for _, path in pairs(dirs) do
        autoinclude(dir .. "/" .. path)
    end
end

autoinclude(searchdir)

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "RecoilAmount")
    self:NetworkVar("Float", 1, "AnimLockTime")
    self:NetworkVar("Float", 2, "NextIdle")
    self:NetworkVar("Float", 3, "LastRecoilTime")
    self:NetworkVar("Float", 4, "RecoilDirection")
    self:NetworkVar("Float", 5, "SprintAmount")
    self:NetworkVar("Float", 6, "LastMeleeTime")
    self:NetworkVar("Float", 7, "PrimedAttackTime")
    self:NetworkVar("Float", 8, "StartPrimedAttackTime")
    self:NetworkVar("Float", 9, "ReloadFinishTime")
    self:NetworkVar("Float", 10, "SightAmount")
    self:NetworkVar("Float", 11, "HeatAmount")

    self:NetworkVar("Int", 0, "BurstCount")
    self:NetworkVar("Int", 1, "NthShot")
    self:NetworkVar("Int", 2, "LoadedRounds")
    self:NetworkVar("Int", 3, "Firemode")
    self:NetworkVar("Int", 4, "NthReload")

    self:NetworkVar("Bool", 0, "Customize")
    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Bool", 2, "EndReload")
    self:NetworkVar("Bool", 3, "Safe")
    self:NetworkVar("Bool", 4, "Jammed")
    self:NetworkVar("Bool", 5, "Ready")
    self:NetworkVar("Bool", 6, "TriggerDown")
    self:NetworkVar("Bool", 7, "NeedTriggerPress")
    self:NetworkVar("Bool", 8, "UBGL")
    self:NetworkVar("Bool", 9, "EmptyReload")
    self:NetworkVar("Bool", 10, "InSights")
    self:NetworkVar("Bool", 11, "PrimedAttack")

    self:SetFiremode(1)
    self:SetNthReload(0)
    self:SetNthShot(0)
end

function SWEP:SecondaryAttack()
    return
end
