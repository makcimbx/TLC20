local convar = CreateClientConVar("relay_enabled", "1", true, false, "Should you see messages from discord?")

if RelayConfig.ShowOnJoinMessage then
    chat.AddText(RelayConfig.RelayClr, "[Discord] ", RelayConfig.MessageClr, "To disable the discord relay, run the console command \"relay_enabled 0\"")
end

net.Receive("Relay_Message", function(len)
    if not convar:GetBool() then return end
    local username = net.ReadString()
    local message = net.ReadString()
    chat.AddText(RelayConfig.RelayClr, "[Discord] ", RelayConfig.UsernameClr, username, RelayConfig.ColonClr, ": ", RelayConfig.MessageClr, message)
end)

net.Receive("Relay_Blocked", function(len)
    if not convar:GetBool() then return end -- Should it matter anyways?
    local username = net.ReadString()
    local reason = net.ReadString()
    chat.AddText(RelayConfig.RelayClr, "[Discord] ", RelayConfig.UsernameClr, username, RelayConfig.MessageClr, " has blacklisted you with the reason", RelayConfig.ColonClr, ": ", RelayConfig.MessageClr, reason)
end)