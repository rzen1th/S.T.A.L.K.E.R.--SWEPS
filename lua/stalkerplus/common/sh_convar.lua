// the 0 is for load order!!!

local conVars = {
    {
        name = "showgrenadepanel",
        default = "1",
        type = "bool",
        client = true
    },
    {
        name = "autoreload",
        default = "0",
        client = true
    },
    {
        name = "autosave",
        default = "0",
        client = true
    },
    {
        name = "bodydamagecancel",
        default = "1",
        replicated = true
    },
    {
        name = "free_atts",
        default = "0",
        replicated = true
    },
    {
        name = "lock_atts",
        default = "0",
        replicated = true
    },
    {
        name = "loseattsondie",
        default = "1",
    },
    {
        name = "generateattentities",
        default = "1",
        replicated = true
    },
    {
        name = "npc_equality",
        default = "0",
    },
    {
        name = "npc_atts",
        default = "1",
    },
    {
        name = "penetration",
        default = "1",
        replicated = true
    },
    {
        name = "freeaim",
        default = "1",
        replicated = true
    },
    {
        name = "sway",
        default = "1",
        replicated = true
    },
    {
        name = "benchgun",
        default = "0",
    },
    {
        name = "ricochet",
        default = "1",
        replicated = true
    },
    {
        name = "bullet_physics",
        default = "1",
        replicated = true
    },
    {
        name = "bullet_gravity",
        default = "1",
        replicated = true
    },
    {
        name = "bullet_drag",
        default = "1",
        replicated = true
    },
    {
        name = "bullet_imaginary",
        default = "1",
        replicated = true
    },
    {
        name = "bullet_lifetime",
        default = "10",
        replicated = true
    },
}

local prefix = "STALKERPLUS_"

for _, var in pairs(conVars) do
    local convar_name = prefix .. var.name

    if var.client and CLIENT then
        CreateClientConVar(convar_name, var.default, true)
    else
        local flags = FCVAR_ARCHIVE
        if var.replicated then
            flags = flags + FCVAR_REPLICATED
        end
        CreateConVar(convar_name, var.default, flags)
    end
end

if CLIENT then

local function menu_client_ti(panel)
    panel:AddControl("checkbox", {
        label = "Reload Automatically",
        command = "STALKERPLUS_autoreload"
    })
    panel:AddControl("checkbox", {
        label = "Auto-Save Weapon",
        command = "STALKERPLUS_autosave"
    })
    panel:AddControl("checkbox", {
        label = "Show Grenade Panel",
        command = "STALKERPLUS_showgrenadepanel"
    })
end

local function menu_server_ti(panel)
    panel:AddControl("checkbox", {
        label = "Free Attachments",
        command = "STALKERPLUS_free_atts"
    })
    panel:AddControl("checkbox", {
        label = "Attachment Locking",
        command = "STALKERPLUS_lock_atts"
    })
    panel:AddControl("checkbox", {
        label = "Lose Attachments On Death",
        command = "STALKERPLUS_loseattsondie"
    })
    panel:AddControl("checkbox", {
        label = "Generate Attachment Entities",
        command = "STALKERPLUS_generateattentities"
    })
    panel:AddControl("checkbox", {
        label = "Enable Penetration",
        command = "STALKERPLUS_penetration"
    })
    panel:AddControl("checkbox", {
        label = "NPCs Deal Equal Damage",
        command = "STALKERPLUS_npc_equality"
    })
    panel:AddControl("checkbox", {
        label = "NPCs Get Random Attachments",
        command = "STALKERPLUS_npc_atts"
    })
    panel:AddControl("label", {
        text = "Disable body damage cancel only if you have another addon that will override the hl2 limb damage multipliers."
    })
    panel:AddControl("checkbox", {
        label = "Default Body Damage Cancel",
        command = "STALKERPLUS_bodydamagecancel"
    })
end

local clientmenus_ti = {
    {
        text = "Client", func = menu_client_ti
    },
    {
        text = "Server", func = menu_server_ti
    },
}

hook.Add("PopulateToolMenu", "STALKERPLUS_MenuOptions", function()
    for smenu, data in pairs(clientmenus_ti) do
        spawnmenu.AddToolMenuOption("Options", "STALKER+ Weapons", "STALKERPLUS_" .. tostring(smenu), data.text, "", "", data.func)
    end
end)

end