/***  ----------------------------------------------------------------------  ***
	Документацию по всем доступным методам можно посмотреть в файле documentation.txt
	Там написано много интересных и полезных методов, не ленитесь открыть

	Если демонстрационных итемов для настройки автодоната недостаточно
	- свяжитесь с нами и мы вам оперативно поможем: https://vk.com/im?sel=-143836547

	Не забудьте раскомментировать блок кода, чтобы настройки заработали
	Для этого нужно убрать "--" перед нужными строками.
	Если не знаете, как это сделать - напишите нам

	ДЛЯ ОПЫТНЫХ ПОЛЬЗОВАТЕЛЕЙ пример конфигурации автодоната на TRIGON.IM:
	https://gist.github.com/284608002faf5ff10525874b0225801e
***  -------------------------------------------------------------------------  ***/

--прочтите_то_что_написано_выше = !!!ОБЯЗАТЕЛЬНО

/****************************************************************************
	Разрешаем покупать отмычку только донатерам (DarkRP)
	Доступ навсегда за 1 рубль
	https://img.qweqwe.ovh/1493244432112.png -- частичное объяснение
****************************************************************************/

-- IGS("Отмычка", "otmichka") -- второй параметр ДОЛЖЕН!!!!!!!! быть уникальным(Не повторяться с другими итемамы!) и на латиннице
-- 	-- 1 рубль
-- 	:SetPrice(1)
--
-- 	-- _NAVSEGDA_, значит навсегда.
-- 	-- 0 - одноразовое (Т.е. купил, выполнилось OnActivate и забыл. Полезно для валюты)
-- 	-- 30 - месяц, 7 - неделя и т.д.
-- 	:SetTerm(_NAVSEGDA_)
--
-- 	-- тут пишем реальный КЛАСС ЭНТИТИ, который указан в shipments.lua
-- 	:SetDarkRPItem("lockpick")
--
-- 	-- ОПИСАНИЕ отобразится в подробностях донат итема
-- 	:SetDescription("Разрешает вам покупать отмычку")
--
-- 	-- КАТЕГОРИЯ в магазине
-- 	:SetCategory("Оружие")
--
-- 	-- квадратная ИКОНКА (Не обязательно). Отобразится на главной странице. Может быть с прозрачностью
-- 	:SetIcon("http://i.imgur.com/4zfVs9s.png")
--
-- 	-- БАННЕР 1000х400 (Не обязательно). Отобразится в подробностях итема
-- 	:SetImage("http://i.imgur.com/RqsP5nP.png")



/****************************************************************************
	Игровая валюта для DarkRP
	Срок нет смысла указывать
	Для удобства суммы объединены в группу (Не категорию)
****************************************************************************/
-- local GROUP = IGS.NewGroup("Игровая валюта")
--
-- GROUP:AddItem(
-- 	IGS("100 тысяч", "100k_deneg"):SetDarkRPMoney(100000)
-- 	:SetPrice(200) -- руб
-- )
--
-- GROUP:AddItem(
-- 	IGS("500 тысяч", "500k_deneg"):SetDarkRPMoney(500000)
-- 	:SetPrice(450) -- руб
-- )

local STORE_ITEM = FindMetaTable("IGSItem")
function STORE_ITEM:SetGlob()
	self.Global = true
	return self
end


/****************************************************************************
	Донат группы ULX
	Обратите внимание, иконка и баннер здесь не указаны
	Так делать можно, они просто не будут отображены
****************************************************************************/
local MINIVIP = IGS.NewGroup("Mini-VIP")

local VIP = IGS.NewGroup("VIP")

local SUPERADMIN = IGS.NewGroup("Superadmin")

local HEADADMIN = IGS.NewGroup("HeadAdmin")

local ADMIN = IGS.NewGroup("Admin")

--[[local serv_groups = {
	{
		name = "Админ на всегда",
		id = "admin_forever",
		price = 400,
		category = "Группы",
		discription = "Крутя",
		rank = "admin",
		time = 86400*0,--0 навсегда || другие числа - в секундах
		igstime = _NAVSEGDA_,--_NAVSEGDA_ навсегда || 0 единоразовая || другие числа - в днях
		group = ADMIN,
	},
	{
		name = "Админ на 30 дней",
		id = "admin_30days",
		price = 100,
		category = "Группы",
		discription = "Крутя2",
		rank = "admin",
		time = 86400*30,--0 навсегда || другие числа - в секундах
		igstime = 30,--_NAVSEGDA_ навсегда || 0 единоразовая || другие числа - в днях
		group = ADMIN,
	},
}

for k,v in pairs(serv_groups)do
	v.group:AddItem(
		IGS(v.name, v.id)
			:SetPrice(v.price)
			:SetTerm(v.igstime) -- навсегда
			:SetCategory(v.category)
			:SetDescription(v.discription)
			:SetOnActivate(function(pl)
				serverguard.player:SetRank(pl, v.rank, v.time, true)
			end)
			:SetValidator(function(pl)
				return serverguard.player:GetRank(pl) == v.rank, true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
			end)
			:SetGlob()
	)
end
]]--
MINIVIP:AddItem(
	IGS("Mini-VIP на месяц", "mini_vip_na_mesyac")
	:SetPrice(250)
	:SetTerm(30) -- 30 дней
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "mini-vip", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "mini-vip", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

MINIVIP:AddItem(
	IGS("Mini-VIP навсегда", "mini_vip_navsegda")
	:SetPrice(625)
	:SetTerm(_NAVSEGDA_) -- навсегда
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "mini-vip", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "mini-vip", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

VIP:AddItem(
	IGS("VIP на месяц", "vip_na_mesyac")
	:SetPrice(500)
	:SetTerm(30) -- 30 дней
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "vip", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "vip", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

VIP:AddItem(
	IGS("VIP навсегда", "vip_navsegda")
	:SetPrice(1250)
	:SetTerm(_NAVSEGDA_) -- навсегда
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "vip", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "vip", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

ADMIN:AddItem(
	IGS("Admin на месяц", "admin_na_mesyac")
	:SetPrice(1000)
	:SetTerm(30) -- 30 дней
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "admin", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "admin", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

ADMIN:AddItem(
	IGS("Admin навсегда", "admin_navsegda")
	:SetPrice(2500)
	:SetTerm(_NAVSEGDA_) -- навсегда
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "admin", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "admin", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

SUPERADMIN:AddItem(
	IGS("Superadmin на месяц", "super_na_mesyac")
	:SetPrice(1500)
	:SetTerm(30) -- 30 дней
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "superadmin", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "superadmin", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

SUPERADMIN:AddItem(
	IGS("Superadmin навсегда", "super_navsegda")
	:SetPrice(3750)
	:SetTerm(_NAVSEGDA_) -- навсегда
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "superadmin", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "superadmin", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

HEADADMIN:AddItem(
	IGS("HeadAdmin навсегда", "headadmin_navsegda")
	:SetPrice(5000)
	:SetTerm(_NAVSEGDA_) -- навсегда
	:SetOnActivate(function(pl)
		serverguard.player:SetRank(pl, "headadmin", 0, true)
	end)
	:SetValidator(function(pl)
		return serverguard.player:GetRank(pl) == "headadmin", true -- тут надо сменить группу, на такую-же, как и в :SetOnActivate
	end)
	:SetCategory("SERVERGUARD группы")
	:SetGlob()
)

/****************************************************************************
	Донат группы FAdmin
	Здесь цена указана третьим аргументом, вместо :SetPrice
	Так делать не обязательно, это лишь микровозможность
****************************************************************************/
-- IGS("Фадмин VIP","fa_vip_30d",228):SetFAdminGroup("vip")
-- 	:SetTerm(30)
-- 	:SetDescription("Повысит вас до випа на 30 дней")



/****************************************************************************
	Продажа поинтов для Поинтшоп 2
	https://www.gmodstore.com/scripts/view/596
****************************************************************************/
-- IGS("100 донат поинтов","100_points_don"):SetPremiumPoints(100) -- дон поинты
-- 	:SetPrice(100) -- руб
--
-- IGS("1000 обычных поинтов","1000_points"):SetPoints(1000) -- обычные поинты
-- 	:SetPrice(100)



/****************************************************************************
	Продажа уровней и опыта для Leveling System
	https://github.com/vrondakis/Leveling-System
****************************************************************************/
local LVL = IGS.NewGroup("Опыт")

LVL:AddItem(
IGS("14000 опыта","exp_14000")
	:SetPrice(1)
	:SetEXP(14000)
	:SetStackable(true)
	:SetCategory("Система уровней")
)

LVL:AddItem(
IGS("140000 опыта","exp_140000")
	:SetPrice(10)
	:SetEXP(140000)
	:SetStackable(true)
	:SetCategory("Система уровней")
)

LVL:AddItem(
IGS("1400000 опыта","exp_1400000")
	:SetPrice(100)
	:SetEXP(1400000)
	:SetStackable(true)
	:SetCategory("Система уровней")
)

local weaponArray = { 
--{id = "wep1", name="LL-30M",price=200,code="tfa_swch_ll30",model="models/weapons/w_LL30.mdl",time=21,disc="LL-30 - Бластерный пистолет компании «БласТех Индастриз». Урон: 55. Скор.Выстр. в мин.: 350RPM. Точность: Очень высокая.",restriction = nil}, 
{id = "wep2", name="LL-30M",price=200,code="tfa_swch_ll30",model="models/weapons/w_LL30.mdl",time=_NAVSEGDA_,disc="LL-30 - Бластерный пистолет компании «БласТех Индастриз». Урон: 55. Скор.Выстр. в мин.: 350RPM. Точность: Очень высокая.",restriction = nil}, 
--{id = "wep3", name="DC-15AM",price=300,code="tfa_swch_dc15a_alt",model="models/weapons/w_dc15a_neue.mdl",time=21,disc="DC-15AM - Бластерная винтовка компании «БласТех Индастриз». Урон: 80. Скор.Выстр. в мин.: 400RPM. Точность: Высокая.",restriction = nil}, 
{id = "wep4", name="DC-15AM",price=300,code="tfa_swch_dc15a_alt",model="models/weapons/w_dc15a_neue.mdl",time=_NAVSEGDA_,disc="DC-15AM - Бластерная винтовка компании «БласТех Индастриз». Урон: 80. Скор.Выстр. в мин.: 400RPM. Точность: Высокая.",restriction = nil}, 
--{id = "wep5", name="DC-15AMS",price=400,code="tfa_swch_dc15a_shadow",model="models/weapons/w_dc15a_neue2_shadow.mdl",time=21,disc="DC-15AMS - Бластерная винтовка компании «БласТех Индастриз». Урон: 60x2. Скор.Выстр. в мин.: 350RPM. Точность: Высокая.",restriction = nil}, 
{id = "wep6", name="DC-15AMS",price=400,code="tfa_swch_dc15a_shadow",model="models/weapons/w_dc15a_neue2_shadow.mdl",time=_NAVSEGDA_,disc="DC-15AMS - Бластерная винтовка компании «БласТех Индастриз». Урон: 60x2. Скор.Выстр. в мин.: 350RPM. Точность: Высокая.",restriction = nil}, 

{id = "wep7", name="Два световых меча",price=1000,code="weapon_lightsaber_dual_echo",model="models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl",time=_NAVSEGDA_,disc="Добавляет вам двойные световые мечи. ВНИМАНИЕ, что бы использовать два световых меча, необходима иметь специализацию Защитник/Страж/Джедай боевого назначения.",restriction = {"jedibattlemaster","Sentinel","Guardian"}}, 
{id = "wep8", name="Два световых меча(Corrupted эффект)",price=1500,code="weapon_lightsaber_corrupted_dual_echo",model="models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl",time=_NAVSEGDA_,disc="Добавляет вам двойные световые мечи. ВНИМАНИЕ, что бы использовать два световых меча, необходима иметь специализацию Защитник/Страж/Джедай боевого назначения.",restriction = {"jedibattlemaster","Sentinel","Guardian"}}, 
{id = "wep9", name="Два световых меча(Unstable эффект)",price=1500,code="weapon_lightsaber_corrupted_dual_echo",model="models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl",time=_NAVSEGDA_,disc="Добавляет вам двойные световые мечи. ВНИМАНИЕ, что бы использовать два световых меча, необходима иметь специализацию Защитник/Страж/Джедай боевого назначения.",restriction = {"jedibattlemaster","Sentinel","Guardian"}}, 

{id = "wep10", name="Световой меч (Corrupted эффект)",price=500,code="weapon_lightsaber_corrupted_echo",model="models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl",time=_NAVSEGDA_,disc="Добавляет вам меч с эффектом",restriction = {"jedibattlemaster","Sentinel","Guardian"}}, 
{id = "wep11", name="Световой меч (Unstable эффект) ",price=500,code="weapon_lightsaber_unstable_echo",model="models/sgg/starwars/weapons/w_anakin_ep2_saber_hilt.mdl",time=_NAVSEGDA_,disc="Добавляет вам меч с эффектом",restriction = {"jedibattlemaster","Sentinel","Guardian"}}, 

}

for k,v in pairs(weaponArray)do
		IGS(v.name,v.id)
		:SetPrice(v.price)
		:SetTerm(v.time)
		:SetOnActivate(function(ply) addWeaponToCuLoad(ply,v.code,v.restriction) end)
		--:SetOnRemove(function(s64) removeWeaponFromCuLoad(ply,v.code) end)
		:SetCategory("Оружие")
		:SetIcon(v.model, true) -- true значит, что указана моделька, а не ссылка
		:SetDescription(v.disc)
		:SetGlob()
end


/****************************************************************************
	Работы
****************************************************************************/
local JEDI = IGS.NewGroup("Джедаи")

local RC = IGS.NewGroup("RC")

local jobnames = {
	{name = "RC Sev",id="rc_shadow",price=500,group=RC},
	{name = "RC Scorch",id="rc_fixer",price=500,group=RC},
	{name = "RC Gregor",id="rc_sev",price=500,group=RC},
	{name = "RC Fixer",id="rc_boss",price=500,group=RC},
	{name = "RC Boss",id="rc_gregor",price=500,group=RC},
	{name = "RC Archangel",id="rcscorch",price=500,group=RC},
	{name = "RC Contort",id="rc_black",price=500,group=RC},
	{name = "RC Eyeshard",id="rc_bosky",price=500,group=RC},
	{name = "RC Grip",id="rc_scraps",price=500,group=RC},
	{name = "RC Huskie",id="rc_throttle",price=500,group=RC},
	{name = "RC Kurz",id="rc_trigger",price=500,group=RC},
	{name = "RC Scorpion",id="rc_wookie",price=500,group=RC},
	{name = "RC Stripe",id="rc_archangel",price=500,group=RC},
	{name = "RC Watson",id="rc_grip",price=500,group=RC},
	{name = "RC Nuck",id="rc_eyeshard",price=500,group=RC},
	{name = "RC Price",id="rc_huskie",price=500,group=RC},
	{name = "RC Tranker",id="rc_stripe",price=500,group=RC},
	{name = "RC Acer",id="rc_kurz",price=500,group=RC},
	{name = "RC Headshot",id="rc_contort",price=500,group=RC},
	{name = "RC Grinder",id="rc_scorpion",price=500,group=RC},
	{name = "RC Thumbs",id="rc_watson",price=500,group=RC},
	{name = "Юнлинг",id="unling",price=400,group=JEDI},
	{name = "Джедай Падаван",id="jedi_padavan",price=500,group=JEDI},
	{name = "Джедай Рыцарь",id="jedi_ricar",price= 600,group=JEDI},
	{name = "Джедай Консул",id="jedi_consul",price=800,group=JEDI},
	{name = "Джедай Защитник",id="jedi_defender",price=800,group=JEDI},
	{name = "Джедай Страж",id="jedi_straz",price=800,group=JEDI},
	{name = "Джедай Боевого Назначения",id="jedi_boevogo_naznachenia",price=1000,group=JEDI},
}

for k,v in pairs(jobnames)do
	if !v.group then
		IGS(v.name,v.id)
			:SetCategory("Работы")
			:SetPrice(v.price)
			:SetOnActivate(function(ply) RunConsoleCommand( "bwhitelist_add_to_whitelist_steamid", ply:SteamID(),v.name ) end)
			--:SetOnRemove(function(s64) RunConsoleCommand( "bwhitelist_remove_from_whitelist_steamid", s64,v.name ) end)
			:SetGlob()
	else
		v.group:AddItem(
			IGS(v.name,v.id)
				:SetCategory("Работы")
				:SetPrice(v.price)
				:SetOnActivate(function(ply) RunConsoleCommand( "bwhitelist_add_to_whitelist_steamid", ply:SteamID(),v.name ) end)
				--:SetOnRemove(function(s64) RunConsoleCommand( "bwhitelist_remove_from_whitelist_steamid", s64,v.name ) end)
				:SetGlob()
		)
	end
end

local SKILLS = IGS.NewGroup("Скилы")
local RESETSKILLS = IGS.NewGroup("Сброс скиллов")

SKILLS:AddItem(
	IGS("1 скиллпоинт", "1skill")
	:SetPrice(25)
	:SetTerm(0)
	:SetOnActivate(function(pl)
		pl:AddSkillPoints(1)
	end)
	:SetCategory("Система скиллов")
	:SetGlob()
)


SKILLS:AddItem(
	IGS("5 скиллпоинт", "5skill")
	:SetPrice(125)
	:SetTerm(0)
	:SetOnActivate(function(pl)
		pl:AddSkillPoints(5)
	end)
	:SetCategory("Система скиллов")
	:SetGlob()
)


SKILLS:AddItem(
	IGS("10 скиллпоинт", "10skill")
	:SetPrice(250)
	:SetTerm(0)
	:SetOnActivate(function(pl)
		pl:AddSkillPoints(10)
	end)
	:SetCategory("Система скиллов")
	:SetGlob()
)

SKILLS:AddItem(
	IGS("50 скиллпоинт", "50skill")
	:SetPrice(1250)
	:SetTerm(0)
	:SetOnActivate(function(pl)
		pl:AddSkillPoints(50)
	end)
	:SetCategory("Система скиллов")
	:SetGlob()
)

RESETSKILLS:AddItem(
	IGS("1 очко сброса", "1skillrestore")
	:SetPrice(100)
	:SetTerm(0)
	:SetOnActivate(function(pl)
		pl:addResetPoints(1)
	end)
	:SetCategory("Система скиллов")
	:SetGlob()
)


hook.Add("IGS.OnSuccessPurchase","DoItemGlobal",function(pl, ITEM, isGlobal, iID)
	if isGlobal then return end -- дальше делать нечего

	if ITEM.Global then
		-- IGS.MovePurchase(db_id, nil, fCallback)

		if IGS.C.Inv_Enabled then
			IGS.DeletePlayerInventoryItem(pl, iID, function(ok)
				if !ok then return end
				IGS.AddToInventory(pl, ITEM:UID(), true)
			end)
		else
			print("Есть инвентари выключены, то пока работать не будет")
		end
	end
end)