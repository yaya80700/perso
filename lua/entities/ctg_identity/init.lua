AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')
include('shared.lua')

util.AddNetworkString("CTG_Characters_IdentityFrame")

function ENT:Initialize()

	self:SetModel("models/skylyxx/ctg/npc/npc_naruto.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetMaxYawSpeed(90)
end

function ENT:OnTakeDamage()
	return false
end

function ENT:Use(activator)
	if activator:IsPlayer() then
		net.Start("CTG_Characters_IdentityFrame")
		net.Send(activator)
	end
end
