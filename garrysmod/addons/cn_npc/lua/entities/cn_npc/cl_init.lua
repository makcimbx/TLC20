--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7
--]]

include("shared.lua")

ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	timer.Simple(IsValid(LocalPlayer()) and 1 or 5, function()
		if (IsValid(self)) then
            self:setAnim()

			local uniqueID = self:GetQuest()

			if (uniqueID and cnQuests[uniqueID]) then
				self.GetPlayerColor = function()
					return cnQuests[uniqueID].color
				end
			end
		end
	end)
end

function ENT:createBubble()
	self.bubble = ClientsideModel("models/extras/info_speech.mdl", RENDERGROUP_OPAQUE)
	self.bubble:SetPos(self:GetPos() + Vector(0, 0, 84))
	self.bubble:SetModelScale(0.6, 0)
end

function ENT:Draw()
	local realTime = RealTime()

	self:FrameAdvance(realTime - (self.lastTick or realTime))
	self.lastTick = realTime
	
	local bubble = self.bubble
	
	if (IsValid(bubble)) then
		local realTime = RealTime()
		
		local z = 84
		if(cnQuests[self:GetQuest()].prop!=nil)then
			z = 40
		end
		bubble:SetRenderOrigin(self:GetPos() + Vector(0, 0, z + math.sin(realTime * 3) * 0.75))
		bubble:SetRenderAngles(Angle(0, realTime * 100, 0))
	end

	self:DrawModel()
end

function ENT:Think()
	if (!IsValid(self.bubble)) then
		self:createBubble()
	end

	if ((self.nextAnimCheck or 0) < CurTime()) then
		self:setAnim()
		self.nextAnimCheck = CurTime() + 60
	end

	self:SetNextClientThink(CurTime() + 0.25)

	return true
end

function ENT:OnRemove()
	if (IsValid(self.bubble)) then
		self.bubble:Remove()
	end
end