// Hey, there used to be DRM here, but I removed it.
// I'm not some big scary server man, scriptfodder is just a way for me to earn money and buy games.
// So if you're thinking about leaking this, do me a favour, and don't.
// Becasue I will find you. And I will kill you.

util.AddNetworkString( "GlideStart" )

if not SI.useYoutube and SI.music then
	resource.AddFile( SI.music )
end

hook.Add( "SetupPlayerVisibility", "SIPVS76561198045250557", function( ply )
	if IsValid( ply ) and ply.Gliding then
		AddOriginToPVS( SI.locations[ game.GetMap() ][ ply.Stage ].startpos )
		AddOriginToPVS( SI.locations[ game.GetMap() ][ ply.Stage ].endpos )
	    for k,v in pairs( SI.PVSExtra ) do
	        AddOriginToPVS( v )
	    end
	end
end )

net.Receive( "GlideStart", function( len, ply )
	if not ply.Gliding then
		ply:Freeze( true )
		ply.Stage = 1
		timer.Create( "StageTimer" .. ply:UniqueID(), SI.posDuration, #SI.locations[ game.GetMap() ], function()
			if IsValid( ply ) then
				ply.Stage = ply.Stage + 1
			end
		end )
		timer.Simple( #SI.locations[ game.GetMap() ] * SI.posDuration, function()
			if IsValid( ply ) then
				ply.Gliding = false
				ply:Freeze( false )
			end
		end )
		ply.Gliding = true
	end
end )

