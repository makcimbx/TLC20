surface.CreateFont( "SW.ClockFont", {
	font = "Trebuchet MS",
	size = 24,
	weight = 500
} );

function SW.DrawClock()
	
	if( !SW.ShouldDrawClock ) then return end
	if( !GetConVar( "sw_showclock" ):GetBool() ) then return end
	if( !SW.Time ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	local hr = math.floor( SW.Time );
	local min = math.floor( 60 * ( SW.Time - hr ) );
	
	local ampm = "AM";
	if( hr > 12 ) then
		ampm = "PM";
	end
	if( hr > 12 ) then
		hr = hr - 12;
	end
	
	if( hr == 0 ) then
		hr = 12;
	end
	
	if( min < 10 ) then
		min = "0" .. min;
	end
	
	clock4811 = hr .. ":" .. min .. " " .. ampm;
	
	surface.SetFont( "SW.ClockFont" );
	local w, h = surface.GetTextSize( clock4811 );
	surface.SetDrawColor( Color( 0, 0, 0, 150 ) );
	surface.SetTextColor( Color( 255, 255, 255, 255 ) );
	
	local padding = 10;
	local ybase = ScrH() - 110 - padding - h;
	
	if( SW.ClockTop ) then
		ybase = 20;
	end
	

	
end
hook.Add( "HUDPaint", "SW.DrawClock", SW.DrawClock );
