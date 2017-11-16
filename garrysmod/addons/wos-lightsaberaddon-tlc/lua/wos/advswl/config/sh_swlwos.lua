
--[[-------------------------------------------------------------------
	Lightsaber Combat System:
		An intuitively designed lightsaber combat system.
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

hook.Add( "PostGamemodeLoaded", "wOS.AddJobsForForms", function()

wOS.Forms = {}
-- This is where you configure the group that has access to the form, and which stance they will be using.
-- FORMAT: wOS.Forms[ FORM ] = { [ ULXGROUP ] = { STANCENUMBER1, STANCENUMBER2, STANCENUMBER3 } }
-- STANCENUMBER is a number from 1-3
-- And follow through
-- PLEASE NOTE THAT IF A GROUP DOES NOT HAVE A FORM SPECIFIED, THEY WILL JUST USE THE DEFAULT GMOD ANIMATIONS!
wOS.Forms[ "Defensive" ] = { 
	["user"] = { 1 }, 
	["jedi"] = { 1, 2, 3 },
}
wOS.Forms[ "Aggressive" ] = { 
	["user"] = { 1 }, 
	["jedi"] = { 1, 2, 3 },
}
wOS.Forms[ "Agile" ] = { 
	["VIP"] = { 1, 2, 3 },
}
wOS.Forms[ "Versatile" ] = { 
	["VIP"] = { 1, 2, 3 },
}

-- Same as above. STANCENUMBER is 1-3
wOS.DualForms = {}
wOS.DualForms[ "Arrogant" ] = {
}

--This is where you'd select the usergroups that should have access to ALL forms and stances!
wOS.AllAccessForms = { "minivip", "owner", "superadmin", "headadmin", "administration", "admin", "noaccess", "vip", "event_maker", "commander", "user" }

end )