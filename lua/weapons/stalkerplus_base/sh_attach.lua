function SWEP:Attach(addr, att, silent)
    if !self:CanAttach(addr, att) then return false end

    local slottbl = self:LocateSlotFromAddress(addr)

    slottbl.Installed = att

    self:PostModify()

    return true
end

function SWEP:Detach(addr, silent)
    if !self:CanDetach(addr) then return false end

    local slottbl = self:LocateSlotFromAddress(addr)

    slottbl.Installed = nil

    self:PostModify()

    return true
end

function SWEP:PostModify()
    self:InvalidateCache()

    if CLIENT then
        self:SendWeapon()
        self:SetupModel(true)
        self:SetupModel(false)
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

function SWEP:CanAttach(addr, att, slottbl)
    slottbl = slottbl or self:LocateSlotFromAddress(addr)

    if self:RunHook("Hook_BlockAttachment", {att = att, slottbl = slottbl}) == false then return false end

    local cat = slottbl.Category

    if !istable(cat) then
        cat = {cat}
    end

    local atttbl = STALKERPLUS.GetAttTable(att)

    local attcat = atttbl.Category

    if !istable(attcat) then
        attcat = {attcat}
    end

    for _, c in pairs(attcat) do
        if table.HasValue(cat, c) then
            return true
        end
    end

    return false
end

function SWEP:CanDetach(addr)
    local slottbl = self:LocateSlotFromAddress(addr)

    if slottbl and slottbl.Integral then return false end

    return true
end