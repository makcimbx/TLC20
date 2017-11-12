game.ConsoleCommand("sv_hibernate_think 1\n")

util.AddNetworkString("Relay_Message")
util.AddNetworkString("Relay_Blocked")

if Relay and Relay.Bot:IsConnected() then
    Relay.Bot:Disconnect()
end

Relay = Relay or {}
Relay.Tokens = Relay.Tokens or {}
Relay.Config = Relay.Config or {}
Relay.Blacklist = Relay.Blacklist or {}
Relay.Bot = OOP:New("Bot")

function Relay:Init()
    file.CreateDir("relay")
    if file.Exists("relay/tokens.txt", "DATA") then
        Relay.Tokens = util.JSONToTable(file.Read("relay/tokens.txt", "DATA"))
    else
        file.Write("relay/tokens.txt", util.TableToJSON({}))
    end

    if file.Exists("relay/blacklist.txt", "DATA") then
        Relay.Blacklist = util.JSONToTable(file.Read("relay/blacklist.txt", "DATA"))
    else
        file.Write("relay/blacklist.txt", util.TableToJSON({}))
    end
end
Relay:Init()

function Relay:AddToken(token)
    Relay.Tokens[token] = true
    file.Write("relay/tokens.txt", util.TableToJSON(Relay.Tokens))
end

function Relay:UpdateConfig()
    local channel = RelayConfig.RelayChannel
    if channel == "" then
        Relay:Error("No relay channel assigned!")
    else
        channel = Relay.Bot:FindChannel(channel)
        if not channel then
            Relay:Error("No relay channel were found by name " .. RelayConfig.RelayChannel)
            return
        end

        if channel.type == "voice" then
            Relay:Error("Relay channel was found, but its voice channel.")
            return
        end

        Relay.Config.Channel = channel
    end

    local channel = RelayConfig.RelayAdminChannel
    if channel == "" then
        Relay:Log("No relay admin channel assigned, administration will be disabled!")
    else
        channel = Relay.Bot:FindChannel(channel)
        if not channel then
            Relay:Error("No relay admin channel were found by name " .. RelayConfig.RelayAdminChannel)
            return
        end

        if channel.type == "voice" then
            Relay:Error("Relay admin channel was found, but its voice channel.")
            return
        end

        Relay.Config.AdminChannel = channel
    end
end

function Relay:SaveBlacklist()
    file.Write("relay/blacklist.txt", util.TableToJSON(Relay.Blacklist))
end

function Relay:Log(...)
    MsgC(Color(255, 0, 255), "Relay -> ", color_white, ..., "\n")
end

function Relay:Error(...)
    MsgC(Color(255, 0, 0), "Relay -> ", color_white, ..., "\n")
end

function Relay:IsValidToken(token)
    return Relay.Tokens[token]
end

local function strFormat(str, values)
    for _, val in pairs(values) do
        str = string.Replace(str, "{{" .. _ .. "}}", val)
    end
    return str
end

Relay.Bot:on("ready", function()
    Relay:Log("Connected!")

    if not Relay.Tokens[RelayConfig.BotToken] then
        Relay:AddToken(RelayConfig.BotToken)
    end

    Relay:UpdateConfig()

    if Relay.Config.Channel then
        Relay.Config.Channel:GetWebhooks(function(webhooks)
            local exists = false
            for _, webhook in pairs(webhooks) do
                if webhook.name == "Relay" then
                    Relay.Config.Webhook = webhook
                    exists = true
                end
            end

            if not exists then
                Relay.Config.Channel:CreateWebhook("Relay", nil, function(webhook)
                    Relay.Config.Webhook = webhook
                end)
            end
        end)
    end

    if RelayConfig.BotName ~= "" then
        if RelayConfig.BotAvatar ~= "" then
            if file.Exists("relay/lastavatar.txt", "DATA") and file.Read("relay/lastavatar.txt", "DATA") ~= RelayConfig.BotAvatar then
                http.Fetch(RelayConfig.BotAvatar, function(body, size, headers, code)
                    file.Write("relay/lastavatar.txt", RelayConfig.BotAvatar)
                    Relay.Bot:SetUser(RelayConfig.BotName, util.Base64Encode(body))
                end, function(err)
                    Relay:Error("Getting bot avatar failed with error: " .. err)            
                end)
            end
        else
            if RelayConfig.BotName ~= Relay.Bot.username then
                Relay.Bot:SetUser(RelayConfig.BotName)
            end
        end
    end

    if RelayConfig.BotStatus ~= "" then
        Relay.Bot:SetGame(string.sub(RelayConfig.BotStatus, 0, 32))
    end

    if Relay.Config.Channel and RelayConfig.OnlineAnnounce and not Relay.OnlineAnnounced then
        Relay.OnlineAnnounced = true
        Relay.Config.Channel:SendMessage(strFormat(RelayConfig.OnlineMessageFormat, {
            ip = game.GetIPAddress(),
            hostname = GetHostName(),
            joinurl = "steam://connect/" .. game.GetIPAddress(),
        }))
    end
end)

local function lowercaseKeys(tbl)
    local res = {}
    for _, __ in pairs(tbl) do
        res[string.lower(_)] = __
    end
    return res
end

local function PrintKeysAndValues(tbl)
    for _, __ in pairs(tbl) do print(_, __) end
end

local function hasPerm(msg, permName)
    local guild = msg:GetChannel():GetGuild()
    local perms = lowercaseKeys(RelayConfig.BotAdmins)
    for _, __ in pairs(guild:GetGuildMember(msg.author.id).roles) do
        local role = guild:GetRole(__)
        if perms[string.lower(role.name)] then
            return table.HasValue(RelayConfig.BotAdmins[role.name], permName)
        end
    end
    return false
end
Relay.hasPerm = hasPerm

local function calcStaffAmount()
    local a = 0
    for _, ply in pairs(player.GetAll()) do
        if ply:IsAdmin() or RelayConfig.CountAsStaff[ply:GetUserGroup()] then a = a + 1 end
    end
    return a
end

local function findPlayer(name)
    name = string.lower(name)
    for _, ply in pairs(player.GetAll()) do
        if string.find(string.lower(ply:Nick()), name, 1, true) or
        string.find(string.lower(ply:Name()), name, 1, true) or
        name == ply:SteamID() then
            return ply
        end
    end
    return nil
end
Relay.findPlayer = findPlayer

local function trimMultiline(str)
    local a = ""
    for _, __ in pairs(string.Explode("\n", str)) do
        a = a .. string.Trim(__) .. "\n"
    end
    return a
end

-- Thanks CapsAdmin
local function parseArgs(str)
    local ret = {}
    local InString = false
    local strchar = ""
    local chr = ""
    local escaped = false

    for i = 1, #str do
        local char = str[i]
        if escaped then chr = chr .. char escaped = false continue end
        if char:find("[\"|']") and not InString and not escaped then
            InString = true
            strchar = char
        elseif char:find("[\\]") then
            escaped = true
            continue
        elseif InString and char == strchar then
            table.insert(ret, chr:Trim())
            chr = ""
            InString = false
        elseif char:find("[ ]") and not InString then
            if chr ~= "" then table.insert(ret, chr) chr = "" end
        else
            chr = chr .. char
        end
    end
    if chr:Trim():len() ~= 0 then table.insert(ret, chr) end
    return ret
end

local save = nil
if Relay.Commands and Relay.Commands["ss"] then save = Relay.Commands["ss"] end
Relay.Commands = {
    ["ping"] = function(msg)
        local start = SysTime()
        msg:GetChannel():SendMessage("Pong!", function(msg)
            msg:Edit("Pong! Took " .. math.Round(SysTime() - start, 2) * 100 .. "ms!")
        end)
    end,
    ["blacklist"] = function(msg)
        if not hasPerm(msg, "blacklist") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if not msg.mentions or not msg.mentions[1] then
            msg:GetChannel():SendMessage("No user mentioned!")
            return
        end

        local target = msg.mentions[1]
        if Relay.Blacklist["D"..target.id] then
            msg:GetChannel():SendMessage("User is already blacklisted!")
            return
        end

        msg:GetChannel():SendMessage("User " .. target.username .. " was blacklisted!")
        Relay.Blacklist["D"..target.id] = {}
        Relay:SaveBlacklist()
    end,
    ["unblacklist"] = function(msg)
        if not hasPerm(msg, "unblacklist") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if not msg.mentions or not msg.mentions[1] then
            msg:GetChannel():SendMessage("No user mentioned!")
            return
        end

        local target = msg.mentions[1]
        if not Relay.Blacklist["D"..target.id] then
            msg:GetChannel():SendMessage("User isn't blacklisted!")
            return
        end

        msg:GetChannel():SendMessage("User " .. target.username .. " was unblacklisted!")
        Relay.Blacklist["D"..target.id] = nil
        Relay:SaveBlacklist()
    end,
    ["status"] = function(msg)
        local embed = OOP:New("RichEmbed")
        :SetColor(Color(180, 0, 180))
        :SetTitle(GetHostName())
        :AddField("IP", game.GetIPAddress(), true)
        :AddField("Gamemode", gmod.GetGamemode().Name, true)
        :AddField("Map", game.GetMap(), true)
        :AddField("Players", #player.GetAll() .. "/" .. game.MaxPlayers(), true)
        :AddField("Staff online", calcStaffAmount(), true)

        -- player list?

        msg:GetChannel():SendEmbed(embed)
    end,
    ["say"] = function(msg, argStr)
        if not hasPerm(msg, "say") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if string.Trim(argStr) == "" then
            msg:GetChannel():SendMessage("Nothing to send.")
            return
        end

        game.ConsoleCommand("say " .. argStr .. "\n")
        msg:GetChannel():SendMessage("Console: " .. argStr)
    end,
    ["rcon"] = function(msg, argStr)
        if not hasPerm(msg, "rcon") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if string.Trim(argStr) == "" then
            msg:GetChannel():SendMessage("Nothing to rcon.")
            return
        end

        game.ConsoleCommand(argStr .. "\n")
        msg:GetChannel():SendMessage("Ran ``" .. argStr .. "``   as rcon.")
    end,
    ["lua_sv"] = function(msg, argStr)
        if not hasPerm(msg, "lua_sv") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if string.Trim(argStr) == "" then
            msg:GetChannel():SendMessage("Nothing to run serverside.")
            return
        end

        RunString(argStr)
        msg:GetChannel():SendMessage("Ran ``" .. argStr .. "`` serverside.")
    end,
    ["kick"] = function(msg, argStr, args)
        if not hasPerm(msg, "kick") then
            msg:GetChannel():SendMessage("You don't have the permissions for this!")
            return
        end

        if not args[1] then
            msg:GetChannel():SendMessage("No args entered (name)")
            return
        end

        local ply = findPlayer(args[1])

        if not ply or not IsValid(ply) then
            msg:GetChannel():SendMessage("Invalid player!")
            return
        end

        if not args[2] then
            ply:Kick("Kicked from discord")
        else
            ply:Kick(args[2])
        end
    end,
    ["help"] = function(msg)
        local m = trimMultiline([[
            ping - Responds with Pong!
            status - Shows server info

            Admins only:
            say TEXT - Sends message as Console to the server
            kick NAME REASON - Kicks player with that name from the server
            rcon TEXT - Runs as rcon on the server
            lua_sv LUA - Runs lua serverside
            blacklist @NAME - Blacklists user from relay
            unblacklist @NAME - Unblacklists user from relay]])
        if Relay.Commands["screenshot"] then
            m = m .. [[
                screenshot NAME QUALITY - Screenshots player, quality: 1-100
                ss NAME QUALITY - Alias of screenshot
            ]]
        end
        msg:GetChannel():SendMessage(trimMultiline(m))
    end,
}
if save then Relay.Commands["ss"] = save Relay.Commands["screenshot"] = save end

Relay.Bot:on("message", function(msg)
    if msg.author.id == Relay.Bot.id then return end
    if msg.author.bot then return end
    if msg:GetChannel() ~= Relay.Config.Channel and (Relay.Config.AdminChannel and msg:GetChannel() ~= Relay.Config.AdminChannel or false) then return end
    if Relay.Blacklist["D"..msg.author.id] then return end

    local content = string.lower(msg.content)
    if string.StartWith(content, RelayConfig.BotPrefix) then
        local data = string.Explode(" ", content)
        data[1] = string.sub(string.lower(data[1]), 2, string.len(data[1]))
        if Relay.Commands[data[1]] then
            local argStr = string.sub(msg.content, string.len(RelayConfig.BotPrefix) + string.len(data[1]) + 2, string.len(content))
            local args = parseArgs(argStr)
            Relay.Commands[data[1]](msg, argStr, args)
        end
    elseif msg:GetChannel() == Relay.Config.Channel then
        if string.len(msg.content) > 126 then
            msg:GetChannel():SendMessage(strFormat(RelayConfig.TooLongMessage, {
                username = msg.author.username
            }))
            return
        end

        for _, __ in pairs(RelayConfig.BlockedCommands) do
            if string.StartWith(msg.content, __) then return end
        end

        for _, __ in pairs(msg.mentions) do
            msg.content = string.Replace(msg.content, "<@" .. __.id .. ">", "@" .. __.username)
            msg.content = string.Replace(msg.content, "<@!" .. __.id .. ">", "@" .. __.username)
        end

        for _, channel in pairs(Relay.Bot.channels) do
            msg.content = string.Replace(msg.content, "<#" .. channel.id .. ">", "#" .. channel.name)
        end

        net.Start("Relay_Message")
            net.WriteString(msg.author.username)
            net.WriteString(msg.content)
        net.Broadcast()
    end
end)

Relay.Bot:on("close", function(wasAuthed)
    Relay:Log("Disconnected.")
    if not wasAuthed and not Relay:IsValidToken(RelayConfig.BotToken) then
        Relay:Error("Connection was closed before authenticated,\nAre you sure bot token is correct?\n")
    end

    if Relay:IsValidToken(RelayConfig.BotToken) then
        Relay:Log("Trying to reconnect in 15 seconds...")
        timer.Simple(15, function()
            if Relay.Bot:IsConnected() then Relay:Log("Connection was already restored, aborting reconnection.") return end
            Relay.Bot:Login(RelayConfig.BotToken)
        end)
    end
end)

Relay.Bot:Login(RelayConfig.BotToken)

local joinAntiSpam = {}
gameevent.Listen("player_connect")
hook.Add("player_connect", "Relay_Connect", function(data)
    if not RelayConfig.JoinAnnounce then return end
    if joinAntiSpam[data.networkid] and joinAntiSpam[data.networkid] > CurTime() then return end
    joinAntiSpam[data.networkid] = CurTime() + RelayConfig.AntiSpamDelay
    local embed = OOP:New("RichEmbed")
    :SetColor(Color(0, 204, 0))
    :SetDescription(strFormat(RelayConfig.JoinMessageFormat, {
        name = data.name,
        sid = data.networkid,
        ip = game.GetIPAddress(),
        hostname = GetHostName(),
        joinurl = "steam://connect/" .. game.GetIPAddress(),
    }))
    if Relay.Config.Channel and Relay.Bot:IsConnected() then
        Relay.Config.Channel:SendEmbed(embed)
    end
end)

local leaveAntiSpam = {}
gameevent.Listen("player_disconnect")
hook.Add("player_disconnect", "Relay_Disconnect", function(data)
    if not RelayConfig.LeaveAnnounce then return end
    if leaveAntiSpam[data.networkid] and leaveAntiSpam[data.networkid] > CurTime() then return end
    leaveAntiSpam[data.networkid] = CurTime() + RelayConfig.AntiSpamDelay
    local embed = OOP:New("RichEmbed")
    :SetColor(Color(204, 0, 0))
    :SetDescription(strFormat(RelayConfig.LeaveMessageFormat, {
        name = data.name,
        sid = data.networkid,
        ip = game.GetIPAddress(),
        joinurl = "steam://connect/" .. game.GetIPAddress(),
        hostname = GetHostName(),
        reason = data.reason,
    }))
    if Relay.Config.Channel and Relay.Bot:IsConnected() then
        Relay.Config.Channel:SendEmbed(embed)
    end
end)

hook.Add("PlayerSay", "Relay_SendChat", function(ply, text, team)
    if chatexp then team = team == CHATMODE_TEAM end
    local parse = markup_quickParse or quick_parse
    if parse then text = parse(text, ply) end
    if not ply or not IsValid(ply) then return end
    if not Relay.Bot:IsConnected() or not Relay.Config.Webhook then return end
    if Relay.Blacklist[ply:SteamID()] then
        if not ply.RelayIsBlacklisted then
            net.Start("Relay_Blocked")
                net.WriteString(Relay.Blacklist[ply:SteamID()].admin or "<UNKNOWN>")
                net.WriteString(Relay.Blacklist[ply:SteamID()].reason or "<NONE>")
            net.Send(ply)

            ply.RelayIsBlacklisted = true
        end
        return
    end

    for _, __ in pairs(RelayConfig.BlockedCommands) do
        if string.StartWith(text, __) then return end
    end

    if #RelayConfig.WhitelistedCommands > 0 then
        local canrelay = false
        for _, __ in pairs(RelayConfig.WhitelistedCommands) do
            if string.StartWith(text, __) then canrelay = true end
        end
        if not canrelay then return end
    end

    if engine.ActiveGamemode() == "terrortown" then
        if GetRoundState() == 3 then
            if ply:IsTraitor() and team or ply:IsDetective() and team then return end

            if not ply:Alive() then return end
        end
    end

    if not RelayConfig.TeamChatEnabled and team then return end

    local plyNick = RelayConfig.NamePrefix .. (ply:Nick() or ply:Name())
    if string.len(plyNick) > 32 then plyNick = string.sub(plyNick, 1, 29) .. "..." end

    -- limit messages length?

    if RelayConfig.ConvertMentions then
        local guild = Relay.Config.Channel:GetGuild()
        if guild and guild.channels then
            for _, channel in pairs(guild.channels) do
                text = string.Replace(text, "#" .. channel.name, "<#" .. channel.id .. ">")
            end

            for _, user in pairs(guild.members) do
                text = string.Replace(text, "@" .. user.user.username, "<@" .. user.user.id .. ">")
            end
        end
    end

    http.Fetch("http://steamcommunity.com/profiles/" .. ply:SteamID64() .. "/?xml=1", function(body)
        local a, startPos = string.find(body, "<avatarFull>", 1, true)
        local endPos = string.find(body, "</avatarFull>", 1, true)
        local url = RelayConfig.DefaultAvatar
        if a and startPos and endPos then
            url = string.sub(body, startPos + 1, endPos - 1)
        end
        
        if string.StartWith(url, "<![CDATA[") then
            url = string.sub(url, string.len("<![CDATA[") + 1, string.len(url) - string.len("]]>"))
        end

        Relay.Config.Webhook:SendMessage(text, plyNick, url)
    end, function(err)
        Relay:Log("Getting steam avatar failed with error: " .. err)
    end)
end)

function Relay:ULXLogging()
    if RelayConfig.UlxLogging and ULib and ulx then
        Relay:Log("Enabling ulx logging...")
        game.ConsoleCommand("ulx logFile 1\n")
        if not Relay.ulx_logString then
            Relay.ulx_logString = ulx.logString
            ulx.logString = function(str, log_to_main)
                local yay = true
                for _, bad in pairs(RelayConfig.UlxBlacklist) do
                    if string.find(text, bad) then yay = false end
                end

                if yay and Relay.Config.AdminChannel then
                    local embed = OOP:New("RichEmbed")
                    :SetColor(Color(0, 180, 180))
                    :SetTitle("ULX Log")
                    :SetDescription(str)

                    Relay.Config.AdminChannel:SendEmbed(embed)
                end
                return Relay.ulx_logString(str, log_to_main)
            end
        end
    end
end
timer.Simple(1, Relay.ULXLogging)

function Relay:SGLogging()
    if RelayConfig.SGLogging and serverguard and serverguard.plugin.GetList().logs then
        Relay:Log("Enabling serverguard logging...")
        if not Relay.sg_log then
            Relay.sg_log = serverguard.plugin.GetList().logs.Log
            serverguard.plugin.GetList().logs.Log = function(sg, text, hideConsole)
                local yay = true
                for _, bad in pairs(RelayConfig.SGBlacklist) do
                    if string.find(text, bad) then yay = false end
                end

                if yay and Relay.Config.AdminChannel then
                    local embed = OOP:New("RichEmbed")
                    :SetColor(Color(0, 180, 180))
                    :SetTitle("SG Log")
                    :SetDescription(text)

                    Relay.Config.AdminChannel:SendEmbed(embed)
                end

                return Relay.sg_log(text, hideConsole)
            end
        end
    end
end
timer.Simple(1, Relay.SGLogging)