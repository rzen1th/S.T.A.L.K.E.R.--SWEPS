function SWEP:Think()
    local owner = self:GetOwner()

    if owner:KeyReleased(IN_ATTACK) then
        self:SetNeedTriggerPress(false)
        if !self:GetProcessedValue("RunawayBurst") then
            self:SetBurstCount(0)
        end
        if self:GetCurrentFiremode() < 0 and !self:GetProcessedValue("RunawayBurst") and self:GetBurstCount() > 0 then
            self:SetNextPrimaryFire(CurTime() + self:GetProcessedValue("PostBurstDelay"))
        end
    end

    if self:GetProcessedValue("RunawayBurst") then
        if self:GetBurstCount() >= self:GetCurrentFiremode() and self:GetCurrentFiremode() > 0 then
            self:SetBurstCount(0)
            self:SetNextPrimaryFire(CurTime() + self:GetProcessedValue("PostBurstDelay"))
            if !self:GetProcessedValue("AutoBurst") then
                self:SetNeedTriggerPress(true)
            end
        elseif self:GetBurstCount() > 0 and self:GetBurstCount() < self:GetCurrentFiremode() then
            self:PrimaryAttack()
        end
    end

    self:ThinkRecoil()

    self:ThinkSprint()

    self:ThinkReload()

    self:ThinkSights()

    self:ThinkFiremodes()

    self:ProcessTimers()

    if self:GetNextIdle() < CurTime() then
        self:Idle()
    end
end