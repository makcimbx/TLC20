
--[[-------------------------------------------------------------------
	Advanced Lightsaber Combat Base:
		An intuitively designed lightsaber combat base.
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

include( "shared.lua" )

function SWEP:DoLight()

	local stance = self:GetStance()
	local form = wOS.Form.LocalizedForms[ self:GetForm() ]
	
	if not form then 
		print( "[wOS] Invalid form! Animations will not operate properly!"  )
		self:SetDelay( 0 ) 
		return 
	end
	
	local formdata = wOS.Form.Duals[ form ][ stance ]
	local movedata = formdata[ "light_forward" ]
	local time
	
	if self.Owner:KeyDown(IN_MOVELEFT) then 
		movedata = formdata[ "light_left" ]
	elseif self.Owner:KeyDown(IN_MOVERIGHT) then 
		movedata = formdata[ "light_right" ]
	end
	
	if not movedata then
		print( "[wOS] Invalid move data for form: " .. form .. "!"  )
		self:SetDelay( 0 ) 
		return 	
	end
	
	local time = self.Owner:SetSequenceOverride( movedata[ "Sequence" ], movedata[ "Time" ], movedata[ "Rate" ] ) or 0.5
	
	if wOS.EnableLunge then
		local force = self.Owner:GetAimVector() * 500 
		force.z = 0; 
		self.Owner:SetVelocity( force ) 
	end
	
	if not self.CanMoveWhileAttacking then
		self.Owner:SetNWFloat( "SWL_FeatherFall", CurTime() + time )
	end	
	
	time = time or 0.5
	self:SetDelay( time )
	
end

function SWEP:DoAerial()

	local stance = self:GetStance()
	local form = wOS.Form.LocalizedForms[ self:GetForm() ]
	
	if not form then 
		print( "[wOS] Invalid form! Animations will not operate properly!"  )
		self:SetDelay( 0 ) 
		return 
	end
	
	local formdata = wOS.Form.Duals[ form ][ stance ]
	local movedata = formdata[ "air_forward" ]
	local time
	
	if self.Owner:KeyDown(IN_MOVELEFT) then 
		movedata = formdata[ "air_left" ]
	elseif self.Owner:KeyDown(IN_MOVERIGHT) then 
		movedata = formdata[ "air_right" ]
	end
	
	if not movedata then
		print( "[wOS] Invalid move data for form: " .. form .. "!"  )
		self:SetDelay( 0 ) 
		return 	
	end
	
	local time = self.Owner:SetSequenceOverride( movedata[ "Sequence" ], movedata[ "Time" ], movedata[ "Rate" ] ) or 0.5
	
	time = time or 0.5
	self:SetDelay( time )
	
	
end

function SWEP:DataTableInit()

	self:SetBladeLength( 0 )
	self:SetBladeWidth( 2 )
	self:SetMaxLength( 42 )
	self:SetSecBladeLength( 0 )
	self:SetSecBladeWidth( 2 )
	self:SetSecMaxLength( 42 )
	self:SetSecDarkInner( false )
	self:SetDarkInner( false )
	self:SetWorksUnderwater( true )
	self:SetEnabled( true )

	self:SetOnSound( "lightsaber/saber_on" .. math.random( 1, 4 ) .. ".wav" )
	self:SetOffSound( "lightsaber/saber_off" .. math.random( 1, 4 ) .. ".wav" )
	self:SetWorldModel( "models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl" )
	self:SetSecWorldModel( "models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl" )	
	self:SetCrystalColor( Vector( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ) ) )
	self:SetSecCrystalColor( Vector( math.random( 0, 255 ), math.random( 0, 255 ), math.random( 0, 255 ) ) )
	self:SetForceType( 1 )
	self:SetDevestatorType( 1 )
	self:SetForce( 100 )

	self:NetworkVarNotify( "Force", self.OnForceChanged )
	self:NetworkVarNotify( "Enabled", self.OnEnabledOrDisabled )
	
end

function SWEP:StanceUpdate()
	self.StancePos = self.StancePos + 1
	if self.StancePos > #self.Stances[ self:GetForm() ] then
		self.StancePos = 1
	end
	self.CurStance = self.Stances[ self:GetForm() ][ self.StancePos ]
	self:SetStance( self.CurStance )
end

function SWEP:PerformHeavyAttack()

	if wOS.EnableStamina then
		if not self.Owner:CanUseStamina( true ) then return end
	end
	
	local stance = self:GetStance()
	local form = wOS.Form.LocalizedForms[ self:GetForm() ]
	
	if not form then 
		print( "[wOS] Invalid form! Animations will not operate properly!"  )
		self:SetDelay( 0 ) 
		return 
	end
	
	local formdata = wOS.Form.Duals[ form ][ stance ]
	local movedata = formdata[ "heavy" ]
	local time = self.Owner:SetSequenceOverride( movedata[ "Sequence" ], movedata[ "Time" ], movedata[ "Rate" ] ) or 2

	
	self:SetFPCamTime( CurTime() + time )
	self:SetNextAttack( time )
	if wOS.EnableStamina then
		self.Owner:AddStamina( -1*wOS.HeavyCost )
	end
	self.Owner:SetNWFloat( "SWL_HeavyAttackTime", CurTime() + time )
	if not self.CanMoveWhileAttacking then
		self.Owner:SetNWFloat( "SWL_FeatherFall", CurTime() + time )
	end
end

function SWEP:SetStandard()

	local ply = self.Owner
	
	local group = ply:GetUserGroup()
	self:SetNWBool( "SWL_CustomAnimCheck", false )
	self.Stances = {}
	self.Forms = {}
	self.StancePos = 1
	self.FormPos = 1
	self:SetNWInt( "Stance", 1 )
	if self.UseForms then
		for form, stances in pairs( self.UseForms ) do
			self.Forms[ #self.Forms + 1 ] = form
			local index = wOS.Form.IndexedForms[ form ]
			self:SetForm( index )
			self.Stances[ index ] = {}
			for _, num in pairs( stances ) do
				self:SetStance( num )
				table.insert( self.Stances[ index ], num )					
			end
		end
	else
		if table.HasValue( wOS.AllAccessForms, group ) then
			for form, _ in pairs( wOS.DualForms ) do
				self.Forms[ #self.Forms + 1 ] = form
				local index = wOS.Form.IndexedForms[ form ]
				self:SetForm( index )
				self.Stances[ index ] = { 1, 2, 3 }
			end		
			self:SetStance( 1 )
		else
			for form, _ in pairs( wOS.Forms ) do

				if wOS.DualForms[ form ][ group ] then
					local entry = wOS.DualForms[ form ][ group ]
					local index = wOS.Form.IndexedForms[ form ]
					self.Forms[ #self.Forms + 1 ] = form
					self:SetForm( index )					
					self.Stances[ index ] = {}
					for _, num in pairs( entry ) do
						self:SetStance( num )
						table.insert( self.Stances[ index ], num )
					end
				end
			end
		end
	end
	
	if table.Count( self.Stances ) > 0 and table.Count( self.Forms ) > 0 then
		self:SetNWBool( "SWL_CustomAnimCheck", true )
		self:SetNWInt("Stance", self.Stances[ self:GetForm() ][1] )
	end
	
end

function SWEP:ServerThoughts()

	if !self.Owner.IsBlocking and self.Owner:KeyDown( IN_USE ) and self.Owner:KeyDown( IN_ATTACK2 ) and self:GetEnabled() and self:GetNWBool( "SWL_CustomAnimCheck", false ) and !( prone and self.Owner:IsProne() ) and !self.HeavyCharge then
		self.HeavyCharge = 0
	end
	
	if ( CLIENT ) then return true end
	
	wOS.LightsaberHook.HeavyCharge( self )


	if ( ( self.NextForce or 0 ) < CurTime() ) then
		self:SetForce( math.min( self:GetForce() + ( 0.5*self.RegenSpeed ), self.MaxForce ) )
	end

	if ( !self:GetEnabled() && self:GetBladeLength() != 0 ) then
		self:SetBladeLength( math.Approach( self:GetBladeLength(), 0, 2 ) )
	elseif ( self:GetEnabled() && self:GetBladeLength() != self:GetMaxLength() ) then
		self:SetBladeLength( math.Approach( self:GetBladeLength(), self:GetMaxLength(), 8 ) )
	end

	if ( self:GetEnabled() && !self:GetWorksUnderwater() && self.Owner:WaterLevel() > 2 ) then
		self:SetEnabled( false )
		--self:EmitSound( self:GetOffSound() )
	end
	
	if ( !self:GetEnabled() && self:GetSecBladeLength() != 0 ) then
		self:SetSecBladeLength( math.Approach( self:GetSecBladeLength(), 0, 2 ) )
	elseif ( self:GetEnabled() && self:GetSecBladeLength() != self:GetSecMaxLength() ) then
		self:SetSecBladeLength( math.Approach( self:GetSecBladeLength(), self:GetSecMaxLength(), 8 ) )
	end

	if ( self:GetBladeLength() <= 0 ) then return end
	
	local pos, ang = self:GetSaberPosAng()
	

	if !wOS.MinimalLightsabers or self:GetNextPrimaryFire() >= CurTime() then
	
	-- ------------------------------------------------- DAMAGE ------------------------------------------------- --

		-- This whole system needs rework

		-- Up
		local isTrace1Hit = false
		local pos, ang = self:GetSaberPosAng()
		local trace = util.TraceLine( {
			start = pos,
			endpos = pos + ang * self:GetBladeLength(),
			filter = { self, self.Owner },
			--mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
			--maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
		} )
		local traceBack = util.TraceLine( {
			start = pos + ang * self:GetBladeLength(),
			endpos = pos,
			filter = { self, self.Owner },
			--mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
			--maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
		} )

		--if ( SERVER ) then debugoverlay.Line( trace.StartPos, trace.HitPos, .1, Color( 255, 0, 0 ), false ) end

		-- When the blade is outside of the world
		if ( trace.HitSky or ( trace.StartSolid && trace.HitWorld ) ) then trace.Hit = false end
		if ( traceBack.HitSky or ( traceBack.StartSolid && traceBack.HitWorld ) ) then traceBack.Hit = false end

		self:DrawHitEffects( trace, traceBack )
		isTrace1Hit = trace.Hit or traceBack.Hit

		-- Don't deal the damage twice to the same entity
		if ( traceBack.Entity == trace.Entity && IsValid( trace.Entity ) ) then traceBack.Hit = false end

		if ( trace.Hit ) then rb655_LS_DoDamage( trace, self ) end
		if ( traceBack.Hit ) then rb655_LS_DoDamage( traceBack, self ) end

		-- Down
		local isTrace2Hit = false
		if ( self:LookupAttachment( "blade2" ) > 0 ) then -- TEST ME
			local pos2, dir2 = self:GetSaberPosAng( 2 )
			local trace2 = util.TraceLine( {
				start = pos2,
				endpos = pos2 + dir2 * self:GetBladeLength(),
				filter = { self, self.Owner },
				--mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
				--maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
			} )
			local traceBack2 = util.TraceLine( {
				start = pos2 + dir2 * self:GetBladeLength(),
				endpos = pos2,
				filter = { self, self.Owner },
				--mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
				--maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
			} )

			if ( trace2.HitSky or ( trace2.StartSolid && trace2.HitWorld ) ) then trace2.Hit = false end
			if ( traceBack2.HitSky or ( traceBack2.StartSolid && traceBack2.HitWorld ) ) then traceBack2.Hit = false end

			self:DrawHitEffects( trace2, traceBack2 )
			isTrace2Hit = trace2.Hit or traceBack2.Hit

			if ( traceBack2.Entity == trace2.Entity && IsValid( trace2.Entity ) ) then traceBack2.Hit = false end

			if ( trace2.Hit ) then rb655_LS_DoDamage( trace2, self ) end
			if ( traceBack2.Hit ) then rb655_LS_DoDamage( traceBack2, self ) end

		end

		if ( ( isTrace1Hit or isTrace2Hit ) && self.SoundHit ) then
			self.SoundHit:ChangeVolume( math.Rand( 0.1, 0.5 ), 0 )
		elseif ( self.SoundHit ) then
			self.SoundHit:ChangeVolume( 0, 0 )
		end
		local isTrace3Hit = false
		local isTrace4Hit = false
		if true then
			local pos, ang = self:GetSaberSecPosAng()
			if self.Owner.DualWielded then
				pos, ang = self:GetSaberSecPosAng( nil, nil, self.Owner.DualWielded )
			end
			local trace = util.TraceLine( {
				start = pos,
				endpos = pos + ang * self:GetSecBladeLength(),
				filter = { self, self.Owner, ( self.Owner.DualWielded and self.Owner.DualWielded ) },
				//mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
				//maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
			} )
			local traceBack = util.TraceLine( {
				start = pos + ang * self:GetSecBladeLength(),
				endpos = pos,
				filter = { self, self.Owner, ( self.Owner.DualWielded and self.Owner.DualWielded ) },
				//mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
				//maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
			} )

			if ( SERVER ) then debugoverlay.Line( trace.StartPos, trace.HitPos, .1, Color( 255, 0, 0 ), false ) end

			if ( trace.HitSky || trace.StartSolid ) then trace.Hit = false end
			if ( traceBack.HitSky || traceBack.StartSolid ) then traceBack.Hit = false end

			self:DrawHitEffects( trace, traceBack )
			isTrace3Hit = trace.Hit || traceBack.Hit

			// Don't deal the damage twice to the same entity
			if ( traceBack.Entity == trace.Entity && IsValid( trace.Entity ) ) then traceBack.Hit = false end

			if ( trace.Hit ) then rb655_LS_DoDamage( trace, self ) end
			if ( traceBack.Hit ) then rb655_LS_DoDamage( traceBack, self ) end

			-- Down
			if ( self:GetSecWorldModel():find( "staff" ) ) then -- TEST ME
				local pos2, dir2 = self:GetSaberSecPosAng( 2 )
				local trace2 = util.TraceLine( {
					start = pos2,
					endpos = pos2 + dir2 * self:GetSecBladeLength(),
					filter = { self, self.Owner, ( self.Owner.DualWielded and self.Owner.DualWielded ) },
					//mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
					//maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
				} )
				local traceBack2 = util.TraceLine( {
					start = pos2 + dir2 * self:GetSecBladeLength(),
					endpos = pos2,
					filter = { self, self.Owner, ( self.Owner.DualWielded and self.Owner.DualWielded ) },
					//mins = Vector( -1, -1, -1 ) * self:GetBladeWidth() / 8,
					//maxs = Vector( 1, 1, 1 ) * self:GetBladeWidth() / 8
				} )

				if ( trace2.HitSky || trace2.StartSolid ) then trace2.Hit = false end
				if ( traceBack2.HitSky || traceBack2.StartSolid ) then traceBack2.Hit = false end

				self:DrawHitEffects( trace2, traceBack2 )
				isTrace4Hit = trace2.Hit || traceBack2.Hit

				if ( traceBack2.Entity == trace2.Entity && IsValid( trace2.Entity ) ) then traceBack2.Hit = false end

				if ( trace2.Hit ) then rb655_LS_DoDamage( trace2, self ) end
				if ( traceBack2.Hit ) then rb655_LS_DoDamage( traceBack2, self ) end

			end
			
			if ( ( isTrace3Hit or isTrace4Hit ) && self.SoundHit ) then
				self.SoundHit:ChangeVolume( math.Rand( 0.1, 0.5 ), 0 )
			elseif ( self.SoundHit ) then
				self.SoundHit:ChangeVolume( 0, 0 )
			end
		end
		
		if ( ( isTrace1Hit or isTrace2Hit or isTrace3Hit or isTrace4Hit  ) && self.SoundHit ) then
			self.SoundHit:ChangeVolume( math.Rand( 0.1, 0.5 ), 0 )
		elseif ( self.SoundHit ) then
			self.SoundHit:ChangeVolume( 0, 0 )
		end
	
	end
	
	-- ------------------------------------------------- SOUNDS ------------------------------------------------- --
	
	if ( self.SoundSwing ) then

		if ( self.LastAng != ang ) then
			self.LastAng = self.LastAng or ang
			self.SoundSwing:ChangeVolume( math.Clamp( ang:Distance( self.LastAng ) / 2, 0, 1 ), 0 )
		end

		self.LastAng = ang
	end

	if ( self.SoundLoop ) then
		pos = pos + ang * self:GetBladeLength()

		if ( self.LastPos != pos ) then
			self.LastPos = self.LastPos or pos
			self.SoundLoop:ChangeVolume( 0.1 + math.Clamp( pos:Distance( self.LastPos ) / 128, 0, 0.2 ), 0 )
		end
		self.LastPos = pos
	end
	
end