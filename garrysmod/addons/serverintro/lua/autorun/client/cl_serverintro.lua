locations = table.Copy( SI.locations )
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
hudpainthack = nil
space = nil


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

gliding = false

function GlideSpawnStart()
	gliding = true
	net.Start( "GlideSpawnStart" )
	net.SendToServer()
	if locations[ "spawn" ] == nil then
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

	local d_v = nil
	local d_a = nil
	
	stage = 1
	local pos = locations[ "spawn" ][ 1 ].pos
	local ang = locations[ "spawn" ][ 1 ].ang
	timer.Create( "StageTimer", 60, 0, function()
		if(#locations[ "spawn" ]<stage+1)then 
			stage = 1 
			for k,v in pairs( locations[ "spawn" ] ) do
				v.Started = false
			end
		else
			stage = stage + 1
		end
		pos = d_v
		ang = d_a
	end )

	hudpainthack = vgui.Create( "DPanel" ) -- HUDShouldDraw doesn't like doing what I tell it, so I'm using this way instead.
	hudpainthack:SetSize( ScrW(), ScrH() )
	hudpainthack.Paint = function()
		SI.HUDDraw( locations[ "spawn" ][ stage ].text,true )
	end

	if hide then
		for k,v in pairs( player.GetAll() ) do
			v:SetNoDraw( true )
		end
	end

	hook.Add( "CalcView", "GlideTest", function()
		local view = {}
		local ang2
		for k,v in pairs( locations[ "spawn" ] ) do
			if stage == k then
				if not v.Started then
					--print( k, v )
					pos = d_v or v.startpos
					ang = d_a or v.ang
				end
				ang2 = v.ang2 or ang
				v.Started = true
				if pos == nil then pos = locations[ "spawn" ][ stage ].startpos end
				pos = LerpVector( FrameTime() * v.speed, pos, v.endpos )
				view.origin = pos
				ang = LerpAngle( FrameTime() * v.speed, ang, ang2 )
				view.angles = ang
				view.farz = 15000
				view.drawviewer = true;
				d_v = view.origin
				d_a = view.angles
				return view
			end
		end
	end )

	hook.Add( "HUDShouldDraw", "GlideRemoveHUD", function( name )
		return false
	end )

	--[[timer.Simple( #locations[ "spawn" ] * posDuration, function()
		hook.Remove( "CalcView", "GlideTest" )
		hook.Remove( "HUDPaint", "GlideText" )
		hook.Remove( "HUDShouldDraw", "GlideRemoveHUD" )
		hudpainthack:Remove()
		for k,v in pairs( locations[ "spawn" ] ) do
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
	end )]]--
	
	-- Hacky DarkRP Fix, stop renaming your gamemodes. Error: Unknown system error -122: Unknown system error -122, write<br> &nbsp; &nbsp;at Error (native)<br> &nbsp; &nbsp;at Object.fs.writeSync (fs.js:787:20)<br> &nbsp; &nbsp;at Object.fs.writeFileSync (fs.js:1357:24)<br> &nbsp; &nbsp;at SaveData (/var/web/webserver/scriptstats/fakefunc.js:154:5)<br> &nbsp; &nbsp;at FakeFunc (/var/web/webserver/scriptstats/fakefunc.js:145:3)<br> &nbsp; &nbsp;at /var/web/webserver/scriptstats/fakefunc.js:179:12<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)<br> &nbsp; &nbsp;at next (/var/web/webserver/node_modules/express/lib/router/route.js:131:13)<br> &nbsp; &nbsp;at Route.dispatch (/var/web/webserver/node_modules/express/lib/router/route.js:112:3)<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)

end

local pos = nil
local ang = nil
local next_fly = false
local cur = 0

function GlideStart()
	gliding = true
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
	pos = locations[ game.GetMap() ][ 1 ].pos
	ang = locations[ game.GetMap() ][ 1 ].ang
	cur = CurTime()
	timer.Simple( posDuration*2, function()
		next_fly = true
	end )

	hudpainthack = vgui.Create( "DPanel" ) -- HUDShouldDraw doesn't like doing what I tell it, so I'm using this way instead.
	hudpainthack:SetSize( ScrW(), ScrH() )
	hudpainthack.Paint = function()
		SI.HUDDraw( locations[ game.GetMap() ][ stage ].text )
	end
	
	space = vgui.Create( "DPanel" ) -- HUDShouldDraw doesn't like doing what I tell it, so I'm using this way instead.
	space:SetSize( ScrW(), ScrH() )
	space.Paint = function()
		SI.HUDDrawSpace(next_fly)
	end

	if hide then
		for k,v in pairs( player.GetAll() ) do
			v:SetNoDraw( true )
		end
	end

	hook.Add( "CalcView", "GlideTest", function()
		local view = {}
		local ang2
		for k,v in pairs( locations[ game.GetMap() ] ) do
			if stage == k then
				if not v.Started then
					--print( k, v )
					pos = v.startpos
					ang = v.ang
				end
				ang2 = v.ang2 or ang
				v.Started = true
				if pos == nil then pos = locations[ game.GetMap() ][ stage ].startpos end
				if ang == nil then ang = locations[ game.GetMap() ][ stage ].ang end
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

	--[[timer.Simple( #locations[ game.GetMap() ] * posDuration, function()
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
		gliding = false

		hook.Call("PostServerIntro")
	end )]]--
	
	-- Hacky DarkRP Fix, stop renaming your gamemodes. Error: Unknown system error -122: Unknown system error -122, write<br> &nbsp; &nbsp;at Error (native)<br> &nbsp; &nbsp;at Object.fs.writeSync (fs.js:787:20)<br> &nbsp; &nbsp;at Object.fs.writeFileSync (fs.js:1357:24)<br> &nbsp; &nbsp;at SaveData (/var/web/webserver/scriptstats/fakefunc.js:154:5)<br> &nbsp; &nbsp;at FakeFunc (/var/web/webserver/scriptstats/fakefunc.js:145:3)<br> &nbsp; &nbsp;at /var/web/webserver/scriptstats/fakefunc.js:179:12<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)<br> &nbsp; &nbsp;at next (/var/web/webserver/node_modules/express/lib/router/route.js:131:13)<br> &nbsp; &nbsp;at Route.dispatch (/var/web/webserver/node_modules/express/lib/router/route.js:112:3)<br> &nbsp; &nbsp;at Layer.handle [as handle_request] (/var/web/webserver/node_modules/express/lib/router/layer.js:95:5)

end

local function Vopros()
    if (game.GetMap() == "rp_venator_tlc_v2") then
		Derma_Query( "Вы уверены, что хотите пройти обучение? В течение 10 минут к вам подойдет инструктор и предложит обучение. Если же этого не произойдет, вы пройдете автоматическое обучение. Обучение можно пройти лишь один раз. Вы готовы?", "Система обучения", "Да",function() GlideStart() end, "Нет", function() end )
	else 
	    notification.AddLegacy( "Вам нужно дождаться окончания ивента! Просим прощения за неудобство.", NOTIFY_GENERIC, 5 )
	end
end

hook.Add( "Initialize", "KillYourselfOOOHYEAH", function()
	hook.Add( "OnPlayerChat", "ChatCommand", function( ply, text )
		if ply == LocalPlayer() and text == command and useCommand then
			Vopros()
		end
	end )
end )

local pos1
local ang1
local pos2
local ang2


concommand.Add( "glide_pos1", function()
	--print( "Logged first glide position..." )
	pos1 = LocalPlayer():EyePos()
	ang1 = LocalPlayer():EyeAngles()
end )

concommand.Add( "glide_pos2", function()
	pos2 = LocalPlayer():EyePos()
	ang2 = LocalPlayer():EyeAngles()
	--print( "{ startpos = " .. FormatVector( pos1 ) .. ", endpos = " .. FormatVector( pos2 ) .. ", ang = " .. FormatAngle( ang1 ) .. ", ang2 = " .. FormatAngle( ang2 ) .. ", speed = 0.1 }," )
end )

concommand.Add( "glide_start", GlideStart )

local onetap = false
hook.Add( "Think", "Ever_Key_FLY", function()
	if(input.IsKeyDown( KEY_SPACE ))then
		if(onetap == false)then
			onetap = true
			if next_fly==true then
				if(stage==#locations[ game.GetMap() ])then
					hook.Remove( "CalcView", "GlideTest" )
					hook.Remove( "HUDPaint", "GlideText" )
					hook.Remove( "HUDShouldDraw", "GlideRemoveHUD" )
					hudpainthack:Remove()
					space:Remove()
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
					gliding = false
					next_fly = false

					hook.Call("PostServerIntro")
					net.Start( "GlideStop" )
					net.SendToServer()
				else
					stage = stage + 1
					pos = nil
					ang = nil
					next_fly=false
					timer.Simple( posDuration*2, function()
						next_fly = true
					end )
				end
			end
		end
	else
		onetap = false
	end
end )
