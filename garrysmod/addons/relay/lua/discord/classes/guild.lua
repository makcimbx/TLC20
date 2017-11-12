local Parser = OOP:New("DataParser")
local Guild = {}

function Guild:Constructor(data, _client)
    self.id = nil
    self.default_message_notifications = nil
    self.large = nil
    self.verification_level = nil
    self.channels = nil
    self.mfa_level = nil
    self.features = nil
    self.emojis = nil
    self.unavailable = nil
    self.afk_timeout = nil
    self.region = nil
    self.owner_id = nil
    self.name = nil
    self.members = nil
    self.roles = nil
    self.voice_states = nil
    self.presences = nil
    self.icon = nil
    self.joined_at = nil
    self.member_count = nil
    self._client = _client
    data = Parser:ParseGuildData(data, _client)
    for _, __ in pairs(data) do
        self[_] = __
    end
end

function Guild:GetGuildMember(id)
    for _, __ in pairs(self.members) do
        if __.user.id == id then return __ end
    end
end

function Guild:GetRole(id)
    for _, __ in pairs(self.roles) do
        if __.id == id then return __ end
    end
end

OOP:Register("Guild", Guild)