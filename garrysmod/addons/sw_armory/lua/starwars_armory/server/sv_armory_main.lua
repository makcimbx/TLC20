
util.AddNetworkString("Armory_SyncWeapons")
util.AddNetworkString("Armory_BuyWeapons")
util.AddNetworkString("Armory_DeployWeapons")
util.AddNetworkString("Armory_OpenMenu")


function SArmory.Action.DeployWeapon(Player, strWeapon)
	if not Player then return end
	if not strWeapon then SArmory.Action.FatalError() return end
	if Player:HasWeapon(strWeapon) then return end
	
	local data = SArmory.Database[strWeapon]
	if not data then MsgN("no data for weapon") return end

	--[[ Check Usergroup Table ]]--
	if data.Usergroup and not table.HasValue(data.Usergroup, Player:GetUserGroup()) then 
		SArmory.Action.Notify(Player, "You are not the required group to deploy this weapon!")
		return 
	end
	
	--[[ Check Team Table (bool ]]--
	if data.Job then
		local jobs = SArmory.Database[strWeapon].Job
		local found = false
		
		for k,v in pairs(jobs) do
			if v == Player:Team() then
				found = true
			end
		end
		
		if (found == false) then
			SArmory.Action.Notify(Player, "You are not the required team to deploy this weapon!")
			return
		end
	end
	
	--[[ Check Deployment Costs]]--
	if data.DeployCost then
		if not Player:canAfford(data.DeployCost) then
			SArmory.Action.Notify(Player, "You do not have the money to deploy this weapon!")
			return 
		else
			Player:addMoney(-data.DeployCost)
		end
	end
	
	Player:Give(strWeapon)
	Player:SetActiveWeapon(strWeapon)
	
end

function SArmory.Action.Notify(Player, strMessage)
	if SArmory.Config.Notify == "darkrp" then
		DarkRP.notify(Player, 1, 5, tostring(strMessage))
	else
		Player:PrintMessage(HUD_PRINTTALK, strMessage)
	end
end


function SArmory.Action.ArmorySaveData(Player)
	file.Write("armory/armory_"..Player:SteamID64()..".txt", util.TableToJSON(Player.ArmoryWeapons))

	SArmory.Action.SyncData(Player)
end


function SArmory.Action.connectDatabase()
	if !file.Exists("armory", "DATA") then
		file.CreateDir( "armory" )
	end
	
	if file.Exists("armory_spawns.txt", "DATA" ) then
		local tbl = file.Read("armory_spawns.txt", "DATA")
		ArmorySpawnVector = util.JSONToTable(tbl)
	else
		ArmorySpawnVector = {}
		file.Write("armory_spawns.txt", util.TableToJSON(ArmorySpawnVector))
	end
	
	SArmory.Action.SpawnNPCs()
end
hook.Add( "Initialize", "SArmory.Action.connectDatabase()", SArmory.Action.connectDatabase)


hook.Add("PlayerInitialSpawn", "Armory_InitalSpawn", function(Player)
	timer.Simple(1, function()
		if file.Exists("armory/armory_"..Player:SteamID64()..".txt", "DATA" ) then
			local tbl = file.Read("armory/armory_"..Player:SteamID64()..".txt", "DATA") 
			Player.ArmoryWeapons = util.JSONToTable(tbl)
			SArmory.Action.SyncData(Player)
		else
			Player.ArmoryWeapons = {}
			file.Write("armory/armory_"..Player:SteamID64()..".txt", util.TableToJSON(Player.ArmoryWeapons))
		end
	end)
end)


local pmeta = FindMetaTable("Player")
function pmeta:HasOwnedWeapon(strWep)
	local bool = false
	
	if self.ArmoryWeapons[strWep] then
		bool = true
	end

	return bool
end

function SArmory.Action.PurchaseWeapon(Player, strWep)

	if Player:HasOwnedWeapon(tostring(strWep)) then 
		SArmory.Action.Notify(Player, "У вас уже есть данное оружие!")
		return 
	end
	
	local data = SArmory.Database[strWep]
	
	if (Player:canAfford(data.Price) == false) then
		SArmory.Action.Notify(Player, "Вы не можете позволить себе это оружие!")
		return
	end
	
	if data.Usergroup and not table.HasValue(data.Usergroup, Player:GetUserGroup()) then 
		SArmory.Action.Notify(Player, "Данное оружие только для донатеров. Мир несправедлив :(")
		return 
	end
	
	if SArmory.Database[strWep].Job then
		local jobs = SArmory.Database[strWep].Job
		local found = false
		
		for k,v in pairs(jobs) do
			if v == Player:Team() then
				found = true
			end
		end
		
		if (found == false) then
			SArmory.Action.Notify(Player, "У вас нет доступа к этому оружию. Видимо оно не подходит для вашей работы.")
			return
		end
	end
	
	Player.ArmoryWeapons[strWep] = true
	Player:addMoney(-data.Price)
	Player:PrintMessage(HUD_PRINTTALK, "Успешная покупка оружия!")
	
	timer.Simple(0.1, function()
		SArmory.Action.ArmorySaveData(Player)
	end)
end

function SArmory.Action.CreateSpawnPoint(Player, mdl)
	if not IsValid(Player) then return end
	
	if not mdl then mdl = "models/cw_furniture19/cw_furniture19.mdl" end
	
	local pos = Player:GetPos()
	local ang = Player:GetAngles()
	local mdl = mdl or "models/cw_furniture19/cw_furniture19.mdll"
	
	local tbl = {vec = pos, ang = ang, model = mdl}
	
	if not ArmorySpawnVector[game.GetMap()] then
		ArmorySpawnVector[game.GetMap()] = {}
	end
	
	table.insert(ArmorySpawnVector[game.GetMap()], tbl)
	
	file.Write( "armory_spawns.txt", util.TableToJSON(ArmorySpawnVector))
	
	local ents = ents.Create("starwars_armor")
	ents:SetPos(pos)
	ents:SetAngles(ang)
	ents:SetModel(mdl)
	ents:Spawn()
	ents:Activate()
end

function SArmory.Action.CMD_Spawn(ply, cmd, args)
	if not IsValid(ply) then return end
	
	if not table.HasValue(SArmory.Config.CMD_UserGroups, ply:GetUserGroup() ) then return end
	
	local mdl = args[1]
	
	SArmory.Action.CreateSpawnPoint(ply, mdl)
end
concommand.Add("sw_addnpc", SArmory.Action.CMD_Spawn)

function SArmory.Action.SpawnNPCs()
	timer.Simple(3, function()
	
		if not file.Exists("armory_spawns.txt", "DATA") then MsgN("[ARMORY] No spawns have been set!") return end
		
		local tbl = file.Read("armory_spawns.txt", "DATA")
		local tbl2 = util.JSONToTable(tbl)
		
		if not tbl2[game.GetMap()] then
			MsgN('Armory: No spawns for this map!')
			return
		end
		
		for k,v in pairs(tbl2[game.GetMap()]) do
			local ents = ents.Create("starwars_armor")
			ents:SetPos(Vector(v.vec.x, v.vec.y, v.vec.z))
			ents:SetAngles(Angle(v.ang.p,v.ang.y,v.ang.r))
			ents:SetModel(v.model)
			ents:Spawn()
			ents:Activate()
		end
	end)
end

function SArmory.Action.CMD_RemoveSpawn(Player)
	if not IsValid(Player) then return end
	if not table.HasValue(SArmory.Config.CMD_UserGroups, Player:GetUserGroup() ) then return end
	
	
	local trace = Player:GetEyeTrace()
	
	if trace.Entity and trace.Entity:GetClass() == "starwars_armor" then
		local pos = trace.Entity:GetPos()
		local ent = trace.Entity

		local counter = 1
		for k,v in pairs(ArmorySpawnVector[game.GetMap()]) do
			if v.vec == pos then
				v = nil
				SArmory.Action.SaveSpawns()
				ent:Remove()
			end
		end
	end
end
concommand.Add("sw_removenpc", SArmory.Action.CMD_RemoveSpawn)

function SArmory.Action.SaveSpawns()
	if not ArmorySpawnVector then return end
	file.Write( "armory_spawns.txt", util.TableToJSON(ArmorySpawnVector))
end