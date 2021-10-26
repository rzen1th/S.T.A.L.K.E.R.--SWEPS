local rtmat = GetRenderTarget("stalkerplus_pipscope", 512, 512, false)

local rtsize = 512

function SWEP:DoRT(fov)
    local size = rtsize
    local rt = {
        x = 0,
        y = 0,
        w = size,
        h = size,
        angles = ang,
        origin = pos,
        drawviewmodel = false,
        fov = fov,
    }

    render.PushRenderTarget(rtmat, 0, 0, size, size)

    render.RenderView(rt)

    render.PopRenderTarget()
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