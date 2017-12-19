
util.AddNetworkString("startMission")
util.AddNetworkString("winMission")
util.AddNetworkString("stopMission")
util.AddNetworkString("sndoC")
util.AddNetworkString("createmyrace")
util.AddNetworkString("sendLastId")
util.AddNetworkString("startFiringMission")
util.AddNetworkString("stopFiringMission")

net.Receive("sendLastId", function(length, client)
	local id = net.ReadString()
	SetOfflineData( "last_npc_id", id,client:SteamID() )
end)
--RACE
--RACE
--RACE
--RACE
net.Receive("startMission", function(length, client)
	local id = net.ReadString()
	local name = net.ReadString()
	local ent = Entity(tonumber(id))
	SetOfflineData( "npc_take", "1", client:SteamID() )
	SendCreateRase(client,ent:GetQuest())
	client:SetPData("last_npc_name",name)
	client:SetPData("last_npc_id3",ent:GetQuest())
	SendInfoOnCL(client,ent)
end)

net.Receive("stopMission", function(length, client)
	local id = net.ReadString()
	local ent = Entity(tonumber(id))
	
	SetOfflineData( "npc_take", "0", client:SteamID() )
	SetOfflineData( "npc_"..ent:GetQuest().."time", "0", client:SteamID() )
	SetOfflineData( "npc_"..ent:GetQuest().."make", "0", client:SteamID() )
	RemoveRace(client)
	SendInfoOnCL(client,ent)
end)
--FIRING
--FIRING
--FIRING
--FIRING
net.Receive("startFiringMission", function(length, client)
	local id = net.ReadString()
	local name = net.ReadString()
	local hard = net.ReadString()
	local money = net.ReadString()
	local xpe = net.ReadString()
	
	local ent = Entity(tonumber(id))
	SetData( ent:GetQuest().."lastentid", id )
	SetOfflineData( "npc_take", "1", client:SteamID() ) 
	tmr(client,hard,money,xpe)
	client:SetPData("last_npc_name",name)
	client:SetPData("last_npc_id3",ent:GetQuest())
	SendInfoOnCL(client,ent)
	SetData( ent:GetQuest().."lastplid", client:SteamID() )
	SetData( ent:GetQuest().."startFirMis", "1" )
	ent.playerid = client:SteamID()
end)

function tmr(ply,hard,money,xpe)
	local spwnpos = Vector(-923.133240, 1116.051758,-427.968750)
	local fp = ents.Create( "firing_prop" )
	if ( !IsValid( fp ) ) then return end // Check whether we successfully made an entity, if not - bail
	fp:SetPos( spwnpos )
	fp.hard = tonumber(hard)
	fp.player=ply
	fp.playerid = ply:SteamID()
	fp:Spawn()
	
	SetOfflineData("frpropid",fp:EntIndex(), fp.playerid)
	local tm = 300 
	timer.Create( "msgtext21", 1, tm, function() 
		local rps = timer.RepsLeft( "msgtext21" )
		local nflr = timer.RepsLeft( "msgtext21" )/60
		local flr = math.floor(nflr)
		local m = flr
		local s = (nflr-flr)*60
		local ss = s
		local ms = m
		if(s<10)then
			ss = "0"..s
		end
		if(m<10)then
			ms = "0"..m
		end
		
		if(IsValid(fp.player))then
			DarkRP.notify(ply, 0, 1, ms..":"..ss )
		else
			StopFirMiss(GetOfflineData( "last_npc_id", fp.playerid ),fp.playerid)
		end
		if(rps==0)then
			StopFirMiss(GetOfflineData( "last_npc_id", fp.playerid ),fp.playerid,true)
			if(IsValid(fp.player))then
				StopFirMiss(GetOfflineData( "last_npc_id", fp.playerid ),fp.playerid)
				DarkRP.notify(ply, 0, 1, "Ты завалил задание! Попробуй снова!")
			end
		end
	end )
end

net.Receive("stopFiringMission", function(length, client)
	local id = net.ReadString()
	StopFirMiss(id,client)
end)

function StopFirMiss(id,client,d)
	local ent = Entity(tonumber(id))
	
	d=true
	if(d==nil)then
		d=false
	end
	if(timer.Exists( "msgtext21" ))then
		timer.Remove( "msgtext21" )
	end
	
	local ent2=Entity(tonumber(GetOfflineData( "frpropid", ent.playerid )))
	if(ent2!=nil and tostring(ent2)!="[NULL Entity]")then
		ent2:Remove()
	end
	RemoveOfflineData( "npc_take", GetData( ent:GetQuest().."lastplid" ),"0" )
	RemoveOfflineData( "npc_"..ent:GetQuest().."time", ent.playerid,"0" )
	RemoveOfflineData( "npc_"..ent:GetQuest().."make", ent.playerid,"0" )
	
	if(d)then
		SendInfoOnCL(client,ent)
	end
	RemoveData( ent:GetQuest().."startFirMis")
	
	
	--net.WriteString(client:GetPData("last_npc_id3","0"))
end
--REWARD
--REWARD
--REWARD
--REWARD
net.Receive("winMission", function(length, client)
	local id = net.ReadString()
	local ent = Entity(tonumber(id))

	
	local m = tonumber(client:GetPData("lstmoney",-1))
	local x = tonumber(client:GetPData("lstxpe",-1))
	
	if(m==-1 and x ==-1)then
		m=5000
		x=50000
		client:addMoney(m)
		client:addXP(x, true)
		DarkRP.notify(client, 0, 1, "Вы получили награду![Деньги:"..m.."][Опыт:"..x.."]")
	else
		client:addMoney(m)
		client:addXP(x, true)
		DarkRP.notify(client, 0, 1, "Вы получили награду![Деньги:"..m.."][Опыт:"..x.."]")
		client:RemovePData("lstmoney")
		client:RemovePData("lstxpe")
	end

	SetOfflineData( "npc_take", "0", client:SteamID() )
	SetOfflineData( "npc_"..ent:GetQuest().."time", os.date("%d",os.time()), client:SteamID() )
	SetOfflineData( "npc_"..ent:GetQuest().."make", "0", client:SteamID() )
	SendInfoOnCL(client,ent)
end)

function SendInfoOnCL(client,ent)
	net.Start("sndoC")
		net.WriteString(GetOfflineData( "npc_take", client:SteamID(),"0" ))
		net.WriteString(GetOfflineData( "npc_"..ent:GetQuest().."time", client:SteamID(),"0" ))
		net.WriteString(ent:GetQuest())
		net.WriteString(client:GetPData("npc_"..ent:GetQuest().."make","0"))
		net.WriteString(client:GetPData("last_npc_id3","0"))
		net.WriteString(GetData( ent:GetQuest().."startFirMis","0"))
	net.Send(client)
end 

function SendCreateRase(client,misname)
	net.Start("createmyrace")
		net.WriteString(misname)
	net.Send(client)
end

function racend(a, raceid, winner )
	winner:GetPData("npc_take","1")
	local ent = Entity(tonumber(GetOfflineData( "last_npc_id",winner:SteamID() )))
	winner:SetPData("npc_"..ent:GetQuest().."make","1")
	SendInfoOnCL(winner,ent)
	DarkRP.notify(winner, 0, 5, "Вы выполнили задание! Возвращайтесь за наградой." )
end
hook.Add( "checkpointsPlayerFinishedRace", "playerFinishedRace1", racend )