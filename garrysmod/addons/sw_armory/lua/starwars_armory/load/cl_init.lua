if not CLIENT then return end
//
/*
	This file is not needed to be touched.
	
	For configuration
	server/sv_armory_config.lua
	client/cl_armory_config.lua
	
	Thanks for purchasing -Nykez
*/

SArmory = SArmory or {}
SArmory.Config = SArmory.Config or {}
SArmory.Action = SArmory.Action or {}
SArmory.Database = SArmory.Database or {}
local folder = "starwars_armory"

function SArmory.Action.loadWeapons()
	local foundFiles = file.Find(folder .. "/weapons/*.lua", "LUA")
	MsgN("[Armory] Found " .. #foundFiles .. " weapon files!")

	for k, v in pairs(foundFiles) do
        local fileName = folder.. "/weapons/".. v

    	if SERVER then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	end
end

function SArmory.Action.registerWeapon(tblWeapon)
	SArmory.Database[tblWeapon.ID] = tblWeapon
end

function SArmory.Action.loadFiles()
	for k, v in pairs(file.Find(folder.."/client/*.lua", "LUA")) do
		include(folder.."/client/"..v)
	end
	for k, v in pairs(file.Find(folder.."/client/vgui/*.lua", "LUA")) do
		include(folder.."/client/vgui/"..v)
	end
	
	SArmory.Action.loadWeapons()
end
hook.Add("DarkRPFinishedLoading", "SArmory.Action.loadFiles1", SArmory.Action.loadFiles)

function SArmory.Action.onReload()
	SArmory.Action.loadFiles()
	SArmory.Action.loadWeapons()
end
hook.Add("OnReloaded", "SArmory.Action.onReload", SArmory.Action.onReload)
















