
local Settings = {
	["Enable"] = true,
	--Enables/Disables the entire addon.

	["IgnoreAnimationsCRC"] = true,
	--Sets the addon to ignore CRC checking. If the garrysmod animations file is edited from an update, this will change.

	["IgnoreDarkRPAnimationsCRC"] = false,
	--Skips CRC checking of the darkrp animations hook. If you have not modified the "darkrp_animations" hook, then you can enable this to force replace the original hook with the optimized version.

	["LoadDelay"] = 5,
	--The initial load delay in seconds, where conflicts are checked and functions are overwritten. This should be a time after all addons have loaded.

	["IgnoreFunctionOverwrites"] = false,
	--Skips checking for function overwrites and loads all optimized code. (Not recommended)

	["LogToFile"] = false,
	--Logs all output to a file. Useful if your rcon is cluttered with other addons. The file will be garrysmod/data/SBoost_Animations.txt
	

}

function GetSBoostASetting(name)
	return Settings[name]
end