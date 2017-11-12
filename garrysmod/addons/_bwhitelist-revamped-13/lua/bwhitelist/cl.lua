if (IsValid(BWhitelist.Menu)) then
	BWhitelist.Menu:Close()
end

function BWhitelist:chatprint(msg,type)
	if (type == "error" or type == "bad") then
		chat.AddText(Color(255,0,0),"[BWhitelist] ",Color(255,255,255),msg)
	elseif (type == "success" or type == "good") then
		chat.AddText(Color(0,255,0),"[BWhitelist] ",Color(255,255,255),msg)
	else
		chat.AddText(Color(0,255,255),"[BWhitelist] ",Color(255,255,255),msg)
	end
end

BWhitelist:netr("notify",function()
	BWhitelist:chatprint(BWhitelist:t("notify"))
end)
BWhitelist:netr("notify_success",function()
	BWhitelist:chatprint(BWhitelist:t("notify_success"),"good")
end)
BWhitelist:netr("notify_failure",function()
	BWhitelist:chatprint(BWhitelist:t("notify_failure"),"bad")
end)
BWhitelist:netr("permission_failure",function()
	BWhitelist:chatprint(BWhitelist:t("permission_failure"),"bad")
end)

local net_receiver_messages = {
	"check_if_whitelist_enabled",
	"enable_whitelist",
	"add_to_whitelist",
	"remove_from_whitelist",
	"disable_whitelist",
	"clear_whitelist",
	"get_enabled_whitelist",
	"get_last_enabled_whitelist",
	"no_enabled_whitelists",
	"import_from_nordahl",
	"import_from_old_bwhitelist",
	"import_from_mayoz",
	"enable_all_whitelists",
	"disable_all_whitelists",
	"reset_everything",
	"customcheckerror",
	"clear_unknown_jobs",
}

BWhitelist.Permissed = {}
BWhitelist.WhitelistsEnabled = {}
BWhitelist.Blacklists = {}
BWhitelist:netr("get_all_blacklists",function()
	local team = net.ReadString()
	BWhitelist.Blacklists[team] = true
end)
BWhitelist:netr("get_all_permissed",function()
	local team = net.ReadString()
	BWhitelist.Permissed[team] = true
end)
BWhitelist:timer("get_all_permissed",0.5,0,function()
	BWhitelist:nets("get_all_permissed")
	net.SendToServer()
	BWhitelist:untimer("get_all_permissed")
end)
BWhitelist:netr("get_a_permissed",function()
	local team = net.ReadString()
	local perm = net.ReadBool()
	local tell = net.ReadBool()
	if (perm == false) then
		BWhitelist.Permissed[team] = nil
		if (tell) then BWhitelist:chatprint(BWhitelist:t("removed_from_whitelist"):format(team),"bad") end
	else
		BWhitelist.Permissed[team] = true
		if (tell) then BWhitelist:chatprint(BWhitelist:t("added_to_whitelist"):format(team),"good") end
	end
end)
BWhitelist:netr("get_a_enabled",function()
	local team = net.ReadString()
	BWhitelist.WhitelistsEnabled[team] = true
end)

BWhitelist:netr("no_import",function()
	Billy_Message(BWhitelist:t("no_import"),BWhitelist:t("error"))
end)

BWhitelist:netr("already_exists",function()
	Billy_Message(BWhitelist:t("already_exists"),BWhitelist:t("error"))
end)
BWhitelist:netr("doesnt_exist",function()
	Billy_Message(BWhitelist:t("doesnt_exist"),BWhitelist:t("error"))
end)

local function openmenu()

	if (IsValid(BWhitelist.Menu)) then
		BWhitelist.Menu:Close()
	end

	local team_number_cache = {}
	for i,v in pairs(RPExtraTeams) do
		if (team_number_cache[v.name]) then
			BillyError("BWhitelist","The team \"" .. v .. "\" already has another team with the same name. Please rename or remove the duplicate team.")
			return
		end
		team_number_cache[v.name] = i
	end

	local admin_mode = BWhitelist:IsMaxPermitted()

	BWhitelist.Menu = vgui.Create("BFrame")
	local m = BWhitelist.Menu
	m.NetReceiver = {}
	m:SetSize(700,580)
	m:Center()
	if (admin_mode) then
		m:SetTitle("BWhitelist " .. BWhitelist.Version .. " | " .. BWhitelist:t("admin_mode"))
		m:SetIcon("icon16/shield.png")
	else
		m:SetTitle("BWhitelist " .. BWhitelist.Version)
		m:SetIcon("icon16/user.png")
	end
	m:Configured()
	m:MakePopup()

	for _,v in pairs(net_receiver_messages) do
		BWhitelist:netr(v,function(...)
			if (m.NetReceiver) then
				if (m.NetReceiver[v]) then
					m.NetReceiver[v](...)
				end
			end
		end)
	end

	m.Tabs = vgui.Create("BTabs",m)
	m.Tabs:SetSize(m:GetWide(),35)
	m.Tabs:AlignTop(24)

	m.JobsPanel = vgui.Create("BTabs_Panel",m)
	m.JobsPanel:SetTabs(m.Tabs)
	m.JobsPanel:SetSize(m:GetWide(),m:GetTall() - 24 - m.Tabs:GetTall())

		local update_jobs_searching_for = ""
		local function update_jobs()
			for _,c in pairs(DarkRP.getCategories().jobs) do
				if (#c.members == 0) then continue end
				local catted = false
				for _,v in pairs(c.members) do
					if (v.name:lower():find(update_jobs_searching_for:lower()) or update_jobs_searching_for == "") then
						if (not catted) then
							m.JobsPanel.Jobs:NewCategory(c.name,Color(52,139,249))
							catted = true
						end
						m.JobsPanel.Jobs:NewItem(v.name,Color(52,139,249),function()
							BWhitelist:nets("stop_data_flow")
							net.SendToServer()

							m.JobsPanel.Title:SetText(v.name)
							m.JobsPanel.Title:SizeToContents()
							m.JobsPanel.Title:CenterHorizontal()
							m.JobsPanel.Title:AlignTop(10)

							BWhitelist:nets("get_blacklisted")
								net.WriteString(v.name)
							net.SendToServer()
							function m.JobsPanel.IsBlacklist:OnChange()
								BWhitelist:nets("blacklist")
									net.WriteString(m.JobsPanel.Title:GetText())
									net.WriteBool(m.JobsPanel.IsBlacklist:GetChecked())
								net.SendToServer()
							end

							m.JobsPanel.RemoveFromWhitelist:SetDisabled(true)
							m.JobsPanel.DisableButton:SetDisabled(true)
							m.JobsPanel.CopyButton:SetDisabled(true)
							m.JobsPanel.SteamProfileButton:SetDisabled(true)

							m.JobsPanel.BottomBar.ProgressBar.Value = 0
							m.JobsPanel.BottomBar.ProgressBar.Max = 1

							m.JobsPanel.InfoPanel.Text:Center()

							m.JobsPanel.MouseBlock:AlignRight()
							m.JobsPanel.MouseBlock:AlignBottom()

							m.JobsPanel.List:Clear()

							m.JobsPanel.DisableButton:SetDisabled(true)
							m.JobsPanel.ClearButton:SetDisabled(true)

							m.JobsPanel.InfoPanel.EnableButton:SetVisible(false)

							if (GAMEMODE.DefaultTeam == team_number_cache[v.name]) then
								m.JobsPanel.MouseBlock:AlignRight()
								local x,y = m.JobsPanel.MouseBlock:GetPos()
								m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
								m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("default_team"))
								m.JobsPanel.InfoPanel.Text:SizeToContents()
								m.JobsPanel.InfoPanel.Text:Center()
								return
							end

							m.NetReceiver["customcheckerror"] = function()
								m.JobsPanel.MouseBlock:AlignRight()
								local x,y = m.JobsPanel.MouseBlock:GetPos()
								m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
								m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("customcheck_team"))
								m.JobsPanel.InfoPanel.Text:SizeToContents()
								m.JobsPanel.InfoPanel.Text:Center()
								return
							end

							if (not BWhitelist:HasAccess(LocalPlayer(),v.name)) then
								m.JobsPanel.MouseBlock:AlignRight()
								local x,y = m.JobsPanel.MouseBlock:GetPos()
								m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
								m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("no_whitelist_permission"))
								m.JobsPanel.InfoPanel.Text:SizeToContents()
								m.JobsPanel.InfoPanel.Text:Center()
								return
							end

							m.JobsPanel.List:AddLine(BWhitelist:t("retrieving"))
							m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("retrieving"))
							m.JobsPanel.InfoPanel.Text:SizeToContents()
							m.JobsPanel.InfoPanel.Text:Center()

							m.NetReceiver["check_if_whitelist_enabled"] = function()
								local is_enabled = net.ReadBool()

								if (is_enabled) then
									m.JobsPanel.InfoPanel:MoveTo(m:GetWide(),0,0.5)
									m.JobsPanel.MouseBlock:AlignRight(-m:GetWide())

									if (v.BWhitelist == true) then
										m.JobsPanel.DisableButton:SetDisabled(true)
										m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("in_jobs_file_tooltip"))
									else
										if (BWhitelist.Config.MaxPermittedDisableWhitelists == true) then
											if (admin_mode) then
												m.JobsPanel.DisableButton:SetDisabled(false)
												m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("disable_whitelist_tooltip"))
											else
												m.JobsPanel.DisableButton:SetDisabled(true)
												m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("permission_failure"))
											end
										else
											m.JobsPanel.DisableButton:SetDisabled(false)
											m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("disable_whitelist_tooltip"))
										end
									end
									if (admin_mode) then
										m.JobsPanel.ClearButton:SetDisabled(false)
									end
									m.JobsPanel.AddToWhitelist:SetDisabled(false)

									BWhitelist:nets("start_data_flow")
										net.WriteString(v.name)
									net.SendToServer()
								else
									m.JobsPanel.MouseBlock:AlignRight()
									local x,y = m.JobsPanel.MouseBlock:GetPos()
									m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
									m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("disabled_whitelist"))
									m.JobsPanel.InfoPanel.Text:SizeToContents()
									m.JobsPanel.InfoPanel.Text:Center()
									local x,y = m.JobsPanel.InfoPanel.Text:GetPos()
									m.JobsPanel.InfoPanel.Text:SetPos(x,y - 35)
									m.JobsPanel.InfoPanel.EnableButton:SetVisible(true)
								end
							end
							m.NetReceiver["add_to_whitelist"] = function()
								local is_usergroup = net.ReadBool()
								local team = net.ReadString()
								if (team ~= v.name) then return end
								local value = net.ReadString()
								local player_name = net.ReadString()
								local s = "SteamID"
								if (is_usergroup) then
									s = "Usergroup"
								end
								m.JobsPanel.List:AddLine(s,value,player_name)
							end
							m.NetReceiver["remove_from_whitelist"] = function()
								local is_usergroup = net.ReadBool()
								local team = net.ReadString()
								if (team ~= v.name) then return end
								local value = net.ReadString()
								if (is_usergroup) then
									for i,v in pairs(m.JobsPanel.List:GetLines()) do
										if (v:GetValue(1) == "Usergroup") then
											if (v:GetValue(2) == value) then
												m.JobsPanel.List:RemoveLine(i)
												break
											end
										end
									end
								else
									for i,v in pairs(m.JobsPanel.List:GetLines()) do
										if (v:GetValue(1) == "SteamID") then
											if (v:GetValue(2) == value) then
												m.JobsPanel.List:RemoveLine(i)
												break
											end
										end
									end
								end
							end
							m.NetReceiver["enable_whitelist"] = function()
								local team = net.ReadString()
								BWhitelist.WhitelistsEnabled[team] = true
								if (v.name == team) then
									m.JobsPanel.InfoPanel:MoveTo(m:GetWide(),0,0.5)
									m.JobsPanel.MouseBlock:AlignRight(-m:GetWide())

									if (v.BWhitelist == true) then
										m.JobsPanel.DisableButton:SetDisabled(true)
										m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("in_jobs_file_tooltip"))
									else
										if (BWhitelist.Config.MaxPermittedDisableWhitelists == true) then
											if (admin_mode) then
												m.JobsPanel.DisableButton:SetDisabled(false)
												m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("disable_whitelist_tooltip"))
											else
												m.JobsPanel.DisableButton:SetDisabled(true)
												m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("permission_failure"))
											end
										else
											m.JobsPanel.DisableButton:SetDisabled(false)
											m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("disable_whitelist_tooltip"))
										end
									end
									if (admin_mode) then
										m.JobsPanel.ClearButton:SetDisabled(false)
									end
									m.JobsPanel.AddToWhitelist:SetDisabled(false)

									BWhitelist:nets("start_data_flow")
										net.WriteString(v.name)
									net.SendToServer()
								end
							end
							m.NetReceiver["disable_whitelist"] = function()
								local team = net.ReadString()
								BWhitelist.WhitelistsEnabled[team] = nil
								if (v.name == team) then
									m.JobsPanel.MouseBlock:AlignRight()
									local x,y = m.JobsPanel.MouseBlock:GetPos()
									m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
									m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("disabled_whitelist"))
									m.JobsPanel.InfoPanel.Text:SizeToContents()
									m.JobsPanel.InfoPanel.Text:Center()
									local x,y = m.JobsPanel.InfoPanel.Text:GetPos()
									m.JobsPanel.InfoPanel.Text:SetPos(x,y - 35)
									m.JobsPanel.InfoPanel.EnableButton:SetVisible(true)
								end
							end
							m.NetReceiver["clear_whitelist"] = function()
								local team = net.ReadString()
								if (v.name == team) then
									m.JobsPanel.List:Clear()
									m.JobsPanel.List:AddLine(BWhitelist:t("no_data"))
								end
							end
							BWhitelist:nets("check_if_whitelist_enabled")
								net.WriteString(v.name)
							net.SendToServer()
						end,true)
					end
				end
			end
		end

		local update_jobs_coroutine

		m.JobsPanel.SearchJobs = vgui.Create("BTextBox",m.JobsPanel)
		m.JobsPanel.SearchJobs:SetSize(200,32)
		m.JobsPanel.SearchJobs:AlignTop(-1)
		m.JobsPanel.SearchJobs:SetPlaceHolder(BWhitelist:t("search_jobs"))
		m.JobsPanel.SearchJobs.Typed = function(t)
			update_jobs_searching_for = t
			m.JobsPanel.Jobs:Clear()
			update_jobs_coroutine = coroutine.create(update_jobs)
			coroutine.resume(update_jobs_coroutine)
		end

		m.JobsPanel.Jobs = vgui.Create("BCategories",m.JobsPanel)
		m.JobsPanel.Jobs:SetSize(200,m.JobsPanel:GetTall() - 75)
		m.JobsPanel.Jobs:AlignBottom(45)
		update_jobs_coroutine = coroutine.create(update_jobs)
		coroutine.resume(update_jobs_coroutine)

		m.LanguagePanel = vgui.Create("BPanel",m.JobsPanel)
		m.LanguagePanel:SetSize(200,45)
		m.LanguagePanel:AlignBottom()
		m.LanguagePanel:DockPadding(10,10,10,10)

		m.LanguagePanel.Selector = vgui.Create("DComboBox",m.LanguagePanel)
		m.LanguagePanel.Selector:Dock(FILL)
		m.LanguagePanel.Selector:AddChoice("English",nil,true)
		local f = file.Find("bwhitelist/lang/*.lua","LUA")
		for _,v in pairs(f) do
			v = ((v):gsub("%.lua$",""))
			if (BWhitelist.SelectedLanguage == v:sub(1,1):upper() .. v:sub(2)) then
				m.LanguagePanel.Selector:AddChoice(v:sub(1,1):upper() .. v:sub(2),nil,true)
			else
				m.LanguagePanel.Selector:AddChoice(v:sub(1,1):upper() .. v:sub(2))
			end
		end
		m.LanguagePanel.Selector:SetText(BWhitelist.SelectedLanguage)
		m.LanguagePanel.Selector.OnSelect = function(_,__,l)
			BWhitelist.SelectedLanguage = l
			if (l == "English") then
				BWhitelist.Language = nil
			else
				include("bwhitelist/lang/" .. l:lower() .. ".lua")
			end
			file.Write("bwhitelist_language.txt",l:lower())
			BWhitelist.Menu:Close()
			openmenu()
		end

		m.JobsPanel.BottomBar = vgui.Create("BPanel",m.JobsPanel)
		m.JobsPanel.BottomBar:SetSize(m.JobsPanel:GetWide() - m.JobsPanel.Jobs:GetWide(),40)
		m.JobsPanel.BottomBar:AlignRight()
		m.JobsPanel.BottomBar:AlignBottom()

			m.JobsPanel.BottomBar.SteamIDFinder = vgui.Create("BButton",m.JobsPanel.BottomBar)
			m.JobsPanel.BottomBar.SteamIDFinder:SetSize(135,30)
			m.JobsPanel.BottomBar.SteamIDFinder:SetText(BWhitelist:t("steamid_finder"))
			m.JobsPanel.BottomBar.SteamIDFinder:AlignBottom(5)
			m.JobsPanel.BottomBar.SteamIDFinder:AlignRight(5)
			m.JobsPanel.BottomBar.SteamIDFinder.DoClick = function()
				gui.OpenURL("http://steamid.venner.io/?q=" .. LocalPlayer():SteamID64())
			end
			m.JobsPanel.BottomBar.SteamIDFinder:SetTooltip("steamid.venner.io")

			m.JobsPanel.BottomBar.ProgressBar = vgui.Create("BProgressBar",m.JobsPanel.BottomBar)
			m.JobsPanel.BottomBar.ProgressBar:SetSize(m.JobsPanel.BottomBar:GetWide() - 200,28)
			m.JobsPanel.BottomBar.ProgressBar:AlignLeft(5)
			m.JobsPanel.BottomBar.ProgressBar:AlignBottom(6)

			m.JobsPanel.BottomBar.ProgressPanel = vgui.Create("DPanel",m.JobsPanel.BottomBar)
			m.JobsPanel.BottomBar.ProgressPanel:SetSize(45,28)
			m.JobsPanel.BottomBar.ProgressPanel:AlignLeft(m.JobsPanel.BottomBar:GetWide() - 190)
			m.JobsPanel.BottomBar.ProgressPanel:AlignBottom(6)
			function m.JobsPanel.BottomBar.ProgressPanel:Paint(w,h)
				surface.SetDrawColor(Color(255,255,255))
				surface.DrawRect(0,0,w,h)
			end

				m.JobsPanel.BottomBar.ProgressPanel.Text = vgui.Create("BLabel",m.JobsPanel.BottomBar.ProgressPanel)
				m.JobsPanel.BottomBar.ProgressPanel.Text:Dock(FILL)
				m.JobsPanel.BottomBar.ProgressPanel.Text:SetText("100%")
				m.JobsPanel.BottomBar.ProgressPanel.Text:SetContentAlignment(5)
				function m.JobsPanel.BottomBar.ProgressPanel.Text:Think()
					if (m.JobsPanel.BottomBar.ProgressBar.Max == 0) then
						m.JobsPanel.BottomBar.ProgressPanel.Text:SetText("100%")
					else
						m.JobsPanel.BottomBar.ProgressPanel.Text:SetText(math.Round((m.JobsPanel.BottomBar.ProgressBar.Value / m.JobsPanel.BottomBar.ProgressBar.Max) * 100) .. "%")
					end
				end

			m.JobsPanel.InfoContainer = vgui.Create("DPanel",m.JobsPanel)
			m.JobsPanel.InfoContainer:SetSize(m.JobsPanel:GetWide() - m.JobsPanel.Jobs:GetWide(),m.JobsPanel:GetTall() - m.JobsPanel.BottomBar:GetTall())
			m.JobsPanel.InfoContainer:AlignBottom(m.JobsPanel.BottomBar:GetTall())
			m.JobsPanel.InfoContainer:AlignRight()
			function m.JobsPanel.InfoContainer:Paint() end

				m.JobsPanel.Title = vgui.Create("BLabel",m.JobsPanel.InfoContainer)

				m.JobsPanel.BlacklistText = vgui.Create("BLabel",m.JobsPanel.InfoContainer)
				m.JobsPanel.BlacklistText:SetText("Blacklist?")
				m.JobsPanel.BlacklistText:SizeToContents()
				m.JobsPanel.BlacklistText:AlignRight(10)
				m.JobsPanel.BlacklistText:AlignTop(10)

				m.JobsPanel.IsBlacklist = vgui.Create("DCheckBox",m.JobsPanel.InfoContainer)
				m.JobsPanel.IsBlacklist:AlignRight(10 + 5 + m.JobsPanel.BlacklistText:GetWide())
				m.JobsPanel.IsBlacklist:AlignTop(10)

				m.JobsPanel.SearchList = vgui.Create("BTextBox",m.JobsPanel.InfoContainer)
				m.JobsPanel.SearchList:SetSize(m.JobsPanel.InfoContainer:GetWide() - 119,30)
				m.JobsPanel.SearchList:SetPlaceHolder(BWhitelist:t("search"))
				m.JobsPanel.SearchList:AlignLeft(10)
				m.JobsPanel.SearchList:AlignTop(35)
				m.JobsPanel.SearchListButton = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.SearchListButton:SetSize(100,30)
				m.JobsPanel.SearchListButton:SetText(BWhitelist:t("go"))
				m.JobsPanel.SearchListButton:AlignRight(10)
				m.JobsPanel.SearchListButton:AlignTop(35)
				m.JobsPanel.SearchListButton:SetDisabled(true)
				m.JobsPanel.SearchList.Typed = function(t)
					if (t ~= "") then
						m.JobsPanel.SearchListButton:SetDisabled(false)
					else
						m.JobsPanel.SearchListButton:SetDisabled(true)
					end
				end
				m.JobsPanel.SearchListButton.DoClick = function()
					m.JobsPanel.SteamProfileButton:SetDisabled(true)
					m.JobsPanel.CopyButton:SetDisabled(true)
					m.JobsPanel.RemoveFromWhitelist:SetDisabled(true)
					if (m.JobsPanel.SearchListButton:GetText() == BWhitelist:t("cancel")) then
						m.JobsPanel.SearchListButton:SetText(BWhitelist:t("go"))
						BWhitelist:nets("stop_data_flow")
						net.SendToServer()
						m.JobsPanel.List:Clear()
						BWhitelist:nets("start_data_flow")
							net.WriteString(m.JobsPanel.Title:GetText())
						net.SendToServer()
					else
						m.JobsPanel.SearchListButton:SetText(BWhitelist:t("cancel"))
						BWhitelist:nets("stop_data_flow")
						net.SendToServer()
						m.JobsPanel.List:Clear()
						BWhitelist:nets("search")
							net.WriteString(m.JobsPanel.Title:GetText())
							net.WriteString(m.JobsPanel.SearchList:GetValue())
						net.SendToServer()
					end
				end

				m.JobsPanel.ClearButton = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.ClearButton:SetSize(155,30)
				m.JobsPanel.ClearButton:SetText(BWhitelist:t("clear_whitelist"))
				m.JobsPanel.ClearButton:SetDisabled(true)
				m.JobsPanel.ClearButton:AlignLeft(10)
				m.JobsPanel.ClearButton:AlignTop(75)
				m.JobsPanel.ClearButton:SetTooltip(BWhitelist:t("clear_whitelist_tooltip"))
				m.JobsPanel.ClearButton.DoClick = function()
					BWhitelist:nets("clear_whitelist")
						net.WriteString(m.JobsPanel.Title:GetText())
					net.SendToServer()
					m.JobsPanel.List:Clear()
					m.JobsPanel.List:AddLine(BWhitelist:t("no_data"))
					m.JobsPanel.RemoveFromWhitelist:SetDisabled(true)
					m.JobsPanel.CopyButton:SetDisabled(true)
					m.JobsPanel.SteamProfileButton:SetDisabled(true)
				end

				m.JobsPanel.DisableButton = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.DisableButton:SetSize(155,30)
				m.JobsPanel.DisableButton:SetText(BWhitelist:t("disable_whitelist"))
				m.JobsPanel.DisableButton:SetDisabled(true)
				m.JobsPanel.DisableButton:CenterHorizontal()
				m.JobsPanel.DisableButton:AlignTop(75)
				m.JobsPanel.DisableButton:SetTooltip(BWhitelist:t("disable_whitelist_tooltip"))
				m.JobsPanel.DisableButton.DoClick = function()
					BWhitelist:nets("disable_whitelist")
						net.WriteString(m.JobsPanel.Title:GetText())
					net.SendToServer()
					m.JobsPanel.MouseBlock:AlignRight()
					local x,y = m.JobsPanel.MouseBlock:GetPos()
					m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
					m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("disabled_whitelist"))
					m.JobsPanel.InfoPanel.Text:SizeToContents()
					m.JobsPanel.InfoPanel.Text:Center()
					local x,y = m.JobsPanel.InfoPanel.Text:GetPos()
					m.JobsPanel.InfoPanel.Text:SetPos(x,y - 35)
					m.JobsPanel.InfoPanel.EnableButton:SetVisible(true)
				end

				m.JobsPanel.AddToWhitelist = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.AddToWhitelist:SetSize(155,30)
				m.JobsPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
				m.JobsPanel.AddToWhitelist:SetDisabled(true)
				m.JobsPanel.AddToWhitelist:AlignRight(10)
				m.JobsPanel.AddToWhitelist:AlignTop(75)
				m.JobsPanel.AddToWhitelist:SetTooltip(BWhitelist:t("add_to_whitelist_tooltip"))
				m.JobsPanel.AddToWhitelist.DoClick = function()
					local menu = DermaMenu()
					menu:AddOption(BWhitelist:t("add_usergroup"),function()

						Billy_StringRequest(BWhitelist:t("add_usergroup"),BWhitelist:t("add_usergroup_modal"),"Usergroup",function(usergroup)

							BWhitelist:nets("add_to_whitelist")
								net.WriteBool(true)
								net.WriteString(m.JobsPanel.Title:GetText())
								net.WriteString(usergroup)
							net.SendToServer()

							if (m.JobsPanel.List:GetLine(1):GetValue(1) == BWhitelist:t("no_data")) then
								m.JobsPanel.List:RemoveLine(1)
							end

							m.JobsPanel.List:AddLine("Usergroup",usergroup,"N/A")

						end)

					end):SetIcon("icon16/shield.png")
					menu:AddOption(BWhitelist:t("add_steamid"),function()

						Billy_StringRequest(BWhitelist:t("add_steamid"),BWhitelist:t("add_steamid_modal"),"SteamID",function(steamid)

							if (tonumber(steamid)) then
								steamid = util.SteamIDFrom64(steamid)
							end

							if ((steamid:find("^STEAM_%d:%d:%d-$")) == nil) then
								Billy_Message(BWhitelist:t("not_a_steamid_or_64"),BWhitelist:t("error"))
								return
							end

							BWhitelist:nets("add_to_whitelist")
								net.WriteBool(false)
								net.WriteString(m.JobsPanel.Title:GetText())
								net.WriteString(steamid)
							net.SendToServer()

							if (m.JobsPanel.List:GetLine(1):GetValue(1) == BWhitelist:t("no_data")) then
								m.JobsPanel.List:RemoveLine(1)
							end

							local p = player.GetBySteamID(steamid)
							if (IsValid(p)) then
								m.JobsPanel.List:AddLine("SteamID",steamid,p:Nick())
							else
								m.JobsPanel.List:AddLine("SteamID",steamid,"Unknown")
							end

						end)

					end):SetIcon("icon16/user.png")
					menu:Open()
				end

				m.JobsPanel.List = vgui.Create("BListView",m.JobsPanel.InfoContainer)
				m.JobsPanel.List:SetSize(m.JobsPanel.InfoContainer:GetWide() - 20,m.JobsPanel.InfoContainer:GetTall() - 165)
				m.JobsPanel.List:AlignTop(115)
				m.JobsPanel.List:AlignLeft(10)
				m.JobsPanel.List:AddColumn(BWhitelist:t("type"))
				m.JobsPanel.List:AddColumn(BWhitelist:t("value"))
				m.JobsPanel.List:AddColumn(BWhitelist:t("team_name"))
				m.JobsPanel.List:SetMultiSelect(false)
				m.JobsPanel.List.OnRowSelected = function(e,i,l)
					if (l:GetValue(1) == BWhitelist:t("no_data")) then return end
					m.JobsPanel.RemoveFromWhitelist:SetDisabled(false)
					m.JobsPanel.CopyButton:SetDisabled(false)
					if (l:GetValue(1) == "Usergroup") then
						m.JobsPanel.SteamProfileButton:SetDisabled(true)
					else
						m.JobsPanel.SteamProfileButton:SetDisabled(false)
					end
				end

				m.JobsPanel.RemoveFromWhitelist = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.RemoveFromWhitelist:SetSize(155,30)
				m.JobsPanel.RemoveFromWhitelist:AlignBottom(10)
				m.JobsPanel.RemoveFromWhitelist:AlignLeft(10)
				m.JobsPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
				m.JobsPanel.RemoveFromWhitelist:SetTooltip(BWhitelist:t("remove_from_whitelist_tooltip"))
				m.JobsPanel.RemoveFromWhitelist:SetDisabled(true)
				m.JobsPanel.RemoveFromWhitelist.DoClick = function()
					local l = m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine())
					BWhitelist:nets("remove_from_whitelist")
						net.WriteBool(l:GetValue(1) == "Usergroup")
						net.WriteString(m.JobsPanel.Title:GetText())
						net.WriteString(l:GetValue(2))
					net.SendToServer()
					m.JobsPanel.List:RemoveLine(m.JobsPanel.List:GetSelectedLine())
					if (#m.JobsPanel.List:GetLines() == 0) then
						m.JobsPanel.List:AddLine(BWhitelist:t("no_data"))
					end
					m.JobsPanel.RemoveFromWhitelist:SetDisabled(true)
					m.JobsPanel.CopyButton:SetDisabled(true)
					m.JobsPanel.SteamProfileButton:SetDisabled(true)
				end

				m.JobsPanel.CopyButton = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.CopyButton:SetSize(155,30)
				m.JobsPanel.CopyButton:AlignBottom(10)
				m.JobsPanel.CopyButton:CenterHorizontal()
				m.JobsPanel.CopyButton:SetText(BWhitelist:t("copy"))
				m.JobsPanel.CopyButton:SetTooltip(BWhitelist:t("copy_tooltip"))
				m.JobsPanel.CopyButton:SetDisabled(true)
				m.JobsPanel.CopyButton.DoClick = function()
					if (m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine()):GetValue(1) == "Usergroup") then
						SetClipboardText(m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine()):GetValue(2))
					else
						local menu = DermaMenu()
						menu:AddOption("Copy SteamID",function()
							SetClipboardText(m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine()):GetValue(2))
						end):SetIcon("icon16/user.png")
						menu:AddOption("Copy SteamID64",function()
							SetClipboardText(util.SteamIDTo64(m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine()):GetValue(2)))
						end):SetIcon("icon16/user_red.png")
						menu:Open()
					end
				end

				m.JobsPanel.SteamProfileButton = vgui.Create("BButton",m.JobsPanel.InfoContainer)
				m.JobsPanel.SteamProfileButton:SetSize(155,30)
				m.JobsPanel.SteamProfileButton:AlignBottom(10)
				m.JobsPanel.SteamProfileButton:AlignRight(10)
				m.JobsPanel.SteamProfileButton:SetText(BWhitelist:t("steamprofile"))
				m.JobsPanel.SteamProfileButton:SetDisabled(true)
				m.JobsPanel.SteamProfileButton.DoClick = function()
					gui.OpenURL("https://steamcommunity.com/profiles/" .. util.SteamIDTo64(m.JobsPanel.List:GetLine(m.JobsPanel.List:GetSelectedLine()):GetValue(2)))
				end

				m.JobsPanel.List.Filler = vgui.Create("DPanel",m.JobsPanel.InfoContainer)
				m.JobsPanel.List.Filler:SetSize(1,34)
				m.JobsPanel.List.Filler:AlignRight(11)
				m.JobsPanel.List.Filler:AlignTop(115)
				function m.JobsPanel.List.Filler:Paint(w,h)
					surface.SetDrawColor(Color(242,242,242))
					surface.DrawRect(0,0,w,h)
				end

	m.JobsPanel.MouseBlock = vgui.Create("DPanel",m.JobsPanel)
	m.JobsPanel.MouseBlock:SetSize(m.JobsPanel:GetWide() - m.JobsPanel.Jobs:GetWide(),m.JobsPanel:GetTall())
	m.JobsPanel.MouseBlock:AlignRight()
	m.JobsPanel.MouseBlock:AlignBottom()
	function m.JobsPanel.MouseBlock:Paint() end

	m.JobsPanel.InfoPanel = vgui.Create("BPanel",m.JobsPanel)
	m.JobsPanel.InfoPanel:SetSize(m.JobsPanel:GetWide() - m.JobsPanel.Jobs:GetWide(),m.JobsPanel:GetTall())
	m.JobsPanel.InfoPanel:AlignRight()
	m.JobsPanel.InfoPanel:AlignBottom()

		m.JobsPanel.InfoPanel.Text = vgui.Create("BLabel",m.JobsPanel.InfoPanel)
		m.JobsPanel.InfoPanel.Text:White()
		m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("select_job"))
		m.JobsPanel.InfoPanel.Text:SizeToContents()
		m.JobsPanel.InfoPanel.Text:Center()

		m.JobsPanel.InfoPanel.EnableButton = vgui.Create("BButton",m.JobsPanel.InfoPanel)
		m.JobsPanel.InfoPanel.EnableButton:SetSize(120,30)
		m.JobsPanel.InfoPanel.EnableButton:SetText(BWhitelist:t("enable_whitelist"))
		m.JobsPanel.InfoPanel.EnableButton:Center()
		m.JobsPanel.InfoPanel.EnableButton:SetVisible(false)
		if (BWhitelist.Config.MaxPermittedDisableWhitelists == true) then
			if (not admin_mode) then
				m.JobsPanel.InfoPanel.EnableButton:SetDisabled(true)
				m.JobsPanel.InfoPanel.EnableButton:SetTooltip(BWhitelist:t("permission_failure"))
			end
		end
		m.JobsPanel.InfoPanel.EnableButton.DoClick = function()
			m.JobsPanel.InfoPanel.EnableButton:SetVisible(false)
			m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("enabling_whitelist"))
			m.JobsPanel.InfoPanel.Text:SizeToContents()
			m.JobsPanel.InfoPanel.Text:Center()
			BWhitelist:nets("enable_whitelist")
				net.WriteString(m.JobsPanel.Title:GetText())
			net.SendToServer()
		end

	m.PlayersPanel = vgui.Create("BTabs_Panel",m)
	m.PlayersPanel:SetTabs(m.Tabs)
	m.PlayersPanel:SetSize(m:GetWide(),m:GetTall() - 24 - m.Tabs:GetTall())

		m.PlayersPanel.List = vgui.Create("BListView",m.PlayersPanel)
		m.PlayersPanel.List:SetSize(m.PlayersPanel:GetWide(),m.PlayersPanel:GetTall() - 40)
		m.PlayersPanel.List:AddColumn(BWhitelist:t("player_name"))
		m.PlayersPanel.List:AddColumn("SteamID")
		m.PlayersPanel.List:AddColumn("Usergroup")
		m.PlayersPanel.List:SetMultiSelect(false)
		local function update_players()
			if (not IsValid(BWhitelist.Menu)) then
				BWhitelist:untimer("update_players")
				return
			end
			for i,v in pairs(BWhitelist.Menu.PlayersPanel.List:GetLines()) do
				if (not table.HasValue(player.GetHumans(),v.PlayerObject)) then
					BWhitelist.Menu.PlayersPanel.List:RemoveLine(i)
				end
			end
			for _,v in pairs(player.GetHumans()) do
				local found = false
				for _,l in pairs(BWhitelist.Menu.PlayersPanel.List:GetLines()) do
					if (l:GetValue(2) == v:SteamID()) then
						found = true
						break
					end
				end
				if (not found) then
					BWhitelist.Menu.PlayersPanel.List:AddLine(v:Nick(),v:SteamID(),v:GetUserGroup()).PlayerObject = v
				end
			end
		end
		update_players()
		BWhitelist:untimer("update_players")
		BWhitelist:timer("update_players",5,0,update_players)
		m.PlayersPanel.List.OnRowSelected = function(e,i,l)
			m.PlayersPanel.AddToWhitelist:SetDisabled(false)
			m.PlayersPanel.RemoveFromWhitelist:SetDisabled(false)
			m.PlayersPanel.SteamProfileButton:SetDisabled(false)
		end

		m.PlayersPanel.AddToWhitelist = vgui.Create("BButton",m.PlayersPanel)
		m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
		m.PlayersPanel.AddToWhitelist:SetDisabled(true)
		m.PlayersPanel.AddToWhitelist:SetSize(225,30)
		m.PlayersPanel.AddToWhitelist:AlignBottom(5)
		m.PlayersPanel.AddToWhitelist:AlignLeft(5)
		m.PlayersPanel.AddToWhitelist:SetTooltip(BWhitelist:t("add_to_whitelist_selected_tooltip"))
		m.PlayersPanel.AddToWhitelist.DoClick = function()
			m.PlayersPanel.AddToWhitelist:SetDisabled(true)
			m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("retrieving"))
			local enabled_whitelists = {}
			m.NetReceiver["get_enabled_whitelist"] = function()
				local team_name = net.ReadString()
				table.insert(enabled_whitelists,team_name)
			end
			m.NetReceiver["get_last_enabled_whitelist"] = function()
				local team_name = net.ReadString()
				table.insert(enabled_whitelists,team_name)
				local menu
				local a = 0
				table.sort(enabled_whitelists)
				for _,v in pairs(enabled_whitelists) do
					if (BWhitelist:HasAccess(LocalPlayer(),v)) then
						a = a + 1
						if (not menu) then
							menu = DermaMenu()
							menu:AddOption(BWhitelist:t("add_to_all_whitelists"),function()

								BWhitelist:nets("add_to_all_whitelists")
									net.WriteString(m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2))
								net.SendToServer()

							end):SetIcon("icon16/add.png")
							menu:AddSpacer()
						end
						menu:AddOption(v,function()

							if (m.PlayersPanel.List:GetSelectedLine() == nil) then
								Billy_Message(BWhitelist:t("player_left"),BWhitelist:t("error"))
								m.PlayersPanel.AddToWhitelist:SetDisabled(false)
								m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
								return
							end

							BWhitelist:nets("add_to_whitelist")
								net.WriteBool(false)
								net.WriteString(v)
								net.WriteString(m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2))
							net.SendToServer()

							if (m.JobsPanel.Title:GetText() == v) then
								if (m.JobsPanel.List:GetLine(1):GetValue(1) == BWhitelist:t("no_data")) then
									m.JobsPanel.List:RemoveLine(1)
								end
								m.JobsPanel.List:AddLine("SteamID",m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2),m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(1))
							end

						end):SetIcon("icon16/user_gray.png")
					end
				end
				if (a == 0) then
					Billy_Message(BWhitelist:t("player_left"),BWhitelist:t("error"))
				else
					menu:Open()
				end
				m.PlayersPanel.AddToWhitelist:SetDisabled(false)
				m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
			end
			m.NetReceiver["no_enabled_whitelists"] = function()
				Billy_Message(BWhitelist:t("no_enabled_whitelists"),BWhitelist:t("error"))
				m.PlayersPanel.AddToWhitelist:SetDisabled(false)
				m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
				m.PlayersPanel.RemoveFromWhitelist:SetDisabled(false)
				m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
			end
			BWhitelist:nets("get_all_enabled_whitelists")
			net.SendToServer()
		end

		m.PlayersPanel.SteamProfileButton = vgui.Create("BButton",m.PlayersPanel)
		m.PlayersPanel.SteamProfileButton:SetText(BWhitelist:t("steamprofile"))
		m.PlayersPanel.SteamProfileButton:SetDisabled(true)
		m.PlayersPanel.SteamProfileButton:SetSize(225,30)
		m.PlayersPanel.SteamProfileButton:AlignBottom(5)
		m.PlayersPanel.SteamProfileButton:AlignRight(5)
		m.PlayersPanel.SteamProfileButton.DoClick = function()
			gui.OpenURL("http://steamcommunity.com/profiles/" .. util.SteamIDTo64(m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2)))
		end

		m.PlayersPanel.RemoveFromWhitelist = vgui.Create("BButton",m.PlayersPanel)
		m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
		m.PlayersPanel.RemoveFromWhitelist:SetDisabled(true)
		m.PlayersPanel.RemoveFromWhitelist:SetSize(225,30)
		m.PlayersPanel.RemoveFromWhitelist:AlignBottom(5)
		m.PlayersPanel.RemoveFromWhitelist:CenterHorizontal()
		m.PlayersPanel.RemoveFromWhitelist:SetTooltip(BWhitelist:t("remove_from_whitelist_selected_tooltip"))
		m.PlayersPanel.RemoveFromWhitelist.DoClick = function()
			m.PlayersPanel.RemoveFromWhitelist:SetDisabled(true)
			m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("retrieving"))
			local enabled_whitelists = {}
			m.NetReceiver["get_enabled_whitelist"] = function()
				local team_name = net.ReadString()
				table.insert(enabled_whitelists,team_name)
			end
			m.NetReceiver["get_last_enabled_whitelist"] = function()
				local team_name = net.ReadString()
				table.insert(enabled_whitelists,team_name)
				local menu
				local a = 0
				table.sort(enabled_whitelists)
				for _,v in pairs(enabled_whitelists) do
					if (BWhitelist:HasAccess(LocalPlayer(),v)) then
						a = a + 1
						if (not menu) then
							menu = DermaMenu()
							menu:AddOption(BWhitelist:t("remove_from_all_whitelists"),function()

								BWhitelist:nets("remove_from_all_whitelists")
									net.WriteString(m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2))
								net.SendToServer()

							end):SetIcon("icon16/delete.png")
							menu:AddSpacer()
						end
						menu:AddOption(v,function()

							if (m.PlayersPanel.List:GetSelectedLine() == nil) then
								Billy_Message(BWhitelist:t("player_left"),BWhitelist:t("error"))
								m.PlayersPanel.RemoveFromWhitelist:SetDisabled(false)
								m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
								return
							end

							local sec = m.PlayersPanel.List:GetLine(m.PlayersPanel.List:GetSelectedLine()):GetValue(2)

							BWhitelist:nets("remove_from_whitelist")
								net.WriteBool(false)
								net.WriteString(v)
								net.WriteString(sec)
							net.SendToServer()

							if (m.JobsPanel.Title:GetText() == v) then
								if (#m.JobsPanel.List:GetLines() == 1) then
									m.JobsPanel.List:RemoveLine(1)
								end
								for iv,ls in pairs(m.JobsPanel.List:GetLines()) do
									if (ls:GetValue(1) == "SteamID" and ls:GetValue(2) == sec) then
										m.JobsPanel.List:RemoveLine(iv)
									end
								end
								if (#m.JobsPanel.List:GetLines() == 0) then
									m.JobsPanel.List:AddLine("No data!")
								end
							end

						end):SetIcon("icon16/user_gray.png")
					end
				end
				if (a == 0) then
					Billy_Message(BWhitelist:t("player_left"),BWhitelist:t("error"))
				else
					menu:Open()
				end
				m.PlayersPanel.RemoveFromWhitelist:SetDisabled(false)
				m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
			end
			m.NetReceiver["no_enabled_whitelists"] = function()
				Billy_Message(BWhitelist:t("no_enabled_whitelists"),BWhitelist:t("error"))
				m.PlayersPanel.AddToWhitelist:SetDisabled(false)
				m.PlayersPanel.AddToWhitelist:SetText(BWhitelist:t("add_to_whitelist"))
				m.PlayersPanel.RemoveFromWhitelist:SetDisabled(false)
				m.PlayersPanel.RemoveFromWhitelist:SetText(BWhitelist:t("remove_from_whitelist"))
			end
			BWhitelist:nets("get_all_enabled_whitelists")
			net.SendToServer()
		end

	m.AdminPanel = vgui.Create("BTabs_Panel",m)
	m.AdminPanel:SetTabs(m.Tabs)
	m.AdminPanel:SetSize(m:GetWide(),m:GetTall() - 24 - m.Tabs:GetTall())

		m.AdminPanel.ImportFromNordahl = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ImportFromNordahl:SetText(BWhitelist:t("import_from_nordahl"))
		m.AdminPanel.ImportFromNordahl:SetSize(300,30)
		m.AdminPanel.ImportFromNordahl:AlignTop(10)
		m.AdminPanel.ImportFromNordahl:AlignLeft(10)
		m.AdminPanel.ImportFromNordahl:SetTooltip(BWhitelist:t("import_from_nordahl_tooltip"))
		m.AdminPanel.ImportFromNordahl.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.AdminPanel.ImportFromNordahl:SetDisabled(true)
				BWhitelist:nets("import_from_nordahl")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["import_from_nordahl"] = function()
			m.AdminPanel.ImportFromNordahl:SetDisabled(false)
		end
		m.AdminPanel.ViewNordahl = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ViewNordahl:SetText(BWhitelist:t("view"))
		m.AdminPanel.ViewNordahl:SetSize(100,30)
		m.AdminPanel.ViewNordahl:AlignTop(10)
		m.AdminPanel.ViewNordahl:AlignLeft(320)
		m.AdminPanel.ViewNordahl.DoClick = function()
			gui.OpenURL("https://scriptfodder.com/scripts/view/1402")
		end

		m.AdminPanel.ImportFromMayoz = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ImportFromMayoz:SetText(BWhitelist:t("import_from_mayoz"))
		m.AdminPanel.ImportFromMayoz:SetSize(300,30)
		m.AdminPanel.ImportFromMayoz:AlignTop(50)
		m.AdminPanel.ImportFromMayoz:AlignLeft(10)
		m.AdminPanel.ImportFromMayoz:SetTooltip(BWhitelist:t("import_from_mayoz_tooltip"))
		m.AdminPanel.ImportFromMayoz.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.AdminPanel.ImportFromMayoz:SetDisabled(true)
				BWhitelist:nets("import_from_mayoz")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["import_from_mayoz"] = function()
			m.AdminPanel.ImportFromMayoz:SetDisabled(false)
		end
		m.AdminPanel.ViewMayoz = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ViewMayoz:SetText(BWhitelist:t("view"))
		m.AdminPanel.ViewMayoz:SetSize(100,30)
		m.AdminPanel.ViewMayoz:AlignTop(50)
		m.AdminPanel.ViewMayoz:AlignLeft(320)
		m.AdminPanel.ViewMayoz.DoClick = function()
			gui.OpenURL("https://scriptfodder.com/scripts/view/2348")
		end

		m.AdminPanel.ImportFromOldBWhitelist = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ImportFromOldBWhitelist:SetText(BWhitelist:t("import_from_old_bwhitelist"))
		m.AdminPanel.ImportFromOldBWhitelist:SetSize(300,30)
		m.AdminPanel.ImportFromOldBWhitelist:AlignTop(90)
		m.AdminPanel.ImportFromOldBWhitelist:AlignLeft(10)
		m.AdminPanel.ImportFromOldBWhitelist:SetTooltip(BWhitelist:t("import_from_old_bwhitelist_tooltip"))
		m.AdminPanel.ImportFromOldBWhitelist.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.AdminPanel.ImportFromOldBWhitelist:SetDisabled(true)
				BWhitelist:nets("import_from_old_bwhitelist")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["import_from_old_bwhitelist"] = function()
			m.AdminPanel.ImportFromOldBWhitelist:SetDisabled(false)
		end

		m.AdminPanel.EnableAllWhitelists = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.EnableAllWhitelists:SetText(BWhitelist:t("enable_all_whitelists"))
		m.AdminPanel.EnableAllWhitelists:SetSize(300,30)
		m.AdminPanel.EnableAllWhitelists:AlignTop(130)
		m.AdminPanel.EnableAllWhitelists:AlignLeft(10)
		m.AdminPanel.EnableAllWhitelists:SetTooltip(BWhitelist:t("enable_all_whitelists"))
		m.AdminPanel.EnableAllWhitelists.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.AdminPanel.EnableAllWhitelists:SetDisabled(true)
				BWhitelist:nets("enable_all_whitelists")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["enable_all_whitelists"] = function()
			m.AdminPanel.EnableAllWhitelists:SetDisabled(false)
		end

		m.AdminPanel.DisableAllWhitelists = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.DisableAllWhitelists:SetText(BWhitelist:t("disable_all_whitelists"))
		m.AdminPanel.DisableAllWhitelists:SetSize(300,30)
		m.AdminPanel.DisableAllWhitelists:AlignTop(170)
		m.AdminPanel.DisableAllWhitelists:AlignLeft(10)
		m.AdminPanel.DisableAllWhitelists:SetTooltip(BWhitelist:t("disable_all_whitelists"))
		m.AdminPanel.DisableAllWhitelists.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.AdminPanel.DisableAllWhitelists:SetDisabled(true)
				BWhitelist:nets("disable_all_whitelists")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["disable_all_whitelists"] = function()
			m.AdminPanel.DisableAllWhitelists:SetDisabled(false)
		end

		m.AdminPanel.ResetEverything = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ResetEverything:SetText(BWhitelist:t("reset_everything"))
		m.AdminPanel.ResetEverything:SetSize(300,30)
		m.AdminPanel.ResetEverything:AlignBottom(10)
		m.AdminPanel.ResetEverything:AlignLeft(10)
		m.AdminPanel.ResetEverything:SetTooltip(BWhitelist:t("reset_everything_tooltip"))
		m.AdminPanel.ResetEverything.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.JobsPanel.MouseBlock:AlignRight()
				local x,y = m.JobsPanel.MouseBlock:GetPos()
				m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
				m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("disabled_whitelist"))
				m.JobsPanel.InfoPanel.Text:SizeToContents()
				m.JobsPanel.InfoPanel.Text:Center()
				local x,y = m.JobsPanel.InfoPanel.Text:GetPos()
				m.JobsPanel.InfoPanel.Text:SetPos(x,y - 35)
				m.JobsPanel.InfoPanel.EnableButton:SetVisible(true)

				m.AdminPanel.ResetEverything:SetDisabled(true)
				BWhitelist:nets("reset_everything")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["reset_everything"] = function()
			m.AdminPanel.ResetEverything:SetDisabled(false)
		end

		m.AdminPanel.ClearUnknownJobs = vgui.Create("BButton",m.AdminPanel)
		m.AdminPanel.ClearUnknownJobs:SetText(BWhitelist:t("clear_unknown_jobs"))
		m.AdminPanel.ClearUnknownJobs:SetSize(300,30)
		m.AdminPanel.ClearUnknownJobs:AlignBottom(50)
		m.AdminPanel.ClearUnknownJobs:AlignLeft(10)
		m.AdminPanel.ClearUnknownJobs:SetTooltip(BWhitelist:t("clear_unknown_jobs_tooltip"))
		m.AdminPanel.ClearUnknownJobs.DoClick = function()
			Billy_Query(BWhitelist:t("are_you_sure"),BWhitelist:t("confirm"),BWhitelist:t("yes"),function()

				m.JobsPanel.MouseBlock:AlignRight()
				local x,y = m.JobsPanel.MouseBlock:GetPos()
				m.JobsPanel.InfoPanel:MoveTo(x,y,0.5)
				m.JobsPanel.InfoPanel.Text:SetText(BWhitelist:t("disabled_whitelist"))
				m.JobsPanel.InfoPanel.Text:SizeToContents()
				m.JobsPanel.InfoPanel.Text:Center()
				local x,y = m.JobsPanel.InfoPanel.Text:GetPos()
				m.JobsPanel.InfoPanel.Text:SetPos(x,y - 35)
				m.JobsPanel.InfoPanel.EnableButton:SetVisible(true)

				m.AdminPanel.ClearUnknownJobs:SetDisabled(true)
				BWhitelist:nets("clear_unknown_jobs")
				net.SendToServer()

			end,BWhitelist:t("cancel"))
		end
		m.NetReceiver["clear_unknown_jobs"] = function()
			m.AdminPanel.ClearUnknownJobs:SetDisabled(false)
		end

	m.Tabs:AddTab(BWhitelist:t("jobs_tab"),m.JobsPanel)
	m.Tabs:AddTab(BWhitelist:t("players_tab"),m.PlayersPanel)

	if (admin_mode) then
		m.Tabs:AddTab(BWhitelist:t("admin_tab"),m.AdminPanel)
	else
		m.AdminPanel:Remove()
	end

end
BWhitelist:netr("openmenu",openmenu)

BWhitelist:netr("get_blacklisted",function()
	local blacklisted = net.ReadBool()
	local name = net.ReadString()
	if (name == BWhitelist.Menu.JobsPanel.Title:GetText()) then
		BWhitelist.Menu.JobsPanel.IsBlacklist:SetChecked(blacklisted)
	end
end)

if (BWhitelist.Config.AllowConsoleCommand) then
	concommand.Add("bwhitelist",function()
		BWhitelist:nets("openmenu")
		net.SendToServer()
	end)
end

BWhitelist:print("Clientside loaded","good")

local data_flow_i = 0
BWhitelist:netr("first_data_flow",function()
	local c1 = net.ReadString()
	local c2 = net.ReadString()
	local c3 = net.ReadString()
	local max = net.ReadDouble()
	data_flow_i = 1
	if (not IsValid(BWhitelist.Menu)) then
		BWhitelist:nets("stop_data_flow")
		net.SendToServer()
		return
	end
	BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Value = BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Value + 1
	BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Max = max
	BWhitelist.Menu.JobsPanel.List:Clear()
	BWhitelist.Menu.JobsPanel.List:AddLine(c1,c2,c3)
end)
BWhitelist:netr("data_flow",function()
	local c1 = net.ReadString()
	local c2 = net.ReadString()
	local c3 = net.ReadString()
	data_flow_i = data_flow_i + 1
	if (not IsValid(BWhitelist.Menu)) then
		BWhitelist:nets("stop_data_flow")
		net.SendToServer()
		return
	end
	if (data_flow_i == 500) then
		BWhitelist:nets("stop_data_flow")
		net.SendToServer()
	end
	BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Value = BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Value + 1
	BWhitelist.Menu.JobsPanel.List:AddLine(c1,c2,c3)
end)
BWhitelist:netr("no_data",function()
	BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Value = 0
	BWhitelist.Menu.JobsPanel.BottomBar.ProgressBar.Max = 0
	BWhitelist.Menu.JobsPanel.List:Clear()
	BWhitelist.Menu.JobsPanel.List:AddLine(BWhitelist:t("no_data"))
end)

properties.Add("whitelistingmenu",{
	Order = 0,
	MenuLabel = "BWhitelist",
	MenuIcon = "icon16/shield.png",
	Filter = function(self,ent,ply)
		if (not IsValid(ent)) then return false end
		if (not ent:IsPlayer()) then return false end
		if (ent:IsBot()) then return false end
		BWhitelist.MousePos = {gui.MousePos()}
		return true
	end,
	Action = function(_,ply)
		timer.Simple(0.1,function()
			local menu = DermaMenu()
			menu:AddOption("Loading...",function() end)
			menu:Open()
			gui.SetMousePos(unpack(BWhitelist.MousePos))

			BWhitelist:nets("open_context_menu")
				net.WriteEntity(ply)
			net.SendToServer()
		end)
	end,
})

BWhitelist:netr("open_context_menu",function()
	local datn = net.ReadDouble()
	local data = util.JSONToTable(util.Decompress(net.ReadData(datn)))
	local ply = net.ReadEntity()
	if (not IsValid(ply)) then BWhitelist:chatprint(BWhitelist:t("player_left"),"bad") return end

	local menu = DermaMenu()
	menu:AddOption("BWhitelist"):SetIcon("icon16/shield.png")
	menu:AddSpacer()

	table.sort(data.whitelisted_to)
	table.sort(data.whitelist_to)

	local remove_from_whitelist
	for _,v in pairs(data.whitelisted_to) do
		if (BWhitelist:HasAccess(LocalPlayer(),v)) then
			if (not remove_from_whitelist) then
				remove_from_whitelist = menu:AddSubMenu(BWhitelist:t("remove_from_whitelist"))
			end
			remove_from_whitelist:AddOption(v,function()
				BWhitelist:nets("remove_from_whitelist")
					net.WriteBool(false)
					net.WriteString(v)
					net.WriteString(ply:SteamID())
				net.SendToServer()
			end)
		end
	end

	local add_to_whitelist
	for _,v in pairs(data.whitelist_to) do
		if (BWhitelist:HasAccess(LocalPlayer(),v)) then
			if (not add_to_whitelist) then
				add_to_whitelist = menu:AddSubMenu(BWhitelist:t("add_to_whitelist"))
			end
			add_to_whitelist:AddOption(v,function()
				BWhitelist:nets("add_to_whitelist")
					net.WriteBool(false)
					net.WriteString(v)
					net.WriteString(ply:SteamID())
				net.SendToServer()
			end)
		end
	end

	menu:AddSpacer()

	menu:AddOption(BWhitelist:t("add_to_all_whitelists"),function()

		BWhitelist:nets("add_to_all_whitelists")
			net.WriteString(ply:SteamID())
		net.SendToServer()

	end):SetIcon("icon16/add.png")
	menu:AddOption(BWhitelist:t("remove_from_all_whitelists"),function()

		BWhitelist:nets("remove_from_all_whitelists")
			net.WriteString(ply:SteamID())
		net.SendToServer()

	end):SetIcon("icon16/delete.png")

	if (not remove_from_whitelist and not add_to_whitelist) then
		menu:AddOption(BWhitelist:t("no_actions_available")):SetIcon("icon16/emoticon_unhappy.png")
	end

	menu:Open()
	gui.SetMousePos(unpack(BWhitelist.MousePos))

end)
