if CLIENT then	

	CreateClientConVar( "dsablehud_enabled", "0", true, false )
	
	local Editor = {}

	Editor.DelayPos = nil
	Editor.ViewPos = nil
	
	Editor.EnableToggle = GetConVar( "dsablehud_enabled" ):GetBool() or false
	
	list.Set(
		"DesktopWindows", 
		"Вкл/Откл худ",
		{
			title = "Вкл/Откл элементов Худа",
			icon = "icon32/zoom_extend.png",
			width = 300,
			height = 300,
			onewindow = true,
			init = function(icn, pnl)
				BuildDisMenu(pnl)
			end
		}
	)
	
	function BuildDisMenu(PNL)
	
		if Editor.PANEL != nil then
			Editor.PANEL:Remove()
		end
		
		if PNL == nil then	
			PNL = vgui.Create( "DFrame" )
			PNL:SetSize( 300, 300 )
			PNL:SetTitle( "Вкл/Откл элементов Худа" )
			PNL:SetVisible( true )
			PNL:SetDraggable( true )
			PNL:ShowCloseButton( true )
			PNL:MakePopup()
		end

		Editor.PANEL = PNL
		Editor.PANEL:SetPos(ScrW()/6,200)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 290, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Zadacha = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Основное", Editor.PANEL.Zadacha, "icon16/cog_edit.png" )
		
		
		Editor.PANEL.EnableThrd = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd:SizeToContents()
		
		if Editor.EnableToggle then
			Editor.PANEL.EnableThrd:SetText("Enable Hud 1")
			Editor.PANEL.EnableThrd:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd:SetText("Disable Hud 1")
			Editor.PANEL.EnableThrd:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd:SetPos(10,6)
		Editor.PANEL.EnableThrd:SetSize(250,20)
		Editor.PANEL.EnableThrd.DoClick = function()

			Editor.EnableToggle = !Editor.EnableToggle

			if Editor.EnableToggle then
				Editor.PANEL.EnableThrd:SetText("Enable Hud 1")
				Editor.PANEL.EnableThrd:SetTextColor(Color(0,150,0))
				RunConsoleCommand("xpvrodhuddisabled","1")
			else
				Editor.PANEL.EnableThrd:SetText("Disable Hud 1")
				Editor.PANEL.EnableThrd:SetTextColor(Color(150,0,0))
				RunConsoleCommand("xpvrodhuddisabled","0")
			end
					
		end
		
		
		
		Editor.PANEL.EnableThrd1 = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd1:SizeToContents()
		
		if Editor.EnableToggle1 then
			Editor.PANEL.EnableThrd1:SetText("Enable Hud 2")
			Editor.PANEL.EnableThrd1:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd1:SetText("Disable Hud 2")
			Editor.PANEL.EnableThrd1:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd1:SetPos(10,36)
		Editor.PANEL.EnableThrd1:SetSize(250,20)
		Editor.PANEL.EnableThrd1.DoClick = function()

			Editor.EnableToggle1 = !Editor.EnableToggle1

			if Editor.EnableToggle1 then
				Editor.PANEL.EnableThrd1:SetText("Enable Hud 2")
				Editor.PANEL.EnableThrd1:SetTextColor(Color(0,150,0))
				RunConsoleCommand("xpwoshuddisabled","1")
			else
				Editor.PANEL.EnableThrd1:SetText("Disable Hud 2")
				Editor.PANEL.EnableThrd1:SetTextColor(Color(150,0,0))
				RunConsoleCommand("xpwoshuddisabled","0")
			end
					
		end
		
		
		Editor.PANEL.EnableThrd2 = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd2:SizeToContents()
		
		if Editor.EnableToggle2 then
			Editor.PANEL.EnableThrd2:SetText("Enable Hud 3")
			Editor.PANEL.EnableThrd2:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd2:SetText("Disable Hud 3")
			Editor.PANEL.EnableThrd2:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd2:SetPos(10,66)
		Editor.PANEL.EnableThrd2:SetSize(250,20)
		Editor.PANEL.EnableThrd2.DoClick = function()

			Editor.EnableToggle2 = !Editor.EnableToggle2

			if Editor.EnableToggle2 then
				Editor.PANEL.EnableThrd2:SetText("Enable Hud 3")
				Editor.PANEL.EnableThrd2:SetTextColor(Color(0,150,0))
				RunConsoleCommand("radhuddisabled","1")
			else
				Editor.PANEL.EnableThrd2:SetText("Disable Hud 3")
				Editor.PANEL.EnableThrd2:SetTextColor(Color(150,0,0))
				RunConsoleCommand("radhuddisabled","0")
			end
					
		end
		
		
		Editor.PANEL.EnableThrd3 = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd3:SizeToContents()
		
		if Editor.EnableToggle3 then
			Editor.PANEL.EnableThrd3:SetText("Enable Hud 4")
			Editor.PANEL.EnableThrd3:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd3:SetText("Disable Hud 4")
			Editor.PANEL.EnableThrd3:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd3:SetPos(10,96)
		Editor.PANEL.EnableThrd3:SetSize(250,20)
		Editor.PANEL.EnableThrd3.DoClick = function()

			Editor.EnableToggle3 = !Editor.EnableToggle3

			if Editor.EnableToggle3 then
				Editor.PANEL.EnableThrd3:SetText("Enable Hud 4")
				Editor.PANEL.EnableThrd3:SetTextColor(Color(0,150,0))
				RunConsoleCommand("objhuddisabled","1")
			else
				Editor.PANEL.EnableThrd3:SetText("Disable Hud 4")
				Editor.PANEL.EnableThrd3:SetTextColor(Color(150,0,0))
				RunConsoleCommand("objhuddisabled","0")
			end
					
		end
		
		
		Editor.PANEL.EnableThrd4 = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd4:SizeToContents()
		
		if Editor.EnableToggle4 then
			Editor.PANEL.EnableThrd4:SetText("Enable Hud 5")
			Editor.PANEL.EnableThrd4:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd4:SetText("Disable Hud 5")
			Editor.PANEL.EnableThrd4:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd4:SetPos(10,126)
		Editor.PANEL.EnableThrd4:SetSize(250,20)
		Editor.PANEL.EnableThrd4.DoClick = function()

			Editor.EnableToggle4 = !Editor.EnableToggle4

			if Editor.EnableToggle4 then
				Editor.PANEL.EnableThrd4:SetText("Enable Hud 5")
				Editor.PANEL.EnableThrd4:SetTextColor(Color(0,150,0))
				RunConsoleCommand("eventhuddisabled","1")
			else
				Editor.PANEL.EnableThrd4:SetText("Disable Hud 5")
				Editor.PANEL.EnableThrd4:SetTextColor(Color(150,0,0))
				RunConsoleCommand("eventhuddisabled","0")
			end
					
		end
		
		
		Editor.PANEL.EnableThrd5 = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.EnableThrd5:SizeToContents()
		
		if Editor.EnableToggle5 then
			Editor.PANEL.EnableThrd5:SetText("Enable Hud 6")
			Editor.PANEL.EnableThrd5:SetTextColor(Color(0,150,0))
		else
			Editor.PANEL.EnableThrd5:SetText("Disable Hud 6")
			Editor.PANEL.EnableThrd5:SetTextColor(Color(150,0,0))
		end
		
		Editor.PANEL.EnableThrd5:SetPos(10,156)
		Editor.PANEL.EnableThrd5:SetSize(250,20)
		Editor.PANEL.EnableThrd5.DoClick = function()

			Editor.EnableToggle5 = !Editor.EnableToggle5

			if Editor.EnableToggle5 then
				Editor.PANEL.EnableThrd5:SetText("Enable Hud 6")
				Editor.PANEL.EnableThrd5:SetTextColor(Color(0,150,0))
				RunConsoleCommand("utime_enable","0")
			else
				Editor.PANEL.EnableThrd5:SetText("Disable Hud 6")
				Editor.PANEL.EnableThrd5:SetTextColor(Color(150,0,0))
				RunConsoleCommand("utime_enable","1")
			end
					
		end
		
	end
end
