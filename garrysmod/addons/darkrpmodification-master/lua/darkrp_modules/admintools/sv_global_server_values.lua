if ( !sql.TableExists( "globalvalues" ) ) then

	sql.Query( "CREATE TABLE IF NOT EXISTS globalvalues ( infoid TEXT NOT NULL PRIMARY KEY, value TEXT );" )

end

function GetData( name, default )

	local val = sql.QueryValue( "SELECT value FROM globalvalues WHERE infoid = " .. SQLStr( name ) .. " LIMIT 1" )
	if ( val == nil ) then return default end

	return val

end

function SetData( name, value )

	sql.Query( "REPLACE INTO globalvalues ( infoid, value ) VALUES ( " .. SQLStr( name ) .. ", " .. SQLStr( value ) .. " )" )

end

function RemoveData( name )

	sql.Query( "DELETE FROM globalvalues WHERE infoid = " .. SQLStr( name ) )

end

function SetOfflineData( name, value, steamid )
	local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
	name = Format( "%s[%s]", uniqueid, name )
	sql.Query( "REPLACE INTO playerpdata ( infoid, value ) VALUES ( " .. SQLStr( name ) .. ", " .. SQLStr( value ) .. " )" )

end

function GetOfflineData( name, steamid , default )
	local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
	name = Format( "%s[%s]", uniqueid, name )
	local val = sql.QueryValue( "SELECT value FROM playerpdata WHERE infoid = " .. SQLStr( name ) .. " LIMIT 1" )
	if ( val == nil ) then return default end

	return val

end

function RemoveOfflineData( name, steamid )

	local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
	name = Format( "%s[%s]", uniqueid, name )
	sql.Query( "DELETE FROM playerpdata WHERE infoid = " .. SQLStr( name ) )

end