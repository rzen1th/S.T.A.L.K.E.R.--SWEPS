local sizes_to_make = {
    6,
    8,
    10,
    12,
    16,
    32
}

local unscaled_sizes_to_make = {
}

local font = "Jura"

local function generatefonts()

    for _, i in pairs(sizes_to_make) do

        surface.CreateFont( "STALKERPLUS_" .. tostring(i), {
            font = font,
            size = ScreenScale(i),
            weight = 800,
            antialias = true,
            extended = true, -- Required for non-latin fonts
        } )

        surface.CreateFont( "STALKERPLUS_" .. tostring(i) .. "_Glow", {
            font = font,
            size = ScreenScale(i),
            weight = 800,
            antialias = true,
            blursize = 6,
            extended = true,
        } )

    end

    for _, i in pairs(unscaled_sizes_to_make) do

        surface.CreateFont( "STALKERPLUS_" .. tostring(i) .. "_Unscaled", {
            font = font,
            size = i,
            weight = 800,
            antialias = true,
            extended = true,
        } )

    end

end

generatefonts()

function STALKERPLUS.Regen(full)
    if full then
        generatefonts()
    end
end

hook.Add( "OnScreenSizeChanged", "STALKERPLUS.Regen", function() STALKERPLUS.Regen(true) end)