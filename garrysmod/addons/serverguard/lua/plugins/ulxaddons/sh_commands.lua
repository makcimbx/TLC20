local plugin = plugin

local command = {};
command.help		= "Set a player's model.";
command.command 	= "model";
command.arguments	= {"player", "model"};
command.permissions	= "Set Model";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"setmodel", "model"};

function command:OnPlayerExecute(_, target, arguments)
	local model = arguments[2];
	
	if(util.IsValidModel( model )) then
		target:SetModel(model)
	end

	return true;
end;

function command:OnNotify(pPlayer, targets, arguments)
	local model = arguments[2];
	
	if(util.IsValidModel( model )) then
		return SGPF("command_model", serverguard.player:GetName(pPlayer), util.GetNotifyListForTargets(targets, true), model);
	else
		return unpack({SERVERGUARD.NOTIFY.RED, "Wrong model!"});
	end
end;

serverguard.phrase:Add("english", "command_model", {
	SERVERGUARD.NOTIFY.GREEN, "%s", SERVERGUARD.NOTIFY.WHITE, " has set ", SERVERGUARD.NOTIFY.RED, "%s", SERVERGUARD.NOTIFY.WHITE, " model to ",
	SERVERGUARD.NOTIFY.GREEN, "%s",
});
serverguard.command:Add(command);


command = {};
command.help		= "Scale model.";
command.command 	= "scale";
command.arguments	= {"player", "scale"};
command.permissions	= "Set scale"; 
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"setscale", "scale"};

function command:OnPlayerExecute(_, target, arguments)
	local scale = tonumber(arguments[2])
	
	if(scale>0) then
		target.CLEANUPKITScale = scale
		target.CLEANUPKITViewOffset = target.CLEANUPKITViewOffset or target:GetViewOffset()
		target.CLEANUPKITViewOffsetDucked =target.CLEANUPKITViewOffsetDucked or target:GetViewOffsetDucked()
		
		target:SetViewOffset(target.CLEANUPKITViewOffset*scale)
		target:SetViewOffsetDucked(target.CLEANUPKITViewOffsetDucked*scale)
		target:SetHull(Vector(-16, -16, 0), Vector(16, 16, 72 * scale))
		target:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 36 * scale))
		target:SetModelScale(scale,0)
		net.Start("ever_scale")
			net.WriteEntity(target)
			net.WriteString(scale)
		net.Broadcast()
	end

	return true;
end;

function command:OnNotify(pPlayer, targets, arguments)
	local scale = tonumber(arguments[2])
	
	if(scale>0) then
		return SGPF("command_scale", serverguard.player:GetName(pPlayer), util.GetNotifyListForTargets(targets, true), scale);
	else
		return unpack({SERVERGUARD.NOTIFY.RED, "Wrong scale!"});
	end
end;

serverguard.phrase:Add("english", "command_scale", {
	SERVERGUARD.NOTIFY.GREEN, "%s", SERVERGUARD.NOTIFY.WHITE, " has set ", SERVERGUARD.NOTIFY.RED, "%s", SERVERGUARD.NOTIFY.WHITE, " scale to ",
	SERVERGUARD.NOTIFY.GREEN, "%d",
});
serverguard.command:Add(command);


command = {}
command.help = "Останавливает звуки на сервере."
command.command = "stopsound"
command.arguments = {}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"stopsound"}
command.permissions = {"Stop Sounds on server"}
function command:Execute(ply, silent, arguments)

	    for k,v in pairs(player.GetAll()) do
		    v:SendLua([[RunConsoleCommand("stopsound")]])
	    end
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(ply), SERVERGUARD.NOTIFY.WHITE, " остановил все звуки")
		end
end
plugin:AddCommand(command)


command = {}
command.help = "Фризит пропы на сервере."
command.command = "nolag"
command.arguments = {}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"nolag"}
command.permissions = {"Freeze props on server"}
function command:Execute(player, silent, arguments)
	    for k,v in pairs(ents.FindByClass("prop_physics")) do
		     v:GetPhysicsObject():EnableMotion(false)
	    end
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " зафризил все пропы")
		end
end
plugin:AddCommand(command)


command = {};
command.help		= "RECONNECT PLAYER.";
command.command 	= "reconnect";
command.arguments	= {"player"};
command.permissions	= "reconnect";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"reconnect"};

function command:OnPlayerExecute(_, target, arguments)
	
	target:SendLua([[RunConsoleCommand("retry")]])

	return true;
end;

function command:OnNotify(pPlayer, targets, arguments)
	return SGPF("command_reconnect", serverguard.player:GetName(pPlayer), util.GetNotifyListForTargets(targets, true));
end;

serverguard.phrase:Add("english", "command_reconnect", {
	SERVERGUARD.NOTIFY.GREEN, "%s", SERVERGUARD.NOTIFY.WHITE, " has reconnect ", SERVERGUARD.NOTIFY.RED, "%s"
});
serverguard.command:Add(command);


local RocketPlayers = {}
if SERVER then
	hook.Add("Think","CLEANUPKIT.RocketThink",function()
		for k,v in pairs(RocketPlayers) do
			if not (IsValid(k) and k:Alive()) then RocketPlayers[k] = nil end
			k:SetVelocity(Vector(0,0,5000))
			local tr = {}
			local eye = k:EyePos()
			tr.start = eye
			tr.endpos = eye + Vector(0,0,20)
			tr.filter = k
			local trace = util.TraceLine(tr)
			if trace.Hit then
				k:Kill()
				local vPoint = k:GetPos()
				local effectdata = EffectData()
				effectdata:SetStart(vPoint)
				effectdata:SetOrigin(vPoint)
				effectdata:SetScale(1)
				util.Effect("Explosion", effectdata)
			end
		end
	end)
end


command = {};
command.help		= "Rocket player.";
command.command 	= "rocket";
command.arguments	= {"player"};
command.permissions	= "Rocket";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"rocket"};

function command:OnPlayerExecute(_, target, arguments)

	RocketPlayers[target] = true

	return true;
end;

function command:OnNotify(pPlayer, targets, arguments)
	return SGPF("command_rocket", serverguard.player:GetName(pPlayer), util.GetNotifyListForTargets(targets, true));
end;

serverguard.phrase:Add("english", "command_rocket", {
	SERVERGUARD.NOTIFY.GREEN, "%s", SERVERGUARD.NOTIFY.WHITE, " has rocket ", SERVERGUARD.NOTIFY.RED, "%s"
});
serverguard.command:Add(command);


command = {};
command.help		= "Add weapon to player loadout.";
command.command 	= "cuload_add";
command.arguments	= {"player", "weapon"};
command.permissions	= "culoadadd";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"cuload_add"};
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)
	local weapon = arguments[2];
	
	if(util.IsValidWeapon(weapon))then
		local addw = addWeaponToCuLoad(target,weapon)
	
		if(addw==false)then
			serverguard.Notify(_, SERVERGUARD.NOTIFY.RED,target:Name(),SERVERGUARD.NOTIFY.WHITE," have ",SERVERGUARD.NOTIFY.RED,weapon,SERVERGUARD.NOTIFY.WHITE," in cuload!");
		else
			serverguard.Notify(_, SERVERGUARD.NOTIFY.WHITE, "Added ", SERVERGUARD.NOTIFY.RED,weapon, SERVERGUARD.NOTIFY.WHITE, " to ",SERVERGUARD.NOTIFY.GREEN, target:Name())
			print("CULOAD ".._:SteamID().." add "..weapon.." "..target:SteamID())
		end
	else
		serverguard.Notify(_, SERVERGUARD.NOTIFY.RED,weapon,SERVERGUARD.NOTIFY.WHITE," doesnt exist!");
	end
	
	return true
end
serverguard.command:Add(command);


command = {};
command.help		= "Remove weapon from player loadout.";
command.command 	= "cuload_remove";
command.arguments	= {"player", "weapon"};
command.permissions	= "culoadremove";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"cuload_remove"};
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)
	local weapon = arguments[2];
	
	local remw = removeWeaponFromCuLoad(target,weapon)
	
	if(remw != false)then
		serverguard.Notify(_,SERVERGUARD.NOTIFY.WHITE, "Removed ", SERVERGUARD.NOTIFY.GREEN, weapon, SERVERGUARD.NOTIFY.WHITE, " from ",SERVERGUARD.NOTIFY.RED,target:Name());
		print("CULOAD ".._:SteamID().." remove "..weapon.." "..target:SteamID())
	else
		serverguard.Notify(_, SERVERGUARD.NOTIFY.RED,target:Name(),SERVERGUARD.NOTIFY.WHITE," dont have this weapon in cuload!");
	end
	
	return true;
end;
serverguard.command:Add(command);


command = {};
command.help		= "Get player cuload list.";
command.command 	= "cuload_list";
command.arguments	= {"player"};
command.permissions	= "culoadget";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"cuload_list"};
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)
	printCuLoad(_,target)
	serverguard.Notify(_, SERVERGUARD.NOTIFY.RED,target:Name(),SERVERGUARD.NOTIFY.WHITE," loadout list printed in console!");
	return true;
end;
serverguard.command:Add(command);

command = {};
command.help		= "Remove weapon from player loadout by index.";
command.command 	= "cuload_remove_i";
command.arguments	= {"player", "weapon"};
command.permissions	= "culoadremovei";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.aliases		= {"cuload_remove_i"};
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)
	local weapon = tonumber(arguments[2]);
	
	if(weapon > 0) then
		local remw = removeIndexFromCuLoad(target,weapon)
		
		if(remw != false)then
			serverguard.Notify(_, SERVERGUARD.NOTIFY.WHITE, "Removed ", SERVERGUARD.NOTIFY.GREEN, remw, SERVERGUARD.NOTIFY.WHITE, " from ",SERVERGUARD.NOTIFY.RED,target:Name());
			print("CULOAD ".._:SteamID().." remove "..weapon.." "..target:SteamID())
		else
			serverguard.Notify(_, SERVERGUARD.NOTIFY.RED,target:Name(),SERVERGUARD.NOTIFY.WHITE," dont have this weapon in cuload!");
		end
	end

	return true;
end;
serverguard.command:Add(command);


local command = {};

command.help				= "Send a player to where you're looking, or to another player.";
command.command 			= "teleport";--send
command.arguments			= {"player"};
command.permissions			= "Send";
command.bDisallowConsole	= true;

function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	
	if (IsValid(target)) then
		if (!serverguard.player:HasBetterImmunity(player, serverguard.player:GetImmunity(target))) then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "This player has a higher immunity than you.");
			return;
		end;

		if (not target:Alive()) then
			target:Spawn();
		end

		target.sg_LastPosition = target:GetPos();
		target.sg_LastAngles = target:EyeAngles();

		local trace = player:GetEyeTrace();
			trace = trace.HitPos +trace.HitNormal *1.25;
		target:SetPos(trace);
		
		if (!silent) then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " has sent ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, " to their location.");
		end;
	end;
end;

function command:ContextMenu(player, menu, rankData)
	local option = menu:AddOption("Send Player", function()
		serverguard.command.Run("send", false, player:Name());
	end);
	
	option:SetImage("icon16/wand.png");
end;

serverguard.command:Add(command);


command = {};
command.help		= "Addskill.";
command.command 	= "addskill";
command.arguments	= {"player","skill count"};
command.permissions	= "addskill";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)

	local count = tonumber(arguments[2])

	target:AddSkillPoints( count )
	
	serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " добавил ",SERVERGUARD.NOTIFY.RED, count.."", SERVERGUARD.NOTIFY.WHITE, " скилл поинтов ", SERVERGUARD.NOTIFY.RED, target:Name());
	
	return true;
end;
serverguard.command:Add(command);


command = {};
command.help		= "AddSkillsReload.";
command.command 	= "addskillreload";
command.arguments	= {"player","reload points"};
command.permissions	= "addskillreload";
command.immunity 	= SERVERGUARD.IMMUNITY.LESSOREQUAL;
command.bSingleTarget = true;

function command:OnPlayerExecute(_, target, arguments)

	local count = tonumber(arguments[2])

	target:addResetPoints(count)
	
	serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " добавил ",SERVERGUARD.NOTIFY.RED, count.."", SERVERGUARD.NOTIFY.WHITE, " очков сброса навыков ", SERVERGUARD.NOTIFY.RED, target:Name());
	
	return true;
end;
serverguard.command:Add(command);