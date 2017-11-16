
--[[-------------------------------------------------------------------
	Lightsaber Devestators:
		The available powers that the new saber base uses.
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--

wOS = wOS or {}

wOS.AvailableDevestators = { 	
	["Kyber Slam"] = {
		name = "Kyber Slam",
		action = function( self )
			if self.UltimateCooldown and self.UltimateCooldown >= CurTime() then return end
			self:SetForce( 0 )
			self:SetNextAttack( 10 )
			self.Owner:SetVelocity( Vector( 0, 0, 300 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.Owner:SetSequenceOverride( "ryoku_a_s1_charge", 0 )
			self.Owner:SetNWFloat( "SWL_FeatherFall", CurTime() + 5 )
			self.Owner:SetNWFloat( "wOS.DevestatorTime", CurTime() + 5 )
			self.Owner.KyberSlam = true
		end
	},
	["Lightning Coil"] = {
		name = "Lightning Coil",
		action = function( self )
			if self.UltimateCooldown and self.UltimateCooldown >= CurTime() then return end
			self:SetForce( 0 )
			self:SetNextAttack( 10 )
			self.Owner:SetVelocity( Vector( 0, 0, 500 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.Owner:SetSequenceOverride( "vanguard_a_s1_t1", 0 )
			self.Owner:SetNWFloat( "SWL_FeatherFall", CurTime() + 5 )
			self.Owner:SetNWFloat( "wOS.DevestatorTime", CurTime() + 5 )
			timer.Simple( 0.5, function()
				if not IsValid( self ) then return end
				if not self.Owner then return end
				if not self.Owner:Alive() then return end
				local coil = ents.Create( "wos_lightning_coil" )
				coil:SetPos( self.Owner:GetPos() )
				coil:Spawn()
				coil:SetOwner( self.Owner )
				self.Owner:SetSequenceOverride( "judge_a_right_charge", 0 )
				self:SetNextAttack( 5 )			
				self.UltimateCooldown = CurTime() + 5		
				return					
			end )
		end
	},
	["Sonic Discharge"] = {
		name = "Sonic Discharge",
		action = function( self )
			if self.UltimateCooldown and self.UltimateCooldown >= CurTime() then return end
			self:SetForce( 0 )
			self:SetNextAttack( 10 )
			self.Owner:SetVelocity( Vector( 0, 0, 300 ) )
			self:PlayWeaponSound( "lightsaber/force_leap.wav" )
			self.Owner:SetSequenceOverride( "vanguard_a_s1_t1", 0 )
			self.Owner:SetNWFloat( "SWL_FeatherFall", CurTime() + 5 )
			self.Owner:SetNWFloat( "wOS.DevestatorTime", CurTime() + 5 )
			timer.Simple( 0.3, function()
				if not IsValid( self ) then return end
				if not self.Owner then return end
				if not self.Owner:Alive() then return end
				local coil = ents.Create( "wos_sonic_discharge" )
				coil:SetPos( self.Owner:GetPos() )
				coil:Spawn()
				coil:SetOwner( self.Owner )
				self.Owner:SetSequenceOverride( "judge_a_right_charge", 0 )
				self:SetNextAttack( 5 )			
				self.UltimateCooldown = CurTime() + 5		
				return					
			end )
		end
	},
}
