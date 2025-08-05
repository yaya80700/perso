--[ CTG_Characters_ClothesFrame ]--
local PANEL = {}
PANEL.Elements = PANEL.Elements or {}

local materials = {
	["bg"] = Material("wardrobe/bg.png"),
	["title"] = Material("wardrobe/clothes.png"),
	["frame"] = Material("wardrobe/frame2.png"),
	["infos"] = Material("gui/ctg_characters/titles/clothes_infos.png"),
	["logo"] = Material("materials/icon/nlw.png"),

	["clothes_hairs"] = Material("wardrobe/cheveux.png"),
	["clothes_face"] = Material("wardrobe/visage.png"),
	["clothes_body"] = Material("wardrobe/tenue.png"),

	["red_cross"] = Material("wardrobe/red_cross.png"),
	["red_cross_hover"] = Material("wardrobe/red_cross_hover.png"),

	["ok"] = Material("wardrobe/ok.png"),
	["ok_hover"] = Material("wardrobe/ok_hover.png"),

	["icon_hairs"] = Material("wardrobe/hairs_category.png"),
	["icon_face"] = Material("wardrobe/face_category.png"),
	["icon_body"] = Material("wardrobe/body_category.png"),

	["scroll_bg"] = Material("wardrobe/scroll_bg.png"),
	["scroll"] = Material("wardrobe/scroll.png"),

	["blue2"] = Material("wardrobe/bgtheme.png"),

	["white2"] = Material("wardrobe/white2.png"),
	["white2_hover"] = Material("wardrobe/white2_hover.png"),
	["white2_press"] = Material("wardrobe/white2_press.png"),

	["color_wheel"] = Material("icon16/color_wheel.png"),
}


local function RX(x) return (x * ScrW()) / 1920 end
local function RY(x) return (x * ScrH()) / 1080 end

for i = 1, 100 do 
    surface.CreateFont(("GTO:1CharSys%i"):format(i), {
        font = "Albert Sans",
        extended = false,
        weight = 900,
        size = i,
    })    

    surface.CreateFont(("GTO:2CharSys%i"):format(i), {
        font = "Albert Sans",
        extended = false,
        weight = 400,
        size = i,
    })  
end 


local function FilledCircle(x, y, radius, seg)
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is needed for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end

PANEL.current = nil

PANEL.Available = {}
PANEL.Available.Bodies = {}
PANEL.Available.Hairs = {}
PANEL.Available.Faces = {}

PANEL.Selected = {}
PANEL.Selected.Body = nil
PANEL.Selected.Hairs = nil
PANEL.Selected.Face = nil

function PANEL:Select(new)
	self.current = new
	-- self:UpdateAvailable()
	self:Fields()
	self:ClothesPanel()
end

-- function PANEL:UpdateAvailable()
-- 	-- print(table.ToString(self.Selected, "new", true))	
-- 	local body = ATG_Clothes_GetBody(self.Selected.Body)

-- 	self.Available.Hairs = body.hairs
-- 	-- print(self.Selected.Hairs)
-- 	if self.Selected.Hairs == nil then
-- 		self.Selected.Hairs = self.Available.Hairs[1]
-- 	end
-- 	self.Available.Faces = body.faces
-- 	-- print(self.Selected.Face)
-- 	if self.Selected.Face == nil then
-- 		self.Selected.Face = self.Available.Faces[1]
-- 	end
-- end

function PANEL:SelectClothe(new)
	-- print(table.ToString(self.Selected, "before", true))
	if self.current == "hairs" then
		self.Selected.Hairs = new
	elseif self.current == "face" then
		self.Selected.Face = new
	elseif self.current == "body" then
		self.Selected.Body = new
	end
	-- print(table.ToString(self.Selected, "after", true))	
	-- self:UpdateAvailable()
	self:Fields()
	-- print(table.ToString(self.Selected, "after2", true))
	-- print("------------------")
end

function PANEL:Init()
	self:SetSize(ScrW(), ScrH()) 
	self:SetPos(0, 0)
	self:SetTitle("") 
	self:SetVisible( true ) 
	self:SetDraggable( false ) 
	self:ShowCloseButton( true ) 
	self:SetMouseInputEnabled(true)
	self:SetKeyBoardInputEnabled(true)
	self:SetDeleteOnClose(true)
	-- print(self.HairsColor)

	local ply = LocalPlayer()
	local char = ply:ATG_GetCharacter()
	if not char then
		self:Close()
		chat.AddText(Color(255, 255, 0), "[CTG] ", Color(255, 0, 0), "Vous n'avez aucun personnage de sÃ©lectionnÃ© ! Je ne sais pas comment cela se fait mais merci d'en sÃ©lectionner un en appuyant sur votre touche F6")
		return
	end
	local job = ply:getJobTable().team


	self.HairsColor = Color(char.clothes.hairs_color.r, char.clothes.hairs_color.g, char.clothes.hairs_color.b) 
	self.HeadbandColor = Color(char.clothes.headband_color.r, char.clothes.headband_color.g, char.clothes.headband_color.b)
	self.SkinColor = Color(char.clothes.skin_color.r, char.clothes.skin_color.g, char.clothes.skin_color.b)

	self.Available.Bodies = ATG_Clothes_GetAvailableBodies(char.sex,job)
	self.Available.Hairs = ATG_Clothes_GetAvailableHairs(char.sex, job)
	self.Available.Faces = ATG_Clothes_GetAvailableFaces(char.sex, job)

	-- for k,v in pairs(self.Available) do
	-- 	PrintTable(v)
	-- end

	if #self.Available.Bodies < 1 or #self.Available.Hairs < 1 or #self.Available.Faces < 1 then
		self:Close()
		print(char.sex, job, " / ", #self.Available.Bodies, #self.Available.Hairs, #self.Available.Faces)
		for i=1,5 do
			notification.AddLegacy("Une erreur est survenue. Merci de contacter le staff (Code 1)", NOTIFY_ERROR, 5)
		end
		return
	end
	-- PrintTable(self.Available.Bodies)
	self.Selected.Body = char.clothes.body or self.Available.Bodies[1]
	self.Selected.Hairs = char.clothes.hairs or self.Available.Hairs[1]
	self.Selected.Face = char.clothes.face or self.Available.Faces[1]

	self:Select("body")

	self:CloseButton()

end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(materials["bg"])
	surface.DrawTexturedRect(0, 0, w, h)
	
	surface.SetMaterial(materials["title"])
	surface.DrawTexturedRect(0, 0, RX(689), RY(213))

	surface.SetMaterial(materials["frame"])
	surface.DrawTexturedRect(RX(54), RY(363), RX(812), RY(612))
	surface.DrawTexturedRect(RX(1005), RY(363), RX(812), RY(612))

	surface.SetMaterial(materials["blue2"])
	surface.DrawTexturedRect(RX(333), RY(438), RX(242), RY(54))

	surface.SetMaterial(materials["clothes_"..self.current])
	surface.DrawTexturedRect(RX(333), RY(438), RX(242), RY(54))

	--surface.SetMaterial(materials["infos"])
	--surface.DrawTexturedRect(RX(388), RY(393), RX(1132), RY(26))

	surface.SetMaterial(materials["logo"])
	surface.DrawTexturedRect(ScrW()/2 - RX(128)/2, 0, RX(128), RY(128))
end

function PANEL:CloseButton()
	if self.Elements.CloseButton then self.Elements.CloseButton:Remove() end

	self.Elements.CloseButton = vgui.Create("DButton", self)
	self.Elements.CloseButton:SetSize(RX(64), RY(64))
	self.Elements.CloseButton:SetPos(RX(1846), RY(10))
	self.Elements.CloseButton:SetText("")
	self.Elements.CloseButton.Paint = function(self, w, h)
		local bg = materials["red_cross"]
		if self:IsHovered() then
			bg = materials["red_cross_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.Elements.CloseButton.DoClick = function()
		self:Close()
	end
end

function PANEL:Fields()

	if self.Elements.Preview then self.Elements.Preview:Remove() end
	self.Elements.Preview = vgui.Create("DModelPanel", self)
	self.Elements.Preview:SetSize(RX(559), RY(507))
	self.Elements.Preview:SetPos(RX(1143), RY(446))
	self.Elements.Preview:SetModel(ATG_Clothes_GetBody(self.Selected.Body).model)

	local ent = self.Elements.Preview:GetEntity()
	ent:SetSequence(ent:LookupSequence("idle_DEFAULT"))
	self.Elements.Preview.LayoutEntity = function()
		if ent:GetCycle() == 1 then ent:SetCycle(0) end
		self.Elements.Preview:RunAnimation()
	end

	local hairs = ClientsideModel(ATG_Clothes_GetHairs(self.Selected.Hairs).model)
	hairs:SetNoDraw(true)
	local face = ClientsideModel(ATG_Clothes_GetFace(self.Selected.Face).model)
	face:SetNoDraw(true)

	self.Elements.Preview.PostDrawModel = function()
		hairs:SetPos(ent:GetPos())
		hairs:SetAngles(ent:GetAngles())
		hairs:SetParent(ent)
		hairs:AddEffects(EF_BONEMERGE)
		hairs:DrawModel()

		face:SetPos(ent:GetPos())
		face:SetAngles(ent:GetAngles())
		face:SetParent(ent)
		face:AddEffects(EF_BONEMERGE)
		face:DrawModel()
	end



	for k,v in pairs({ent, hairs, face}) do
		v:SetNWVector("CTG_MatProxies:CTGHairsColor", self.HairsColor:ToVector())
		v:SetNWVector("CTG_MatProxies:CTGHeadbandColor", self.HeadbandColor:ToVector())
		v:SetNWVector("CTG_MatProxies:CTGSkinColor", self.SkinColor:ToVector())
	end


	if self.Elements.HairsButton then self.Elements.HairsButton:Remove() end
	self.Elements.HairsButton = vgui.Create("DButton", self)
	self.Elements.HairsButton:SetSize(RX(64), RY(64))
	self.Elements.HairsButton:SetPos(RX(1477), RY(454))
	self.Elements.HairsButton:SetText("")
	self.Elements.HairsButton.Paint = function(self, w, h)
		local bg = materials["icon_hairs"]
		if self:IsHovered() or self:GetParent().current == "hairs" then
			draw.NoTexture()
			surface.SetDrawColor(255, 255, 255, 255)
			FilledCircle(w/2, h/2, w/2, 25)
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.Elements.HairsButton.DoClick = function()
		self:Select("hairs")
	end

	if self.Elements.FaceButton then self.Elements.FaceButton:Remove() end
	self.Elements.FaceButton = vgui.Create("DButton", self)
	self.Elements.FaceButton:SetSize(RX(64), RY(64))
	self.Elements.FaceButton:SetPos(RX(1328), RY(531))
	self.Elements.FaceButton:SetText("")
	self.Elements.FaceButton.Paint = function(self, w, h)
		local bg = materials["icon_face"]
		if self:IsHovered() or self:GetParent().current == "face" then
			draw.NoTexture()
			surface.SetDrawColor(255, 255, 255, 255)
			FilledCircle(w/2, h/2, w/2, 25)
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.Elements.FaceButton.DoClick = function()
		self:Select("face")
	end

	if self.Elements.BodyButton then self.Elements.BodyButton:Remove() end
	self.Elements.BodyButton = vgui.Create("DButton", self)
	self.Elements.BodyButton:SetSize(RX(64), RY(64))
	self.Elements.BodyButton:SetPos(RX(1300), RY(610))
	self.Elements.BodyButton:SetText("")
	self.Elements.BodyButton.Paint = function(self, w, h)
		local bg = materials["icon_body"]
		if self:IsHovered() or self:GetParent().current == "body" then
			draw.NoTexture()
			surface.SetDrawColor(255, 255, 255, 255)
			FilledCircle(w/2, h/2, w/2, 25)
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.Elements.BodyButton.DoClick = function()
		self:Select("body")
	end

	if self.Elements.AcceptButton then self.Elements.AcceptButton:Remove() end
	self.Elements.AcceptButton = vgui.Create("DButton", self)
	self.Elements.AcceptButton:SetSize(RX(77), RY(77))
	self.Elements.AcceptButton:SetPos(RX(1843), RY(1003))
	self.Elements.AcceptButton:SetText("")
	self.Elements.AcceptButton.Paint = function(self, w, h)
		local bg = materials["ok"]
		if self:IsHovered() then
			bg = materials["ok_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	self.Elements.AcceptButton.DoClick = function()
		local clothes = {
			body = self.Selected.Body,
			hairs = self.Selected.Hairs,
			hairs_color = string.format("%d;%d;%d", self.HairsColor.r, self.HairsColor.g, self.HairsColor.b),
			headband_color = string.format("%d;%d;%d", self.HeadbandColor.r, self.HeadbandColor.g, self.HeadbandColor.b),
			skin_color = string.format("%d;%d;%d", self.SkinColor.r, self.SkinColor.g, self.SkinColor.b),
			face = self.Selected.Face,
		}
		self:Close()

		local json = util.TableToJSON(clothes)
		local data = util.Compress(json)
		net.Start("CTG_Characters_ChangeClothes")
		net.WriteUInt(#data, 32)
		net.WriteData(data, #data)
		net.SendToServer()
	end

end

function PANEL:ClothesPanel()
	if self.Elements.ClothesPanel then self.Elements.ClothesPanel:Remove() end
	
	self.Elements.ClothesPanel = vgui.Create("DScrollPanel", self)
	self.Elements.ClothesPanel:SetPos(RX(93), RY(500))
	self.Elements.ClothesPanel:SetSize(RX(736), RY(450))

	local scrollBar = self.Elements.ClothesPanel:GetVBar()
	scrollBar.Paint = function(self, w, h)
		local bg = materials["scroll_bg"]
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	scrollBar.btnUp.Paint = function(self, w, h)
	end
	scrollBar.btnDown.Paint = function(self, w, h)
	end
	scrollBar.btnGrip.Paint = function(self, w, h)
		local bg = materials["scroll"]
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end

	local toScroll = false
	local clothes = {}
	if self.current == "body" then
		clothes = self.Available.Bodies
	elseif self.current == "hairs" then
		clothes = self.Available.Hairs
	elseif self.current == "face" then
		clothes = self.Available.Faces
	end

	for key, value in SortedPairs(clothes) do
		local button = self.Elements.ClothesPanel:Add( "DButton" )
		local name = "<Sans nom>"

		if self.current == "body" then
			name = ATG_Clothes_GetBody(value).name
		elseif self.current == "hairs" then
			name = ATG_Clothes_GetHairs(value).name
		elseif self.current == "face" then
			name = ATG_Clothes_GetFace(value).name
		end

		button:SetText(name)
		button:SetFont("GTO:1CharSys30")
		button:SetSize(RX(670), RY(60))
		button:Dock( TOP )
		button:DockMargin( 0, 0, 0, 5 )
		button.Paint = function(btn, w, h)
			local bg = materials["white2"]
			if btn:IsHovered() or self.Selected.Body == value or self.Selected.Hairs == value or self.Selected.Face == value then
				bg = materials["white2_hover"]
			end
			if btn:IsDown() then
				bg = materials["white2_press"]
			end
			surface.SetMaterial(bg)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(0, 0, w, h)
		end
		button.DoClick = function()
			self:SelectClothe(value)
		end
	end

	if self.Elements.HairColorButton then self.Elements.HairColorButton:Remove() end
	
	local parent = self
	self.Elements.ColorButton = vgui.Create("DButton", self)
	self.Elements.ColorButton:SetPos(RX(585), RY(444))
	self.Elements.ColorButton:SetSize(RX(48), RY(48))
	self.Elements.ColorButton:SetText("")
	self.Elements.ColorButton.Paint = function(self, w, h)
		surface.SetMaterial(materials["color_wheel"])
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)

		if self:IsHovered() then
			draw.RoundedBox(w/2, 0, 0, w, h, Color(255, 255, 255, 50))
		end
	end

	self.Elements.ColorButton.DoClick = function()
		local word = {
			["body"] = "Peau",
			["hairs"] = "Cheveux",
			["face"] = "Bandeau"
		}

		local colors = {
			["body"] = {
				Color(255, 218, 185),
				Color(233, 176, 165),
				Color(180, 120, 110),
				Color(154, 119, 89),
				Color(134, 101, 84),
				Color(93, 70, 60),
			},
			["face"] = {
				Color(10, 60, 130),
				Color(150, 70, 90),
				Color(230, 220, 190),
				Color(70, 70, 70),
				Color(110, 130, 60),
				Color(190, 80, 50),
			},
		}

		local Frame = vgui.Create("DFrame", self)
		Frame:SetSize(RX(500), RY(colors[self.current] and 300 or 500))
		Frame:Center()
		Frame:SetTitle("Choix de couleur: "..word[self.current])
		Frame:MakePopup()
		function Frame:Paint(w, h)
			surface.SetDrawColor(70, 70, 70)
			surface.DrawRect(0, 0, w, h)

			surface.SetDrawColor(16, 16, 16)
			surface.DrawRect(0, 0, w, 25)
		end
		
		if colors[self.current] then
			local currentColor
			if self.current == "body" then currentColor = self.SkinColor end
			if self.current == "face" then currentColor = self.HeadbandColor end

			for i=1,#colors[self.current] do
				local color = colors[self.current][i]

				local euclidean = (i - i%4)/4
				local btn = vgui.Create("DButton", Frame)
				btn:SetText("")
				btn:SetSize(RX(130), RY(50))
				btn:SetPos(RX(40) + RX(150)*(i%4 - 1 + euclidean), RY(90)*(euclidean + 1))
				function btn:Paint(w, h)
					draw.RoundedBox(5, 0, 0, w, h, currentColor == color and Color(0, 190, 0) or Color(0, 0, 0))
					draw.RoundedBox(5, 10, 10, w - 20, h - 20, color)
				end
				btn.DoClick = function()
					if self.current == "body" then
						self.SkinColor = color
					elseif self.current == "face" then
						self.HeadbandColor = color
					end
					currentColor = color
					self:Fields()
				end
			end
		else
			local colorPicker = vgui.Create("DColorMixer", Frame)
			colorPicker:Dock(FILL)					-- Make Mixer fill place of Frame
			colorPicker:SetPalette(true)  			-- Show/hide the palette 				DEF:true
			colorPicker:SetAlphaBar(false) 			-- Show/hide the alpha bar 				DEF:true
			colorPicker:SetWangs(true) 				-- Show/hide the R G B A indicators 	DEF:true
			colorPicker:SetColor(parent.HairsColor)
			function colorPicker:ValueChanged(newColor)
				parent.HairsColor = Color(newColor.r, newColor.g, newColor.b, 255)
				parent:Fields()
			end
		end
	end

end

vgui.Register("CTG_Characters_Wardrobe", PANEL, "DFrame")
PANEL = nil

print("[CTG] cl_wardrobe.lua loaded")