-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Солдат Армии Республики"

function NPC:onStart()
	local ply = LocalPlayer()
	local id = ply:GetPData("last_npc_id")
	local entity = Entity(id)
	local id2 = entity:GetQuest()
	local take = ply:GetPData("npc_take","0")
	local id3 = ply:GetPData("last_npc_id3","0")
	local make = ply:GetPData("npc_"..id2.."make","0")
	local time = ply:GetPData("npc_"..id2.."time","0")
	local infir = GetData( entity:GetQuest().."startFirMis","0")
	
	if(time=="0" or time==nil)then
		if(take=="0" or take==nil)then
			if(infir=="0" or infir==nil)then
				self:addText("Привет! Настоло время тренировки!")
				self:addOption("Хорошо. Что нужно делать?", function()
					self:addText("Стреляй по мишеням! Чем лучше будешь стрелять тем лучше!")
					self:addOption("Хорошо! Давай начнём!", function()
						self:addText("Не так быстро! Сначала выбери сложность!")
						self:addText("В зависимости от сложности увеличиваются скорость,нужное количество попаданий и награда!")
						self:addText("На выполнение задания у тебя есть 5 минут!")
						self:addLeave("Начать миссию[ЛЕГКО]","StartFiringMission",id,self.name,1,5000,25000)
						self:addLeave("Начать миссию[СРЕДНЕ]","StartFiringMission",id,self.name,2,5000,50000)
						self:addLeave("Начать миссию[СЛОЖНО]","StartFiringMission",id,self.name,3,5000,75000)
						self:addLeave("Начать миссию[ХАРДКОР]","StartFiringMission",id,self.name,4,5000,100000)
					end)
					self:addOption("Не сейчас.", function()
						self:addText("Серьёзно? Ладно. Возвращайся когда будет время. Ты знаешь где меня найти.")
						self:addLeave("...")
					end)
				end)
				self:addOption("Не сейчас.", function()
					self:addText("Серьёзно? Ладно. Возвращайся когда будет время. Ты знаешь где меня найти.")
					self:addLeave("...")
				end)
			else
				self:addText("Сейчас это задание выполняет кто-то другой!")
				self:addText("Прийди позже.")
				self:addLeave("...")
			end
		else
			if(make=="0" or make==nil)then
				if(id3==self.uniqueID)then
					self:addText("Ты сделал задание? Нет?! Тогда почему ещё здесь?")
					self:addOption("Уже собираюсь выполнить!", function()
						self:addText("Хорошо! Ступай.")
						self:addLeave("...")
					end)
					
					self:addOption("Я отказываюсь от задания!.", function()
						self:addText("Серьёзно? Ладно. Возвращайся когда будет время. Ты знаешь где меня найти.")
						self:addLeave("...","stopFiringMission",id)
					end)
				else
					self:addText("Ты уже выполняешь чьё-то задание! Возвращайся позже!")
					self:addLeave("...")
				end
			else
				if(id3==self.uniqueID)then
					self:addText("Выполнил задание? Отлично! Забирай награду.")
					self:addLeave("Взять награду.","getReward",id)
				else
					self:addText("Ты уже выполняешь чьё-то задание! Возвращайся позже!")
					self:addLeave("...")
				end
			end
		end
	else
		self:addText("Ты уже выполнял задание! Возвращайся завтра!")
		self:addLeave("...")
	end
end