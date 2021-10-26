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
                s.atttbl = atttbl
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
    local pos, ang = self:GetAttPos(slottbl, false, true)

    pos = pos - (ang:Right() * sight.Pos.x)
    pos = pos - (ang:Forward() * sight.Pos.y)
    pos = pos - (ang:Up() * sight.Pos.z)

    ang:RotateAroundAxis(ang:Right(), sight.Ang.p)
    ang:RotateAroundAxis(ang:Up(), sight.Ang.y)
    ang:RotateAroundAxis(ang:Forward(), sight.Ang.r)

    debugoverlay.Axis(pos, ang, 16, 1, true)

    local s_pos = Vector(0, 0, 0)
    local s_ang = Angle(0, 0, 0)

    local up, forward, right = s_ang:Up(), s_ang:Forward(), s_ang:Right()

    s_pos = s_pos + (right * pos.x)
    s_pos = s_pos + (forward * pos.y)
    s_pos = s_pos + (up * -pos.z)

    return {
        Pos = s_pos,
        Ang = s_ang,
        Magnification = sight.Magnification or 1
    }
end

SWEP.MultiSightIndex = 1

function SWEP:GetSight()
    if GetConVar("developer"):GetBool() then
        self:BuildMultiSight()
    end
    return self.MultiSightTable[self.MultiSightIndex] or {}
end

function SWEP:GetSightPositions()
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