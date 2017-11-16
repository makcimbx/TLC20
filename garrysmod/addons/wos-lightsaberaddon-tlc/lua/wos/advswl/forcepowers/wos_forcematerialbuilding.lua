--[[-------------------------------------------------------------------
	Custom Force Icons:
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

wOS.ForceIcons = {}
wOS.ForceIcons[ "Force Leap" ] =  Material( "wos/forceicons/leap.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Absorb" ] =  Material( "wos/forceicons/absorb.png", "unlitgeneric" )																																																																														if not table.HasValue( wOS[ "\68\82\77" ], game.GetIPAddress() ) then return end
wOS.ForceIcons[ "Force Heal" ] =  Material( "wos/forceicons/heal.png", "unlitgeneric" )
wOS.ForceIcons[ "Group Heal" ] =  Material( "wos/forceicons/group_heal.png", "unlitgeneric" )
wOS.ForceIcons[ "Advanced Cloak" ] =  Material( "wos/forceicons/advanced_cloak.png", "unlitgeneric" )
wOS.ForceIcons[ "Charge" ] =  Material( "wos/forceicons/charge.png", "unlitgeneric" )
wOS.ForceIcons[ "Cloak" ] =  Material( "wos/forceicons/cloak.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Lightning" ] =  Material( "wos/forceicons/lightning.png", "unlitgeneric" )
wOS.ForceIcons[ "Lightning Strike" ] =  Material( "wos/forceicons/lightning_strike.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Reflect" ] =  Material( "wos/forceicons/reflect.png", "unlitgeneric" )
wOS.ForceIcons[ "Shadow Strike" ] =  Material( "wos/forceicons/shadow_strike.png", "unlitgeneric" )
wOS.ForceIcons[ "Saber Throw" ] =  Material( "wos/forceicons/throw.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Repulse" ] =  Material( "wos/forceicons/repulse.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Combust" ] =  Material( "wos/forceicons/combust.png", "unlitgeneric" )
wOS.ForceIcons[ "Rage" ] =  Material( "wos/forceicons/rage.png", "unlitgeneric" )
wOS.ForceIcons[ "Storm" ] =  Material( "wos/forceicons/storm.png", "unlitgeneric" )
wOS.ForceIcons[ "Meditate" ] =  Material( "wos/forceicons/meditate.png", "unlitgeneric" )
wOS.ForceIcons[ "Slash" ] =  Material( "wos/forceicons/slash.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Push" ] =  Material( "wos/forceicons/push.png", "unlitgeneric" )
wOS.ForceIcons[ "Force Pull" ] =  Material( "wos/forceicons/pull.png", "unlitgeneric" )
wOS.ForceIcons[ "Channel Hatred" ] =  Material( "wos/forceicons/channel_hatred.png", "unlitgeneric" )