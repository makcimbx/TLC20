
--[[
	local weapon = {}
	weapon.ID = "tfa_swch_dc15a" // The tntiy of the weapon Q Menu < Weapons < Right Click < Copy to clipboard
	weapon.Name = 'DC15a Blaster' // Name of weapon you want it to be
	weapon.Price = 45000 // Price of wep
	weapon.Model = "models/weapons/w_dc15a.mdl" // model path to the weapon
	weapon.Usergroup = {"Donator", "Owner"} // Usergroups *****IF NO USERGROUP THEN REMOVE THIS LINE ******
	weapon.Job = {TEAM_CITIZEN, TEAM_POLICE} // Teams *****IF NOT TEAM THEN REMOVE THIS LINE ******
	weapon.DeployCost = 250 // DeployCost *****IF NO DEPLOY COST THEN REMOVE THIS LINE ****
	SArmory.Action.registerWeapon(weapon) <---- ALWAYS HAVE THIS AT THE END OF THE WEAPON

--]]



local weapon = {}
weapon.ID = "tfa_dc15s_ashura_custom"
weapon.Name = 'Винтовка DC-15s'
weapon.Price = 15000
weapon.Model = "models/servius/starwars/ashura/dc15s.mdl"
weapon.DeployCost = 250
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_dc15x_custom"
weapon.Name = 'Снайперская Винтовка DC-15x'
weapon.Price = 20000
weapon.Model = "models/swbf3/rep/sniperrifle.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_dc17_custom"
weapon.Name = 'Пистолет DC-17'
weapon.Price = 10000
weapon.Model = "models/weapons/w_dc17.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "weapon_frag"
weapon.Name = 'Детонатор'
weapon.Price = 5000
weapon.Model = "models/weapons/w_npcnade.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "models/weapons/w_clonelauncher.mdl"
weapon.Name = 'RPS-6 Ракетница'
weapon.Price = 30000
weapon.Model = "models/nate159/swbf2015/pewpew/rocketlauncher.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_swch_z6"
weapon.Name = 'Z6 Бластерный Пулемёт'
weapon.Price = 65000
weapon.Model = "models/weapons/w_z6_rotary_blaster.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_westarm5_custom"
weapon.Name = 'Бластерная Винтовка WESTAR-M5'
weapon.Price = 45000
weapon.Model = "models/weapons/w_alphablaster.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_dc17dual_custom"
weapon.Name = 'Двойные Пистолеты DC-17'
weapon.Price = 17000
weapon.Model = "models/weapons/w_dc17.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "weapon_combineshield"
weapon.Name = 'Щит'
weapon.Price = 18000
weapon.Model = "models/cloud/ballisticshield_mod.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "weapon_slam"
weapon.Name = 'Дистанционная Мина'
weapon.Price = 20000
weapon.Model = "models/weapons/w_slam.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_sw_repshot"
weapon.Name = 'Бластерный Дробовик DC-15h'
weapon.Price = 12000
weapon.Model = "models/swbf3/rep/shotgun.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "repair_tool"
weapon.Name = 'Инструменты Пилота'
weapon.Price = 8500
weapon.Model = "models/starwars/syphadias/props/sw_tor/bioware_ea/items/harvesting/scavenge/scavenge_cargo.mdl"
weapon.Job = {TEAM_PLTCR, TEAM_PLT}
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "ammoaura"
weapon.Name = 'Аура раздачи патрон'
weapon.Price = 40000
weapon.Model = "models/energy_cell.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "armoraura"
weapon.Name = 'Аура поднятия брони'
weapon.Price = 40000
weapon.Model = "models/cire992/props2/containment_cells_01.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "models/effects/hexshield.mdl"
weapon.Name = 'Персональный Энерго-Щит'
weapon.Price = 25000
weapon.Model = "models/ut2004/bio_ammo.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "weapon_alphacrate"
weapon.Name = 'Раздача боеприпасов'
weapon.Price = 25000
weapon.Model = "models/power_cell.mdl"
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "healaura"
weapon.Name = 'Аура лечения здоровья'
weapon.Price = 40000
weapon.Model = "models/props/asgclonewars/medic_pack.mdl"
weapon.Job = {TEAM_MEDIC, TEAM_MEDIC1, TEAM_MEDIC2, TEAM_MEDIC3, TEAM_MEDIC4, TEAM_MEDIC5, TEAM_MEDIC6, TEAM_MEDIC7, TEAM_MEDIC8}
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "tfa_dc15a_custom_medicvar"
weapon.Name = 'Медицинская Винтовка DC-15a'
weapon.Price = 20000
weapon.Model = "models/weapons/w_dc15a_neue.mdl"
weapon.Job = {TEAM_MEDIC, TEAM_MEDIC1, TEAM_MEDIC2, TEAM_MEDIC3, TEAM_MEDIC4, TEAM_MEDIC5, TEAM_MEDIC6, TEAM_MEDIC7, TEAM_MEDIC8}
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "weapon_bactanadefixed"
weapon.Name = 'Бакта-Граната'
weapon.Price = 25000
weapon.Model = "models/riddickstuff/bactagrenade/bactanade.mdl"
weapon.Job = {TEAM_MEDIC, TEAM_MEDIC1, TEAM_MEDIC2, TEAM_MEDIC3, TEAM_MEDIC4, TEAM_MEDIC5, TEAM_MEDIC6, TEAM_MEDIC7, TEAM_MEDIC8}
SArmory.Action.registerWeapon(weapon)

local weapon = {}
weapon.ID = "models/bacta_small.mdl"
weapon.Name = 'Медицинские Приборы'
weapon.Price = 18000
weapon.Model = "models/haxxer/me2_props/medcrate.mdl"
weapon.Job = {TEAM_MEDIC, TEAM_MEDIC1, TEAM_MEDIC2, TEAM_MEDIC3, TEAM_MEDIC4, TEAM_MEDIC5, TEAM_MEDIC6, TEAM_MEDIC7, TEAM_MEDIC8}
SArmory.Action.registerWeapon(weapon)