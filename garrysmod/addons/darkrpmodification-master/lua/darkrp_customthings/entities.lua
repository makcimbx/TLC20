--[[---------------------------------------------------------------------------
DarkRP custom entities
---------------------------------------------------------------------------

This file contains your custom entities.
This file should also contain entities from DarkRP that you edited.

Note: If you want to edit a default DarkRP entity, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the entity to this file and edit it.

The default entities can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua#L111

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomEntityFields

Add entities under the following line:
---------------------------------------------------------------------------]]


	DarkRP.createEntity("Джетпак", {
		ent = "sneakyjetpack",
		model = "models/thrusters/jetpack.mdl",
		price = 1,
		max = 1,
		cmd = "buypjetpack",
		category = "Jetpack",
		allowed = {TEAM_327JETTRP,TEAM_ARCTRP,TEAM_ARCCPL,TEAM_ARCSGT,TEAM_ARCLT,TEAM_ARCCPT,TEAM_ARCMJR,TEAM_ARCCOL,TEAM_ARCCO,TEAM_104JETTRP,TEAM_ARCSNP,TEAM_ARCGRENADE,TEAM_ARCGUNNER},
	})
	
	DarkRP.createEntity("Патроны", {
		ent = "touch_pickup_752_ammo_ar2",
		model = "models/starwars/items/power_cell.mdl",
		price = 1,
		max = 20,
		cmd = "buyammo",
		category = "Ammo",
		allowed = {TEAM_EODTRP,TEAM_EODCPL,TEAM_EODSGT,TEAM_EODLT,TEAM_EODCPT,TEAM_EODMJR,TEAM_EODCOL,TEAM_EODCO},
	})
	
	DarkRP.createEntity("Заряд щита", {
		ent = "touch_pickup_752_armor_large",
		model = "models/starwars/items/shield_large.mdl",
		price = 1,
		max = 20,
		cmd = "buyshield",
		category = "Shield",
		allowed = {TEAM_EODTRP,TEAM_EODCPL,TEAM_EODSGT,TEAM_EODLT,TEAM_EODCPT,TEAM_EODMJR,TEAM_EODCOL,TEAM_EODCO},
	})
	
	DarkRP.createEntity("Патроны для гранатомета", {
		ent = "item_rpg_round",
		model = "models/Items/AR2_Grenade.mdl",
		price = 1,
		max = 20,
		cmd = "buygrenade",
		category = "Grenade",
		allowed = {TEAM_EODTRP,TEAM_EODCPL,TEAM_EODSGT,TEAM_EODLT,TEAM_EODCPT,TEAM_EODMJR,TEAM_EODCOL,TEAM_EODCO},
	})
	
	DarkRP.createEntity("Турель", {
		ent = "turret_bullets_clone_minigun",
		model = "models/swbf3/outerrim/weapons/bowcaster.mdl",
		price = 1,
		max = 1,
		cmd = "buyturret",
		category = "Turret",
		allowed = {TEAM_EODTRP,TEAM_EODCPL,TEAM_EODSGT,TEAM_EODLT,TEAM_EODCPT,TEAM_EODMJR,TEAM_EODCOL,TEAM_EODCO},
	})
	
	
	DarkRP.createEntity("LAAT", {
		ent = "laat",
		model = "models/ish/starwars/laat/laat_mk2.mdl",
		price = 1,
		max = 1,
		cmd = "buylaat",
		category = "LAAT",
		allowed = {TEAM_PILOTTRP,TEAM_PILOTCPL,TEAM_PILOTSGT,TEAM_PILOTLT,TEAM_PILOTCPT,TEAM_PILOTMJR,TEAM_PILOTCOL,TEAM_PILOTCO},
	})

	DarkRP.createEntity("ARC170", {
		ent = "arc170",
		model = "models/ish/starwars/laat/laat_mk2.mdl",
		price = 1,
		max = 1,
		cmd = "buyarc170",
		category = "ARC170",
		allowed = {TEAM_PILOTSGT,TEAM_PILOTLT,TEAM_PILOTCPT,TEAM_PILOTMJR,TEAM_PILOTCOL,TEAM_PILOTCO},
	})
	
	DarkRP.createEntity("V19 Torrent", {
		ent = "v19torrent",
		model = "models/ish/starwars/laat/laat_mk2.mdl",
		price = 1,
		max = 1,
		cmd = "buyv19",
		category = "V19",
		allowed = {TEAM_PILOTCPL,TEAM_PILOTSGT,TEAM_PILOTLT,TEAM_PILOTCPT,TEAM_PILOTMJR,TEAM_PILOTCOL,TEAM_PILOTCO},
	})
	
	DarkRP.createEntity("Z95", {
		ent = "headhunter",
		model = "models/ish/starwars/laat/laat_mk2.mdl",
		price = 1,
		max = 1,
		cmd = "buyz95",
		category = "Z95",
		allowed = {TEAM_PILOTCPL,TEAM_PILOTSGT,TEAM_PILOTLT,TEAM_PILOTCPT,TEAM_PILOTMJR,TEAM_PILOTCOL,TEAM_PILOTCO},
	})

	DarkRP.createEntity("Y WING BTL B", {
		ent = "ywing_btlb",
		model = "models/ish/starwars/laat/laat_mk2.mdl",
		price = 1,
		max = 1,
		cmd = "buyywing",
		category = "YWING",
		allowed = {TEAM_PILOTCPL,TEAM_PILOTSGT,TEAM_PILOTLT,TEAM_PILOTCPT,TEAM_PILOTMJR,TEAM_PILOTCOL,TEAM_PILOTCO},
	})
	
	DarkRP.createEntity("Бакта Диспенсер", {
		ent = "bacta_dispenser",
		model = "models/props/starwars/medical/bacta_dispenser.mdl",
		price = 1,
		max = 2,
		cmd = "buybactadispenser",
		category = "Bacta Dispenser",
		allowed = {TEAM_74TRP,TEAM_74CPL,TEAM_74SGT,TEAM_74LT,TEAM_74CPT,TEAM_74MJR,TEAM_74COL,TEAM_74CO},
	})
	
	DarkRP.createEntity("Бакта", {
		ent = "touch_pickup_752_bacta_large",
		model = "models/starwars/items/bacta_large.mdl",
		price = 1,
		max = 6,
		cmd = "buybacta",
		category = "Bacta",
		allowed = {TEAM_74TRP,TEAM_74CPL,TEAM_74SGT,TEAM_74LT,TEAM_74CPT,TEAM_74MJR,TEAM_74COL,TEAM_74CO},
	})
	