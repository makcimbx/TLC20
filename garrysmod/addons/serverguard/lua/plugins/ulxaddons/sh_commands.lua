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
	local model = tostring(arguments[#arguments])
	table.remove(arguments,#arguments)
	
	if model == -1 then return	end
	
	local setmdl = function (v) v:SetModel(model) end
	
	Simpliest(player,arguments,setmdl,true,silent,"выдал модель")
	

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
	local scale = tonumber(arguments[#arguments])
	table.remove(arguments,#arguments)
	
	if scale == nil then return	end
	
	local scaling = function (v) 
		v.CLEANUPKITScale = scale
		v.CLEANUPKITViewOffset = v.CLEANUPKITViewOffset or v:GetViewOffset()
		v.CLEANUPKITViewOffsetDucked =v.CLEANUPKITViewOffsetDucked or v:GetViewOffsetDucked()
		
		v:SetViewOffset(v.CLEANUPKITViewOffset*scale)
		v:SetViewOffsetDucked(v.CLEANUPKITViewOffsetDucked*scale)
		v:SetModelScale(scale,0) 
	end
	Simpliest(player,arguments,scaling,true,silent,"установил высоту")

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

	local reconect = function (v) v:SendLua([[RunConsoleCommand("retry")]]) end
	Simpliest(player,arguments,reconect,false,silent,"ВЫДАЛ РЕКОННЕКТ")

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

	local rockeet = function (v) RocketPlayers[v] = true end

	Simpliest(player,arguments,rockeet,true,silent,"взорвал пердак")

end
plugin:AddCommand(command)

function Simpliest(ply,arguments,func,needAlive,silent,msg)
	if(#arguments>1)then
		local affected_plys = {}
		for k,v in pairs(arguments)do
			v = util.FindPlayer(v, ply)
			if (IsValid(v))then
				if v.DarkRPUnInitialized then
					serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED, v:Name().." is not yet initialized.")
				else
					if(needAlive)then
						if v:Alive() then
							func(v)
							table.insert( affected_plys, v:Name() )
						end
					else
						func(v)
						table.insert( affected_plys, v:Name() )
					end
				end
			end
		end
		if (not silent) and #affected_plys!=0 then
			serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(ply), SERVERGUARD.NOTIFY.WHITE, " "..msg.." ", SERVERGUARD.NOTIFY.RED, "["..table.concat( affected_plys, ", " ).."]")
		end
	else
		if(#arguments==1)then
			if arguments[1] != "*" then 
				if arguments[1] != "^" then 
					local affected_ply = ""
					local v = util.FindPlayer(arguments[1], ply)
					if (IsValid(v))then
						if v.DarkRPUnInitialized then
							serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED, v:Name().." is not yet initialized.")
						else
							if(needAlive)then
								if v:Alive() then
									func(v)
									affected_ply = v:Name()
								end
							else
								func(v)
								affected_ply = v:Name()
							end
						end
					end
					if (not silent) and affected_ply!="" then
						serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(ply), SERVERGUARD.NOTIFY.WHITE, " "..msg.." ", SERVERGUARD.NOTIFY.RED, affected_ply)
					end
				else
					local affected_ply = ""
					local v = ply
					if (IsValid(v))then
						if v.DarkRPUnInitialized then
							serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED, v:Name().." is not yet initialized.")
						else
							if(needAlive)then
								if v:Alive() then
									func(v)
									affected_ply = v:Name()
								end
							else
								func(v)
								affected_ply = v:Name()
							end
						end
					end
					if (not silent) and affected_ply!="" then
						serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(ply), SERVERGUARD.NOTIFY.WHITE, " "..msg.." ", SERVERGUARD.NOTIFY.RED, affected_ply)
					end
				end
			else
				local affected_plys = {}
				for k,v in pairs(player.GetAll())do
					func(v)
					table.insert( affected_plys, v:Name() )
				end
				if (not silent) and #affected_plys!=0 then
					serverguard.Notify(nil, SERVERGUARD.NOTIFY.GREEN, serverguard.player:GetName(ply), SERVERGUARD.NOTIFY.WHITE, " "..msg.." ", SERVERGUARD.NOTIFY.RED, "["..table.concat( affected_plys, ", " ).."]")
				end
			end
		end
	end
end
