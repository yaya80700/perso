--

local tCharactersCache = {}

net.Receive("GTOCharSys_SendCharacters", function()
    tCharactersCache = net.ReadTable()
end)

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

    surface.CreateFont(("GTO:3CharSys%i"):format(i), {
        font = "Albert Sans",
        extended = false,
        weight = 500,
        size = i,
    })  

end 

Available_Bodies = ATG_Clothes_GetAvailableBodies("man",TEAM_KONO_ELEVE)
Available_Hairs = ATG_Clothes_GetAvailableHairs("man", TEAM_KONO_ELEVE)
Available_Faces = ATG_Clothes_GetAvailableFaces("man", TEAM_KONO_ELEVE)

if #Available_Bodies < 1 or #Available_Hairs < 1 or #Available_Faces < 1 then
    for i=1,5 do
        notification.AddLegacy("Une erreur est survenue. Merci de contacter le staff (Code 1)", NOTIFY_ERROR, 5)
    end
    return
end

SelectedBody = "man_kakashi_gaiden"
SelectedHairs = "hairs_iruka"
SelectedFace = "face_genin"

local job = nil 
local sSexe = "man"
local sName = ""
local sVillage = "   Konoha"

local konoman = "man_kakashi_gaiden"
local konowoman = "man_kakashi_gaiden_woman"

local kiriman = "man_kakashi_gaiden"
local kiriwoman = "man_kakashi_gaiden_woman"

local hairman = "hairs_iruka"
local hairwoman = "hairs_tenten-og"

local HairsColor = Color(72, 72, 72)
local HeadbandColor = Color(10, 60, 190)
local SkinColor = Color(255, 218, 185)

local function fcCreateCharacter(openbody)

    local vguiFrame = vgui.Create("DFrame")

    function UpdateCaracther(sex, job, selectbody, selecthair, openbody)

        Available_Bodies = ATG_Clothes_GetAvailableBodies(sex,job)
        Available_Hairs = ATG_Clothes_GetAvailableHairs(sex, job)
        Available_Faces = ATG_Clothes_GetAvailableFaces(sex, job)
        
        if #Available_Bodies < 1 or #Available_Hairs < 1 or #Available_Faces < 1 then
            vguiFrame:Close()
            for i=1,5 do
                notification.AddLegacy("Une erreur est survenue. Merci de contacter le staff (Code 1)", NOTIFY_ERROR, 5)
            end
            return
        end

        SelectedBody = selectbody
        SelectedHairs = selecthair
        SelectedFace = "face_genin"

        vguiFrame:Close()
        if openbody then
            fcCreateCharacter(true )
        else 
            fcCreateCharacter()
        end
    end


    local pPlayer = LocalPlayer()
    local eSelected = NULL

    vguiFrame:SetSize(ScrW(), ScrH()) 
    vguiFrame:SetPos(0, 0)
    vguiFrame:SetTitle("")
	vguiFrame:SetVisible( true ) 
	vguiFrame:SetDraggable( false ) 
	vguiFrame:ShowCloseButton( true  ) 
    vguiFrame:MakePopup()
    vguiFrame.Paint = function(self, w, h)
        surface.SetDrawColor(color_white) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.BackgroundCreation) 
	    surface.DrawTexturedRect(0, 0, w, h) 

        surface.SetDrawColor(Color(255, 255, 255, 50)) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.Effect) 
	    surface.DrawTexturedRect(0, 0, w, h) 

        surface.SetDrawColor(color_white) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.Cloud) 
	    surface.DrawTexturedRect(0, 0, w, h) 

        draw.SimpleText("CRÉER VOTRE PERSONNAGE", "GTO:1CharSys58", RX(50), RY(40), color_white)
        draw.SimpleText("Créez votre personnage et devenez unique !", "GTO:2CharSys33", RX(50), RY(87.43), Color(190, 190, 190))
    end

    local vguiModelPlayer = vgui.Create("DModelPanel", vguiFrame)
    vguiModelPlayer:SetSize(RX(1000), RY(1000))
    vguiModelPlayer:SetPos(RX(0), RY(100))
    vguiModelPlayer:SetModel(ATG_Clothes_GetBody(SelectedBody).model)
    
    local ent = vguiModelPlayer:GetEntity()
    ent:SetSequence(ent:LookupSequence("pose_minato"))
    ent:SetAngles(Angle(0, 80, 0))
    
    local isRotating = false
    local lastX = 0
    
    vguiModelPlayer.OnMousePressed = function(self, mouseCode)
        if mouseCode == MOUSE_LEFT then
            isRotating = true
            lastX = gui.MouseX()
        end
    end
    
    vguiModelPlayer.OnMouseReleased = function(self, mouseCode)
        if mouseCode == MOUSE_LEFT then
            isRotating = false
        end
    end
    
    vguiModelPlayer.OnCursorMoved = function(self, x, y)
        if isRotating then
            local currentX = gui.MouseX()
            local diff = currentX - lastX
            ent:SetAngles(Angle(0, ent:GetAngles().y + diff, 0))
            lastX = currentX
        end
    end
    
    vguiModelPlayer.LayoutEntity = function()
        if ent:GetCycle() == 1 then ent:SetCycle(0) end
        vguiModelPlayer:RunAnimation()
    end

        
	local hairs = ClientsideModel(ATG_Clothes_GetHairs(SelectedHairs).model)
	hairs:SetNoDraw(true)
	local face = ClientsideModel(ATG_Clothes_GetFace(SelectedFace).model)
	face:SetNoDraw(true)

    
	vguiModelPlayer.PostDrawModel = function()
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
		v:SetNWVector("CTG_MatProxies:CTGHairsColor", HairsColor:ToVector())
		v:SetNWVector("CTG_MatProxies:CTGHeadbandColor", HeadbandColor:ToVector())
		v:SetNWVector("CTG_MatProxies:CTGSkinColor", SkinColor:ToVector())
	end

    function UpdateClothe()
        ent:SetModel(ATG_Clothes_GetBody(SelectedBody).model)
        hairs:SetModel(ATG_Clothes_GetHairs(SelectedHairs).model)
        face:SetModel(ATG_Clothes_GetFace(SelectedFace).model)

        ent:SetSequence(ent:LookupSequence("pose_minato"))
        ent:SetAngles(Angle(0, 80, 0))


        for k,v in pairs({ent, hairs, face}) do
            v:SetNWVector("CTG_MatProxies:CTGHairsColor", HairsColor:ToVector())
            v:SetNWVector("CTG_MatProxies:CTGHeadbandColor", HeadbandColor:ToVector())
            v:SetNWVector("CTG_MatProxies:CTGSkinColor", SkinColor:ToVector())
        end

    end


    local vguiCancel = vgui.Create("DButton", vguiFrame)
    vguiCancel:SetPos(RX(30), RY(1005))
    vguiCancel:SetSize(RX(201), RY(46))
    vguiCancel:SetText("   RETOUR")
    vguiCancel:SetFont("GTO:1CharSys22")
    vguiCancel:SetTextColor(color_white)
    vguiCancel.Paint = function(self, w, h)
        surface.SetDrawColor(color_white) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.Disconect) 
	    surface.DrawTexturedRect(0, 0, w, h) 
    end 
    vguiCancel.DoClick = function()
        net.Start("GTO:OpenCharFrame")
        net.SendToServer()

        vguiFrame:Close() 

    end
    vguiCancel.OnCursorEntered = function()
        vguiCancel:SetTextColor(color_white:Lerp(Color(255, 0, 0), 1))
    end 
    vguiCancel.OnCursorExited = function()
        vguiCancel:SetTextColor(color_white)
    end 

    local vguiInfos = vgui.Create("DPanel", vguiFrame)
    if openbody then
        vguiInfos:SetVisible(false)
    end
    vguiInfos:SetPos(RX(800), RY(280))
    vguiInfos:SetSize(RX(778), RY(671))
    vguiInfos.Paint = function(self, w, h)

        if GTOCharSys and GTOCharSys.Resources and GTOCharSys.Resources.Materials and GTOCharSys.Resources.Materials.Text then
            surface.SetMaterial(GTOCharSys.Resources.Materials.Text)
            surface.DrawTexturedRect(60, 180, RX(600), RY(70))
        else
            draw.RoundedBox(8, 0, 0, w, h, color_white)
        end


        surface.SetDrawColor(color_white) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.Panel) 
	    surface.DrawTexturedRect(0, 0, w, h) 

        draw.SimpleText("IDENTITÉ", "GTO:1CharSys50", RX(250), RY(20), color_white)
        draw.SimpleText("Choisissez votre identité et devenez n'importe qui", "GTO:2CharSys28", RX(100), RY(70), color_white)        
        draw.SimpleText("Nom, Prénom (20 caractères)", "GTO:1CharSys30", RX(50), RY(130), color_white)
        draw.SimpleText("Village", "GTO:1CharSys30", RX(70), RY(265), color_white)
        draw.SimpleText("Sexe", "GTO:1CharSys30", RX(100), RY(415), color_white)
        
    
    end 

    local vguiIdentity = vgui.Create("DTextEntry", vguiInfos)
    vguiIdentity:SetPos(RX(80), RY(180))
    vguiIdentity:SetSize(RX(600), RY(70))
    vguiIdentity:SetDrawLanguageID(false)
    vguiIdentity:SetFont("GTO:1CharSys25")
    if sName then
        vguiIdentity:SetValue(sName)
    end

    vguiIdentity:SetTextColor(Color(0, 0, 0, 0))
    
    vguiIdentity.Paint = function(self, w, h)
        surface.SetDrawColor(color_white)
        self:DrawTextEntryText(Color(255, 255, 255), Color(255, 255, 255, 53), color_white)
        if self:GetValue() == "" then
            draw.SimpleText("Entrez votre nom, prénom ...", "GTO:2CharSys25", 5, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end
    vguiIdentity.OnTextChanged = function(self)
        if string.len(self:GetValue()) >= 20 then
            self:SetText(string.sub(self:GetValue(), 1, 20))
        end
        sName = self:GetValue()

    end 

    local vguiChooseVillageKonoha = vgui.Create("DButton", vguiInfos)
    vguiChooseVillageKonoha:SetPos(RX(80), RY(320))
    vguiChooseVillageKonoha:SetSize(RX(300), RY(65))
    vguiChooseVillageKonoha:SetText("   Konoha")
    vguiChooseVillageKonoha:SetFont("GTO:1CharSys30")
    vguiChooseVillageKonoha:SetTextColor(color_white)
    vguiChooseVillageKonoha.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.ButonNoHvr
		if self:IsHovered() then
			bg = GTOCharSys.Resources.Materials.Buton
		end

        if sVillage == "   Konoha" then bg = GTOCharSys.Resources.Materials.Buton end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)


		surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.konoha_logo)
        surface.DrawTexturedRect(70, 21, 25, 25)

    end

    vguiChooseVillageKonoha.DoClick = function()
        sVillage = "   Konoha"
        local bodyvillage = nil
        local sexvilalge = nil
        if sSexe == "man" then 
            sexvilalge = hairman
            bodyvillage = konoman 
        elseif sSexe == "woman" then
            sexvilalge = hairwoman 
            bodyvillage = konowoman 
        end

        UpdateCaracther(sSexe, TEAM_KONO_ELEVE, bodyvillage, sexvilalge)
    end


    local vguiChooseVillageKiri = vgui.Create("DButton", vguiInfos)
    vguiChooseVillageKiri:SetPos(RX(380), RY(320))
    vguiChooseVillageKiri:SetSize(RX(300), RY(65))
    vguiChooseVillageKiri:SetText("   Kiri")
    vguiChooseVillageKiri:SetFont("GTO:1CharSys30")
    vguiChooseVillageKiri:SetTextColor(color_white)
    vguiChooseVillageKiri.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.ButonNoHvr
		if self:IsHovered() then
			bg = GTOCharSys.Resources.Materials.Buton
		end

        if sVillage == "   Kiri" then bg = GTOCharSys.Resources.Materials.Buton end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)


		surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.kiri_logo)
        surface.DrawTexturedRect(70, 21, 25, 25)

    end

    vguiChooseVillageKiri.DoClick = function()
        sVillage = "   Kiri"

        local bodyvillage = nil
        local sexvilalge = nil

        if sSexe == "man" then 
            sexvilalge = hairman
            bodyvillage = kiriman 
        elseif sSexe == "woman" then 
            sexvilalge = hairwoman
            bodyvillage = kiriwoman 
        end

        UpdateCaracther(sSexe, TEAM_KIRI_ELEVE, bodyvillage, sexvilalge)
    end

    
    local vguiSexeMan = vgui.Create("DButton", vguiInfos)
    vguiSexeMan:SetPos(RX(120), RY(470))
    vguiSexeMan:SetSize(RX(300), RY(65))
    vguiSexeMan:SetText("   Homme")
    vguiSexeMan:SetFont("GTO:1CharSys30")
    vguiSexeMan:SetTextColor(color_white)
    vguiSexeMan.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.ButonNoHvr
		if self:IsHovered() then
			bg = GTOCharSys.Resources.Materials.Buton
		end

        if sSexe == "man" then bg = GTOCharSys.Resources.Materials.Buton end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)


		surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.Man)
        surface.DrawTexturedRect(70, 21, 25, 25)

    end

    vguiSexeMan.DoClick = function()
        sSexe = "man"
        local jobsex = nil
        local tenuesex = nil
        if sVillage == "   Konoha" then 
            jobsex = TEAM_KONO_ELEVE 
            tenuesex = konoman
        elseif sVillage == "   Kiri" then 
            jobsex = TEAM_KIRI_ELEVE 
            tenuesex = kiriman
        end

        UpdateCaracther(sSexe, jobsex, tenuesex, hairman)
    end

    local vguiSexeWoman = vgui.Create("DButton", vguiInfos)
    vguiSexeWoman:SetPos(RX(420), RY(470))
    vguiSexeWoman:SetSize(RX(300), RY(65))
    vguiSexeWoman:SetText("   Femme")
    vguiSexeWoman:SetFont("GTO:1CharSys30")
    vguiSexeWoman:SetTextColor(color_white)
    vguiSexeWoman.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.ButonNoHvr
		if self:IsHovered() then
			bg = GTOCharSys.Resources.Materials.Buton
		end

        if sSexe == "woman" then bg = GTOCharSys.Resources.Materials.Buton end
        
        surface.SetDrawColor(color_white)
		surface.SetMaterial(bg)
		surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.Woman)
        surface.DrawTexturedRect(70, 21, 23, 24)
    end

    vguiSexeWoman.DoClick = function()
        sSexe = "woman"
        local jobsex = nil
        local tenuesex = nil

        if sVillage == "   Konoha" then 
            jobsex = TEAM_KONO_ELEVE 
            tenuesex = konowoman
        elseif sVillage == "   KIRI" then 
            jobsex = TEAM_KIRI_ELEVE 
            tenuesex = kiriwoman
        end

        UpdateCaracther(sSexe, jobsex, tenuesex, hairwoman)
    end



    local vguiTenu = vgui.Create("DPanel", vguiFrame)
    vguiTenu:SetPos(RX(800), RY(280))
    vguiTenu:SetSize(RX(778), RY(671))
    if openbody then
        vguiTenu:SetVisible(true)
    else
        vguiTenu:SetVisible(false)
    end
    vguiTenu.Paint = function(self, w, h)

        if GTOCharSys and GTOCharSys.Resources and GTOCharSys.Resources.Materials and GTOCharSys.Resources.Materials.Text then
            surface.SetMaterial(GTOCharSys.Resources.Materials.Text)
            surface.DrawTexturedRect(60, 180, RX(600), RY(70))

            surface.SetDrawColor(color_white) 
            surface.SetMaterial(GTOCharSys.Resources.Materials.Text)
            surface.DrawTexturedRect(80, 315, RX(600), RY(70))

            surface.SetDrawColor(color_white) 
            surface.SetMaterial(GTOCharSys.Resources.Materials.Text)
            surface.DrawTexturedRect(110, 465, RX(600), RY(70))
        else
            draw.RoundedBox(8, 0, 0, w, h, color_white)
        end


        surface.SetDrawColor(color_white) 
	    surface.SetMaterial(GTOCharSys.Resources.Materials.Panel) 
	    surface.DrawTexturedRect(0, 0, w, h) 

    

        draw.SimpleText("APPARENCE", "GTO:1CharSys50", RX(250), RY(20), color_white)
        draw.SimpleText("Changez votre apparence et devenez une personne unique !", "GTO:2CharSys28", RX(35), RY(70), color_white)        
        draw.SimpleText("Haut", "GTO:1CharSys30", RX(50), RY(130), color_white)
        draw.SimpleText("Visage", "GTO:1CharSys30", RX(70), RY(265), color_white) 
        draw.SimpleText("Cheveux", "GTO:1CharSys30", RX(100), RY(415), color_white)
    end 

    local vguiChooseTenue = vgui.Create("DNumSlider", vguiTenu)
    vguiChooseTenue:SetPos(RX(80), RY(190))
    vguiChooseTenue:SetSize(RX(550), RY(70))
    vguiChooseTenue:SetText("")
    vguiChooseTenue:SetMin(0)
    vguiChooseTenue:SetMax(1)
    vguiChooseTenue:SetDecimals(0)
    vguiChooseTenue.Label:SetVisible(false)
    vguiChooseTenue.TextArea:SetVisible(false)
    vguiChooseTenue.TextArea:SetDrawBackground(false )
    vguiChooseTenue.Slider.Knob:SetColor(Color(50, 200, 255))

    vguiChooseTenue.Slider.Paint = function(self, w, h)
        local barHeight = 4 
        local cornerRadius = 8 
        draw.RoundedBox(cornerRadius, 0, h / 2 - barHeight / 2, w, barHeight, Color(255, 255, 255, 255)) 
    end
    
    vguiChooseTenue.Slider.Knob.Paint = function(self, w, h)
        draw.RoundedBox(h / 2, 0, 0, w, h, Color(255, 255, 255)) 
    

    end


    
    vguiChooseTenue.Paint = function(self, w, h)
        draw.SimpleText(vguiChooseTenue:GetMin(), "GTO:2CharSys20", RX(0), RY(0), color_bleu)
        draw.SimpleText(vguiChooseTenue:GetMax(), "GTO:2CharSys20", RX(530), RY(0), color_bleu)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 0)) 
    end
            


    local vguiChooseFace = vgui.Create("DNumSlider", vguiTenu)
    vguiChooseFace:SetPos(RX(100), RY(325))
    vguiChooseFace:SetSize(RX(550), RY(70))
    vguiChooseFace:SetText("")
    vguiChooseFace:SetMin(1)
    vguiChooseFace:SetMax(#Available_Faces)
    vguiChooseFace:SetDecimals(0)
    vguiChooseFace.Label:SetVisible(false)
    vguiChooseFace.TextArea:SetVisible(false)
    vguiChooseFace.TextArea:SetDrawBackground(false )
    vguiChooseFace.Slider.Knob:SetColor(Color(50, 200, 255))

    vguiChooseFace.Slider.Paint = function(self, w, h)
        local barHeight = 4 
        local cornerRadius = 8 
        draw.RoundedBox(cornerRadius, 0, h / 2 - barHeight / 2, w, barHeight, Color(255, 255, 255, 255)) 
    end
    
    
    vguiChooseFace.Slider.Knob.Paint = function(self, w, h)
        draw.RoundedBox(h / 2, 0, 0, w, h, Color(255, 255, 255)) 
    
        local parent = self:GetParent()
        local currentValue = parent:GetParent():GetValue() 
        local text = math.Round(currentValue)

        if text ~= 1 then
            if text ~= vguiChooseFace:GetMax() then
                draw.SimpleText(text, "DermaDefaultBold", w / 2, -15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            end
           
        end
    end
    

    vguiChooseFace.Paint = function(self, w, h)
        draw.SimpleText(vguiChooseFace:GetMin(), "GTO:2CharSys20", RX(0), RY(0), color_bleu)
        draw.SimpleText(vguiChooseFace:GetMax(), "GTO:2CharSys20", RX(530), RY(0), color_bleu)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 0)) 
    end
    
    for k, v in pairs(Available_Faces) do
        if v == SelectedFace then
            vguiChooseFace:SetValue(k)
        end
    end


    vguiChooseFace.OnValueChanged = function(self, value)
        local valuearound = math.Round(value)
        SelectedFace = Available_Faces[valuearound]
        UpdateClothe()
    end

    local vguiChooseHair = vgui.Create("DNumSlider", vguiTenu)
    vguiChooseHair:SetPos(RX(135), RY(475))
    vguiChooseHair:SetSize(RX(550), RY(70))
    vguiChooseHair:SetText("")
    vguiChooseHair:SetMin(1)
    vguiChooseHair:SetMax(#Available_Hairs)
    vguiChooseHair:SetDecimals(0)
    vguiChooseHair.Label:SetVisible(false)
    vguiChooseHair.TextArea:SetVisible(false)
    vguiChooseHair.TextArea:SetDrawBackground(false )
    vguiChooseHair.Slider.Knob:SetColor(Color(50, 200, 255))

    vguiChooseHair.Slider.Paint = function(self, w, h)
        local barHeight = 4 
        local cornerRadius = 8 
        draw.RoundedBox(cornerRadius, 0, h / 2 - barHeight / 2, w, barHeight, Color(255, 255, 255, 255)) 
    end
    
    
    vguiChooseHair.Slider.Knob.Paint = function(self, w, h)
        draw.RoundedBox(h / 2, 0, 0, w, h, Color(255, 255, 255)) 
    
        local parent = self:GetParent()
        local currentValue = parent:GetParent():GetValue() 
        local text = math.Round(currentValue)

        if text ~= 1 then
            if text ~= vguiChooseHair:GetMax() then
                draw.SimpleText(text, "DermaDefaultBold", w / 2, -15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            end
           
        end
    end
    

    vguiChooseHair.Paint = function(self, w, h)
        draw.SimpleText(vguiChooseHair:GetMin(), "GTO:2CharSys20", RX(0), RY(0), color_bleu)
        draw.SimpleText(vguiChooseHair:GetMax(), "GTO:2CharSys20", RX(530), RY(0), color_bleu)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 0)) 
    end

    for k, v in pairs(Available_Hairs) do
        if v == SelectedHairs then
            vguiChooseHair:SetValue(k)
        end
    end

    vguiChooseHair.OnValueChanged = function(self, value)
        local valuearound = math.Round(value)
        SelectedHairs = Available_Hairs[valuearound]
        UpdateClothe()
    end


    local function OpenColorPicker(parent, current)
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
                Color(93, 70, 120),
                Color(0, 128, 0),
            },
        }

        local Frame = vgui.Create("DFrame", parent)
        Frame:SetSize(RX(1200), RY(colors[current] and 300 or 500))
        Frame:Center()
        Frame:SetTitle("Choix de couleur: " .. word[current])
        Frame:MakePopup()
        function Frame:Paint(w, h)
            surface.SetDrawColor(70, 70, 70)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(16, 16, 16)
            surface.DrawRect(0, 0, w, 25)
        end

        if colors[current] then
            local currentColor = parent[current .. "Color"]

            for i = 1, #colors[current] do
                local color = colors[current][i]
                local euclidean = math.floor((i - 1) / 3)
                local btn = vgui.Create("DButton", Frame)
                btn:SetText("")
                btn:SetSize(RX(130), RY(50))
                btn:SetPos(RX(40) + RX(150) * ((i - 1) % 3), RY(90) * (euclidean + 1))
                function btn:Paint(w, h)
                    draw.RoundedBox(5, 0, 0, w, h, currentColor == color and Color(0, 190, 0) or Color(0, 0, 0))
                    draw.RoundedBox(5, 10, 10, w - 20, h - 20, color)
                end
                btn.DoClick = function()
                    if current == "body" then
                        SkinColor = color  
                    elseif current == "face" then
                        HeadbandColor = color
                    end 
                    UpdateClothe()
                end
            end
        else
            local colorPicker = vgui.Create("DColorMixer", Frame)
            colorPicker:Dock(FILL)
            colorPicker:SetPalette(true)
            colorPicker:SetAlphaBar(false)
            colorPicker:SetWangs(true)
            colorPicker:SetColor(HairsColor or Color(255, 255, 255))
            function colorPicker:ValueChanged(newColor)
                HairsColor = Color(newColor.r, newColor.g, newColor.b, 255)
                UpdateClothe()
            end
        end
    end


    local color_body = vgui.Create("DButton", vguiTenu)
    color_body:SetPos(RX(135), RY(580))
    color_body:SetSize(RX(185), RY(70))
    color_body:SetText("   Corps")
    color_body:SetFont("GTO:3CharSys30")
    color_body:SetTextColor(color_white)
    color_body.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.Color_Select
        if self:IsHovered() then
            bg = GTOCharSys.Resources.Materials.Color_Select_Hover
        end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.Pallete)
        surface.DrawTexturedRect(35, 25, 20, 20)
    end
    color_body.DoClick = function()
        OpenColorPicker(vguiTenu, "body")
    end

    local color_bandeau = vgui.Create("DButton", vguiTenu)
    color_bandeau:SetPos(RX(335), RY(580))
    color_bandeau:SetSize(RX(185), RY(70))
    color_bandeau:SetText("    Bandeau")
    color_bandeau:SetFont("GTO:3CharSys30")
    color_bandeau:SetTextColor(color_white)
    color_bandeau.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.Color_Select
        if self:IsHovered() then
            bg = GTOCharSys.Resources.Materials.Color_Select_Hover
        end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.Pallete)
        surface.DrawTexturedRect(30, 25, 20, 20)
    end
    color_bandeau.DoClick = function()
        OpenColorPicker(vguiTenu, "face")
    end

    local color_hairs = vgui.Create("DButton", vguiTenu)
    color_hairs:SetPos(RX(535), RY(580))
    color_hairs:SetSize(RX(185), RY(70))
    color_hairs:SetText("    Cheveux")
    color_hairs:SetFont("GTO:3CharSys30")
    color_hairs:SetTextColor(color_white)
    color_hairs.Paint = function(self, w, h)
        local bg = GTOCharSys.Resources.Materials.Color_Select
        if self:IsHovered() then
            bg = GTOCharSys.Resources.Materials.Color_Select_Hover
        end

        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(GTOCharSys.Resources.Materials.Pallete)
        surface.DrawTexturedRect(30, 25, 20, 20)
    end
    color_hairs.DoClick = function()
        OpenColorPicker(vguiTenu, "hairs")
    end




    local current_page = "Identity"

    if openbody then
        current_page = "Body"
    end

    local vguiCreateIdentity = vgui.Create("DButton", vguiFrame) 
    vguiCreateIdentity:SetPos(RX(1500), RY(400))				
    vguiCreateIdentity:SetSize(107, 87)	
    vguiCreateIdentity:SetText("")
    vguiCreateIdentity.Paint = function(self, w, h) 
        local bg = GTOCharSys.Resources.Materials.Identity
        local body = GTOCharSys.Resources.Materials.body

        if current_page == "Identity" then 
            bg = GTOCharSys.Resources.Materials.IdentityHover 
            body = GTOCharSys.Resources.Materials.body_hover
        end

		if self:IsHovered() then
			bg = GTOCharSys.Resources.Materials.IdentityHover
            body = GTOCharSys.Resources.Materials.body_hover
		end
        
        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(color_white) 
        surface.SetMaterial(body) 
        surface.DrawTexturedRect(37, 22, 35, 40)
        
    end
    vguiCreateIdentity.DoClick = function()
        if not IsValid(vguiTenu) then return end
        if vguiInfos:IsVisible() then return end 
        current_page = "Identity"
        vguiTenu:SetVisible(false)
        vguiInfos:SetVisible(true)
        
    end 


    local vguiCreateBody = vgui.Create("DButton", vguiFrame) 
    vguiCreateBody:SetPos(RX(1520), RY(500))				
    vguiCreateBody:SetSize(107, 87)	
    vguiCreateBody:SetText("")
    vguiCreateBody.Paint = function(self, w, h) 
        local bg = GTOCharSys.Resources.Materials.Identity
        local face = GTOCharSys.Resources.Materials.face

        if current_page == "Body" then 
            bg = GTOCharSys.Resources.Materials.IdentityHover 
            face = GTOCharSys.Resources.Materials.face_hover
        end

        if self:IsHovered() then
            face = GTOCharSys.Resources.Materials.face_hover
            bg = GTOCharSys.Resources.Materials.IdentityHover
        end
        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)

        surface.SetDrawColor(color_white)
        surface.SetMaterial(face)
        surface.DrawTexturedRect(37, 22, 35, 40)
    end

    vguiCreateBody.DoClick = function()

        if sName == "" then return end
        if sVillage == "  Choisissez votre village ..." then return end
        if sSexe ~= "man" and sSexe ~= "woman" then return end

        if not IsValid(vguiInfos) then return end 
        if vguiTenu:IsVisible() then return end
        current_page = "Body"
        vguiInfos:SetVisible(false)
        vguiTenu:SetVisible(true)
    end 


    local vguiCreateCharacter = vgui.Create("DButton", vguiFrame) 
    vguiCreateCharacter:SetPos(RX(1540), RY(600))				
    vguiCreateCharacter:SetSize(107, 87)
    vguiCreateCharacter:SetText("")
    vguiCreateCharacter.Paint = function(self, w, h) 
        local bg = GTOCharSys.Resources.Materials.Save
        if self:IsHovered() then
            bg = GTOCharSys.Resources.Materials.SaveHover
        end
        surface.SetDrawColor(color_white)
        surface.SetMaterial(bg)
        surface.DrawTexturedRect(0, 0, w, h)
    end

    vguiCreateCharacter.DoClick = function()
        if sName == "" then return end
        if sVillage == "  Choisissez votre village ..." then return end
        if sSexe ~= "man" and sSexe ~= "woman" then return end

        if SelectedBody == nil or SelectedBody == "" then return end
        if SelectedFace == nil or SelectedFace == "" then  return end
        if SelectedHairs == nil or SelectedHairs == "" then return end

        local sVillage = string.Trim(sVillage)

        LocalPlayer().NewCharacter = {}

        LocalPlayer().NewCharacter.name = sName
        LocalPlayer().NewCharacter.village = sVillage
        LocalPlayer().NewCharacter.sex = sSexe

        local clothes = {
			body = SelectedBody,
			hairs = SelectedHairs,
			hairs_color = string.format("%d;%d;%d", HairsColor.r, HairsColor.g, HairsColor.b),
			headband_color = string.format("%d;%d;%d", HeadbandColor.r, HeadbandColor.g, HeadbandColor.b),
			skin_color = string.format("%d;%d;%d", SkinColor.r, SkinColor.g, SkinColor.b),
			face = SelectedFace,
		}

        LocalPlayer().NewCharacter.clothes = clothes

        LocalPlayer():ATG_CreateNewCharacter()

        vguiFrame:Close()
    end 


end

local function fcOpenCharCreation()
    local pPlayer = LocalPlayer()
    local vguiFrame = vgui.Create("DFrame")
    vguiFrame:SetSize(ScrW(), ScrH()) 
    vguiFrame:SetPos(0, 0)
    vguiFrame:SetTitle("")
	vguiFrame:SetVisible( true ) 
	vguiFrame:SetDraggable( false ) 
	vguiFrame:ShowCloseButton( false ) 
    vguiFrame:MakePopup()
    vguiFrame.Paint = function(self, w, h)
        surface.SetDrawColor(color_white) 
        surface.SetMaterial(GTOCharSys.Resources.Materials.Background) 
        surface.DrawTexturedRect(0, 0, w, h) 

        surface.SetDrawColor(color_white) 
        surface.SetMaterial(GTOCharSys.Resources.Materials.Effect) 
        surface.DrawTexturedRect(0, 0, w, h) 

        surface.SetDrawColor(color_white) 
        surface.SetMaterial(GTOCharSys.Resources.Materials.Cloud) 
        surface.DrawTexturedRect(0, 0, w, h) 

        draw.SimpleText("CHOISISSEZ VOTRE PERSONNAGE", "GTO:1CharSys58", RX(50), RY(44), color_white)
        draw.SimpleText("Choisissez ou créer votre personnage et (re)découvrez ce monde !", "GTO:2CharSys33", RX(52), RY(95), Color(190, 190, 190))
    end

    local vguiDisconect = vgui.Create("DButton", vguiFrame)
    vguiDisconect:SetPos(RX(30), RY(1005))
    vguiDisconect:SetSize(RX(201), RY(46))
    vguiDisconect:SetText("   RETOUR")
    vguiDisconect:SetFont("GTO:1CharSys22")
    vguiDisconect:SetTextColor(color_white)
    vguiDisconect.Paint = function(self, w, h)
        surface.SetDrawColor(color_white) 
        surface.SetMaterial(GTOCharSys.Resources.Materials.Disconect) 
        surface.DrawTexturedRect(0, 0, w, h) 
    end 
    vguiDisconect.DoClick = function()
        vguiFrame:Close()
        
    end
    vguiDisconect.OnCursorEntered = function()
        vguiDisconect:SetTextColor(Color(255, 0, 0))
    end 
    vguiDisconect.OnCursorExited = function()
        vguiDisconect:SetTextColor(color_white)
    end 

    local tCharacters = tCharactersCache

    if not istable(tCharacters) then 
        tCharacters = {}
    end 
    
    for i = 1, 3 do
        local vguiCreate = vgui.Create("DPanel", vguiFrame)
        local panelSpacing = RX(-280)
        vguiCreate:SetPos((RX(674) + panelSpacing) * (i - 1) + RX(280), RY(270))
        vguiCreate:SetSize(RX(674), RX(674))
    
        vguiCreate.Paint = function(self, w, h)
            surface.SetDrawColor(color_white)
            if tCharacters[i] then
                local character = tCharacters[i]

                surface.SetMaterial(GTOCharSys.Resources.Materials.Play)
                surface.DrawTexturedRect(0, 0, w, h)

                local textsize, textheight = surface.GetTextSize(character.name)

                draw.SimpleText(character.name, "GTO:1CharSys35", w/2.4, RY(80), color_white, TEXT_ALIGN_CENTER)

                draw.SimpleText(character.village, "GTO:2CharSys20", w/2.3, RY(120), color_white, TEXT_ALIGN_CENTER)
                
            else
                local hasAccess = false
                if i == 1 then
                    hasAccess = true
                    surface.SetMaterial(GTOCharSys.Resources.Materials.Create)
                elseif i == 2 then
                    if GTOCharSys.Resources.Ranks[i][pPlayer:GetUserGroup()] then
                        hasAccess = true
                        surface.SetMaterial(GTOCharSys.Resources.Materials.Create)
                    else
                        surface.SetMaterial(GTOCharSys.Resources.Materials.Vip)
                    end
                elseif i == 3 then
                    if GTOCharSys.Resources.Ranks[i][pPlayer:GetUserGroup()] then
                        hasAccess = true
                        surface.SetMaterial(GTOCharSys.Resources.Materials.Create)
                    else
                        surface.SetMaterial(GTOCharSys.Resources.Materials.Staff)
                    end
                end
                surface.DrawTexturedRect(0, 0, w, h)

            end
        end
    
        if not tCharacters[i] and GTOCharSys.Resources.Ranks[i][pPlayer:GetUserGroup()] then
            local vguiNewChar = vgui.Create("DButton", vguiCreate)
            vguiNewChar:SetSize(RX(300), RY(57))
            vguiNewChar:SetPos((vguiCreate:GetWide() - vguiNewChar:GetWide()) / 2 + 50, RY(540))
            vguiNewChar:SetText("CRÉER")
            vguiNewChar:SetFont("GTO:1CharSys30")
            vguiNewChar:SetTextColor(color_white)
            vguiNewChar.Paint = function(self, w, h)
                local bg = GTOCharSys.Resources.Materials.ButonNoHvr

                if self:IsHovered() then
                    bg = GTOCharSys.Resources.Materials.Buton
                end

                surface.SetDrawColor(color_white)
                surface.SetMaterial(bg)
                surface.DrawTexturedRect(0, 0, w, h)
            end
            vguiNewChar.DoClick = function()
                vguiFrame:Close()
                fcCreateCharacter()
            end
        elseif tCharacters[i]  then
            local caracther = tCharacters[i]

            local vguiDelete = vgui.Create("DButton", vguiCreate)
            vguiDelete:SetSize(RX(25), RY(25))
            vguiDelete:SetPos(RX(120), RY(70))
            vguiDelete:SetText("")
            vguiDelete:SetFont("GTO:1CharSys30")
            vguiDelete:SetTextColor(color_white)
            vguiDelete.Paint = function (self, w, h)
                local bg = GTOCharSys.Resources.Materials.Poubelle

                surface.SetDrawColor(color_white)
                surface.SetMaterial(bg)
                surface.DrawTexturedRect(0, 0, w, h)
            end

            vguiDelete.DoClick = function()
                net.Start("GTOCharSys:DeleteCharacter")
                    net.WriteInt(caracther.id, 32)
                net.SendToServer()

                net.Start("GTO:OpenCharFrame")
                net.SendToServer()
        
 
                vguiFrame:Close()
   

            end

            local infos_preview = vgui.Create("DModelPanel", vguiCreate)
            infos_preview:SetSize(RX(380), RY(500))
            infos_preview:SetPos(RX(170), RY(108))
            infos_preview:SetFOV(30)
            infos_preview:SetLookAt(Vector(0, 0, 55.0))
            infos_preview:SetModel(ATG_Clothes_GetBody(caracther.clothes_body).model)
            local ent = infos_preview:GetEntity()
            ent:SetSequence(ent:LookupSequence("pose_minato"))
            ent:SetAngles(Angle(0, 15, 0))
            infos_preview.LayoutEntity = function (entity)
                if ent:GetCycle() == 1 then ent:SetCycle(0) end
                infos_preview:RunAnimation()
            end
            local hairs = ClientsideModel(ATG_Clothes_GetHairs(caracther.clothes_hairs).model)
            hairs:SetNoDraw(true)
            local face = ClientsideModel(ATG_Clothes_GetFace(caracther.clothes_face).model)
            face:SetNoDraw(true)
    
            infos_preview.PostDrawModel = function()
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
  

            local Hairs_Color = string.Split(caracther.clothes_hairs_color, ";")
            local Headband_Color = string.Split(caracther.clothes_headband_color, ";")
            local Body_Color = string.Split(caracther.clothes_skin_color, ";")
            
            Hairs_Color = Color(Hairs_Color[1], Hairs_Color[2], Hairs_Color[3])
            Headband_Color = Color(Headband_Color[1], Headband_Color[2], Headband_Color[3])
            Body_Color = Color(Body_Color[1], Body_Color[2], Body_Color[3])

            for k,v in pairs({ent, hairs, face}) do
                v:SetNWVector("CTG_MatProxies:CTGHairsColor", Hairs_Color:ToVector())
                v:SetNWVector("CTG_MatProxies:CTGHeadbandColor", Headband_Color:ToVector())
                v:SetNWVector("CTG_MatProxies:CTGSkinColor", Body_Color:ToVector())
            end



            local vguiPlay = vgui.Create("DButton", vguiCreate)
            vguiPlay:SetSize(RX(300), RY(57))
            vguiPlay:SetPos((vguiCreate:GetWide() - vguiPlay:GetWide()) / 2 + 50, RY(540))
            vguiPlay:SetText("JOUER")
            vguiPlay:SetFont("GTO:1CharSys30")
            vguiPlay:SetTextColor(color_white)
            vguiPlay.Paint = function(self, w, h)
                local bg = GTOCharSys.Resources.Materials.ButonNoHvr

                if self:IsHovered() then
                    bg = GTOCharSys.Resources.Materials.Buton
                end

                surface.SetDrawColor(color_white)
                surface.SetMaterial(bg)
                surface.DrawTexturedRect(0, 0, w, h)
            end
            vguiPlay.DoClick = function()
                if GTOCharSys.Resources.Ranks[i][pPlayer:GetUserGroup()] then
                    pPlayer:SelectCharacter(caracther.id)
                    vguiFrame:Close()
                end
            end



        end
    end
end
net.Receive("GTO:OpenCharFrame", fcOpenCharCreation)


function GTOCharSys:GetCharactersBySteamID()
    return tCharactersCache
end



concommand.Add("izg_reload", function(ply, cmd, args)
    if not IsValid(LocalPlayer()) then return end
    
    net.Start("CTG_Characters_UpdateSubModels")
    net.SendToServer()
    
    timer.Simple(0.1, function()
        if IsValid(LocalPlayer()) then
            net.Start("CTG_Characters_Characters_RequestCharacters")
            net.SendToServer()
            
            notification.AddLegacy("Apparence rechargée !", NOTIFY_GENERIC, 3)
        end
    end)
end)