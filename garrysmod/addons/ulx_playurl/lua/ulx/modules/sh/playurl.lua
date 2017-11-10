local CATEGORY_NAME = "Apple's Creations"

if(SERVER)then
	util.AddNetworkString("StartAnime")
end


// Plays the song
function ulx.playurlsound( calling_ply, urlsound )
	local options = ""
	umsg.Start("ulib_url_sound")
		umsg.String(urlsound)
	umsg.End()
	timer.Simple(10+1,function() net.Start("StartAnime") net.Broadcast() end)
	
	ulx.fancyLogAdmin( calling_ply, "#A played the url song. Type !stopurlme to stop listening: #s", urlsound )
end
local playurlsound = ulx.command( CATEGORY_NAME, "ulx playurlsound", ulx.playurlsound, "!playurl" )
playurlsound:addParam{ type=ULib.cmds.StringArg, hint="", autocomplete_fn=ulx.soundComplete }
playurlsound:defaultAccess( ULib.ACCESS_ADMIN )
playurlsound:help( "Play a URL song for the server - !playurl" )



// Stops the song
function ulx.stopurlsound( calling_ply, stopurlsound )

	umsg.Start("ulib_url_stopsound")
		umsg.String(stopurlsound)
	umsg.End()

	ulx.fancyLogAdmin( calling_ply, "#A stopped the url song for the server." )
end

local stopurlsound = ulx.command( CATEGORY_NAME, "ulx stopurlsound", ulx.stopurlsound, "!stopurl" )
stopurlsound:defaultAccess( ULib.ACCESS_ADMIN )
stopurlsound:help( "Stops a URL song for the server - !stopurl" )


// All client crap

function Stop_URL_Song_Client(ply,text,public)
local exp = string.Explode(" ", text)
if exp[1] == "!stopurlme" then
		print("This part is working")
		umsg.Start("stopmysongplease", ply)
		umsg.End()
end
if exp[1] == "!playurlme" then
		print("This part is working")
		umsg.Start("startmysongplease", ply)
		umsg.String(exp[2])
		umsg.End()	
end
end

hook.Add("PlayerSay","Stop_URL_Song_Client", Stop_URL_Song_Client)