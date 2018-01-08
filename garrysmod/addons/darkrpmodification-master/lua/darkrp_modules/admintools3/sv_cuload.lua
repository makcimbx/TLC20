
function util.IsValidWeapon( weapon )
	if(weapons.Get( weapon )==nil)then
		return false
	end
	return true
end

--[[function CheckPlayerCuLoadout(target,weapon)
	local iCuLoad = tonumber(target:GetPData("iCuLoadNumb","0"))
	for i=1,iCuLoad do 
		if(target:GetPData("iCuLoad_"..i,"-1")==weapon)then
			return true
		end
	end
	return false
end]]--

function printCuLoad(ply,target)
	local tbl = getWeaponsFromCuLoad(target)
	if(#tbl!=0)then
		local s = ""
		s = s.."---------------------------------\\n";
		s = s.."'"..target:Nick().."' cuload list: \\n";
		for k,v in pairs(tbl)do
			s = s..k.." - "..v.wep.."\\n";
		end
		s = s.."---------------------------------\\n";
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\""..s.."\\n\")") 
	else
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"---------------------------------\\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"'"..target:Nick().."' dont have any weapon in cuload! \\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"---------------------------------\\n\")") 
	end
end

function addWeaponToCuLoad(ply,wep,restriction)
	local iCuLoad = tonumber(ply:GetPData("iCuLoadNumb","0"))
	local array = {}
	for i=1,iCuLoad do 
		table.insert(array,ply:GetPData("iCuLoad_"..i))
	end

	local i = table.KeyFromValue(array,wep)
	if(i==nil)then
		ply:SetPData("iCuLoad_"..iCuLoad+1,wep)
		ply:SetPData("iCuLoadNumb",iCuLoad+1)
		if(restriction!=nil)then
			if(type(restriction)=="table")then
				ply:SetPData("iCuLoad_R_Type"..iCuLoad+1,"table")
				ply:SetPData("iCuLoad_R_V"..iCuLoad+1,table.concat( restriction, "*" ))
			else
				ply:SetPData("iCuLoad_R_Type"..iCuLoad+1,"string")
				ply:SetPData("iCuLoad_R_V"..iCuLoad+1,restriction)
			end
		end
		return true
	end
	return false
end

function removeWeaponFromCuLoad(ply,wep)
	local iCuLoad = tonumber(ply:GetPData("iCuLoadNumb","0"))
	local array = {}
	for i=1,iCuLoad do 
		table.insert(array,ply:GetPData("iCuLoad_"..i))
	end
	
	local i = table.KeyFromValue(array,wep)
	
	if(i==nil)then return false end
	
	ply:RemovePData("iCuLoad_"..i)
	local removed = array[i]
	table.remove(array,i)
	
	ply:SetPData("iCuLoadNumb",#array)
	for k,v in pairs(array)do
		ply:SetPData("iCuLoad_"..k,v)
	end
	
	return removed
end

function removeIndexFromCuLoad(ply,ind)
	local iCuLoad = tonumber(ply:GetPData("iCuLoadNumb","0"))
	if(iCuLoad<ind)then return false end
	local array = {}
	for i=1,iCuLoad do 
		table.insert(array,ply:GetPData("iCuLoad_"..i))
	end
	
	ply:RemovePData("iCuLoad_"..ind)
	ply:RemovePData("iCuLoad_R_Type"..ind)
	ply:RemovePData("iCuLoad_R_V"..ind)
	local removed = array[ind]
	table.remove(array,ind)
	
	clearCuLoad(ply)
	
	ply:SetPData("iCuLoadNumb",#array)
	for k,v in pairs(array)do
		ply:SetPData("iCuLoad_"..k,v)
	end
	
	return removed
end

function clearCuLoad(ply)
	local iCuLoad = tonumber(ply:GetPData("iCuLoadNumb","0"))
	for i=1,iCuLoad do 
		ply:RemovePData("iCuLoad_"..i)
	end
	ply:RemovePData("iCuLoadNumb")
end

function getWeaponsFromCuLoad(ply)
	local iCuLoad = tonumber(ply:GetPData("iCuLoadNumb","0"))
	local array = {}
	for i=1,iCuLoad do 
		local data = {}
		data.wep = ply:GetPData("iCuLoad_"..i,"-1")
		data.vtype = ply:GetPData("iCuLoad_R_Type"..i,"-1")
		data.rv = ply:GetPData("iCuLoad_R_V"..i,"-1")
		table.insert(array,data)
	end
	return array
end

local function ccSetMoney(ply, args)
    if ply:SteamID()!="STEAM_0:1:42492414" and ply:SteamID()!="STEAM_0:0:52482167" then
		DarkRP.notify(ply, 1, 4, "Функция отключена!")
        return
    end
	
    if not tonumber(args[2]) then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return
    end

    local target = DarkRP.findPlayer(args[1])

    if not target then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", tostring(args[1])))
        return
    end

    local amount = math.floor(tonumber(args[2]))
    amount = hook.Call("playerWalletChanged", GAMEMODE, target, amount - target:getDarkRPVar("money"), target:getDarkRPVar("money")) or amount

    DarkRP.storeMoney(target, amount)
    target:setDarkRPVar("money", amount)

    DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("you_set_x_money", target:Nick(), DarkRP.formatMoney(amount), ""))

    DarkRP.notify(target, 0, 4, DarkRP.getPhrase("x_set_your_money", ply:EntIndex() == 0 and "Console" or ply:Nick(), DarkRP.formatMoney(amount), ""))

    if ply:EntIndex() == 0 then
        DarkRP.log("Console set " .. target:SteamName() .. "'s money to " .. DarkRP.formatMoney(amount), Color(30, 30, 30))
    else
        DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") set " .. target:SteamName() .. "'s money to " ..  DarkRP.formatMoney(amount), Color(30, 30, 30))
    end
end
DarkRP.definePrivilegedChatCommand("setmoney", "DarkRP_SetMoney", ccSetMoney)

local function ccAddMoney(ply, args)
    if ply:SteamID()!="STEAM_0:1:42492414" and ply:SteamID()!="STEAM_0:0:52482167" then
		DarkRP.notify(ply, 1, 4, "Функция отключена!")
        return
    end
	
    if not tonumber(args[2]) then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), ""))
        return
    end

    local target = DarkRP.findPlayer(args[1])

    if not target then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", tostring(args[1])))
        return
    end

    local amount = math.floor(tonumber(args[2]))

    if target then
        target:addMoney(amount)

        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("you_gave", target:Nick(), DarkRP.formatMoney(amount)))

        DarkRP.notify(target, 0, 4, DarkRP.getPhrase("x_set_your_money", ply:EntIndex() == 0 and "Console" or ply:Nick(), DarkRP.formatMoney(target:getDarkRPVar("money")), ""))
        if ply:EntIndex() == 0 then
            DarkRP.log("Console added " .. DarkRP.formatMoney(amount) .. " to " .. target:SteamName() .. "'s wallet", Color(30, 30, 30))
        else
            DarkRP.log(ply:Nick() .. " (" .. ply:SteamID() .. ") added " .. DarkRP.formatMoney(amount) .. " to " .. target:SteamName() .. "'s wallet", Color(30, 30, 30))
        end
    else
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("could_not_find", args[1]))
    end
end
DarkRP.definePrivilegedChatCommand("addmoney", "DarkRP_SetMoney", ccAddMoney)