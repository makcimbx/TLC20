#NoSimplerr#
hook.Add( "HUDPaint", "HUDPaint_DrawABox", function()
	DrawMovableCubic(ScrW()/2,ScrH()/2,8,8)
end )

local aray = {
	{x=ScrW()/2,y=ScrH()/2},
	{x=ScrW()/2+50,y=ScrH()/2+0},
	{x=ScrW()/2+50,y=ScrH()/2+50},
	{x=ScrW()/2+0,y=ScrH()/2+50},
	{x=ScrW()/2+0,y=ScrH()/2+100},
	{x=ScrW()/2+50,y=ScrH()/2+100},
	{x=ScrW()/2+0,y=ScrH()/2+100},
}

function DrawMovableCubic(x,y,w,h)
	local mod1 = 50
	local mod = mod1/2
	
	for k,v in pairs(aray)do
		local x = v.x
		local y = v.y
		local xy = GetMouse()
		local yx = GetMouse()
		surface.DrawRect( x+xy, y+yx, w, h )
	end

	local x = x - w/2-mod
	local y = y - h/2+mod
	local xy = GetMouse()
	local yx = GetMouse()
	surface.DrawRect( x+xy, y+yx, w, h )
	local x2 = x + mod1
	local y2 = y
	local xy2 = GetMouse()
	local yx2 = GetMouse()
	surface.DrawRect( x2+xy2, y2+yx2, w, h )
	surface.DrawLine( x+xy+w/2, y+yx+h/2, x2+xy2+w/2, y2+yx2+h/2 )
	local x3 = x2
	local y3 = y2 - mod1
	local xy3 = GetMouse()
	local yx3 = GetMouse()
	surface.DrawRect( x3+xy3, y3+yx3, w, h )
	surface.DrawLine( x3+xy3+w/2, y3+yx3+h/2, x2+xy2+w/2, y2+yx2+h/2 )
	local x4 = x3 - mod1
	local y4 = y3
	local xy4 = GetMouse()
	local yx4 = GetMouse()
	surface.DrawRect( x4+xy4, y4+yx4, w, h )
	surface.DrawLine( x4+xy4+w/2, y4+yx4+h/2, x3+xy3+w/2, y3+yx3+h/2 )
	surface.DrawLine( x4+xy4+w/2, y4+yx4+h/2, x+xy+w/2, y+yx+h/2 )
end
local d = 0

hook.Add( "Think", "Ever_K32423534655ey_FLY", function()
	if(input.IsMouseDown( MOUSE_LEFT ))then
		d = math.Clamp( d + 0.1, 0, 5 )
	else
		d = math.Clamp( d - 0.1, 0, 5 )
	end
end)

function GetMouse()
	return math.Rand(-d,d)
end

concommand.Add("hashit",function(ply)
	local str = "ABCDF"
	local nH = 6
	local prestring = string.ToTable( str ) 
	
	for i=1,nH do
		local d = prestring[i]
		if(i+3>#prestring)then
			prestring[i] = prestring[i+3-#prestring]
			prestring[i+3-#prestring] = d
		else
			prestring[i] = prestring[i+3]
			prestring[i+3] = d
		end
	end
	PrintTable(prestring)
end)