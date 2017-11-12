local Role = {}

function Role:Constructor(data)
    self.color = nil
    self.hoist = nil
    self.id = nil
    self.managed = nil
    self.mentionable = nil
    self.name = nil
    self.permission = nil
    self.position = nil
    for _, __ in pairs(data) do
        if _ == "permission" then
            self[_] = OOP:New("Permissions", __)
        else
            self[_] = __
        end
    end
end

function Role:GetColor() -- Convert decimal to Color()
    return nil
end

OOP:Register("Role", Role)