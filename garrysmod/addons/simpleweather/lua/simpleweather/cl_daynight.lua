SW_TIME_DAWN = 6;
SW_TIME_AFTERNOON = 12;
SW_TIME_DUSK = 18;
SW_TIME_NIGHT = 24;

SW_TIME_WEATHER = 1;
SW_TIME_WEATHER_NIGHT = 2;

SW.TimePeriod = SW_TIME_DUSK;

SW.CurFogDensity = 1;

SW.Time = SW.StartTime;

function SW.nInitFogSettings( len )
	
	SW.FogSettings = net.ReadTable();
	
end
net.Receive( "SW.nInitFogSettings", SW.nInitFogSettings );

function SW.nInitSkyboxFogSettings( len )
	
	SW.SkyboxFogSettings = net.ReadTable();
	
end
net.Receive( "SW.nInitSkyboxFogSettings", SW.nInitSkyboxFogSettings );

function SW.nSetTime( len )
	
	SW.Time = net.ReadFloat();
	
end
net.Receive( "SW.nSetTime", SW.nSetTime );

function SW.DayNightThink()
	
	if( !SW.UpdateFog ) then return end
	if( !SW.Time ) then return end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	local startdensity = SW.FogDayDensity;
	local enddensity = SW.FogDayDensity;
	local lerpdensity = 1;
	
	if( SW.Time < 4 ) then
		
		startdensity = SW.FogNightDensity;
		enddensity = SW.FogNightDensity;
		
	elseif( SW.Time < 6 ) then
		
		startdensity = SW.FogNightDensity;
		enddensity = SW.FogDayDensity;
		lerpdensity = ( SW.Time - 4 ) / 2;
		
	elseif( SW.Time < 18 ) then
		
		
		
	elseif( SW.Time < 20 ) then
		
		startdensity = SW.FogDayDensity;
		enddensity = SW.FogNightDensity;
		lerpdensity = ( SW.Time - 18 ) / 2;
		
	else
		
		startdensity = SW.FogNightDensity;
		enddensity = SW.FogNightDensity;
		
	end
	
	if( !SW.SkyboxVisible ) then
		
		SW.CurFogDensity = math.Approach( SW.CurFogDensity, 0, 0.003 );
		
	else
		
		SW.CurFogDensity = math.Approach( SW.CurFogDensity, Lerp( lerpdensity, startdensity, enddensity ), 0.003 );
		
	end
	
end

function SW.SetupWorldFog()
	
	if( !SW.UpdateFog ) then return false end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( SW.GetCurrentWeather().FogColor ) then
		
		local w = SW.GetCurrentWeather();
		
		render.FogMode( MATERIAL_FOG_LINEAR );
		render.FogStart( w.FogStart );
		render.FogEnd( w.FogEnd );
		render.FogMaxDensity( w.FogMaxDensity * SW.CurFogDensity );
		
		local c = w.FogColor;
		
		render.FogColor( c.r, c.g, c.b );
		
	else
		
		if( !SW.FogSettings or SW.CurFogDensity == 1 ) then return false end
		
		render.FogMode( MATERIAL_FOG_LINEAR );
		render.FogStart( tonumber( SW.FogSettings.fogstart ) );
		render.FogEnd( tonumber( SW.FogSettings.fogend ) );
		render.FogMaxDensity( SW.CurFogDensity * SW.FogSettings.fogmaxdensity );
		
		local col = string.Explode( " ", SW.FogSettings.fogcolor );
		render.FogColor( tonumber( col[1] ), tonumber( col[2] ), tonumber( col[3] ) );
		
	end
	
	return true;
	
end
hook.Add( "SetupWorldFog", "SW.SetupWorldFog", SW.SetupWorldFog );

function SW.SetupSkyboxFog( scale )
	
	if( !SW.UpdateFog ) then return false end
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( SW.GetCurrentWeather().FogColor ) then
		
		local w = SW.GetCurrentWeather();
		
		render.FogMode( MATERIAL_FOG_LINEAR );
		render.FogStart( 0 );
		render.FogEnd( 10 );
		render.FogMaxDensity( w.FogMaxDensity * SW.CurFogDensity );
		
		local c = w.FogColor;
		
		render.FogColor( c.r, c.g, c.b );
		
	elseif( SW.FogSettings ) then
		
		if( !SW.SkyboxFogSettings or SW.CurFogDensity == 1 ) then return false end
		
		render.FogMode( MATERIAL_FOG_LINEAR );
		render.FogStart( tonumber( SW.SkyboxFogSettings.fogstart ) );
		render.FogEnd( tonumber( SW.SkyboxFogSettings.fogend ) );
		render.FogMaxDensity( SW.CurFogDensity * SW.FogSettings.fogmaxdensity );
		
		local col = string.Explode( " ", SW.SkyboxFogSettings.fogcolor );
		render.FogColor( tonumber( col[1] ), tonumber( col[2] ), tonumber( col[3] ) );
		
	end
	
	return true;
	
end
hook.Add( "SetupSkyboxFog", "SW.SetupSkyboxFog", SW.SetupSkyboxFog );