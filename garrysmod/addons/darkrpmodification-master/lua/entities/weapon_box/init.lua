AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
 
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 18
	
	local ent = ents.Create("weapon_box")
	ent:SetPos(SpawnPos)
	local ang = ply:EyeAngles()
	ang.p = 0
	ang:RotateAroundAxis( ang:Up(), 180 )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel(self.model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:PhysicsCollide(data, physobj)
	if (data.Speed > 80 and data.DeltaTime > 0.2) then
		self.Entity:EmitSound("Default.ImpactSoft")
	end
end

function ENT:OnTakeDamage(dmginfo)

	self.Entity:TakePhysicsDamage(dmginfo)
end

local nextuse = 0

function ENT:Use(activator, caller)
	if (activator:IsPlayer() and nextuse<CurTime()) then
		nextuse = CurTime()+1
		BOX_PlayerLoadout(activator)
	end
end
