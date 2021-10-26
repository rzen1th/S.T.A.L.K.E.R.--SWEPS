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

function SWEP:GetAttBlocked(atttbl)
    local eles = self:GetElements()

    if atttbl.ExcludeElements then
        for _, group in ipairs(atttbl.ExcludeElements) do
            if !istable(group) then
                group = {group}
            end

            local ok = false
            for _, ele in ipairs(group) do
                if !eles[ele] then ok = true break end
            end

            if !ok then return true end
        end
    end

    if atttbl.RequireElements then
        for _, group in ipairs(atttbl.ExcludeElements) do
            if !istable(group) then
                group = {group}
            end

            local ok = true
            for _, ele in ipairs(group) do
                if !eles[ele] then ok = false break end
            end

            if ok then return true end
        end

        return true
    end

    return false
end

function SWEP:GetSlotBlocked(slottbl)
    local eles = self:GetElements()

    if slottbl.ExcludeElements then
        for _, group in ipairs(slottbl.ExcludeElements) do
            if !istable(group) then
                group = {group}
            end

            local ok = false
            for _, ele in ipairs(group) do
                if !eles[ele] then ok = true break end
            end

            if !ok then return true end
        end
    end

    local totalcount = self:CountAttachments()

    if totalcount >= STALKERPLUS.GetMaxAtts() then return true end

    if slottbl.RequireElements then
        for _, group in ipairs(slottbl.RequireElements) do
            if !istable(group) then
                group = {group}
            end

            local ok = true
            for _, ele in ipairs(group) do
                if !eles[ele] then ok = false break end
            end

            if ok then return true end
        end

        return true
    end

    return false
end

function SWEP:CanAttach(addr, att, slottbl)
    slottbl = slottbl or self:LocateSlotFromAddress(addr)

    if self:RunHook("Hook_BlockAttachment", {att = att, slottbl = slottbl}) == false then return false end

    if self:GetSlotBlocked(slottbl) then return false end

    local cat = slottbl.Category

    if !istable(cat) then
        cat = {cat}
    end

    local atttbl = STALKERPLUS.GetAttTable(att)

    if atttbl.Max then
        local count = self:CountAttachments(att)

        if atttbl.InvAtt then
            count = count + self:CountAttachments(atttbl.InvAtt)
        end

        if slottbl.Installed then
            local installed_atttbl = STALKERPLUS.GetAttTable(slottbl.Installed)

            if installed_atttbl.InvAtt == att or att.InvAtt == slottbl.Installed then
                count = count - 1
            elseif slottbl.Installed == installed_atttbl.InvAtt then
                count = count - 1
            end
        end

        if count >= atttbl.Max then return false end
    end

    if self:GetAttBlocked(atttbl) then return false end

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

function SWEP:CountAttachments(countatt)
    local qty = 0

    for _, att in ipairs(self:GetAttachmentList()) do
        if !countatt then
            qty = qty + 1
        else
            local atttbl = STALKERPLUS.GetAttTable(att)
            if countatt == att or countatt == atttbl.InvAtt then
                qty = qty + 1
            end
        end
    end

    return qty
end