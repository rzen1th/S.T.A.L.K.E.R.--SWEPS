function SWEP:CalcView(ply, pos, ang, fov)
    local rec = (self:GetLastRecoilTime() + self:GetProcessedValue("RecoilResetTime")) - CurTime()

    rec = rec * 10

    rec = math.Clamp(rec, 0, 1)

    rec = rec * self:GetProcessedValue("RecoilKick")

    if rec > 0 then
        ang.r = ang.r + (math.sin(CurTime() * 70.151) * rec * 0.25)
    end

    return pos, ang, fov
end