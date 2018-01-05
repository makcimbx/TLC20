SI = {}
SI.locations = {} -- Don't touch that.

// Config

SI.locations[ "rp_chancellor_tlc_b1" ] = { -- You can change the map name to whatever you want. Make sure to add new positions for every map you have!
	{ 
		startpos = Vector( -1876.755981, 294.222473, -277.731079 ), 
		endpos = Vector( -1883.230591, -859.605591, -277.731079 ), 
		ang = Angle( 0, 180, 0 ),  
		speed = 0.1, 
		text = "Сфотографируйте или запомните.",
	},
	{ 
		startpos = Vector( -1873.558350, -865.585999, -282.910065 ),
		endpos = Vector( -1142.853882, -855.912048, -282.910065 ), 
		ang = Angle( 0, 90, 0 ), 
		speed = 0.1, 
		text = "Сфотографируйте или запомните." 
	},
}


SI.locations[ "spawn" ] = {
	{ 
		startpos = Vector( 14740, -5074, 6881 ), 
		endpos = Vector( -11165, -8072, 6073 ), 
		ang = Angle( 20, 138, 0 ), 
		speed = 0.05, 
		text = "Нажмите 'Пробел' для того чтобы заспавнится.",
		ang2 = Angle( 17, 32, 0 ),
	},
	{

		startpos = Vector( -11165, -8072, 6073 ), 
		endpos = Vector( -11093, 6760, 8728 ), 
		ang = Angle( 17, 32, 0 ), 
		speed = 0.05, 
		text = "Нажмите 'Пробел' для того чтобы заспавнится.",
		ang2 = Angle( 29, -36, 0 ),
	},
	{

		startpos = Vector( -11093, 6760, 8728 ), 
		endpos = Vector( 13878, 10201, 5804 ), 
		ang = Angle( 29, -36, 0 ), 
		speed = 0.05, 
		text = "Нажмите 'Пробел' для того чтобы заспавнится.",
		ang2 = Angle( 12, -136, 0 ),
	},
	{ 
		startpos = Vector( 13878, 10201, 5804 ), 
		endpos = Vector( 14740, -5074, 6881 ), 
		ang = Angle( 12, -136, 0 ), 
		speed = 0.05, 
		text = "Нажмите 'Пробел' для того чтобы заспавнится.",
		ang2 = Angle( 20, 138, 0 ),
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

SI.useCommand = false
SI.command = "!tutorial"

SI.forceIntro = false -- Force the user to watch the intro?
SI.showOnce = false -- Only ask the user if they want to see it once?

SI.hide = true -- Hide players?

// ADVANCED: HUD DRAW FUNCTION
function SI.HUDDraw( text,d ) // Only change this if you know how to make a HUD. Text is the current text from the location. text is a MarkupObject generated from the text string in each section.
	d = d or false
	local x = 100
	local y = 250
	local h = 100
	local s = ""
	local s2 = ""
	local color = Color( 0, 0, 0, 210 )
	if(d == true )then
		x = 0
		y = 50
		h = 50
		s = "<colour=0, 0, 0, 255>"
		s2 = "</colour>"
		color = Color( 150, 150, 150, 210 )
	end
	draw.RoundedBox( 0, x, ScrH() - y, ScrW() - 2*x, h, color )
	markup.Parse( "<font=DermaLarge>".. s .. text .. s2.."</font>", ScrW() - 2*h ):Draw( ScrW() / 2, ScrH() - y+h/2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end 

function SI.HUDDrawSpace( d ) // Only change this if you know how to make a HUD. Text is the current text from the location. text is a MarkupObject generated from the text string in each section.
	d = d or false
	local x = 100
	local h = 50
	local y = ScrH()+h
	local s = ""
	local s2 = ""
	local color = Color( 0, 0, 0, 210 )
	if(d == true )then
		x = 0
		y = 150
		h = 50
		--s = "<colour=0, 0, 0, 255>"
		--s2 = "</colour>"
		--color = Color( 150, 150, 150, 210 )
	end
	draw.RoundedBox( 0, ScrW()/2-ScrW()/4,  ScrH()/2+2*h+y, ScrW()/2, h, color )
	markup.Parse( "<font=DermaLarge>".. s .. "Нажмите пробел для продолжения" .. s2.."</font>", ScrW() - 2*h ):Draw( ScrW()/2,  ScrH()/2+2*h+h/2+y, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end 