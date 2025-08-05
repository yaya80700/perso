GTOCharSys = GTOCharSys or {}
AddCSLuaFile()

function ATGLoad()
    if SERVER then
        
        AddCSLuaFile("character_system/gto_character_config.lua")
        AddCSLuaFile("character_system/sh_utils.lua")
        AddCSLuaFile("character_system/sh_parts_data.lua")

        AddCSLuaFile("character_system/client/cl_identity.lua")
        AddCSLuaFile("character_system/client/cl_main.lua")
        AddCSLuaFile("character_system/client/cl_pss.lua")
        AddCSLuaFile("character_system/client/cl_pss_frame.lua")
        AddCSLuaFile("character_system/client/cl_pss_offline_characters.lua")
        AddCSLuaFile("character_system/client/cl_pss_offline_steamid.lua")
        AddCSLuaFile("character_system/client/cl_pss_select.lua")
        AddCSLuaFile("character_system/client/cl_storage.lua")
        AddCSLuaFile("character_system/client/cl_wardrobe.lua")


        AddCSLuaFile("matproxy/skin_color.lua")
        AddCSLuaFile("matproxy/hairs_color.lua")
        AddCSLuaFile("matproxy/headband_color.lua")
        AddCSLuaFile("matproxy/dojutsu.lua")

        include("character_system/gto_character_config.lua")
        include("character_system/sh_utils.lua")
        include("character_system/sh_parts_data.lua")

        include("character_system/server/sv_main.lua")
        include("character_system/server/sv_storage.lua")
        include("character_system/server/sv_pss.lua")

	elseif CLIENT then
        include("character_system/gto_character_config.lua")
        include("character_system/sh_utils.lua")
        include("character_system/sh_parts_data.lua")

        include("character_system/client/cl_identity.lua")
        include("character_system/client/cl_main.lua")
        include("character_system/client/cl_pss.lua")
        include("character_system/client/cl_pss_frame.lua")
        include("character_system/client/cl_pss_offline_characters.lua")
        include("character_system/client/cl_pss_offline_steamid.lua")
        include("character_system/client/cl_pss_select.lua")
        include("character_system/client/cl_storage.lua")
        include("character_system/client/cl_wardrobe.lua")
    end 
end

timer.Simple(0, ATGLoad)