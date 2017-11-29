if SERVER then
	AddCSLuaFile("rt/client/cl_menus.lua")
	AddCSLuaFile("rt/client/DChoice.lua")
	AddCSLuaFile("rt/client/DAlert.lua")
	AddCSLuaFile("rt/sh_rtconfig.lua")
	include("rt/server/sv_rt.lua")

	resource.AddFile("resource/fonts/Roboto-Thin.ttf")
	resource.AddFile("resource/fonts/Roboto-Light.ttf")
end

include("rt/sh_rtconfig.lua")

if CLIENT then
	include("rt/client/cl_menus.lua")
	include("rt/client/DChoice.lua")
	include("rt/client/DAlert.lua")
end