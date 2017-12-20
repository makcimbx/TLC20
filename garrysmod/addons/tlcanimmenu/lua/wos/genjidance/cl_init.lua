


hook.Add( "CalcView", "wOS.RollMod.FirstPerson", function( ply, pos, ang )
    
	
end )

hook.Add( "CalcViewModelView", "wOS.RollMod.RotateGun", function(wep, viewmodel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)


	
end )


hook.Add( "CreateMove", "wOS.RollMod.PreventMovement", function( cmd )

end )

--Credit to Stalker for this thing, super handy.
net.Receive( "wOS.RollMod.CallRestart", function()

	local ply = net.ReadEntity()
	
	if IsValid( ply ) then
	
		ply:AnimRestartMainSequence()
		
	end
	
end )