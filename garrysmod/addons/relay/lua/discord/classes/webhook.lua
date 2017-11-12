local Webhook = {}
local debug = DISCORD_DEBUG or false

function Webhook:Constructor(data, _client)
    self._client = _client

    self.id = nil
    self.guild_id = nil
    self.channel_id = nil
    self.user = nil
    self.name = nil
    self.avatar = nil
    self.token = nil

    for _, __ in pairs(data) do
        if _ == "user" then
            self[_] = OOP:New("User", __)
        else
            self[_] = __
        end
    end
end

function Webhook:Edit(name, avatar, callback)
    if debug then print("-> Editing webhook") end
    local data = util.TableToJSON({name = name, avatar = avatar and "data:image/png;base64," .. avatar or nil})
    self._client.http:EditWebhook(self.id, data, callback)
end

function Webhook:SendMessage(message, username, avatar_url, callback)
    if debug then print("-> Sending message as webhook") end
    local data = util.TableToJSON({
        username = username,
        avatar_url = avatar_url,
        content = message,
    })
    self._client.http:SendWebhook(self.id, self.token, data, callback)
end

OOP:Register("Webhook", Webhook)