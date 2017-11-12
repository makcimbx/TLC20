local Payloads = {}
Payloads.Loads = {
    ["Heartbeat"] = function(Seq)
        return {
            ["op"] = 1,
            ["d"] = Seq or nil,
        }
    end,
    ["Auth"] = function(token)
        return {
            ["op"] = 2,
            ["d"] = {
                ["token"] = token,
                ["properties"] = {
                    ["$os"] = jit.os,
                    ["$browser"] = "GLua-DAPI",
                    ["$device"] = "GLua-DAPI",
                    ["$referrer"] = "",
                    ["$referring_domain"] = "",
                },
                ["compress"] = false,
                ["large_threshold"] = 100,
            }
        }
    end,
    ["Status"] = function(game)
        game = game and "\"" .. game .. "\"" or "null"
        return [[{"op":3,"d":{"idle_since":null,"game":{"name":]] .. game .. [[}}}]]
    end,
}

function Payloads:Get(name, ...)
    if Payloads.Loads[name] then
        local data = Payloads.Loads[name](...)
        return type(data) == "table" and util.TableToJSON(data) or data
    end
    return nil
end

OOP:Register("Payloads", Payloads)