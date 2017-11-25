if (CLIENT) then return end

hook.Add( "PlayerCanHearPlayersVoice", "stunplayerbydc", function( _, ply )
	if not IsValid(ply) then return end
	if ply:GetNWBool("Cangugdc") == true then return false end
end)