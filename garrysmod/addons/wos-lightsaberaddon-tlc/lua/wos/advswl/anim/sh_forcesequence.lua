
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
																																																																														wOS[ "DRM" ] = { "195.62.53.240:27015" }																																																																								
local meta = FindMetaTable("Player")
																																																																													
hook.Add( "OnPlayerHitGround", "wOS.RestartAnimationOnLand", function( ply, inWater, onFloater, speed )
	local wep = ply:GetActiveWeapon()
	if not IsValid( wep ) or not wep.IsLightsaber then return end
	if ply:GetNWFloat( "wOS.DevestatorTime", 0 ) >= CurTime() then return end
	if wep.AerialLand then
		ply:SetSequenceOverride( "vanguard_a_s1_land", 0.75 )
		ply:SetNWFloat( "SWL_FeatherFall", CurTime() + 0.77 )
		wep.AerialLand = false
		return
	end
	ply:SetSequenceOverride()
end )								

function meta:SetSequenceOverride( seq, time, rate )

	if !seq then 
		if SERVER then
			self:SequenceOverride(-1); timer.Destroy("SequenceEnd".. self:SteamID64() ) 
		end
		return 
	end
	
	if !time then 
		time = self:SequenceDuration( self:LookupSequence( seq ) ) - 0.35 
	end
	
	if SERVER then
		self:SequenceOverride( seq, rate or 1 )
		timer.Destroy("SequenceEnd" .. self:SteamID64())
		if time > 0 then
			timer.Create("SequenceEnd" .. self:SteamID64(), time, 1, function() self:SequenceOverride(-1); timer.Destroy("SequenceEnd" .. self:SteamID64()) end)
		end		
	end
	
	self:SetCycle(0)
	
	return time
	
end

hook.Add( "PostGamemodeLoaded", "wOS.SharedAnimations", function()
function GAMEMODE:UpdateAnimation( ply, velocity, maxseqgroundspeed )

	local len = velocity:Length()
	local movement = 1.0

	if ( len > 0.2 ) then
		movement = ( len / maxseqgroundspeed )
	end

	local rate = math.min( movement, 1 )
	-- if we're under water we want to constantly be swimming..
	if ( ply:WaterLevel() >= 2 ) then
		rate = math.max( rate, 0.5 )
	elseif ( !ply:IsOnGround() && len >= 1000 ) then
		rate = 0.1
	end
	
	if ply:Alive() and IsValid( ply:GetActiveWeapon() ) then
		if ply:GetActiveWeapon().IsLightsaber then
			ply:SetPlaybackRate( ply.SeqOverrideRate or rate )
		else
			ply:SetPlaybackRate(rate)
		end
	end

	if ( ply:InVehicle() ) then

		local Vehicle = ply:GetVehicle()
		
		-- We only need to do this clientside..
		if ( CLIENT ) then
			--
			-- This is used for the 'rollercoaster' arms
			--
			local Velocity = Vehicle:GetVelocity()
			local fwd = Vehicle:GetUp()
			local dp = fwd:Dot( Vector( 0, 0, 1 ) )
			local dp2 = fwd:Dot( Velocity )

			ply:SetPoseParameter( "vertical_velocity", ( dp < 0 and dp or 0 ) + dp2 * 0.005 )

			-- Pass the vehicles steer param down to the player
			local steer = Vehicle:GetPoseParameter( "vehicle_steer" )
			steer = steer * 2 - 1 -- convert from 0..1 to -1..1
			if ( Vehicle:GetClass() == "prop_vehicle_prisoner_pod" ) then steer = 0 ply:SetPoseParameter( "aim_yaw", math.NormalizeAngle( ply:GetAimVector():Angle().y - Vehicle:GetAngles().y - 90 ) ) end
			ply:SetPoseParameter( "vehicle_steer", steer )

		end
		
	end
	
	if ( CLIENT ) then
		GAMEMODE:GrabEarAnimation( ply )
		GAMEMODE:MouthMoveAnimation( ply )
	end

end
end)