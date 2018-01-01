
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


wOS = wOS or {}
wOS.ExperienceTable = {}

--Your MySQL Data ( Fill in if you are using MySQL Database )
--DO NOT GIVE THIS INFORMATION OUT! Malicious users can connect to your database with it
wOS.SkillDatabase = wOS.SkillDatabase or {}
wOS.SkillDatabase.Host = "server191.hosting.reg.ru"
wOS.SkillDatabase.Port = 3306
wOS.SkillDatabase.Username = "u0426341_gmod"
wOS.SkillDatabase.Password = "vstreza555"
wOS.SkillDatabase.Database = "u0426341_gmod"
wOS.SkillDatabase.Socket = ""


--How often do you want to save player progression ( in seconds )
wOS.SkillDatabase.SaveFrequency = 360

--Do you want to use MySQL Database to save your data?
--PlayerData ( text files in your data folder ) are a lot less intensive but lock you in on one server
--MySQL Saving lets you sync with many servers that share the database, but has the potential to increase server load due to querying
wOS.ShouldSkillUseMySQL = true

--Should XP gained from Vrondrakis also be used for the skill point system?
wOS.VrondrakisSync = false

--How many levels do you need to progress in order to get skill points?
wOS.LevelsPerSkillPoint = 1

--How many skill points do you get when you achieve those levels above?
wOS.SkillPointPerLevel = 1

--How long before we award free xp just for playing? ( set this to false if you don't want to do this )
wOS.TimeBetweenXP = 600

--[[
	Distribute the XP per usergroup here. The additions may be subject to change
	but the general format is:
	
	wOS.ExperienceTable[ "USERGROUP" ] = {
			Meditation = XP Per meditation tick ( every 3 seconds ),
			PlayerKill = XP for killing another player,
			NPCKill = XP for killing an NPC,
			XPPerInt = The XP gained from the playing internval above,
	}	
		
]]--

--Default is the DEFAULT xp awarded if they aren't getting special XP. Only change the numbers for this one!
wOS.ExperienceTable[ "Default" ] = {
		Meditation = 50,
		PlayerKill = 500,
		NPCKill = 100,
		XPPerInt = 30,
		XPPerHeal = 30,
}

wOS.ExperienceTable[ "vip" ] = {
		Meditation = 100,
		PlayerKill = 1000,
		NPCKill = 200,
		XPPerInt = 70,
		XPPerHeal = 30,
}

wOS.ExperienceTable[ "superadmin" ] = {
		Meditation = 150,
		PlayerKill = 1500,
		NPCKill = 300,
		XPPerInt = 100,
		XPPerHeal = 30,
}





