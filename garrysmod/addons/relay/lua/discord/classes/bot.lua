local Bot = {}

local Payloads = OOP:New("Payloads")
local debug = DISCORD_DEBUG or false
local Gateway = "wss://gateway.discord.gg/?v=6"
function Bot:Constructor()
    self.Token = ""
    self.Seq = nil
    self.Authed = false
    self.hbInterval = 0
    self.channels = {}
    self.guilds = {}
    self.users = {}
    self.http = OOP:New("HTTP", self)
end

function Bot:IsConnected()
    return self.WebSocket:IsActive() and self.Authed
end

function Bot:Auth()
    if debug then print("-> Authenticating") end
    self.WebSocket:Send(Payloads:Get("Auth", self.Token))
end

function Bot:StartHB()
    if not self:IsConnected() then return end
    timer.Create(tostring(self.WebSocket), self.hbInterval, 0, function()
        if not self:IsConnected() then timer.Destroy(tostring(self.WebSocket)) return end
        self:HB()
    end)
end

function Bot:HB()
    if debug then print("-> Heartbeat with sequence: " .. (self.Seq or "nil")) end
    self.WebSocket:Send(Payloads:Get("Heartbeat", self.Seq))
end

function Bot:HandleMessages(data)
    data = util.JSONToTable(data)
    -- op 11: Heartback ACK
    if debug and data.op ~= 11 and data.op ~= 0 then print("-> Received op code: " .. data.op) end
    if data.op == 0 then
        self:HandleMessage(data)
    elseif data.op == 1 then
        self:HB()
    elseif data.op == 7 then
        self.WebSocket:Close()
    elseif data.op == 9 then
        self.WebSocket:Close() -- Invalid session id
        if Relay then Relay:Log("Invalid Session ID") end
    elseif data.op == 10 then
        self.hbInterval = data.d.heartbeat_interval / 1000
        if not self.Authed then
            self:Auth()
        end
    end
end

function Bot:HandleMessage(data)
    self.Seq = data.s
    local t = data.t
    if debug then print("-> Message type: " .. t) end
    if t == "READY" then
        if debug then print("-> Ready") end
        self.Authed = true
        self.user = OOP:New("User", data.d.user, _client)
        self.id = data.d.user.id
        self.username = data.d.user.username
        self:StartHB()
        timer.Simple(1, function() self:fire("ready") end) -- wait for guilds to init
    elseif t == "GUILD_CREATE" then
        local guild = OOP:New("Guild", data.d, self)
        local guildid = data.d.id
        self.guilds[guildid] = guild
    elseif t == "MESSAGE_CREATE" then
        local message = OOP:New("Message", data.d, self)
        self:fire("message", message)
    else
        if debug then print("-> Unsupported type: " .. t) end
    end
end

function Bot:Login(token)
    self.Token = token
    self.WebSocket = WS.Client(Gateway, 443)
    self.WebSocket:on("open", function()
        if debug then print("-> WebSocket Open") end
    end)
    self.WebSocket:on("message", function(data)
        self:HandleMessages(data)
    end)
    self.WebSocket:on("close", function(a)
        if debug then print("-> Closed") end
        self:fire("close", self.Authed)
        self.Authed = false
    end)
    self.WebSocket:Connect()
end

function Bot:SetGame(game)
    self.WebSocket:Send(Payloads:Get("Status", game))
end

function Bot:SetUser(username, avatar, callback)
    local data = util.TableToJSON({username = username, avatar = avatar and "data:image/png;base64," .. avatar or nil})
    self.http:EditUser(data, function(user)
        self.user = user
        self.id = user.id
        self.username = user.username
        if callback then callback(user) end
    end)
end

function Bot:Mention()
    return "<@" .. self.id .. ">"
end

function Bot:Disconnect()
    if not self.WebSocket:IsActive() then return end
    if debug then print("-> Disconnecting...") end
    self.WebSocket:Close()
end

function Bot:FindChannel(name)
    name = string.lower(name)
    for _, channel in pairs(self.channels) do
        if string.lower(channel.name) == name then return channel end
    end
end

OOP:Register("Bot", Bot, "EventHandler")