local plugin = plugin

local command = {}
command.help = "Ставит модель игроку."
command.command = "model"
command.arguments = {"player", "model"}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"model"}
command.permissions = {"Set Model"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	local model = tostring(arguments[2])
	
	if model == -1 then return	end
	
	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		target:SetModel(model)
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " выдал  ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, " модель.")
		end
	end
end
plugin:AddCommand(command)


command = {}
command.help = "Scale player."
command.command = "scale"
command.arguments = {"player", "scale"}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"scale"}
command.permissions = {"Set Scale"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)
	local scale = tonumber(arguments[2])
	local affected_plys = {}
	
	if scale == -1 then return	end
	
	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		target.CLEANUPKITScale = scale
		target.CLEANUPKITViewOffset = target.CLEANUPKITViewOffset or target:GetViewOffset()
		target.CLEANUPKITViewOffsetDucked =target.CLEANUPKITViewOffsetDucked or target:GetViewOffsetDucked()
		
		target:SetViewOffset(target.CLEANUPKITViewOffset*scale)
		target:SetViewOffsetDucked(target.CLEANUPKITViewOffsetDucked*scale)
		target:SetModelScale(scale,0)
		table.insert( affected_plys, target )
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " установил  ", SERVERGUARD.NOTIFY.RED, target:Name(), SERVERGUARD.NOTIFY.WHITE, " высоту.")
		end
	end
end
plugin:AddCommand(command)

command = {}
command.help = "Останавливает звуки на сервере."
command.command = "stopsound"
command.arguments = {}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"stopsound"}
command.permissions = {"Stop Sounds on server"}
function command:Execute(player, silent, arguments)

	    for k,v in pairs(v.GetAll()) do
		    v:SendLua([[RunConsoleCommand("stopsound")]])
	    end
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " остановил все звуки")
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

command = {}
command.help = "РЕКОННЕКТ."
command.command = "reconnect"
command.arguments = {"player"}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"reconnect"}
command.permissions = {"RECONNECT"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)

	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		target:SendLua([[RunConsoleCommand("retry")]])
		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " ВЫДАЛ РЕКОННЕКТ  ", SERVERGUARD.NOTIFY.RED, target:Name())
		end
	end
end
plugin:AddCommand(command)


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


command = {}
command.help = "Взрывает пердак у игрока."
command.command = "rocket"
command.arguments = {"player"}
command.bDisallowConsole = false
command.bSingleTarget = false
command.immunity = SERVERGUARD.IMMUNITY.LESSEQUAL
command.aliases = {"rocket"}
command.permissions = {"Rocket"}
function command:Execute(player, silent, arguments)
	local target = util.FindPlayer(arguments[1], player)

	if (IsValid(target)) then
		if target.DarkRPUnInitialized then
			serverguard.Notify(player, SERVERGUARD.NOTIFY.RED, "Player is not yet initialized.")
			return
		end
		
		local affected_plys = {}

		local v = target[ i ]
		if v:Alive() then
			RocketPlayers[v] = true
			table.insert( affected_plys, v )
		end

		
		if not silent then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(player), SERVERGUARD.NOTIFY.WHITE, " взорвал пердак у  ", SERVERGUARD.NOTIFY.RED, target:Name())
		end
	end
end
plugin:AddCommand(command)

