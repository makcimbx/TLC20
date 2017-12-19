-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "7th INS Jedi CO Sentinel Zeraf"
local missname = "pilots"

function NPC:onStart()
	local ply = LocalPlayer()
	local id = ply:GetPData("last_npc_id")
	local entity = Entity(id)
	local id2 = entity:GetQuest()
	local take = ply:GetPData("npc_take","0")
	local id3 = ply:GetPData("last_npc_id3","0")
	local make = ply:GetPData("npc_"..id2.."make","0")
	local time = ply:GetPData("npc_"..id2.."time","0")
	
	if(time=="0" or time==nil)then
		if(take=="0" or take==nil)then
			self:addText("Привет! Не хотел бы сделать тренировочный полёт?")
			self:addOption("Не против.", function()
				self:addText("Отлично! Данные скинул тебе на кпк. Вылетай из ангара на одном из кораблей и следуй точкам!.")
				self:addLeave("...","StartMission",id,self.name)
			end)
			
			self:addOption("Не сейчас.", function()
				self:addText("Серьёзно? Ладно. Возвращайся когда будет время. Ты знаешь где меня найти.")
				self:addLeave("...")
			end)
		else
			if(make=="0" or make==nil)then
				if(id3==self.uniqueID)then
					self:addText("Ты сделал задание? Нет?! Тогда почему ещё здесь?")
					self:addOption("Уже собираюсь выполнить!.", function()
						self:addText("Хорошо! Ступай.")
						self:addLeave("...")
					end)
					
					self:addOption("Я отказываюсь от задания!.", function()
						self:addText("Серьёзно? Ладно. Возвращайся когда будет время. Ты знаешь где меня найти.")
						self:addLeave("...","stopMission",id)
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

/*if(take=="0" or take==nil)then
	self:addText("Hello there, how are you today?")
		self:addOption("I'm good.", function()
			self:addText("That's good!")

			self:addLeave("See you later.",missname,id)
		end)

		self:addOption("I feel cold.", function()
			self:addText("Do you want to feel warmer?")

			self:addOption("Sure!", function()
				self:send("Ignite", math.random(5, 10))

				self:addLeave("Ouch!")
			end)
			self:addLeave("No thanks.")
		end)
	else
		self:addText("Ты ебанарик")
		self:addLeave("...")
	end*/