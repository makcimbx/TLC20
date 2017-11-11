AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
include('cl_init.lua')
 
function ENT:SpawnFunction(ply, tr)

	if (!tr.Hit) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 18
	
	local ent = ents.Create("touch_pickup_752_ammo_map_box")
	ent:SetPos(SpawnPos)
	local ang = ply:EyeAngles()
	ang.p = 0
	ang:RotateAroundAxis( ang:Up(), 180 )
	ent:SetAngles( ang )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

local m_ammo = 600000
local t_ammo = 600
function ENT:Initialize()

	self:SetNWInt( "Ammo", m_ammo );
	self.Entity:SetModel("models/Items/ammocrate_smg1.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:DrawShadow(false)
	
	local phys = self.Entity:GetPhysicsObject()
	
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.Entity:SetUseType(SIMPLE_USE)
	
	timer.Create( tostring(math.random( 1, 999999999999 )), 0.1, 0, function()
	self:SetNWInt( "Ammo", math.Clamp( self:GetNWInt( "Ammo" ) + t_ammo/100, 0, m_ammo )  )
	end )
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
end
