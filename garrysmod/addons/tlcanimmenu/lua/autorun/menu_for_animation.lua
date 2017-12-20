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
		Editor.PANEL:SetPos(ScrW() - 1750,90)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 290, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Settings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Анимации 1", Editor.PANEL.Settings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CameraSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Анимации 2", Editor.PANEL.CameraSettings, "icon16/cog_edit.png" )
		
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
		Editor.PANEL.ResetCam:SetText("Танец Генджи")
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
		Editor.PANEL.ResetCam:SetText("Магическая стойка")
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
		Editor.PANEL.ResetCam:SetText("Поправить галстук")
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
		Editor.PANEL.ResetCam:SetText("Преклонить колено")
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
		Editor.PANEL.ResetCam:SetText("Руки в подмыхи")
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
		Editor.PANEL.ResetCam:SetText("Руки на бёдра")
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
		Editor.PANEL.ResetCam:SetText("Поднять левую руку (Не как ленин)")
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
		Editor.PANEL.ResetCam:SetText("Две руки показывают что всё заебись")
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
		Editor.PANEL.ResetCam:SetText("Свэээээг")
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
		Editor.PANEL.ResetCam:SetText("Кулаком по ебалу")
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
		Editor.PANEL.ResetCam:SetText("Радость")
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
		Editor.PANEL.ResetCam:SetText("А ну ка, подойди ко мне")
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
		Editor.PANEL.ResetCam:SetText("Пинок с любовью из спарты")
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
		Editor.PANEL.ResetCam:SetText("Двигаться 'Дополнительно'")
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
		Editor.PANEL.ResetCam:SetText("Двигаться Вперёд")
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
		Editor.PANEL.ResetCam:SetText("Сгрупироваться")
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
		Editor.PANEL.ResetCam:SetText("Остановиться")
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
		Editor.PANEL.ResetCam:SetText("Налево")
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
		Editor.PANEL.ResetCam:SetText("Направо")
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
		Editor.PANEL.ResetCam:SetText("В укрытие")
		Editor.PANEL.ResetCam:SetPos(0,246)
		Editor.PANEL.ResetCam:SetSize(270,40)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("StartAnimationGenjiDance")
			net.WriteString("24")
			net.WriteString(tostring(2))
			net.SendToServer()
		end
		
		
	end
end