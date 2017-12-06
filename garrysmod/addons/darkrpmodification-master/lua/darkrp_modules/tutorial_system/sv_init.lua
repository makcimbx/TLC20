util.AddNetworkString( "StartTest" )
util.AddNetworkString( "sendtrain" )
util.AddNetworkString( "gettrain" )
local TrainPlayer = {}

local function CreateTrain(ply, args)
	if ply.train_wait!=nil or args != "" then return "" end
	if ply:GetPData("tutor_ever","0") == "1" then ply:ChatPrint("Вы уже проходили обучение!") return "" end
	
	ply:ChatPrint("Ждите в течении 5 минут до прибытия командира, либо вам будет предложено автоматическое обучение.")
 
	target.pause = false
	table.insert(TrainPlayer,{ply = ply,tm = 5*60})
 
	ply.train_wait = #TrainPlayer
 
	return ""
end
DarkRP.defineChatCommand("train", CreateTrain)

local function AutoTrain(ply)
	ply:SendLua("GlideStart()")
end

timer.Create( "TrainPlayerCheck", 3, 0,function()
	for k,v in pairs(TrainPlayer)do
		if(target.pause == false)then
			v.tm = v.tm + 3
			if(v.tm>=1)then
				v.ply.train_wait = nil
				if(IsValid(v.ply))then
					AutoTrain(v.ply)
				end
				table.remove( TrainPlayer, k )
			end
		end
	end
end )

net.Receive("gettrain",function(len,ply)
	local d = net.ReadBool()
	local from = net.ReadEntity()
	
	ply.pause = false
	if(d == true)then
		table.remove( TrainPlayer, ply.train_wait )
		ply.train_wait=nil
		ply.sempai = from
	end
end)

local function OfferTrain(ply, args)
	if #args != 1 then return "" end
	if type(args)!="table" then return "" end
	local target = AutoComplete(tostring(args[1]))
	if target.train_wait!=nil then return "" end
	local d = false
	target.pause = true
	net.Start("sendtrain")
		net.WriteEntity(ply)
	net.Send(target)
end
DarkRP.defineChatCommand("offertrain", OfferTrain)

local function OfferTest(ply, args)
	if #args != 1 then return "" end
	if type(args)!="table" then return "" end
	local target = AutoComplete(tostring(args[1]))
	if target.sempai!=ply then return "" end
	local d = false
	EverDerma("Обучение","Начать тест?",{{text="Да",
		func = function() 
			d = true
		end},
		{text="Нет",
		func = function()
			d = false
		end}
	})
	if(d == true)then
		target.sempai = ply
	end
end
DarkRP.defineChatCommand("offertest", OfferTest)

local function AutoComplete( stringargs )

	--stringargs = string.Trim( stringargs ) -- Remove any spaces before or after.
	stringargs = string.lower( stringargs )
	
	for k, v in pairs( player.GetAll() ) do
		local nick = v:Nick()
		if string.find( string.lower( nick ), stringargs ) then
			return v
		end
	end
	
	return false
end