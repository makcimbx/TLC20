local function TrainEnd()
	if(LocalPlayer().respawned != false)then
		net.Start("StartTest")
		net.SendToServer()
	else
		net.Start("GlideSpawnStop")
		net.SendToServer()
	end
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
		net.Start("gettrain") net.WriteBool(true) net.SendToServer()
	end}})
end)

net.Receive("offertest",function(l,ply)
	local d = false
	EverDerma("Обучение","Начать тест?",{{text="Да",
		func = function() 
			net.Start("startEvertest") net.WriteBool(true) net.SendToServer()
		end},
		{text="Нет",
		func = function()
			net.Start("startEvertest") net.WriteBool(false) net.SendToServer()
		end}
	})
end)