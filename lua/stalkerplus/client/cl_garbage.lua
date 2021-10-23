STALKERPLUS.CSModelPile    = {} -- { {Model = NULL, Weapon = NULL} }
STALKERPLUS.FlashlightPile = {}

function STALKERPLUS.CollectGarbage()
    local removed = 0

    local newpile = {}

    for _, k in pairs(STALKERPLUS.CSModelPile) do
        if IsValid(k.Weapon) then
            table.insert(newpile, k)

            continue
        end

        SafeRemoveEntity(k.Model)

        removed = removed + 1
    end

    STALKERPLUS.CSModelPile = newpile

    if GetConVar("developer"):GetBool() and removed > 0 then
        print("Removed " .. tostring(removed) .. " CSModels")
    end
end

hook.Add("PostCleanupMap", "STALKERPLUS.CleanGarbage", function()
    STALKERPLUS.CollectGarbage()
end)

timer.Create("STALKERPLUS CSModel Garbage Collector", 5, 0, STALKERPLUS.CollectGarbage)

hook.Add("PostDrawEffects", "STALKERPLUS_CleanFlashlights", function()
    local newflashlightpile = {}

    for _, k in pairs(STALKERPLUS.FlashlightPile) do
        if IsValid(k.Weapon) and k.Weapon == LocalPlayer():GetActiveWeapon() then
            table.insert(newflashlightpile, k)

            continue
        end

        if k.ProjectedTexture and k.ProjectedTexture:IsValid() then
            k.ProjectedTexture:Remove()
        end
    end

    STALKERPLUS.FlashlightPile = newflashlightpile

    local wpn = LocalPlayer():GetActiveWeapon()

    if !wpn then return end
    if !IsValid(wpn) then return end
    if !wpn.STALKERPLUS then return end

    if GetViewEntity() == LocalPlayer() then return end

    wpn:KillFlashlightsVM()
end)