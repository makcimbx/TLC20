-- Written by Team Ulysses, http://ulyssesmod.net/
module( "Utime", package.seeall )
if not SERVER then return end

utime_welcome = CreateConVar( "utime_welcome", "1", FCVAR_ARCHIVE )

timer.Simple(1,function()
	atlaschat.sql.Query("CREATE TABLE IF NOT EXISTS utime ( id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT, player BIGINT NOT NULL, totaltime BIGINT NOT NULL, lastvisit BIGINT NOT NULL );")
	atlaschat.sql.Query("CREATE INDEX IDX_UTIME_PLAYER ON utime ( player DESC );")
end)

function onJoin( ply )
	local uid = ply:UniqueID()
	local db = mysqloo.connect( RP_MySQLConfig.Host, RP_MySQLConfig.Username, RP_MySQLConfig.Password, RP_MySQLConfig.Database_name, RP_MySQLConfig.Database_port )

	function db:onConnected()
		--MsgC(Color(255,0,0), "Database has connected!" )
	end

	function db:onConnectionFailed( err )
		MsgC(Color(255,0,0), "Connection to database failed!" )
	end

	db:connect()
	
	local row = nil
	
	local query = db:query("SELECT totaltime FROM utime WHERE player = " .. SQLStr(uid ) .. " LIMIT 1") -- In mysqloo 9 a query can be started before the database is connected
	function query:onSuccess(data)
		if (data and #data > 0) then
			row = data[1].totaltime
		end
	end

	function query:onError(err)
		MsgC(Color(255,0,0),"An error occured while executing the query: " .. err)
	end

	query:start()
	query:wait(false)
	
	
	local time = 0 
	if row != nil then
		if utime_welcome:GetBool() then
			
		end
		atlaschat.sql.Query("UPDATE utime SET lastvisit = " .. SQLStr(os.time() ) .. " WHERE player = " .. SQLStr(uid ) .. ";")
		time = row
	else
		if utime_welcome:GetBool() then
			
		end
		atlaschat.sql.Query("INSERT into utime ( player, totaltime, lastvisit ) VALUES ( " .. SQLStr(uid ) .. ", 0, " .. SQLStr(os.time() ) .. " );")
	end
	ply:SetUTime( time )
	ply:SetUTimeStart( CurTime() )
end
hook.Add( "PlayerInitialSpawn", "UTimeInitialSpawn", onJoin )

function updatePlayer( ply )
	atlaschat.sql.Query("UPDATE utime SET totaltime = " .. SQLStr(math.floor( ply:GetUTimeTotalTime() ) ) .. " WHERE player = " .. SQLStr(ply:UniqueID() ) .. ";")
end
hook.Add( "PlayerDisconnected", "UTimeDisconnect", updatePlayer )

function updateAll()
	local players = player.GetAll()

	for _, ply in ipairs( players ) do
		if ply and ply:IsConnected() then
			updatePlayer( ply )
		end
	end
end
timer.Create( "UTimeTimer", 67, 0, updateAll )
