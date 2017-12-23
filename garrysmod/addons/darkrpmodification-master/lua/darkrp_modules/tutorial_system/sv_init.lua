util.AddNetworkString( "StartTest" )
util.AddNetworkString( "sendtrain" )
util.AddNetworkString( "gettrain" )
util.AddNetworkString( "offertest" )
util.AddNetworkString( "startEvertest" )

TrainPlayer = {}


local function AutoTrain(ply)
	ply:SendLua("GlideStart()")
end

function GM:PlayerDisconnected( ply )
	table.RemoveByValue( TrainPlayer, ply )
end

timer.Create( "TrainPlayerCheck", 3, 0,function()
	for k,v in pairs(TrainPlayer)do
		if(IsValid(v))then
			if(v.pause == false)then
				v.tm = v.tm - 3
				if(v.tm<=0)then
					v.ply.train_wait = false
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
		ply.train_wait=false
		ply.sempai = ply.presempai
		ply:SetNWEntity( "sempai", ply.presempai )
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.GREEN," принял предложение!");
	else
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.RED," отклонил предложение!");
		ply.pause = false
		ply.presempai = false
	end
end)


net.Receive("startEvertest",function(len,ply)
	local d = net.ReadBool()
	
	if(d == true)then
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.GREEN," начал тест!");
		rt_startq(ply)
	else
		serverguard.Notify(ply.presempai, SERVERGUARD.NOTIFY.RED,ply:Name(),SERVERGUARD.NOTIFY.RED," отклонил тест!");
	end
end)

