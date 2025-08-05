local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:ATG_RequestCharacters()
	net.Start("CTG_Characters_Characters_RequestCharacters")
	net.SendToServer()
end

function PlayerMeta:SelectCharacter(id)
	if self:ATG_GetCurrentCharacterID() == tonumber(id) then
		chat.AddText(Color(255, 255, 0), "[IZG] ", Color(255, 0, 0), "Vous jouez déjà avec le personnage que vous tentez de sélectionner !")
		return
	end
	net.Start("CTG_Characters_Characters_SelectCharacter")
	net.WriteInt(id, 32)
	net.SendToServer()
end

function PlayerMeta:ATG_CreateNewCharacter()
	local char = self.NewCharacter

	local data = util.TableToJSON(char)
	data = util.Compress(data)

	net.Start("ATG_Characters_Characters_CreateCharacter")
	net.WriteUInt(#data, 32)
	net.WriteData(data, #data)
	net.SendToServer()

	self.NewCharacter = nil
end

function PlayerMeta:ATG_GetCurrentCharacterID()
	if not self.SelectedCharacter or self.SelectedCharacter < 1 then return 0 end
	return self.SelectedCharacter
end

function PlayerMeta:ATG_GetCurrentCharacter()
	if not self.SelectedCharacter or self.SelectedCharacter < 1 then return { id = 0 } end
	return self.CharactersData[self.SelectedCharacter]
end

function PlayerMeta:ATG_GetCharacter()
	if not self.CharactersData then return false end
	for key, value in pairs(self.CharactersData) do
		if value.id == tostring(self:ATG_GetCurrentCharacterID()) then return value end
	end
	return false
end

function PlayerMeta:ATG_SaveCharacter()
	net.Start("CTG_Characters_SaveCharacter")
	net.SendToServer()
end

function PlayerMeta:AddSubModel(mdl)
	if not IsValid(self) then 
		print("[AddSubModel] self Invalid")
		return
	end
	self.SubModels = self.SubModels or {}

	local ent = ClientsideModel(mdl)
	if not ent then
		print("[AddSubModel] ent = nil")
		print(self)
		print(mdl)
		print("-----------")
		return
	end
	ent:SetNoDraw(true)

	self.SubModels[mdl] = ent
	return ent
end


function PlayerMeta:RemoveSubModel(mdl)
	if not self.SubModels then return end
	local ent = self.SubModels[mdl]
	if not ent then return end

	ent:Remove()
	self.SubModels[mdl] = nil
end

function PlayerMeta:GetSubModels()
	return self.SubModels or {}
end

function PlayerMeta:ClearSubModels()
	for _,ent in pairs(self:GetSubModels()) do
		ent:Remove()
	end
	self.SubModels = {}
end

function PlayerMeta:UpdateRenderOverride()
	self.RenderOverride = function(self, flags)
		self:DrawModel(flags)

		if table.Count(self:GetSubModels()) < 1 then return end
		for _,ent in pairs(self:GetSubModels()) do
			local parent = IsValid(self:GetRagdollEntity()) and self:GetRagdollEntity() or self
			ent:SetPos(parent:GetPos())
			ent:SetAngles(parent:GetAngles())
			ent:SetParent(parent)
			ent:AddEffects(EF_BONEMERGE)
			ent:SetupBones()
			ent:DrawModel(flags)
		end
	end
end


net.Receive("GTOCharSys_CharacterSelected", function()
	local id = net.ReadInt(32)
	LocalPlayer().SelectedCharacter = id
end)

net.Receive("CTG_Characters_UpdateSubModels", function()
	local target = net.ReadEntity()
	local hairs = net.ReadString()
	local face = net.ReadString()
	local village = net.ReadString()
	
	CTG_UpdateClothes(target, hairs, face, village)
end)


function CTG_UpdateClothes(target, hairs, face, village)
	if !IsValid(target) then return end
	target:ClearSubModels()
	--print(target)
	if not hairs or not face then
		print("not hairs or not face for: ")
		print(target)
		return
	end
	local hairsEnt = target:AddSubModel(hairs)
	local faceEnt = target:AddSubModel(face)

	local function applyMat(ent, village)
		if not IsValid(ent) then return end
		local materials = ent:GetMaterials()
		for k,v in pairs(materials) do
			if string.find(v, "headband_symbol") or v == "___error" then
				ent:SetSubMaterial(tonumber(k) - 1, "models/skylyxx/ctg/characters/headband/"..village)
				break
			end
		end
	end

	timer.Simple(0.1, function()
		for k,ent in pairs(target.SubModels or {}) do
			if not IsValid(ent) then
				print("[SKYLYXX DEBUG] Character System, materials-ent null: "..k)
				print(k, ent)
				debug.Trace()
				continue
			end
			applyMat(ent, village)
		end
		applyMat(target, village)

		target:UpdateRenderOverride()
	end)
end

function CTG_UpdateOtherClothes()
	for k,target in pairs(player.GetAll()) do
		if target == LocalPlayer() then continue end
		
		local hairs = target:GetNWString("CTG_Characters:SubModels:Hairs", "models/skylyxx/ctg/characters/man/hairs/hairs_man_03.mdl")
		local face = target:GetNWString("CTG_Characters:SubModels:Face", "models/skylyxx/ctg/characters/man/faces/face_genin.mdl")
		local village = target:GetNWString("CTG_Characters:SubModels:Headband")
		
		CTG_UpdateClothes(target, hairs, face, village)
	end
end

net.Receive("CTG_Characters_Characters_RequestCharacters", function()
	local len = net.ReadUInt(32)
	local data = net.ReadData(len)
	local json = util.Decompress(data)
	local charsData = util.JSONToTable(json)

	for i=1,#charsData do
		local char = charsData[i]

		local hairsColor = string.Split(char.clothes.hairs_color, ";")
		char.clothes.hairs_color = Color(hairsColor[1], hairsColor[2], hairsColor[3])

		local headbandColor = string.Split(char.clothes.headband_color, ";")
		char.clothes.headband_color = Color(headbandColor[1], headbandColor[2], headbandColor[3])

		local skinColor = string.Split(char.clothes.skin_color, ";")
		char.clothes.skin_color = Color(skinColor[1], skinColor[2], skinColor[3])
	end

	LocalPlayer().CharactersData = charsData


	if LocalPlayer():ATG_GetCurrentCharacterID() < 1 then
		net.Start("GTO:OpenCharFrame")
        net.SendToServer()
	end

end)



hook.Add("InitPostEntity", "ATG_HOOK_FirstCharactersFetch", function()
	LocalPlayer():ATG_RequestCharacters()
end)

function CTG_Characters_OpenFrame(frame)
	if ValidPanel(LocalPlayer().CTG_Frame) then LocalPlayer().CTG_Frame:Close() end
	print(frame)
	LocalPlayer().CTG_Frame = vgui.Create(frame)
	LocalPlayer().CTG_Frame:MakePopup()
end
