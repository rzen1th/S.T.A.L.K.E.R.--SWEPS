function SWEP:GetSightDelta()
    return self:GetSightAmount()
end

function SWEP:EnterSights()
    if self:GetSprintAmount() > 0 then return end

    self:SetInSights(true)
    self:EmitSound(self:GetProcessedValue("SoundEnterSights"), 100, 75)
end

function SWEP:ExitSights()
    self:SetInSights(false)
    self:EmitSound(self:GetProcessedValue("SoundExitSights"), 100, 75)
end

function SWEP:ThinkSights()
    if self:GetSafe() then return end

    local sighted = self:GetInSights()

    local amt = self:GetSightAmount()

    if sighted then
        amt = math.Approach(amt, 1, FrameTime() / self:GetProcessedValue("AimDownSightsTime"))
    else
        amt = math.Approach(amt, 0, FrameTime() / self:GetProcessedValue("AimDownSightsTime"))
    end

    self:GetVM():SetPoseParameter("sights", amt)

    self:SetSightAmount(amt)

    if sighted and !self:GetOwner():KeyDown(IN_ATTACK2) then
        self:ExitSights()
    elseif !sighted and self:GetOwner():KeyDown(IN_ATTACK2) then
        if self:GetOwner():KeyDown(IN_USE) then
            return
        end

        self:EnterSights()
    end
end

function SWEP:GetShouldFOV()
    return GetConVar("fov_desired"):GetFloat()
end

function SWEP:AdjustMouseSensitivity()
    local fov = self:GetShouldFOV()
    -- local fov = 90

    if fov > 0 then
        return fov / 90
    end
end