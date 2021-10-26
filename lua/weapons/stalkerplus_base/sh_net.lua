function SWEP:SendWeapon(rec)
    net.Start("stalkerplus_networkweapon")
    net.WriteEntity(self)

    for i, k in pairs(self.Attachments or {}) do
        self:SendAttachmentTree(self.Attachments[i])
    end

    if SERVER then
        if rec then
            // send to just this one person
            net.Send(rec)
        else
            net.Broadcast()
        end
    else
        net.SendToServer()
    end
end

function SWEP:SendAttachmentTree(tree)
    if tree and tree.Installed then
        local atttbl = STALKERPLUS.GetAttTable(tree.Installed)
        local id = atttbl.ID

        net.WriteUInt(id, STALKERPLUS.Attachments_Bits)

        tree.SubAttachments = tree.SubAttachments or {}

        if atttbl.Attachments then
            for i, k in pairs(atttbl.Attachments) do
                self:SendAttachmentTree(tree.SubAttachments[i])
            end
        end
    else
        net.WriteUInt(0, STALKERPLUS.Attachments_Bits)
    end
end

function SWEP:CountAttsInTree(tree)
    local flattree = self:AttTreeToList(tree)

    local count = {}

    for _, i in ipairs(flattree) do
        if i.Installed then
            local att = i.Installed
            count[att] = (count[att] or 0) + 1
        end
    end

    return count
end

function SWEP:ReceiveWeapon()
    local tbl = {}

    for i, k in pairs(self.Attachments or {}) do
        tbl[i] = self:ReceiveAttachmentTree()
    end

    if SERVER then
        if !self:ValidateInventoryForNewTree(tbl) then
            return
        end
    end

    self:BuildSubAttachments(tbl)

    if CLIENT then
        self:SetupModel(true)
        self:SetupModel(false)
        self:RefreshCustomizeMenu()
    else
        self:SendWeapon()
    end
end

function SWEP:ReceiveAttachmentTree()
    local id = net.ReadUInt(STALKERPLUS.Attachments_Bits)
    local att = STALKERPLUS.Attachments_Index[id]

    local tree = {
        Installed = att,
        SubAttachments = {}
    }

    if !att then return tree end

    local atttbl = STALKERPLUS.GetAttTable(att)

    if atttbl.Attachments then
        for i, k in pairs(atttbl.Attachments) do
            tree.SubAttachments[i] = self:ReceiveAttachmentTree()
        end
    end

    return tree
end