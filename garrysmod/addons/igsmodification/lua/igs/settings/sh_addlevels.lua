--[[-------------------------------------------------------------------------
	Цены в .Add указываются в рублях
---------------------------------------------------------------------------]]

-- Уровни сработают только, если не произойдет ошибки при пополнении счета
-- Она может случиться, если вы не пользуетесь мгновенным пополнением

IGS.LVL.Add(1)
	:SetName("Новичок")
	:SetBonus(function(pl)
		local bonus = pl:IGSFunds() * 0.1
		pl:AddIGSFunds(bonus,"Бонус за первое пополнение")
		IGS.Notify(pl,"Вы получили " .. PL_IGS(bonus) .. "\nв качестве бонуса за первое пополнение счета")
	end)
	:SetDescription("Начало начал... При первом пополнении счета получите 10% в подарок") -- выше в catchDSHints еще


IGS.LVL.Add(100):SetName("Стартанувший")
	:SetDescription("Красавчик! Но всё ещё только впереди!") -- выше в catchDSHints еще
	
IGS.LVL.Add(500):SetName("В теме")
	:SetDescription("Ды ты шаришь!") -- выше в catchDSHints еще
	--[[:SetBonus(function(pl)
		-- вдруг чел как раз в этот момент премку и купит? Даем ему время ее активировать
		timer.Simple(600,function()
			if IsValid(pl) and pl:GetUserGroup() ~= "vip" then
				IGS.OM(pl:SteamID64(),
					"Поздравляем с переходом на новый бизнес уровень!\n\n" ..
					"В честь этого события мы подготовили для вас скидку на покупку премиум статуса - 40%\n\n" ..
					"Чтобы воспользоваться возможностью - напишите нам\n\n" ..
					"Мы ждем вас и очень надеемся, что вы не откажетесь от возможности стать круче, наравне с остальными премиумами",

					"Новый уровень"
				)
			end
		end)
	end)]]


IGS.LVL.Add(1000):SetName("Бывалый")
	:SetDescription("Оу мен! Теберь Анти Чит не помрёт с голоду!")
	--[[:SetBonus(function(pl)
		IGS.OM(pl:SteamID64(),
			"Вы заслужили возможность получить уникальную группу на форуме - Мегалодон\n\n" ..
			"Она не дает ничего сверхъестественного, лишь выделение среди других, " ..
				"несколько дополнительных прав, вроде доступа к засекреченному разделу и, в общем то, все",
			"Новый уровень"
		)
	end)]]


IGS.LVL.Add(1500):SetName("Вроде не бомж")
	:SetDescription("Скоро новый бонус")


IGS.LVL.Add(2000):SetName("Точно не бомж")
	:SetDescription("Еще капельку и бонус. Следующий лвл")


IGS.LVL.Add(2500):SetName("100% не бомж")
	:SetDescription("Ты добрался так высоко! Получика  20% бонус в лицо!")
	:SetBonus(function(pl)
		local bonus = pl:IGSFunds() * .1 -- на самом деле бонус начислит на всю имеющуюся сумму, а не сумму пополнения. Так что ахтунг
		pl:AddIGSFunds(bonus,"Бонус за 2500 руб транзакций")
		IGS.Notify(pl,"Вы получили " .. PL_IGS(bonus) .. "\nв качестве бонуса за новый ЛВЛ")
	end)


IGS.LVL.Add(3000):SetName("110% не бомж")
	:SetDescription("Премиум поддержка от правительства???")
	--[[:SetBonus(function(pl)
		IGS.OM(pl:SteamID64(),
			"Обратитесь к нам, чтобы договориться о прайм поддержке\n\n" ..
			"Не забудьте сказать, что это предложение с автодоната и назовите уникальную секретную комбинацию: FVL0YT0VELFR", -- lol
			"Новый уровень"
		)
	end)]]--


IGS.LVL.Add(4000):SetName("Очень щедрый")
	:SetDescription("На след. лвл новый бонус")


IGS.LVL.Add(5000):SetName("Пиздец щедрый")
	:SetDescription("Тебе нет равных? Евер говорит что он лучше! Ахахаха! На те 10% бонус от Евера!")
	:SetBonus(function(pl)
		local bonus = pl:IGSFunds() * .05 -- на самом деле бонус начислит на всю имеющуюся сумму, а не сумму пополнения. Так что ахтунг
		pl:AddIGSFunds(bonus,"Бонус за 5000 руб транзакций")
		IGS.Notify(pl,"Вы получили " .. PL_IGS(bonus) .. "\nв качестве бонуса за новый ЛВЛ")
	end)


IGS.LVL.Add(6000):SetName("Мажор")

IGS.LVL.Add(7000):SetName("Супермажик")
IGS.LVL.Add(8000):SetName("Гипермажик")
IGS.LVL.Add(9000):SetName("Убермажор")
IGS.LVL.Add(10000):SetName("Миллионер")
	:SetDescription("Может быть скоро бонус?")

IGS.LVL.Add(12000):SetName("МультиМиллионер")
IGS.LVL.Add(15000):SetName("Миллиардер")
	:SetDescription("БОНУС! 10%? 20%? НЕТ! 25%! Ахахахах!")
	:SetBonus(function(pl)
		local bonus = pl:IGSFunds() * .05 -- на самом деле бонус начислит на всю имеющуюся сумму, а не сумму пополнения. Так что ахтунг
		pl:AddIGSFunds(bonus,"Бонус за 15000 руб транзакций")
		IGS.Notify(pl,"Вы получили " .. PL_IGS(bonus) .. "\nв качестве бонуса за новый супер-пупер ЛВЛ")
	end)
	
IGS.LVL.Add(20000):SetName("МультиМиллиардер")
	:SetDescription("Премиум поддержка лично от Анти Чита в любое время суток")
	:SetBonus(function(pl)
		IGS.OM(pl:SteamID64(),
			"Напиши нам для получения прямой помощи в любое время суток",
			"Новый уровень"
		)
	end)
	
IGS.LVL.Add(25000):SetName("Нахуй с дороги")
IGS.LVL.Add(30000):SetName("Сядь в лужу, я пройду")
IGS.LVL.Add(35000):SetName("Круче только Еппа Свин")
IGS.LVL.Add(40000):SetName("Круче только Евер Кодер")
IGS.LVL.Add(50000):SetName("Круче только Анти Чит")


hook.Add("IGS.OnSuccessPurchase","DoItemGlobal",function(pl, ITEM, isGlobal, iID)
	if isGlobal then return end -- дальше делать нечего

	if ITEM.global then
		-- IGS.MovePurchase(db_id, nil, fCallback)

		if IGS.C.Inv_Enabled then
			local s64 = pl:SteamID64()
			IGS.DeleteInventoryItem(iID, function(ok)
				if !ok then return end
				IGS.StoreInvItem(s64, ITEM:UID(), true)
			end)
		else
			print("Если инвентарь выключен, то пока работать не будет")
		end
	end
end)