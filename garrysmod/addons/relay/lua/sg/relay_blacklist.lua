serverguard.command:Add({
    ["help"] = "Block a person from relay",
    ["command"] = "relayblacklist",
    ["arguments"] = {"player", "reason"},
    ["permissions"] = {"Admin"},
    ["Execute"] = function(sg, player, silent, args)
        local target = util.FindPlayer(args[1], player)
        if target and IsValid(target) then
            if Relay.Blacklist[target:SteamID()] then
                local data = Relay.Blacklist[target:SteamID()]
                serverguard.Notify(player, data.admin .. " has already blacklisted this user! (" .. data.reason .. ")")
                return
            end

            Relay.Blacklist[target:SteamID()] = {
                admin = target:Nick() or target:Name(),
                reason = args[2] || "No reason",
            }
            Relay:SaveBlacklist()
            serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " has blocked ", SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), SERVERGUARD.NOTIFY.WHITE, " from chatting to discord (" .. (args[2] || "No reason") .. ").")
        end
    end
})

serverguard.command:Add({
    ["help"] = "Unblock a person from relay",
    ["command"] = "relayunblacklist",
    ["arguments"] = {"player"},
    ["permissions"] = {"Admin"},
    ["Execute"] = function(sg, player, silent, args)
        local target = util.FindPlayer(args[1], player)
        if target and IsValid(target) then
            if not Relay.Blacklist[target:SteamID()] then
                serverguard.Notify(player, serverguard.player:GetName(target) .. " is not blacklisted from discord!")
                return
            end

            Relay.Blacklist[target:SteamID()] = nil
            Relay:SaveBlacklist()
            serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " has unblocked ", SERVERGUARD.NOTIFY.RED, serverguard.player:GetName(target), SERVERGUARD.NOTIFY.WHITE, " from chatting to discord (" .. (args[2] || "No reason") .. ").")
        end
    end
})