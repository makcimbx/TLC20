local User = {}

function User:Constructor(data)
    self.avatar = nil
    self.discriminator = nil
    self.id = nil
    self.username = nil

    for _, __ in pairs(data) do
        self[_] = __
    end
end

OOP:Register("User", User)