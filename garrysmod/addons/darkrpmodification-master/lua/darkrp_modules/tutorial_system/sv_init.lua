util.AddNetworkString( "StartTest" )
util.AddNetworkString( "sendtrain" )
util.AddNetworkString( "gettrain" )
util.AddNetworkString( "offertest" )
util.AddNetworkString( "startEvertest" )

TrainPlayer = {}


local function AutoTrain(ply)
	net.Start("offertest")
	net.Send(ply)
end

function GM:PlayerDisconnected( ply )
	table.RemoveByValue( TrainPlayer, ply )
end

timer.Create( "TrainPlayerCheck2", 40, 0,function()
	local p = #TrainPlayer
	if(p!=0)then
		local i = "игроков"
		local i2 = "ждут"
		if(p==1)then i="игрок" i2 = "ждёт" else if(p>1 and not #TrainPlayer>4)then i = "игрока" i2 = "ждёт" end end
		serverguard.Notify(nil, SERVERGUARD.NOTIFY.WHITE, "[TRAIN] " , SERVERGUARD.NOTIFY.RED, p.."", SERVERGUARD.NOTIFY.WHITE, " "..i.." "..i2.." обучения");
	end
end)

timer.Create( "TrainPlayerCheck", 3, 0,function()
	for k,v in pairs(TrainPlayer)do
		if(IsValid(v.ply))then
			if(v.pause != true)then
				v.tm = v.tm - 3
				if(v.tm<=0)then
					v.ply.train_wait = nil
					v.ply:SetNWEntity( "train_wait", nil )
					if(IsValid(v.ply))then
						AutoTrain(v.ply)
					end
					table.remove( TrainPlayer, k )
				end
			end
		else
			table.remove( TrainPlayer, k )
		end
	end
end )

net.Receive("gettrain",function(len,ply)
	local d = net.ReadBool()
	
	if(d == true)then
		table.RemoveByValue( TrainPlayer, ply )
		ply.train_wait=nil
		target:SendLua("StopTTimer()")
		ply:SetNWBool( "train_wait", false )
		ply.sempai = ply.presempai
		ply:SetNWEntity( "sempai", ply.presempai )
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.GREEN," принял предложение!");
	else
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.RED," отклонил предложение!");
		ply.pause = false
		ply.presempai = nil
		target:SendLua("UnPauseTTimer()")
	end
end)


net.Receive("startEvertest",function(len,ply)
	local d = net.ReadBool()
	
	if(IsValid(ply.presempai))then
		if(d == true)then
			serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.GREEN," начал тест!");
			rt_startq(ply)
		else
			serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.RED," отклонил тест!");
		end
	else
		if(d == true)then
			ply:SendLua("GlideStart()")
			ply:SendLua("StopTTimer()")
		else
			serverguard.Notify(ply,SERVERGUARD.NOTIFY.WHITE,"Ждите в течении", SERVERGUARD.NOTIFY.GREEN," 5 минут",SERVERGUARD.NOTIFY.WHITE," прибытия",SERVERGUARD.NOTIFY.RED," инструктора",SERVERGUARD.NOTIFY.WHITE,", либо вам будет предложено",SERVERGUARD.NOTIFY.RED,SERVERGUARD.NOTIFY.WHITE, " автоматическое обучение.");
  
			ply.pause = false
			table.insert(TrainPlayer,{ply = ply,tm = 300})
			ply.train_wait = true
			ply:SetNWBool( "train_wait", true )
			ply:SendLua("StartTTimer()")
		end
	end
end)

