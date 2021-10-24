SWEP.AttachmentAddresses = {}

function SWEP:LocateSlotFromAddress(address)
    return self.AttachmentAddresses[address]
end

function SWEP:BuildAttachmentAddresses()
    self.AttachmentAddresses = {}

    for c, i in pairs(self:GetSubSlotList()) do
        i.Address = c

        self.AttachmentAddresses[c] = i
    end
end

function SWEP:AttTreeToList(tree)
    local atts = {}

    atts = {tree}

    if tree.SubAttachments then
        for _, sub in pairs(tree.SubAttachments) do
            table.Add(atts, self:AttTreeToList(sub))
        end
    end

    return atts
end

function SWEP:GetSubSlotList()
    local atts = {}

    for _, i in pairs(self.Attachments or {}) do
        table.Add(atts, self:AttTreeToList(i))
    end

    return atts
end

function SWEP:GetAttachmentList()
    local atts = {}

    for _, i in pairs(self:GetSubSlotList()) do
        if i.Installed then
            table.insert(atts, i.Installed)
        end
    end

    return atts
end

function SWEP:BuildSubAttachmentTree(tbl)
    if !tbl.Installed then return {} end

    local atttbl = STALKERPLUS.GetAttTable(tbl.Installed)

    local subatts = {}

    if atttbl then
        if atttbl.Attachments then
            subatts = table.Copy(atttbl.Attachments)
            for i, k in ipairs(tbl.SubAttachments) do
                subatts[i].Installed = tbl[i].Installed
                subatts[i].SubAttachments = self:BuildSubAttachmentTree(k)
            end
        end
    end

    return subatts
end

function SWEP:BuildSubAttachments(tbl)
    for i, k in pairs(self.Attachments) do
        k.SubAttachments = {}
    end

    for i, k in pairs(tbl) do
        self.Attachments[i].Installed = k.Installed

        if !k.Installed then continue end

        local atttbl = STALKERPLUS.GetAttTable(k.Installed)

        if atttbl then
            if atttbl.Attachments then
                self.Attachments[i].SubAttachments = self:BuildSubAttachmentTree(k)
            end
        end
    end

    self:BuildAttachmentAddresses()
end