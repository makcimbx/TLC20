--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/mossman.mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_BBOX)
	self:PhysicsInit(SOLID_BBOX)

	self.receivers = {}

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end

	timer.Simple(1, function()
		if (!IsValid(self)) then
			return
		end
 
	    local uniqueID = self:GetQuest()
	    local info = uniqueID and cnQuests[uniqueID]
		if(GetData(uniqueID.."lastplid","0")!="0")then
			RemoveOfflineData( "npc_take", GetData(uniqueID.."lastplid") )
		end
		RemoveData( uniqueID.."startFirMis" )
	    if (info and type(info.onEntityCreated) == "function") then
	    	info:onEntityCreated(self)
	    end
	end)
end

function ENT:Interact(activator)
	if (!self:GetQuest()) then
		return
	end
	
	local ide = self:GetQuest()
	local day = tonumber(os.date( "%d" , os.time() ))
	local sday = tonumber(activator:GetPData("npc_"..ide.."time","0"))
	
	if(day>sday)then
		activator:SetPData("npc_"..ide.."time","0")
		SendInfoOnCL(activator,Entity(self:EntIndex()))
	end
	
	local info = cnQuests[self:GetQuest()]

	if (info) then
		if (info.customUse) then
			if (!info:customUse(activator, self)) then
				return
			end
		end

		if (!IsValid(activator.cnQuest)) then
			activator.cnQuest = self
		else
			return
		end

		net.Start("npcOpen")
			net.WriteUInt(self:EntIndex(), 14)
		net.Send(activator)
	end
end