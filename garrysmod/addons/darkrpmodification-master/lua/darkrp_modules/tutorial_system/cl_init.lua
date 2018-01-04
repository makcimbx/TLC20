local function TrainEnd()
	EverDerma("Обучение","Начать тест?",{{text="Да",
		func = function() 
			net.Start("startEvertest") net.WriteBool(true) net.SendToServer()
		end},
		{text="Нет",
		func = function()
			net.Start("startEvertest") net.WriteBool(false) net.SendToServer()
		end}
	})
end

hook.Add( "PostServerIntro", "Ever_PostServerIntro", function( ply )
	TrainEnd()
end )

net.Receive("sendtrain",function()
	local from = net.ReadEntity()
	local d = false
	EverDerma("Обучение","Принять обучение от инструктора:\n"..from:Nick(),{{text="Да",
		func = function() 
			net.Start("gettrain") net.WriteBool(true) net.SendToServer()
		end},
	{text="Нет",func = function() 
		net.Start("gettrain") net.WriteBool(false) net.SendToServer()
	end}})
end)

net.Receive("offertest",function(l,ply)
	local t = "Начать тест?"
	local auto = net.ReadBool() or false
	if(auto==true)then
		t = "Начать обучение?"
	end
	EverDerma("Обучение",t,{{text="Да",
		func = function() 
			net.Start("startEvertest") net.WriteBool(true) net.WriteBool(auto) net.SendToServer()
		end},
		{text="Нет",
		func = function()
			net.Start("startEvertest") net.WriteBool(false) net.SendToServer()
		end}
	})
end)