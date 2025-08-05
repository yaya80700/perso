--
local tNets = {
    "GTO:OpenCharFrame",
    "GTO:CreateCharacter",
	"ATG_Characters_Characters_CreateCharacter",
    "GTOCharSys_SendCharacters",
    "GTOCharSys_CharacterSelected",
	"CTG_Characters_UpdateSubModels",
	"CTG_Characters_Characters_RequestCharacters",
	"CTG_Characters_Characters_SelectCharacter",
	"CTG_Characters_Identity_Rename",
	"GTOCharSys:DeleteCharacter"
}

for _, sNets in pairs(tNets) do
    util.AddNetworkString(sNets) 
end 


net.Receive("CTG_Characters_Characters_RequestCharacters", function(len, ply)
	ply:CTG_UpdateCharacters()
end)

function GTOCharSys:SendCharactersToClient(pPlayer)
    if not IsValid(pPlayer) then return end
    
    local characters = self:GetCharactersBySteamID(pPlayer:SteamID64())
    net.Start("GTOCharSys_SendCharacters")
        net.WriteTable(characters or {})
    net.Send(pPlayer)
end



hook.Add("PlayerButtonDown", "GTO:OpenCharFrameOnF6", function(pPlayer, button)
    if button == KEY_F8 then
        GTOCharSys:SendCharactersToClient(pPlayer)
        net.Start("GTO:OpenCharFrame")
        net.Send(pPlayer)
    end
end)



net.Receive("ATG_Characters_Characters_CreateCharacter", function(len, ply)    
	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local char = util.JSONToTable(json)

	local count = GTOCharSys:GetCharactersCount(ply:SteamID64())
	if count > 3 then
		print("Too many characters for: "..ply:Nick().." ("..ply:SteamID64()..")")
		return
	end

	local hairsColor = string.Split(char.clothes.hairs_color, ";")
	local headbandColor = string.Split(char.clothes.headband_color, ";")
	local skinColor = string.Split(char.clothes.skin_color, ";")
	char.clothes.hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3])
	char.clothes.headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3])
	char.clothes.skin_color = Color(skinColor[1], skinColor[2], skinColor[3])

    GTOCharSys:CreateCharacter(ply:SteamID64(), char)

	ply:CTG_UpdateCharacters()

	CTG_BLOGS["Characters"]["create"]:Log(string.format("%s (%s) a créé un nouveau perso: %s", ply:SteamName(), ply:SteamID(), ply:Nick()))
end)


net.Receive("GTO:OpenCharFrame", function(_, pPlayer)
	GTOCharSys:SendCharactersToClient(pPlayer)
    net.Start("GTO:OpenCharFrame")
    net.Send(pPlayer)
end)

util.AddNetworkString("CTG_Characters_Characters_SelectCharacter")
net.Receive("CTG_Characters_Characters_SelectCharacter", function(len, ply)
	local id = net.ReadInt(32)
	ply:GTO_SelectCharacter(tostring(id))
end)



hook.Add("CanChangeRPName", "CTG_DisableRPName", function(ply, name)
    return false, "La commande est désactivée, si vous souhaitez changer de nom merci de faire un ticket !"
end)


hook.Add("PlayerInitialSpawn", "ATG_SaveIinit", function(ply, transition)

    if IsValid(ply) and ply:IsConnected() and !transition then
        local id = "ATG_SaveCharacters_"..ply:SteamID64()
        timer.Create(id, 10, 0, function()
            if IsValid(ply) and ply:IsConnected() then
				GTOCharSys:SaveCharacter(ply:SteamID64())
            else
                timer.Remove(id)
            end
        end)
    end

end)

hook.Add("PlayerDisconnected", "Atg_SaveRemove", function(ply)
    if IsValid(ply) and !ply:IsConnected() then
        timer.Remove("ATG_SaveCharacters_"..ply:SteamID64())
        GTOCharSys:SaveCharacter(ply:SteamID64())
    end
end)

hook.Add("playerWalletChanged", "ATG_WalletUpdate", function(ply, amount, wallet)
	local char = ply:ATG_GetCurrentCharacter()
	if not char then return end
	local total = wallet + amount
	char.money = tonumber(total)
end)

hook.Add("OnPlayerChangedTeam", "ATG_SaveJob", function(ply, before, after)

	local teambl = { TEAM_SPAWN }
	if table.HasValue(teambl, after) then return end

	local char = ply:ATG_GetCurrentCharacter()
	if not char then return end

	char.job = RPExtraTeams[after].command

end)



hook.Add("PlayerLoadout", "CTG_Characters_HandleLoadout", function(ply)

	local char = GTOCharSys:GetCharacterByID(ply:SteamID64(), ply.SelectedCharacter)
	
	if not char then
		ply:SendLua([[timer.Simple(0, function()
			if not LocalPlayer().ATG_RequestCharacters then return end
			LocalPlayer():ATG_RequestCharacters()
		end)]])
		return
	end

	ply:ATG_UpdateClothe(ply, char)

	hook.Run("CTG_CHARACTERS_RESPAWN", ply, char)

	timer.Simple(1, function()
		ply:SendLua("CTG_UpdateOtherClothes()")
	end)

end)



local PlayerMeta = FindMetaTable("Player")
function PlayerMeta:CTG_SetEyes(texture)
	self:SetNWString("CTG_MatProxies:CTGDojutsu", texture or "eyes")
end


function PlayerMeta:ApplyColors(ent)
	local char = self:ATG_GetCurrentCharacter()
	ent:SetNWVector("CTG_MatProxies:CTGHairsColor", char.clothes.hairs_color:ToVector())
	ent:SetNWVector("CTG_MatProxies:CTGHeadbandColor", char.clothes.headband_color:ToVector())
	ent:SetNWVector("CTG_MatProxies:CTGSkinColor", char.clothes.skin_color:ToVector())
end

function PlayerMeta:ATG_GetCurrentCharacter()
	if not tonumber(self.SelectedCharacter) or tonumber(self.SelectedCharacter) < 1 then return { id = 0 } end
	return GTOCharSys:GetCharacterByID(self:SteamID64(), self.SelectedCharacter)
end

function PlayerMeta:CTG_UpdateCharacters()
	-- debug.Trace()
	local characters = GTOCharSys:GetCharacters(self:SteamID64())
	characters = table.Copy(characters)

	for i=1,#characters do
		local char = characters[i]
		char.clothes.hairs_color = string.format("%d;%d;%d", char.clothes.hairs_color.r, char.clothes.hairs_color.g, char.clothes.hairs_color.b)
		char.clothes.headband_color = string.format("%d;%d;%d", char.clothes.headband_color.r, char.clothes.headband_color.g, char.clothes.headband_color.b)
		char.clothes.skin_color = string.format("%d;%d;%d", char.clothes.skin_color.r, char.clothes.skin_color.g, char.clothes.skin_color.b)
	end

	characters = util.TableToJSON(characters)
	characters = util.Compress(characters)

	net.Start("CTG_Characters_Characters_RequestCharacters")
	net.WriteUInt(#characters, 32)
	net.WriteData(characters, #characters)
	net.Send(self)
end


function PlayerMeta:GTO_SelectCharacter(iID)
    if not iID then return end
    local tCharacter = GTOCharSys:GetCharacterByID(self:SteamID64(), iID)
    if not tCharacter then 
		self.SelectedCharacter = 0
		
		net.Start("GTOCharSys_CharacterSelected")
        net.WriteInt(0, 32)
		net.Send(self)
		self:Spawn()
		self:changeTeam(tonumber(TEAM_SPAWN), true, true, true)
        return 
    end
	GTOCharSys:SaveCharacter(self:SteamID64())
	self.SelectedCharacter = iID

    self:setDarkRPVar("rpname", tCharacter.name)

    self:setDarkRPVar("money", tonumber(tCharacter.money) or 0)

    local jobTable, jobId = DarkRP.getJobByCommand(tCharacter.job)
    self:changeTeam(tonumber(jobId), true, true, true)

    self:Spawn()

    hook.Run("CTG_CHARACTERS_SELECT", self, char, old)

    net.Start("GTOCharSys_CharacterSelected")
    net.WriteInt(iID, 32)
    net.Send(self)
end

function PlayerMeta:ATG_UpdateClothe()
	if not IsValid(self) then
		print("----")
		print("[YOLTIX DEBUG] metaPly:ATG_UpdateClothe: le self est nul")
		print(self)
		print("----")
	end
	local source = self
	local char = source:ATG_GetCurrentCharacter()
	timer.Simple(0.01, function()
		if not IsValid(source) and not IsValid(self) then return end

		local job = (IsValid(source) and source or self):getJobTable().team
		local body = ATG_Clothes_GetBody(char.clothes.body)
		if not ATG_Clothes_CanWear(body, char.sex, job) then
			print(char.sex, job)
			local bodies = ATG_Clothes_GetAvailableBodies(char.sex, job)
			if bodies then
				body = bodies[1]
				body = ATG_Clothes_GetBody(body)
			else
				body = false
			end
		end

		if body then
			local hairs = ATG_Clothes_GetHairs(char.clothes.hairs)
			if not ATG_Clothes_CanWear(hairs, char.sex, job) then
				local parts = ATG_Clothes_GetAvailableHairs(char.sex, job)
				if parts then
					hairs = parts[1]
					hairs = ATG_Clothes_GetHairs(hairs)
				else
					hairs = false
				end
			end
			local face = ATG_Clothes_GetFace(char.clothes.face)
			if not ATG_Clothes_CanWear(face, char.sex, job) then
				local parts = ATG_Clothes_GetAvailableFaces(char.sex, job)
				if parts then
					face = parts[1]
					face = ATG_Clothes_GetFace(face)
				else
					face = false
				end
			end

			if not hairs or not face then
				print("--------------------------------------")
				print("not hairs or not face")
				print(hairs)
				print(face)
				print(self)
				PrintTable(char)
				print("--------------------------------------")
				net.Start("CTG_Characters_UpdateSubModels")
					net.WriteEntity(self)
					-- net.WriteString(nil)
					-- net.WriteString(nil)
					-- net.WriteString(nil)
				net.Broadcast()
				return
			end
			
			self:SetModel(body.model)
			
			net.Start("CTG_Characters_UpdateSubModels")
				net.WriteEntity(self)
				net.WriteString(hairs.model)
				net.WriteString(face.model)
				net.WriteString(char.village)
			net.Broadcast()
			self:SetNWString("CTG_Characters:SubModels:Hairs", hairs.model)
			self:SetNWString("CTG_Characters:SubModels:Face", face.model)
			self:SetNWString("CTG_Characters:SubModels:Headband", char.village)

			self:SetNWVector("CTG_MatProxies:CTGHairsColor", char.clothes.hairs_color:ToVector())
			self:SetNWVector("CTG_MatProxies:CTGHeadbandColor", char.clothes.headband_color:ToVector())
			self:SetNWVector("CTG_MatProxies:CTGSkinColor", char.clothes.skin_color:ToVector())
		else
			print("no body for: ")
			print(self)
			debug.Trace()
		end
	end)
end



util.AddNetworkString("CTG_Characters_Identity_Rename")
net.Receive("CTG_Characters_Identity_Rename", function(len, ply)
	local name = net.ReadString()
	if ply:getDarkRPVar("money") < 0 then return end
	local isNearNPC = false
	local around = ents.FindInSphere(ply:GetPos(), 100)
	for i=1,#around do
		local ent = around[i]
		if ent.ClassName == "ctg_identity" then
			isNearNPC = true
			break
		end
	end
	if !isNearNPC then return end

	local char = ply:ATG_GetCurrentCharacter()
	char.name = name
	GTOCharSys:SaveCharacter(ply:SteamID64())
    ply:setDarkRPVar("rpname", name)
    ply:addMoney(-0)


	CTG_BLOGS["Characters"]["edit"]:Log(string.format("%s (%s [%s]) a changé de Nom RP: %s", previousName, ply:SteamName(), ply:SteamID64(), ply:Nick()))
end)


util.AddNetworkString("CTG_Characters_ChangeClothes")
net.Receive("CTG_Characters_ChangeClothes", function(len, ply)
	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local clothes = util.JSONToTable(json)

	local char = ply:ATG_GetCurrentCharacter()	
	char.clothes = clothes

	local hairsColor = string.Split(char.clothes.hairs_color, ";")
	local headbandColor = string.Split(char.clothes.headband_color, ";")
	local skinColor = string.Split(char.clothes.skin_color, ";")
	char.clothes.hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3])
	char.clothes.headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3])
	char.clothes.skin_color = Color(skinColor[1], skinColor[2], skinColor[3])

	GTOCharSys:UpdateClothes(ply:SteamID64(), char.id, clothes)
	ply:CTG_UpdateCharacters()
	timer.Simple(0.1, function()
		ply:ATG_UpdateClothe()
	end)
end)


net.Receive("GTOCharSys:DeleteCharacter", function(len, ply)
	local id = net.ReadInt(32)
	local char = ply:ATG_GetCurrentCharacter()
	if char and tonumber(char.id) == id then
		ply:GTO_SelectCharacter(0)
	end

	GTOCharSys:DeleteCharacter(ply:SteamID64(), tostring(id))

    ply:CTG_UpdateCharacters()

	CTG_BLOGS["Characters"]["del"]:Log(string.format("%s (%s) a supprimé son perso: %s", ply:SteamName(), ply:SteamID(), ply:Nick()))
end)
