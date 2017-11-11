function spawn( ply )
	ply:StripAmmo()
	ply:SetPData(ply:SteamID().."_new", "true")	
	Jedi(ply)
end
hook.Add( "PlayerSpawn", "PlayerSpawn", spawn )

function change(ply, oldTeam, newTeam)
	ply:StripAmmo()
	ply:SetPData(ply:SteamID().."_new", "true")
	Jedi(ply)
end
hook.Add( "OnPlayerChangedTeam", "OnPlayerChangedTeam", change )

function death( victim, inflictor, attacker )
	victim:StripAmmo()
	victim:SetPData(victim:SteamID().."_new", "true")
end
hook.Add( "PlayerDeath", "PlayerDeath", death )

function Jedi(ply)
	timer.Simple( 0.1, function() 
		if(ply:getJobTable().category=="Jedi")then
			ply:Give("weapon_lightsaber_wos")
		end
		ply:Give("keys")
	 end )
end
