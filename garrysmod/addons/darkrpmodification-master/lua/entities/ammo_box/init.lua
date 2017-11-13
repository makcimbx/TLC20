AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
include('cl_init.lua')
 
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("ammo_box")
	ent:SetPos(SpawnPos)
	local ang = ply:EyeAngles()
	ang.p = 0
	--ang:RotateAroundAxis( ang:Forward(), -90 )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self:SetNWInt( "Ammo", self.m_ammo );
	self.Entity:SetModel(self.model)
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	self.Entity:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	
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

function ENT:Use(activator, caller)
	if (activator:IsPlayer()) then
		local a = 0 
		for k,v in pairs(self.Ammo)do
			local ac = activator:GetAmmoCount( v.name )
			if(ac<v.max)then
				a=a+1
				if(ac+self.t_ammo<v.max)then
					self:SetNWInt( "Ammo",self:GetNWInt( "Ammo" )-self.t_ammo )
					activator:GiveAmmo(self.t_ammo,v.name)
					if(self:GetNWInt( "Ammo" )<=0)then self.Entity:Remove() end
				else
					self:SetNWInt( "Ammo",self:GetNWInt( "Ammo" )-(v.max-ac) )
					activator:GiveAmmo(v.max-ac,v.name)
					if(self:GetNWInt( "Ammo" )<=0)then self.Entity:Remove() end
				end
			end
		end
		if(a==0)then DarkRP.notify(activator, 1, 4, "Ты не можешь взять больше!") end
		if (self:GetNWInt( "Ammo" )<=0)then self.Entity:Remove() end
	end
end