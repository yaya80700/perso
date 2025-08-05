--[ OPEN FRAMES ]--

local function discordPSSLog(type, admin, target, swep)
    local webhookURL = ""
    
    local payload = {
        content = string.format("**Type:** %s\n**Admin:** %s\n**Target:** %s\n**SWEP:** %s", 
            type, 
            admin, 
            target, 
            swep
        )
    }

    local jsonPayload = util.TableToJSON(payload)

    local headers = {
        ["Content-Type"] = "application/json"
    }

    HTTP({
        url = webhookURL,
        method = "POST",
        body = jsonPayload,
        headers = headers,
        success = function(code, body, headers)
            print("Discord webhook sent successfully")
        end,
        failed = function(err)
            print("Discord webhook error: " .. err)
        end
    })
end

util.AddNetworkString("CTG_Characters_OpenPSS_Select")
net.Receive("CTG_Characters_OpenPSS_Select", function(len, ply)
	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then 
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		print("g_sys_character/lua/characther_system/server/sv_pss.lua LIGNE 18")

		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		return 
	end
	
	local cache = GTOCharSys:GetAllCharacters()
	local newCache = {}

	for key, value in pairs(cache) do
		newCache[util.SteamIDFrom64(key)] = value
	end
	newCache = util.TableToJSON(newCache)
	newCache = util.Compress(newCache)

	net.Start("CTG_Characters_OpenPSS_Select")
	net.WriteUInt(#newCache, 32)
	net.WriteData(newCache, #newCache)
	net.Send(ply)
end)

util.AddNetworkString("CTG_Characters_OpenPSS_SelectOffline")
net.Receive("CTG_Characters_OpenPSS_SelectOffline", function(len, ply)
	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then

	 	print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		print("g_sys_character/lua/characther_system/server/sv_pss.lua LIGNE 52")

		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		return  
	end
	
	local steamid = net.ReadString()
	if string.find(steamid, "STEAM") then -- Convert STEAMID to 64 if needed
		steamid = util.SteamIDTo64(steamid)
	end
	
	CTGPermaSwepSystem:OpenOffline(ply, steamid)
end)

util.AddNetworkString("CTG_Characters_SavePSS")
net.Receive("CTG_Characters_SavePSS", function(len, ply)
	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then
	
	 	print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		print("g_sys_character/lua/characther_system/server/sv_pss.lua LIGNE 82")

		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		return  
	end

	local steamid = net.ReadString()
	CTGPermaSwepSystem:SaveData(steamid)
end)


util.AddNetworkString("CTG_Characters_OpenPSS")
net.Receive("CTG_Characters_OpenPSS", function(len, ply)
	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then
	
	 	print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		print("g_sys_character/lua/characther_system/server/sv_pss.lua LIGNE 108")

		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		return  
	end

	local steamid = net.ReadString()
	local charId = net.ReadString()
	local char = nil
	local isGlobal = tonumber(charId) < 1

	if !isGlobal then
		char = GTOCharSys:GetCharacterByID(steamid, charId)
		if not char then return end
	end

	net.Start("CTG_Characters_OpenPSS")
	net.WriteBool(isGlobal)
	net.WriteString(steamid)

	local sweps = CTGPermaSwepSystem:GetData(steamid)
	sweps = util.TableToJSON(sweps)
	sweps = util.Compress(sweps)
	net.WriteUInt(#sweps, 32)
	net.WriteData(sweps, #sweps)


	if char then
		char = util.TableToJSON(char)
		char = util.Compress(char)
		net.WriteUInt(#char, 32)
		net.WriteData(char, #char)
	end

	net.Send(ply)
end)

util.AddNetworkString("CTG_Characters_PSS_Add")
net.Receive("CTG_Characters_PSS_Add", function(len, ply)

	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then
		return  
	end

	local steamid = net.ReadString()
	local charId = net.ReadString()
	local swep = net.ReadString()

	CTGPermaSwepSystem:AddSwep(steamid, charId, swep)

	local target = "nil"
	if tonumber(charId) > 0 then
		local char = GTOCharSys:GetCharacterByID(steamid, charId)
		if char then target = char.name end
	else
		local ply = player.GetBySteamID64(steamid)
		if IsValid(ply) then
			target = ply:SteamName()
		else
			target = steamid
		end
		target = target.." (Global)"
	end

	for _, ply in ipairs(player.GetAll()) do
		if ply:IsAdmin() or ply:IsSuperAdmin() then
			ply:SendLua(string.format([[chat.AddText(
				Color(255, 150, 40), "[LCS]",
				Color(0, 150, 0), " Vous avez donné le swep ",
				Color(255, 255, 0), "%s",
				Color(0, 150, 0), " à ",
				Color(255, 255, 0), "%s",
				Color(0, 150, 0), " !"
			)]], swep, target))
		end
	end
	

    discordPSSLog("add", 
        string.format("%s (%s)", ply:Nick(), ply:SteamID()), 
        string.format("%s (%s)", target, steamid), 
        swep
    )
end)

util.AddNetworkString("CTG_Characters_PSS_Del")
net.Receive("CTG_Characters_PSS_Del", function(len, ply)
	if not IsValid(ply) or not GTOCharSys.Resources.Access[ply:GetUserGroup()] then
	
	 	print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		print("g_sys_character/lua/characther_system/server/sv_pss.lua LIGNE 217")

		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")
		print("/!\\ ATTENTION /!\\")

		return  
	end


	local steamid = net.ReadString()
	local charId = net.ReadString()
	local swep = net.ReadString()
	CTGPermaSwepSystem:DelSwep(steamid, charId, swep)

	local target = "nil"
	if tonumber(charId) > 0 then
		local char = GTOCharSys:GetCharacterByID(steamid, charId)
		if char then target = char.name end
	else
		local ply = player.GetBySteamID64(steamid)
		if IsValid(ply) then
			target = ply:SteamName()
		else
			target = steamid
		end
		target = target.." (Global)"
	end
	ply:SendLua(string.format([[chat.AddText(Color(255, 150, 40), "[LCS]", Color(0, 150, 0), " Vous avez retiré le swep ", Color(255, 255, 0), "%s", Color(0, 150, 0), " à ", Color(255, 255, 0), "%s", Color(0, 150, 0), " !")]], swep, target))


	-- CTG_BLOGS["Characters"]["admin-pss-del"]:Log("{1} a retiré le SWEP \"\" à {2}", GAS.Logging:FormatPlayer(ply), GAS.Logging:FormatPlayer(target))
	CTG_BLOGS["Characters"]["admin-pss-del"]:Log(string.format("%s (%s) a retiré \"%s\" à %s", ply:Nick(), ply:SteamID(), swep, target))


	discordPSSLog("del", string.format("%s (%s)", ply:Nick(), ply:SteamID()), string.format("%s (%s)", target, steamid), swep)
	-- discordPSSLog("del", ply:Nick(), target, swep)

end)

--[ HOOK ]--

hook.Add("CTG_CHARACTERS_RESPAWN", "CTG_PSS_GiveSweps", function(ply, char)
	if not char then return end
	local content = CTGPermaSwepSystem:GetData(ply:SteamID64())
	ply:StripWeapons()

	local weptbl = ply:getJobTable().weapons
    local weptbl2 = gmod.GetGamemode().Config.DefaultWeapons
    for k,v in pairs(weptbl) do
    	ply:Give(v)
    end
    for k,v in pairs(weptbl2) do
    	ply:Give(v)
    end

	local global = content["global"] or {}
	local other = content[tonumber(char.id)] or {}
	for key, _ in pairs(global) do
		ply:Give(key)
	end
	for key, _ in pairs(other) do
		ply:Give(key)
	end
end)

hook.Add("canDropWeapon", "CTG_PSS_PreventDrops", function(ply, swep)
	if not IsValid(swep) or not swep.GetClass then return true end
	local data = CTGPermaSwepSystem:GetData(ply:SteamID64())
	for k,v in pairs(data) do
		if v[swep:GetClass()] then
			return false
		end
	end
end)

--[ STORAGE ]--

CTGPermaSwepSystem = CTGPermaSwepSystem or {}

function CTGPermaSwepSystem:InitStorage()
	sql.Query([[CREATE TABLE IF NOT EXISTS ctg_permasweps (
		steamid BIGINT(20) PRIMARY KEY,
		content TEXT
	);]])

	-- On vide le cache
	CTGPermaSwepSystem.Cache = {}
end

function CTGPermaSwepSystem:GetData(steamid)
	local content = {}

	if CTGPermaSwepSystem.Cache[steamid] then
		content = CTGPermaSwepSystem.Cache[steamid]
	else
		local rows = sql.Query("SELECT * FROM ctg_permasweps WHERE steamid='"..steamid.."'")

		if rows then
			local json = rows[1]["content"]
			content = util.JSONToTable(json)
		end

		CTGPermaSwepSystem.Cache[steamid] = content
	end

	return content
end

function CTGPermaSwepSystem:SaveData(steamid)
	local content = self:GetData(steamid)
	local json = util.TableToJSON(content)

	local exists = false
	local row = sql.Query("SELECT 1 FROM ctg_permasweps WHERE steamid="..sql.SQLStr(steamid))
	if row then
		exists = true
	end

	if exists then
		if json == "[]" then
			sql.Query("DELETE FROM ctg_permasweps WHERE steamid="..sql.SQLStr(steamid))
		else
			sql.Query("UPDATE ctg_permasweps SET content="..sql.SQLStr(json).." WHERE steamid="..sql.SQLStr(steamid))
		end
	else
		sql.Query("INSERT INTO ctg_permasweps(steamid, content) VALUES("..sql.SQLStr(steamid)..", "..sql.SQLStr(json)..")")
	end

end

function CTGPermaSwepSystem:AddSwep(steamid, charId, swep)
	local content = self:GetData(steamid)
	if tonumber(charId) > 0 then
		content[tonumber(charId)] = content[tonumber(charId)] or {}
		content[tonumber(charId)][swep] = true
	else
		content["global"] = content["global"] or {}
		content["global"][swep] = true
	end

	CTGPermaSwepSystem.Cache[steamid] = content

	local ply = player.GetBySteamID64(steamid)
	if not IsValid(ply) or !ply:IsConnected() then return end
	if tonumber(charId) < 1 or ply:ATG_GetCurrentCharacter().id == charId then
		ply:Give(swep)
	end

	local target = "nil"
	if tonumber(charId) > 0 then
		local char = GTOCharSys:GetCharacterByID(steamid, charId)
		if char then target = char.name end
	else
		target = ply:SteamName().." (Global)"
	end
	ply:SendLua(string.format([[chat.AddText(Color(255, 150, 40), "[LCS]", Color(0, 150, 0), " Vous avez reçu le swep ", Color(255, 255, 0), "%s", Color(0, 150, 0), " sur votre personnage ", Color(255, 255, 0), "%s", Color(0, 150, 0), " !")]], swep, target))
end

function CTGPermaSwepSystem:DelSwep(steamid, charId, swep)
	local content = self:GetData(steamid)
	if tonumber(charId) > 0 then
		content[tonumber(charId)] = content[tonumber(charId)] or {}
		content[tonumber(charId)][swep] = nil
	else
		content["global"] = content["global"] or {}
		content["global"][swep] = nil
	end

	CTGPermaSwepSystem:CleanupTable(content)
	CTGPermaSwepSystem.Cache[steamid] = content

	local ply = player.GetBySteamID64(steamid)
	if not IsValid(ply) or !ply:IsConnected() then return end
	if tonumber(charId) < 1 or ply:ATG_GetCurrentCharacter().id == charId then
		ply:StripWeapon(swep)
	end

	local target = "nil"
	if tonumber(charId) > 0 then
		local char = GTOCharSys:GetCharacterByID(steamid, charId)
		if char then target = char.name end
	else
		target = ply:SteamName().." (Global)"
	end
	ply:SendLua(string.format([[chat.AddText(Color(255, 150, 40), "[LCS]", Color(0, 150, 0), " Vous avez perdu le swep ", Color(255, 255, 0), "%s", Color(0, 150, 0), " sur votre personnage ", Color(255, 255, 0), "%s", Color(0, 150, 0), " !")]], swep, target))
end

function CTGPermaSwepSystem:CleanupTable(tbl)
	for key, _ in pairs(tbl) do
		if type(tbl[key]) == "table" and table.IsEmpty(tbl[key]) then
			tbl[key] = nil
		end
	end
end

function CTGPermaSwepSystem:OpenOffline(ply, steamid)
	local characters = GTOCharSys:GetCharacters(steamid)
	if not characters then return end
	if #characters < 1 then return end

	characters = util.TableToJSON(characters)
	characters = util.Compress(characters)

	net.Start("CTG_Characters_OpenPSS_SelectOffline")
	net.WriteString(steamid)
	net.WriteUInt(#characters, 32)
	net.WriteData(characters, #characters)
	net.Send(ply)
end

CTGPermaSwepSystem:InitStorage()