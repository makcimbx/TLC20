function OnNPCKilled(npc, attacker, inflictor)
	local wep = npc:GetActiveWeapon()
	if(IsValid(wep))then
		wep:Remove()
	end
end
hook.Add("OnNPCKilled","Ever_OnNPCKilled",OnNPCKilled)

local meta = FindMetaTable("Player")

function meta:isArrested()
	return false
end