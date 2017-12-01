util.AddNetworkString( "StartTest" )

local TrainPlayer = {}

local function CreateTrain(ply, args)
	if ply.train_wait!=nil or args != "" then return "" end
	if ply:GetPData("tutor_ever","0") == "1" then ply:ChatPrint("Вы уже проходили обучение!") return "" end
	
	ply:ChatPrint("Ждите в течении 5 минут до прибытия командира, либо вам будет предложено автоматическое обучение.")
 
	table.insert(TrainPlayer,{ply = ply,tm = 0})
 
	ply.train_wait = #TrainPlayer
 
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
			v.ply.train_wait = nil
			if(IsValid(v.ply))then
				AutoTrain(v.ply)
			end
			table.remove( TrainPlayer, k )
		end
	end
end )

local function OfferTrain(ply, args)
	--if ply.train_wait!=nil then return "" end
	if #args != 1 then return "" end
	if type(args)!="table" then return "" end
	PrintTable(args)
	local target = AutoComplete(tostring(args[1]))
	print(target)
	
end
DarkRP.defineChatCommand("offertrain", OfferTrain)

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