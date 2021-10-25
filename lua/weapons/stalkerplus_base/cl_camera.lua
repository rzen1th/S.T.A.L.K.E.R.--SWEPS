SWEP.SmoothedMagnification = 1

function SWEP:CalcView(ply, pos, ang, fov)
    local rec = (self:GetLastRecoilTime() + self:GetProcessedValue("RecoilResetTime")) - CurTime()

    rec = rec * 10

    rec = math.Clamp(rec, 0, 1)

    rec = rec * self:GetProcessedValue("RecoilKick")

    if rec > 0 then
        ang.r = ang.r + (math.sin(CurTime() * 70.151) * rec * 0.25)
    end

    local mag = 1

    if self:GetSightAmount() > 0 then
        mag = Lerp(self:GetSightAmount(), 1, self:GetMagnification())
    end

    local diff = math.abs(self.SmoothedMagnification - mag)

    self.SmoothedMagnification = math.Approach(self.SmoothedMagnification, mag, FrameTime() * diff * 10)

    fov = fov / self.SmoothedMagnification

    return pos, ang, fov
end