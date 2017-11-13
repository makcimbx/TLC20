function OnNPCKilled(npc, attacker, inflictor)
	npc:GetActiveWeapon():Remove()
end
hook.Add("OnNPCKilled","Ever_OnNPCKilled",OnNPCKilled)