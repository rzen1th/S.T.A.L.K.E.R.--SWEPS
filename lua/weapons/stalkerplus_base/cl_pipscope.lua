local rtmat = GetRenderTarget("stalkerplus_pipscope", 512, 512, false)

local rtsize = 512

function SWEP:DoRT(fov)
    if !GetConVar("stalkerplus_cheapscopes"):GetBool() then
        local rt = {
            x = 0,
            y = 0,
            w = rtsize,
            h = rtsize,
            angles = ang,
            origin = pos,
            drawviewmodel = false,
            fov = fov,
        }

        render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

        render.RenderView(rt)

        render.PopRenderTarget()
    end
end

local rtsurf = Material("effects/stalkerplus_rt")

function SWEP:DoRTScope(model, atttbl)
    render.PushRenderTarget(rtmat)

    cam.Start2D()

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(atttbl.RTScopeReticle)
    surface.DrawTexturedRect(0, 0, rtsize, rtsize)

    surface.SetDrawColor(0, 0, 0, 255 * (1 - self:GetSightAmount()))
    surface.DrawRect(0, 0, rtsize, rtsize)

    cam.End2D()

    render.PopRenderTarget()

    rtsurf:SetTexture("$basetexture", rtmat)

    model:SetSubMaterial()

    model:SetSubMaterial(atttbl.RTScopeSubmatIndex, "effects/stalkerplus_rt")
end

function SWEP:DoCheapScope(fov)
    local scrw = ScrW()
    local scrh = ScrH()

    scrw = scrw
    scrh = scrh * 9 / 16

    local s = (self:GetOwner():GetFOV() / fov) / 1.4

    local scrx = (ScrW() - scrw * s) / 2
    local scry = (ScrH() - scrh * s) / 2

    scrx = scrx + 16
    scry = scry + 16

    STALKERPLUS:DrawPhysBullets()

    render.UpdateScreenEffectTexture()
    local screen = render.GetScreenEffectTexture()
    render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

    -- cam.Start2D()
    render.DrawTextureToScreenRect(screen, scrx, scry, scrw * s, scrh * s)
    -- render.DrawTextureToScreenRect(ITexture tex, number x, number y, number width, number height)
    -- cam.End2D()

    render.PopRenderTarget()
end