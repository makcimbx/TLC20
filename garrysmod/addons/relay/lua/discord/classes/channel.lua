local Channel = {}
local debug = DISCORD_DEBUG or false

function Channel:Constructor(data, _client)
    self._client = _client

    -- Text channel
    self.id = nil
    self.last_message_id = nil
    self.last_pin_timestamp = nil
    self.name = nil
    self.permission_overwrites = nil
    self.position = nil
    self.topic = nil
    self.type = nil

    -- Voice channel
    self.bitrate = nil
    self.id = nil
    self.permission_overwrites = nil
    self.position = nil
    self.type = nil
    self.user_limit = nil

    for _, __ in pairs(data) do
        if _ == "permission_overwrites" then
            self[_] = OOP:New("Permissions", __)
        else
            self[_] = __
        end
    end
end

function Channel:SendMessage(data, callback)
    if debug then print("-> Sending message " .. data .. " to channel " .. self.name) end
    data = util.TableToJSON({content = data})
    self._client.http:SendMessage(self.id, data, callback)
end

function Channel:SendEmbed(embed, callback)
    if debug then print("-> Sending Embed to channel " .. self.name) end
    data = util.TableToJSON({embed = embed.data})
    self._client.http:SendMessage(self.id, data, callback)
end

function Channel:GetWebhooks(callback)
    if debug then print("-> Requesting all webhooks") end
    self._client.http:GetWebhooks(self.id, callback)
end

function Channel:CreateWebhook(name, avatar, callback)
    if debug then print("-> Creating webhook") end
    local data = util.TableToJSON({name = name, avatar = avatar and "data:image/png;base64," .. avatar or nil})
    self._client.http:CreateWebhook(self.id, data, callback)
end

function Channel:GetGuild()
    for _, __ in pairs(self._client.guilds) do
        if __.channels[self.id] then return __ end
    end
end

OOP:Register("Channel", Channel)