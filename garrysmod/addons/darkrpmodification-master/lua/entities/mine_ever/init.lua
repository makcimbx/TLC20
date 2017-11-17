AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
include('cl_init.lua')

function ENT:Initialize()
	self.maxhp = 100
	self.hp = self.maxhp
	--self.ship = nil
	--self.right = false
	self.dead = false

	self:SetModel( "models/hunter/misc/sphere175x175.mdl" )

	self:SetSolid( SOLID_VPHYSICS ) -- Setting the solidity
	self:SetMoveType( MOVETYPE_NONE ) -- Setting the movement type
end

function ENT:OnTakeDamage( damage )
	
	self.hp = self.hp-damage:GetDamage()
	if(self.hp<=0 && self.dead == false)then
		self:Dead(damage:GetAttacker())
	end
end

function ENT:Use( activator, caller, useType, value )
	if(self.dead == false)then
		self.ship:GunnerEnter(activator,self.right)
	end
end

function ENT:Think()
	if(self.right == true)then
		self:SetNWBool("suka",true)
	end
end

function ENT:OnRemove()
	self.ship:Remove()
end

function ENT:Dead(k)
	self.dead = true
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	util.Effect( "HelicopterMegaBomb", effectdata )
	if(self.right)then
		if(IsValid(self.ship.RightGunner))then
			local p = self.ship.RightGunner
			p:TakeDamage( p:Health()*2, k, nil )
		end
	else
		if(IsValid(self.ship.LeftGunner))then
			local p = self.ship.LeftGunner
			p:TakeDamage( p:Health()*2, k, nil )
		end
	end
end