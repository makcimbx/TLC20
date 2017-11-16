
--[[-------------------------------------------------------------------
	Lightsaber Force Powers:
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

wOS.AvailablePowers = { 
	["Force Leap"] = {
		name = "Force Leap",
		icon = "L",
		image = "wos/forceicons/leap",
		description = "Jump longer and higher. Aim higher to jump higher/further",
	},
	["Charge"] = {
			name = "Charge",
			icon = "CH",
			distance = 600,
			image = "wos/forceicons/charge",
			target = 1,
			description = "Lunge at your enemy",
			action = function( self )
				local ent = self:SelectTargets( 1, 600 )[ 1 ]
				if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
				if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
				self.Owner:SetSequenceOverride( "phalanx_a_s2_t1", 5 )					
				self:SetNextAttack( 1 )
				self.AerialLand = true
			end,
	},
	["Force Absorb"] = {
		name = "Force Absorb",
		icon = "A",
		image = "wos/forceicons/absorb",
		description = "Hold Mouse 2 to protect yourself from harm",
	},	
	["Saber Throw"] = {
		name = "Saber Throw",
		icon = "T",
		image = "wos/forceicons/throw",
		description = "Throws your lightsaber. It will return to you.",
		action = function(self)
			if self:GetForce() < 20 then return end
			self:SetForce( self:GetForce() - 20 )
			self:SetEnabled(false)
			self:SetBladeLength(0)
		end
	}, 
	["Force Heal"] = {
		name = "Force Heal",
		icon = "H",
		image = "wos/forceicons/heal",
		target = 1,
		description = "Heals your target.",
	}, 
	["Group Heal"] = {
		name = "Group Heal",
		icon = "GH",
		image = "wos/forceicons/group_heal",
		description = "Heals all around you.",
	}, 
	
	[ "Cloak" ] = {
		name = "Cloak",
		icon = "C",
		image = "wos/forceicons/cloak",
		description = "Shrowd yourself with the force for 10 seconds",
	},
	[ "Force Reflect" ] = {
		name = "Force Reflect",
		icon = "FR",
		image = "wos/forceicons/reflect",
		description = "An eye for an eye",
	},
	[ "Rage" ] = {
		name = "Rage",
		icon = "RA",
		image = "wos/forceicons/reflect",
		description = "Unleash your anger",
	},
	["Shadow Strike" ] = {
		name = "Shadow Strike",
		icon = "SS",
		distance = 30,
		image = "wos/forceicons/shadow_strike",
		target = 1,
		description = "From the darkness it preys",
		action = function( self )
			if self.Owner:GetNWFloat( "CloakTime", 0 ) < CurTime() then return end
			local ent = self:SelectTargets( 1, 30 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 50 ) then self:SetNextAttack( 0.2 ) return end
			self.Owner:SetSequenceOverride("b_c3_t2", 1)	
		end
	},
	[ "Force Pull" ] = {
		name = "Force Pull",
		icon = "PL",
		target = 1,
		description = "Get over here!",
	},
	[ "Force Push" ] = {
		name = "Force Push",
		icon = "PH",
		target = 1,
		distance = 150,
		description = "They are no harm at a distance",
	},
	["Lightning Strike" ] = {
		name = "Lightning Strike",
		icon = "LS",
		distance = 600,
		image = "wos/forceicons/lightning_strike",
		target = 1,
		description = "A focused charge of lightning",
		action = function( self )
			local ent = self:SelectTargets( 1, 600 )[ 1 ]
			if !IsValid( ent ) then self:SetNextAttack( 0.2 ) return end
			if ( self:GetForce() < 20 ) then self:SetNextAttack( 0.2 ) return end
			local bullet = {}
			bullet.Num 		= 1
			bullet.Src 		= self.Owner:GetPos() + Vector( 0, 0, 10 )	
			bullet.Dir 		= ( ent:GetPos() - ( self.Owner:GetPos() + Vector( 0, 0, 10 ) ) )
			bullet.Spread 	= 0		
			bullet.Tracer	= 1
			bullet.Force	= 0						
			bullet.Damage	= 0
			bullet.AmmoType = "Pistol"
			bullet.Entity = self.Owner
			bullet.TracerName = "thor_thunder"

			self.Owner:FireBullets( bullet )
		end
	},
	["Advanced Cloak" ] = {
		name = "Advanced Cloak",
		icon = "AC",
		image = "wos/forceicons/advanced_cloak",
		description = "Shrowd yourself with the force for 25 seconds",
	},
	["Force Lightning"] = {
		name = "Force Lightning",
		icon = "L",
		target = 1,
		image = "wos/forceicons/lightning",
		description = "Torture people ( and monsters ) at will.",
	},
	[ "Force Combust" ] = {
		name = "Force Combust",
		icon = "C",
		target = 1,
		description = "Ignite stuff infront of you.",
	},
	["Force Repulse"] = {
		name = "Force Repulse",
		icon = "R",
		description = "Hold to charge for greater distance/damage. Kill everybody close to you. Push back everybody who is a bit farther away but still close enough.",
		think = function( self )
			if ( self:GetNextSecondaryFire() > CurTime() ) then return end
		end
	},
	["Storm"] = {
		name = "Storm",
		icon = "STR",
		description = "Charge for 2 seconds, unleash a storm on your enemies",
		action = function( self )
			if ( self:GetForce() < 100 ) then self:SetNextAttack( 0.2 ) return end
			if self.Owner:GetNWFloat( "SWL_FeatherFall", 0 ) >= CurTime() then return end
			local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
			local pos = tr.HitPos + Vector( 0, 0, 600 )		
			local pi = math.pi
			local bullet = {}
			bullet.Num 		= 1
			bullet.Spread 	= 0		
			bullet.Tracer	= 1
			bullet.Force	= 0						
			bullet.Damage	= 500
			bullet.AmmoType = "Pistol"
			bullet.Entity = self.Owner
			bullet.TracerName = "thor_storm"
			timer.Simple( 2, function()
				if not IsValid( self.Owner ) then return end
				self.Owner:EmitSound( Sound( "ambient/atmosphere/thunder1.wav" ) )
				bullet.Src 		= pos
				bullet.Dir 		= Vector( 0, 0, -1 )
				self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
				self.Owner:FireBullets( bullet )
				timer.Simple( 0.1, function() 
					if not IsValid( self.Owner ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*2/5 ), 65*math.cos( pi*2/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
					self.Owner:FireBullets( bullet )			
				end )
				timer.Simple( 0.2, function() 
					if not IsValid( self.Owner ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*4/5 ), 65*math.cos( pi*4/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
					self.Owner:FireBullets( bullet )				
				end )
				timer.Simple( 0.3, function()
					if not IsValid( self.Owner ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*6/5 ), 65*math.cos( pi*6/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
					self.Owner:FireBullets( bullet )					
				end )
				timer.Simple( 0.4, function() 
					if not IsValid( self.Owner ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( pi*8/5 ), 65*math.cos( pi*8/5 ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
					self.Owner:FireBullets( bullet )					
				end )
				timer.Simple( 0.5, function() 
					if not IsValid( self.Owner ) then return end
					bullet.Src 		= pos + Vector( 65*math.sin( 2*pi ), 65*math.cos( 2*pi ), 0 )
					bullet.Dir 		= Vector( 0, 0, -1 )
					self.Owner:EmitSound( Sound( "npc/strider/fire.wav" ) )
					self.Owner:FireBullets( bullet )					
				end )
			end )
		end
	},
	["Meditate"] = {
		name = "Meditate",
		icon = "M",
		description = "Relax yourself and channel your energy",
		think = function( self )
			if self.MeditateCooldown and self.MeditateCooldown >= CurTime() then return end
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self.Owner:OnGround() then
				if !self._ForceMeditating then
					self.Owner.SaveAngles = self.Owner:GetAngles()
				end
				self._ForceMeditating = true
			else
				self._ForceMeditating = false
				self._NextMeditateHeal = 0
			end
			if self.Owner:KeyReleased( IN_ATTACK2 ) then
				self.MeditateCooldown = CurTime() + 3
			end
		end
	},
	["Channel Hatred"] = {
		name = "Channel Hatred",
		icon = "HT",
		description = "I can feel your anger",
		think = function( self )
			if self.ChannelCooldown and self.ChannelCooldown >= CurTime() then return end
			if ( self.Owner:KeyDown( IN_ATTACK2 ) ) and !self:GetEnabled() and self.Owner:OnGround() then
				self._ForceChanneling = true
			else
				self._ForceChanneling = false
			end
			if self.Owner:KeyReleased( IN_ATTACK2 ) then
				self.ChannelCooldown = CurTime() + 3
			end
		end
	},
}
