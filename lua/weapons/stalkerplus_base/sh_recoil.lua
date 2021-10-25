function SWEP:ThinkRecoil()
    if (self:GetLastRecoilTime() + self:GetProcessedValue("RecoilResetTime")) < CurTime() then
        local rec = self:GetRecoilAmount()

        rec = rec - (FrameTime() * self:GetProcessedValue("RecoilDissipationRate"))

        rec = math.Clamp(rec, 0, self:GetProcessedValue("RecoilMaximum"))

        self:SetRecoilAmount(rec)
    end
end

function SWEP:ApplyRecoil()
    local rec = self:GetRecoilAmount()

    local rps = 1

    rec = rec + rps

    local delay = 60 / self:GetProcessedValue("RPM")

    rec = math.Clamp(rec, 0, self:GetProcessedValue("RecoilMaximum"))

    self:SetRecoilDirection(util.SharedRandom("stalkerplus_recoildir", -180, 0))
    -- self:SetRecoilDirection(-90)
    self:SetRecoilAmount(rec)
    self:SetLastRecoilTime(CurTime() + (delay * 2))

    -- local vis_kick = self:GetProcessedValue("RecoilKick")
    -- local vis_shake = 0

    -- vis_kick = vis_kick * rps
    -- vis_shake = vis_kick * rps

    -- local vis_kick_v = vis_kick * 0.5
    -- local vis_kick_h = vis_kick * util.SharedRandom("stalkerplus_vis_kick_h", -1, 1)
    -- vis_shake = vis_shake * util.SharedRandom("stalkerplus_vis_kick_shake", -1, 1)

    -- self:GetOwner():SetViewPunchAngles(Angle(vis_kick_v, vis_kick_h, vis_shake))

    self:GetOwner():SetFOV(self:GetOwner():GetFOV() * 0.99, 0)
    self:GetOwner():SetFOV(0, 60 / (self:GetProcessedValue("RPM")))
end