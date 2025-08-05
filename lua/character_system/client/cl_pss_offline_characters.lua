--[ CTG_Characters_PSS_Select ]--
local PANEL = {}
local materials = {
	["bg"] = Material("gui/ctg_characters/frame.png"),
	["title"] = Material("gui/ctg_characters/titles/pss_offline_characters.png"),

	["cross"] = Material("gui/ctg_characters/icons/red_cross.png"),
	["cross_hover"] = Material("gui/ctg_characters/icons/red_cross_hover.png"),

	["btn"] = Material("gui/ctg_characters/inputs/blue.png"),
	["btn_hover"] = Material("gui/ctg_characters/inputs/blue_hover.png"),
	["btn_press"] = Material("gui/ctg_characters/inputs/blue_press.png"),
	["btn_text"] = Material("gui/ctg_characters/titles/pss_select_btn.png"),

	["panel_bg"] = Material("gui/ctg_characters/frame_black.png")
}
CTG_PSS_OfflineCharacters = {}

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
	self:SetSize(RX(824), RY(752)) 
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

	surface.SetMaterial(materials["title"])
	surface.DrawTexturedRect(RX(251), RY(26), RX(319), RY(141))
end

function PANEL:CloseButton()
	local closeButton = vgui.Create("DButton", self)
	closeButton:SetSize(RX(64), RY(64))
	closeButton:SetPos(RX(740), RY(10))
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

	local charactersPanel = vgui.Create("DPanel", self)
	charactersPanel:SetSize(RX(334), RY(400))
	charactersPanel:SetPos(RX(245), RY(225))
	charactersPanel.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(materials["panel_bg"])
		surface.DrawTexturedRect(0, 0, w, h)
	end
	local charactersList = vgui.Create("DListView", charactersPanel)
	charactersList:Dock(FILL)
	charactersList:DockMargin(RX(10), RX(10), RY(10), RY(10))
	charactersList:AddColumn("Id")
	charactersList:AddColumn("Name")
	charactersList:SetHideHeaders(true)
	charactersList:SetPaintBackground(false)
	charactersList:SetMultiSelect(false)
	function charactersList:UpdateContent()
		self:Clear()
		
		charactersList:AddLine("0", "GLOBAL")
		for i=1,#CTG_PSS_OfflineCharacters do
			local char = CTG_PSS_OfflineCharacters[i]
			charactersList:AddLine(char.id, char.name)
		end

		for i=1,#charactersList.Lines do
			local line = charactersList.Lines[i]
			for i=1,#line.Columns do
				local label = line.Columns[i]
				label:SetColor(Color(255, 255, 255, 255))
				label:SetFont("GTO:1CharSys15")
			end
		end
	end
	charactersList:UpdateContent()

	local acceptButton = vgui.Create("DButton", self)
	acceptButton:SetSize(RX(334), RY(61))
	acceptButton:SetPos(RX(245), RY(655))
	acceptButton:SetText("")
	acceptButton.Paint = function(self, w, h)
		local bg = materials["btn"]
		if self:IsDown() then
			bg = materials["btn_press"]
		elseif self:IsHovered() then
			bg = materials["btn_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	acceptButton.DoClick = function()
		if #charactersList:GetSelected() > 0 then
			local steamid = CTG_PSS_ARGS[1]

			local row = charactersList:GetSelected()[1]
			if not row then return end
			local charId = row:GetValue(1)

			net.Start("CTG_Characters_OpenPSS")
			net.WriteString(steamid)
			net.WriteString(charId)
			net.SendToServer()
			self:Close()
		end 
	end

	local buttonText = vgui.Create("DLabel", self)
	buttonText:SetPos(RX(245), RY(655))
	buttonText:SetSize(RX(334), RY(61))
	buttonText:SetText("")
	buttonText.Paint = function(self, w, h)
		surface.SetMaterial(materials["btn_text"])
		surface.DrawTexturedRectUV(0, 0, w, h, 0.5, 0, 1, 1)
	end

end

vgui.Register("CTG_Characters_PSS_Offline_CHARACTERS", PANEL, "DFrame")
PANEL = nil

