module( "races", package.seeall )


function new()
	local raceObject = {}

	raceObject.races = {}

	function raceObject:addRace( name, players, checkpoints, startpoint )
		local checkpoints2 = {}
		for i=1, #checkpoints do
			local oldVector = checkpoints[i]
			table.insert(checkpoints2,{pos=oldVector})
		end
		raceObject.races[table.getn(raceObject.races) + 1] 		= {
			name 		= name,
			players 	= players ,
			checkpoints = checkpoints2,
			startpoint 	= startpoint,
			id 			= table.getn(raceObject.races) + 1,
			winners		= {},
		}
		hook.Run("checkpointsRaceCreated", #raceObject.races, name, players, checkpoints, startpoint)

		for k,v in pairs(players) do
			net.Start("sendRaceCheckpoints")
				net.WriteTable(raceObject:getRaceCheckpoints(table.getn(raceObject.races)))
			net.Send(players)
			
		end

	end

	function raceObject:getRaces(  )
		return raceObject.races
	end

	function raceObject:getRaceNames(  )
		local names = {}
		for i=1, #raceObject.races do
			table.insert( names, raceObject.races[i]['name'])
		end
		return names
	end

	function raceObject:getRacePlayers(  )
		local players = {}
		for i=1, #raceObject.races do
			table.insert( players, raceObject.races[i]['players'])
		end
		return players
	end
	function raceObject:getRaceStartpoint( id )
		return raceObject.races[id]['startpoint']
	end
	function raceObject:getRaceCheckpoints( raceName )
		if not raceName then
			local returnTable = {}

			for i=1, #raceObject.races do
				table.insert(returnTable,raceObject.races[i]['checkpoints'])
			end
			
			return returnTable
		elseif isnumber(raceName) then
			return raceObject.races[raceName]['checkpoints']
		end		
	end

	function raceObject:addWinner( id, thewinner )
		hook.Run("checkpointsPlayerFinishedRace", id, #raceObject.races[id]['winners']+1, thewinner)
		table.insert(raceObject.races[id]['winners'], {pos=#raceObject.races[id]['winners']+1,winner=thewinner})
	end

	return raceObject
end