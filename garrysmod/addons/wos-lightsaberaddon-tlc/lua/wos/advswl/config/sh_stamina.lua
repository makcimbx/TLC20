

--[[-------------------------------------------------------------------
	Lightsaber Stamina System:
		Make the right choices and play smart.
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--


if not wOS then
	wOS = {}
end

-- Enable the stamina mod?
wOS.EnableStamina = false

if not wOS.EnableStamina then return end

-- Amount of stamina lost when doing a normal attack ( Out of 100 )
wOS.AttackCost = 15

-- Amount of stamina lost when doing a heavy attack ( Out of 100 )
wOS.HeavyCost = 35

if SERVER then

	hook.Add( "Think", "wOS.PlayerStaminaChecks", function()

		for _,ply in pairs( player.GetAll() ) do
			if not IsValid( ply ) then continue end
			if not ply:Alive() then continue end
			ply:AddStamina( 0.1 )
		end

	end )

	hook.Add( "PlayerSpawn", "wOS.resetStam", function( ply )
		ply:SetStamina( 100 )
	end )
			
end

if CLIENT then

end

hook.Add( "InitPostEntity", "wOS.LoadStaminaFuncs", function()

	local meta = FindMetaTable( "Player" )
	
	function meta:CanUseStamina( heavy )
		local stam = wOS.AttackCost
		if heavy then
			stam = wOS.HeavyCost
		end
		if self:GetStamina() < stam then return false end
		
		return true
	end

	function meta:GetStamina()
		return self:GetNWFloat( "Stamina", 100 )
	end

	function meta:SetStamina( num )
		self:SetNWFloat( "Stamina", num )
	end

	function meta:AddStamina( num )
		self:SetStamina( math.Clamp( self:GetStamina() + num, 0, 100 ) )
	end

end )