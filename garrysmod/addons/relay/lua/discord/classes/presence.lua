--[[
    game = {
        name = "gamename if playing"
    }

    user = {
        id = "discorduserid"
    }
]]
local Presence = {}

function Presence:Constructor(data)
    self.game = nil
    self.status = nil
    self.user = nil
    for _, __ in pairs(data) do
        self[_] = __
    end
end

OOP:Register("Presence", Presence)