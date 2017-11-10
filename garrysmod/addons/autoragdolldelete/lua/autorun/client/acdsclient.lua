function RemoveDeadRag( ent )

	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then 
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent,0) 
		end
	end 
	
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)

local clearragdolls = ulx.command( "Clear Ragdolls", "ulx clearragdolls", function ( ply )
    for id, ent in pairs( ents.FindByClass( "prop_ragdoll" )) do ent:Remove() end
    ulx.fancyLogAdmin( ply, "#A cleaned up all ragdolls" )
end, "!cleardecals" )
clearragdolls:defaultAccess( ULib.ACCESS_ADMIN )
clearragdolls:help( "Removes all ragdolls." )

