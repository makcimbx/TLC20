AddCSLuaFile("afk_config.lua")
AddCSLuaFile("../client/cl_afkmanager.lua")

include('afk_config.lua')

local afkPlayers = {}
local time = CurTime()

util.AddNetworkString("GivePlayerAFKWarning")
util.AddNetworkString("RemovePlayerAFKWarning")

hook.Add("PlayerAuthed","Add players to the table",function(ply,SID,UID)
	ply.uID = UID
	ply.lastMoved = CurTime()
	afkPlayers[ply.uID] = ply
	ply.hasBeenWarned = false
end)

hook.Add("PlayerDisconnect","Remove players from the table",function(ply)
	if(IsValid(ply.uID)) then
		afkPlayers[ply.uID] = nil
	end
end)

hook.Add("KeyPress","updatePlayerLastMoved",function(ply,key)

	if(IsValid(afkPlayers[ply.uID]))then
		ply.lastMoved=CurTime()
		if(ply.hasBeenWarned==true)then
			ply.hasBeenWarned = false
			removeAFKWarning(ply)
		end
	end

end)

function giveAFKWarning(ply)
	net.Start("GivePlayerAFKWarning")
	net.Send(ply)
	ply.hasBeenWarned=true
	return
end

function removeAFKWarning(ply)
	net.Start("RemovePlayerAFKWarning")
	net.Send(ply)
	ply.hasBeenWarned=false
	return
end

hook.Add("Think","checkForAfkPlayers",function()
	if(time<=CurTime())then
		if(table.Count(afkPlayers)>0)then
			for k,v in pairs(afkPlayers) do
				if(v.lastMoved!=nil) then
					if((v.lastMoved+(AFKCONFIG.kickTime*60))-CurTime()<0)then
						local id = v.uID
						if(AFKCONFIG.souldKickAdmins==false)then
							if(v:IsAdmin()==false)then
								afkPlayers[id]:Kick(AFKCONFIG.kickReason)
								afkPlayers[id] = nil
							end
						else
							afkPlayers[id]:Kick(AFKCONFIG.kickReason)
							afkPlayers[id] = nil
						end
					elseif((v.lastMoved+(AFKCONFIG.warnTime*60))-CurTime()<0)then
						if(v.hasBeenWarned==false)then
							giveAFKWarning(v)
						end
					end
				end
			end
		end
		time=CurTime()+1
	end
end)
