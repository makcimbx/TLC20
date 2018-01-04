#NoSimplerr#

hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	DrawMovableCubic(ScrW()/2,ScrH()/2,16,16)
end )

function DrawMovableCubic(x,y,w,h)
	x = x - w/2
	y = y - h/2
	surface.DrawRect( x+GetMouse(x,true), y+GetMouse(y,false), w, h )
end


function GetMouse(p,t)
	local x,y = input.GetCursorPos()
	if(t)then
		return x 
	else
		return y 
	end
end