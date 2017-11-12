local Message = {}
local debug = DISCORD_DEBUG or false

function Message:Constructor(data, _client)
    self._client = _client

    self.attachments = nil
    self.author = nil
    self.channel_id = nil
    self.content = nil
    self.embeds = nil
    self.id = nil
    self.mention_everyone = nil
    self.mention_roles = nil
    self.mentions = nil
    self.nonce = nil
    self.pinned = nil
    self.timestamp = nil
    self.tts = nil
    self.type = nil

    for _, __ in pairs(data) do
        if _ == "author" then
            self[_] = OOP:New("User", __)
        else
            self[_] = __
        end
    end
end

function Message:GetChannel()
    return self._client.channels[self.channel_id]
end

function Message:Edit(data, callback)
    if self.author.id ~= self._client.id then return end
    if debug then print("-> Editing message with " .. data) end
    data = util.TableToJSON({content = data})
    self._client.http:EditMessage(self.channel_id, self.id, data, callback)
end

function Message:Delete(callback)
    if self.author.id ~= self._client.id then return end
    if debug then print("-> Deleting message") end
    self._client.http:DeleteMessage(self.channel_id, self.id, callback)
end

OOP:Register("Message", Message)