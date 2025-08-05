hook.Add("OnPlayerChat", "CTG_PSS_COMMAND", function(ply, msg)
	if ply ~= LocalPlayer() then return end
	local cmd = string.lower(msg)
	if cmd == "!pss" then
		RunConsoleCommand("ctg_pss")
	end
end)

concommand.Add("izg_pss", function(ply)
    if IsValid(ply) and ply == LocalPlayer() and ply:IsSuperAdmin() then
        net.Start("CTG_Characters_OpenPSS_Select")
        net.SendToServer()
    else
        chat.AddText(Color(255, 150, 40), "[IZG]", Color(255, 0, 0), " Vous n'avez pas la permission de faire cette commande !")
    end
end)

net.Receive("CTG_Characters_OpenPSS_Select", function()
	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local cache = util.JSONToTable(json)

	local newCache = {}
	for key, value in pairs(cache) do
		local steamid = ""
		if string.len(key) < 18 then
			steamid = "90071996842377216"
		else
			steamid = util.SteamIDTo64(key)
		end
		newCache[steamid] = value
	end
	CTG_PSS_Cache = newCache
	
	CTG_Characters_OpenFrame("CTG_Characters_PSS_Select")
end)

net.Receive("CTG_Characters_OpenPSS_SelectOffline", function()
	local steamid = net.ReadString()

	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local characters = util.JSONToTable(json)

	CTG_PSS_OfflineCharacters = characters
	CTG_PSS_ARGS = {
		steamid
	}
	
	CTG_Characters_OpenFrame("CTG_Characters_PSS_Offline_CHARACTERS")
end)

net.Receive("CTG_Characters_OpenPSS", function()
	local isGlobal = net.ReadBool()
	local steamid = net.ReadString()

	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local sweps = util.JSONToTable(json)
	if not sweps then return end

	if !isGlobal then
		local len = net.ReadUInt(32)
		local data = net.ReadData(len)
		local json = util.Decompress(data)
		local char = util.JSONToTable(json)
		if not char then return end

		CTG_PSS_ARGS = {
			steamid, -- steamid
			char.id, -- charId,
			sweps, -- sweps table
			char, -- char table
		}
	else
		CTG_PSS_ARGS = {
			steamid, -- steamid
			0, -- charId,
			sweps, -- sweps table
		}
	end
	
	CTG_Characters_OpenFrame("CTG_Characters_PSS")
end)