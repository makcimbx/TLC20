--[[
	Chessnut's NPC System
	Do not re-distribute without author's permission.

	Revision f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7
--]]

if (SERVER) then
	include("cn_npc_system/sv_cn_npc.lua")
	include("cn_npc_system/sh_cn_npc.lua")
	include("cn_npc_system/sv_mis.lua")

	AddCSLuaFile("cn_npc_system/cl_cn_npc.lua")
	AddCSLuaFile("cn_npc_system/sh_cn_npc.lua")
	AddCSLuaFile("cn_npc_system/cl_mis.lua")
else
	include("cn_npc_system/cl_cn_npc.lua")
	include("cn_npc_system/sh_cn_npc.lua")
	include("cn_npc_system/cl_mis.lua")
end

MsgC(Color(0, 255, 0), "Loaded Chessnut's NPC system! rev. f560639668fcb339e596b8d9cf3a6c0c9efe05a1d047e11da6c4f21e2320e4d7\n")