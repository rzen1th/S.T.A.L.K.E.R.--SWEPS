SWEP.ElementsCache = {}

function SWEP:GetElements()
    if self.ElementsCache then return self.ElementsCache end

    local eles = {}

    for _, slottbl in pairs(self:GetSubSlotList()) do
        if slottbl.Installed then
            table.Add(eles, slottbl.InstalledElements or {})
            local atttbl = STALKERPLUS.GetAttTable(slottbl.Installed)
            table.Add(eles, atttbl.ActivateElements or {})
            local cat = atttbl.Category
            if !istable(cat) then
                cat = {cat}
            end
            table.Add(eles, cat)
            table.insert(eles, slottbl.Installed)
        else
            table.Add(eles, slottbl.UnInstalledElements or {})
        end
    end

    table.insert(eles, self.DefaultElements or {})

    if !STALKERPLUS.Overrun then
        STALKERPLUS.Overrun = true
        table.insert(eles, self:GetCurrentFiremodeTable().ActivateElements or {})
        STALKERPLUS.Overrun = false
    end

    local eles2 = {}

    for _, ele in ipairs(eles) do
        eles2[ele] = true
    end

    self.ElementsCache = eles2

    return eles2
end