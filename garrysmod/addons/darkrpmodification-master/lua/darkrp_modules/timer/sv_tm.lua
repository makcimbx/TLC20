
hook.Add("PlayerInitialSpawn","EverTimer_PlayerInitialSpawn",function(ply)
	ply.saved_time = ply:TimeConnected()
	ply:SetNWFloat( 'saved_time', ply.saved_time )
	ply:SetNWFloat( 'online_time', 0 )
end)

hook.Add("ShutDown","EverTimer_ShutDown",function()
	for k,v in pairs(player.GetAll())do
		v:SetPData("ever_time",(v.saved_time or 0) +v:TimeConnected())
	end
end)

hook.Add("PlayerDisconnected","EverTimer_PlayerDisconnected",function( ply )
	ply:SetPData("ever_time",(ply.saved_time or 0) +ply:TimeConnected())
end)

timer.Create( "UniqueName1", 1, 1, function()
	for k,v in pairs(player.GetAll())do
		ply:SetNWFloat( 'online_time', ply:TimeConnected() )
	end
end )