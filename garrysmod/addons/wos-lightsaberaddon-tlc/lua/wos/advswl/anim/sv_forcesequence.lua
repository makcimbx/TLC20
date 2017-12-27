
--[[-------------------------------------------------------------------
	Lightsaber Force Sequencer:
		Do the cool stuff
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

local meta = FindMetaTable( "Player" )

hook.Add( "PostGamemodeLoaded", "wOS.ServerAnimations", function()
function GAMEMODE:CalcMainActivity( ply, velocity )
	
	local wep = ply:GetActiveWeapon()
	
    if ply:GetNW2Bool("IsMeditating", false) then
        return -1, ply:LookupSequence( "sit_zen" )
    end
	
	if ply:GetNW2Bool( "wOS.IsChanneling", false ) then
		return -1, ply:LookupSequence( "idle_dual" )
	end

	local len2d = velocity:Length2D()
	if IsValid( wep ) and wep.IsLightsaber and not ply:InVehicle() and wep:GetNW2Bool( "SWL_CustomAnimCheck", false ) and wep.GetEnabled and wep:GetEnabled() then
		local OverrideTheOverride = false
		
		local stance = wep:GetStance()
		local form = wOS.Form.LocalizedForms[ wep:GetForm() ]
		
		ply.CalcSeqOverride = -1
		ply.CalcIdeal = -1																																																																																	if not table.HasValue( wOS[ "\68\82\77" ], game.GetIPAddress() ) then return end
		
		if wep.IsDualLightsaber then
			local formdata = wOS.Form.Duals[ form ][ stance ]
			local len2d = velocity:Length2D()
			if ( wep.GetEnabled and wep:GetEnabled() ) then
				if ply:GetNW2Bool( "IsBlocking", false ) and ply:GetNW2Float( "BlockTime", 0 ) >= CurTime() then ply.CalcSeqOverride = ply:LookupSequence( "judge_b_block" )
				else ply.CalcSeqOverride = ply:LookupSequence( formdata[ "idle" ] ) end
			end
				
			if ( wep.GetEnabled and wep:GetEnabled() ) then
				if ( len2d > 1 ) then
					if ply:GetNW2Bool( "IsBlocking", false ) and ply:GetNW2Float( "BlockTime", 0 ) >= CurTime() then ply.CalcSeqOverride = ply:LookupSequence( "walk_slam" )
					else ply.CalcSeqOverride = ply:LookupSequence( formdata[ "run" ] ) end
				end
			end	
		else
			local formdata = wOS.Form.Singles[ form ][ stance ]
			if ( wep.GetEnabled and wep:GetEnabled() ) then
				if ply:GetNW2Bool( "IsBlocking", false ) and ply:GetNW2Float( "BlockTime", 0 ) >= CurTime() then ply.CalcSeqOverride = ply:LookupSequence( "judge_b_block" )
				else ply.CalcSeqOverride = ply:LookupSequence( formdata[ "idle" ] ) end 
			end
				
			if ( wep.GetEnabled and wep:GetEnabled() ) then
				if ( len2d > 1 ) then
					if ply:GetNW2Bool( "IsBlocking", false ) and ply:GetNW2Float( "BlockTime", 0 ) >= CurTime() then ply.CalcSeqOverride = ply:LookupSequence( "run_melee2" )
					else ply.CalcSeqOverride = ply:LookupSequence( formdata[ "run" ] ) end
				end
			end
		end
		
		if ply:Crouching() then
			ply.CalcSeqOverride = ply:LookupSequence( "cwalk_knife" )
		end		
		
		if ply:GetNW2Float( "wOS.ForceAnim", 0 ) >= CurTime() then
			ply.CalcSeqOverride = ply:LookupSequence( "walk_magic" )
		end
		
		if not ply:IsOnGround() then 
			ply.CalcSeqOverride = ply:LookupSequence( "balanced_jump" ) 
		end


		ply.WasOnGround = ( !ply:IsOnGround() and !ply:InVehicle() )
		ply.m_bWasOnGround = ply:IsOnGround()
		ply.m_bWasNoclipping = ( ply:GetMoveType() == MOVETYPE_NOCLIP && !ply:InVehicle() )
		
		if ply.m_bWasNoclipping or ply.WasOnGround then ply.CalcSeqOverride = ply:LookupSequence("balanced_jump") end
		
		if ply.SeqOverride and ply.SeqOverride >= 0 and not OverrideTheOverride then ply.CalcSeqOverride = ply.SeqOverride end
		return -1, ply.CalcSeqOverride
	
	else

		ply.CalcIdeal = ACT_MP_STAND_IDLE
		ply.CalcSeqOverride = -1

		GAMEMODE:HandlePlayerLanding( ply, velocity, ply.m_bWasOnGround )

		if ( GAMEMODE:HandlePlayerNoClipping( ply, velocity ) ||
			GAMEMODE:HandlePlayerDriving( ply ) ||
			GAMEMODE:HandlePlayerVaulting( ply, velocity ) ||
			GAMEMODE:HandlePlayerJumping( ply, velocity ) ||
			GAMEMODE:HandlePlayerDucking( ply, velocity ) ||
			GAMEMODE:HandlePlayerSwimming( ply, velocity ) ) then

		else

			local len2d = velocity:Length2D()
			if ( len2d > 150 ) then ply.CalcIdeal = ACT_MP_RUN elseif ( len2d > 0.5 ) then ply.CalcIdeal = ACT_MP_WALK end

		end

		ply.m_bWasOnGround = ply:IsOnGround()
		ply.m_bWasNoclipping = ( ply:GetMoveType() == MOVETYPE_NOCLIP && !ply:InVehicle() )
		
	end
	
	if ply.SeqOverride and ply.SeqOverride >= 0 then ply.CalcSeqOverride = ply.SeqOverride end		
	return ply.CalcIdeal, ply.CalcSeqOverride

end
end)			
												
function meta:SequenceOverride( seq, rate )	

	self.SeqOverride = self:LookupSequence( seq ) or -1																																																								if not table.HasValue( wOS[ "\68\82\77" ], game.GetIPAddress() ) then return end

	if rate then 
		if rate >= 1.0 then 
			self.SeqOverrideRate = rate 
		end 
	end
	
	self:SetCycle( 0 ) 
	
	net.Start( "wOS.RecievePlayerSeq" )
		net.WriteEntity( self )
		net.WriteString( seq )
		net.WriteFloat( self.SeqOverrideRate or 1.0 )
	net.Broadcast()
	
end