--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7
--]]

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.hard = 1//1,2,3,4
ENT.OurHealth = 5; //2,4,6,8
ENT.speedy = 5//2,4,6,8
ENT.speedx = 5//2,4,6,8
ENT.speedz = 5//2,4,6,8
ENT.psz = 0.5//0.9,0,75,0.65,0.5
ENT.player = nil

function ENT:Initialize()
	if(self.hard==1)then
		self:SetModel("models/props_junk/wood_crate001a.mdl")
		self.OurHealth = 5
		self.speedy = 2
		self.speedx = 2
		self.speedz = 1
		self.psz = 0.9
	else
		if(self.hard==2)then
			self:SetModel("models/props_c17/FurnitureDrawer002a.mdl")
			self.OurHealth = 10
			self.speedy = 2.5
			self.speedx = 2.5
			self.speedz = 1.25
			self.psz = 0.75
		else
			if(self.hard==3)then
				self:SetModel("models/props_junk/PropaneCanister001a.mdl")
				self.OurHealth = 20
				self.speedy = 2.75
				self.speedx = 2.75
				self.speedz = 1.5
				self.psz = 0.65
			else
				if(self.hard==4)then
				self:SetModel("models/props_junk/PropaneCanister001a.mdl")
					self.OurHealth = 30
					self.speedy = 2.75
					self.speedx = 2.75
					self.speedz = 1.5
					self.psz = 0.5
				else
				
				end
			end
		end
	end
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)

	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		physObj:Sleep()
	end
	self.startpos=self:GetPos()
	local angles = self:GetAngles()
	self:SetAngles(Angle(0,90,0))
	
	self.tr = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos + self:GetAngles():Right() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	self.tr2 = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos - self:GetAngles():Right() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	self.tr3 = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos + self:GetAngles():Up() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	self.tr4 = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos - self:GetAngles():Up() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	
	self.tr5 = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos + self:GetAngles():Forward() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	self.tr6 = util.TraceLine( {
		start = self.startpos,
		endpos = self.startpos - self:GetAngles():Forward() * 10000,
		filter = function( ent ) if ( ent:GetClass() == "prop_physics" ) then return false end end
	} )
	self.maxposy = self.tr5.HitPos.y
	self.minposy = self.tr6.HitPos.y
	self.maxposx = self.tr2.HitPos.x
	self.minposx = self.tr.HitPos.x
	self.maxposz = self.tr3.HitPos.z
	self.minposz = self.tr4.HitPos.z
	if(GetData( self:GetQuest().."startFirMis")!=nil)then
		RemoveData( self:GetQuest().."startFirMis")
	end
end

 function ENT:OnTakeDamage(dmg)
	local ply = dmg:GetAttacker()
	if(ply==self.player)then
		if(dmg:IsBulletDamage())then
			self.OurHealth = self.OurHealth - 1
			if(self.OurHealth <= 0) then -- If our health-variable is zero or below it
				self:Remove(); -- Remove our entity
				local ent = Entity(tonumber(ply:GetPData("last_npc_id")))
				ply:SetPData("npc_"..ent:GetQuest().."make","1")
				SendInfoOnCL(ply,ent)
				DarkRP.notify(ply, 0, 5, "Вы выполнили задание! Возвращайтесь за наградой." )
				if(GetData( ent:GetQuest().."startFirMis")!=nil)then
					RemoveData( ent:GetQuest().."startFirMis")
				end
				if(timer.Exists( "msgtext21" ))then
					timer.Remove( "msgtext21" )
				end
			else
				DarkRP.notify(ply, 0, 5, "Попадание! Осталось "..self.OurHealth.." раз." )
			end
		end
	else
		DarkRP.notify(dmg:GetAttacker(), 0, 5, "Сейчас данное задание выполняет другой человек!" )
	end
 end

function ENT:Think()
	local getps = self:GetPos() 
	local pos = Vector((self.maxposx+self.minposx)/2+(self.maxposx-self.minposx)*math.sin(CurTime()*self.speedx)/2.5,(self.maxposy+self.minposy+self.minposy/self.psz)/2+(self.maxposy-self.minposy)*math.cos(CurTime()*self.speedy)/5.5,(self.maxposz+self.minposz)/2+(self.maxposz-self.minposz)*math.sin(CurTime()*7*self.speedz)/2.5)
	self:SetPos(pos)
	
	local physObj = self:GetPhysicsObject()

	if (IsValid(physObj)) then
		physObj:EnableMotion(false)
		end
	self:NextThink( CurTime() )
	
	return true
end