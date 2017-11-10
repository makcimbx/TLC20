--I Love you for ever and ever becuase {CODE BLUE} loves everyone

include('afk_config.lua')

surface.CreateFont( "AFKFont", {
	font = "Arial", 
	size = ScreenScale(120), 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = true, 
} )

surface.CreateFont( "AFKFontTwo", {
	font = "Arial", 
	size = ScreenScale(25), 
	weight = 500, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = true, 
} )

local shouldDrawADKWarning = false

net.Receive("GivePlayerAFKWarning",function()
	shouldDrawADKWarning=true
end)

net.Receive("RemovePlayerAFKWarning",function()
	shouldDrawADKWarning=false
end)

hook.Add("HUDPaint","drawTheAFKWarning",function()

	if(shouldDrawADKWarning)then

		draw.RoundedBox( 0, 0, (ScrH()/2)-ScreenScale(60), ScrW(), ScreenScale(120), Color(0,0,0,240) )
		draw.DrawText( AFKCONFIG.mainWarnMessage, "AFKFont", ScrW() * 0.5, (ScrH()*0.5)-(ScreenScale(50)), Color( 255, 0 ,0 , 255 ), TEXT_ALIGN_CENTER )
		draw.DrawText( AFKCONFIG.subWarnMessage, "AFKFontTwo", ScrW() * 0.5, (ScrH()*0.5), Color( 255,255,255, 255 ), TEXT_ALIGN_CENTER )

	end
	
end)