JukeBox.Settings = {}
JukeBox.Colours = {}

--| GENERAL SETTINGS |------------------------------------------------------------------------------------
-- This decides whether new players should be bale to hear the JukeBox or not
-- This option only sets a config for new players on first join and they can enable the JukeBox themselves after.
JukeBox.Settings.DefaultEnabled = false

-- Use this to make sure when ANYONE joins the server the JukeBox is off by default, even if they've used it before.
-- This may be useful for gamemodes where the JukeBox mak be intrusive.
JukeBox.Settings.DisabledOverride = false

-- This sets whether downloads should be done via workshop or FastDL
-- If set to false, the files within the "materials" folder should be put on your FastDL
JukeBox.Settings.UseWorkshop = true

-- This is the URL to the YouTube player HTML page provided.
-- The link provided should work, this shouldn't need changing
JukeBox.Settings.PlayerURL = "http://botdan.com/JukeBox/VideoPlayer/"
-- Backup [OLD] http://dantheradarman.github.io/JukeBox.html
-- Backup [OLD] http://pulsifygaming.com/BOTDan/JukeBox/VideoPlayer/index.html

-- This is the URL that checks if the videos are real
-- DON'T change this unless you've uploaded the PHP file somewhere else.
JukeBox.Settings.CheckerURL = "http://botdan.com/JukeBox/VideoLength/?id="
-- Backup [OLD] http://www.pulsifygaming.com/BOTDan/JukeBox/VideoLength/?id=

-- This is the URL that gets the search data for the Add a song - Search tab
-- DON'T change this unless you've uploaded the PHP file somewhere else.
JukeBox.Settings.SearchURL = "http://botdan.com/JukeBox/VideoSearch/?search="

-- The default volume for new users of the player
-- This can be between 0 and 100 (0 = can't hear)
JukeBox.Settings.DefaultVolume = 50

-- Time in seconds to add to the song length to allow for lag
-- This will help people with slower connections hear the whole song.
JukeBox.Settings.LagCompensationTime = 2

-- The maximum length of a song before it can't be added (in seconds)
-- Set this number very high if you require no limit. (60*30 = 30 minutes)
JukeBox.Settings.MaxSongLength = 60*999

--| TTT SETTINGS |----------------------------------------------------------------------------------------
-- Whether songs should play while a player is alive
-- Useful for gamemodes where voice chat is needed while alive.
JukeBox.Settings.PlayWhileAlive = true

-- Whether songs should only play during the downtime in TTT
-- This is in between the time of the round ending and the prep phase starting.
-- /!\ JukeBox.Settings.PlayWhileAlive should be true for this to work! /!\
JukeBox.Settings.TTTOnlyRoundEnd = false

--| QUEUING COST |----------------------------------------------------------------------------------------
-- Whether to use Pointshop 1 Points to queue songs
-- Set to true to enable or false to disable
JukeBox.Settings.UsePointshop = false

-- Whether to use Pointshop 2 Points to queue songs
-- Set to true to enable or false to disable
JukeBox.Settings.UsePointshop2 = false

-- How much it costs to queue a song
-- This only works if Pointshop 1 or 2 are set to true
JukeBox.Settings.PointsCost = 15000

-- Whether to use DarkRP cash to queue songs
-- Make sure if set to true that UsePointshop is set to false
JukeBox.Settings.UseDarkRPCash = false

-- How much it costs to queue a song
-- This only works if the above is set to true
JukeBox.Settings.DarkRPCashCost = 500

-- Whether to use Sandbox Simple Money System to queue a song
-- Requires http://steamcommunity.com/sharedfiles/filedetails/?id=620306794
-- Make sure to set the other 3 to false
JukeBox.Settings.UseSimpleMoney = false

-- How much it costs to queue a song
-- This only works if the above is set to true
JukeBox.Settings.SimpleMoneyCost = 100

--| PLAYER COOLDOWNS |------------------------------------------------------------------------------------
-- Whether players should be limited to how many songs they queue
-- Below you can change how many songs that can queue in a certain time
JukeBox.Settings.UsePlayerCooldowns = true

-- The amount of time it takes for the queue limit to reset (in seconds)
-- This is measures in seconds. (60*10 = 10 minutes)
JukeBox.Settings.PlayerCooldownsTime = 60*10
-- Override cooldowns time for certain groups.
-- Format: ["GROUPNAME"] = TIME,
JukeBox.Settings.PlayerCooldownsTimeList = {
	["superadmin"] = 60*5,
}

-- How many songs a player can queue per the time above.
-- By default, this allows users to request 2 songs every 10 minutes.
JukeBox.Settings.PlayerCooldownsLimit = 3
-- Override cooldowns limit for certain groups.
-- Format: ["GROUPNAME"] = LIMIT,
JukeBox.Settings.PlayerCooldownsLimitList = {
	["superadmin"] = 4,
}

--| SONG COOLDOWNS |--------------------------------------------------------------------------------------
-- Whether songs should be blocked from being queued after playing.
-- This prevents the same songs playing over and over again.
JukeBox.Settings.UseCooldowns = true

-- How long the song should be blocked for after playing.
-- The time is done in seconds and is applied at the end of the song. (60*15 = 15mins)
JukeBox.Settings.CooldownAmount = 60*15

-- A list of groups that can bypass the song cooldown limits.
-- Don't edit this if you don't want any groups to bypass the cooldowns.
JukeBox.Settings.CooldownBypassers = {
--	"superadmin",
}

--| RESTRICTIONS |----------------------------------------------------------------------------------------
-- Whether the JukeBox should be restricted from certain ranks.
-- This can be used to make the JukeBox donator only.
JukeBox.Settings.UseGroupRestrictions = true

-- If the Group Restrictions should work as a whitelist.
-- This means that anyone in the list below WILL be able to queue songs, everyone else won't be.
JukeBox.Settings.GroupRestrctionWhiteList = true

-- The list of groups that CAN'T or CAN use the JukeBox.
-- Restricts users from being able to queue songs.
JukeBox.Settings.RestrictedGroups = {
	"superadmin",
	"none",
}

--| MISC |------------------------------------------------------------------------------------------------
-- If requests should be automatically added to the All Songs list
-- This means the Manager Requests tab will not be used.
JukeBox.Settings.AutoAcceptRequests = false

-- This allows users to pay a bit extra to have their request added straight to the All Songs list
-- This is good for servers that don't have a huge Manager population
JukeBox.Settings.RequestFasttrack = false

-- How much it costs to skip the Manager approval system
-- NOTE: This uses whatever currency system you have enabled up top (PS1, PS2 or DarkRP Cash)
JukeBox.Settings.RequestFasttrackCost = 250

-- If queueing songs can only be done by managers (I RECOMMEND RESTRICTIONS INSTEAD ABOVE)
-- This prevents users from queueing songs but they can still request
JukeBox.Settings.ManagerOnlyMode = true

-- The percentage of players that have to vote skip a song for it to skip
-- This is done as a decimal from 0 to 1 (0.6 = 60%)
JukeBox.Settings.VoteSkipPercent = 0.6

-- This is how long the notifications at the top of the JukeBox stay around for in seconds
-- Set this to 0 to disable the timer.
JukeBox.Settings.NotificationTimer = 10

--| QUICK KEY |-------------------------------------------------------------------------------------------
-- Whether a key should be used to open the VGUI
-- This key ideally should be a KEY_F followed by a number (KEY_F8 is F8)
JukeBox.Settings.UseQuickKey = true

-- The key to open the menu with
-- Key values can be found at http://wiki.garrysmod.com/page/Enums/KEY
JukeBox.Settings.QuickKey = KEY_F8

--| IDLE PLAY |-------------------------------------------------------------------------------------------
-- Should the JukeBox automatically play songs if none are queue'd?
-- This sort of turns the JukeBox into a radio while no ongs are queue'd
JukeBox.Settings.EnableIdlePlay = false

-- Whether, when a new song is queue'd, it should start it instantly
-- This means it will cut off the current idle song and play the first in the queue
JukeBox.Settings.IdlePlayCutoff = false

-- How long to wait before starting the idle play
-- This stops the JukeBox from instantly playing idle songs
JukeBox.Settings.IdlePlayDelay = 15

-- How long to wait in-between idle play songs
-- Good if you want some time betweeen each song
JukeBox.Settings.IdlePlaySpacing = 10

--| ULX RANKS + COMMANDS |--------------------------------------------------------------------------------------------
-- If a/multiple ULX ranks should be used for manager rank on the JukeBox
-- This allows them to add, edit and remove songs
JukeBox.Settings.UseULXRanks = true

-- The ULX ranks to have access to the manager parts of the JukeBox
-- Only used if the above setting is set to true
JukeBox.Settings.ULXRanksList = {
	"superadmin",
	"Helper",
	"Eventmaker",
	"Moderator",
}

-- SteamIDs that have access to the manager parts of the JukeBox
JukeBox.Settings.SteamIDList = {
	"",
}

-- Commands to open the JukeBox VGUI
JukeBox.Settings.ChatCommands = {
	"!jb",
	"!jukebox",
	"/jukebox",
	"/jb",
}

-- Commands to voteskip the current song
JukeBox.Settings.SkipCommands = {
	"!skipsong",
	"/skipsong",
}

-- Commands to stop the JukeBox
JukeBox.Settings.StopCommand = {
	"!stop",
	"/stop",
}

--| HUD SETTINGS |----------------------------------------------------------------------------------------
-- Whether the HUD element should be displayed
-- This displayes the currently playing song name and artist
JukeBox.Settings.HUDEnabled = true

-- If the HUD element should be left, right or center
-- "left", "right" or "center" only.
JukeBox.Settings.HUDAcross = "center"

-- If the HUD element should be top, bottom or center
-- "top", "bottom" or "center" only
JukeBox.Settings.HUDDown = "top"

--[[ VGUI COLOURS ]]--
-- I don't recommend changing any of these other than the Definition colour and the 2 chat colours.
JukeBox.Colours.Base = Color( 50, 50, 50 )
JukeBox.Colours.Background = Color( 35, 35, 35 )
JukeBox.Colours.Definition = Color( 230, 126, 34 )
JukeBox.Colours.Light = Color( 65, 65, 65, 255 )

JukeBox.Colours.Issue = Color( 231, 76, 60 )
JukeBox.Colours.Accept = Color( 46, 204, 113 )
JukeBox.Colours.Warning = Color( 241, 196, 15 )
JukeBox.Colours.Information = Color( 52, 152, 219 )

JukeBox.Colours.ChatBase = Color( 255, 255, 255 )
JukeBox.Colours.ChatHighlight = Color( 230, 126, 34 )

JukeBox.Colours.HUDBase = Color( 0, 0, 0, 200 )
JukeBox.Colours.HUDHighlight = Color( 230, 126, 34, 200 )
JukeBox.Colours.HUDFont = Color( 255, 255, 255, 220 )

--[[ FONTS ]]--
if SERVER then return end
for i=4, 50 do -- I'll change this :)
	surface.CreateFont( "JukeBox.Font."..i, {
		font = "Roboto",
		size = i,
		weight = 0,
		antialias = true,
	} )
	surface.CreateFont( "JukeBox.Font."..i..".Bold", {
		font = "Roboto Bold",
		size = i,
		weight = 1000,
		antialias = true,
	} )
end