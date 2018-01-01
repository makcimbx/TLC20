
local e_time = 5*60
local ptimer = 0
local pause = false
local vision = false
local mx = ScrW()/2 + 50

function StartTTimer()
	ptimer = e_time
	mx = ScrW()/2 + 50
	timer.Create("ever_ttimer",1,0,function()
		if(not pause)then
			if(not vision)then vision = true end
			if(ptimer - 1<=0)then
				timer.Remove( "ever_ttimer" )
			else
				ptimer = ptimer - 1
			end
		else
			vision = not vision
		end
	end)
end

function PauseTTimer()
	pause = true
end

function UnPauseTTimer()
	pause = false
end

function StopTTimer()
	if ( timer.Exists( "ever_ttimer" ) ) then
		timer.Remove( "ever_ttimer" )
	end
	pause = false
	ptimer = 0
end

local function ConvertTime(tm)
	if(tm == 0)then return "" end
	local m = math.floor( tm/60 )
	tm = tm - m*60
	local s = tm
	
	if(m<10)then
		m = "0"..m
	end
	
	if(s<10)then
		s = "0"..s
	end
	
	if(vision)then
		return m..":"..s
	else
		return ""
	end
end

hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	if(ptimer!=0)then
		if(mx>0)then mx = mx - 0.75 end
		surface.SetFont( "Trebuchet24" )
		surface.SetTextColor( 150, 150, 255,125  )
		surface.SetTextPos( ScrW()/2-mx, 3*ScrH()/4 )
		surface.DrawText( ConvertTime(ptimer) )
	end
end )