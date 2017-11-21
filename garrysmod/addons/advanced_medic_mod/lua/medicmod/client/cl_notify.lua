local NotificationTable = {}

function MedicNotif( msg, time )

	NotificationTable[#NotificationTable + 1] = {
	text = msg,
	apptime = CurTime() + 0.2,
	timeremove = CurTime() + 0.2 + 1 + time,
	}

end

local iconMat = Material( "materials/notify_icon.png" )
local iconMatR = Material( "materials/notify_rect.png" )

hook.Add("HUDPaint", "MedicMod.HUDNotifications", function()
		
	for k, v in pairs( NotificationTable ) do
		
		if v.timeremove - CurTime() < 0 then table.remove(NotificationTable,k) continue end
		
		local alpha = ( math.Clamp(CurTime() - v.apptime, 0 , 1) )
		local posy = ScrH() - 200 - 60 * k - 40 * ( 1 - ( math.Clamp(CurTime() - v.apptime, 0 , 1) ) )
		local posx = math.Clamp(v.timeremove - CurTime(),0,0.25) * 4 * 30 + (0.25 - math.Clamp(v.timeremove - CurTime(),0,0.25)) * 4 * - 340
		
		surface.SetFont( "MedicModFont20" )
		local textsize = select( 1,surface.GetTextSize( v.text ) )
				
		 surface.SetDrawColor( 255, 255, 255, 255 * alpha )
		-- surface.DrawRect( posx + 50, posy, 20 + textsize, 40 )
	
		surface.SetMaterial( iconMat )
		surface.DrawTexturedRect( posx - 20, posy - 18 , 75,75 )
		surface.SetMaterial( iconMatR )		
		surface.DrawTexturedRect( posx + 75 - 34, posy - 17.5 , textsize + 30, 75 )
		
		surface.SetTextPos( posx + 50 + 10, posy + 10 )
		surface.SetTextColor( 255,255,255, 255 * alpha)
		surface.DrawText( v.text )
	
	end	
	
end)