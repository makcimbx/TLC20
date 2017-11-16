--[[-------------------------------------------------------------------
	Zhrom Hilt Extensions:
		Adding more hilts automatically!
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

wOS = wOS or {}

hook.Add( "PostGamemodeLoaded", "wOS.AddZhromHilts", function()

	if !wOS.EnableZhromExtension then return end
	
	list.Set( "LightsaberModels", "models/dani/dani.mdl", {} )
	list.Set( "LightsaberModels", "models/donation gauntlet/donation gauntlet.mdl", {} )
	list.Set( "LightsaberModels", "models/donation1/donation1.mdl", {} )	
	list.Set( "LightsaberModels", "models/donation2/donation2.mdl", {} )	
	list.Set( "LightsaberModels", "models/donation3/donation3.mdl", {} )
	list.Set( "LightsaberModels", "models/donation4/donation4.mdl", {} )
	list.Set( "LightsaberModels", "models/donation7/donation7.mdl", {} )	
	list.Set( "LightsaberModels", "models/lightsaber/lightsaber.mdl", {} )	
	list.Set( "LightsaberModels", "models/lightsaber2/lightsaber2.mdl", {} )
	list.Set( "LightsaberModels", "models/lightsaber3/lightsaber3.mdl", {} )
	list.Set( "LightsaberModels", "models/lightsaber4/lightsaber4.mdl", {} )	
	list.Set( "LightsaberModels", "models/pike/pike.mdl", {} )		
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_reborn_saber_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_1_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_2_hilt.mdl", {} )	
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_3_hilt.mdl", {} )	
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_4_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_5_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_6_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_7_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_8_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_9_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_dual_1_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_dual_2_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_dual_3_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_dual_4_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/sgg/starwars/weapons/w_saber_dual_5_hilt.mdl", {} )
	list.Set( "LightsaberModels", "models/snake/snake.mdl", {} )
	list.Set( "LightsaberModels", "models/snake2/snake2.mdl", {} )	
	list.Set( "LightsaberModels", "models/training/training.mdl", {} )	
	list.Set( "LightsaberModels", "models/trident/trident.mdl", {} )
	list.Set( "LightsaberModels", "models/donation gauntlet/donation gauntlet.mdl", {} )
	list.Set( "LightsaberModels", "models/donation1/donation1.mdl", {} )	
	list.Set( "LightsaberModels", "models/donation1/donation1.mdl", {} )	

	if SERVER then
		resource.AddWorkshop( "740395760" )
	end
	
end )