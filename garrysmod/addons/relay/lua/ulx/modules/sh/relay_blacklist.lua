function ulx.relayblacklist(calling_ply, target_ply, reason)
    if Relay.Blacklist[target_ply:SteamID()] then
        local data = Relay.Blacklist[target_ply:SteamID()]
        ULib.tsayError(calling_ply, data.admin .. " has already blacklisted this user! (" .. data.reason .. ")")
        return
    end

    Relay.Blacklist[target_ply:SteamID()] = {
        admin = calling_ply:Nick() or calling_ply:Name(),
        reason = reason
    }
    Relay:SaveBlacklist()
    ulx.fancyLogAdmin(calling_ply, false, "#A blocked #T from chatting to discord (#s)", target_ply, reason)
end

local relayblacklist = ulx.command("Discord Relay", "ulx relayblacklist", ulx.relayblacklist, "!relayblacklist", true)
relayblacklist:addParam({type = ULib.cmds.PlayerArg})
relayblacklist:addParam({type = ULib.cmds.StringArg, hint = "Reason", ULib.cmds.takeRestOfLine})
relayblacklist:defaultAccess(ULib.ACCESS_ADMIN)
relayblacklist:help("Block a person from relay")

function ulx.relayunblacklist(calling_ply, target_ply)
    if not Relay.Blacklist[target_ply:SteamID()] then
        ULib.tsayError(calling_ply, target_ply:Nick() .. " is not blacklisted from discord!")
        return
    end

    Relay.Blacklist[target_ply:SteamID()] = nil
    Relay:SaveBlacklist()
    ulx.fancyLogAdmin(calling_ply, false, "#A unblocked #T from chatting to discord", target_ply)
end

local relayunblacklist = ulx.command("Discord Relay", "ulx relayunblacklist", ulx.relayunblacklist, "!relayunblacklist", true)
relayunblacklist:addParam({type = ULib.cmds.PlayerArg})
relayunblacklist:defaultAccess(ULib.ACCESS_ADMIN)
relayunblacklist:help("Unblock a person from relay")
