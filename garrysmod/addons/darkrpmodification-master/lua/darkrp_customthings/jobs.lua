--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------
This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
      Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields

Add your custom jobs under the following line:
---------------------------------------------------------------------------]]

TEAM_CADET = DarkRP.createJob("Кадет", {
	color = Color(211, 124, 103, 255),
	model = "models/smitty/bf2_reg/clone_recruit/clone_recruit.mdl",
	description = [[Кадет, ожидающий старшего для того что бы пройти тренировку.]],
	weapons = {},
	command = "cadet",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 0,
	hasLicense = false,
	candemote = false,
})


TEAM_501CT = DarkRP.createJob("501-й Клон Солдат", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "501ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	maxHP=500,
	maxAM=100,
	level = 1,
	OnPlayerChangedTeam = function(ply)
		timer.Simple(0.1,function()
			ply:SetBodygroup(1,1) 
		end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501TRP = DarkRP.createJob("501-й Солдат", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы часть 501-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "501trp",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 10,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply)
		timer.Simple(0.1,function()
			ply:SetBodygroup(1,0) 
			ply:SetBodygroup(2,0) 
			ply:SetBodygroup(3,0) 
			ply:SetBodygroup(4,0) 
			ply:SetBodygroup(5,0) 
			ply:SetBodygroup(6,0)
		end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501GUNNER = DarkRP.createJob("501-й Пулеметчик", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/swbf2heavygunner/501st/501st.mdl",
	description = [[Поздравляем, теперь вы часть 501-го легиона!]],
	weapons = {"tfa_swch_z6","tfa_dc17chrome","clone_card_c5"},
	command = "501gunner",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	level = 20,
	maxHP=500,
	maxAM=100,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501GRENADETRP = DarkRP.createJob("501-й Гранатометчик", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/vnvariants/501/501.mdl",
	description = [[Поздравляем, теперь вы часть 501-го легиона!]],
	weapons = {"tfa_swch_clonelauncher","tfa_dc15s_ashura","clone_card_c5"},
	command = "501granadetrp",
	max = 2,
	salary = 0,
	admin = 0,
	vote = false,
	level = 20,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply)
		timer.Simple(0.1,function()
			ply:SetBodygroup(0,0) 
			ply:SetBodygroup(1,1) 
			ply:SetBodygroup(2,0) 
			ply:SetBodygroup(3,1) 
			ply:SetBodygroup(4,0) 
			ply:SetBodygroup(5,0) 
			ply:SetBodygroup(6,1)
			ply:SetBodygroup(7,0)
			ply:SetBodygroup(8,1)
			ply:SetBodygroup(9,0)
		end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501CPL = DarkRP.createJob("501-й Капрал", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы капрал 501-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c5"},
	command = "501cpl",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 20,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply)
		timer.Simple(0.1,function()
			ply:SetBodygroup(0,0) 
			ply:SetBodygroup(1,0) 
			ply:SetBodygroup(2,0) 
			ply:SetBodygroup(3,0) 
			ply:SetBodygroup(4,0) 
			ply:SetBodygroup(5,0)
			ply:SetBodygroup(6,1)
		end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501SGT = DarkRP.createJob("501-й Сержант", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы сержант 501-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "501sgt",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 30,
	maxHP=500,
	maxAM=100,	
	OnPlayerChangedTeam = function(ply)
		if SERVER then
			ply:bestSetSize(0.6)
		end
		timer.Simple(0.1,function()
			ply:SetBodygroup(0,0) 
			ply:SetBodygroup(1,1) 
			ply:SetBodygroup(2,0) 
			ply:SetBodygroup(3,0) 
			ply:SetBodygroup(4,0) 
			ply:SetBodygroup(5,0)
			ply:SetBodygroup(6,0)
		end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501LT = DarkRP.createJob("501-й Лейтенант", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы сержант 501-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "501lt",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 40,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501CPT = DarkRP.createJob("501-й Капитан", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы капитан 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "501cpt",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 50,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501MJR = DarkRP.createJob("501-й Майор", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы майор 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "501mjr",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 60,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)	
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501COL = DarkRP.createJob("501-й Подполковник", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/501st/bf2501.mdl",
	description = [[Поздравляем, теперь вы подполковник 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "501col",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 80,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501CO = DarkRP.createJob("501-й Командир", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/rex/bf2rex.mdl",
	description = [[Поздравляем, теперь вы командир 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "501co",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501CC = DarkRP.createJob("501-й Клон-Командер", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/rex/bf2rex.mdl",
	description = [[Поздравляем, теперь вы командир 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "501cc",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})

TEAM_501MC = DarkRP.createJob("501-й Маршал-Командер", {
	color = Color(50, 50, 255, 255),
	model = "models/player/ven/bf2_reg/rex/bf2rex.mdl",
	description = [[Поздравляем, теперь вы командир 501-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "501mc",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	hasLicense = false,
	candemote = false,
	category = "501st legion",
})


TEAM_212CT = DarkRP.createJob("212-й Клон Солдат", {
	color = Color(244, 210, 74, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "212ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "212 AB",
})

TEAM_212TRP = DarkRP.createJob("212-й Солдат", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы часть 212-го штурмового батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "212trp",
	max = 0,
	salary = 50,
	level = 10,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,0)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212CPL = DarkRP.createJob("212-й Капрал", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы капрал 212-го штурмового батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c5"},
	command = "212cpl",
	max = 0,
	salary = 50,
	level = 20,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212SGT = DarkRP.createJob("212-й Сержант", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы сержант 212-го штурмового батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "212sgt",
	max = 0,
	salary = 50,
	level = 30,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212LT = DarkRP.createJob("212-й Лейтенант", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы лейтенант 212-го штурмового батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "212lt",
	max = 0,
	salary = 50,
	level = 40,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212CPT = DarkRP.createJob("212-й Капитан", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы капитан 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "212cpt",
	max = 0,
	salary = 50,
	level = 50,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212MJR = DarkRP.createJob("212-й Майор", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы майор 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "212MJR",
	max = 0,
	salary = 50,
	level = 60,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)	
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212COL = DarkRP.createJob("212-й Подполковник", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/212th/bf2212.mdl",	
	description = [[Поздравляем, теперь вы подполковник 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "212col",
	max = 0,
	salary = 50,
	level = 80,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212CO = DarkRP.createJob("212-й Командир", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/cody/bf2cody.mdl",	
	description = [[Поздравляем, теперь вы командир 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "212co",
	max = 0,
	salary = 50,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212CC = DarkRP.createJob("212-й Клон-Командер", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/cody/bf2cody.mdl",	
	description = [[Поздравляем, теперь вы командир 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "212cc",
	max = 0,
	salary = 50,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_212MC = DarkRP.createJob("212-й Маршал-Командер", {
	color = Color(244, 210, 74, 255),
    model = "models/player/ven/bf2_reg/cody/bf2cody.mdl",	
	description = [[Поздравляем, теперь вы командир 212-го штурмового батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "212mc",
	max = 0,
	salary = 50,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_2NDTRP = DarkRP.createJob("212-й Пулеметчик", {
	color = Color(244, 210, 74, 255),
	model = "models/gonzo/swbf2heavygunner/212th/212th.mdl",
	description = [[Поздравляем, теперь вы пулеметчик 212!]],
	weapons = {"tfa_swch_z6","tfa_dc17chrome","clone_card_c5"},
	command = "212heavygunner",
	max = 2,
	salary = 60,
	admin = 0,
	level = 20,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})

TEAM_2NDGRENADE = DarkRP.createJob("212-й Гранатометчик", {
	color = Color(244, 210, 74, 255),
	model = "models/gonzo/vnvariants/212/212.mdl",
	description = [[Поздравляем, теперь вы гранатометчик 212!]],
	weapons = {"tfa_swch_clonelauncher","tfa_dc15s_ashura","clone_card_c5"},
	command = "212grenade",
	max = 2,
	salary = 60,
	admin = 0,
	level = 30,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	ply:SetBodygroup(7,0)
	ply:SetBodygroup(8,1)
	ply:SetBodygroup(9,0)
	end)
	end,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "212 AB",
	candemote = false,
})


TEAM_41CT = DarkRP.createJob("41-й Клон Солдат", {
	color = Color(133, 133, 133),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "41ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "41st legion",
})

TEAM_41TRP = DarkRP.createJob("41-й Солдат", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы часть 41-го Легиона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","clone_card_c5"},
	command = "41thtrp",
	max = 0,
	level = 10,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41CPL = DarkRP.createJob("41-й Капрал", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы капрал 41-го Легиона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","clone_card_c5"},
	command = "41thcpl",
	max = 0,
	level = 20,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41SGT = DarkRP.createJob("41-й Сержант", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы сержант 41-го Легиона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "41thsgt",
	max = 0,
	level = 30,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41LT = DarkRP.createJob("41-й Лейтенант", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы лейтенант 41-го Легиона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "41thlt",
	max = 0,
	level = 40,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41CPT = DarkRP.createJob("41-й Капитан", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы капитан 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "41thcpt",
	max = 0,
	level = 50,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41MJR = DarkRP.createJob("41-й Майор", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы майор 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "41thmjr",
	max = 0,
	level = 60,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41COL = DarkRP.createJob("41-й Подполковник", {
	color = Color(133, 133, 133),
	model = "models/gonzo/swbf2greencompany/gctrooper/gctrooper.mdl",
	description = [[Поздравляем, теперь вы майор 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "41thcol",
	max = 0,
	level = 80,
	salary = 70,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41CO = DarkRP.createJob("41-й Командир", {
	color = Color(133, 133, 133),
	model = "models/player/ven/bf2_reg/gree/bf2gree.mdl",
	description = [[Поздравляем, теперь вы командир 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "41thco",
	max = 0,
	level = 1,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41CC = DarkRP.createJob("41-й Клон-Командер", {
	color = Color(133, 133, 133),
	model = "models/player/ven/bf2_reg/gree/bf2gree.mdl",
	description = [[Поздравляем, теперь вы командир 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "41thcc",
	max = 0,
	level = 1,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_41MC = DarkRP.createJob("41-й Маршал-Командер", {
	color = Color(133, 133, 133),
	model = "models/player/ven/bf2_reg/gree/bf2gree.mdl",
	description = [[Поздравляем, теперь вы командир 41-го Легиона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "41thmc",
	max = 0,
	level = 1,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_GCSCOUT = DarkRP.createJob("41-й Разведчик", {
	color = Color(62, 126, 52, 255),
	model = "models/smitty/bf_gc/sm_faie_alt.mdl",
	description = [[Поздравляем, теперь вы разведчик 41-го Легиона!]],
	weapons = {"tfa_swch_dc15a_scoped", "tfa_dc15s_ashura", "zeus_flashbang", "zeus_smokegranade", "realistic_hook","clone_card_c5"},
	command = "gcscout",
	max = 10,
	level = 25,
	salary = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "41st legion",
	candemote = false,
})

TEAM_GCSNP = DarkRP.createJob("41-й Снайпер", {
	color = Color(62, 126, 52, 255),
	model = "models/gonzo/swbf2greencompany/gcarf/gcarf.mdl",
	description = [[Поздравляем, теперь вы снайпер 41-го Легиона!]],
	weapons = {"tfa_sw_repsnip", "tfa_dc15s_ashura", "zeus_smokegranade", "zeus_flashbang", "realistic_hook","clone_card_c5"},
	command = "gcsnp",
	max = 2,
	level = 30,
	salary = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "41st legion",
	candemote = false,
})


TEAM_91CT = DarkRP.createJob("91-й Клон Солдат", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "91ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "91st Recon Corps",
})

TEAM_91TRP = DarkRP.createJob("91-й Солдат", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы часть 91-го батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","clone_card_c5"},
	command = "91trp",
	max = 0,
	salary = 60,
	admin = 0,
	level = 10,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply)
timer.Simple(0.1,function()	
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91CPL = DarkRP.createJob("91-й Капрал", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы часть 91-го батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","clone_card_c5"},
	command = "91cpl",
	max = 0,
	salary = 60,
	admin = 0,
	level = 20,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91SGT = DarkRP.createJob("91-й Сержант", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Вы сержант 91-го разведывательного корпуса!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "91sgt",
	max = 0,
	salary = 85,
	admin = 0,
	level = 30,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91LT = DarkRP.createJob("91-й Лейтенант", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы Лейтенант 91-го батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "91lt",
	max = 0,
	salary = 120,
	admin = 0,
	level = 40,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91CPT = DarkRP.createJob("91-й Капитан", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы Капитан 91-го батальона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "91cpt",
	max = 0,
	salary = 140,
	admin = 0,
	level = 50,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91MJR = DarkRP.createJob("91-й Майор", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы Майор 91-го батальона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "91mjr",
	max = 0,
	salary = 140,
	admin = 0,
	level = 60,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)	
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91COL = DarkRP.createJob("91-й Подполковник", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/91st/bf291.mdl"},
	description = [[Поздравляем, теперь вы Подполковник 91-го полка!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "91col",
	max = 0,
	salary = 75,
	admin = 0,
	level = 80,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91CO = DarkRP.createJob("91-й Командир", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/neyo/bf2neyo.mdl"},
	description = [[Поздравляем, теперь вы Командир 91-го батальона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "91co",
	max = 1,
	salary = 500,
	admin = 0,
	level = 1,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91CC = DarkRP.createJob("91-й Клон-Командер", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/neyo/bf2neyo.mdl"},
	description = [[Поздравляем, теперь вы Командир 91-го батальона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "91cc",
	max = 1,
	salary = 500,
	admin = 0,
	level = 1,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91MC = DarkRP.createJob("91-й Маршал-Командер", {
	color = Color(200, 0, 25, 255),
	model = {"models/player/ven/bf2_reg/neyo/bf2neyo.mdl"},
	description = [[Поздравляем, теперь вы Командир 91-го батальона!]],
	weapons = {"tfa_ee3_extended", "tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "91mc",
	max = 1,
	salary = 500,
	admin = 0,
	level = 1,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91SCOUT = DarkRP.createJob("91-й Разведчик", {
	color = Color(200, 0, 25, 255),
	model = {"models/gonzo/327thand91st/91starf/91starf.mdl"},	
	description = [[Поздравляем, теперь вы разведчик 91-го батальона!]],
	weapons = {"tfa_swch_dc15a_scoped", "tfa_dc15s_ashura", "zeus_flashbang", "zeus_smokegranade", "realistic_hook","clone_card_c5"},
	command = "91scout",
	max = 10,
	salary = 500,
	admin = 0,
	level = 25,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})

TEAM_91SNP = DarkRP.createJob("91-й Снайпер", {
	color = Color(200, 0, 25, 255),
	model = {"models/gonzo/327thand91st/91starf/91starf.mdl"},	
	description = [[Поздравляем, теперь вы снайпер 91-го батальона!]],
	weapons = {"tfa_sw_repsnip", "tfa_dc15s_ashura", "zeus_smokegranade", "zeus_flashbang", "realistic_hook","clone_card_c5"},
	command = "91snp",
	max = 2,
	salary = 500,
	admin = 0,
	level = 30,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "91st Recon Corps",
	candemote = false,
})


TEAM_327CT = DarkRP.createJob("327-й Клон Солдат", {
	color = Color(150, 75, 0),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "327ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "327st",
})

TEAM_327TRP = DarkRP.createJob("327-й Солдат", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы часть 327-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "327trp",
	max = 0,
	salary = 50,
	level = 10,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327CPL = DarkRP.createJob("327-й Капрал", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы капрал 327-го легиона!]],
	weapons = {"tfa_swch_dc15a", "tfa_swch_dc17","clone_card_c5"},
	command = "327cpl",
	max = 0,
	salary = 50,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327SGT = DarkRP.createJob("327-й Сержант ", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы сержант 327-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "327sgt",
	max = 0,
	salary = 75,
	level = 40,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327LT = DarkRP.createJob("327-й Лейтенант", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы Лейтенант 327-го звездного корпуса!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "327lt",
	max = 0,
	salary = 75,
	admin = 0,
	level = 50,
	maxHP=650,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,	
})

TEAM_327CPT = DarkRP.createJob("327-й Капитан ", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы Капитан 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "327cpt",
	max = 0,
	level = 60,
	salary = 75,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327MJR = DarkRP.createJob("327-й Майор", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы майор 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "327mjr",
	max = 0,
	salary = 70,
	level = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)	
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327COL = DarkRP.createJob("327-й Подполковник", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы Подполковник 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "327col",
	max = 0,
	salary = 80,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327CO = DarkRP.createJob("327-й Командир", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/bly/bf2bly.mdl",
	description = [[Поздравляем, теперь вы Командир 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "327co",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327CC = DarkRP.createJob("327-й Клон-Командер", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/bly/bf2bly.mdl",
	description = [[Поздравляем, теперь вы Командир 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "327cc",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327MC = DarkRP.createJob("327-й Маршал-Командер", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/bly/bf2bly.mdl",
	description = [[Поздравляем, теперь вы Командир 327-го легиона!]],
	weapons = {"tfa_swch_dc15a","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "327mc",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327JETTRP = DarkRP.createJob("327-й Солдат c ранцем", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы Солдат c ранцем 327-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c5"},
	command = "327jettrp",
	max = 2,
	salary = 80,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})

TEAM_327FLAMETRP = DarkRP.createJob("327-й Огнеметчик", {
	color = Color(150, 75, 0),
	model = "models/player/ven/bf2_reg/327th/bf2327.mdl",
	description = [[Поздравляем, теперь вы Сержант с ранцем 327-го легиона!]],
	weapons = {"flamethrower_basic","tfa_dc15s_ashura","zeus_thermaldet","zeus_smokegranade","clone_card_c5"},
	command = "327flametrp",
	max = 2,
	salary = 100,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "327st",
	candemote = false,
})


TEAM_104CT = DarkRP.createJob("104-й Клон Солдат", {
	color = Color(92, 183, 222, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "104ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "104st",
})

TEAM_104TRP = DarkRP.createJob("104-й Солдат", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы часть 104-го батальона!]],
	weapons = {"tfa_swch_dc15a","tfa_dc17chrome","clone_card_c5"},
	command = "104trp",
	max = 0,
	salary = 50,
	level = 10,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104CPL = DarkRP.createJob("104-й Капрал", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы капрал 104-го батальона!]],
	weapons = {"tfa_swch_dc15a", "tfa_swch_dc17","clone_card_c5"},
	command = "104cpl",
	max = 0,
	salary = 50,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104SGT = DarkRP.createJob("104-й Сержант ", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы сержант 104-го батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","clone_card_c6"},
	command = "104sgt",
	max = 0,
	salary = 75,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104LT = DarkRP.createJob("104-й Лейтенант", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы Лейтенант 104-го батальона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "104lt",
	max = 0,
	salary = 75,
	admin = 0,
	level = 40,
	maxHP=650,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,	
})

TEAM_104CPT = DarkRP.createJob("104-й Капитан ", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы Капитан 104-го батальона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "140cpt",
	max = 0,
	level = 50,
	salary = 75,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104MJR = DarkRP.createJob("104-й Майор", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы майор 104-го батальона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "104mjr",
	max = 0,
	salary = 80,
	level = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)	
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104COL = DarkRP.createJob("104-й Подполковник", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы Подполковник 104-го батальона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c7"},
	command = "104col",
	max = 0,
	salary = 80,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104CO = DarkRP.createJob("104-й Командир", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/wolffe/bf2wolffe.mdl",
	description = [[Поздравляем, теперь вы Командир 104-го легиона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "104co",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104CC = DarkRP.createJob("104-й Клон-Командер", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/wolffe/bf2wolffe.mdl",
	description = [[Поздравляем, теперь вы Командир 104-го легиона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "104cc",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104MC = DarkRP.createJob("104-й Маршал-Командер", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/wolffe/bf2wolffe.mdl",
	description = [[Поздравляем, теперь вы Командир 104-го легиона!]],
	weapons = {"tfa_e11d_extended","tfa_sw_dc17dual","zeus_thermaldet","zeus_smokegranade","clone_card_c8","weapon_physgun"},
	command = "104MC",
	max = 0,
	salary = 80,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104FLMTRP = DarkRP.createJob("104-й Огнеметчик", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы огнеметчик 104-го легиона!]],
	weapons = {"flamethrower_basic","tfa_dc15s_ashura","zeus_thermaldet","zeus_smokegranade","clone_card_c5"},
	command = "104flmtrp",
	max = 2,
	salary = 80,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "104st",
	candemote = false,
})

TEAM_104JETTRP = DarkRP.createJob("104-й Солдат с ранцем", {
	color = Color(92, 183, 222, 255),
	model = "models/player/ven/bf2_reg/104th/bf2104.mdl",
	description = [[Поздравляем, теперь вы солдат с ранцем 104-го легиона!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","zeus_smokegranade","clone_card_c5"},
	command = "104jettrp",
	max = 4,
	salary = 100,
	level = 40,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "104st",
	candemote = false,
})


TEAM_EODCT = DarkRP.createJob("EOD Клон Солдат", {
	color = Color(244, 210, 74, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5"},
	command = "eodct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "EOD",
})

TEAM_EODTRP = DarkRP.createJob("EOD Солдат", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы часть EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c5"},
	command = "eodtrp",
	max = 0,
	salary = 50,
	level = 10,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODCPL = DarkRP.createJob("EOD Капрал", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы капрал EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","zeus_thermaldet","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c5"},
	command = "eodcpl",
	max = 0,
	salary = 60,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODSGT = DarkRP.createJob("EOD Сержант", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы сержант EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","seal6-c4","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c6"},
	command = "eodsgt",
	max = 0,
	salary = 80,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODLT = DarkRP.createJob("EOD Лейтенант", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы лейтенант EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","seal6-c4","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c7"},
	command = "eodlt",
	max = 0,
	salary = 90,
	level = 40,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODCPT = DarkRP.createJob("EOD Капитан", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы капитан EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c7"},
	command = "eodcpt",
	max = 0,
	salary = 90,
	level = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODMJR = DarkRP.createJob("EOD Майор", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы майор EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c7"},
	command = "eodmjr",
	max = 0,
	salary = 90,
	level = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)	
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODCOL = DarkRP.createJob("EOD Подполковник", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы подполковник EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c7"},
	command = "eodcol",
	max = 0,
	salary = 100,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODCO = DarkRP.createJob("EOD Командир", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы Командир EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c8","gmod_tool","tfa_sw_dc17dual"},
	command = "eodco",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODCC = DarkRP.createJob("EOD Клон-Командер", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы Командир EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c8","gmod_tool"},
	command = "eodcc",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODMC = DarkRP.createJob("EOD Маршал-Командер", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы Командир EOD!]],
	weapons = {"tfa_dc15s_ashura","tfa_sw_repshot","zeus_thermaldet","weapon_swrc_det","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c8","gmod_tool"},
	command = "eodmc",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})

TEAM_EODDEM = DarkRP.createJob("EOD Подрывник", {
	color = Color(244, 210, 74, 255),
	model = "models/player/ven/bf2_reg/eod/bf2eod.mdl",
	description = [[Поздравляем, теперь вы часть EOD!]],
	weapons = {"tfa_sw_repshot","tfa_dc17chrome","zeus_thermaldet","weapon_physgun","weapon_physcannon","repair_tool","clone_card_c5","weapon_swrc_det"},
	command = "eoddemoman",
	max = 0,
	salary = 50,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "EOD",
	candemote = false,
})


TEAM_74CT = DarkRP.createJob("74-й Клон Солдат", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/helmetlessclone/helmetlessclone.mdl",
	description = [[]],
	weapons = {"tfa_dc15s_ashura","tfa_dc17chrome","clone_card_c5","darkrp_defibrillator","med_kit"},
	command = "74ct",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	level = 1,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(1,1)
	end)
	end,
	hasLicense = false,
	candemote = false,
	category = "74th medical corps",
})

TEAM_74TRP = DarkRP.createJob("74-й Солдат", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы часть 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c5","darkrp_defibrillator","med_kit"},
	command = "74trp",
	max = 0,
	level = 10,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,0) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74CPL = DarkRP.createJob("74-й Капрал", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы капрал 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","weapon_physgun","weapon_physcannon","darkrp_defibrillator","med_kit"},
	command = "74cpl",
	max = 0,
	salary = 70,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74SGT = DarkRP.createJob("74-й Сержант", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы Сержант 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c6","darkrp_defibrillator","med_kit"},
	command = "74sgt",
	max = 0,
	level = 30,
	salary = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,0) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74LT = DarkRP.createJob("74-й Лейтенант", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы Лейтенант 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c7","darkrp_defibrillator","med_kit"},
	command = "74lt",
	max = 0,
	salary = 100,
	level = 40,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,1) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74CPT = DarkRP.createJob("74-й Капитан", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы капитан 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c7","darkrp_defibrillator","med_kit"},
	command = "74cpt",
	max = 0,
	salary = 120,
	level = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74MJR = DarkRP.createJob("74-й Майор", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы майор 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c7","darkrp_defibrillator","med_kit"},
	command = "74mjr",
	max = 0,
	salary = 110,
	level = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74COL = DarkRP.createJob("74-й Подполковник", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы подполковник 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","clone_card_c7","darkrp_defibrillator","med_kit"},
	command = "74col",
	max = 0,
	salary = 160,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74CO = DarkRP.createJob("74-й Командир", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы Командир 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","weapon_physgun","clone_card_c8","darkrp_defibrillator","med_kit"},
	command = "74co",
	max = 0,
	level = 1,
	salary = 500,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,1) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74CC = DarkRP.createJob("74-й Клон-Командер", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы Командир 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","weapon_physgun","clone_card_c8","darkrp_defibrillator","med_kit"},
	command = "74cc",
	max = 0,
	level = 1,
	salary = 500,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,1) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})

TEAM_74MC = DarkRP.createJob("74-й Маршал-Командер", {
	color = Color(200, 0, 25, 255),
	model = "models/gonzo/swbf2ahsoka/theta/theta.mdl",
	description = [[Поздравляем, теперь вы Командир 74!]],
	weapons = {"tfa_dc15a_custom_medicvar","tfa_dc17chrome","weapon_physgun","clone_card_c8","darkrp_defibrillator","med_kit"},
	command = "74mc",
	max = 0,
	level = 1,
	salary = 500,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,1) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,1) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1) 
	ply:SetBodygroup(6,1) 
	ply:SetSkin(1) 
	end)
	end,
	vote = false,
	category = "74th medical corps",
	candemote = false,
})


TEAM_ARCSNP = DarkRP.createJob("ЭРК Снайпер", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/yellowarc/yellowarc.mdl",
	description = [[Поздравляем, теперь вы Элитный Разведывательный Коммандос!]],
	weapons = {"tfa_sw_repsnip", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c5"},
	command = "arcsnp",
	max = 0,
	salary = 75,
	level = 40,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCGRENADE = DarkRP.createJob("ЭРК Гранатометчик", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/yellowarc/yellowarc.mdl",
	description = [[Поздравляем, теперь вы Элитный Разведывательный Коммандос!]],
	weapons = {"tfa_swch_clonelauncher", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c5","weapon_combineshield"},
	command = "arcgrenade",
	max = 0,
	salary = 75,
	level = 20,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCGUNNER = DarkRP.createJob("ЭРК Пулеметчик", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/yellowarc/yellowarc.mdl",
	description = [[Поздравляем, теперь вы Элитный Разведывательный Коммандос!]],
	weapons = {"tfa_swch_z6", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c5","weapon_combineshield"},
	command = "arcgunner",
	max = 0,
	salary = 75,
	level = 30,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCTRP = DarkRP.createJob("ЭРК Солдат", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/bluearc/bluearc.mdl",
	description = [[Поздравляем, теперь вы Элитный Разведывательный Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c5"},
	command = "arctrp",
	max = 0,
	salary = 75,
	level = 10,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCCPL = DarkRP.createJob("ЭРК Капрал", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/bluearc/bluearc.mdl",
	description = [[Поздравляем, теперь вы капрал Элитный Разведывательный Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c5"},
	command = "arccpl",
	max = 0,
	salary = 75,
	level = 30,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCSGT = DarkRP.createJob("ЭРК Сержант", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/greenarc/greenarc.mdl",
	description = [[Поздравляем, теперь вы Сержант Элитного Разведывательного Коммандоса!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet","seal6-c4","clone_card_c6"},
	command = "arcsgt",
	max = 0,
	salary = 140,
	level = 45,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCLT = DarkRP.createJob("ЭРК Лейтенант", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/redarc/redarc.mdl",
	description = [[Поздравляем, теперь вы Лейтенант Элитного Разведывательного Коммандоса!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c7"},
	command = "arclt",
	max = 4,
	salary = 160,
	level = 65,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCCPT = DarkRP.createJob("ЭРК Капитан", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/modifiedarctrooperranks/redarc/redarc.mdl",
	description = [[Поздравляем, теперь вы Капитан Элитного Разведывательного Коммандоса!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c7"},
	command = "arccpt",
	max = 3,
	salary = 180,
	level = 80,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCMJR = DarkRP.createJob("ЭРК Майор", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/rancorarcs/blitz/blitz.mdl",
	description = [[Поздравляем, теперь вы майор Элитного Республиканского Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c7"},
	command = "arcmjr",
	max = 2,
	salary = 100,
	level = 90,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCCOL = DarkRP.createJob("ЭРК Подполковник", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/rancorarcs/colt/colt.mdl",
	description = [[Поздравляем, теперь вы подполковник Элитного Разведывательного Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c7"},
	command = "arccol",
	max = 0,
	salary = 95,
	level = 95,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCCO = DarkRP.createJob("ЭРК Командир", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/rancorarcs/havoc/havoc.mdl",
	description = [[Поздравляем, теперь вы командир Элитного Разведывательного Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c8","weapon_physgun"},
	command = "arcco",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCCC = DarkRP.createJob("ЭРК Клон-Командер", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/rancorarcs/havoc/havoc.mdl",
	description = [[Поздравляем, теперь вы командир Элитного Разведывательного Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c8","weapon_physgun"},
	command = "arccc",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})

TEAM_ARCMC = DarkRP.createJob("ЭРК Маршал-Командер", {
	color = Color(50, 50, 255, 255),
	model = "models/gonzo/rancorarcs/havoc/havoc.mdl",
	description = [[Поздравляем, теперь вы командир Элитного Разведывательного Коммандос!]],
	weapons = {"tfa_westarm5_custom", "tfa_dc17dual_custom", "zeus_smokegranade", "zeus_flashbang", "zeus_thermaldet", "seal6-c4","clone_card_c8","weapon_physgun"},
	command = "arcmc",
	max = 0,
	salary = 100,
	level = 1,
	admin = 0,
	maxHP=600,
	maxAM=100,
	vote = false,
	category = "ARC",
	candemote = false,
})


TEAM_RC = DarkRP.createJob("Республиканский Коммандос", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sgg/starwars/clone_commando.mdl",
	description = [[Поздравляем, теперь вы часть Республиканского Коммандоса, вы элита!]],
	weapons = {"tfa_westarm5_custom", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rc",
	max = 0,
	level = 80,
	salary = 150,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCSEV = DarkRP.createJob("RC Sev", {
	color = Color(0, 100, 100),
	model = "models/player/sgg/starwars/clone_commando_07.mdl",
	description = [[Поздравляем, теперь вы RC Sev, снайпер Республиканского Коммандоса!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcsev",
	max = 0,
	level = 0,
	salary = 300,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCSCORCH = DarkRP.createJob("RC Scorch", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sgg/starwars/clone_commando_62.mdl",
	description = [[Поздравляем, теперь вы RC Scorch, эксперт подрывник Республиканского Коммандоса!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcscorch",
	max = 0,
	level = 0,
	salary = 300,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCGREGOR = DarkRP.createJob("RC Gregor", {
	color = Color(247, 103, 17, 255),
	model = "models/player/star wars/gregor/clone_commando_gregor.mdl",
	description = [[Поздравляем, теперь вы RC Gregor!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcgregor",
	max = 0,
	salary = 300,
	admin = 0,
	level = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCFIXER = DarkRP.createJob("RC Fixer", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sgg/starwars/clone_commando_40.mdl",
	description = [[Поздравляем, теперь вы RC Fixer, технологический эксперт Республиканского Коммандоса!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcfixer",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCBOSS = DarkRP.createJob("RC Boss", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sgg/starwars/clone_commando_38.mdl",
	description = [[Поздравляем, теперь вы RC Boss, лидер Республиканского Коммандоса!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCARCHANGEL = DarkRP.createJob("RC Archangel", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/archangel.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss8",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCCONTORT = DarkRP.createJob("RC Contort", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/contort.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss9",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCEYESHARD = DarkRP.createJob("RC Eyeshard", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/eyeshard.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss10",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCGRIP = DarkRP.createJob("RC Grip", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/grip.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss11",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCHUSKIE = DarkRP.createJob("RC Huskie", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/huskie.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss12",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCKURZ = DarkRP.createJob("RC Kurz", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/kurz.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss13",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCSCORPION = DarkRP.createJob("RC Scorpion", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/scorpion.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss14",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCSTRIPE = DarkRP.createJob("RC Stripe", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/stripe.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss15",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCWATSON = DarkRP.createJob("RC Watson", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/watson.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss16",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCNUCK = DarkRP.createJob("RC Nuck", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/nuck.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss17",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCPRICE = DarkRP.createJob("RC Price", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/price.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss18",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCTRANKER = DarkRP.createJob("RC Tranker", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/tranker.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss19",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCACER = DarkRP.createJob("RC Acer", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/acer.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss20",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCHEADSHOT = DarkRP.createJob("RC Headshot", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/headshot.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss21",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCGRINDER = DarkRP.createJob("RC Grinder", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/grinder.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss22",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_RCTHUMBS = DarkRP.createJob("RC Thumbs", {
	color = Color(247, 103, 17, 255),
	model = "models/player/sono/Starwars/thumbs.mdl",
	description = [[Поздравляем!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "rcboss23",
	max = 0,
	salary = 600,
	level = 0,
	admin = 0,
	maxHP=800,
	maxAM=100,
	vote = false,
	category = "Republic Commando",
	candemote = false,
})

TEAM_SHTRPS = DarkRP.createJob("RC Shadow", {
	color = Color(0, 0, 0),
	model = "models/player/sgg/starwars/clone_commando_mp_a.mdl",
	description = [[Поздравляем, теперь вы солдат тени!]],
	weapons = {"tfa_swch_dc17m_br", "tfa_swch_dc17m_at", "tfa_dc17m_shotgun", "tfa_swch_dc17m_sn", "tfa_swch_dc15sa", "weapon_swrc_det", "zeus_thermaldet", "zeus_smokegranade", "zeus_flashbang","clone_card_c6"},
	command = "soldtrpsh",
	max = 0,
	salary = 500,
	admin = 0,
	level = 0,
	maxHP=1500,
	maxAM=100,
	vote = false,
	category = "Shadow",
	candemote = false,
})


TEAM_GUARDTRP = DarkRP.createJob("Гвардия Солдат", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы часть Гвардии!]],
	weapons = {"tfa_dc15s_ashura_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c5"},
	command = "guardtrp",
	max = 0,
	level = 10,
	salary = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDCPL = DarkRP.createJob("Гвардия Капрал", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы капрал Гвардии!]],
	weapons = {"tfa_dc15s_ashura_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c5"},
	command = "guardcpl",
	max = 0,
	level = 20,
	salary = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,0) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDSGT = DarkRP.createJob("Гвардия Сержант", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы сержант Гвардии!]],
	weapons = {"tfa_dc15s_ashura_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c6"},
	command = "guardsgt",
	max = 0,
	salary = 75,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,0)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDLT = DarkRP.createJob("Гвардия Лейтенант", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы Лейтенант Гвардии!]],
	weapons = {"tfa_dc15s_ashura_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c7"},
	command = "guardlt",
	max = 0,
	level = 40,
	salary = 90,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,0)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDCPT = DarkRP.createJob("Гвардия Капитан", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы Капитан Гвардии!]],
	weapons = {"tfa_dc15a_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c7"},
	command = "guardcpt",
	max = 0,
	level = 50,
	salary = 100,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,1) 
	ply:SetBodygroup(5,0) 
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDMJR = DarkRP.createJob("Гвардия Майор", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы Майор Гвардии!]],
	weapons = {"tfa_dc15a_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c7"},
	command = "guardmjr",
	max = 0,
	level = 60,
	salary = 110,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,0) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)	
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDCOL = DarkRP.createJob("Гвардия Подполковник", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/st/bf2st.mdl",
	description = [[Поздравляем, теперь вы подполковник Гвардии!]],
	weapons = {"tfa_dc15a_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c7"},
	command = "guardcol",
	max = 0,
	salary = 120,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	OnPlayerChangedTeam = function(ply) 
	timer.Simple(0.1,function()
	ply:SetBodygroup(0,0) 
	ply:SetBodygroup(1,1) 
	ply:SetBodygroup(2,1) 
	ply:SetBodygroup(3,0) 
	ply:SetBodygroup(4,0) 
	ply:SetBodygroup(5,1)
	ply:SetBodygroup(6,1)
	end)
	end,
	vote = false,
	category = "Guard",
	candemote = false,
})

TEAM_GUARDCO = DarkRP.createJob("Гвардия Командир", {
	color = Color(50, 50, 255),
	model = "models/player/ven/bf2_reg/fox/bf2fox.mdl",
	description = [[Поздравляем, теперь вы Командир Гвардии!]],
	weapons = {"tfa_dc15a_custom", "tfa_dc17_custom", "weapon_cuff_elastic", "weapon_stunstick", "zeus_flashbang","weapon_combineshield","clone_card_c8","weapon_physgun"},
	command = "guardco",
	max = 4,
	salary = 130,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "Guard",
	candemote = false,
})


TEAM_PILOTTRP = DarkRP.createJob("127-ое-крыло Пилот", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/grey_pilot_trooper/grey_pilot_trooper.mdl",
	description = [[Поздравляем, теперь вы часть 127-го-крыла-авиаподдержки!]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c5"},
	command = "pilottrp",
	max = 0,
	salary = 60,
	level = 10,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTCPL = DarkRP.createJob("127-ое-крыло Пилот Капрал", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/grey_pilot_lieutenant/grey_pilot_lieutenant.mdl",
	description = [[Поздравляем, теперь вы  Пилот Капрал 127-го-крыла-авиаподдержки!]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c5"},
	command = "pilotcpl",
	max = 0,
	salary = 60,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTSGT = DarkRP.createJob("127-ое-крыло Пилот Сержант", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/gold_pilot_sergeant/gold_pilot_sergeant.mdl",
	description = [[Поздравляем, теперь вы Пилот Сержант 127-го-крыла-авиаподдержки!]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c6"},
	command = "pilotsgt",
	max = 0,
	salary = 100,
	level = 30,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTLT = DarkRP.createJob("127-ое-крыло Пилот Лейтенант", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/gold_pilot_captain/gold_pilot_captain.mdl",
	description = [[Поздравляем, теперь вы Пилот Лейтенант 127-го-крыла-авиаподдержки!]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c7"},
	command = "pilotlt",
	max = 0,
	salary = 120,
	level = 40,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTCPT = DarkRP.createJob("127-ое-крыло Пилот Капитан", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/blue_pilot_captain/blue_pilot_captain.mdl",
	description = [[Поздравляем, теперь вы Пилот Капитан 127-го-крыла-авиаподдержки!]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c7"},
	command = "pilotcpt",
	max = 0,
	salary = 140,
	level = 50,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTMJR = DarkRP.createJob("127-ое-крыло Пилот Майор", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/red_pilot_captain/red_pilot_captain.mdl",
	description = [[Поздравляем, теперь вы Пилот Майор 127-го-крыла-авиаподдержки]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c7"},
	command = "pilotmjr",
	max = 1,
	salary = 500,
	level = 60,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTCOL = DarkRP.createJob("127-ое-крыло Пилот Подполковник", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/orange_pilot_major/orange_pilot_major.mdl",
	description = [[Поздравляем, теперь вы Пилот Подполковник 127-го-крыла-авиаподдержки]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c7"},
	command = "pilotcol",
	max = 1,
	salary = 500,
	level = 80,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})

TEAM_PILOTCO = DarkRP.createJob("127-ое-крыло Пилот Командир", {
	color = Color(253, 162, 82),
	model = "models/player/smitty/bf2_reg/orange_pilot_commander/orange_pilot_commander.mdl",
	description = [[Поздравляем, теперь вы Пилот Командир 127-го-крыла-авиаподдержки]],
	weapons = {"tfa_dc15s_ashura", "tfa_dc17chrome","clone_card_c8","weapon_physgun"},
	command = "pilotco",
	max = 1,
	salary = 500,
	level = 1,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "127th Wing-Aviation Support",
	candemote = false,
})


TEAM_ENSIN = DarkRP.createJob("Энсин", {
	color = Color(0, 200, 0, 255),
	model = "models/smitty/bf2_reg/black_officer/black_officer.mdl",
	description = [[Поздравляем, теперь вы Энсин]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "ensin",
	max = 0,
	salary = 750,
	level = 10,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_JUNIOROFFICER = DarkRP.createJob("Младший Офицер", {
	color = Color(0, 200, 0, 255),
	model = "models/smitty/bf2_reg/olive_officer/olive_officer.mdl",
	description = [[Поздравляем, теперь вы Младший офицер]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "juniorofficer",
	max = 0,
	salary = 750,
	level = 20,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_SENIOROFFICER = DarkRP.createJob("Старший офицер", {
	color = Color(0, 200, 0, 255),
	model = "models/smitty/bf2_reg/grey_officer/grey_officer.mdl",
	description = [[Поздравляем, теперь вы Старший офицер]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "seniorofficer",
	max = 0,
	salary = 750,
	admin = 0,
	level = 30,
	maxHP=750,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_LT = DarkRP.createJob("Лейтенант", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/lieutenant_playermodel.mdl",
	description = [[Поздравляем, теперь вы Лейтенант]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "lt",
	max = 0,
	salary = 750,
	admin = 0,
	level = 40,
	maxHP=1000,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_CPT = DarkRP.createJob("Капитан", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/captain_playermodel.mdl",
	description = [[Поздравляем, теперь вы Капитан]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "cpt",
	max = 0,
	salary = 750,
	level = 50,
	admin = 0,
	maxHP=1000,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_Commandor = DarkRP.createJob("Коммандор", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/commodore_playermodel.mdl",
	description = [[Поздравляем, теперь вы Коммандор]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "commandor",
	max = 0,
	salary = 750,
	admin = 0,
	level = 60,
	maxHP=1000,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_ADMIRAL = DarkRP.createJob("Адмирал", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/admiral_playermodel.mdl",
	description = [[Поздравляем, теперь вы Адмирал]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "admiral",
	max = 0,
	salary = 750,
	admin = 0,
	level = 70,
	maxHP=1500,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_VICEADMIRAL = DarkRP.createJob("Вице Адмирал", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/colonel_playermodel.mdl",
	description = [[Поздравляем, теперь вы Гранд-Адмирал]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "viceadmiral",
	max = 0,
	salary = 750,
	level = 80,
	admin = 0,
	maxHP=1500,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})

TEAM_ADMIRALFLEET = DarkRP.createJob("Адмирал Флота", {
	color = Color(0, 200, 0, 255),
	model = "models/kriegsyntax/starwars/grandadmiral_playermodel.mdl",
	description = [[Поздравляем, теперь вы Гранд-Адмирал]],
	weapons = {"tfa_dc17chrome","clone_card_c3nevy"},
	command = "admiralfleet",
	max = 0,
	salary = 750,
	level = 100,
	admin = 0,
	maxHP=1500,
	maxAM=100,
	vote = false,
	category = "Fleet",
	candemote = false,
})


TEAM_JEDIP2 = DarkRP.createJob("Юнлинг", {
	color = Color(60, 200, 255, 255),
model = {
		"models/jazzmcfly/jka/younglings/jka_young_male.mdl",
		"models/jazzmcfly/jka/younglings/jka_young_female.mdl",
		"models/jazzmcfly/jka/younglings/jka_young_shak.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c5","weapon_lightsaber_training"},
	command = "youngling",
	max = 0,
	category = "Jedi",
	salary = 0,
	level = 40,
	admin = 0,
	maxHP=100,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_JEDIP = DarkRP.createJob("Джедай Падаван", {
	color = Color(60, 200, 255, 255),
model = {
		"models/grealms/characters/padawan/padawan_01.mdl",
		"models/grealms/characters/padawan/padawan_02.mdl",
		"models/grealms/characters/padawan/padawan_03.mdl",
		"models/grealms/characters/padawan/padawan_03.mdl",
		"models/grealms/characters/padawan/padawan_04.mdl",
		"models/grealms/characters/padawan/padawan_05.mdl",
		"models/grealms/characters/padawan/padawan_06.mdl",
		"models/grealms/characters/padawan/padawan_07.mdl",
		"models/grealms/characters/padawan/padawan_08.mdl",
		"models/grealms/characters/padawan/padawan_09.mdl",
		"models/padawan2/padawan2.mdl",
		"models/padawan3/padawan3.mdl",
		"models/padawan4/padawan4.mdl",
		"models/player/grady/starwars/duros_padawan.mdl",
        "models/player/grady/starwars/keldor_padawan.mdl",
        "models/player/grady/starwars/mon_cala_padawan.mdl",
        "models/player/grady/starwars/rodian_padawan.mdl",
        "models/player/grady/starwars/zabrak_padawan.mdl",
		"models/gonzo/swtorjedi1/twilekjedi2/twilekjedi2.mdl",
		"models/players/femalejedi.mdl",
		"models/player/jedi/gotal.mdl",
		"models/player/jedi/gungan.mdl",
		"models/player/jedi/human.mdl",
		"models/player/jedi/nautolan.mdl",
		"models/player/jedi/pantoran.mdl",
		"models/player/jedi/quarren.mdl",
		"models/player/jedi/togruta.mdl",
		"models/player/jedi/trandoshan.mdl",
		"models/player/jedi/twilek.mdl",
		"models/player/jedi/twilek2.mdl",
		"models/player/jedi/umbaran.mdl",
		"models/player/jedi/zabrak.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "padawan",
	max = 0,
	category = "Jedi",
	salary = 0,
	admin = 0,
	level = 40,
	maxHP=1000,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_JEDIK = DarkRP.createJob("Джедай Рыцарь", {
	color = Color(60, 200, 255, 255),
	model = {
		"models/grealms/characters/jedibattlelord/jedibattlelord.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_01.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_02.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_03.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_04.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_05.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_06.mdl",
		"models/grealms/characters/jedibattlelord/jedibattlelord_07.mdl",
		"models/padawan2/padawan2.mdl",
		"models/padawan3/padawan3.mdl",
		"models/padawan4/padawan4.mdl",
		"models/player/grady/starwars/duros_master.mdl",
		"models/player/grady/starwars/keldor_master.mdl",
		"models/player/grady/starwars/mon_cala_master.mdl",
		"models/player/grady/starwars/rodian_master.mdl",
		"models/player/grady/starwars/zabrak_master.mdl",
		"models/gonzo/swtorjedi1/twilekjedi1/twilekjedi1.mdl",
		"models/gonzo/jedihoodmask/jedihoodmask.mdl",
		"models/player/jedi/gotal.mdl",
		"models/player/jedi/gungan.mdl",
		"models/player/jedi/human.mdl",
		"models/player/jedi/nautolan.mdl",
		"models/player/jedi/pantoran.mdl",
		"models/player/jedi/quarren.mdl",
		"models/player/jedi/togruta.mdl",
		"models/player/jedi/trandoshan.mdl",
		"models/player/jedi/twilek.mdl",
		"models/player/jedi/twilek2.mdl",
		"models/player/jedi/umbaran.mdl",
		"models/player/jedi/zabrak.mdl",
		"models/grealms/characters/bastila/bastila.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "knight",
	max = 0,
	salary = 0,
	category = "Jedi",
	admin = 0,
	level =60,
	maxHP=1250,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_JEDIS = DarkRP.createJob("Джедай Страж", {
	color = Color(255, 200, 0, 255),
	model = {
		"models/player/light_revan.mdl",
		"models/player/darth_revan.mdl",
		"models/player/darth_revan_brown.mdl",
		"models/padawan2/padawan2.mdl",
		"models/padawan3/padawan3.mdl",
		"models/padawan4/padawan4.mdl",
		"models/player/grady/starwars/duros_master.mdl",
		"models/player/grady/starwars/keldor_master.mdl",
		"models/player/grady/starwars/mon_cala_master.mdl",
		"models/player/grady/starwars/rodian_master.mdl",
		"models/player/grady/starwars/zabrak_master.mdl",
		"models/gonzo/swtorjedi1/twilekjedi1/twilekjedi1.mdl",
		"models/gonzo/jedihoodmask/jedihoodmask.mdl",
		"models/player/jedi/gotal.mdl",
		"models/player/jedi/gungan.mdl",
		"models/player/jedi/human.mdl",
		"models/player/jedi/nautolan.mdl",
		"models/player/jedi/pantoran.mdl",
		"models/player/jedi/quarren.mdl",
		"models/player/jedi/togruta.mdl",
		"models/player/jedi/trandoshan.mdl",
		"models/player/jedi/twilek.mdl",
		"models/player/jedi/twilek2.mdl",
		"models/player/jedi/umbaran.mdl",
		"models/player/jedi/zabrak.mdl",
		"models/grealms/characters/bastila/bastila.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "Sentinel",
	max = 0,
	category = "Jedi",
	salary = 0,
	admin = 0,
	level = 80,
	maxHP=1750,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_JEDIQ = DarkRP.createJob("Джедай Защитник", {
	color = Color(60, 200, 255, 255),
	model = {
		"models/jazzmcfly/jka/jtg/jtg.mdl",
		"models/player/darth_revan_grey.mdl",
		"models/padawan2/padawan2.mdl",
		"models/padawan3/padawan3.mdl",
		"models/padawan4/padawan4.mdl",
		"models/player/grady/starwars/duros_master.mdl",
		"models/player/grady/starwars/keldor_master.mdl",
		"models/player/grady/starwars/mon_cala_master.mdl",
		"models/player/grady/starwars/rodian_master.mdl",
		"models/player/grady/starwars/zabrak_master.mdl",
		"models/gonzo/swtorjedi1/twilekjedi1/twilekjedi1.mdl",
		"models/gonzo/jedihoodmask/jedihoodmask.mdl",
		"models/player/jedi/gotal.mdl",
		"models/player/jedi/gungan.mdl",
		"models/player/jedi/human.mdl",
		"models/player/jedi/nautolan.mdl",
		"models/player/jedi/pantoran.mdl",
		"models/player/jedi/quarren.mdl",
		"models/player/jedi/togruta.mdl",
		"models/player/jedi/trandoshan.mdl",
		"models/player/jedi/twilek.mdl",
		"models/player/jedi/twilek2.mdl",
		"models/player/jedi/umbaran.mdl",
		"models/player/jedi/zabrak.mdl",
		"models/grealms/characters/bastila/bastila.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "Guardian",
	max = 0,
	salary = 0,
	category = "Jedi",
	admin = 0,
	level = 80,
	maxHP=2000,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_JEDIKO = DarkRP.createJob("Джедай Консул", {
	color = Color(0, 200, 0, 255),
	model = {
		"models/grealms/characters/jedirobes/jedirobes_01.mdl",
		"models/grealms/characters/jedirobes/jedirobes_02.mdl",
		"models/grealms/characters/jedirobes/jedirobes_03.mdl",
		"models/grealms/characters/jedirobes/jedirobes_04.mdl",
		"models/grealms/characters/jedirobes/jedirobes_05.mdl",
		"models/grealms/characters/jedirobes/jedirobes_06.mdl",
		"models/grealms/characters/jedirobes/jedirobes_07.mdl",
		"models/grealms/characters/jedirobes/jedirobes_08.mdl",
		"models/grealms/characters/jedirobes/jedirobes_09.mdl",
		"models/padawan2/padawan2.mdl",
		"models/padawan3/padawan3.mdl",
		"models/padawan4/padawan4.mdl",
		"models/player/grady/starwars/duros_master.mdl",
		"models/player/grady/starwars/keldor_master.mdl",
		"models/player/grady/starwars/mon_cala_master.mdl",
		"models/player/grady/starwars/rodian_master.mdl",
		"models/player/grady/starwars/zabrak_master.mdl",
		"models/grealms/characters/bastila/bastila.mdl",
		"models/player/jedi/gotal.mdl",
		"models/player/jedi/gungan.mdl",
		"models/player/jedi/human.mdl",
		"models/player/jedi/nautolan.mdl",
		"models/player/jedi/pantoran.mdl",
		"models/player/jedi/quarren.mdl",
		"models/player/jedi/togruta.mdl",
		"models/player/jedi/trandoshan.mdl",
		"models/player/jedi/twilek.mdl",
		"models/player/jedi/twilek2.mdl",
		"models/player/jedi/umbaran.mdl",
		"models/player/jedi/zabrak.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "jediko",
	max = 0,
	salary = 0,
	admin = 0,
	level = 80,
	maxHP=1500,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_JEDIM = DarkRP.createJob("Гранд-Мастер", {
	color = Color(145, 145, 145, 255),
	model = "models/player/swtor/arsenic/jokal/jokal.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "Echo",
	max = 0,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_YODA = DarkRP.createJob("Йода", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_yodanojig.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "yoda",
	max = 1,
	salary = 0,
	admin = 0,
	level = 0,
	maxHP=2000,
	maxAM=100,
	OnPlayerChangedTeam = function(ply)
		if SERVER then
			ply:bestSetSize(0.6)
		end
	end,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_KENOBI = DarkRP.createJob("Оби-Ван Кеноби", {
	color = Color(60, 200, 255, 255),
	model = {
		"models/player/generalkenobi/cgikenobi.mdl",
		"models/tfa/comm/gg/pm_sw_obiwan_alt.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "kenobi",
	max = 1,
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_WINDU = DarkRP.createJob("Мэйс Винду", {
	color = Color(255, 0, 255, 255),
	model = "models/player/mace/mace.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "windu",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_KOON = DarkRP.createJob("Пло Кун", {
	color = Color(255, 200, 0, 255),
	model = "models/player/plokoon/plokoon.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "koon",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_SKYWALKER = DarkRP.createJob("Энакин Скайуокер", {
	color = Color(60, 200, 255, 255),
	model = {
		"models/tfa/comm/pm_sw_anakin_skywalker.mdl",
		"models/tfa/comm/gg/pm_sw_anakin_v2.mdl"
	},
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "skywalker",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_SECURA = DarkRP.createJob("Айла Секура", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_aayala.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "secura",
	max = 1,
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_MUNDI = DarkRP.createJob("Ки-Ади Мунди", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_mundi.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "mundi",
	max = 1,
	salary = 0,
	admin = 0,
	level = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_SAESEE = DarkRP.createJob("Сэси Тийн", {
	color = Color(60, 200, 255, 255),
	model = "models/cultist_kun/sw/saesee_tiin.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "saeseetiin",
	max = 1,
	salary = 0,
	admin = 0,
	level = 0,
	maxHP=2500,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_JEDIBATTLEMASTER = DarkRP.createJob("Джедай Боевого Назначения", {
    color = Color(255, 200, 0, 255),
    model = {
        "models/gonzo/forcewarden/varonno/varonno.mdl",
        "models/gonzo/forcewarden/remus/remus.mdl",
        "models/gonzo/forcewarden/krelach/krelach.mdl"
    },
    description = [[ВНИМАНИЕ: Для использования 2-ух мечей/посоха необходимо изучить формы боя.]],
    weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_dual_echo"},
    command = "jedibattlemaster",
    max = 0,
    salary = 0,
    admin = 0,
	level = 80,	
	maxHP=2000,
	maxAM=100,	
    vote = false,
    candemote = false,
    category = "Jedi",
})

TEAM_FISTO = DarkRP.createJob("Кит Фисто", {
	color = Color(0, 200, 0, 255),
	model = {
        "models/tfa/comm/gg/pm_sw_fisto.mdl",
        "models/player/valley/lgn/kitfisto_diver/kitfisto_diver.mdl"
    },
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "fisto",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TI = DarkRP.createJob("Шаак Ти", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_shaakti.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "ti",
	max = 1,
	category = "Jedi",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_TANO = DarkRP.createJob("Асока", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_ahsoka_v2.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,	
	OnPlayerChangedTeam = function(ply)
		if SERVER then
			ply:bestSetSize(0.9)
		end
	end,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO22 = DarkRP.createJob("Луминара Ундули", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_luminara.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano22",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO3 = DarkRP.createJob("Квинлан Вос", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_quinlanvos.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano3",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO4 = DarkRP.createJob("Айма-Ган Дай", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_imagundi.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano4",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO5 = DarkRP.createJob("Ади Галлия", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_adigallia.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano5",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO6 = DarkRP.createJob("Иит Кот", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_eeth_koth.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano6",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})

TEAM_TANO7 = DarkRP.createJob("Баррисс Оффи", {
	color = Color(0, 200, 0, 255),
	model = "models/tfa/comm/gg/pm_sw_barriss.mdl",
	description = [[.]],
	weapons = {"gmod_tool", "weapon_physgun","clone_card_c8","weapon_lightsaber_lightsaber_echo"},
	command = "tano7",
	max = 1,
	salary = 0,
	level = 0,
	admin = 0,
	maxHP=2000,
	maxAM=100,
	vote = false,
	category = "Jedi",
	candemote = false,
})


TEAM_TUSKEN = DarkRP.createJob("Тускенский Рейдер", {
	color = Color(60, 200, 255, 255),
	model = {"models/valley/lgn/cgi pack/tusken_raider/tusken_raider.mdl"},
	description = [[]],
	weapons = {"tfa_steela_rifle","tfa_steelapistol"},
	command = "tusken",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_HAEMNIK = DarkRP.createJob("Наемник", {
	color = Color(60, 200, 255, 255),
	model = {"models/valley/lgn/cgi pack/rako_hardeen/rako_hardeen.mdl","models/valley/lgn/cgi pack/dengar/dengar.mdl","models/valley/lgn/cgi pack/cad_bane/cad_bane.mdl","models/valley/lgn/cgi pack/blacksun_soldier/blacksun_soldier.mdl"},
	description = [[]],
	weapons = {"tfa_mercenarypistol","tfa_cadbane_rifle"},
	command = "haemnik",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_PADME = DarkRP.createJob("Сенатор", {
	color = Color(60, 200, 255, 255),
	model = {"models/valley/lgn/cgi pack/padme/padme.mdl","models/valley/lgn/cgi pack/naboo_ballroom/naboo_ballroom.mdl","models/valley/lgn/cgi pack/mina_bonteri/mina_bonteri.mdl","models/player/valley/lgn/bail_organa/bail_organa.mdl"},
	description = [[]],
	weapons = {"tfa_swch_elg3a"},
	command = "padme",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_SECURITY = DarkRP.createJob("Охранник", {
	color = Color(60, 200, 255, 255),
	model = {"models/valley/lgn/cgi pack/onderon_guard/onderon_guard.mdl","models/valley/lgn/cgi pack/mandalorian_secret_service/mandalorian_secret_service.mdl"},
	description = [[]],
	weapons = {"weapon_stunstick","tfa_kotor_br_1","weapon_combineshield"},
	command = "security",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_CIVIL = DarkRP.createJob("Гражданский", {
	color = Color(60, 200, 255, 255),
	model = {"models/valley/lgn/cgi pack/naaleth/naaleth.mdl","models/valley/lgn/cgi pack/lux_bonteri/lux_bonteri.mdl","models/valley/lgn/cgi pack/ion_papanoida/ion_papanoida.mdl","models/valley/lgn/cgi pack/coruscant_underworld/coruscant_underworld.mdl","models/player/valley/lgn/quarren/quarren.mdl"},
	description = [[]],
	weapons = {},
	command = "civil",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_MANDA = DarkRP.createJob("Мандалорец", {
	color = Color(60, 200, 255, 255),
   model = {
        "models/gonzo/gazaclan/leader/leader.mdl",
        "models/gonzo/gazaclan/trooper/trooper.mdl",
        "models/gonzo/sabinclan/leader/leader.mdl",
		"models/gonzo/sabinclan/officer/officer.mdl",
		"models/gonzo/sabinclan/trooper/trooper.mdl",
		"models/gonzo/victusclan/leader/leader.mdl",
		"models/gonzo/victusclan/officer/officer.mdl",
		"models/gonzo/victusclan/trooper/trooper.mdl",
		"models/gonzo/rikatari/rikatari.mdl",
		"models/tfa/comm/gg/pm_sw_dw_infantry_melee.mdl",
		"models/tfa/comm/gg/pm_sw_dw_fem_elite_melee.mdl",
		"models/tfa/comm/gg/pm_sw_dw_commander_base.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/trooper_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/super_commando_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/super_commando_captain_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/soldier_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/sold_com_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/lieutenant_helmet.mdl",
		"models/tfa/comm/gg/deathwatch_bf2/commander_helmet.mdl"
    },
	description = [[]],
	weapons = {"tfa_deathwatch_1","tfa_cadbane_rifle","tfa_wsp_5","zeus_thermaldet","zeus_smokegranade"},
	command = "manda",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_OXOTNIK = DarkRP.createJob("Охотник за головами", {
	color = Color(60, 200, 255, 255),
   model = {
        "models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v2_skin2.mdl",
        "models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v2.mdl",
        "models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v1_skin2.mdl",
		"models/tfa/comm/gg/pm_sw_trandoshan_bounty_hunter_v1.mdl"
    },
	description = [[]],
	weapons = {"tfa_dlt19_extended","tfa_wsp_2","zeus_thermaldet","zeus_smokegranade"},
	command = "oxotnik",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	category = "For Events",
	candemote = false,
})

TEAM_B2 = DarkRP.createJob("B2", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_b2.mdl",
	description = [[.]],
	weapons = {"b2_cannon", "b2_wrist_blaster"},
	command = "b2",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=750,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_B1 = DarkRP.createJob("B1", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_b1.mdl",
	description = [[.]],
	weapons = {"e5_blaster_rifle", "zeus_thermaldet"},
	command = "b1",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_B1SNP = DarkRP.createJob("B1 снайпер", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_b1.mdl",
	description = [[.]],
	weapons = {"tfa_sw_cissnip", "zeus_thermaldet"},
	command = "b1snp",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_B1GRENADE = DarkRP.createJob("B1 гранатометчик", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_b1.mdl",
	description = [[.]],
	weapons = {"e60r_rocket_launcher", "se14_blaster_pistol"},
	command = "b1grenade",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_COMMANDOS = DarkRP.createJob("Дроид Коммандос", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_commando.mdl",
	description = [[.]],
	weapons = {"e5_commando_blaster", "zeus_flashbang","zeus_smokegranade","zeus_thermaldet","seal6-c4"},
	command = "b1commandos",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_TACTICAL = DarkRP.createJob("Тактический Дроид", {
	color = Color(60, 200, 255, 255),
	model = "models/tfa/comm/gg/pm_sw_droid_tactical.mdl",
	description = [[.]],
	weapons = {"e5_commando_blaster", "zeus_flashbang","zeus_smokegranade","zeus_thermaldet","seal6-c4"},
	command = "tactical",
	max = 0,
	category = "For Events",
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_ASTRO = DarkRP.createJob("Дроид Астромеханик", {
	color = Color(60, 200, 255, 255),
	model = {
		"models/player/r2d2.mdl",
		"models/player/yellow.mdl",
		"models/player/r4p17.mdl",
		"models/player/r2kt.mdl",
		"models/player/purple.mdl",
		"models/player/red.mdl",
		"models/player/r5blue.mdl",
		"models/player/republict3.mdl",
		"models/player/mandaloriant3.mdl",
		"models/player/green.mdl",
		"models/player/black.mdl"
	},
	description = [[Вы дроид астромеханик... Вы должны отыгрывать роль просто дроида механика и помогать в нелегком деле пилотам и инженерам, ну и флоту тоже.]],
	weapons = {"repair_tool"},
	command = "astro",
	level = 0,
	max = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_INSTRUKTOR = DarkRP.createJob("Инструктор", {
	color = Color(60, 200, 255, 255),
	model = "models/player/smitty/bf2_reg/clone_instructor/clone_instructor.mdl",
	description = [[.]],
	weapons = {"e5_commando_blaster"},
	command = "instructor",
	max = 0,
	level = 0,
	salary = 0,
	admin = 0,
	maxHP=500,
	maxAM=100,
	vote = false,
	candemote = false,
})

TEAM_ADMIN = DarkRP.createJob("Администратор", {  color = Color(219, 200, 200, 255),  model = {"models/player/kleiner.mdl"},  description = [[NON RP]],  weapons = {},  command = "admin",  max = 0,  salary = 0,  admin = 0,  vote = false,  hasLicense = false,  level = 0,  candemote = false,
})

--[[---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_CADET
--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]


--[[---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------]]
--DarkRP.addHitmanTeam(TEAM_MOB)


