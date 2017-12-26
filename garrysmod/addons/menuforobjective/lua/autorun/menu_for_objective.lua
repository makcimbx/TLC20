if CLIENT then	

    local function HUDPaint()
		
		local posX = 0

		local posY = 50
		
		draw.RoundedBox(6,30+posX,30+posY,375,125,Color(0,0,0,200))
		draw.RoundedBox(0,30+posX,60+posY,375,3,Color(255,255,255,220))
		
		draw.RoundedBox(6,30+posX,30+125+30+posY,375,125,Color(0,0,0,200))
		draw.RoundedBox(0,30+posX,30+125+60+posY,375,3,Color(255,255,255,220))
		
		draw.DrawText('ТЕКУЩАЯ СИТУАЦИЯ', "CloseCaption_Normal", 40+posX,30+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText('ТЕКУЩАЯ ЗАДАЧА', "CloseCaption_Normal", 40+posX,30+125+30+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		draw.DrawText(s1 or "", "HudHintTextLarge", 40+posX,60+10+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText(s2 or "", "HudHintTextLarge", 40+posX,60+25+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText(s3 or "", "HudHintTextLarge", 40+posX,60+40+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		draw.DrawText(s4 or "", "HudHintTextLarge", 40+posX,30+125+60+10+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText(s5 or "", "HudHintTextLarge", 40+posX,30+125+60+25+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText(s6 or "", "HudHintTextLarge", 40+posX,30+125+60+40+posY,Color(255,255,255,220), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
    end
    hook.Add("HUDPaint", "manolis:MVLevels:DrawThisShitAntiCheat", HUDPaint) 

    

	CreateClientConVar( "objective_enabled", "0", true, false )
	
	local Editor = {}

	Editor.DelayPos = nil
	Editor.ViewPos = nil
	
	Editor.EnableToggle = GetConVar( "objective_enabled" ):GetBool() or false
	
	list.Set(
		"DesktopWindows", 
		"Меню задач",
		{
			title = "Меню задач",
			icon = "icon32/zoom_extend.png",
			width = 300,
			height = 340,
			onewindow = true,
			init = function(icn, pnl)
			    if (serverguard.player:HasPermission(LocalPlayer(), "Object Menu")) then
				BuildObjectiveMenu(pnl)
				end
			end
		}
	)
	
	function BuildObjectiveMenu(PNL)
	
		if Editor.PANEL != nil then
			Editor.PANEL:Remove()
		end
		
		if PNL == nil then	
			PNL = vgui.Create( "DFrame" )
			PNL:SetSize( 300, 340 )
			PNL:SetTitle( "Меню задач" )
			PNL:SetVisible( true )
			PNL:SetDraggable( true )
			PNL:ShowCloseButton( true )
			PNL:MakePopup()
		end

		Editor.PANEL = PNL
		Editor.PANEL:SetPos(ScrW() - 1500,200)
		
		Editor.PANEL.Sheet = Editor.PANEL:Add( "DPropertySheet" )
		Editor.PANEL.Sheet:Dock(LEFT)
		Editor.PANEL.Sheet:SetSize( 290, 0 )
		Editor.PANEL.Sheet:SetPos(5,0)
		
		Editor.PANEL.Zadacha = Editor.PANEL.Sheet:Add( "DPanelSelect" )
		Editor.PANEL.Sheet:AddSheet( "Основное", Editor.PANEL.Zadacha, "icon16/cog_edit.png" )
		
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,0)
		Editor.PANEL.CamDistanceTxt:SetText("Текущая ситуация:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,30)
		Editor.PANEL.CamDistanceTxt:SetText("1 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,60)
		Editor.PANEL.CamDistanceTxt:SetText("2 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,90)
		Editor.PANEL.CamDistanceTxt:SetText("3 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,120)
		Editor.PANEL.CamDistanceTxt:SetText("Текущая задача:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,150)
		Editor.PANEL.CamDistanceTxt:SetText("1 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,180)
		Editor.PANEL.CamDistanceTxt:SetText("2 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		Editor.PANEL.CamDistanceTxt = Editor.PANEL.Zadacha:Add("DLabel")
		Editor.PANEL.CamDistanceTxt:SetPos(0,210)
		Editor.PANEL.CamDistanceTxt:SetText("3 строка:")
		Editor.PANEL.CamDistanceTxt:SizeToContents() 
		
		
		Editor.PANEL.ResetCam = Editor.PANEL.Zadacha:Add( "DButton" )
		Editor.PANEL.ResetCam:SizeToContents()
		Editor.PANEL.ResetCam:SetText("Изменить на всём сервере")
		Editor.PANEL.ResetCam:SetPos(0,240)
		Editor.PANEL.ResetCam:SetSize(270,30)
		Editor.PANEL.ResetCam.DoClick = function()
		    net.Start("ObjectiveMenuHoly")
			net.WriteString(s1)
			net.WriteString(s2)
			net.WriteString(s3)
			net.WriteString(s4)
			net.WriteString(s5)
			net.WriteString(s6)
			net.SendToServer()
		end
		
		Editor.PANEL.CamDistanceLb1 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb1:SetPos(60,28)
		Editor.PANEL.CamDistanceLb1:SetValue(s1)
		Editor.PANEL.CamDistanceLb1:SetSize(200,20)
		Editor.PANEL.CamDistanceLb1:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb1:SetUpdateOnType(false)
		
		Editor.PANEL.CamDistanceLb1.OnTextChanged  = function()
		    s1 = Editor.PANEL.CamDistanceLb1:GetValue()
		end
		
		
		Editor.PANEL.CamDistanceLb2 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb2:SetPos(60,58)
		Editor.PANEL.CamDistanceLb2:SetValue(s2)
		Editor.PANEL.CamDistanceLb2:SetSize(200,20)
		Editor.PANEL.CamDistanceLb2:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb2:SetUpdateOnType(true)
		
		Editor.PANEL.CamDistanceLb2.OnTextChanged  = function()
		    s2 = Editor.PANEL.CamDistanceLb2:GetValue()
		end
		
		Editor.PANEL.CamDistanceLb3 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb3:SetPos(60,88)
		Editor.PANEL.CamDistanceLb3:SetValue(s3)
		Editor.PANEL.CamDistanceLb3:SetSize(200,20)
		Editor.PANEL.CamDistanceLb3:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb3:SetUpdateOnType(true)
		
		Editor.PANEL.CamDistanceLb3.OnTextChanged  = function()
		    s3 = Editor.PANEL.CamDistanceLb3:GetValue()
		end
		
		Editor.PANEL.CamDistanceLb4 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb4:SetPos(60,178)
		Editor.PANEL.CamDistanceLb4:SetValue(s4)
		Editor.PANEL.CamDistanceLb4:SetSize(200,20)
		Editor.PANEL.CamDistanceLb4:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb4:SetUpdateOnType(true)
		
		Editor.PANEL.CamDistanceLb4.OnTextChanged  = function()
		    s5 = Editor.PANEL.CamDistanceLb4:GetValue()
		end
		
		Editor.PANEL.CamDistanceLb5 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb5:SetPos(60,148)
		Editor.PANEL.CamDistanceLb5:SetValue(s5)
		Editor.PANEL.CamDistanceLb5:SetSize(200,20)
		Editor.PANEL.CamDistanceLb5:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb5:SetUpdateOnType(true)
		
		Editor.PANEL.CamDistanceLb5.OnTextChanged  = function()
		    s4 = Editor.PANEL.CamDistanceLb5:GetValue()
		end
		
		Editor.PANEL.CamDistanceLb6 = Editor.PANEL.Zadacha:Add("DTextEntry")
		Editor.PANEL.CamDistanceLb6:SetPos(60,208)
		Editor.PANEL.CamDistanceLb6:SetValue(s6)
		Editor.PANEL.CamDistanceLb6:SetSize(200,20)
		Editor.PANEL.CamDistanceLb6:SetNumeric(false)	
		Editor.PANEL.CamDistanceLb6:SetUpdateOnType(true)
		
		Editor.PANEL.CamDistanceLb6.OnTextChanged  = function()
		    s6 = Editor.PANEL.CamDistanceLb6:GetValue()
		end
	end
end
