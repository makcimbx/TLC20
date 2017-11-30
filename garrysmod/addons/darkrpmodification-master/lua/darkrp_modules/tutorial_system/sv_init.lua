util.AddNetworkString( "StartTest" )

local TrainPlayer = {}

local function CreateTrain(ply, args)
	if ply.train_wait or args != "" then return "" end
	if ply:GetPData("tutor_ever","0") == "1" then ply:ChatPrint("Вы уже проходили обучение!") return "" end
	
	ply:ChatPrint("Ждите в течении 5 минут до прибытия командира, либо вам будет предложено автоматическое обучение.")
 
	table.insert(TrainPlayer,{ply = ply,tm = 0})
 
	ply.train_wait = true
 
	return ""
end
DarkRP.defineChatCommand("train", CreateTrain)

local function AutoTrain(ply)
	ply:SendLua("GlideStart()")
end

timer.Create( "TrainPlayerCheck", 3, 0,function()
	for k,v in pairs(TrainPlayer)do
		v.tm = v.tm + 3
		if(v.tm>=1)then
			v.ply.train_wait = false
			if(IsValid(v.ply))then
				AutoTrain(v.ply)
			end
			table.remove( TrainPlayer, k )
		end
	end
end )

net.Receive("StartTest", function(len,ply)
	ply.Attempts = rtConfig.Attempts
	net.Start("firsttimert") net.Send( ply )
end)