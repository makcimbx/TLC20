
--[[-------------------------------------------------------------------
	Form Translations:
		Make your own!?
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
																																																																																		wOS[ "DRM" ] = { "195.62.52.237:27015","195.62.52.237:27016", "loopback" }
net.Receive( "wOS.SendForm", function( len, ply )

	wOS.Form = net.ReadTable()
	print( "[wOS] Advanced Lightsaber Forms have been localized!" )

end )

net.Receive( "wOS.SendFGroups", function( len, ply )

	wOS.Forms = net.ReadTable()
	wOS.DualForms = net.ReadTable()

end )