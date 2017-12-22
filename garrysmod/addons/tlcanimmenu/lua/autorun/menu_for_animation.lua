concommand.Add( "tlc_run_animation", function( ply, cmd, args )
    net.Start("StartAnimationGenjiDance")
	net.WriteString(tostring(args[1]))
	if (args[2] == 18 or args[2] == 19 or args[2] == 20 or args[2] == 21 or args[2] == 22 or args[2] == 23 or args[2] == 24) then
	net.WriteString(tostring(2))
	else
	net.WriteString(tostring(args[2]))
	end
	net.SendToServer()
end )

if CLIENT then	
 
    CreateClientConVar( "anim_delay", "2", true, false )
	CreateClientConVar( "anim_enabled", "0", true, false )
	
	local Editor = {}

	Editor.DelayPos = nil
	Editor.ViewPos = nil
	
	Editor.EnableToggle = GetConVar( "anim_enabled" ):GetBool() or false
	
	list.Set(
		"DesktopWindows", 
		"Animation Menu",
		{
			title = "Animation Menu",
			icon = "icon32/zoom_extend.png",
			width = 300,
			height = 600,
			onewindow = true,
			init = function(icn, pnl)
				BuildAnimMenu(pnl)
			end
		}
	)
	
	function BuildAnimMenu(PNL)
	
		if Editor.PANEL != nil then
			Editor.PANEL:Remove()
		end
		
		if PNL == nil then	
			PNL = vgui.Create( "DFrame" )
			PNL:SetSize( 300, 600 )
			PNL:SetTitle( "Animation Menu" )
			PNL:SetVisible( true )
			PNL:SetDraggable( true )
			PNL:ShowCloseButton( true )
			PNL:MakePopup()
		end

		Editor.PANEL = PNL
		Editor.PANEL:SetPos(ScrW()/6,90)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 290, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Settings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Анимации 1", Editor.PANEL.Settings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CameraSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Анимации 2", Editor.PANEL.CameraSettings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,493)
		Editor.PANEL.CamDistanceTxt:SetText("КК: tlc_run_animation номеранимации длительность")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,510)
		Editor.PANEL.CamDistanceTxt:SetText("Длительность анимации (max 20) : ")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceLb = Editor.PANEL.Settings:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb:SetPos(180,507)
		Editor.PANEL.CamDistanceLb:SetValue(GetConVar( "anim_delay" ):GetFloat())
		Editor.PANEL.CamDistanceLb:SetSize(50,20)
		Editor.PANEL.CamDistanceLb:SetNumeric(true)	
		Editor.PANEL.CamDistanceLb:SetUpdateOnType( true )
		
		Editor.PANEL.CamDistanceLb.OnTextChanged  = function()
		    if ((tonumber(Editor.PANEL.CamDistanceLb:GetValue()) or 0) > 20) then
			RunConsoleCommand("anim_delay","0")
			else
			RunConsoleCommand("anim_delay",Editor.PANEL.CamDistanceLb:GetValue())
			end
		end
		
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Танец Генджи (2)")
		Editor.PANEL.ResetCam:SetPos(0,0)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("2")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Магическая стойка (3)")
		Editor.PANEL.ResetCam:SetPos(0,41)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("3")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Поправить галстук (8)")
		Editor.PANEL.ResetCam:SetPos(0,246)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("8")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Преклонить колено (9)")
		Editor.PANEL.ResetCam:SetPos(0,287)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("9")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Руки в подмыхи (10)")
		Editor.PANEL.ResetCam:SetPos(0,328)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("10")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Руки на бёдра (11)")
		Editor.PANEL.ResetCam:SetPos(0,369)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("11")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Поднять левую руку (12)")
		Editor.PANEL.ResetCam:SetPos(0,410)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("12")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Две руки показывают что всё заебись (13)")
		Editor.PANEL.ResetCam:SetPos(0,451)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("13")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Свэээээг (4)")
		Editor.PANEL.ResetCam:SetPos(0,451)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("4")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Кулаком по ебалу (14)")
		Editor.PANEL.ResetCam:SetPos(0,205)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("14")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Радость (15)")
		Editor.PANEL.ResetCam:SetPos(0,164)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("15")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("А ну ка, подойди ко мне (16)")
		Editor.PANEL.ResetCam:SetPos(0,82)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("16")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Пинок с любовью из спарты (17)")
		Editor.PANEL.ResetCam:SetPos(0,123)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("17")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Двигаться 'Дополнительно' (18)")
		Editor.PANEL.ResetCam:SetPos(0,0)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("18")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Двигаться Вперёд (19)")
		Editor.PANEL.ResetCam:SetPos(0,41)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("19")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Сгрупироваться (20)")
		Editor.PANEL.ResetCam:SetPos(0,82)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("20")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Остановиться (21)")
		Editor.PANEL.ResetCam:SetPos(0,123)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("21")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Налево (22)")
		Editor.PANEL.ResetCam:SetPos(0,164)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("22")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Направо (23)")
		Editor.PANEL.ResetCam:SetPos(0,205)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("23")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("В укрытие (24)")
		Editor.PANEL.ResetCam:SetPos(0,246)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("24")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Танец 'Я дефект' (25)")
		Editor.PANEL.ResetCam:SetPos(0,287)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("25")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Ебануть с ноги типа кунгфу (27)")
		Editor.PANEL.ResetCam:SetPos(0,369)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("27")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Посидим блять (28)")
		Editor.PANEL.ResetCam:SetPos(0,328)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("28")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Истинно-Джедайский танец (29)")
		Editor.PANEL.ResetCam:SetPos(0,410)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("29")
			net.WriteString(tostring(GetConVar( "anim_delay" ):GetFloat()))
			net.SendToServer()
		end
		
	end
end

