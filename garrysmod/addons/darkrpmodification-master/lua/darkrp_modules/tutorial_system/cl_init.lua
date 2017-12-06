local function TrainEnd()
	net.Start("StartTest")
	
	net.SendToServer()
end

hook.Add( "PostServerIntro", "Ever_PostServerIntro", function( ply )
	TrainEnd()
end )

net.Receive("sendtrain",function()
	local from = net.ReadEntity()
	local d = false
	EverDerma("Обучение","Принять обучение от этого инструктора:\n"..from:Nick(),{{text="Да",
		func = function() 
			d = true
		end},
	{text="Нет",func = function() end}})
	net.Start("gettrain")
		net.WriteBool(d)
		net.WriteEntity(from)
	net.SendToServer()
end)