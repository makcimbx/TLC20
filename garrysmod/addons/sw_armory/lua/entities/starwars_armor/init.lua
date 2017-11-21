--[[---------------------------------------------------------------------------
This is an example of a custom entity.
---------------------------------------------------------------------------]]
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
	self:SetSolid(SOLID_BBOX);
	self:PhysicsInit(SOLID_BBOX);
	self:SetMoveType(MOVETYPE_NONE);
	self:DrawShadow(true);
	self:SetUseType(SIMPLE_USE);
end

function ENT:AcceptInput(inputName, activator)
	if self.dead == false then return end
	
	if not IsValid(activator) then return end
	if not activator:IsPlayer() then return end

	if inputName == "Use" then
		net.Start("Armory_OpenMenu")
		net.Send(activator)
	end
end
