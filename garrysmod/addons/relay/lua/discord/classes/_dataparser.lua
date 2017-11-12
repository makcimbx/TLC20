local DataParser = {}

function DataParser:ParseGuildData(data, _client)
    local result = {}
    for _, __ in pairs(data) do
        if type(__) ~= "table" then
            result[_] = __
        else
            if _ == "channels" then
                local channels = {}
                for ___, channel in pairs(__) do
                    local channelObject = OOP:New("Channel", channel, _client)
                    channels[channelObject.id] = channelObject
                    _client.channels[channelObject.id] = channelObject
                end
                result[_] = channels
            elseif _ == "features" then
                -- Empty???
            elseif _ == "emojis" then
                local emojis = {}
                for ___, emoji in pairs(__) do
                    table.insert(emojis, OOP:New("Emoji", emoji))
                end
                result[_] = emojis
            elseif _ == "members" then
                local members = {}
                for ___, member in pairs(__) do
                    table.insert(members, OOP:New("GuildMember", member))
                end
                result[_] = members
            elseif _ == "roles" then
                local roles = {}
                for ___, role in pairs(__) do
                    table.insert(roles, OOP:New("Role", role))
                end
                result[_] = roles
            elseif _ == "voice_states" then
                -- Empty???
            elseif _ == "presences" then
                local presences = {}
                for ___, presence in pairs(__) do
                    table.insert(presences, OOP:New("Presence", presence))
                end
                result[_] = presences
            else
                print("-> Unhandled receiving data: " .. _)
            end
        end
    end
    return result
end

OOP:Register("DataParser", DataParser)