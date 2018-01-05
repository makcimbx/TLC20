function playerAdvert( ply, args )

	if args == "" then

		ply:SendLua( string.format( [[notification.AddLegacy( "%s", 1, 5 )
			surface.PlaySound( "buttons/button15.wav" )]], CLASSICADVERT.failMessage ) )

	else
		local senderColor = team.GetColor( ply:Team() )
		local DoSay = function(text)
			for k, v in pairs(player.GetAll()) do
				if v:IsPlayer() then
					serverguard.Notify(v, CLASSICADVERT.advertTextColor, CLASSICADVERT.chatPrefix, senderColor, " "..ply:GetName(), CLASSICADVERT.advertTextColor, ": "..args);
				end
			end
		end
		return args, DoSay
	
		--for k,pl in pairs( player.GetAll() ) do

		--	local senderColor = team.GetColor( ply:Team() )
		--	DarkRP.talkToPerson(pl, senderColor, CLASSICADVERT.chatPrefix.." "..ply:Nick())
		--	DarkRP.talkToPerson(pl, senderColor, CLASSICADVERT.chatPrefix.." "..ply:Nick(), Color(255, 255, 0), args, ply)
		--end

		--return ""

	end

end
DarkRP.defineChatCommand( CLASSICADVERT.chatCommand, playerAdvert )