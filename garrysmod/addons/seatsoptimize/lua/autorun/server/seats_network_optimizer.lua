if !game.SinglePlayer() then
	seats_network_optimizer = seats_network_optimizer or {}
	
	if !seats_network_optimizer.Spawn then
		local Entity = FindMetaTable( "Entity" )
		local Spawn = Entity.Spawn
		function Entity:Spawn( ... )
			if self:GetClass()!="prop_vehicle_prisoner_pod" then
				return Spawn( self, ... )
			else
				local result = Spawn( self, ... )
				self:AddEFlags( EFL_NO_THINK_FUNCTION ) -- disable self's Think
				self.seats_network_optimizer = true -- Now we know that this seat has been Entity:Spawn().
				return result
			end
		end
		seats_network_optimizer.Spawn = Spawn
	end
	
	local i
	local seats
	local last_enabled
	hook.Add( "Think", "seats_network_optimizer", function()
		-- This function enables the Think of one seat during each frame. This is more suitable than letting the Think enabled all the time.
		if !seats or !seats[i] then
			-- Begin a new loop, with a new seats list.
			i=1
			seats = {}
			for _,seat in ipairs( ents.FindByClass( "prop_vehicle_prisoner_pod" ) ) do
				if seat.seats_network_optimizer then
					table.insert( seats, seat )
				end
			end
		end
		while seats[i] and !IsValid( seats[i] ) do
			-- Jump to the next valid seat.
			i=i+1
		end
		if last_enabled != seats[i] and IsValid( last_enabled ) then
			local saved = last_enabled:GetSaveTable()
			if !saved["m_bEnterAnimOn"] and !saved["m_bExitAnimOn"] then -- A change occurs at the end of animations, so we keep the Think enabled until then.
				last_enabled:AddEFlags( EFL_NO_THINK_FUNCTION ) -- disable last_enabled's Think
			end
		end
		if IsValid( seats[i] ) then
			seats[i]:RemoveEFlags( EFL_NO_THINK_FUNCTION ) -- enable seats[i]'s Think
			last_enabled = seats[i]
		end
		i=i+1
	end )
	
	local function EnteredOrLeaved( ply, seat )
		if IsValid( seat ) and seat.seats_network_optimizer then
			table.insert( seats, i, seat ) -- seat's Think will be enabled on next game's Think
		end
	end
	hook.Add( "PlayerEnteredVehicle", "seats_network_optimizer", EnteredOrLeaved )
	hook.Add( "PlayerLeaveVehicle", "seats_network_optimizer", EnteredOrLeaved )
end