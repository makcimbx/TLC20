
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
TREE.Name = "Урон"

--Description of the skill tree
TREE.Description = "Сила есть ума не надо."

--Icon for the skill tree ( Appears in category menu and above the skills )
TREE.TreeIcon = "wos/skilltrees/characterstats/characterstats.png"

--What is the background color in the menu for this 
TREE.BackgroundColor = Color( 255, 0, 0, 25 )

--How many tiers of skills are there?
TREE.MaxTiers = 6

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
TREE.UserGroups = false

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
	Name = "Урон 1",
	Description = "+5% к урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.05,0 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end, 
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[1][2] = {
	Name = "Крит. урон 1",
	Description = "+5% к критическому урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/emergent.png",
	PointsRequired = 1,
	Requirements = {},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.05,crit*0.05 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

TREE.Tier[2] = {}
TREE.Tier[2][1] = {
	Name = "Урон 2",
	Description = "+5% к урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 1,
	Requirements = {[1] = {1}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.05,0 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[2][2] = {
	Name = "Крит. урон 2",
	Description = "+5% к критическому урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/emergent.png",
	PointsRequired = 1,
	Requirements = {[1] = {2}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0,0.05 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

TREE.Tier[3] = {}
TREE.Tier[3][1] = {
	Name = "Урон 3",
	Description = "+5% к урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 3,
	Requirements = {[2] = {1}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.05,0 end,
	--OnPlayerSpawn = function( ply ) end,,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[3][2] = {
	Name = "Крит. урон 3",
	Description = "+5% к критическому урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/emergent.png",
	PointsRequired = 1,
	Requirements = {[2] = {2}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0,0.05 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

TREE.Tier[4] = {}
TREE.Tier[4][1] = {
	Name = "Берсерк",
	Description = "Чем меньше у вас ХП тем быстрее вы передвигаетесь,",
	Description2 = "но получаете +10% урона",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 30,
	Requirements = {[3] = {1,2}},
	OnPlayerTakeDamage = function(target, attacker, dmg,crit) return 0.1,0 end,
	OnHealthChanged = function(ply) timer.Simple(0.1,function() local hpp = 1-ply:Health()/ply:GetMaxHealth() ply:UpdateSpeedBonus(hpp)  end) end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

TREE.Tier[5] = {}
TREE.Tier[5][1] = {
	Name = "Урон 5",
	Description = "+10% к урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 5,
	Requirements = {[3] = {1}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.1,0 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[5][2] = {
	Name = "Крит. урон 5",
	Description = "+5% к критическому урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/emergent.png",
	PointsRequired = 1,
	Requirements = {[3] = {2}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0,0.05 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}


TREE.Tier[6] = {}
TREE.Tier[6][1] = {
	Name = "Урон 6",
	Description = "+10% к урону",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 6,
	Requirements = {[5] = {1}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0.1,0 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[6][3] = {
	Name = "Крит. урон 6",
	ETree = "Убийца",
	Description = "+5% к критическому урону",
	Icon = "wos/skilltrees/ravager/emergent.png",
	PointsRequired = 1,
	Requirements = {[5] = {2}},
	OnPlayerMakeDamage = function(target, attacker, dmg,crit) return 0,0.05 end,
	--OnPlayerSpawn = function( ply ) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}
TREE.Tier[6][2] = {
	Name = "Маньяк",
	Description = "Ваше хп восстанавливается за каждый нанесённый",
	Description2 = "вами урон на 0.5% от этого урона",
	ETree = "Убийца",
	Icon = "wos/skilltrees/ravager/torment.png",
	PointsRequired = 20,
	Requirements = {[4] = {1}},
	OnPlayerPostMakeDamage = function(target, attacker, dmg,crit) attacker:SetHealth(math.Clamp( attacker:Health()+dmg*0.005, 0, attacker:GetMaxHealth() )) end,
	--OnPlayerDeath = function( ply ) end,
	--OnSaberDeploy = function( wep ) end,
}

wOS:RegisterSkillTree( TREE )