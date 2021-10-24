function SWEP:Attach(addr, att, silent)
    if !self:CanAttach(addr, att) then return end

    local slottbl = self:LocateSlotFromAddress(addr)

    slottbl.Installed = att

    if CLIENT then
        self:SendWeapon()
        self:SetupModel(true)
        self:SetupModel(false)
        self:InvalidateCache()
    end
end

function SWEP:Detach(addr, silent)
    if !self:CanDetach(addr) then return end

    local slottbl = self:LocateSlotFromAddress(addr)

    slottbl.Installed = nil

    if CLIENT then
        self:SendWeapon()
        self:SetupModel(true)
        self:SetupModel(false)
        self:InvalidateCache()
    end
end

function SWEP:ToggleCustomize(on)
    if on == self:GetCustomize() then return end

    self:SetCustomize(on)

    self:SetShouldHoldType()

    if !self:GetCustomize() then
        self:Inspect(true)
    end
end

function SWEP:CanAttach(addr, att)
    local slottbl = self:LocateSlotFromAddress(addr)

    return true
end

function SWEP:CanDetach(addr)
    local slottbl = self:LocateSlotFromAddress(addr)

    if slottbl and slottbl.Integral then return false end

    return true
end