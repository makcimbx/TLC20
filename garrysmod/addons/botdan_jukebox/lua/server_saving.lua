--// Names of the text documents to save in \\--
			-- DON'T CHANGE THESE! --
local textAllSongs 	= "JukeBox_AllSongs.txt"
local textQueue 	= "JukeBox_CurrentQueue.txt"
local textRequests 	= "JukeBox_Requests.txt"
local textCooldowns = "JukeBox_CoolDowns.txt"
local textExtra		= "JukeBox_ExtraData.txt"
local textBans		= "JukeBox_Bans.txt"
local textIdleSongs	= "JukeBox_IdleSongs.txt"

--// Initial text document creation \\--
function JukeBox:CheckSaves()
	if not file.Exists( textAllSongs, "DATA" ) then
		file.Write( textAllSongs, "" )
	end
	if not file.Exists( textQueue, "DATA" ) then
		file.Write( textQueue, "" )
	end
	if not file.Exists( textCooldowns, "DATA" ) then
		file.Write( textCooldowns, "" )
	end
	if not file.Exists( textRequests, "DATA" ) then
		file.Write( textRequests, "" )
	end
	if not file.Exists( textExtra, "DATA" ) then
		file.Write( textExtra, "" )
	end
	if not file.Exists( textBans, "DATA" ) then
		file.Write( textBans, "" )
	end
	if not file.Exists( textIdleSongs, "DATA" ) then
		file.Write( textIdleSongs, "" )
	end
end

--// Gets all the saved data \\--
function JukeBox:GetSaveData()
	self:CheckSaves()
	
	if not JukeBox.Settings.MySQL.UseMySQL or not JukeBox.MySQL.Available then
		if file.Read( textAllSongs, "DATA" ) != "" then
			local TableFromJSON = util.JSONToTable( file.Read( textAllSongs, "DATA" ) )
			for k, v in pairs( TableFromJSON ) do
				JukeBox.SongList[v.id] = v
			end
		end
	end
	
	if file.Read( textQueue, "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( textQueue, "DATA" ) )
		JukeBox.QueueList = TableFromJSON
		JukeBox:FixQueue()
		JukeBox:CheckQueue()
	end
	
	if file.Read( textRequests, "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( textRequests, "DATA" ) )
		for k, v in pairs( TableFromJSON ) do
			table.insert( JukeBox.RequestsList, v )
		end
	end
	
	if file.Read( textBans, "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( textBans, "DATA" ) )
		for k, v in pairs( TableFromJSON ) do
			JukeBox.BansList[v.steamid64] = v
		end
	end
	
	if file.Read( textIdleSongs, "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( textIdleSongs, "DATA" ) )
		JukeBox.IdleSongList = TableFromJSON
	end
	
	if JukeBox.Settings.UseCooldowns then
		if file.Read( textCooldowns, "DATA" ) != "" then
			local TableFromJSON = util.JSONToTable( file.Read( textCooldowns, "DATA" ) )
			for k, v in pairs( TableFromJSON ) do
				if v+JukeBox.Settings.CooldownAmount > os.time() then
					JukeBox.CooldownsList[k] = v
				end
			end
		end
	end
end
hook.Add( "Initialize", "JukeBox_ServerStartUp", function()
	JukeBox:GetSaveData()
end )

--// Save all songs list \\--
function JukeBox:SaveAllSongs()
	local TableToJSON = util.TableToJSON( self.SongList )
	file.Write( textAllSongs, TableToJSON )
end

--// Save current queue \\--
function JukeBox:SaveQueue()
	local TableToJSON = util.TableToJSON( self.QueueList )
	file.Write( textQueue, TableToJSON )
end

--// Save requests \\--
function JukeBox:SaveRequests()
	local TableToJSON = util.TableToJSON( self.RequestsList )
	file.Write( textRequests, TableToJSON )
end

--// Save cooldowns \\--
function JukeBox:SaveCooldowns()
	local TableToJSON = util.TableToJSON( self.CooldownsList )
	file.Write( textCooldowns, TableToJSON )
end

--// Save idle list \\--
function JukeBox:SaveIdleList()
	local TableToJSON = util.TableToJSON( self.IdleSongList )
	file.Write( textIdleSongs, TableToJSON )
end

--// Save current song+time \\--
function JukeBox:SavePlaying()
	local info
	if self.CurPlaying then
		info = { id = self.CurPlaying, time = self.CurPlayingEnd-self.CurPlayingStart }
	else
		info = { id = false, time = false }
	end
	local TableToJSON = util.TableToJSON( info )
	file.Write( textExtra, TableToJSON )
end

--// Save player bans \\--
function JukeBox:SaveBans()
	local TableToJSON = util.TableToJSON( self.BansList )
	file.Write( textBans, TableToJSON )
end