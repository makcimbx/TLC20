util.AddNetworkString("firsttimert")
util.AddNetworkString("questions")
util.AddNetworkString("checkanswers")
util.AddNetworkString("rtresults")
util.AddNetworkString("addquestions")
util.AddNetworkString("addquestion")
util.AddNetworkString("adminselectquestion")
util.AddNetworkString("editquestionmenu")
util.AddNetworkString("editquestion")
util.AddNetworkString("addnagrada")


hook.Add("Initialize", "firsttimeconnect", function()
	--if !sql.TableExists( "rt_questions" ) then
	--	sql.Query("CREATE TABLE `rt_questions` ( `id` INTEGER PRIMARY KEY AUTOINCREMENT, `question` TEXT, `answers` TEXT, `rightanswer` TEXT)")
	--end
	if !sql.TableExists("rt_players") then
		sql.Query("CREATE TABLE `rt_players` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `steamid` TEXT, `name` TEXT, `pass` BOOLEAN)")
	end
end)
--[[
hook.Add("PlayerInitialSpawn", "rt", function( pl )
	local wehavequestions = sql.Query("SELECT * FROM `rt_questions`")
	if wehavequestions != nil then
		local findPlayer = sql.Query("SELECT * FROM `rt_players` WHERE `steamid` = '" .. pl:SteamID() .. "'")
		if findPlayer == nil then net.Start("firsttimert") net.Send( pl ) end
		pl.Attempts = rtConfig.Attempts
	end
end)

hook.Add("PlayerSay", "chatcommand", function( pl, text )
	if string.lower(text) ==  "!rtadd" then
		pl:ConCommand("rtadd")
	end
	if string.lower(text) == "!rtedit" then
		pl:ConCommand("rtedit")
	end
end)]]--

net.Receive("checkanswers", function(l, pl)
	local answers = net.ReadTable()
	local howmany = #answers
	local good = 0
	for k,v in pairs(answers) do
		if tostring(rtLang.Questions[k]["rightanswer"]) == tostring(answers[k]) then 
			good = good +1
		end
	end
	
	pl.trainXp = good*rtConfig.XPmultip*100/howmany
	
	pl.allgood = false
	
	if((good/howmany)*100>=rtConfig.Percent)then
		pl.allgood = true
	end
	
	if pl.allgood then
		sql.Query("INSERT INTO `rt_players` (`steamid`, `name`, `pass`) VALUES ('" .. pl:SteamID() .. "', '" .. pl:Nick() .. "', 'true')")
		net.Start("rtresults")
			net.WriteBool( true )
		net.Send( pl )
	else
		pl.Attempts = pl.Attempts - 1
		if pl.Attempts == 0 then
			if !rtConfig.banPlayer then
				pl:Kick( rtLang.noAttemptsKick )
			else
				pl:Ban( rtConfig.banTime, true )
			end
		else
			net.Start("rtresults")
				net.WriteBool( false )
				net.WriteString( pl.Attempts )
			net.Send( pl )
		end
	end
end)

net.Receive("addnagrada",function(l,pl)
	if(pl.allgood == true)then
		local id = tonumber(net.ReadString())
		pl:changeTeam(DarkRP.getJobByCommand([rtLang.Legions[id].cmd]).team,true,true)
		RunConsoleCommand( "bwhitelist_add_to_whitelist_steamid", pl:SteamID(), rtLang.Legions[id].prof )
		pl:addXP(pl.trainXp, true)
		if(IsValid(pl.sempai))then
			pl.sempai:addXP(10000, true)
		end
		pl.trainXp = nil
		pl:SetNWEntity( "sempai",NULL )
		pl.train_wait = nil
		pl:SetNWBool( "train_wait",false )
		pl:SetPData("tutor_ever","1")
	end
end)

--[[net.Receive("addquestion", function(l, pl)
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		local data = net.ReadTable()
		sql.Query("INSERT INTO `rt_questions` (`question`, `answers`, `rightanswer`) VALUES ('" .. data[1] .. "', '" .. data[2] .. "', '" .. data[3] .. "')")
		pl:SendLua("notification.AddLegacy( 'The question has been added.', NOTIFY_HINT, 10 ) LocalPlayer():ChatPrint('The question has been added.')")
	end
end)

net.Receive("editquestion", function(l, pl)
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		local data = net.ReadTable()
		sql.Query("UPDATE`rt_questions` SET `question` = '" .. data[1] .. "', `answers` = '" .. data[2] .. "', `rightanswer` = '" .. data[3] .. "' WHERE `id` = '" .. data[4] .. "'")
		pl:SendLua("notification.AddLegacy( 'The question been edited.', NOTIFY_HINT, 10 ) LocalPlayer():ChatPrint('The question been edited.')")
	end
end)

function rt_add( pl, cmd, arg )
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		net.Start("addquestions")
		net.Send( pl )
	else
		pl:ChatPrint("[RT] Admins ONLY!")	
	end
end
concommand.Add("rtadd", rt_add)

function rt_edit( pl, cmd, arg )
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		local questions = sql.Query("SELECT `id`,`question` FROM `rt_questions`")
		net.Start("adminselectquestion")
			net.WriteTable(questions)
		net.Send( pl )
	else
		pl:ChatPrint("[RT] Admins ONLY!")	
	end
end
concommand.Add("rtedit", rt_edit)]]--

net.Receive("StartTest",function(l,ply)
	--local questions = sql.Query("SELECT `question`, `answers` FROM `rt_questions`")
	rt_startq(ply)
end)

function rt_startq(pl)
	net.Start("questions")
	net.Send( pl )
end

function question_request(pl, cmd, args)
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		local question = sql.Query("SELECT * FROM `rt_questions` WHERE `id` = '".. args[1] .."'")
		net.Start("editquestionmenu")
			net.WriteTable(question)
		net.Send( pl )
	end
end
--concommand.Add("question_request", question_request)

--[[function question_delete(pl, cmd, args)
	if pl:IsAdmin() or pl:IsSuperAdmin() or pl:IsUserGroup("admin") or pl:IsUserGroup("superadmin") or pl:IsUserGroup("owner") then
		local question = sql.Query("DELETE FROM `rt_questions` WHERE `id` = '".. args[1] .."'")
		pl:SendLua("notification.AddLegacy( 'The question has been deleted.', NOTIFY_HINT, 10 ) LocalPlayer():ChatPrint('The question has been deleted.')")
	end
end
concommand.Add("question_delete", question_delete)]]--

function rt_cancel(pl, cmd, args)
	local a = args[1] or "close"
	if(args[1]=="restart")then
		pl:SendLua("GlideStart()")
	else
		if(args[1]=="exit")then
			pl:ConCommand( "disconnect" )
		else	
			pl:ConCommand( "close" )
		end
	end
end
concommand.Add("rt_cancel", rt_cancel)

