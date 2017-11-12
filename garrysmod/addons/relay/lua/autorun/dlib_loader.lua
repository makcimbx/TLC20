if CLIENT then include("cl_relayconfig.lua") include("relay/cl_relay.lua") include("relay/cl_screenshot.lua") return end
print("Discord Relay: Initializing")

local installed = false

for _, module in pairs(file.Find("garrysmod/lua/bin/*", "BASE_PATH")) do
    if module == "gmsv_bromsock_win32.dll" or module == "gmsv_bromsock_linux.dll" then
        local res, err = pcall(require, "bromsock")
        installed = res
    end
end

if not installed then
    print("Discord Relay: Module bromsock is not installed or is missing dependencies!")
    print("Possible solutions:")
    print(" Windows:")
    print("  - Install C++ 2013 Redistributable")
    print(" Linux:")
    print("  - Make sure you have installed libssl and libcrypto")
    print("Loading has been aborted due to no bromsock.")
    return
end

-- DISCORD_DEBUG = true

include("discord/oop.lua")
local classes = file.Find("discord/classes/*.lua", "LUA")
for _, fileName in pairs(classes) do
    include("discord/classes/" .. fileName)
end
include("relayconfig.lua")
include("relay/relay.lua")
if RelayConfig.ScreenshottingEnabled then
    include("relay/screenshot.lua")
end
AddCSLuaFile("cl_relayconfig.lua")
AddCSLuaFile("relay/cl_relay.lua")
AddCSLuaFile("relay/cl_screenshot.lua")

hook.Add("serverguard.Initialize", "Discord_Relay", function()
    include("sg/relay_blacklist.lua")
end)