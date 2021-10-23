function SWEP:SwitchFiremode()
    if #self:GetValue("Firemodes") == 0 then return end

    local fm = self:GetFiremode()

    self:PlayAnimation("firemode" .. tostring(fm))

    fm = fm + 1

    if fm > #self:GetValue("Firemodes") then
        fm = 1
    end

    self:EmitSound(self:GetProcessedValue("SoundFiremode"), 75, 100, 1, CHAN_ITEM)

    self:SetFiremode(fm)

    self:InvalidateCache()
end

function SWEP:GetCurrentFiremode()
    mode = self:GetValue("Firemodes")[self:GetFiremode()].Mode

    mode = self:RunHook("Hook_TranslateMode") or mode

    return mode
end

function SWEP:GetCurrentFiremodeTable()
    local fm = self:GetFiremode()

    if fm > #self:GetValue("Firemodes") then
        fm = 1
    end

    return self:GetValue("Firemodes")[fm]
end

function SWEP:ToggleSafety(onoff)
    onoff = onoff or !self:GetSafe()

    self:SetSafe(onoff)
end

function SWEP:ThinkFiremodes()
    if self:GetOwner():KeyPressed(IN_ATTACK2) and self:GetOwner():KeyDown(IN_USE) then
        self:ToggleSafety()
    end

    if self:GetOwner():KeyPressed(IN_RELOAD) and self:GetOwner():KeyDown(IN_USE) then
        self:SwitchFiremode()
    end
end