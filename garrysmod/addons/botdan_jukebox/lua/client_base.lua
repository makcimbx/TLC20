--// Variables (I actually forgot these...) \\--
JukeBox.SongList = {}
JukeBox.QueueList = {}
JukeBox.RequestsList = {}
JukeBox.BansList = {}
JukeBox.IdleSongList = {}
JukeBox.FavouritesList = {}

JukeBox.CurPlaying = false
JukeBox.CurPlayingStart = false
JukeBox.CurPlayingEnd = false

JukeBox.PlayersTunedIn = 0
JukeBox.VoteSkips = 0
JukeBox.HasVoteSkipped = false

JukeBox.PlayerQueuedSongs = 0
JukeBox.PlayerCooldownEnd = false

JukeBox.PlayerAlive = true

JukeBox.PlayerRequestBanned = false
JukeBox.PlayerQueueBanned = false

JukeBox.Quality = "medium"

JukeBox.Cookies = {}
JukeBox.Cookies["JukeBox_Enabled"] = tostring( JukeBox.Settings.DefaultEnabled and not JukeBox.Settings.DisabledOverride )
JukeBox.Cookies["JukeBox_Volume"] = JukeBox.Settings.DefaultVolume
JukeBox.Cookies["JukeBox_ChatStartSong"] = "true"
JukeBox.Cookies["JukeBox_ChatQueueSong"] = "false"
JukeBox.Cookies["JukeBox_ChatSkipSong"] = "true"
JukeBox.Cookies["JukeBox_ChatVoteSkip"] = "true"
JukeBox.Cookies["JukeBox_ChatAdminRequest"] = "false"
JukeBox.Cookies["JukeBox_VideoQuality"]	= "medium" 	-- "small" (240p), "medium" (360p), "large" (480p), "hd720" (720p), "hd1080" (1080p), "highres" (4k)

--// Con-Vars \\--
-- These were buggy, so I phased them out.
--CreateClientConVar( "JukeBox_Enabled", 1, true, false )
--CreateClientConVar( "JukeBox_Volume", JukeBox.Settings.DefaultVolume, true, false )

--// Cookies (hopefully better than Client ConVars) \\--
for k, v in pairs( JukeBox.Cookies ) do
	if isstring( v ) then
		local var = cookie.GetString( k, "failure" )
		if var == "failure" or var == nil then
			cookie.Set( k, v )
		else
			JukeBox.Cookies[k] = var
		end
	else
		var = cookie.GetNumber( k, 9001 )
		if var == 9001 or var == nil then
			cookie.Set( k, v )
		else
			JukeBox.Cookies[k] = var
		end
	end
end

if JukeBox.Settings.DisabledOverride then
	JukeBox.Cookies["JukeBox_Enabled"] = false
end

--[[ COOKIE FUNCTIONS ]]--
function JukeBox:GetCookie( id )
	return JukeBox.Cookies[id]
end

function JukeBox:SetCookie( id, val )
	cookie.Set( id, val )
	JukeBox.Cookies[id] = val
end

--[[ ADMIN FUNCTIONS ]]--
function JukeBox:IsManager( ply )
	local hasULXRank = false
	if JukeBox.Settings.UseULXRanks then
		for k, v in pairs( JukeBox.Settings.ULXRanksList ) do
			if ply:IsUserGroup( v ) then
				hasULXRank = true
			end
		end
	end
	return ply:IsSuperAdmin() or table.HasValue( JukeBox.Settings.SteamIDList, ply:SteamID() ) or hasULXRank
end

--[[ GENERAL FUNCTIONS ]]--
--// Chat print function \\--
function JukeBox:ChatAddText( info, code )
	if not code then return end
	local text = ""
	if type( info ) == "string" then
		if string.StartWith( info, "#" ) then
			text = JukeBox.Lang:GetPhrase( info )
		else
			text = info
		end
	else
		local final = ""
		local subin = {}
		for k, v in pairs( info ) do
			v = tostring(v)
			if k == 1 then
				final = JukeBox.Lang:GetPhrase( v )
			elseif string.StartWith( v, "#" ) then
				v = JukeBox.Lang:GetPhrase( v )
				table.insert( subin, v )
			else
				table.insert( subin, v )
			end
		end
		final = string.format( final, unpack(subin) )
		text = final
	end
	
	if code == "JukeBox_ChatAdminRequest" then if !self:IsManager( LocalPlayer() ) then return end end
	if tobool( self:GetCookie( "JukeBox_Enabled" ) ) then
		if tobool( self:GetCookie( code ) ) then
			chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", text )
		end
	else
		if code == "JukeBox_ChatStartSong" then
			chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", text )
			chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#CHAT_ListenInText", JukeBox.Settings.ChatCommands[1] ) )
		end
	end
end
net.Receive( "JukeBox_ChatMessage", function() JukeBox:ChatAddText( net.ReadTable(), net.ReadString() ) end )

--// Word shortening function \\--
JukeBox.MinWords = {}
function JukeBox:MinWord( word, font, size )
	surface.SetFont( font )
	local newW, newH = surface.GetTextSize( word )
	local newWord = word
	if newW <= size then
		return word
	end

	if not JukeBox.MinWords[font] then
		JukeBox.MinWords[font] = {}
	end
	
	if not JukeBox.MinWords[font][size] then
		JukeBox.MinWords[font][size] = {}
	end
	
	if not JukeBox.MinWords[font][size][word] then
		-- Get the text down to size
		while (newW > size) do
			newWord = string.sub( newWord, 1, string.len( newWord )-1 )
			newW, newH = surface.GetTextSize( newWord )
		end
		-- Remove tailing character and add "..."
		newWord = string.sub( newWord, 1, string.len( newWord )-1 ).."..."
		JukeBox.MinWords[font][size][word] = newWord
	end
	return JukeBox.MinWords[font][size][word]
end

--// Functions for favouriting songs \\--
function JukeBox:GetFavourites()
	if not file.Exists( "JukeBox_Favourites.txt", "DATA" ) then
		file.Write( "JukeBox_Favourites.txt", "" )
	end
	if file.Read( "JukeBox_Favourites.txt", "DATA" ) != "" then
		local TableFromJSON = util.JSONToTable( file.Read( "JukeBox_Favourites.txt", "DATA" ) )
		self.FavouritesList = TableFromJSON
	end
end

--// Saves the favourites list \\--
function JukeBox:SaveFavourites()
	local TableToJSON = util.TableToJSON( self.FavouritesList )
	file.Write( "JukeBox_Favourites.txt", TableToJSON )
end

--// Set a song as a favourite \\--
function JukeBox:UpdateFavourite( id, bool )
	self.FavouritesList[id] = (bool and true or nil)
	self:SaveFavourites()
end

--// Function to stop the JukeBox music \\--
function JukeBox:StopMusic()
	JukeBox:SetCookie( "JukeBox_Enabled", "false" )
	JukeBox:StopVideo()
	JukeBox:IsTunedIn( false )
	chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#CHAT_StoppedJukeBox" ) )
end
net.Receive( "JukeBox_StopMusic", function() JukeBox:StopMusic() end )

--// Functions for IdlePlay \\--
function JukeBox:UpdateIdleSong( id, bool )
	JukeBox.IdleSongList[id] = (bool and true or nil)
	net.Start( "JukeBox_IdleSongUpdate" )
		net.WriteString( id )
		net.WriteBool( bool )
	net.SendToServer()
end

function JukeBox:ReceiveIdleSongs()
	local songs = net.ReadTable()
	JukeBox.IdleSongList = songs
end
net.Receive( "JukeBox_IdleSongUpdate", function() JukeBox:ReceiveIdleSongs() end )

--// Vote to skip the current song \\--
function JukeBox:VoteSkip()
	if not tobool( self:GetCookie( "JukeBox_Enabled" ) ) then
		JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_ListeningToSkip" ), JukeBox.Colours.Issue, "JukeBox/error.png", "SKIP", true )
		return
	end
	if self.HasVoteSkipped then
		JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_AlreadyVoteSkip" ), JukeBox.Colours.Issue, "JukeBox/error.png", "SKIP", true )
	elseif !JukeBox.CurPlaying then
		JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_NoSongPlaying" ), JukeBox.Colours.Issue, "JukeBox/error.png", "SKIP", true )
	else
		net.Start( "JukeBox_VoteSkip" )
		net.SendToServer()
		self.HasVoteSkipped = true
		JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_VotedToSkip" ), JukeBox.Colours.Accept, "JukeBox/tick.png", "SKIP", true )
	end
end

--// Vote to skip from chat \\--
function JukeBox:VoteSkipChat()
	if not tobool( self:GetCookie( "JukeBox_Enabled" ) ) then
		chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#NOTIFY_ListeningToSkip" ))
		return
	end
	if self.HasVoteSkipped then
		chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#NOTIFY_AlreadyVoteSkip" ))
	elseif !JukeBox.CurPlaying then
		chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#NOTIFY_NoSongPlaying" ))
	else
		net.Start( "JukeBox_VoteSkip" )
		net.SendToServer()
		self.HasVoteSkipped = true
		chat.AddText( JukeBox.Colours.ChatBase, "[", JukeBox.Colours.ChatHighlight, JukeBox.Lang:GetPhrase( "#HEADING_Name" ), JukeBox.Colours.ChatBase, "] ", JukeBox.Lang:GetPhrase( "#NOTIFY_VotedToSkip" ))
	end
end
net.Receive( "JukeBox_VoteSkipChat", function() JukeBox:VoteSkipChat() end )

--// Force skip for admins \\--
function JukeBox:ForceSkip()
	if JukeBox:IsManager( LocalPlayer() ) then
		if !JukeBox.CurPlaying then
			JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_NoSongPlaying" ), JukeBox.Colours.Issue, "JukeBox/error.png", "SKIP", true )
		else
			net.Start( "JukeBox_ForceSkip" )
			net.SendToServer()
		end
	end
end

function JukeBox:UpdateTunedIn()
	local count = tonumber( net.ReadString() )
	self.PlayersTunedIn = count
end
net.Receive( "JukeBox_PlayersTunedIn", function() JukeBox:UpdateTunedIn() end )

function JukeBox:IsTunedIn( bool )
	net.Start( "JukeBox_PlayersTunedIn" )
		net.WriteBool( bool )
	net.SendToServer()
end

--// Update vote skips info \\--
function JukeBox:VoteSkipUpdate()
	local amount = tonumber( net.ReadString() )
	self.VoteSkips = amount
end
net.Receive( "JukeBox_VoteSkip", function() JukeBox:VoteSkipUpdate() end )

--// Reset vote skips \\--
function JukeBox:ResetVoteSkips()
	self.VoteSkips = 0
	self.HasVoteSkipped = false
end

--[[ SONG START FUNCTIONS ]]--
--// Play next song \\--
function JukeBox:PlayNext()
	local playID = net.ReadString()
	if not self.SongList[playID] then return end
	if self.SongList[playID].starttime or self.SongList[playID].endtime then
		self:PlayNextWithTimes( playID )
		self:ResetVoteSkips()
	else
		self:PlayVideo( playID )
		self:ResetVoteSkips()
		self.CurPlaying = playID
		self.CurPlayingStart = os.time()
		self.CurPlayingEnd = os.time()+self.SongList[playID].length
	end
end
net.Receive( "JukeBox_PlayNext", function() JukeBox:PlayNext() end )

--// Ask for current song time \\--
function JukeBox:PlayReEnabled()
	net.Start( "JukeBox_ReEnabled" )
	net.SendToServer()
end

--// Play next song function extended \\--
function JukeBox:PlayNextWithTimes( playID )
	if not self.SongList[playID] then return end
	if self.SongList[playID].starttime and !self.SongList[playID].endtime then --| Only startTime
		self:PlayVideoFromTime( playID, self.SongList[playID].starttime )
		self.CurPlaying = playID
		self.CurPlayingStart = os.time()
		self.CurPlayingEnd = os.time()+self.SongList[playID].length-self.SongList[playID].starttime
	elseif !self.SongList[playID].starttime and self.SongList[playID].endtime then --| Only endTime
		self:PlayVideoUntilTime( playID, self.SongList[playID].endtime )
		self.CurPlaying = playID
		self.CurPlayingStart = os.time()
		self.CurPlayingEnd = os.time()+self.SongList[playID].length-(self.SongList[self.CurPlaying].length-self.SongList[self.CurPlaying].endtime)
	elseif self.SongList[playID].starttime and self.SongList[playID].endtime then --| Both startTime and endTime
		self:PlayVideoWithTimes( playID, self.SongList[playID].starttime, self.SongList[playID].endtime )
		self.CurPlaying = playID
		self.CurPlayingStart = os.time()
		self.CurPlayingEnd = os.time()+self.SongList[playID].length-self.SongList[playID].starttime-(self.SongList[self.CurPlaying].length-self.SongList[self.CurPlaying].endtime)
	else --| Something went wrong
		print( "JukeBox Issue" )
	end
end

--// Play next from time \\--
function JukeBox:PlayNextTime()
	local playID = net.ReadString()
	local playTime = tostring( net.ReadString() )
	local resetVoteSkip = net.ReadBool()
	if not self.SongList[playID] then return end
	if self.SongList[playID].starttime then
		playTime = playTime + self.SongList[playID].starttime
	end
	self:PlayVideoFromTime( playID, playTime )
	self.CurPlaying = playID
	self.CurPlayingStart = os.time()-playTime
	self.CurPlayingEnd = os.time()-playTime+self.SongList[playID].length
end
net.Receive( "JukeBox_PlayNextTime", function() JukeBox:PlayNextTime() end )

--// Set everything to nothing \\--
function JukeBox:NoSong()
	self:StopVideo()
	self:ResetVoteSkips()
	self.CurPlaying = false
	self.CurPlayingStart = false
	self.CurPlayingEnd = false
end
net.Receive( "JukeBox_NoSong", function() JukeBox:NoSong() end )

--// Receive all songs 2 \\--
function JukeBox:ReceieveAllSongs2()
	if net.ReadBool() == true then
		self.SongList = {}
	end
	local part = net.ReadTable()
	table.Merge( self.SongList, part )
	if net.ReadBool() == true then
		hook.Call( "JukeBox_AllSongsUpdated" )
	end
end
net.Receive( "JukeBox_AllSongs2", function() JukeBox:ReceieveAllSongs2() end )

--// Receive all songs \\--
function JukeBox:ReceiveAllSongs()
	local allSongs = net.ReadType( TYPE_TABLE )
	self.SongList = allSongs
	hook.Call( "JukeBox_AllSongsUpdated" )
end
net.Receive( "JukeBox_AllSongs", function() JukeBox:ReceiveAllSongs() end )

--// Receive song queue \\--
function JukeBox:ReceiveQueue()
	local queue = net.ReadTable()
	self.QueueList = queue
	hook.Call( "JukeBox_QueueUpdated" )
end
net.Receive( "JukeBox_Queue", function() JukeBox:ReceiveQueue() end )

--// Receive requests \\--
function JukeBox:ReceiveRequests()
	local requests = net.ReadTable()
	self.RequestsList = requests
	hook.Call( "JukeBox_RequestsUpdated" )
end
net.Receive( "JukeBox_Requests", function() JukeBox:ReceiveRequests() end )

--// Add song to queue \\--
function JukeBox:QueueSong( id )
	net.Start( "JukeBox_QueueSong" )
		net.WriteString( id )
	net.SendToServer()
end

--// Function to remove song from Queue \\--
function JukeBox:DeleteQueuedSong( id )
	net.Start( "JukeBox_DeleteQueuedSong" )
		net.WriteString( id )
	net.SendToServer()
end

--// Updates song info \\--
function JukeBox:UpdateSong( data )
	net.Start( "JukeBox_UpdateSong" )
		net.WriteTable( data )
	net.SendToServer()
end

--// Deletes a song \\--
function JukeBox:DeleteSong( id )
	net.Start( "JukeBox_DeleteSong" )
		net.WriteString( id )
	net.SendToServer()
end

--[[ REQUEST FUNCTIONS ]]--
--// Send request \\--
function JukeBox:AddRequest( data )
	net.Start( "JukeBox_AddRequest" )
		net.WriteTable( data )
	net.SendToServer()
end

--// Fasttrack request \\--
function JukeBox:FasttrackRequest( data )
	net.Start( "JukeBox_FasttrackRequest" )
		net.WriteTable( data )
	net.SendToServer()
end

--// Accept request \\--
function JukeBox:AcceptRequest( data )
	net.Start( "JukeBox_AcceptRequest" )
		net.WriteTable( data )
	net.SendToServer()
end

--// Deny request \\--
function JukeBox:DenyRequest( id )
	net.Start( "JukeBox_DenyRequest" )
		net.WriteString( id )
	net.SendToServer()
end

--[[ BAN FUNCTIONS ]]--
--// Update a ban \\--
function JukeBox:UpdateBan( data )
	net.Start( "JukeBox_UpdateBan" )
		net.WriteTable( data )
	net.SendToServer()
end

--// Receive Bans \\--
function JukeBox:ReceieveBans()
	local requestban = net.ReadBool()
	local queueban = net.ReadBool()
	local bans = net.ReadTable()
	
	JukeBox.PlayerRequestBanned = requestban
	JukeBox.PlayerQueueBanned = queueban
	
	if bans then
		JukeBox.BansList = bans
		hook.Call( "JukeBox_BansUpdated" )
	end
end
net.Receive( "JukeBox_Bans", function() JukeBox:ReceieveBans() end )

--[[ VGUI FUNCTIONS ]]--
--// CREATING A POPUP \\--
function JukeBox:CreatePopup()
	self.VGUI:CreatePopup( JukeBox.Lang:GetPhrase( net.ReadString() ), JukeBox.Lang:GetPhrase( net.ReadString() ) )
	JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( "#NOTIFY_URLInUse" ), JukeBox.Colours.Issue, "JukeBox/warning.png", "REQUEST", true )
end
net.Receive( "JukeBox_Popup", function() JukeBox:CreatePopup() end )

--// Create a notification \\--
function JukeBox:CreateNotification()
	local info = net.ReadTable()
	if not ValidPanel( JukeBox.VGUI.VGUI ) then return end
	if type( info.text ) == "string" then
		if string.StartWith( info.text, "#" ) then
			JukeBox.VGUI.VGUI:MakeNotification( JukeBox.Lang:GetPhrase( info.text ), info.colour, info.mat, info.id, info.killID )
		else
			JukeBox.VGUI.VGUI:MakeNotification( info.text, info.colour, info.mat, info.id, info.killID )
		end
	else
		local final = ""
		local subin = {}
		for k, v in pairs( info.text ) do
			v = tostring(v)
			if k == 1 then
				final = JukeBox.Lang:GetPhrase( v )
			elseif string.StartWith( v, "#" ) then
				v = JukeBox.Lang:GetPhrase( v )
				table.insert( subin, v )
			else
				table.insert( subin, v )
			end
		end
		final = string.format( final, unpack(subin) )
		JukeBox.VGUI.VGUI:MakeNotification( final, info.colour, info.mat, info.id, info.killID )
	end
end
net.Receive( "JukeBox_Notification", function() JukeBox:CreateNotification() end )

--// Start-up Hook \\--
net.Receive( "JukeBox_StartUp", function()
	JukeBox:GetFavourites()
	JukeBox:IsTunedIn( tobool( JukeBox:GetCookie( "JukeBox_Enabled" ) ) )
	JukeBox:SetVolume( JukeBox:GetCookie( "JukeBox_Volume" ) ) -- This is a backup in case the page didn't load quick enough
	JukeBox.Quality = JukeBox:GetCookie( "JukeBox_VideoQuality" )
end )

--// Is Alive Hook \\--
if not JukeBox.Settings.PlayWhileAlive then
	hook.Add( "Think", "JukeBox_ClientAlive", function()
		local ply = LocalPlayer()
		if (!ply:Alive() or (ply:GetObserverMode() != OBS_MODE_NONE)) and not JukeBox.PlayerAlive then
			JukeBox:PlayReEnabled()
			JukeBox.PlayerAlive = true
		elseif (ply:Alive() and (ply:GetObserverMode() == OBS_MODE_NONE)) and JukeBox.PlayerAlive then
			JukeBox:StopVideo()
			JukeBox.PlayerAlive = false
		end
	end )
end

--[[ PRINT FUNCTION FOR DEBUG ]]--
function JukeBox:Print( text, override )
	if override then
		MsgC( Color(211, 84, 0), "\nJukeBox ", Color( 160, 230, 230 ), "[CLIENT]", Color(243, 156, 18), " - "..text )
	elseif self.DevMode then
		MsgC( Color(211, 84, 0), "\nJukeBox ", Color( 160, 230, 230 ), "[CLIENT]", Color(41, 128, 185), "[DEV]", Color(243, 156, 18), " - "..text )
	end	
end