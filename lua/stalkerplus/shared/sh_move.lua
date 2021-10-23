STALKERPLUS.LastEyeAngles = Angle(0, 0, 0)
STALKERPLUS.RecoilRise = Angle(0, 0, 0)

function STALKERPLUS.Move(ply, mv, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.STALKERPLUS then return end

    local basespd = (Vector(cmd:GetForwardMove(), cmd:GetUpMove(), cmd:GetSideMove())):Length()
    basespd = math.min(basespd, mv:GetMaxClientSpeed())

    local mult = wpn:GetProcessedValue("Speed", 1)

    if wpn:GetSightAmount() > 0 then
        if ply:KeyDown(IN_SPEED) then
            mult = mult / Lerp(wpn:GetSightAmount(), 1, ply:GetRunSpeed() / ply:GetWalkSpeed())
        end
    end

    mv:SetMaxSpeed(basespd * mult)
    mv:SetMaxClientSpeed(basespd * mult)
end

hook.Add("SetupMove", "STALKERPLUS.SetupMove", STALKERPLUS.Move)

function STALKERPLUS.StartCommand(ply, cmd)
    local wpn = ply:GetActiveWeapon()

    if !wpn.STALKERPLUS then return end

    local diff = STALKERPLUS.LastEyeAngles - cmd:GetViewAngles()
    local recrise = STALKERPLUS.RecoilRise

    if recrise.p > 0 then
        recrise.p = math.Clamp(recrise.p, 0, recrise.p - diff.p)
    elseif recrise.p < 0 then
        recrise.p = math.Clamp(recrise.p, recrise.p - diff.p, 0)
    end

    if recrise.y > 0 then
        recrise.y = math.Clamp(recrise.y, 0, recrise.y - diff.y)
    elseif recrise.y < 0 then
        recrise.y = math.Clamp(recrise.y, recrise.y - diff.y, 0)
    end

    recrise:Normalize()
    STALKERPLUS.RecoilRise = recrise

    if wpn:GetRecoilAmount() > 0 then
        local recoildir = wpn:GetRecoilDirection()
        local rec = math.Clamp(wpn:GetRecoilAmount(), 0, 1) * wpn:GetProcessedValue("Recoil")

        local eyeang = cmd:GetViewAngles()

        local uprec = math.sin(math.rad(recoildir)) * FrameTime() * rec * wpn:GetProcessedValue("RecoilUp")
        local siderec = math.cos(math.rad(recoildir)) * FrameTime() * rec * wpn:GetProcessedValue("RecoilSide")

        eyeang.p = eyeang.p + uprec
        eyeang.y = eyeang.y + siderec

        recrise = STALKERPLUS.RecoilRise

        recrise = recrise + Angle(uprec, siderec, 0)

        STALKERPLUS.RecoilRise = recrise

        cmd:SetViewAngles(eyeang)

        -- local aim_kick_v = rec * math.sin(CurTime() * 15) * FrameTime() * (1 - sightdelta)
        -- local aim_kick_h = rec * math.sin(CurTime() * 12.2) * FrameTime() * (1 - sightdelta)

        -- wpn:SetFreeAimAngle(wpn:GetFreeAimAngle() - Angle(aim_kick_v, aim_kick_h, 0))
    end

    if (wpn:GetLastRecoilTime() + wpn:GetProcessedValue("RecoilResetTime")) < CurTime() then
        recrise = STALKERPLUS.RecoilRise

        local recreset = recrise * FrameTime() * 6

        recrise = recrise - recreset

        recrise:Normalize()

        local eyeang = cmd:GetViewAngles()

        -- eyeang.p = math.AngleDifference(eyeang.p, recreset.p)
        -- eyeang.y = math.AngleDifference(eyeang.y, recreset.y)

        eyeang = eyeang - recreset

        cmd:SetViewAngles(eyeang)

        STALKERPLUS.RecoilRise = recrise
    end

    STALKERPLUS.LastEyeAngles = cmd:GetViewAngles()
end

hook.Add("StartCommand", "STALKERPLUS_StartCommand", STALKERPLUS.StartCommand)