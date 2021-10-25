SWEP.MultiSightTable = {
    -- {
    --     Pos = Vector(0, 0, 0),
    --     Ang = Angle(0, 0, 0)
    -- }
}

function SWEP:BuildMultiSight()
    self.MultiSightTable = {}

    local keepbaseirons = true

    for i, slottbl in ipairs(self:GetSubSlotList()) do
        if !slottbl.Installed then continue end
        local atttbl = STALKERPLUS.GetAttTable(slottbl.Installed)

        if atttbl.Sights then
            for _, sight in pairs(atttbl.Sights) do
                local s = self:GenerateAutoSight(sight, slottbl)
                table.insert(self.MultiSightTable, s)
            end

            if !slottbl.KeepBaseIrons and !atttbl.KeepBaseIrons then
                keepbaseirons = false
            end
        end
    end

    if keepbaseirons then
        local tbl = {}
        table.Add(tbl, self.BaseSights)
        table.Add(self.MultiSightTable, self.BaseSights)
        self.MultiSightTable = tbl
    end

    if self.MultiSightIndex > #self.MultiSightTable then
        self.MultiSightIndex = 1
    end
end

function SWEP:GenerateAutoSight(sight, slottbl)
    local apos, aang = self:GetAttPos(slottbl, false, true)

    local vpos = apos + (aang:Right() * -sight.Pos.x)
    vpos = vpos + (aang:Forward() * -sight.Pos.y)
    vpos = vpos + (aang:Up() * -sight.Pos.z)

    local vang = aang
    vang:RotateAroundAxis(vang:Right(), sight.Ang.p)
    vang:RotateAroundAxis(vang:Up(), sight.Ang.y)
    vang:RotateAroundAxis(vang:Forward(), sight.Ang.r)

    local x = vpos.x
    local y = vpos.y
    local z = vpos.z

    vpos.x = -y
    vpos.y = x
    vpos.z = z

    return {
        Pos = -vpos,
        Ang = -vang,
        Magnification = sight.Magnification or 1
    }
end

SWEP.MultiSightIndex = 1

function SWEP:GetSight()
    return self.MultiSightTable[self.MultiSightIndex] or {}
end

function SWEP:GetSightPositions()
    -- self:GenerateAutoSight()
    local s = self:GetSight()
    return s.Pos, s.Ang
end

function SWEP:SwitchMultiSight()
    local old_msi = self.MultiSightIndex
    self.MultiSightIndex = self.MultiSightIndex + 1

    if self.MultiSightIndex > #self.MultiSightTable then
        self.MultiSightIndex = 1
    end

    if self.MultiSightIndex != old_msi then
        // eh put some code in here
    end
end

function SWEP:GetMagnification()
    return self:GetSight().Magnification or 1
end

function SWEP:AdjustMouseSensitivity()
    local mag = self:GetMagnification()
    -- local fov = 90

    if mag > 0 then
        return 1 / mag
    end
end