
--[[-------------------------------------------------------------------
	Lightsaber Force Powers:
		The available powers that the new saber base uses.
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

local TREE = {}

--Name of the skill tree
TREE.Name = "74 легион"

--Description of the skill tree
TREE.Description = "Улучшение снаряжения для 74 легиона"

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/characterstats/characterstats.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 6

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.Tier = {}

TREE.TeamAllowed = {
	["74mc"] = true,
	["74cc"] = true,
	["74co"] = true,
	["74col"] = true,
	["74mjr"] = true,
	["74cpt"] = true,
	["74lt"] = true,
	["74sgt"] = true,
	["74cpl"] = true,
	["74trp"] = true,
	["74ct"] = true,
}



--Tier format is as follows:
--To create the TIER Table, do the following
--TREE.Tier[ TIER NUMBER ] = {} 
--To populate it with data, the format follows this
--TREE.Tier[ TIER NUMBER ][ SKILL NUMBER ] = DATA
--Name, description, and icon are exactly the same as before
--PointsRequired is for how many skill points are needed to unlock this particular skill
--Requirements prevent you from unlocking this skill unless you have the pre-requisite skills from the last tiers. If you are on tier 1, this should be {}
--OnPlayerSpawn is a function called when the player just spawns
--OnPlayerDeath is a function called when the player has just died
--OnSaberDeploy is a function called when the player has just pulled out their lightsaber ( assuming you have SWEP.UsePlayerSkills = true )


TREE.Tier[1] = {}
TREE.Tier[1][1] = {
	Name = "Объём лечения 1",
	Description = "Увеличивает объём лечения на 1 еденицы",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 1,0  end,
}
TREE.Tier[1][2] = {
	Name = "Скорость лечения 1",
	Description = "Увеличивает скорость лечения на 5%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 0,0.05  end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Объём лечения 2",
	Description = "Увеличивает объём лечения на 1 еденицы",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 1 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 1,0  end,
}
TREE.Tier[2][2] = {
	Name = "Скорость лечения 2",
	Description = "Увеличивает скорость лечения на 5%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 2 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 0,0.05  end,
}

TREE.Tier[3] = {}
TREE.Tier[3][1] = {
	Name = "Объём лечения 3",
	Description = "Увеличивает объём лечения на 2 едениц",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 1 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 2,0  end,
}
TREE.Tier[3][2] = {
	Name = "Скорость лечения 3",
	Description = "Увеличивает скорость лечения на 10%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 2,
	Requirements = {
	[2] = { 2 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 0,0.1  end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Объём лечения 4",
	Description = "Увеличивает объём лечения на 2 едениц",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 3,
	Requirements = {
	[3] = { 1 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 2,0  end,
}
TREE.Tier[4][2] = {
	Name = "Скорость лечения 4",
	Description = "Увеличивает скорость лечения на 10%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 3,
	Requirements = {
	[3] = { 2 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 0,0.1  end,
}

TREE.Tier[5] = {}
TREE.Tier[5][1] = {
	Name = "Скорость лечения 5",
	Description = "Увеличивает скорость лечения на 20%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 5,
	Requirements = {
	[4] = { 2 },
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return 0,0.2  end,
}

TREE.Tier[6] = {}
TREE.Tier[6][1] = {
	Name = "Герой 74 легиона",
	Description = "Увеличивает объём и скорость лечения на 15%",
	Icon = "wos/skilltrees/characterstats/health.png",
	PointsRequired = 25,
	Requirements = {
	[4] = { 1,2 },
	[5] = { 1},
	},
	OnPlayerMedKitUse = function( ply,who,heal,speed ) return heal*0.15,0.15  end,
}

wOS:RegisterSkillTree( TREE )