local serverStats = {}
local feedback = ""

function AWarn2_Statistics_Post()

	serverStats.hostname = GetHostName()
	serverStats.ipport = game.GetIPAddress()
	serverStats.map = game.GetMap()
	serverStats.gamemode = gmod.GetGamemode().Name or "UNKNOWN"
	serverStats.addon = "AWarn2"
	serverStats.addonversion = AWarn.Version

	http.Post( "http://g4p.org/addonstats/post.php", serverStats, statSuccess, function(errorCode) print("FAIL") end )
	timer.Simple( 1800, AWarn2_Statistics_Post )
end

function AWarn2_Stats_TimerStart()
	timer.Simple( 5, AWarn2_Statistics_Post )
end
hook.Add( "InitPostEntity", "awarn2_stats_post", AWarn2_Stats_TimerStart )

function statSuccess( body )
	feedback = body
	
	ServerLog("AWarn: Your server info has been updated to the online statistics tracking\n")
end

function FreeVersionAdvert()
	for k, v in pairs( player.GetAll() ) do
		v:SendLua( "chat.AddText( Color(255,255,255), 'This server is running ', Color(255,50,50), 'AWarn2 ', Color(255,255,255), 'designed by ', Color(50,255,50), '|G4P| Mr.President', Color(255,255,255), '.' )" )
	end

	timer.Simple( 1800, FreeVersionAdvert )
end

function AWarn2_Advert_TimerStart()
	timer.Simple( 5, FreeVersionAdvert )
end
hook.Add( "InitPostEntity", "AWarn2_Advert_TimerStart", AWarn2_Advert_TimerStart )