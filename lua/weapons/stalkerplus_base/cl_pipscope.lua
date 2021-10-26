local rtmat = GetRenderTarget("stalkerplus_pipscope", 512, 512, false)

local rtsize = 512

function SWEP:DoRT(fov)
    if !GetConVar("stalkerplus_cheapscopes"):GetBool() then
        local rt = {
            x = 0,
            y = 0,
            w = rtsize,
            h = rtsize,
            angles = self:GetOwner():EyeAngles(),
            origin = self:GetOwner():GetShootPos(),
            drawviewmodel = false,
            fov = fov,
        }

        render.PushRenderTarget(rtmat, 0, 0, rtsize, rtsize)

        render.RenderView(rt)

        render.PopRenderTarget()
    end
end

local rtsurf = Material("effects/stalkerplus_rt")
local shadow = Material("stalkerplus/shadow.png", "smooth")

function SWEP:DoRTScope(model, atttbl)
    local pos = model:GetPos()
    local ang = model:GetAngles()

    pos = pos + ang:Forward() * 12000

    local screenpos = pos:ToScreen()

    local sh_x = (screenpos.x - (ScrW() / 2)) + (rtsize / 2)
    local sh_y = (screenpos.y - (ScrH() / 2)) + (rtsize / 2)

    local sh_s = math.floor(rtsize * 0.8)

    sh_x = sh_x - (sh_s / 2)
    sh_y = sh_y - (sh_s / 2)

    render.PushRenderTarget(rtmat)

    cam.Start2D()

    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(atttbl.RTScopeReticle)
    surface.DrawTexturedRect(0, 0, rtsize, rtsize)

    surface.SetDrawColor(0, 0, 0)
    surface.SetMaterial(shadow)
    surface.DrawTexturedRect(sh_x, sh_y, sh_s, sh_s)

    if !screenpos.visible then
        surface.DrawRect(0, 0, rtsize, rtsize)
    else
        surface.DrawRect(sh_x - rtsize, sh_y - rtsize, rtsize * 4, rtsize)
        surface.DrawRect(sh_x - rtsize, sh_y - rtsize, rtsize, rtsize * 4)
        surface.DrawRect(sh_x + sh_s, sh_y - rtsize, rtsize, rtsize * 4)
        surface.DrawRect(sh_x - rtsize, sh_y + sh_s, rtsize * 4, rtsize)
    end

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

    local s = (self:GetOwner():GetFOV() / self:GetMagnification() / fov) * 1.40

    local scrx = (ScrW() - scrw * s) / 2
    local scry = (ScrH() - scrh * s) / 2

    scrx = scrx + 8
    scry = scry + 8

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