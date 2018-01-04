--RACE
--RACE
--RACE
--RACE
function StartMission(id,name)
	net.Start("startMission")
		net.WriteString(id)
		net.WriteString(name)
	net.SendToServer()
end
hook.Add( "StartMission", "SomeStartMission", StartMission )

function StopMission(id)
	net.Start("stopMission")
		net.WriteString(id)
	net.SendToServer()
end
hook.Add( "stopMission", "SomeStopMission", StopMission )
--FIRING
--FIRING
--FIRING
--FIRING
function StartFiringMission(id,name,hard,m,x)
	net.Start("startFiringMission")
		net.WriteString(id)
		net.WriteString(name)
		net.WriteString(hard)
		net.WriteString(m)
		net.WriteString(x)
	net.SendToServer()
	net.Start("sendLastId")
		net.WriteString(LocalPlayer():GetPData("last_npc_id"))
	net.SendToServer()
end
hook.Add( "StartFiringMission", "SomeStartFiringMission", StartFiringMission )

function StopFiringMission(id)
	net.Start("stopFiringMission")
		net.WriteString(id)
	net.SendToServer()
end
hook.Add( "stopFiringMission", "SomeStopFiringMission", StopFiringMission )
--REWARD
--REWARD
--REWARD
--REWARD
function getReward(id)
	net.Start("winMission")
		net.WriteString(id)
	net.SendToServer()
end
hook.Add( "getReward", "SomegetReward", getReward )
--OTHER
--OTHER
--OTHER
--OTHER
net.Receive("sndoC", function()
	local ply = LocalPlayer()
	local take = net.ReadString()
	local time = net.ReadString()
	local id = net.ReadString()
	local make = net.ReadString()
	local id3 = net.ReadString()
	local infir = net.ReadString()
	
	ply:SetPData("npc_take",take)
	ply:SetPData("npc_"..id.."time",time)
	ply:SetPData("npc_"..id.."make",make)
	ply:SetPData("last_npc_id3",id3)
	SetData( id.."startFirMis",infir)
end)

net.Receive("createmyrace", function() 
	local misname = net.ReadString()
	MakeMyRace(LocalPlayer(),misname)
	net.Start("sendLastId")
		net.WriteString(LocalPlayer():GetPData("last_npc_id"))
	net.SendToServer()
end)