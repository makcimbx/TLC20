local Emoji = {}

function Emoji:Constructor(data)
    self.id = nil
    self.managed = nil
    self.name = nil
    self.require_colons = nil
    self.roles = nil
    for _, __ in pairs(data) do
        self[_] = __
    end
end

OOP:Register("Emoji", Emoji)