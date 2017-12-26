if(SERVER)then
	if(RP_MySQLConfig.EnableMySQL)then
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
			local db = mysqloo.connect( RP_MySQLConfig.Host, RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port )

			function db:onConnected()
				--print( "Database has connected!" )
			end

			function db:onConnectionFailed( err )
				--print( "Connection to database failed!" )
			end

			db:connect()
			
			local rt = default
			
			local query = db:query("SELECT value FROM playerpdata WHERE infoid = " ..  SQLStr(name )  .. " LIMIT 1") -- In mysqloo 9 a query can be started before the database is connected
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

		function RemoveOfflineData( name, steamid )
			local uniqueid = util.CRC( "gm_" .. steamid .. "_gm" )
			name = Format( "%s[%s]", uniqueid, name )
			
			atlaschat.sql.Query("DELETE FROM playerpdata WHERE infoid = " .. SQLStr(name ))
		end

		local meta = FindMetaTable( "Player" )

		function meta:SetPData( name, value )

			name = Format( "%s[%s]", self:UniqueID(), name )
			atlaschat.sql.Query( "REPLACE INTO playerpdata ( infoid, value ) VALUES ( " .. SQLStr( name ) .. ", " .. SQLStr( value ) .. " )" )
		end

		function meta:GetPData( name, default )

			name = Format( "%s[%s]", self:UniqueID(), name )

			local db = mysqloo.connect( RP_MySQLConfig.Host, RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port )

			function db:onConnected()
				--print( "Database has connected!" )
			end

			function db:onConnectionFailed( err )
				--print( "Connection to database failed!" )
			end

			db:connect()
			
			local rt = default
			
			local query = db:query("SELECT value FROM playerpdata WHERE infoid = " .. SQLStr( name ) .. " LIMIT 1") -- In mysqloo 9 a query can be started before the database is connected
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

		function meta:RemovePData( name )

			name = Format( "%s[%s]", self:UniqueID(), name )
			atlaschat.sql.Query( "DELETE FROM playerpdata WHERE infoid = " .. SQLStr( name ) )

		end
	else
	
		sql.Query( "CREATE TABLE IF NOT EXISTS globalvalues ( infoid TEXT NOT NULL PRIMARY KEY, value TEXT );")

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
	end
end

if(CLIENT)then

	sql.Query( "CREATE TABLE IF NOT EXISTS globalvalues ( infoid TEXT NOT NULL PRIMARY KEY, value TEXT );" )

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
end
