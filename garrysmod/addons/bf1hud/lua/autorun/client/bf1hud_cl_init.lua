--hook.Add("HUDShouldDraw","BHudHideDarkRPHUD",function(name) if name == "DarkRP_EntityDisplay" or name == "DarkRP_HUD" then return false end end)


bhudstructure = {}


bhudstructure = {

	compass = {
		barw = 300,
		barh = 25,
		facingw = 75,
		facingh = 40,
		numw = 75,
		numh = 25,
		colour = Color(0,0,0,100),
		barcolour = Color(0,0,0,100),
		text = Color(255,255,255,255),
		bartext = Color(255,255,255,255)
	}
}

surface.CreateFont("BF1HUDCompassNumFont",{
	font = "Futura Book",
	extended = false,
	size = 25,
	weight = 0,
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
	outline = false,
})

surface.CreateFont("BF1HUDCompassFont2",{
	font = "Futura Book",
	extended = false,
	size = 20,
	weight = 0,
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
	outline = false,
})