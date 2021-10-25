SWEP.CustomizeDelta = 0

SWEP.ViewModelPos = Vector(0, 0, 0)
SWEP.ViewModelAng = Angle(0, 0, 0)

function SWEP:GetViewModelPosition(pos, ang)
    if GetConVar("stalkerplus_benchgun"):GetBool() then
        return Vector(0, 0, 0), Angle(0, 0, 0)
    end

    -- pos = Vector(0, 0, 0)
    -- ang = Angle(0, 0, 0)

    local oldang = Angle(0, 0, 0)

    oldang:Set(ang)

    local offsetpos = Vector(0, 0, 0)
    local offsetang = Angle(0, 0, 0)

    local extra_offsetpos = Vector(0, 0, 0)
    local extra_offsetang = Angle(0, 0, 0)

    -- print(extra_offsetang)

    offsetpos:Set(self:GetProcessedValue("PassivePos"))
    offsetang:Set(self:GetProcessedValue("PassiveAng"))

    local sightdelta = self:Curve(self:GetSightDelta())

    -- cor_val = Lerp(sightdelta, cor_val, 1)

    if sightdelta > 0 then
        local sightpos, sightang = self:GetSightPositions()

        -- local sightpos = self.SightPos
        -- local sightang = self.SightAng

        offsetpos = LerpVector(sightdelta, offsetpos, sightpos)
        offsetang = LerpAngle(sightdelta, offsetang, sightang)
    end

    -- local eepos, eeang = self:GetExtraSightPosition()
    local eepos, eeang = Vector(0, 0, 0), Angle(0, 0, 0)

    local im = self:GetProcessedValue("SightMidPoint")

    local midpoint = sightdelta * math.cos(sightdelta * (math.pi / 2))
    local joffset = (im and im.Pos or Vector(0, 0, 0)) * midpoint
    local jaffset = (im and im.Ang or Angle(0, 0, 0)) * midpoint

    extra_offsetpos = LerpVector(sightdelta, extra_offsetpos, -eepos + joffset)
    extra_offsetang = LerpAngle(sightdelta, extra_offsetang, -eeang + jaffset)

    -- extra_offsetang.y = extra_offsetang.y - (self:GetSwayAngles().p * cor_val)
    -- extra_offsetang.p = extra_offsetang.p + (self:GetSwayAngles().y * cor_val)

    -- extra_offsetang.y = extra_offsetang.y - (self:GetFreeAimOffset().p * cor_val)
    -- extra_offsetang.p = extra_offsetang.p + (self:GetFreeAimOffset().y * cor_val)

    if game.SinglePlayer() or IsFirstTimePredicted() then
        if self:GetCustomize() then
            self.CustomizeDelta = math.Approach(self.CustomizeDelta, 1, FrameTime() * 1 / 0.15)
        else
            self.CustomizeDelta = math.Approach(self.CustomizeDelta, 0, FrameTime() * 1 / 0.15)
        end
    end

    local curvedcustomizedelta = self:Curve(self.CustomizeDelta)

    -- local sprintdelta = self:Curve(self:GetSprintDelta())
    local sprintdelta = self:Curve(self:GetSprintDelta())

    if sprintdelta > 0 then
        offsetpos = LerpVector(sprintdelta, offsetpos, self:GetProcessedValue("SprintPos"))
        offsetang = LerpAngle(sprintdelta, offsetang, self:GetProcessedValue("SprintAng"))

        extra_offsetang = LerpAngle(sprintdelta, extra_offsetang, Angle(0, 0, 0))
    end

    local sim = self:GetProcessedValue("SprintMidPoint")

    local spr_midpoint = sprintdelta * math.cos(sprintdelta * (math.pi / 2))
    local spr_joffset = (sim and sim.Pos or Vector(0, 0, 0)) * spr_midpoint
    local spr_jaffset = (sim and sim.Ang or Angle(0, 0, 0)) * spr_midpoint

    extra_offsetpos = extra_offsetpos + spr_joffset
    extra_offsetang = extra_offsetang + spr_jaffset

    self.BobScale = 0
    self.SwayScale = Lerp(sightdelta, 1, 0.1)

    if curvedcustomizedelta > 0 then
        offsetpos = LerpVector(curvedcustomizedelta, offsetpos, self:GetProcessedValue("CustomizePos"))
        offsetang = LerpAngle(curvedcustomizedelta, offsetang, self:GetProcessedValue("CustomizeAng"))

        extra_offsetpos = LerpVector(curvedcustomizedelta, extra_offsetpos, Vector(0, 0, 0))
        extra_offsetang = LerpAngle(curvedcustomizedelta, extra_offsetang, Angle(0, 0, 0))

        offsetang = offsetang + (self.MenuRotation * curvedcustomizedelta)
        offsetang:Normalize()
        extra_offsetang:Normalize()
        extra_offsetpos = extra_offsetpos + (Vector(-24, 0, 0) * (math.cos(math.rad(self.MenuRotation.p)) - 1) / -2)
        extra_offsetpos = extra_offsetpos + (Vector(0, -14, 0) * (math.sin(math.rad(self.MenuRotation.p)) - 1) / -2)
        extra_offsetpos = extra_offsetpos + (Vector(0, 0, -24) * (math.cos(math.rad(self.MenuRotation.y)) - 1) / -2)

        extra_offsetpos = LerpVector(1 - curvedcustomizedelta, extra_offsetpos, Vector(0, 0, 0))
    end

    self.ViewModelPos = LerpVector(0.8, offsetpos, self.ViewModelPos)
    offsetpos = self.ViewModelPos

    self.ViewModelAng = LerpAngle(0.8, offsetang, self.ViewModelAng)
    offsetang = self.ViewModelAng
    self.ViewModelAng:Normalize()

    pos = pos + (ang:Right() * offsetpos.x)
    pos = pos + (ang:Forward() * offsetpos.y)
    pos = pos + (ang:Up() * offsetpos.z)

    ang:RotateAroundAxis(oldang:Up(), offsetang.p)
    ang:RotateAroundAxis(oldang:Right(), offsetang.y)
    ang:RotateAroundAxis(oldang:Forward(), offsetang.r)

    pos = pos + (oldang:Right() * extra_offsetpos[1])
    pos = pos + (oldang:Forward() * extra_offsetpos[2])
    pos = pos + (oldang:Up() * extra_offsetpos[3])

    ang:RotateAroundAxis(oldang:Up(), extra_offsetang[1])
    ang:RotateAroundAxis(oldang:Right(), extra_offsetang[2])
    ang:RotateAroundAxis(oldang:Forward(), extra_offsetang[3])

    pos, ang = self:GetViewModelBob(pos, ang)
    pos, ang = self:GetMidAirBob(pos, ang)
    pos, ang = self:GetViewModelLeftRight(pos, ang)
    pos, ang = self:GetViewModelInertia(pos, ang)
    pos, ang = self:GetViewModelSway(pos, ang)
    pos, ang = self:GetViewModelSmooth(pos, ang)

    self.LastViewModelPos = pos
    self.LastViewModelAng = ang

    return pos, ang
end