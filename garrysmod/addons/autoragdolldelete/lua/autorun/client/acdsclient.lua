function RemoveDeadRag( ent )

	if (ent == NULL) or (ent == nil) then return end
	if (ent:GetClass() == "class C_ClientRagdoll") then 
		if ent:IsValid() and !(ent == NULL) then
			SafeRemoveEntityDelayed(ent,0) 
		end
	end 
	
end
hook.Add("OnEntityCreated", "RemoveDeadRag", RemoveDeadRag)

