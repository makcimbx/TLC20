
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
TREE.Name = "Консул"

--Description of the skill tree
TREE.Description = ""

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/forms/defensive.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.TeamAllowed = {
	["jediko"] = true,
	["Echo"] = true,
	["yoda"] = true,
	["fisto"] = true,
	["ti"] = true,
	["tano5"] = true,
	["jedimco"] = true,
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
	Name = "Улучшение связи с силой IV",
	Description = "Повышение максимальной силы на 20.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 3,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 20 ) end,
}

TREE.Tier[1][2] = {
	Name = "Улучшение чувствителньости к силе Г",
	Description = "Повышает регенерацию силы на 25%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 3,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.25 end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Улучшение связи с силой V",
	Description = "Повышение максимальной силы на 30.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
	Requirements = {
	[1] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 30 ) end,
}

TREE.Tier[2][2] = {
	Name = "Улучшение чувствителньости к силе ГГ",
	Description = "Повышает регенерацию силы на 25%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 5,
	Requirements = {
	[1] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.25 end,
}

TREE.Tier[3] = {}
TREE.Tier[3][1] = {
	Name = "Улучшение связи с силой VГ",
	Description = "Повышение максимальной силы на 50.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 7,
	Requirements = {
	[2] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 50 ) end,
}

TREE.Tier[3][2] = {
	Name = "Улучшение чувствителньости к силе Г",
	Description = "Повышает регенерацию силы на 50%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 7,
	Requirements = {
	[2] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.5 end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Отражение силы",
	Description = "Отражает весь наносимый вам урон обратно во врага.",
	Icon = "wos/forceicons/reflect.png",
	PointsRequired = 5,
	Requirements = {
	[3] = { 1, 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Reflect" ) end,
}

TREE.Tier[4][2] = {
	Name = "Исцеление силы",
	Description = "Исцеляет выбранную цель.",
	Icon = "wos/forceicons/heal.png",
	PointsRequired = 2,
	Requirements = {
	[3] = { 1, 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Force Heal" ) end,
}

TREE.Tier[5] = {}
TREE.Tier[5][1] = {
	Name = "Массовое исцеление силы",
	Description = "Исцеляет всех вокруг вас.",
	Icon = "wos/forceicons/group_heal.png",
	PointsRequired = 5,
	Requirements = {
	[4] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Group Heal" ) end,
}

wOS:RegisterSkillTree( TREE )