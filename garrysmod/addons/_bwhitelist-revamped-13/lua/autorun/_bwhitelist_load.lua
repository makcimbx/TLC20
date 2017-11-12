hook.Add("loadCustomDarkRPItems","bwhitelist_loadCustomDarkRPItems",function()
	BWhitelist_loadCustomDarkRPItems = true
end)
hook.Add("ezJobsLoaded","bwhitelist_loadezJobs",function()
	ezJobs_loaded = true
end)

if (BWhitelist and CLIENT) then
	if (IsValid(BWhitelist.Menu)) then
		BWhitelist.Menu:Close()
	end
end

BWhitelist = {}
BWhitelist.Version = "Revamped-13"
BWhitelist.Licensee = "76561198045250557"

if (SERVER) then
	AddCSLuaFile("bwhitelist/sh.lua")
	AddCSLuaFile("bwhitelist_config.lua")
	AddCSLuaFile("bwhitelist/cl.lua")
	AddCSLuaFile("bwhitelist_config.lua")
	AddCSLuaFile("bwhitelist/default_config.lua")
	for _,v in pairs((file.Find("bwhitelist/lang/*.lua","LUA"))) do
		AddCSLuaFile("bwhitelist/lang/" .. v)
	end
end
include("bwhitelist/sh.lua")
