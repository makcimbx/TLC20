--[[ MySQL SAVING INFORMATION ]]--
-- Requires mysqloo from here:
-- https://facepunch.com/showthread.php?t=1357773&p=43754012&viewfull=1#post43754012
-- Follow the instructions at the bottom of the post for installation.
-- Download the correct 2 files for the server's OS and place where instructed.
-- Once MySQL is enabled, use the following console command in the server's console:
-- JukeBox_TransferSongs
-- to transfer all currently saves songs in the txt file to the MySQL table.

JukeBox.Settings.MySQL = {}

-- This dictates whether to use MySQL for the All Songs list.
-- If set to true, all the details below will need filling in.
JukeBox.Settings.MySQL.UseMySQL = true

-- The IP of the MySQL database
local Host = "server191.hosting.reg.ru"

-- The username used to access the MySQL database
local Username = "u0426341_gmod"

-- The password used with the username to access the MySQL database
local Password = "vstreza555"

-- The port of the MySQL database
local Port = 3306

-- The name of the MySQL database
local Database = "u0426341_gmod"

--[[ END OF SETTINGS, DO NOT EDIT ]]--
--// BEGINNING OF MYSQL \\--
JukeBox.MySQL = {}
JukeBox.MySQL.Connection = nil
JukeBox.MySQL.Available = false
JukeBox.MySQL.Transferred = false

if not JukeBox.Settings.MySQL.UseMySQL then return end
JukeBox.MySQL.Available = true

require( "mysqloo" )

local db = mysqloo.connect( Host, Username, Password, Database, Port )
function db:onConnected()

    print( "[JukeBox] Connection Status....OK" )
	
	JukeBox.MySQL.Connection = self
	JukeBox.MySQL:CheckTable()

end
function db:onConnectionFailed( err )
    print( "[JukeBox] Connection Status....FAIL \n[JukeBox] Error: "..err )
end
print( "[JukeBox] Queueing MySQL Connection..." )
db:connect()

function JukeBox.MySQL:CheckTable()
	if not self.Connection then return end
	
	local q = self.Connection:query( "CREATE TABLE IF NOT EXISTS JukeBox_AllSongs( id varchar(11), name varchar(100), artist varchar(100), length int, starttime int, endtime int );" )
	function q:onSuccess( data )
		print( "[JukeBox] Table Status.........OK" )
		JukeBox.MySQL:GetSongsData()
	end
	function q:onError( err, sql )
		print( "[JukeBox] Table Status.........FAIL \n[JukeBox] Error: "..err )
	end
	q:start()
end

function JukeBox.MySQL:GetSongsData()
	if not self.Connection then return end
	
	local q = self.Connection:query( "SELECT * FROM JukeBox_AllSongs;" )
	function q:onSuccess( data )
		print( "[JukeBox] Data Status..........OK" )
		print( "[JukeBox] Received "..#data.." results from All Songs table." )
		for k, v in pairs( data ) do
			if v.starttime == 0 then
				v.starttime = nil
			end
			if v.endtime == v.length then
				v.endtime = nil
			end
			JukeBox.SongList[v.id] = v
		end
		JukeBox:SendAllSongs()
	end
	function q:onError( err, sql )
		print( "[JukeBox] Data Status..........FAIL \n[JukeBox] Error: "..err )
	end
	q:start()
end

function JukeBox.MySQL:AddSong( data )
	if not self.Connection then return end
	
	self:DeleteSong( data.id )
	
	data.id = self.Connection:escape( data.id )
	data.name = self.Connection:escape( data.name )
	data.artist = self.Connection:escape( data.artist )
	if not data.starttime then data.starttime = 0 end
	if not data.endtime then data.endtime = data.length end
	
	local q = self.Connection:query( "INSERT INTO JukeBox_AllSongs VALUES( \""..data.id.."\", \""..data.name.."\", \""..data.artist.."\", "..data.length..", "..data.starttime..", "..data.endtime.." );" )
	function q:onSuccess( data )

	end
	function q:onError( err, sql )

	end
	q:start()
	
end

function JukeBox.MySQL:DeleteSong( id )
	if not self.Connection then return end
	
	id = self.Connection:escape( id )
	
	local q = self.Connection:query( "DELETE FROM JukeBox_AllSongs WHERE id=\""..id.."\";" )
	function q:onSuccess( data )

	end
	function q:onError( err, sql )

	end
	q:start()
end

function JukeBox.MySQL:TransferSongs()
	if not self.Connection then
		print( "[JukeBox] Can't transfer songs as MySQL conection isn't established." )
		return
	end
	
	print( "[JukeBox] Beginning song transfer." )
	if file.Read( "JukeBox_AllSongs.txt", "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( "JukeBox_AllSongs.txt", "DATA" ) )
		for k, v in pairs( TableFromJSON ) do
			self:AddSong( v )
		end
		print( "[JukeBox] Transferred "..table.Count(TableFromJSON).." songs from text file.\n[JukeBox] Songs will be loaded next level change/restart." )
	else
		print( "[JukeBox] File is empty, transferred 0 songs." )
	end
end
concommand.Add( "JukeBox_TransferSongs", function( ply )
	if IsValid(ply) then return end
	if JukeBox.MySQL.Transferred then
		print( "[JukeBox] You have already transferred the songs list, please change level and try again." )
		return
	end
	JukeBox.MySQL:TransferSongs()
	JukeBox.MySQL.Transferred = true
end )

function JukeBox.MySQL:AddTestSong()
	if not self.Connection then return end
	
	local q = self.Connection:query( "INSERT INTO JukeBox_AllSongs VALUES( \"12345678911\", \"Song Name\", \"Song Artist\", 123, 0, 123 );" )
	function q:onSuccess( data )
		print( "[JukeBox] Added a Test Song..." )
	end
	function q:onError( err, sql )
		print( "[JukeBox] Error: "..err )
	end
	q:start()
end