--[[
    data = {
        id? = {
            allow = 0,
            deny = 2097152,
            id = user/role id?,
            type = role?,
        }
    }
]]

local Permissions = {}

function Permissions:Constructor(data)

end

OOP:New("Permissions", Permissions)