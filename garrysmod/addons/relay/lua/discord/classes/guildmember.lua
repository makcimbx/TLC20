--[[
    roles = {
        [1] = "roleid",
        [2] = "roleid",
    }

    user = {
        avatar = "avatarhash",
        bot = true,
        discriminator = "userdisciriminator",
        id = "discordid",
        username = "discordusername"
    }
]]

local GuildMember = {}

function GuildMember:Constructor(data)
    self.deaf = nil
    self.joined_at = nil
    self.mute = nil
    self.nick = nil
    self.roles = nil
    self.user = nil
    for _, __ in pairs(data) do
        if _ == "user" then
            self[_] = OOP:New("User", __)
        else
            self[_] = __
        end
    end
end

OOP:Register("GuildMember", GuildMember)