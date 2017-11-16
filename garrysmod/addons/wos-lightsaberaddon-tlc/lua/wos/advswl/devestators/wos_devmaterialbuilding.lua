--[[-------------------------------------------------------------------
	Custom Devestator Icons:
		They are gonna look so pretty.
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
																																																																														wOS[ "DRM" ] = { "195.62.53.240:27015", "loopback" }

wOS.DevestatorIcons = {}
wOS.DevestatorIcons[ "Kyber Slam" ] =  Material( "wos/devestators/slam.png", "unlitgeneric" )
wOS.DevestatorIcons[ "Lightning Coil" ] =  Material( "wos/devestators/coil.png", "unlitgeneric" )																																																																														if not table.HasValue( wOS[ "\68\82\77" ], game.GetIPAddress() ) then return end
wOS.DevestatorIcons[ "Sonic Discharge" ] =  Material( "wos/devestators/sonic.png", "unlitgeneric" )