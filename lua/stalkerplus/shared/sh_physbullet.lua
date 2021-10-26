STALKERPLUS.PhysBullets = {
}

function STALKERPLUS:SendBullet(bullet, attacker)
    net.Start("STALKERPLUS_sendbullet", true)
    net.WriteVector(bullet.Pos)
    net.WriteAngle(bullet.Vel:Angle())
    net.WriteFloat(bullet.Vel:Length())
    net.WriteFloat(bullet.Drag)
    net.WriteFloat(bullet.Gravity)
    net.WriteEntity(bullet.Weapon)

    if attacker and attacker:IsValid() and attacker:IsPlayer() and !game.SinglePlayer() then
        net.SendOmit(attacker)
    else
        if game.SinglePlayer() then
            net.WriteEntity(attacker)
        end
        net.Broadcast()
    end
end

function STALKERPLUS:ShootPhysBullet(wep, pos, vel, tbl)
    tbl = tbl or {}
    local bullet = {
        Penleft = wep:GetProcessedValue("Penetration"),
        Gravity = wep:GetProcessedValue("PhysBulletGravity"),
        Pos = pos,
        Vel = vel,
        Drag = wep:GetProcessedValue("PhysBulletDrag"),
        Travelled = 0,
        StartTime = CurTime(),
        Imaginary = false,
        Underwater = false,
        Weapon = wep,
        Attacker = wep:GetOwner(),
        Filter = {wep:GetOwner()},
        Damaged = {},
        Dead = false,
    }

    for i, k in pairs(tbl) do
        bullet[i] = k
    end

    if bit.band( util.PointContents( pos ), CONTENTS_WATER ) == CONTENTS_WATER then
        bullet.Underwater = true
    end

    table.insert(STALKERPLUS.PhysBullets, bullet)

    if wep:GetOwner():IsPlayer() and SERVER then
        local ping = wep:GetOwner():Ping() / 1000
        ping = math.Clamp(ping, 0, 0.5)
        local timestep = engine.TickInterval()

        while ping > 0 do
            STALKERPLUS:ProgressPhysBullet(bullet, math.min(timestep, ping))
            ping = ping - timestep
        end
    end

    if SERVER then
        STALKERPLUS:ProgressPhysBullet(bullet, FrameTime())

        STALKERPLUS:SendBullet(bullet, wep:GetOwner())
    end
end

if CLIENT then

net.Receive("STALKERPLUS_sendbullet", function(len, ply)
    local pos = net.ReadVector()
    local ang = net.ReadAngle()
    local vel = net.ReadFloat()
    local drag = net.ReadFloat()
    local grav = net.ReadFloat()
    local weapon = net.ReadEntity()
    local ent = nil

    if game.SinglePlayer() then
        ent = net.ReadEntity()
    end

    local bullet = {
        Pos = pos,
        Vel = ang:Forward() * vel,
        Travelled = 0,
        StartTime = CurTime(),
        Imaginary = false,
        Underwater = false,
        Dead = false,
        Damaged = {},
        Drag = drag,
        Attacker = ent,
        Gravity = grav,
        Weapon = weapon,
    }

    if bit.band( util.PointContents( pos ), CONTENTS_WATER ) == CONTENTS_WATER then
        bullet.Underwater = true
    end

    table.insert(STALKERPLUS.PhysBullets, bullet)
end)

end

function STALKERPLUS:DoPhysBullets()
    local new = {}
    for _, i in pairs(STALKERPLUS.PhysBullets) do
        STALKERPLUS:ProgressPhysBullet(i, FrameTime())

        if !i.Dead then
            table.insert(new, i)
        end
    end

    STALKERPLUS.PhysBullets = new
end

hook.Add("Think", "STALKERPLUS_DoPhysBullets", STALKERPLUS.DoPhysBullets)

local function indim(vec, maxdim)
    if math.abs(vec.x) > maxdim or math.abs(vec.y) > maxdim or math.abs(vec.z) > maxdim then
        return false
    else
        return true
    end
end

function STALKERPLUS:ProgressPhysBullet(bullet, timestep)
    timestep = timestep or FrameTime()

    if bullet.Dead then return end

    local oldpos = bullet.Pos
    local oldvel = bullet.Vel
    local dir = bullet.Vel:GetNormalized()
    local spd = bullet.Vel:Length() * timestep
    local drag = bullet.Drag * spd * spd * (1 / 150000)
    local gravity = timestep * GetConVar("STALKERPLUS_bullet_gravity"):GetFloat() * (bullet.Gravity or 1) * 600

    local attacker = bullet.Attacker
    local weapon = bullet.Weapon

    -- if !IsValid(attacker) then
    --     bullet.Dead = true
    --     return
    -- end

    if !IsValid(weapon) then
        bullet.Dead = true
        return
    end

    if bullet.Underwater then
        drag = drag * 3
    end

    drag = drag * GetConVar("STALKERPLUS_bullet_drag"):GetFloat()

    if spd <= 0.001 then bullet.Dead = true return end

    local newpos = oldpos + (oldvel * timestep)
    local newvel = oldvel - (dir * drag)
    newvel = newvel - (Vector(0, 0, 1) * gravity)

    if bullet.Imaginary then
        -- the bullet has exited the map, but will continue being visible.
        bullet.Pos = newpos
        bullet.Vel = newvel
        bullet.Travelled = bullet.Travelled + spd

        if CLIENT and !GetConVar("STALKERPLUS_bullet_imaginary"):GetBool() then
            bullet.Dead = true
        end
    else
        if attacker:IsPlayer() then
            attacker:LagCompensation(true)
        end

        local tr = util.TraceLine({
            start = oldpos,
            endpos = newpos,
            filter = bullet.Filter,
            mask = MASK_SHOT
        })

        if attacker:IsPlayer() then
            attacker:LagCompensation(false)
        end

        if SERVER then
            debugoverlay.Line(oldpos, tr.HitPos, 5, Color(100,100,255), true)
        else
            debugoverlay.Line(oldpos, tr.HitPos, 5, Color(255,200,100), true)
        end

        if tr.HitSky then
            if CLIENT and GetConVar("STALKERPLUS_bullet_imaginary"):GetBool() then
                bullet.Imaginary = true
            else
                bullet.Dead = true
            end

            bullet.Pos = newpos
            bullet.Vel = newvel
            bullet.Travelled = bullet.Travelled + spd

            if SERVER then
                bullet.Dead = true
            end
        elseif tr.Hit then
            bullet.Travelled = bullet.Travelled + (oldpos - tr.HitPos):Length()
            bullet.Pos = tr.HitPos
            -- if we're the client, we'll get the bullet back when it exits.

            if attacker:IsPlayer() then
                attacker:LagCompensation(true)
            end

            if SERVER then
                debugoverlay.Cross(tr.HitPos, 5, 5, Color(100,100,255), true)
            else
                debugoverlay.Cross(tr.HitPos, 5, 5, Color(255,200,100), true)
            end

            local eid = tr.Entity:EntIndex()

            if CLIENT then
                -- do an impact effect and forget about it
                if !game.SinglePlayer() then
                    attacker:FireBullets({
                        Src = oldpos,
                        Dir = dir,
                        Distance = spd + 16,
                        Tracer = 0,
                        Damage = 0,
                        IgnoreEntity = bullet.Attacker
                    })
                end
                bullet.Dead = true
                return
            elseif SERVER then
                bullet.Damaged[eid] = true
                bullet.Dead = true

                bullet.Attacker:FireBullets({
                    Damage = weapon:GetProcessedValue("Damage_Max"),
                    Force = 8,
                    Tracer = 0,
                    Num = 1,
                    Dir = bullet.Vel:GetNormalized(),
                    Src = oldpos,
                    Spread = Vector(0, 0, 0),
                    Callback = function(att, btr, dmg)
                        local range = bullet.Travelled

                        weapon:AfterShotFunction(btr, dmg, range, bullet.Penleft, bullet.Damaged)
                    end
                })
            end

            if attacker:IsPlayer() then
                attacker:LagCompensation(false)
            end
        else
            -- bullet did not impact anything
            bullet.Pos = tr.HitPos
            bullet.Vel = newvel
            bullet.Travelled = bullet.Travelled + spd

            if bullet.Underwater then
                if bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) != CONTENTS_WATER then
                    local utr = util.TraceLine({
                        start = tr.HitPos,
                        endpos = oldpos,
                        filter = bullet.Attacker,
                        mask = MASK_WATER
                    })

                    if utr.Hit then
                        local fx = EffectData()
                        fx:SetOrigin(utr.HitPos)
                        fx:SetScale(5)
                        fx:SetFlags(0)
                        util.Effect("gunshotsplash", fx)
                    end

                    bullet.Underwater = false
                end
            else
                if bit.band( util.PointContents( tr.HitPos ), CONTENTS_WATER ) == CONTENTS_WATER then
                    local utr = util.TraceLine({
                        start = oldpos,
                        endpos = tr.HitPos,
                        filter = bullet.Attacker,
                        mask = MASK_WATER
                    })

                    if utr.Hit then
                        local fx = EffectData()
                        fx:SetOrigin(utr.HitPos)
                        fx:SetScale(5)
                        fx:SetFlags(0)
                        util.Effect("gunshotsplash", fx)
                    end

                    bullet.Underwater = true
                end
            end
        end
    end

    local MaxDimensions = 16384 * 4
    local WorldDimensions = 16384

    if bullet.StartTime <= (CurTime() - GetConVar("STALKERPLUS_bullet_lifetime"):GetFloat()) then
        bullet.Dead = true
    elseif !indim(bullet.Pos, MaxDimensions) then
        bullet.Dead = true
    elseif !indim(bullet.Pos, WorldDimensions) then
        bullet.Imaginary = true
    end
end

local head = Material("particle/particle_glow_04")
local tracer = Material("effects/tracer_middle")

function STALKERPLUS:DrawPhysBullets()
    cam.Start3D()
    for _, i in pairs(STALKERPLUS.PhysBullets) do
        if i.Travelled <= (i.Vel:Length() * 0.05) then continue end

        local size = 1

        size = size * math.log(EyePos():DistToSqr(i.Pos) - math.pow(256, 2))

        size = math.Clamp(size, 0, math.huge)

        -- local delta = (EyePos():DistToSqr(i.Pos) / math.pow(20000, 2))

        -- size = math.pow(size, Lerp(delta, 1, 2))

        -- cam.Start3D()

        local col = Color(255, 225, 200)

        render.SetMaterial(head)
        render.DrawSprite(i.Pos, size, size, col)

        render.SetMaterial(tracer)
        render.DrawBeam(i.Pos, i.Pos - i.Vel:GetNormalized() * math.min(i.Vel:Length() * 0.5, 2048), size * 0.75, 0, 1, col)

        -- cam.End3D()
    end
    cam.End3D()
end

hook.Add("PreDrawEffects", "STALKERPLUS_DrawPhysBullets", STALKERPLUS.DrawPhysBullets)

hook.Add("PostCleanupMap", "STALKERPLUS_CleanPhysBullets", function()
    STALKERPLUS.PhysBullets = {}
end)