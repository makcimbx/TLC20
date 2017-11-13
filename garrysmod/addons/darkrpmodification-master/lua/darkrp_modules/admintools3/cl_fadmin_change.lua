function FAdmin.ScoreBoard.ShowScoreBoard()
    FAdmin.ScoreBoard.Visible = true
    FAdmin.ScoreBoard.DontGoBack = input.IsMouseDown(MOUSE_4) or input.IsKeyDown(KEY_BACKSPACE)

    FAdmin.ScoreBoard.Controls.Hostname = FAdmin.ScoreBoard.Controls.Hostname or vgui.Create("DLabel")
    FAdmin.ScoreBoard.Controls.Hostname:SetText(DarkRP.deLocalise(GetHostName()))
    FAdmin.ScoreBoard.Controls.Hostname:SetFont("ScoreboardHeader")
    FAdmin.ScoreBoard.Controls.Hostname:SetColor(Color(200,200,200,200))
    FAdmin.ScoreBoard.Controls.Hostname:SetPos(FAdmin.ScoreBoard.X + 90, FAdmin.ScoreBoard.Y + 20)
    FAdmin.ScoreBoard.Controls.Hostname:SizeToContents()
    FAdmin.ScoreBoard.Controls.Hostname:SetVisible(true)

    FAdmin.ScoreBoard.Controls.Description = FAdmin.ScoreBoard.Controls.Description or vgui.Create("DLabel")
    FAdmin.ScoreBoard.Controls.Description:SetText(string.format("%s %s\n%s", GAMEMODE.Name, GAMEMODE.Version, GAMEMODE.Author))
    FAdmin.ScoreBoard.Controls.Description:SetFont("ScoreboardSubtitle")
    FAdmin.ScoreBoard.Controls.Description:SetColor(Color(200,200,200,200))
    FAdmin.ScoreBoard.Controls.Description:SetPos(FAdmin.ScoreBoard.X + 90, FAdmin.ScoreBoard.Y + 50)
    FAdmin.ScoreBoard.Controls.Description:SizeToContents()
    if FAdmin.ScoreBoard.X + FAdmin.ScoreBoard.Width / 9.5 + FAdmin.ScoreBoard.Controls.Description:GetWide() > FAdmin.ScoreBoard.Width - 150 then
        FAdmin.ScoreBoard.Controls.Description:SetFont("Trebuchet18")
        FAdmin.ScoreBoard.Controls.Description:SetPos(FAdmin.ScoreBoard.X + 90, FAdmin.ScoreBoard.Y + 50)
    end
    FAdmin.ScoreBoard.Controls.Description:SetVisible(true)

    FAdmin.ScoreBoard.Controls.ServerSettingsLabel = FAdmin.ScoreBoard.Controls.ServerSettingsLabel or vgui.Create("DLabel")
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SetFont("ScoreboardSubtitle")
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SetText("Server settings")
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SetColor(Color(200,200,200,200))
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SizeToContents()
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SetPos(FAdmin.ScoreBoard.Width-150, FAdmin.ScoreBoard.Y + 68)
    FAdmin.ScoreBoard.Controls.ServerSettingsLabel:SetVisible(true)

    FAdmin.ScoreBoard.Controls.ServerSettings = FAdmin.ScoreBoard.Controls.ServerSettings or vgui.Create("DImageButton")
    FAdmin.ScoreBoard.Controls.ServerSettings:SetMaterial("vgui/gmod_tool")
    FAdmin.ScoreBoard.Controls.ServerSettings:SetPos(FAdmin.ScoreBoard.Width-200, FAdmin.ScoreBoard.Y - 20)
    FAdmin.ScoreBoard.Controls.ServerSettings:SizeToContents()
    FAdmin.ScoreBoard.Controls.ServerSettings:SetVisible(true)

    function FAdmin.ScoreBoard.Controls.ServerSettings:DoClick()
        FAdmin.ScoreBoard.ChangeView("Server")
    end
	
	
    FAdmin.ScoreBoard.Controls.Change = vgui.Create("DImageButton")
    FAdmin.ScoreBoard.Controls.Change:SetMaterial("fadmin/change2.png")
    FAdmin.ScoreBoard.Controls.Change:SetPos(FAdmin.ScoreBoard.Width-360, FAdmin.ScoreBoard.Y - 20)
    FAdmin.ScoreBoard.Controls.Change:SetSize( 128, 128 )
    FAdmin.ScoreBoard.Controls.Change:SetVisible(true)

    function FAdmin.ScoreBoard.Controls.Change:DoClick()
        fadminChange = !fadminChange
		
		if(fadminChange==false)then
			Ever_OpenHud()
			if FAdmin.GlobalSetting.FAdmin or OverrideScoreboard:GetBool() then -- Don't show scoreboard when FAdmin is not installed on server
				return FAdmin.ScoreBoard.HideScoreBoard()
			end
		end
    end

    if FAdmin.ScoreBoard.Controls.BackButton then FAdmin.ScoreBoard.Controls.BackButton:SetVisible(true) end

    FAdmin.ScoreBoard[FAdmin.ScoreBoard.CurrentView].Show()

    gui.EnableScreenClicker(true)
    hook.Add("HUDPaint", "FAdmin_ScoreBoard", FAdmin.ScoreBoard.DrawScoreBoard)
    hook.Call("FAdmin_ShowFAdminMenu")
    return true
end
concommand.Add("+FAdmin_menu", FAdmin.ScoreBoard.ShowScoreBoard)