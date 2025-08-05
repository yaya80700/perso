--[ CTG_Characters_PSS ]--
local PANEL = {}
local materials = {
	["bg"] = Material("gui/ctg_characters/pss.png"),

	["cross"] = Material("gui/ctg_characters/icons/red_cross.png"),
	["cross_hover"] = Material("gui/ctg_characters/icons/red_cross_hover.png"),

	["addBtn"] = Material("gui/ctg_characters/inputs/right.png"),
	["addBtn_hover"] = Material("gui/ctg_characters/inputs/right_hover.png"),

	["delBtn"] = Material("gui/ctg_characters/inputs/left.png"),
	["delBtn_hover"] = Material("gui/ctg_characters/inputs/left_hover.png"),
}
local STEAMID = nil
local ISGLOBAL = false
local PLY = nil
local CHARACTER = nil

local function RX(x) return (x * ScrW()) / 1920 end
local function RY(x) return (x * ScrH()) / 1080 end


function PANEL:Init()
	self:SetSize(RX(808), RY(610)) 
	self:Center()
	self:SetTitle("")   
	self:ShowCloseButton(false)

	STEAMID = CTG_PSS_ARGS[1]
	PLY = player.GetBySteamID64(STEAMID)
	ISGLOBAL = tonumber(CTG_PSS_ARGS[2]) < 1
	if not ISGLOBAL then
		CHARACTER = CTG_PSS_ARGS[4]
	end
	SWEPS = CTG_PSS_ARGS[3][ISGLOBAL and "global" or tonumber(CHARACTER.id)]
	SWEPS = SWEPS or {}

	self:CloseButton()
	self:Elements()
end

function PANEL:OnClose()
	if not IsValid(PLY) then -- le joueur n'est pas connecté
		net.Start("CTG_Characters_SavePSS")
		net.WriteString(STEAMID)
		net.SendToServer()
	end
end

function PANEL:Paint(w, h)
	surface.SetDrawColor(255, 255, 255, 255)

	surface.SetMaterial(materials["bg"])
	surface.DrawTexturedRect(0, 0, w, h)

	local title = ""
	if ISGLOBAL then
		if IsValid(PLY) then
			title = PLY:SteamName()
		else
			title = util.SteamIDFrom64(STEAMID)
		end
		title = title.." (Global)"
	else
		title = CHARACTER.name
	end
	draw.SimpleText(title, "GTO:1CharSys30", RX(404), RY(80), Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
end

function PANEL:CloseButton()
	local closeButton = vgui.Create("DButton", self)
	closeButton:SetSize(RX(64), RY(64))
	closeButton:SetPos(RX(724), RY(10))
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
	local leftPanel = vgui.Create("DPanel", self)
	leftPanel:SetSize(RX(347), RY(321))
	leftPanel:SetPos(RX(20), RY(241))
	leftPanel.Paint = function(self, w, h)
	end
	local leftList = vgui.Create("DListView", leftPanel)
	leftList:Dock(FILL)
	leftList:DockMargin(RX(10), RX(10), RY(10), RY(10))
	leftList:AddColumn("Swep")
	leftList:SetHideHeaders(true)
	leftList:SetPaintBackground(false)
	leftList:SetMultiSelect(false)
	function leftList:UpdateContent(input)
		input = input or ""
		self:Clear()
		local sweps = weapons.GetList()
		table.SortByMember(sweps, "ClassName", true)
		for i=1, #sweps do
			local swep = sweps[i]
			if SWEPS[swep.ClassName] or not string.StartWith(swep.ClassName, input) then continue end
			leftList:AddLine(swep.ClassName)
		end
		for i=1,#leftList.Lines do
			local line = leftList.Lines[i]
			for i=1,#line.Columns do
				local label = line.Columns[i]
				label:SetColor(Color(255, 255, 255, 255))
				label:SetFont("GTO:1CharSys15")
			end
		end
	end

	local rightPanel = vgui.Create("DPanel", self)
	rightPanel:SetSize(RX(347), RY(321))
	rightPanel:SetPos(RX(442), RY(241))
	rightPanel.Paint = function(self, w, h)
	end
	local rightList = vgui.Create("DListView", rightPanel)
	rightList:Dock(FILL)
	rightList:DockMargin(RX(10), RX(10), RY(10), RY(10))
	rightList:AddColumn("Swep")
	rightList:SetHideHeaders(true)
	rightList:SetPaintBackground(false)
	rightList:SetMultiSelect(false)
	function rightList:UpdateContent(input)
		input = input or ""
		self:Clear()
		for key, _ in pairs(SWEPS) do
			if string.StartWith(key, input) then
				rightList:AddLine(key)
			end
		end
		for i=1,#rightList.Lines do
			local line = rightList.Lines[i]
			for i=1,#line.Columns do
				local label = line.Columns[i]
				label:SetColor(Color(255, 255, 255, 255))
				label:SetFont("GTO:1CharSys15")
			end
		end
	end

	local addButton = vgui.Create("DButton", self)
	addButton:SetSize(RX(55), RY(37))
	addButton:SetPos(RX(376), RY(328))
	addButton:SetText("")
	addButton.Paint = function(self, w, h)
		local bg = materials["addBtn"]
		if self:IsHovered() then
			bg = materials["addBtn_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	addButton.DoClick = function()
		local selected = leftList:GetSelected()[1]
		if not selected then return end

		local swep = selected:GetValue(1)
		net.Start("CTG_Characters_PSS_Add")
		net.WriteString(STEAMID)
		net.WriteString(ISGLOBAL and 0 or CHARACTER.id)
		net.WriteString(swep)
		net.SendToServer()

		self:RenewFrame()
	end

	local delButton = vgui.Create("DButton", self)
	delButton:SetSize(RX(55), RY(37))
	delButton:SetPos(RX(376), RY(374))
	delButton:SetText("")
	delButton.Paint = function(self, w, h)
		local bg = materials["delBtn"]
		if self:IsHovered() then
			bg = materials["delBtn_hover"]
		end
		surface.SetMaterial(bg)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(0, 0, w, h)
	end
	delButton.DoClick = function()
		local selected = rightList:GetSelected()[1]
		if not selected then return end

		local swep = selected:GetValue(1)
		net.Start("CTG_Characters_PSS_Del")
		net.WriteString(STEAMID)
		net.WriteString(ISGLOBAL and 0 or CHARACTER.id)
		net.WriteString(swep)
		net.SendToServer()

		self:RenewFrame()
	end

	local search = vgui.Create("DTextEntry", self)
	search:SetSize(RX(347), RY(30))
	search:SetPos(RX(808)/2 - RX(347)/2, RY(610) - RY(40))
	search:SetDrawLanguageID(false)
	function search:OnChange()
		local input = self:GetValue()
		leftList:UpdateContent(input)
		rightList:UpdateContent(input)
	end

	leftList:UpdateContent()
	rightList:UpdateContent()

end

function PANEL:RenewFrame()
	net.Start("CTG_Characters_OpenPSS")
	net.WriteString(STEAMID)
	net.WriteString(CTG_PSS_ARGS[2])
	net.SendToServer()
	self:Close()
end

vgui.Register("CTG_Characters_PSS", PANEL, "DFrame")
PANEL = nil


print("[CTG] cl_pss_frame.lua loaded")