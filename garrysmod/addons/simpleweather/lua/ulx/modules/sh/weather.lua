function ulx.weather( ply, type )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	if( type == "none" ) then
		
		type = "";
		
	end
	
	if( type == "" or SW.Weathers[type] ) then
		
		SW.SetWeather( type );
		ulx.fancyLogAdmin( ply, "#A set weather to #s", type );
		
	else
		
		ply:PrintMessage( 2, "ERROR: invalid weather type \"" .. type .. "\" specified." );
		
	end
	
end
local weather = ulx.command( "SimpleWeather", "ulx weather", ulx.weather, "!weather" )
weather:addParam{ type=ULib.cmds.StringArg, completes={ "none", "rain", "storm", "snow", "blizzard", "fog" }, hint="type", error="invalid weather type \"%s\" specified", ULib.cmds.restrictToCompletes }
weather:defaultAccess( ULib.ACCESS_ADMIN )
weather:help( "Change the weather." )

function ulx.stopweather( ply )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.SetWeather( "" );
	ulx.fancyLogAdmin( ply, "#A turned off weather" );
	
end
local weather = ulx.command( "SimpleWeather", "ulx stopweather", ulx.stopweather, "!stopweather" )
weather:defaultAccess( ULib.ACCESS_ADMIN )
weather:help( "Stop the weather." )

function ulx.autoweather( ply, enabled )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.AutoWeatherEnabled = enabled;
	ulx.fancyLogAdmin( ply, "#A set auto-weather to #s", tostring( enabled ) );
	
end
local weather = ulx.command( "SimpleWeather", "ulx autoweather", ulx.autoweather, "!autoweather" )
weather:addParam{ type=ULib.cmds.BoolArg, hint="enabled" }
weather:defaultAccess( ULib.ACCESS_ADMIN )
weather:help( "Change auto-weather on or off." )

function ulx.settime( ply, time )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.SetTime( time );
	ulx.fancyLogAdmin( ply, "#A set time to #s", tostring( time ) );
	
end
local weather = ulx.command( "SimpleWeather", "ulx settime", ulx.settime, "!settime" )
weather:addParam{ type=ULib.cmds.NumArg, min=0, max=24, default=0, hint="time", error="invalid time \"%s\" specified", ULib.cmds.restrictToCompletes }
weather:defaultAccess( ULib.ACCESS_ADMIN )
weather:help( "Change the time." )

function ulx.enabletime( ply, enabled )
	
	if( table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then return end
	
	SW.PauseTime( !enabled );
	ulx.fancyLogAdmin( ply, "#A set the passage of time to #s", tostring( enabled ) );
	
end
local weather = ulx.command( "SimpleWeather", "ulx enabletime", ulx.enabletime, "!enabletime" )
weather:addParam{ type=ULib.cmds.BoolArg, hint="enabled" }
weather:defaultAccess( ULib.ACCESS_ADMIN )
weather:help( "Change the passage of time on or off." )