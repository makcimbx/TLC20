require("races")

util.AddNetworkString("sendRaceCheckpoints")
util.AddNetworkString("openRaceSystem")
util.AddNetworkString("currentCheckpoint")
util.AddNetworkString("SetPlyNpcName")
util.AddNetworkString("Reward")
util.AddNetworkString("Check")
util.AddNetworkString("ChangeSOme")

util.AddNetworkString("createRace")
util.AddNetworkString("removeRace")

util.AddNetworkString("checkCheckpoint")

util.AddNetworkString("tptostartpoint")

local raceSystem = races.new()

for k,v in pairs(player.GetAll()) do
	v.CurrentCheckpoint = 1
end
function sendCheckpoints( ply, arg )
	if not arg then
		net.Start("sendRaceCheckpoints")
			net.WriteTable(raceSystem:getRaceCheckpoints())
		net.Send(ply)
	else
		net.Start("sendRaceCheckpoints")
			net.WriteTable(raceSystem:getRaceCheckpoints(arg))
		net.Send(ply)
	end
end


net.Receive("checkCheckpoint",function ( len, ply )
	local checkpoints = raceSystem:getRaceCheckpoints(ply.inRace)

		if tonumber(ply.CurrentCheckpoint) > #checkpoints then
			raceSystem:addWinner(ply.inRace,ply)
			ply.inRace = nil
		else
			for i=1, #checkpoints do
				if ply:GetPos():Distance(checkpoints[ply.CurrentCheckpoint]['pos']) < 150 then
					ply.CurrentCheckpoint = ply.CurrentCheckpoint + 1
					net.Start("currentCheckpoint")
						net.WriteInt(ply.CurrentCheckpoint,32)
					net.Send(ply)
					if tonumber(ply.CurrentCheckpoint) > #checkpoints then
						raceSystem:addWinner(ply.inRace,ply)
						ply.inRace = nil
						ply.CurrentCheckpoint = 1
					end
					return
				end
			end
		end
end)
--REMOVE THIS, ADD TIMER WHEN RACE CREATED INSTEAD
local function spawn( ply )
	ply.CurrentCheckpoint = 1
end
hook.Add( "PlayerInitialSpawn", "raceTimerCreate", spawn )


net.Receive("createRace",function( len, ply )
	local playersInRace 	= net.ReadTable()
	local checkpoints 		= net.ReadTable()
	local name 				= net.ReadString()
	local startpoint 		= net.ReadVector()
	SomeRace(playersInRace,checkpoints,name,startpoint,ply)
end)

net.Receive("removeRace",function( len, ply )
	RemoveRace(ply)
end)

function RemoveRace(ply)
	ply.CurrentCheckpoint = 999
	net.Start("currentCheckpoint")
		net.WriteInt(ply.CurrentCheckpoint,32)
	net.Send(ply)
	raceSystem:addWinner(ply.inRace,ply,1)
	ply.inRace = nil
	ply.CurrentCheckpoint = 1
end



function SomeRace(playersInRace,checkpoints,name,startpoint,ply)

	if #playersInRace==0 then ply:PrintMessage(HUD_PRINTTALK,"No players were selected!") return end
	if #checkpoints==0 then ply:PrintMessage(HUD_PRINTTALK,"No checkpoints were selected!") return end
	
	for k,v in pairs(checkpoints) do
		v.z=v.z-64
	end
	startpoint.z=startpoint.z-64
	raceSystem:addRace(name,playersInRace,checkpoints,startpoint)

	for k,v in pairs(playersInRace) do
		v:SetPos(raceSystem:getRaceStartpoint(#raceSystem:getRaces()))
		
		local vec1 = checkpoints[1] -- Where we're looking at
		local vec2 = ply:GetShootPos() -- The player's eye pos
		ply:SetEyeAngles( ( vec1 - vec2 ):Angle() ) -- Sets to the angle between the two vectors

		v.inRace = #raceSystem:getRaces()
		net.Start("currentCheckpoint")
			net.WriteInt(ply.CurrentCheckpoint,32)
		net.Send(ply)
		
	end
end

net.Receive("tptostartpoint",function ( len, ply )
	if not ply:IsAdmin() then return end
	ply:SetPos(net.ReadVector())
end)