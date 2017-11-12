local gap = 30

local function BF1HUD( ply )
	local ply = LocalPlayer()
	local width,height = ScrW(),0
	local ang = ply:EyeAngles()
	ang:Normalize()

	/*local CompassDirections = {
	"N",
	"NE",
	"E",
	"SE",
	"S",
	"SW",
	"W",
	"NW"
	}*/
	
	local CompassDirections = {
	"Север",
	"Северо-Восток",
	"Восток",
	"Юго-Восток",
	"Юг",
	"Юго-Запад",
	"Запад",
	"Северо-Запад"
	}
	
	local deg = math.ceil(ang.y-90)
	while deg < 360 do deg = deg+360 end
	while deg > 0 do deg = deg-360 end

	compasspad = 0-width
	compasswidth = ScrW()
	
	local i=1
	local directioncounter = 3

	render.SetScissorRect(width+compasspad,height,width+compasspad+compasswidth,height+20,true)
	
	width = width+math.Round(compasspad-compasswidth*3/2)
	width = width+ang.y/180*compasswidth

	draw.RoundedBox(0,0,height,ScrW(),15,bhudstructure.compass.barcolour)

	while i<=18 do
		local txt = CompassDirections[directioncounter]
		draw.SimpleText(txt,"BF1HUDCompassFont2",width,height-3,bhudstructure.compass.bartext,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		width = width+math.Round(compasswidth/4)
		
		i = i+1
		directioncounter = directioncounter+1
		if directioncounter > #CompassDirections then
			directioncounter = 1
		end
	end

	render.SetScissorRect( 0, 0, 0, 0, false )
	
	draw.RoundedBox(0,ScrW()/2-(5)/2,0,5,15,Color(255,0,0))
	
		
	while deg < 360 do deg = deg+360 end
	while deg > 0 do deg = deg-360 end
	if string.match(tostring(deg),"-") then	deg = string.sub(deg,2,5) end

	draw.RoundedBox(0,ScrW()-bhudstructure.compass.numw,15,bhudstructure.compass.numw,bhudstructure.compass.numh,bhudstructure.compass.colour)
	draw.SimpleText(deg,"BF1HUDCompassNumFont",ScrW()-bhudstructure.compass.numw+(bhudstructure.compass.numw/2),10+(bhudstructure.compass.numh/2-8),bhudstructure.compass.text,TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)

	ang:Normalize()
	local deg = math.ceil(ang.y-90)
end
hook.Add("HUDPaint","BF1HUD",BF1HUD)