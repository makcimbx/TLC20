


local meta = FindMetaTable( "Player" )

function meta:wOSIsRolling()

	return ( self:GetRollTime() >= CurTime() )

end

function meta:GetRollTime()

	return ( self:GetNW2Float( "wOS.RollTime", 0 ) )

end

function meta:GetRollDir()

	return ( self:GetNW2Int( "wOS.RollDir", 1 ) )

end

function wOS.RollMod:ResetAnimation( ply )

	ply:AnimRestartMainSequence()
	if SERVER then
		net.Start( "wOS.RollMod.CallRestart" )
			net.WriteEntity( ply )
		net.Broadcast()
	end
	
end

hook.Add( "UpdateAnimation", "wOS.RollMod.SlowDownAnim", function(ply, velocity, maxSeqGroundSpeed)
	if ply:wOSIsRolling() then
		if ply:GetRollDir() == 2 then
			ply:SetPlaybackRate( 0.75 )
		elseif ply:GetRollDir() == 4 then
			ply:SetPlaybackRate( 1.1 )
		else
			ply:SetPlaybackRate( 0.8 )
		end
		return true
	end
end )

hook.Add( "CalcMainActivity", "wOS.RollMod.Animations", function( ply, velocity )

	if !IsValid( ply ) or !ply:wOSIsRolling() then return end
	
	local seq = wOS.RollMod.Animations[ ply:GetRollDir() ]
	local seqid = ply:LookupSequence( seq or "" )
	if seqid < 0 then return end
	if ply:GetRollDir() == 2 then
		ply:SetPlaybackRate( 0.05 )
	end
	return -1, seqid or nil

end )

hook.Add( "Move", "wOS.RollMod.MoveDir", function( ply, mv ) 

	
end )
