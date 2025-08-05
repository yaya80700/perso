local PANEL = {}
local materials = {
	["bg"] = Material("gui/ctg_characters/pss_offline_steamid.png"),

	["cross"] = Material("gui/ctg_characters/icons/red_cross.png"),
	["cross_hover"] = Material("gui/ctg_characters/icons/red_cross_hover.png"),

	["ok"] = Material("gui/ctg_characters/icons/ok.png"),
	["ok_hover"] = Material("gui/ctg_characters/icons/ok_hover.png"),
}
CTG_PSS_Cache = {}

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

local function RX(x) return (x * ScrW()) / 1920 end
local function RY(x) return (x * ScrH()) / 1080 end

function PANEL:Init()
	CTG_PSS_ARGS = {}

	self:SetSize(RX(808), RY(379)) 
	self:Center()
	self:SetTitle("")   
	self:ShowCloseButton(false)

	self:CloseButton()
	self:Elements()
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(materials["bg"])
	surface.DrawTexturedRect(0, 0, w, h)
end

function PANEL:CloseButton()
	local closeButton = vgui.Create("DButton", self)
	closeButton:SetSize(RX(64), RY(64))
	closeButton:SetPos(RX(730), RY(10))
	closeButton:SetText("")
	closeButton.Paint = function(self, w, h)
		local bg = materials["cross"]
		if self:IsHovered() then
			bg = materials["cross_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	closeButton.DoClick = function()
		self:Close()
	end
end

function PANEL:Elements()
	local field = vgui.Create("DTextEntry", self)
	field:SetSize(RX(492), RY(54))
	field:SetPos(RX(158), RY(222))
	field:SetFont("GTO:1CharSys30")
	field:SetDrawLanguageID(false)
	field:SetTextColor(Color(255,255,255))
	field:SetDrawBackground(false)
	field:SetCursorColor(Color(250, 180, 0))

	local acceptBtn = vgui.Create("DButton", self)
	acceptBtn:SetSize(RX(96), RY(96))
	acceptBtn:SetPos(RX(698), RY(268))
	acceptBtn:SetText("")
	acceptBtn.Paint = function(self, w, h)
		local bg = materials["ok"]
		if self:IsHovered() then
			bg = materials["ok_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	acceptBtn.DoClick = function()
		local steamid = field:GetText()
		if not steamid or string.len(string.Trim(steamid)) < 1 then return end

		net.Start("CTG_Characters_OpenPSS_SelectOffline")
		net.WriteString(steamid)
		net.SendToServer()
	end
end

vgui.Register("CTG_Characters_PSS_Offline_STEAMID", PANEL, "DFrame")
PANEL = nil