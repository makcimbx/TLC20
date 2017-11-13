AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
include('cl_init.lua')
 
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 18
	
	local ent = ents.Create("ammo_map_box")
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
	if(self.UnlimitedAmmo==false)then
		self:SetNWInt( "Ammo", m_ammo );
		self.Think = function()
			if(self:GetNWInt( "Ammo" )<self.m_ammo)then
				self:SetNWInt( "Ammo", math.Clamp( self:GetNWInt( "Ammo" ) + 1*self.recharge_multiplayer, 0, self.m_ammo )  )
			end
			self:NextThink( CurTime() + 1/self.recharge_rate )
			return true
		end
	end
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
	self:SetNWInt( "Ammo", math.Clamp( self:GetNWInt( "Ammo" )+371, 0, self.m_ammo )  )
	self.Entity:TakePhysicsDamage(dmginfo)
end

function ENT:Use(activator, caller)
	if (activator:IsPlayer()) then
		local a = 0
		if (self.UnlimitedAmmo == false) then
			for k,v in pairs(self.Ammo)do
				local ac = activator:GetAmmoCount( v.name )
				if(ac<v.max)then
					if(ac+self.t_ammo<v.max)then
						a=a+1
						local targammo = self.t_ammo
						if(self:GetNWInt( "Ammo" )-targammo<0)then targammo = self:GetNWInt( "Ammo" ) end
						activator:GiveAmmo(targammo,v.name)
						self:SetNWInt( "Ammo", math.Clamp( self:GetNWInt( "Ammo" )-targammo, 0, self.m_ammo )  )
						if(self:GetNWInt( "Ammo" )<=0)then break end
					else
						a=a+1
						local targammo = v.max-ac
						if(self:GetNWInt( "Ammo" )-targammo<0)then targammo = self:GetNWInt( "Ammo" ) end
						activator:GiveAmmo(targammo,v.name)
						self:SetNWInt( "Ammo", math.Clamp( self:GetNWInt( "Ammo" )-targammo, 0, self.m_ammo )  )
						if(self:GetNWInt( "Ammo" )<=0)then break end
					end
				end
			end
		else
			for k,v in pairs(self.Ammo)do
				local ac = activator:GetAmmoCount( v.name )
				if(ac<v.max)then
					a=a+1
					if(ac+self.t_ammo<v.max)then
						activator:GiveAmmo(self.t_ammo,v.name)
					else
						activator:GiveAmmo(v.max-ac,v.name)
					end
				end
			end
		end
		if(a==0)then DarkRP.notify(activator, 1, 4, "Ты не можешь взять больше!") end
	end
end

