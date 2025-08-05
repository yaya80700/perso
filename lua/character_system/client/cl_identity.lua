--[ CTG_Characters_InfosRP ]--
local materials = {
	["bg"] = Material("identitie/bg.png"),
	
	["red_cross"] = Material("wardrobe/red_cross.png"),
	["red_cross_hover"] = Material("wardrobe/red_cross_hover.png"),
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


local PANEL = {}
PANEL.Elements = PANEL.Elements or {}

function PANEL:Init()
	self:SetSize(RX(824), RY(752))
	self:Center()
	self:SetTitle("")   
	self:ShowCloseButton(false)  

	self:Fields()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.SetMaterial(materials["bg"])
	surface.DrawTexturedRect(0, 0, w, h)
end

function PANEL:Fields()
	local Width, Height = self:GetSize()

	local closeButton = vgui.Create("DButton", self)
	closeButton:SetPos(Width - RX(84), RY(10))
	closeButton:SetSize(RX(64), RX(64))
	closeButton:SetText("")
	closeButton.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(materials["red_cross"])
		if(self:IsHovered()) then surface.SetMaterial(materials["red_cross_hover"]) end
		surface.DrawTexturedRect(0, 0, w, h)
	end
	closeButton.DoClick = function()
		self:Close()
	end

	local textField = vgui.Create("DTextEntry", self)
	textField:SetPos(RX(77), RY(420))
	textField:SetSize(RX(671), RX(72))
	textField:SetFont("GTO:1CharSys30")
	textField:SetDrawLanguageID(false)
	textField:SetTextColor(Color(255,255,255))
	textField:SetDrawBackground(false)
	textField:SetCursorColor(Color(250, 180, 0))

	local priceLabel = vgui.Create("DLabel", self)
	priceLabel:SetText("ATTENTION: Le changement de nom est payant: 0 Ryôs")
	priceLabel:SetFont("Trebuchet24")
	priceLabel:SizeToContents()
	priceLabel:SetPos(self:GetSize()/2 - priceLabel:GetSize()/2, RY(630))
	priceLabel:SetColor(Color(255, 0, 0))

	local acceptButton = vgui.Create("DButton", self)
	acceptButton:SetPos(RX(239), RY(548))
	acceptButton:SetSize(RX(347), RX(78))
	acceptButton:SetText("")
	acceptButton.Paint = function(self, w, h)
	end
	acceptButton.DoClick = function()
		local name = textField:GetText()
		if string.len(string.Trim(name)) < 3 or string.len(string.Trim(name)) > 20 then return end
		if LocalPlayer():getDarkRPVar("money") < 0 then return end
		
		net.Start("CTG_Characters_Identity_Rename")
		net.WriteString(name)
		net.SendToServer()
		self:Close()
		notification.AddLegacy("Vous avez changé d'identité. Nouveau nom: "..name, NOTIFY_GENERIC, 5)
	end

end

print("[CTG_Characters_InfosRP] Chargé !")

vgui.Register("CTG_Characters_Identity", PANEL, "DFrame")
PANEL = nil

