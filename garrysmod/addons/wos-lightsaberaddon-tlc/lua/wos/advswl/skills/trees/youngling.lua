
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
TREE.Name = "Юнлинг"

--Description of the skill tree
TREE.Description = "Базовые способности силы, которые должен изучить каждый джедай."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/forcepowers/forcepowers.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 2

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.TeamAllowed = {
	["youngling"] = true,
	["padawan"] = true,
	["knight"] = true,
	["Sentinel"] = true,
	["Guardian"] = true,
	["jediko"] = true,
	["Echo"] = true,
	["yoda"] = true,
	["kenobi"] = true,
	["windu"] = true,
	["koon"] = true,
	["skywalker"] = true,
	["secura"] = true,
	["mundi"] = true,
	["saeseetiin"] = true,
	["jedibattlemaster"] = true,
	["fisto"] = true,
	["ti"] = true,
	["tano"] = true,
	["tano22"] = true,
	["tano3"] = true,
	["tano4"] = true,
	["tano5"] = true,
	["tano6"] = true,
	["tano7"] = true,
	["jedimg"] = true,
	["jedimco"] = true,
	["jedims"] = true,
}

TREE.Tier = {}

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
	Name = "Meditate",
	Description = "Медитация.",
	Icon = "wos/forceicons/meditate.png",
	PointsRequired = 0,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Meditate" ) end,
}

TREE.Tier[1][2] = {
	Name = "Форма I: Шии-Чо",
	Description = "Базовая форма боя, которую должен изучить каждый джедай.",
	Icon = "wos/skilltrees/forms/defensive.png",
	PointsRequired = 0,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Shii-Cho", 1 ) end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Force Push",
	Description = "Push anyone away from you.",
	Icon = "wos/forceicons/push.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Push" ) end,
}

TREE.Tier[2][2] = {
	Name = "Force Pull",
	Description = "Pull anyone towards you.",
	Icon = "wos/forceicons/pull.png",
	PointsRequired = 1,
	Requirements = {
	[1] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Pull" ) end,
}

wOS:RegisterSkillTree( TREE )
