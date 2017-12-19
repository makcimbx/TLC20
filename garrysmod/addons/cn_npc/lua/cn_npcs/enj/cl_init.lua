-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Инженер"
local missname = "enj"

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
			self:addText("Здравия желаю солдат! Сделай осмотр некоторых панелей управления на венаторе (Подойди к панели управления и нажми E).")
			self:addOption("Хорошо.", function()
				self:addText("Данные скинул тебе на кпк. Думаю дальше сам разберёшься!.")
				self:addLeave("...","StartMission",id,self.name)
			end)
			
			self:addOption("У меня сейчас другое задание, прошу прощения.", function()
				self:addText("Хм, ну ладно, буду ждать тебя позже.")
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