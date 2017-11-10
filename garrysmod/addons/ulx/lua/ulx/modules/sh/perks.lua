function ulx.addXP(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:AddExp(amount, true)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " дал вам "..amount.." опыта")
	ulx.fancyLogAdmin( calling_ply, "#A добавил #T #s опыта", target_ply, amount )
end
local addXPx = ulx.command("Система Скилов", "ulx Добавить опыта", ulx.addXP, "!addxp")
addXPx:addParam{type=ULib.cmds.PlayerArg}
addXPx:addParam{type=ULib.cmds.NumArg, min=1, max=100}
addXPx:defaultAccess(ULib.ACCESS_ADMIN)
addXPx:help("Добавляет опыт.")
------------------------------------------------------------------------------------------------------------------------------
function ulx.addPerks(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:AddLevels(amount)
	DarkRP.notify(target_ply, 0,4,"Вам было добавлено "..amount.." Очков Навыков")
	ulx.fancyLogAdmin( calling_ply, "#A добавил #T #s Очков Навыков", target_ply, amount )
end
local addPerks = ulx.command("Система Скилов", "ulx Добавить Очки Навыков", ulx.addPerks, "!addpreks")
addPerks:addParam{type=ULib.cmds.PlayerArg}
addPerks:addParam{type=ULib.cmds.NumArg, min=1, max=100}
addPerks:defaultAccess(ULib.ACCESS_ADMIN)
addPerks:help("Добавляет Очки Навыков.")
------------------------------------------------------------------------------------------------------------------------------
function ulx.setResetPoints(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:SetSkillResetPoints(amount)
	DarkRP.notify(target_ply, 0,4,"Вам было установлено "..amount.." сбросов навыков")
	ulx.fancyLogAdmin( calling_ply, "#A установил #T #s сбросов навыков", target_ply, amount )
end
local setResetPoints = ulx.command("Система Скилов", "ulx Установить сбросы навыков", ulx.setResetPoints, "!setresetpoints")
setResetPoints:addParam{type=ULib.cmds.PlayerArg}
setResetPoints:addParam{type=ULib.cmds.NumArg, min=1, max=100}
setResetPoints:defaultAccess(ULib.ACCESS_ADMIN)
setResetPoints:help("Устанавливает сбросы навыков.")
------------------------------------------------------------------------------------------------------------------------------
function ulx.addResetPoints(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:AddSkillResetPoints(amount)
	DarkRP.notify(target_ply, 0,4,"Вам было добавлено "..amount.." сбросов навыков")
	ulx.fancyLogAdmin( calling_ply, "#A добавил #T #s сбросов навыков", target_ply, amount )
end
local addResetPoints = ulx.command("Система Скилов", "ulx Добавить сбросы навыков", ulx.addResetPoints, "!addresetpoints")
addResetPoints:addParam{type=ULib.cmds.PlayerArg}
addResetPoints:addParam{type=ULib.cmds.NumArg, min=1, max=100}
addResetPoints:defaultAccess(ULib.ACCESS_ADMIN)
addResetPoints:help("Даёт сбросы навыков.")
------------------------------------------------------------------------------------------------------------------------------
function ulx.addXP(calling_ply, target_ply, amount)
	if not amount then ULib.tsayError("Amount not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	target_ply:addXP(amount, true)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " gave you "..amount.."XP")
	ulx.fancyLogAdmin( calling_ply, "#A добавил #T #s опыта", target_ply, amount )
end
local addXPx = ulx.command("Levels", "ulx addxp", ulx.addXP, "!addxp")
addXPx:addParam{type=ULib.cmds.PlayerArg}
addXPx:addParam{type=ULib.cmds.NumArg, hint="xp"}
addXPx:defaultAccess(ULib.ACCESS_ADMIN)
addXPx:help("Add XP to a player.")
------------------------------------------------------------------------------------------------------------------------------
function ulx.setLevel(calling_ply, target_ply, level)
	if not level then ULib.tsayError("Level not specified!") return end
	if target_ply.DarkRPUnInitialized then return end
	DarkRP.storeXPData(target_ply,level,0)
        target_ply:setDarkRPVar('level',level)
        target_ply:setDarkRPVar('xp',0)
	DarkRP.notify(target_ply, 0,4,calling_ply:Nick() .. " set your level to "..level)
	ulx.fancyLogAdmin( calling_ply, "#A установил #s уровень #T", target_ply, amount )
end
local setLevelx = ulx.command("Levels", "ulx setlevel", ulx.setLevel, "!setlevel")
setLevelx:addParam{type=ULib.cmds.PlayerArg}
setLevelx:addParam{type=ULib.cmds.NumArg, hint="level"}
setLevelx:defaultAccess(ULib.ACCESS_ADMIN)
setLevelx:help("Set a players level.")