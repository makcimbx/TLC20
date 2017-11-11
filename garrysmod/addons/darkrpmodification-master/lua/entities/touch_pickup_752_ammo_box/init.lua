AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
include('cl_init.lua')
 
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	
	local ent = ents.Create("touch_pickup_752_ammo_box")
	ent:SetPos(SpawnPos)
	local ang = ply:EyeAngles()
	ang.p = 0
	--ang:RotateAroundAxis( ang:Forward(), -90 )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

local m_ammo = 6000
local t_ammo = 600
function ENT:Initialize()

	self:SetNWInt( "Ammo", m_ammo );
	self.Entity:SetModel("models/Items/BoxMRounds.mdl")
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
	--self.Entity:EmitSound("starwars/items/bacta.wav")
	if (activator:IsPlayer() and self:GetNWInt( "Ammo" )>0) then
		if not(activator:GetAmmoCount( "pistol" )==9999 or activator:GetAmmoCount( "ar2" )==9999 or activator:GetAmmoCount( "rpg" )==9999 or activator:GetAmmoCount( "357" )==9999)then
			local ammo = 0
			if((self:GetNWInt( "Ammo" )-t_ammo)>=0)then
				ammo=t_ammo
				self:SetNWInt( "Ammo", self:GetNWInt( "Ammo" )-t_ammo )
			else
				ammo=self:GetNWInt( "Ammo" )
				self:SetNWInt( "Ammo", 0 )
			end
			activator:GiveAmmo(ammo,"pistol")
			activator:GiveAmmo(ammo,"ar2")
			activator:GiveAmmo(ammo,"RPG_Round")
			activator:GiveAmmo(ammo,"357")
		else
			DarkRP.notify(activator, 1, 4, "Ты не можешь взять больше!")
		end
	end
	if (self:GetNWInt( "Ammo" )<0 or self:GetNWInt( "Ammo" )==0)then self.Entity:Remove() end
end