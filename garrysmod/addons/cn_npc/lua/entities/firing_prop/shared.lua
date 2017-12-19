--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7
--]]

ENT.Type = "anim"
ENT.PhysgunDisable = false
ENT.PhysgunDisabled = false

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Legions"
ENT.Author			= "Ever"
ENT.Information		= "Legion control."
ENT.Category		= "Ever Items"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true


function ENT:setAnim()
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Quest")
end