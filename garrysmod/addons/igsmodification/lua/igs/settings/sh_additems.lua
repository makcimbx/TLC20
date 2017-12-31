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



/****************************************************************************
	Донат группы ULX
	Обратите внимание, иконка и баннер здесь не указаны
	Так делать можно, они просто не будут отображены
****************************************************************************/
-- IGS("VIP на месяц", "vip_na_mesyac"):SetULXGroup("vip")
-- 	:SetPrice(150)
-- 	:SetTerm(30) -- 30 дней
-- 	:SetCategory("Группы")
-- 	:SetDescription("С этой покупкой вы станете офигенными, потому что в ней воооот такая куча крутых возможностей")

-- IGS("PREMIUM навсегда", "premium_navsegda"):SetULXGroup("premium")
-- 	:SetPrice(400)
-- 	:SetTerm(_NAVSEGDA_) -- навсегда
-- 	:SetCategory("Группы")
-- 	:SetDescription("А с этой покупкой еще офигеннее, чем с покупкой VIP")

-- IGS("Тестовая операторка", "demo_operator"):SetULXGroup("operator")
-- 	:SetPrice(30)
-- 	:SetTerm(0) -- одноразовое. Можно ввобще убрать строку
-- 	:SetCategory("Группы")
-- 	:SetDescription("С этой покупкой вы можете попробовать себя в роли оператора. Права исчезнут после перезахода")


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
 IGS("7000 опыта","exp_7000")
 	:SetPrice(1)
 	:SetEXP(7000)
	:SetStackable(true)
 	:SetCategory("Система уровней")
)

LVL:AddItem(
 IGS("70000 опыта","exp_70000")
 	:SetPrice(10)
 	:SetEXP(70000)
	:SetStackable(true)
 	:SetCategory("Система уровней")
)

LVL:AddItem(
 IGS("700000 опыта","exp_700000")
 	:SetPrice(100)
 	:SetEXP(700000)
	:SetStackable(true)
 	:SetCategory("Система уровней")
)

local weaponArray = { 
--{name="LL-30M",price=200,code="tfa_swch_ll30",model="models/weapons/w_LL30.mdl",time=21,disc="LL-30 - Бластерный пистолет компании «БласТех Индастриз». Урон: 55. Скор.Выстр. в мин.: 350RPM. Точность: Очень высокая."}, 
{name="LL-30M",price=800,code="tfa_swch_ll30",model="models/weapons/w_LL30.mdl",time=_NAVSEGDA_,disc="LL-30 - Бластерный пистолет компании «БласТех Индастриз». Урон: 55. Скор.Выстр. в мин.: 350RPM. Точность: Очень высокая."}, 
--{name="DC-15AM",price=300,code="tfa_swch_dc15a_alt",model="models/weapons/w_dc15a_neue.mdl",time=21,disc="DC-15AM - Бластерная винтовка компании «БласТех Индастриз». Урон: 80. Скор.Выстр. в мин.: 400RPM. Точность: Высокая."}, 
{name="DC-15AM",price=900,code="tfa_swch_dc15a_alt",model="models/weapons/w_dc15a_neue.mdl",time=_NAVSEGDA_,disc="DC-15AM - Бластерная винтовка компании «БласТех Индастриз». Урон: 80. Скор.Выстр. в мин.: 400RPM. Точность: Высокая."}, 
--{name="DC-15AMS",price=400,code="tfa_swch_dc15a_shadow",model="models/weapons/w_dc15a_neue2_shadow.mdl",time=21,disc="DC-15AMS - Бластерная винтовка компании «БласТех Индастриз». Урон: 60x2. Скор.Выстр. в мин.: 350RPM. Точность: Высокая."}, 
{name="DC-15AMS",price=1200,code="tfa_swch_dc15a_shadow",model="models/weapons/w_dc15a_neue2_shadow.mdl",time=_NAVSEGDA_,disc="DC-15AMS - Бластерная винтовка компании «БласТех Индастриз». Урон: 60x2. Скор.Выстр. в мин.: 350RPM. Точность: Высокая."}, 
}

for k,v in pairs(weaponArray)do
		IGS(v.name,v.code)
		:SetPrice(v.price)
		:SetTerm(v.time)
		:SetOnActivate(function(ply) addWeaponToCuLoad(ply,v.code) end)
		--:SetOnRemove(function(s64) removeWeaponFromCuLoad(ply,v.code) end)
		:SetCategory("Оружие")
		:SetIcon(v.model, true) -- true значит, что указана моделька, а не ссылка
		:SetDescription(v.disc)
end

	
/****************************************************************************
	Работы
****************************************************************************/
	
	
local SQUAD = IGS.NewGroup("Squad")

local SIERRASQUAD = IGS.NewGroup("Sierra Squad")

local ZULUSQUAD = IGS.NewGroup("Zulu Squad")

local BETASQUAD = IGS.NewGroup("Beta Squad")

local JEDI = IGS.NewGroup("Джедаи")

local RC = IGS.NewGroup("RC")

local jobnames = {
	{name="RC Shadow",id="rc_shadow",price=500,group=RC},
	{name="RC Fixer",id="rc_fixer",price=500,group=RC},
	{name="RC Sev",id="rc_sev",price=500,group=RC},
	{name="RC Boss",id="rc_boss",price=500,group=RC},
	{name="RC Gregor",id="rc_gregor",price=500,group=RC},
	{name="RC Scorch",id="rcscorch",price=500,group=RC},
	{name="RC Black Tiger",id="rc_black",price=500,group=RC},
	{name="RC Bosky",id="rc_bosky",price=500,group=RC},
	{name="RC Scraps",id="rc_scraps",price=500,group=RC},
	{name="RC Throttle",id="rc_throttle",price=500,group=RC},
	{name="RC Trigger",id="rc_trigger",price=500,group=RC},
	{name="RC Wookie",id="rc_wookie",price=500,group=RC},
	{name="RC Archangel",id="rc_archangel",price=500,group=SQUAD},
	{name="RC Grip",id="rc_grip",price=500,group=SQUAD},
	{name="RC Eyeshard",id="rc_eyeshard",price=500,group=SQUAD},
	{name="RC Huskie",id="rc_huskie",price=500,group=SQUAD},
	{name="RC Stripe",id="rc_stripe",price=500,group=SIERRASQUAD},
	{name="RC Kurz",id="rc_kurz",price=500,group=SIERRASQUAD},
	{name="RC Contort",id="rc_contort",price=500,group=SIERRASQUAD},
	{name="RC Scorpion",id="rc_scorpion",price=500,group=SIERRASQUAD},
	{name="RC Watson",id="rc_watson",price=500,group=ZULUSQUAD},
	{name="RC Price",id="rc_price",price=500,group=ZULUSQUAD},
	{name="RC Nuck",id="rc_nuck",price=500,group=ZULUSQUAD},
	{name="RC Tranker",id="rc_tranker",price=500,group=ZULUSQUAD},
	{name="RC Acer",id="rc_acer",price=500,group=BETASQUAD},
	{name="RC Grinder",id="rc_grinder",price=500,group=BETASQUAD},
	{name="RC Headshot",id="rc_headshot",price=500,group=BETASQUAD},
	{name="RC Thumbs",id="rc_thumbs",price=500,group=BETASQUAD},
	{name="Юнлинг",id="unling",price=400,group=JEDI},
	{name="Джедай Падаван",id="jedi_padavan",price=500,group=JEDI},
	{name="Джедай Рыцарь",id="jedi_ricar",price= 600,group=JEDI},
	{name="Джедай Консул",id="jedi_consul",price=800,group=JEDI},
	{name="Джедай Защитник",id="jedi_defender",price=800,group=JEDI},
	{name="Джедай Страж",id="jedi_straz",price=800,group=JEDI},
	{name="Джедай Боевого Назначения",id="jedi_boevogo_naznachenia",price=1000,group=JEDI},
}

for k,v in pairs(jobnames)do
	if(v.group=="nil")then
		IGS(v.name,v.id)
			:SetCategory("Работы")
			:SetPrice(v.price)
			:SetOnActivate(function(ply) RunConsoleCommand( "bwhitelist_add_to_whitelist_steamid", ply:SteamID(),v.name ) end)
			--:SetOnRemove(function(s64) RunConsoleCommand( "bwhitelist_remove_from_whitelist_steamid", s64,v.name ) end)
	else
		v.group:AddItem(
			IGS(v.name,v.id)
				:SetCategory("Работы")
				:SetPrice(v.price)
				:SetOnActivate(function(ply) RunConsoleCommand( "bwhitelist_add_to_whitelist_steamid", ply:SteamID(),v.name ) end)
				--:SetOnRemove(function(s64) RunConsoleCommand( "bwhitelist_remove_from_whitelist_steamid", s64,v.name ) end)
 		)
	end
end