MsgC("\n\n")
for i,v in pairs(string.ToTable(string.rep("#",59))) do
	MsgC(Color(i * 4.32203389831,255,0),v)
end
MsgC("\n\n")
for i,v in pairs({"  ______          ___     _ _       _ _     _   "," |  _ \\ \\        / / |   (_) |     | (_)   | |  "," | |_) \\ \\  /\\  / /| |__  _| |_ ___| |_ ___| |_ "," |  _ < \\ \\/  \\/ / | '_ \\| | __/ _ \\ | / __| __|"," | |_) | \\  /\\  /  | | | | | ||  __/ | \\__ \\ |_ "," |____/   \\/  \\/   |_| |_|_|\\__\\___|_|_|___/\\__|","                                                ","                                                "}) do
	MsgC(string.rep(" ",5))
	for i,_v in pairs(string.ToTable(v)) do
		MsgC(Color(i * 8.5,255,0),_v)
	end
	MsgC("\n")
end
MsgC("\n" .. string.rep(" ",13))
local spaces = ""
for i=1,math.floor(15 - (#BWhitelist.Version / 2)),1 do
	spaces = spaces .. " "
end
for i,v in pairs(string.ToTable(spaces .. BWhitelist.Version)) do
	MsgC(Color(i * 8.5,255,0),v)
end
MsgC("\n\n" .. string.rep(" ",13))
local spaces = ""
for i=1,math.floor(15 - (#("Licensed to " .. BWhitelist.Licensee) / 2)),1 do
	spaces = spaces .. " "
end
for i,v in pairs(string.ToTable(spaces .. "Licensed to " .. BWhitelist.Licensee)) do
	MsgC(Color(i * 8.5,255,0),v)
end
MsgC("\n\n\n")
for i,v in pairs(string.ToTable(string.rep("#",59))) do
	MsgC(Color(i * 4.32203389831,255,0),v)
end
MsgC("\n\n")

BWhitelist.EnglishLanguage = {
	permission_failure = "You don't currently have permission to do this.",
	disabled_whitelist = "The whitelist for this job is disabled.",
	no_whitelist_permission = "You don't have permission to edit this whitelist.",
	search_jobs = "Search jobs...",
	steamid_finder = "SteamID Finder",
	type = "Type",
	value = "Value",
	team_name = "Name",
	select_job = "Select a job on the left...",
	enable_whitelist = "Enable Whitelist?",
	enabling_whitelist = "Enabling Whitelist...",
	add_to_whitelist = "Add to Whitelist",
	disable_whitelist = "Disable Whitelist",
	clear_whitelist = "Clear Whitelist",
	search = "Search...",
	no_data = "No data!",
	retrieving = "Retrieving...",
	admin_mode = "Admin Mode",
	admin_tab = "Admin",
	jobs_tab = "Jobs",
	players_tab = "Players",
	default_team = "This is the default team. You cannot whitelist the default team.",
	remove_from_whitelist = "Remove from Whitelist",
	player_name = "Name",
	remove_from_whitelist_selected_tooltip = "Remove the selected user from a whitelist",
	add_to_whitelist_selected_tooltip = "Add the selected user to a whitelist",
	clear_whitelist_tooltip = "[Admin only] Clears the whitelist. All SteamIDs and usergroups are removed.",
	disable_whitelist_tooltip = "Disables the whitelist. Players can join the job freely.",
	add_to_whitelist_tooltip = "Adds a SteamID, SteamID64 or usergroup to the whitelist for this job.",
	remove_from_whitelist_tooltip = "Removes the selected SteamID, SteamID64 or usergroup from the whitelist for this job.",
	in_jobs_file_tooltip = "You can't disable this whitelist because it is BWhitelist enabled in your DarkRP jobs file.",
	add_steamid = "Add SteamID/64",
	add_usergroup = "Add Usergroup",
	add_usergroup_modal = "Type the usergroup you want to add below.",
	add_steamid_modal = "Paste the SteamID/SteamID64 you want to add below.\nPlease remember that there is an easier way to do this, go to the \"Player\" tab in the menu!",
	error = "Error",
	not_a_steamid_or_64 = "That's not a SteamID or SteamID64!",
	already_exists = "That already exists in the whitelist!",
	doesnt_exist = "That doesn't exist in the whitelist!",
	copy = "Copy",
	copy_tooltip = "Copies the selected usergroup or SteamID.",
	player_left = "Sorry, it looks like that player's left the server.",
	no_enabled_whitelists = "There's no enabled whitelists that you have access to!",
	import_from_mayoz = "Import from Mayoz's Whitelisting System",
	import_from_nordahl = "Import from Nordahl's Whitelisting System",
	import_from_old_bwhitelist = "Import from old BWhitelist",
	view = "View",
	no_import = "It looks like we couldn't find the files/the files are corrupted that are required to import.",
	import_from_old_bwhitelist_tooltip = "If we can find any of the old BWhitelist files on your server, we'll convert them into the new files.",
	import_from_mayoz_tooltip = "If we can find any of Mayoz's Whitelisting System's files on your server, we'll convert them into BWhitelist files.",
	import_from_nordahl_tooltip = "If we can find any of Nordahl's Whitelisting System's files on your server, we'll convert them into BWhitelist files.",
	disable_all_whitelists = "All jobs will have their whitelists disabled. All data will stay.",
	enable_all_whitelists = "All jobs will have their whitelists enabled.",
	steamprofile = "Steam Profile",
	confirm = "Confirm",
	are_you_sure = "Are you sure you want to do this?",
	yes = "Yes",
	cancel = "Cancel",
	reset_everything = "Reset everything",
	reset_everything_tooltip = "WARNING: This will delete ALL whitelist data and enabled whitelists.",
	go = "Go",
	customcheck_team = "This team has a customCheck on it. This overrides BWhitelist.\n\nPlease change \"customCheck\" to \"BWhitelist_customCheck\"\nin your jobs file for your customCheck to work with BWhitelist.",
	removed_from_whitelist = "You were removed from the whitelist for \"%s\"",
	added_to_whitelist = "You were added to the whitelist for \"%s\"",
	disable_all_whitelists = "Disable all whitelists",
	enable_all_whitelists = "Enable all whitelists",
	player_left = "The player has left.",
	no_actions_available = "No actions available for this player.",
	remove_from_all_whitelists = "Remove from all whitelists",
	add_to_all_whitelists = "Add to all whitelists",
	clear_unknown_jobs = "Clear Unknown Jobs",
	clear_unknown_jobs_tooltip = "If there is whitelist data in the database related to a job that doesn't exist anymore, it will all be deleted with this button. The whitelist data of that job will be kept in case you need it in future.",
	blacklist = "Blacklist",
}

if (file.Exists("bwhitelist_version.dat","DATA")) then

	local version_changes = {

	}

	if (version_changes[file.Read("bwhitelist_version.dat","DATA")]) then
		version_changes[file.Read("bwhitelist_version.dat","DATA")]()
		file.Write("bwhitelist_version.dat",BWhitelist.Version)
	end

end

require("billyerror")

function BWhitelist:print(msg,type)
	if (type == "error" or type == "bad") then
		MsgC(Color(255,0,0),"[BWhitelist] ",Color(255,255,255),msg .. "\n")
	elseif (type == "success" or type == "good") then
		MsgC(Color(0,255,0),"[BWhitelist] ",Color(255,255,255),msg .. "\n")
	else
		MsgC(Color(0,255,255),"[BWhitelist] ",Color(255,255,255),msg .. "\n")
	end
end

function BWhitelist:hook(h,i,f)
	hook.Remove(h,"bwhitelist_" .. i)
	hook.Add(h,"bwhitelist_" .. i,f)
end
function BWhitelist:unhook(h,i)
	hook.Remove(h,"bwhitelist_" .. i)
end

function BWhitelist:nets(m)
	net.Start("bwhitelist_" .. m)
end
function BWhitelist:netr(m,f)
	if (SERVER) then
		net.Receive("bwhitelist_" .. m,function(l,p)
			f(p)
		end)
	else
		net.Receive("bwhitelist_" .. m,f)
	end
end

function BWhitelist:timer(i,d,r,f)
	timer.Create("bwhitelist_" .. i,d,r,f)
end
function BWhitelist:untimer(i)
	timer.Remove("bwhitelist_" .. i)
end

local function go()

	include("bwhitelist_config.lua")
	if (not BWhitelist.Config) then
		BillyError("BWhitelist","There's a syntax error with your BWhitelist config. Please check your SERVER console for more information. We remind you that your config errors are not the developers' problem and you must fix them yourself.")
		include("bwhitelist/default_config.lua")
	end

	if (BWhitelist.Config.DefaultLanguage ~= "English") then
		if (file.Exists("bwhitelist/lang/" .. BWhitelist.Config.DefaultLanguage .. ".lua","LUA")) then
			include("bwhitelist/lang/" .. BWhitelist.Config.DefaultLanguage .. ".lua")
		else
			if (CLIENT) then BillyError("BWhitelist","That language does not exist. Please fix config.DefaultLanguage in your BWhitelist Config.") end
			BWhitelist.Config.DefaultLanguage = "English"
		end
	end

	if (CLIENT) then
		if (not file.Exists("bwhitelist_language.txt","DATA")) then
			file.Write("bwhitelist_language.txt",BWhitelist.Config.DefaultLanguage)
		end
		BWhitelist.SelectedLanguage = file.Read("bwhitelist_language.txt","DATA")
		BWhitelist.SelectedLanguage = BWhitelist.SelectedLanguage:sub(1,1):upper() .. BWhitelist.SelectedLanguage:sub(2)
		if (BWhitelist.SelectedLanguage ~= "English") then
			if (not file.Exists("bwhitelist/lang/" .. BWhitelist.SelectedLanguage .. ".lua","LUA")) then
				BWhitelist.SelectedLanguage = "English"
			else
				include("bwhitelist/lang/" .. BWhitelist.SelectedLanguage .. ".lua")
			end
		else
			BWhitelist.Language = nil
		end
	end

	function BWhitelist:IsMaxPermitted(ply)
		if (not ply and CLIENT) then ply = LocalPlayer() end
		for _,v in pairs(BWhitelist.Config.MaxPermitted) do
			if (v == ply:SteamID() or v == ply:SteamID64() or v == ply:Team() or v == ply:GetUserGroup()) then
				return true
			elseif (type(v) == "function") then
				if (v(ply,to_what)) then
					return true
				end
			end
		end
		return false
	end
	function BWhitelist:HasAccess(ply,to_what)
		if (BWhitelist:IsMaxPermitted(ply)) then
			return true
		end
		for i,v in pairs(BWhitelist.Config.Permissions) do
			if (i == ply:SteamID() or i == ply:SteamID64() or i == ply:Team() or i == ply:GetUserGroup()) then
				if (to_what == nil) then
					return true
				else
					for _,x in pairs(v) do
						print(x)
						if (x == "*") then
							return true
						end
						if (RPExtraTeams[x].name == to_what) then
							return true
						end
					end
				end
			elseif (type(i) == "function") then
				if (i(ply,to_what)) then
					return true
				end
			end
		end
		return false
	end

	function BWhitelist:t(p)
		if (BWhitelist.Language) then
			if (BWhitelist.Language[p]) then
				return BWhitelist.Language[p]
			end
		end
		return BWhitelist.EnglishLanguage[p]
	end

	if (CLIENT and BWhitelist.Config.ShowUnwhitelistedJobs == false) then
		for _,v in pairs(RPExtraTeams) do
			v.custom_Check = v.BWhitelist_customCheck
			v.customCheck = function()
				if (BWhitelist.WhitelistsEnabled[v.name]) then
					if (BWhitelist.Permissed[v.name]) then
						return true
					else
						return false
					end
				end
				if (v.custom_Check) then
					local r = v.custom_Check(LocalPlayer())
					if (r == false) then
						return false
					else
						return true
					end
				end
				return true
			end
		end
	end

	if (SERVER) then
		function wfp()
			timer.Simple(0,function()
				if (file.Exists("bwhitelist/sv.lua","LUA")) then
					include("bwhitelist/sv.lua")
				else
					include("bwhitelist/ext.lua")
				end
			end)
		end
		if (#player.GetAll() > 0) then
			wfp()
		else
			BWhitelist:hook("PlayerInitialSpawn","bwhitelist_waitforplayer",function()
				wfp()
				BWhitelist:unhook("PlayerInitialSpawn","bwhitelist_waitforplayer")
			end)
		end
	else
		include("bwhitelist/cl.lua")
	end

end

local function go2()
	if (ezJobs) then
		BWhitelist:print("Waiting for ezJobs...")
		BWhitelist:timer("ezJobsLoaded",0.5,0,function()
			if (ezJobs_loaded) then
				if (BWhitelist) then
					go()
					BWhitelist:print("DarkRP and ezJobs initialized.","good")
					BWhitelist:untimer("ezJobsLoaded")
				end
			end
		end)
	else
		go()
		BWhitelist:print("DarkRP initialized.","good")
	end
end

BWhitelist:print("Waiting for DarkRP...")
if (BWhitelist_loadCustomDarkRPItems) then
	go2()
else
	BWhitelist:timer("loadCustomDarkRPItems",0.5,0,function()
		if (BWhitelist_loadCustomDarkRPItems) then
			if (BWhitelist) then
				go2()
				BWhitelist:untimer("loadCustomDarkRPItems")
			end
		end
	end)
end
