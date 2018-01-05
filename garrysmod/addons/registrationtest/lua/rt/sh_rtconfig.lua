rtConfig = {}


rtConfig.Attempts = 4

-- Ban the player if hes failing in the test or just kick him? (ban is true kick is false)
rtConfig.banPlayer = false

-- If you choose you to ban the player for who much time (in minutes)
rtConfig.banTime = 120

rtConfig.Percent = 0

rtConfig.XPmultip = 1000

rtLang = {}
hook.Add("loadCustomDarkRPItems","Ever_loadCustomDarkRPItems",function()
	rtLang.Legions = {
		[1] = {name = "501",prof = "501-й Клон Солдат",cmd = "501ct",category = "501st legion"},
		[2] = {name = "212",prof = "212-й Клон Солдат",cmd = "212ct",category = "212 AB"},
		[3] = {name = "41",prof = "41-й Клон Солдат",cmd = "41ct",category = "41st legion"},
		[4] = {name = "91",prof = "91-й Клон Солдат",cmd = "91ct",category = "91st Recon Corps"},
		[5] = {name = "74",prof = "74-й Клон Солдат",cmd = "74ct",category = "74th medicacal corps"},
		[6] = {name = "EOD",prof = "EOD Клон Солдат",cmd = "eodct",category = "EOD"},
		[7] = {name = "327",prof = "327-й Клон Солдат",cmd = "327ct",category = "327st"},
		[8] = {name = "104",prof = "104-й Клон Солдат",cmd = "104ct",category = "104st"},
	}
end)

rtLang.Questions = {
	[1] = {["question"]='С самого появления на "Камино", и до самого конца обучения вы сразу же поняли, что в бою самое гланое это',["answers"]={"Братья по оружию","То, с чего ты стреляешь","Точность твоих навыков"},["rightanswer"]=1},
	[2] = {["question"]="Идя на своё первое сражение, вам был предоставлен выбор вооружения, и вам больше всего захотелось взять с собой",["answers"]={"DC-15A","DC-15S",'Модифицированная DC-15A с прицелом'},["rightanswer"]=2},
	[3] = {["question"]="Во время своей первой боевой задачи, вы, оглядевшись на поле боя, замечаете отряд дроидов, про который не было известно, направляющийся в вашу сторону, вы тут-же предприняли",["answers"]={"Действовать незамедлительно, попытавшись уничтожить нежданных противников","Сообщить командиру, непосредственно выдвинуться с группой своих братьев","Сообщить близ стоящим братьям, прикрывая их во время перехвата противника"},["rightanswer"]=3},
	[4] = {["question"]="Ваш отряд окружил противник, вы, единственный кто не оказался в этой западне, вы понимаете, что должны что-то сделать дабы спасти ваш отряд, подумав, вы решаетесь",["answers"]={'Действовать на расстоянии, предпринимая тактику "Бей, беги" устаивая неожиданные удары в спину противника', "Вы, понимая что рискуете потерять отряд, вызываете подкрепления и с их помощью спасаете свой отряд","Вы, подобрав гранат с трупов ваших братьев, решаете ударить в спину противника, прорвавшись к своему отряду"},["rightanswer"]=2},
	[5] = {["question"]="Вас повысили, теперь вы капрал, это добавляет большую ответственность, ваш командир гордиться вами и дает хороший совет, который вы восприняли по своему",["answers"]={"Помни солдат, самое главное в бою, твои братья по оружию, верь в них, что-бы они верили и в тебя, ведь в одиночку ты эту войну не выиграешь","Солдат, помни, наш противник словно рой муравьев, их больше чем нас, но они не умнее нас, действуй продуманно и незаметно по возможности, ведь только твои навыки тебе помогут","Боец, запоминай, война это жестоко, ты видел смерть по всюду, в том числе смерть своих братьев, так защити ты их, всех граждан ВАР, надейся на себя и то чем ты воюешь"},["rightanswer"]=2},
	[6] = {["question"]="Наступил день очередной операции, вашей задачей является захват базы противника, перед началом операции вас распределяют по задачам, вам предоставляют выбор",["answers"]={"Вы решили идти вместе с основным отрядом, штурмуя базу противника в лобовой атаке","Вы решаете с небольшим отрядом устроить диверсию, отвлекая противника и привлечения его на другую сторону", "Вы решаете взять с собой побольше гранат и картриджей, дабы помогать во время боя предоставляя припасами своих братьев" },["rightanswer"]=1},
	[7] = {["question"]="В своё свободное время, вы решили заняться",["answers"]={"Помощью на базе, вы старались больше времени общаться со своими сослуживцами и помогать им в их делах","Вы решаете провести всё своё свободное время на тренировочной площадке, улучшая свои физические навыки и свою реакцию","Вы все время находились на стрельбище, улучшая стрельбу соревнуясь с другими солдатами"},["rightanswer"]=2},
	[8] = {["question"]="Вы потерпели поражение в битве, ваши товарищи отступили но вы оказались слишком далеко от них, дабы выжить и вернуться к своим вы",["answers"]={"Замаскировались с местностью, дабы выжить и переждать некоторое время, прежде чем идти к своим", "Вы решаетесь на подвиг, вы со всем своим снаряжением решаетесь силой пробиться к своей базе, круша противника дабы ослабить их", "Вы решаете действовать скрытно, вы начинаете следить за передвижением и позицией противника, дабы принести с собой полезные данные на базу"},["rightanswer"]=1},
	[9] = {["question"]="Ваш отряд должен был высадиться на LAAT-e прямо во время боя, но его сбивают и вы оказываетесь в окружении, вы видите что вашего сослуживца завалило обломками, вы",["answers"]={"Полагаясь на свои боевые навыки, вы начинаете прикрывать своего товарища в ожидании помощи", "Вы, полагаясь на свои навыки решаете быстро добраться до других подразделений, дабы попросить помощь", "Вы оказываете помощь своему товарищу, вытаскивая своего товарища и стараетесь обеспечить ему первую мед. помощь"},["rightanswer"]=3},
	[10] = {["question"]="Ваш взвод устроил засаду на вражеский конвой, когда конвой начал приближаться, ваш командир перестал выходить на связь, вы, вместе с другими старшими во взводе решили",["answers"]={"Начать атаку конвоя без приказа командира, полагаясь на эффект неожиданности будучи из засады","Вы начинаете атаку конвоя быстрым маневром, не давая врагу даже попытаться спастись", "Вы начинаете залп из всех орудий, подавляя противника огневой мощью" },["rightanswer"]=3},
	[11] = {["question"]="Стоя на посту, вы слышите подозрительны шум из-за деревьев, вы решаете",["answers"]={"Занять позицию, внимательно просматривая территорию","Вы не решаетесь на риск, вы по рации вызываете сослуживцев на помощь","Вы решаете проверить территорию лично"},["rightanswer"]=2},
	[12] = {["question"]="Вы ведёте бои на открытом поле, в котором есть множество боевых позиций, вы решаете",["answers"]={"Занять возвышенность, полагаясь на точность уничтожая противника по одному","Вы решаете идти в лоб противнику, уничтожая их используя гранаты", "Вы держите позицию, открывая заградительный огонь по протвнику"},["rightanswer"]=3},
	[13] = {["question"]="На боевом задании вы совершили большую ошибку, за это ваш командир решил наказать вас, но дав вам выбор наказания, вы",["answers"]={"Выбираете чистку всего оружия своего взвода, думая о том что оружие, дабы с уверенностью идти с ним в бой","Вы встаёте на круглосуточный пост, не имея права на отдых, дабы проверить себя на стойкость","Вы идете в ангар, где начинаете помогать своим товарищам в распределении припасов и погрузкой снаряжения"},["rightanswer"]=1},
	[14] = {["question"]="Ваш командир повел ваш отряд в разведку, вы, учитывая местность, берёте с собой",["answers"]={"Оптический визор, дабы следить за местностью и докладывать обо всем командиру","Побольше припасов, что-бы обеспечить достаточный комплект нужных вещей","Вы берёте с собой только своё оружия, надеясь на свои навыки"},["rightanswer"]=1},
	[15] = {["question"]="На боевой операции в городских условиях, вы, зная карту города, решаете действовать",["answers"]={"Агрессивно, устраивая ловкие атаки на противника с учетом расположения зданий и прочей архитектуры","Вы действуете аккуратно, занимая выгодные позиции на крыше и устраивая засады","Вы решаете занять выгодные позиции в переулках и на улицах, обстраивая свои позиции укреплениями"},["rightanswer"]=2},
}

rtLang.legionTitle = "Выбери легион"
rtLang.legionOk = "Отправить"

rtLang.welcomeTitle = "Проверка знаний"
rtLang.welcomeText = "Сейчас ты пройдёшь небольшой тест на проверку только что полученных тобой знаний"
rtLang.welcomeOk = "Начать тест"
rtLang.welcomeCancel = "Повторить обучение"
rtLang.welcomeOffset1 = 40
rtLang.welcomeCType_1 = "restart"

rtLang.questionsTitle = "Тест"
rtLang.defualtOption = "Выбирай правильные ответы"
rtLang.forgotAnswer = "Ты забыл ответить на некоторые вопросы!"
rtLang.questionsOk = "Отправить"
rtLang.questionsCancel = ""

rtLang.passedTitle = "Проверка знаний"
rtLang.passedText = "Ты прошёл тест! Теперь ты готов играть на сервере!"
rtLang.passedOk = "Поехали!"
rtLang.passedCancel = ""

rtLang.failedTitle = "Ты не набрал определённого порога. Осталось %s попыток."
rtLang.failedText = "Повторить тест?"
rtLang.failedOk = "Повторить"
rtLang.failedCancel1 = "Повторить обучение"
rtLang.failedCancel2 = "Выйти с сервера"
rtLang.failedOffset1 = 40
rtLang.failedOffset2 = 20
rtLang.failedCType_1 = "restart"
rtLang.failedCType_2 = "exit"
----------------------------------------------------------------------------------------------------------------
rtLang.cancelKick = "Ты не хочешь отвечать на вопросы. Для того чтобы играть на сервере вы должны пройти тест!."
rtLang.noAttemptsKick = "Не осталось попыток."
rtLang.ok = "Начать"
rtLang.cancel = ""