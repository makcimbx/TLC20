
if((RP_MySQLConfig.EnableMySQL==false and SERVER) or CLIENT)then
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
else

	hook.Add( "atlaschat.DatabaseConnected", "Another unique name", function(f)
		atlaschat.sql.Query("CREATE TABLE IF NOT EXISTS globalvalues ( infoid VARCHAR(255) NOT NULL PRIMARY KEY, value VARCHAR(255) )")
		atlaschat.sql.Query("CREATE TABLE IF NOT EXISTS playerpdata ( infoid VARCHAR(255) NOT NULL PRIMARY KEY, value VARCHAR(255) )")
	end )

	require( "mysqloo" )
	
	function GetData( name, default )
		local db = mysqloo.connect( RP_MySQLConfig.Host, RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port )

		function db:onConnected()
			--print( "Database has connected!" )
		end

		function db:onConnectionFailed( err )
			--print( "Connection to database failed!" )
		end

		db:connect()
		
		local rt = default
		
		local query = db:query("SELECT value FROM globalvalues WHERE infoid = " ..  SQLStr(name )  .. " LIMIT 1") -- In mysqloo 9 a query can be started before the database is connected
		function query:onSuccess(data)
			if (data and #data > 0) then
				rt = data[1].value
			end
		end

		function query:onError(err)
			print("An error occured while executing the query: " .. err)
		end

		query:start()
		query:wait(false)
		return rt
	end
	
	function SetData( name, value )
		atlaschat.sql.Query("REPLACE INTO globalvalues ( infoid, value ) VALUES ( " ..  SQLStr(name )  .. ", " ..  SQLStr(value )  .. " )")
	end
	
	function RemoveData( name )
		atlaschat.sql.Query("DELETE FROM globalvalues WHERE infoid = " ..  SQLStr(name ))
	end
	
	function SetOfflineData( name, value, steamid )
		local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
		name = Format( "%s[%s]", uniqueid, name )
		
		atlaschat.sql.Query("REPLACE INTO playerpdata ( infoid, value ) VALUES ( " ..  SQLStr(name )  .. ", " ..  SQLStr(value )  .. " )")
	end
	
	function GetOfflineData( name, steamid , default )
		local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
		name = Format( "%s[%s]", uniqueid, name )
		local rt = ""
		
		return atlaschat.sql.Query("SELECT value FROM playerpdata WHERE infoid = " ..  SQLStr(name )  .. " LIMIT 1", function(data, query)
			if (data and #data > 0) then
				rt = data[1].value
			end
		end)
	end

	function RemoveOfflineData( name, steamid )
		local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
		name = Format( "%s[%s]", uniqueid, name )
		
		atlaschat.sql.Query("DELETE FROM playerpdata WHERE infoid = " .. SQLStr(name ))
	end
end