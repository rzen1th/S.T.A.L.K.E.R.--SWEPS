function SWEP:Attach(slot, att, silent)
end

function SWEP:Detach(slot, silent)
end

function SWEP:ToggleCustomize(on)
    if on == self:GetCustomize() then return end

    self:SetCustomize(on)

    self:SetShouldHoldType()

    if !self:GetCustomize() then
        self:Inspect(true)
    end
end

function SWEP:CanAttach(slot, att)
    local slottbl = self:LocateSlotFromAddress(slot)
end

function SWEP:CanDetach(slot)
    local slottbl = self:LocateSlotFromAddress(slot)

    if slottbl and slottbl.Integral then return false end

    return true
end