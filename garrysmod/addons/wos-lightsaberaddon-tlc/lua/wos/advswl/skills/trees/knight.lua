
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
TREE.Name = "Рыцарь"

--Description of the skill tree
TREE.Description = ""

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/ravager/channel.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.TeamAllowed = {
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
	Name = "Улучшение связи с силой I",
	Description = "Повышение максимальной силы на 10.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 2,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.MaxForce = wep.MaxForce + 10 end,
}

TREE.Tier[1][2] = {
	Name = "Навык владения световым мечем I",
	Description = "Повышает наносимый урон световым мечем на 10.",
	Icon = "wos/skilltrees/ravager/combatant.png",
	PointsRequired = 2,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SaberDamage = wep.SaberDamage + 10 end,
}

TREE.Tier[1][3] = {
	Name = "Повышение ловкости",
	Description = "Повышает вашу скорость на 20",
	Icon = "wos/skilltrees/ravager/agility.png",
	PointsRequired = 5,
	Requirements = {},
	OnPlayerSpawn = function( ply ) timer.Simple(0.1,function() ply:Ssws(ply:Gsws() + 20) ply:Ssrs(ply:Gsrs() + 20) end) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Улучшение связи с силой II",
	Description = "Повышение максимальной силы на 15.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
	Requirements = {
	[1] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.MaxForce = wep.MaxForce + 15 end,
}

TREE.Tier[2][2] = {
	Name = "Навык владения световым мечем II",
	Description = "Повышает наносимый урон световым мечем на 15.",
	Icon = "wos/skilltrees/ravager/combatant.png",
	PointsRequired = 5,
	Requirements = {
	[1] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SaberDamage = wep.SaberDamage + 15 end,
}

TREE.Tier[3] = {}
TREE.Tier[3][1] = {
	Name = "Улучшение связи с силой III",
	Description = "Повышение максимальной силы на 25.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
	Requirements = {
	[2] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.MaxForce = wep.MaxForce + 25 end,
}

TREE.Tier[3][2] = {
	Name = "Навык владения световым мечем III",
	Description = "Повышает наносимый урон световым мечем на 25.",
	Icon = "wos/skilltrees/ravager/combatant.png",
	PointsRequired = 5,
	Requirements = {
	[2] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SaberDamage = wep.SaberDamage + 25 end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Волна силы",
	Description = "Оттолкните врагов вокруг себя.",
	Icon = "wos/forceicons/repulse.png",
	PointsRequired = 2,
	Requirements = {
	[3] = { 1, 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Repulse" ) end,
}

TREE.Tier[5] = {}
TREE.Tier[5][1] = {
	Name = "Поглощение силы",
	Description = "Поглащает весь урон, который вам наносят.",
	Icon = "wos/forceicons/absorb.png",
	PointsRequired = 5,
	Requirements = {
	[4] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Absorb" ) end,
}

TREE.Tier[5][2] = {
	Name = "Бросок светового меча",
	Description = "Используйте силу, что бы кинуть световой мечь в вашего врага.",
	Icon = "wos/forceicons/throw.png",
	PointsRequired = 3,
	Requirements = {
	[4] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Saber Throw" ) end,
}

wOS:RegisterSkillTree( TREE )