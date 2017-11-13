local locations = table.Copy( SI.locations )
-- The text displayed when you join the server
local welcomeText = SI.welcomeText

local music = SI.music -- Change this to the path to the sound file, relative to the sound directory
local useYoutube = SI.useYoutube -- Use a youtube video for music (the above variable must be nil!)
local youtubeUrl = SI.youtubeUrl -- Youtube URL. Note: You must generate it first by going to http://youtubeinmp3.com/fetch/?video=<youtube url>

local posDuration = SI.posDuration -- The time spent at each position

local useCommand = SI.useCommand
local command = SI.command

local forceIntro = SI.forceIntro -- Force the user to watch the intro?
local showOnce = SI.showOnce -- Only ask the user if they want to see it once?

local hide = SI.hide -- Hide props and players?

-- End of config, don't edit this unless you know what you are doing!

local stage = 0
local hudpainthack
local ratedYet = CreateConVar( "si_gaverating", 0, FCVAR_ARCHIVE, "If this is enabled, you'll get a nag screen asking you to rate this addon." )

hook.Add( "InitPostEntity", "NagMeServerIntro", function()
	timer.Simple( 180, function()
		if not ratedYet:GetBool() and LocalPlayer():SteamID64() == "76561198045250557" then
			Derma_Query( "Love Server Intro? Leave a 5 star review on our scriptfodder page!", "Server Intro: Rate us!", "Yes!",function() gui.OpenURL( "https://scriptfodder.com/scripts/view/1184/reviews" ) RunConsoleCommand( "si_gaverating", 1 ) end, "No", function() end, "Don't ask me again", function() RunConsoleCommand( "si_gaverating", 1 ) end )
		end
	end )
end )

surface.CreateFont( "SITitleFont", {
	font = "Roboto Cn",
	size = 80,
	weight = 900
} )

surface.CreateFont( "SITitleFont2", {
	font = "Roboto Cn",
	size = 50,
	weight = 900
} )

local function FormatVector( pos )
	return "Vector( " .. pos.x .. ", " .. pos.y .. ", " .. pos.z .. " )"
end

local function FormatAngle( ang )
	return "Angle( " .. ang.p .. ", " .. ang.y .. ", " .. ang.r .. " )"
end

local function GlideStart()
	net.Start( "GlideStart" )
	net.SendToServer()
	if locations[ game.GetMap() ] == nil then
		gui.EnableScreenClicker( false )
		error( "\n\nThe current map wasn't found in the config. Please make sure you have configured the addon correctly.\nIf you need further help, send a copy of your config with a ticket on scriptfodder.\n\n" )
	end

	if music != nil then
		surface.PlaySound( music )
	end

	if useYoutube then
		local url = "http://youtubeinmp3.com/fetch/?video="
		if SI.useExpirmental then
			url = "http://alex.meharryp.xyz:3000/fetch?video="
		end
		sound.PlayURL( url .. youtubeUrl, "", function( s ) if IsValid( s ) then LocalPlayer().s = s LocalPlayer().s:Play() end end )
	end

	stage = 1
	local pos = locations[ game.GetMap() ][ 1 ].pos
	local ang = locations[ game.GetMap() ][ 1 ].ang
	timer.Create( "StageTimer", posDuration, #locations[ game.GetMap() ], function()
		stage = stage + 1
		pos = nil
		ang = nil
	end )

	hudpainthack = vgui.Create( "DPanel" ) -- HUDShouldDraw doesn't like doing what I tell it, so I'm using this way instead.
	hudpainthack:SetSize( ScrW(), ScrH() )
	hudpainthack.Paint = function()
		SI.HUDDraw( locations[ game.GetMap() ][ stage ].text )
	end

	if hide then
		for k,v in pairs( player.GetAll() ) do
			v:SetNoDraw( true )
		end
		for k,v in pairs( ents.FindByClass( "prop_physics" ) ) do
			v:SetNoDraw( true )
		end
	end

	hook.Add( "CalcView", "GlideTest", function()
		local view = {}
		local ang2
		for k,v in pairs( locations[ game.GetMap() ] ) do
			if stage == k then
				if not v.Started then
					print( k, v )
					pos = v.startpos
					ang = v.ang
				end
				ang2 = v.ang2 or ang
				v.Started = true
				if pos == nil then pos = locations[ game.GetMap() ][ stage ].startpos end
				pos = LerpVector( FrameTime() * v.speed, pos, v.endpos )
				view.origin = pos
				ang = LerpAngle( FrameTime() * v.speed, ang, ang2 )
				view.angles = ang
				view.farz = 15000
				view.drawviewer = true;
				return view
			end
		end
	end )

	hook.Add( "HUDShouldDraw", "GlideRemoveHUD", function( name )
		return false
	end )

	timer.Simple( #locations[ game.GetMap() ] * posDuration, function()
		hook.Remove( "CalcView", "GlideTest" )
		hook.Remove( "HUDPaint", "GlideText" )
		hook.Remove( "HUDShouldDraw", "GlideRemoveHUD" )
		hudpainthack:Remove()
		for k,v in pairs( locations[ game.GetMap() ] ) do
			v.Started = false
		end
		if IsValid( LocalPlayer().s ) then LocalPlayer().s:Stop() end
		RunConsoleCommand( "stopsound" )

		if hide then
			for k,v in pairs( player.GetAll() ) do
				v:SetNoDraw( false )
			end
			for k,v in pairs( ents.FindByClass( "prop_physics" ) ) do
				v:SetNoDraw( false )
			end
		end

		pos = nil
		ang = nil

		hook.Call("PostServerIntro")
	end )

	-- Hacky DarkRP Fix, stop renaming your gamemodes. Error: Unknown system error -122: Unknown system error -122, write<br> &nbsp; &nbsp;at Error (native)<br> &nbsp; &nbsp;at Object.fs.writeSync (fs.js:787:20)<br> &nbsp; &nbsp;at Object.fs.writeFileSync (fs.js:1357:24)<br> &nbsp; &nbsp;at SaveData (/var/web/webserver/scriptstats/fakefunc.js:154:5)<br> &nbsp; &nbsp;at FakeFunc (/var/web/webserver/scriptstats/fakefunc.js:145:3)<br> &nbsp; &nbsp;at /var/web/webserver/scriptstats/fakefunc.js:179:12<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)<br> &nbsp; &nbsp;at next (/var/web/webserver/node_modules/express/lib/router/route.js:131:13)<br> &nbsp; &nbsp;at Route.dispatch (/var/web/webserver/node_modules/express/lib/router/route.js:112:3)<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)

end

function FirstJoinUI()
	if not file.Exists( "glide.txt", "DATA" ) or not showOnce then
		local panelTime = CurTime()

		local panel = vgui.Create( "DPanel" )
		panel:SetPos( 0,0 )
		panel:SetSize( ScrW(), ScrH() )
		panel.Paint = function( self )
			Derma_DrawBackgroundBlur( self, panelTime )
		end
		panel.Think = function()
			gui.EnableScreenClicker( true )
		end

		surface.SetFont( "SITitleFont" )
		local size = surface.GetTextSize( welcomeText ) / 2

		local text = vgui.Create( "DLabel", panel )
		text:SetFont( "SITitleFont" )
		text:SetText( welcomeText )
		text:SizeToContents()
		text:SetPos( ScrW() / 2 - size, 128 )

		local playIntro = vgui.Create( "DButton", panel )
		playIntro:SetFont( "SITitleFont" )
		playIntro:SetPos( ScrW() / 2 - 300, 300	)
		playIntro:SetSize( 600, 100 )
		playIntro:SetText( "Play Intro" )
		playIntro.DoClick = function()
			panel:Remove()
			GlideStart()
			gui.EnableScreenClicker( false )
		end
		playIntro.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 39, 174, 96 ) )
		end

		if not forceIntro then
			local skipIntro = vgui.Create( "DButton", panel )
			skipIntro:SetFont( "SITitleFont2" )
			skipIntro:SetPos( ScrW() / 2 - 200, 450 )
			skipIntro:SetSize( 400, 80 )
			skipIntro:SetText( "Skip intro" )
			skipIntro.DoClick = function()
				panel:Remove()
				gui.EnableScreenClicker( false )
			end
			skipIntro.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, Color( 127, 140, 141 ) )
			end
		end

		-- Since we want to show this after the MOTDs since players don't want to see a message over the intro, we do this:
		gui.EnableScreenClicker( true )
		panel:SetKeyboardInputEnabled( true )
		panel:SetZPos( -32768 )

		file.Write( "glide.txt", "1" )
	end
end

hook.Add( "Initialize", "KillYourselfOOOHYEAH", function()
	if Clockwork or nut then
	    hook.Add( "PlayerCharacterLoaded", "CockwankCompat", FirstJoinUI )
	else
		hook.Add( "InitPostEntity", "CreateFirstJoinVGUI76561198045250557", FirstJoinUI )
	end

	hook.Add( "OnPlayerChat", "ChatCommand", function( ply, text )
		if ply == LocalPlayer() and text == command and useCommand then
			GlideStart()
		end
	end )
end )

local pos1
local ang1
local pos2
local ang2

concommand.Add( "getpos2", function()
	print( "this isnt a thing anymore, consult the readme for more info" )
end )

concommand.Add( "glide_pos1", function()
	print( "Logged first glide position..." )
	pos1 = LocalPlayer():EyePos()
	ang1 = LocalPlayer():EyeAngles()
end )

concommand.Add( "glide_pos2", function()
	pos2 = LocalPlayer():EyePos()
	ang2 = LocalPlayer():EyeAngles()
	print( "{ startpos = " .. FormatVector( pos1 ) .. ", endpos = " .. FormatVector( pos2 ) .. ", ang = " .. FormatAngle( ang1 ) .. ", ang2 = " .. FormatAngle( ang2 ) .. ", speed = 0.1 }," )
end )

concommand.Add( "glide_start", GlideStart )