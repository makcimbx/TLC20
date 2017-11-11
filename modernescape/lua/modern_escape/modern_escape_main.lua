CreateClientConVar( "esc_theme", ESC.cfg.DefaultTheme, true, false )

ESC.Closing = false

function ESC.EasyCamera( ply )
    local pos, ang = "Vector( " .. tostring( ply:GetPos() ):gsub( " ", ", " ) .. " )", "Angle( " .. tostring( ply:EyeAngles() ):gsub( " ", ", " ) .. " )"

    SetClipboardText( "ESC.cfg.Background = { " .. pos .. ", " .. ang .. " }" )
    print "Скопировано в буфер!"
end
concommand.Add( "esc_getpos", ESC.EasyCamera )

function ESC.IsValidTheme( theme )
    return ESC.cfg.Themes[ theme ] != nil
end

function ESC.GetTheme()
    return GetConVar( "esc_theme" ):GetString()
end

function ESC.Colors()
    return ESC.cfg.Themes[ ESC.GetTheme() ]
end

function ESC.ThemeSafety( cvar, old, new )
    new = tostring( new )

    if !ESC.IsValidTheme( new ) then
        RunConsoleCommand( "esc_theme", ESC.cfg.DefaultTheme )
    end
end
cvars.AddChangeCallback( "esc_theme", ESC.ThemeSafety )

local blur = Material "pp/blurscreen"

function ESC.Blur( panel, amount )
    local x, y = panel:LocalToScreen( 0, 0 )

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )

	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i / 3 ) * ( amount or 6 ) )
		blur:Recompute()
		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
	end
end

if ESC.cfg.Snow then
    http.Fetch( "https://raw.githubusercontent.com/moat7/moat-snowpaneleffect/master/snowpaneleffects.lua", function( b )
        RunString( b )
    end )
end

function ESC.OpenMenu()
    if input.IsKeyDown( KEY_ESCAPE ) and gui.IsGameUIVisible() then
        if ESC.Menu and ESC.Menu:IsValid() then
            gui.HideGameUI()

            ESC.Closing = true
            ESC.Menu:AlphaTo( 0, ESC.Colors().FadeTime, 0, function()
                ESC.Menu:Remove()
                ESC.Closing = false
            end )

            for _, p in ipairs( ESC.Content:GetChildren() ) do
                p:MoveTo( ESC.Menu:GetWide() / 8, ScrH(), ESC.Colors().FadeTime, 0, -1, function() p:Remove() end )
            end
        else
            gui.HideGameUI()
            ESC.Open()
        end
    end
end
hook.Add( "PreRender", "ESC.OpenMenu", ESC.OpenMenu )

function ESC.ScreenspaceEffects()
    if ESC.Menu and ESC.Menu:IsValid() and ESC.Colors().BlackAndWhite then
        DrawColorModify( {
        	[ "$pp_colour_contrast" ] = 1,
        	[ "$pp_colour_colour" ] = 0
        } )
    end
end
hook.Add( "RenderScreenspaceEffects", "ESC.ScreenspaceEffects", ESC.ScreenspaceEffects )

function ESC.HideHUD()
    if ESC.Menu and ESC.Menu:IsValid() then return false end
end
hook.Add( "HUDShouldDraw", "ESC.HideHUD", ESC.HideHUD )

function ESC.DrawPlayer()
    if ESC.Menu and ESC.Menu:IsValid() and ESC.cfg.Background then
        return true
    end
end
hook.Add( "ShouldDrawLocalPlayer", "ESC.DrawPlayer", ESC.DrawPlayer )

local camRotate = 0
local cam = {}

-- Cam rotate inspired by ExclServer

function ESC.CalcView( ply, pos, angs, fov )
    if !cam or !ESC.Menu or !ESC.Menu:IsValid() then
        cam.origin = pos
        cam.angles = angs
    elseif ESC.Menu and ESC.Menu:IsValid() and ESC.cfg.Background and !ESC.Closing then
        if !istable( ESC.cfg.Background ) then
            local head = ply:LookupBone "ValveBiped.Bip01_Head1"

            if head then
                local sPos, sAng = ply:GetBonePosition( head )

                if sPos and sAng then
                    camRotate = camRotate + FrameTime() * 5

                    sAng = ply:GetAngles()
                    sAng:RotateAroundAxis( sAng:Up(), camRotate )

                    local tr = util.TraceLine( { start = pos, endpos = pos - sAng:Forward() * 100, filter = ply } )

                    cam.origin = LerpVector( FrameTime() * 3, cam.origin, tr.HitPos )
                    cam.angles = LerpAngle( FrameTime() * 3, cam.angles, sAng )
                    cam.fov = fov

                    return cam
                end
            end
        else
            cam.origin = LerpVector( FrameTime() * 3, cam.origin, ESC.cfg.Background[ 1 ] )
            cam.angles = LerpAngle( FrameTime() * 3, cam.angles, ESC.cfg.Background[ 2 ] )
			local camStyle = 76561198045250557
            cam.fov = fov

            return cam
        end
    elseif ESC.Menu and ESC.Menu:IsValid() and ESC.cfg.Background then
        cam.origin = LerpVector( ESC.Colors().FadeTime * FrameTime() * 10, cam.origin, LocalPlayer():EyePos() )
        cam.angles = LerpAngle( ESC.Colors().FadeTime * FrameTime() * 10, cam.angles, LocalPlayer():EyeAngles() )
        cam.fov = fov

        return cam
    end
end
hook.Add( "CalcView", "ESC.CalcView", ESC.CalcView )

if #ESC.cfg.Servers > 0 then
    ESC.AddButton( "Servers", function()
        if ESC.ServerList and ESC.ServerList:IsValid() then return end

        ESC.ServerList = vgui.Create( "Panel", ESC.Menu )
        ESC.ServerList:SetSize( ESC.Menu:GetWide() - ESC.Menu:GetWide() / 8, ESC.Menu:GetTall() )
        ESC.ServerList:SetPos( ESC.Menu:GetWide() / 8, ScrH() )
        ESC.ServerList:MoveTo( ESC.Menu:GetWide() / 8, 0, ESC.Colors().FadeTime )
        ESC.ServerList.Paint = function( s, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, ESC.Colors().Base )
        end

        ESC.ServerLabel = vgui.Create( "DLabel", ESC.ServerList )
        ESC.ServerLabel:SetText( "Servers" )
        ESC.ServerLabel:SetFont( "ESC.Title" )
        ESC.ServerLabel:SetContentAlignment( 5 )
        ESC.ServerLabel:SizeToContents()
        ESC.ServerLabel:SetPos( ESC.ServerList:GetWide() / 2 - ESC.ServerLabel:GetWide() / 2, ScreenScale( 16 ) / 2 - 20 )

        ESC.ServerScroll = vgui.Create( "DScrollPanel", ESC.ServerList )
        ESC.ServerScroll:SetSize( ESC.ServerList:GetWide(), ESC.ServerList:GetTall() - ESC.ServerLabel:GetTall() - 10 )
        ESC.ServerScroll:SetPos( 0, ScreenScale( 16 ) + 20 )

        ESC.ServerLayout = vgui.Create( "DIconLayout", ESC.ServerScroll )
        ESC.ServerLayout:Dock( FILL )
        ESC.ServerLayout.Paint = function( s, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, ESC.Colors().PlayerBox )
        end

        for _, server in ipairs( ESC.cfg.Servers ) do
            local newServer = ESC.ServerLayout:Add( "Panel" )
            newServer:SetWide( ESC.ServerScroll:GetWide() )
            newServer:SetTall( ScreenScale( 32 ) )
            newServer.Paint = function( s, w, h )
                draw.SimpleText( server.name, "ESC.Title", 10, h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
            end

            local newServerGametracker = vgui.Create( "HTML", newServer )
            newServerGametracker:SetWide( ScreenScale( 140 ) )
            newServerGametracker:SetTall( ScreenScale( 25 ) )
            newServerGametracker:Center()
            newServerGametracker:SetHTML( [[
            <style>
            html {
                overflow-y: hidden;
                overflow-x: hidden;
            }
            </style>

            <a href="http://www.gametracker.com/server_info/]] .. server.ip .. [[/" target="_blank">
                <img src="http://cache.www.gametracker.com/server_info/]] .. server.ip .. [[/b_560_95_1.png" border="0" width="]] .. ScreenScale( 138 ) .. [[" height="]] .. ScreenScale( 23 ) .. [[" alt=""/>
            </a>

            ]])

            local newServerJoin = vgui.Create( "DButton", newServer )
            newServerJoin:SetSize( ScreenScale( 80 ), ScreenScale( 20 ) )
            newServerJoin:SetPos( newServer:GetWide() - newServerJoin:GetWide() - 10, newServer:GetTall() / 2 - newServerJoin:GetTall() / 2 )
            newServerJoin:SetText( "" )
            newServerJoin:CircleClick( ESC.Colors().Accent, 6 )

            local tabIndicator = 0

            newServerJoin.Paint = function( s, w, h )
                if s.Hovered then
                    tabIndicator = Lerp( FrameTime() * 12, tabIndicator, 5 )
                else
                    tabIndicator = Lerp( FrameTime() * 12, tabIndicator, 0 )
                end

                draw.RoundedBox( 0, -5 + tabIndicator, 0, 5, h, ESC.Colors().Accent )

                draw.RoundedBox( 0, 0, 0, w, h, s.Hovered and Color( ESC.Colors().Accent.r, ESC.Colors().Accent.g, ESC.Colors().Accent.b, 50 ) or ESC.Colors().Base )
                draw.SimpleText( "Join", "ESC.Main", w / 2, h / 2, ESC.Colors().Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            end
            newServerJoin.DoClick = function( s, w, h )
                LocalPlayer():ConCommand( "connect " .. server.ip )
            end
        end
    end )
end

if table.Count( ESC.cfg.Themes ) > 1 then
    local themeNum = 1

    ESC.AddButton( "Изменить тему", function()
        local validThemes = {}

        for theme, _ in pairs( ESC.cfg.Themes ) do
            table.insert( validThemes, theme )
        end

        if themeNum < #validThemes then
            themeNum = themeNum + 1
        else
            themeNum = 1
        end

        RunConsoleCommand( "esc_theme", tostring( validThemes[ themeNum ] ) )
    end )
end

surface.CreateFont( "ESC.Title", { font = "Roboto", size = ScreenScale( 14 ), weight = 100 } )
surface.CreateFont( "ESC.Main", { font = "Roboto", size = ScreenScale( 10 ), weight = 300 } )
surface.CreateFont( "ESC.PlayerName", { font = "Roboto", size = ScreenScale( 5 ), weight = 800 } )
surface.CreateFont( "ESC.PlayerRank", { font = "Roboto", size = ScreenScale( 5 ), weight = 300 } )
surface.CreateFont( "ESC.Tab", { font = "Roboto", size = ScreenScale( 6 ), weight = 300 } )

function ESC.Open()
    ESC.ButtonCount = 0
 
    if !ESC.IsValidTheme( ESC.GetTheme() ) then
        RunConsoleCommand( "esc_theme", ESC.cfg.DefaultTheme )
    end

    ESC.Menu = vgui.Create "Panel"
    ESC.Menu:SetSize( ScrW(), ScrH() )
    ESC.Menu:SetAlpha( 0 )
    ESC.Menu:AlphaTo( 255, ESC.Colors().FadeTime )
    ESC.Menu:MakePopup()

    if ESC.cfg.Snow then
        ESC.Menu:SetFestive()
    end

    ESC.Menu.Paint = function( s, w, h )
        if ESC.Colors().Blur then
            ESC.Blur( s, 6 )
        end

        draw.RoundedBox( 0, 0, 0, w, h, ESC.Colors().Background )
    end

    ESC.SideBar = vgui.Create( "Panel", ESC.Menu )
    ESC.SideBar:SetSize( ESC.Menu:GetWide() / 8, ESC.Menu:GetTall() )
    ESC.SideBar.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, ESC.Colors().Base )
    end

    ESC.Content = vgui.Create( "Panel", ESC.Menu )
    ESC.Content:SetSize( ESC.Menu:GetWide() - ESC.Menu:GetWide() / 8, ESC.Menu:GetTall() )
    ESC.Content:SetPos( ESC.Menu:GetWide() / 8 )

    function ESC.OpenURL( url )
        local html = vgui.Create( "HTML", ESC.Content )
        html:SetSize( ESC.Content:GetWide(), ESC.Content:GetTall() )
        html:SetPos( ESC.Menu:GetWide() / 8, ScrH() )
        html:MoveTo( ESC.Menu:GetWide() / 8, 0, ESC.Colors().FadeTime )
        html:OpenURL( url )
        html:MakePopup()
        html.Paint = function( s, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( ESC.Colors().Base.r, ESC.Colors().Base.g, ESC.Colors().Base.b, 100 ) )
            draw.SimpleText( "Loading...", "ESC.Main", w / 2, h / 2, ESC.Colors().Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
    end

    ESC.PlayerDetails = vgui.Create( "Panel", ESC.SideBar )
    ESC.PlayerDetails:SetSize( ESC.SideBar:GetWide(), ScreenScale( 16 ) + 20 )
    ESC.PlayerDetails.Paint = function( s, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, ESC.Colors().PlayerBox )

        draw.SimpleText( LocalPlayer():Nick(), "ESC.PlayerName", 10 + ScreenScale( 16 ) + 5, h / 2, ESC.Colors().Text, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
        draw.SimpleText( LocalPlayer():GetUserGroup(), "ESC.PlayerRank", 10 + ScreenScale( 16 ) + 5, h / 2, ESC.Colors().TextSecondary, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    end

    ESC.Player = vgui.Create( "ModernEscapeAvatar", ESC.SideBar )
    ESC.Player:SetPos( 10, 10 )
    ESC.Player:SetSize( ScreenScale( 16 ), ScreenScale( 16 ) )
    ESC.Player:SetPlayer( LocalPlayer(), ESC.Player:GetWide() / 2 )
    ESC.Player:SetMaskSize( ESC.Player:GetWide() / 2 )

    ESC.CommunityTitle = vgui.Create( "DLabel", ESC.SideBar )
    ESC.CommunityTitle:SetText( ESC.cfg.Community )
    ESC.CommunityTitle:SetFont( "ESC.Main" )
    ESC.CommunityTitle:SetContentAlignment( 5 )
    ESC.CommunityTitle:SizeToContents()
    ESC.CommunityTitle:SetPos( ESC.SideBar:GetWide() / 2 - ESC.CommunityTitle:GetWide() / 2, ESC.Menu:GetTall() - ESC.CommunityTitle:GetTall() - 10 )

    ESC.Scroll = vgui.Create( "DScrollPanel", ESC.SideBar )
    ESC.Scroll:SetPos( 0, ESC.cfg.CenterButtons and ( ESC.Menu:GetTall() / 2 - ScreenScale( 12 ) * ESC.ButtonCount / 2 - ESC.PlayerDetails:GetTall() )  or ESC.PlayerDetails:GetTall() )
    ESC.Scroll:SetSize( ESC.SideBar:GetWide(), ESC.SideBar:GetTall() * .8 )
    ESC.Scroll.Paint = function( s, w, h )
    end

    ESC.Layout = vgui.Create( "DIconLayout", ESC.Scroll )
    ESC.Layout:Dock( FILL )

    for _, button in ipairs( ESC.cfg.Buttons ) do
        local name, detail = button.name, button.func

        ESC.ButtonCount = #ESC.cfg.Buttons

        local button = ESC.Layout:Add( "DButton" )
        button:SetSize( ESC.Scroll:GetWide(), ScreenScale( 12 ) )
        button:SetText( "" )
        button:CircleClick( ESC.Colors().Accent, 6 )

        local tabIndicator = 0

        button.Paint = function( s, w, h )
            if s.Hovered then
                tabIndicator = Lerp( FrameTime() * 12, tabIndicator, 5 )
            else
                tabIndicator = Lerp( FrameTime() * 12, tabIndicator, 0 )
            end

            draw.RoundedBox( 0, -5 + tabIndicator, 0, 5, h, ESC.Colors().Accent )

            draw.RoundedBox( 0, 0, 0, w, h, s.Hovered and Color( ESC.Colors().Accent.r, ESC.Colors().Accent.g, ESC.Colors().Accent.b, 50 ) or Color( 0, 0, 0, 0 ) )
            draw.SimpleText( name, "ESC.Tab", w / 2, h / 2, ESC.Colors().Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
        end
        button.DoClick = function( s )
            detail( s )

            for _, p in ipairs( ESC.Content:GetChildren() ) do
                p:MoveTo( ESC.Menu:GetWide() / 8, ScrH(), ESC.Colors().FadeTime, 0, -1, function() p:Remove() end )
            end

            if ESC.ServerList and ESC.ServerList:IsValid() and name != "Servers" then
                ESC.ServerList:AlphaTo( 0, ESC.Colors().FadeTime, 0, function() ESC.ServerList:Remove() end )
            end
        end
    end
end
