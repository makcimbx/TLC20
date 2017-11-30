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
		allowed = {"TEAM_2NDTRP","TEAM_2NDGRENADE","TEAM_327JETSGT","TEAM_327JETTRP","TEAM_ARCTRP","TEAM_ARCCPL","TEAM_ARCSGT","TEAM_ARCLT","TEAM_ARCCPT","TEAM_ARCMJR","TEAM_ARCCOL","TEAM_ARCCO"},
	})
	
	DarkRP.createEntity("Патроны", {
		ent = "touch_pickup_752_ammo_ar2",
		model = "models/starwars/items/power_cell.mdl",
		price = 1,
		max = 20,
		cmd = "buyammo",
		category = "Ammo",
		allowed = {"TEAM_EODTRP","TEAM_EODCPL","TEAM_EODSGT","TEAM_EODLT","TEAM_EODCPT","TEAM_EODMJR","TEAM_EODCOL","TEAM_EODCO"},
	})
	
	DarkRP.createEntity("Заряд щита", {
		ent = "touch_pickup_752_armor_large",
		model = "models/starwars/items/shield_large.mdl",
		price = 1,
		max = 20,
		cmd = "buyshield",
		category = "Shield",
		allowed = {"TEAM_EODTRP","TEAM_EODCPL","TEAM_EODSGT","TEAM_EODLT","TEAM_EODCPT","TEAM_EODMJR","TEAM_EODCOL","TEAM_EODCO"},
	})
	
	DarkRP.createEntity("Патроны для гранатомета", {
		ent = "item_rpg_round",
		model = "models/Items/AR2_Grenade.mdl",
		price = 1,
		max = 20,
		cmd = "buygrenade",
		category = "Grenade",
		allowed = {"TEAM_EODTRP","TEAM_EODCPL","TEAM_EODSGT","TEAM_EODLT","TEAM_EODCPT","TEAM_EODMJR","TEAM_EODCOL","TEAM_EODCO"},
	})
	
	DarkRP.createEntity("Турель", {
		ent = "turret_bullets_clone_minigun",
		model = "models/swbf3/outerrim/weapons/bowcaster.mdl",
		price = 1,
		max = 1,
		cmd = "buyturret",
		category = "Turret",
		allowed = {"TEAM_EODTRP","TEAM_EODCPL","TEAM_EODSGT","TEAM_EODLT","TEAM_EODCPT","TEAM_EODMJR","TEAM_EODCOL","TEAM_EODCO"},
	})
	
	DarkRP.createEntity("Медицинская кровать", {
		ent = "bed_medicmod",
		model = "models/medicmod/hospital_bed/hospital_bed.mdl",
		price = 1,
		max = 3,
		cmd = "buybed",
		category = "Medic Bed",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
	
	DarkRP.createEntity("Пакет Крови", {
		ent = "bloodbag_medicmod",
		model = "models/medicmod/bloodbag/bloodbag.mdl",
		price = 1,
		max = 3,
		cmd = "buyblood",
		category = "Bloodbag",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
	
	DarkRP.createEntity("Капельница", {
		ent = "drip_medicmod",
		model = "models/medicmod/medical_stand/medical_stand.mdl",
		price = 1,
		max = 3,
		cmd = "buydrip",
		category = "Drip",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
	
	DarkRP.createEntity("Электродиаграмм", {
		ent = "electrocardiogram_medicmod",
		model = "models/medicmod/electrocardiogram/electrocardiogram.mdl",
		price = 1,
		max = 3,
		cmd = "buyelectrocardiogram",
		category = "Electrocardiogram",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
	
	DarkRP.createEntity("Дефибриллятор Стационарный", {
		ent = "mural_defib_medicmod",
		model = "models/medicmod/mural_defib/mural_defib.mdl",
		price = 1,
		max = 2,
		cmd = "buydefib",
		category = "Mural Defib",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
	
	DarkRP.createEntity("Рентгеновский Аппарат", {
		ent = "radio_medicmod",
		model = "models/medicmod/radio/radio.mdl",
		price = 1,
		max = 1,
		cmd = "buyradio",
		category = "X-ray Machine",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})
		
	DarkRP.createEntity("Медицинский Терминал", {
		ent = "terminal_medicmod",
		model = "models/medicmod/radio/radio.mdl",
		price = 1,
		max = 2,
		cmd = "buyradio",
		category = "X-ray Machine",
		allowed = {"TEAM_74CPL","TEAM_74SGT","TEAM_74LT","TEAM_74CPT","TEAM_74MJR","TEAM_74COL","TEAM_74CO"},
	})