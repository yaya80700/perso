--[ CTG_Characters_PSS_Select ]--
local PANEL = {}
local materials = {
	["bg"] = Material("gui/ctg_characters/frame.png"),
	["title"] = Material("gui/ctg_characters/titles/pss_select.png"),

	["cross"] = Material("gui/ctg_characters/icons/red_cross.png"),
	["cross_hover"] = Material("gui/ctg_characters/icons/red_cross_hover.png"),

	["btn"] = Material("gui/ctg_characters/inputs/blue.png"),
	["btn_hover"] = Material("gui/ctg_characters/inputs/blue_hover.png"),
	["btn_press"] = Material("gui/ctg_characters/inputs/blue_press.png"),
	["btn_text"] = "gui/ctg_characters/titles/pss_select_btn.png",

	["panel_bg"] = Material("gui/ctg_characters/frame_black.png")
}
CTG_PSS_Cache = {}

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

function PANEL:Init()
	CTG_PSS_ARGS = {}

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
	--[ PANELS ]--
	local playersPanel = vgui.Create("DPanel", self)
	playersPanel:SetSize(RX(334), RY(400))
	playersPanel:SetPos(RX(55), RY(225))
	playersPanel.Paint = function(self, w, h)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(materials["panel_bg"])
		surface.DrawTexturedRect(0, 0, w, h)
	end
	local playersList = vgui.Create("DListView", playersPanel)
	playersList:Dock(FILL)
	playersList:DockMargin(RX(10), RX(10), RY(10), RY(10))
	playersList:AddColumn("Name")
	playersList:AddColumn("SteamID")
	playersList:SetHideHeaders(true)
	playersList:SetPaintBackground(false)
	playersList:SetMultiSelect(false)
	function playersList:UpdateContent()
		self:Clear()
		for _, ply in ipairs(player.GetAll()) do
			local line = playersList:AddLine(ply:Nick(), ply:SteamID64())
		end
		for i=1,#playersList.Lines do
			local line = playersList.Lines[i]
			for i=1,#line.Columns do
				local label = line.Columns[i]
				label:SetColor(Color(255, 255, 255, 255))
				label:SetFont("GTO:1CharSys15")
			end
		end
	end
	timer.Simple(0, function()
		playersList:SortByColumn(1)
	end)

	local charactersPanel = vgui.Create("DPanel", self)
	charactersPanel:SetSize(RX(334), RY(400))
	charactersPanel:SetPos(RX(435), RY(225))
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
		local row = playersList:GetSelected()[1]
		if not row then return end
		local steamid = string.len(string.Trim(row:GetValue(2))) > 1 and row:GetValue(2) or "90071996842377216" -- First bot steamid

		local characters = CTG_PSS_Cache[steamid]
		if not characters then return end
		
		local title = "Bot (Global)"
		local ply = player.GetBySteamID64(steamid)
		if ply then title = ply:SteamName().." (Global)" end
		charactersList:AddLine("0", title)
		for i=1,#characters do
			local char = characters[i]
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

	function playersList:OnRowSelected()
		charactersList:UpdateContent()
	end

	--[ BUTTONS ]--
	local steamIdButton = vgui.Create("DButton", self)
	steamIdButton:SetSize(RX(334), RY(61))
	steamIdButton:SetPos(RX(55), RY(655))
	steamIdButton:SetText("")
	steamIdButton.Paint = function(self, w, h)
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
	steamIdButton.DoClick = function()
		CTG_Characters_OpenFrame("CTG_Characters_PSS_Offline_STEAMID")
	end

	local acceptButton = vgui.Create("DButton", self)
	acceptButton:SetSize(RX(334), RY(61))
	acceptButton:SetPos(RX(435), RY(655))
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
		if #playersList:GetSelected() > 0 and #charactersList:GetSelected() > 0 then
			local row = playersList:GetSelected()[1]
			if not row then return end
			local steamid = string.len(string.Trim(row:GetValue(2))) > 1 and row:GetValue(2) or "90071996842377216" -- First bot steamid

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

	local buttonText = vgui.Create("Material", self)
	buttonText:SetPos(RX(55), RY(655))
	buttonText:SetSize(RX(714), RY(61))
	buttonText:SetMaterial(materials["btn_text"])

	playersList:UpdateContent()
	charactersList:UpdateContent()
end

vgui.Register("CTG_Characters_PSS_Select", PANEL, "DFrame")
PANEL = nil