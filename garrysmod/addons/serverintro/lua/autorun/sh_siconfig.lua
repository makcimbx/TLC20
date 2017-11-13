SI = {}
SI.locations = {} -- Don't touch that.

// Config

SI.locations[ "gm_flatgrass" ] = { -- You can change the map name to whatever you want. Make sure to add new positions for every map you have!
	{ 
		startpos = Vector( 550, -5500, 3311 ), 
		endpos = Vector( 550, 5500, 3311 ), 
		ang = Angle( 90, 90, 0 ), 
		speed = 0.1, 
		text = "This is our map.",
	},
	{ 
		startpos = Vector( 248, 640, -150 ),
		endpos = Vector( 248, 3500, -150 ), 
		ang = Angle( 0, 105, 0 ), 
		speed = 0.1, 
		text = "Please follow the rules." 
	},
	{ 
		startpos = Vector( 2000, 680, -400 ), 
		endpos = Vector( 2400, 1250, -280 ), 
		ang = Angle( 0, 45, 0 ), 
		speed = 0.1,
		text = "There are lots of jobs.", 
		ang2 = Angle( 20, -90, 0 ) 
	},
	{ 	
		startpos = Vector( 3000, -1000, -110 ), 
		endpos = Vector( 3000, -2050, -110 ), 
		ang = Angle( 0, -45, 0 ), 
		speed = 0.1,
		text = "We hope you enjoy your stay.",
		ang2 = Angle( 0, 45, 0 ),
	},
}

SI.PVSExtra = { -- If you are having problems with invisble entites during the intro, add the locations of the entites here and they'll be syncrohnised with the client automatically.
    Vector( 0, 0, 0 )
}

// The text displayed when you join the server
SI.welcomeText = "Welcome to our server!"

SI.music = nil -- Change this to the path to the sound file, relative to the sound directory
SI.useYoutube = false -- Use a youtube video for music (the above variable must be nil!)
SI.useExpirmental = false -- Uses an experminetal new API. This one is much more unstable than the other one so I only recomend using it as a last resort.
SI.youtubeUrl = "https://www.youtube.com/watch?v=vS3C0s3wuN4" -- Youtube URL. Note: You must generate it first by going to http://youtubeinmp3.com/fetch/?video=<youtube url> if you are not using the experimental api.

SI.posDuration = 10 -- The time spent at each position

SI.useCommand = true
SI.command = "!tutorial"

SI.forceIntro = false -- Force the user to watch the intro?
SI.showOnce = false -- Only ask the user if they want to see it once?

SI.hide = true -- Hide players?

// ADVANCED: HUD DRAW FUNCTION
function SI.HUDDraw( text ) // Only change this if you know how to make a HUD. Text is the current text from the location. text is a MarkupObject generated from the text string in each section.
	draw.RoundedBox( 12, 100, ScrH() - 250, ScrW() - 200, 100, Color( 0, 0, 0, 210 ) )
	markup.Parse( "<font=DermaLarge>" .. text .. "</font>", ScrW() - 200 ):Draw( ScrW() / 2, ScrH() - 200, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end 