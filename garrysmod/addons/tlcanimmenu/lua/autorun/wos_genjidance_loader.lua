

wOS = wOS or {}
wOS.RollMod = wOS.RollMod or {}

if SERVER then

	AddCSLuaFile( "wos/genjidance/config.lua" )
	AddCSLuaFile( "wos/genjidance/sh_anim.lua" )
	AddCSLuaFile( "wos/genjidance/cl_init.lua" )
	include( "wos/genjidance/sv_init.lua" )
	
else

	include( "wos/genjidance/cl_init.lua" )

end

include( "wos/genjidance/config.lua" )
include( "wos/genjidance/sh_anim.lua" )
