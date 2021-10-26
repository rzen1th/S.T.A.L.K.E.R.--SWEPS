function SWEP:PreDrawViewModel()
    self:DoRHIK()

    if self:GetCustomize() then
        DrawBokehDOF( 10, 1, 0.1 )

        cam.Start2D()
            surface.SetDrawColor(0, 0, 0, 150)
            surface.DrawRect(0, 0, ScrW(), ScrH())
        cam.End2D()
    end

    self:DoBodygroups(false)
    self:GetVM():SetPoseParameter("sights", self:GetSightAmount())

    if GetConVar("stalkerplus_benchgun"):GetBool() then
        cam.Start3D()
    end
    cam.IgnoreZ(true)
end

function SWEP:PostDrawViewModel()
    cam.IgnoreZ(false)
    if GetConVar("stalkerplus_benchgun"):GetBool() then
        cam.End3D()
    end
end

function SWEP:ViewModelDrawn()
    self:DrawCustomModel(false)
    -- self:DrawLasers()
end

function SWEP:DrawCustomModel(wm)

    if !wm and !IsValid(self:GetOwner()) then return end
    if !wm and self:GetOwner():IsNPC() then return end

    local mdl = self.VModel

    if wm then
        mdl = self.WModel
    end

    if !mdl then
        self:SetupModel(wm)

        mdl = self.VModel

        if wm then
            mdl = self.WModel
        end
    end

    for _, model in pairs(mdl) do
        local slottbl = model.slottbl
        -- local atttbl = model.atttbl

        local apos, aang = self:GetAttPos(slottbl, wm)

        model:SetPos(apos)
        model:SetAngles(aang)
        model:SetRenderOrigin(apos)
        model:SetRenderAngles(aang)

        if !wm and model.atttbl.HoloSight then
            self:DoHolosight(model, model.atttbl)
        end

        if !wm and model.atttbl.RTScope then
            self:DoRTScope(model, model.atttbl)
        end

        if !model.NoDraw then
            model:DrawModel()
        end
    end

    if !wm then
        self:DrawFlashlightsVM()
    end
end