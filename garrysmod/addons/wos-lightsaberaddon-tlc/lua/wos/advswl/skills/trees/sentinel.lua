
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
TREE.Name = "Страж"

--Description of the skill tree
TREE.Description = ""

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/forms/arrogant.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 5

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

TREE.TeamAllowed = {
	["Sentinel"] = true,
	["Echo"] = true,
	["jedibattlemaster"] = true,
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
	Description = "Повышение максимальной силы на 10.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 2,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 10 ) end,
}

TREE.Tier[1][2] = {
	Name = "Навык владения световым мечем IV",
	Description = "Повышает наносимый урон световым мечем на 10.",
	Icon = "wos/skilltrees/ravager/combatant.png",
	PointsRequired = 2,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SaberDamage = wep.SaberDamage + 10 end,
}

TREE.Tier[1][3] = {
	Name = "Улучшение чувствителньости к силе I",
	Description = "Повышает регенерацию силы на 10%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 2,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.1 end,
}

TREE.Tier[1][4] = {
	Name = "Форма Джар'Кай",
	Description = "Изучите 1 стойку формы Джар'Кай",
	Icon = "wos/skilltrees/forms/arrogant.png",
	PointsRequired = 35,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 1 ) end,
}

TREE.Tier[1][5] = {
	Name = "Форма для светового посоха",
	Description = "Изучите 1 стойку формы для светового посоха",
	Icon = "wos/skilltrees/ravager/release.png",
	PointsRequired = 35,
	Requirements = {},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Saberstaff Form", 1 ) end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Улучшение связи с силой V",
	Description = "Повышение максимальной силы на 15.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 3,
	Requirements = {
	[1] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 15 ) end,
}

TREE.Tier[2][2] = {
	Name = "Навык владения световым мечем V",
	Description = "Повышает наносимый урон световым мечем на 15.",
	Icon = "wos/skilltrees/ravager/combatant.png",
	PointsRequired = 3,
	Requirements = {
	[1] = { 2 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.SaberDamage = wep.SaberDamage + 15 end,
}

TREE.Tier[2][3] = {
	Name = "Улучшение чувствителньости к силе II",
	Description = "Повышает регенерацию силы на 15%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 3,
	Requirements = {
	[1] = { 3 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.15 end,
}

TREE.Tier[2][4] = {
	Name = "Форма Джар'Кай",
	Description = "Изучите 2 стойку формы Джар'Кай",
	Icon = "wos/skilltrees/forms/arrogant.png",
	PointsRequired = 50,
	Requirements = {
	[1] = { 4 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 2 ) end,
}

TREE.Tier[2][5] = {
	Name = "Форма для светового посоха",
	Description = "Изучите 2 стойку формы для светового посоха",
	Icon = "wos/skilltrees/ravager/release.png",
	PointsRequired = 50,
	Requirements = {
	[1] = { 5 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Saberstaff Form", 2 ) end,
}

TREE.Tier[3] = {}
TREE.Tier[3][1] = {
	Name = "Улучшение связи с силой VI",
	Description = "Повышение максимальной силы на 25.",
	Icon = "wos/devestators/sonic.png",
	PointsRequired = 5,
	Requirements = {
	[2] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:SetMaxForce( wep:GetMaxForce() + 25 ) end,
}

TREE.Tier[3][2] = {
	Name = "Навык владения световым мечем VI",
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

TREE.Tier[3][3] = {
	Name = "Улучшение чувствителньости к силе III",
	Description = "Повышает регенерацию силы на 25%",
	Icon = "wos/skilltrees/forcepowers/forcepowers.png",
	PointsRequired = 5,
	Requirements = {
	[2] = { 3 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep.RegenSpeed = wep.RegenSpeed + 0.25 end,
}

TREE.Tier[3][4] = {
	Name = "Форма Джар'Кай",
	Description = "Изучите 3 стойку формы Джар'Кай",
	Icon = "wos/skilltrees/forms/arrogant.png",
	PointsRequired = 75,
	Requirements = {
	[2] = { 4 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Jar'Kai", 3 ) end,
}

TREE.Tier[3][5] = {
	Name = "Форма для светового посоха",
	Description = "Изучите 3 стойку формы для светового посоха",
	Icon = "wos/skilltrees/ravager/release.png",
	PointsRequired = 75,
	Requirements = {
	[2] = { 5 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForm( "Saberstaff Form", 3 ) end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Маскировка",
	Description = "Дает невидимость на 10 секунд.",
	Icon = "wos/forceicons/cloak.png",
	PointsRequired = 2,
	Requirements = {
	[3] = { 1, 3 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Cloak" ) end,
}

TREE.Tier[5] = {}
TREE.Tier[5][1] = {
	Name = "Улучшенная маскировка",
	Description = "Дает невидимость на 25 секунд.",
	Icon = "wos/forceicons/advanced_cloak.png",
	PointsRequired = 5,
	Requirements = {
	[4] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Advanced Cloak" ) end,
}

TREE.Tier[5][2] = {
	Name = "Теневой удар",
	Description = "Нанесите удар из маскировки.",
	Icon = "wos/forceicons/shadow_strike.png",
	PointsRequired = 5,
	Requirements = {
	[3] = { 2 },
	[4] = { 1 },
	},
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	OnSaberDeploy = function( wep ) wep:AddForcePower( "Shadow Strike" ) end,
}

wOS:RegisterSkillTree( TREE )