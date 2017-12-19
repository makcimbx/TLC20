if SERVER then

	include("../sv_checkpoints.lua")
	include("../checkpointsconfig.lua")
	AddCSLuaFile("cl_checkpoints.lua")

else

	include("cl_checkpoints.lua")

end