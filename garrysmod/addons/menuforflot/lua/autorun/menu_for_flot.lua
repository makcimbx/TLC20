if CLIENT then	

	CreateClientConVar( "anim_enabled", "0", true, false )
	
	local Editor = {}

	Editor.DelayPos = nil
	Editor.ViewPos = nil
	
	Editor.EnableToggle = GetConVar( "anim_enabled" ):GetBool() or false
	
	list.Set(
		"DesktopWindows", 
		"Меню флота",
		{
			title = "Меню флота",
			icon = "icon32/zoom_extend.png",
			width = 900,
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
			PNL:SetSize( 900, 600 )
			PNL:SetTitle( "Меню флота" )
			PNL:SetVisible( true )
			PNL:SetDraggable( true )
			PNL:ShowCloseButton( true )
			PNL:MakePopup()
		end

		Editor.PANEL = PNL
		Editor.PANEL:SetPos(ScrW() - 1500,200)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 890, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Settings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Меню флота 1", Editor.PANEL.Settings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CameraSettings = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Меню флота 2", Editor.PANEL.CameraSettings, "icon16/cog_edit.png" )
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,0)
		Editor.PANEL.CamDistanceTxt:SetText("Быстрые бинды:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[SYS] ... 25%...50%...75%...100%... Готово!")
		Editor.PANEL.ResetCam:SetPos(0,15)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [SYS] ... 25%...50%...75%...100%... Готово!" )
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[SYS] Идёт перезагрузка всех систем…")
		Editor.PANEL.ResetCam:SetPos(0,36)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [SYS] Идёт перезагрузка всех систем…" )
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[SYS] Внимание, обнаружены незначительные повреждения обшивки.")
		Editor.PANEL.ResetCam:SetPos(0,57)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [SYS] Внимание, обнаружены незначительные повреждения обшивки." )
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[SYS] Производится диагностика систем…")
		Editor.PANEL.ResetCam:SetPos(0,78)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "[SYS] Производится диагностика систем…" )
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,105)
		Editor.PANEL.CamDistanceTxt:SetText("Двигатели:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,120)
		Editor.PANEL.CamDistanceTxt:SetText("Основные:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Запускаю основные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,135)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Запускаю основные двигатели")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Поднимаю тягу основных двигателей…")
		Editor.PANEL.ResetCam:SetPos(0,156)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Поднимаю тягу основных двигателей…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Понижаю тягу основных двигателей...")
		Editor.PANEL.ResetCam:SetPos(0,177)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Понижаю тягу основных двигателей...")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Глушу основные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,198)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Глушу основные двигатели")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,220)
		Editor.PANEL.CamDistanceTxt:SetText("Вторичные:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Запускаю вторичные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,235)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Запускаю вторичные двигатели")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Поднимаю тягу вторичных двигателей…")
		Editor.PANEL.ResetCam:SetPos(0,256)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Поднимаю тягу вторичных двигателей…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Понижаю тягу вторичных двигателей...")
		Editor.PANEL.ResetCam:SetPos(0,277)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Понижаю тягу вторичных двигателей...")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Глушу вторичные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,298)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Глушу вторичные двигатели")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,320)
		Editor.PANEL.CamDistanceTxt:SetText("Третичные:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Запускаю третичные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,335)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Запускаю третичные двигатели")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Поднимаю тягу третичных двигателей…")
		Editor.PANEL.ResetCam:SetPos(0,356)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Поднимаю тягу третичных двигателей…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Понижаю тягу третичных двигателей...")
		Editor.PANEL.ResetCam:SetPos(0,377)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Понижаю тягу третичных двигателей...")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Глушу третичные двигатели")
		Editor.PANEL.ResetCam:SetPos(0,398)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Глушу третичные двигатели")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,420)
		Editor.PANEL.CamDistanceTxt:SetText("Щиты:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Активирую щиты")
		Editor.PANEL.ResetCam:SetPos(0,435)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Активирую щиты")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Деактивирую щиты")
		Editor.PANEL.ResetCam:SetPos(0,456)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Деактивирую щиты")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Перезагружаю щиты...")
		Editor.PANEL.ResetCam:SetPos(0,477)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Перезагружаю щиты...")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(400,0)
		Editor.PANEL.CamDistanceTxt:SetText("Сис-ма жизнеобеспечения:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Активирую сис-му жизнеобеспечения")
		Editor.PANEL.ResetCam:SetPos(400,15)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Активирую сис-му жизнеобеспечения")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Деактивирую сис-му жизнеобеспечения")
		Editor.PANEL.ResetCam:SetPos(400,36)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Деактивирую сис-му жизнеобеспечения")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Перезагружаю сис-му жизнеобеспечения")
		Editor.PANEL.ResetCam:SetPos(400,57)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Перезагружаю сис-му жизнеобеспечения")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(400,77)
		Editor.PANEL.CamDistanceTxt:SetText("Вооружение:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(400,90)
		Editor.PANEL.CamDistanceTxt:SetText("Сдвоенные турболаз. батареи:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру под управление сдвоенные турболаз. батареи")
		Editor.PANEL.ResetCam:SetPos(400,110)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру под управление сдвоенные турболаз. батареи")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Навожу сдвоенные турболаз. батареи…")
		Editor.PANEL.ResetCam:SetPos(400,131)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Навожу сдвоенные турболаз. батареи…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Открыл огонь из сдвоенных турболаз. батарей")
		Editor.PANEL.ResetCam:SetPos(400,152)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Открыл огонь из сдвоенных турболаз. батарей")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления сдвоенными турболаз. батареями")
		Editor.PANEL.ResetCam:SetPos(400,173)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления сдвоенными турболаз. батареями")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(400,200)
		Editor.PANEL.CamDistanceTxt:SetText("Турболазерные пушки:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру под управление турболазерные пушки")
		Editor.PANEL.ResetCam:SetPos(400,220)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру под управление турболазерные пушки")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Навожу турболазерные пушки…")
		Editor.PANEL.ResetCam:SetPos(400,241)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Навожу турболазерные пушки…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Открыл огонь из турболазерных пушек")
		Editor.PANEL.ResetCam:SetPos(400,262)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Открыл огонь из турболазерных пушек")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления турболазерными пушками")
		Editor.PANEL.ResetCam:SetPos(400,283)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления турболазерными пушками")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Settings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(400,303)
		Editor.PANEL.CamDistanceTxt:SetText("Точечные турболаз. пушки:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру под управление точечные турболаз. пушки")
		Editor.PANEL.ResetCam:SetPos(400,323)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру под управление точечные турболаз. пушки")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Навожу точечные турболаз. пушки…")
		Editor.PANEL.ResetCam:SetPos(400,344)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Навожу точечные турболаз. пушки…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Открыл огонь из точечных турболаз. пушек")
		Editor.PANEL.ResetCam:SetPos(400,365)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Открыл огонь из точечных турболаз. пушек")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.Settings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления точечными турболаз. пушками")
		Editor.PANEL.ResetCam:SetPos(400,386)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления точечными турболаз. пушками")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,0)
		Editor.PANEL.CamDistanceTxt:SetText("Проекторы притягивающего луча:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру под управление проекторы притяг. луча")
		Editor.PANEL.ResetCam:SetPos(0,15)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру под управление проекторы притяг. луча")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Навожу проекторы притягивающего луча...")
		Editor.PANEL.ResetCam:SetPos(0,36)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Навожу проекторы притягивающего луча...")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Произвожу захват цели притяг. лучом…")
		Editor.PANEL.ResetCam:SetPos(0,57)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Произвожу захват цели притяг. лучом…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Захватил цель лучом, ожидаю приказов.")
		Editor.PANEL.ResetCam:SetPos(0,78)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Захватил цель лучом, ожидаю приказов.")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Притягиваю цель лучом.")
		Editor.PANEL.ResetCam:SetPos(0,99)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Притягиваю цель лучом.")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Дезактивировал луч, цель свободна.")
		Editor.PANEL.ResetCam:SetPos(0,120)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Дезактивировал луч, цель свободна.")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления проекторами притяг. луча")
		Editor.PANEL.ResetCam:SetPos(0,141)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления проекторами притяг. луча")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,162)
		Editor.PANEL.CamDistanceTxt:SetText("Тяж. протонные торпеды:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру под управление установки с тяж. протон. торпедами")
		Editor.PANEL.ResetCam:SetPos(0,180)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру под управление установки с тяж. протон. торпедами")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Навожу тяж. протон торпеды…")
		Editor.PANEL.ResetCam:SetPos(0,201)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Навожу тяж. протон торпеды…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Открыл огонь из установок с тяж. протон. торпедами")
		Editor.PANEL.ResetCam:SetPos(0,222)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Открыл огонь из установок с тяж. протон. торпедами")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления установками тяж. протон. торпед")
		Editor.PANEL.ResetCam:SetPos(0,243)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления установками тяж. протон. торпед")
		end
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.CameraSettings:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,263)
		Editor.PANEL.CamDistanceTxt:SetText("Радар:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Беру управление радаром на себя.")
		Editor.PANEL.ResetCam:SetPos(0,281)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Беру управление радаром на себя.")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Произвожу сканирование системы…")
		Editor.PANEL.ResetCam:SetPos(0,302)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Произвожу сканирование системы…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Радар засек неопознанные объекты!")
		Editor.PANEL.ResetCam:SetPos(0,323)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Радар засек неопознанные объекты!")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Сканирую неопознанные объекты…")
		Editor.PANEL.ResetCam:SetPos(0,344)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Сканирую неопознанные объекты…")
		end
		
		Editor.PANEL.ResetCam = Editor.PANEL.CameraSettings:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("[VEN] Снялся с управления радаром.")
		Editor.PANEL.ResetCam:SetPos(0,365)
		Editor.PANEL.ResetCam:SetSize(375,20)
		Editor.PANEL.ResetCam.DoClick = function()
		    RunConsoleCommand( "say", "/advert [VEN] "..LocalPlayer():Nick()..": Снялся с управления радаром.")
		end
	end
end