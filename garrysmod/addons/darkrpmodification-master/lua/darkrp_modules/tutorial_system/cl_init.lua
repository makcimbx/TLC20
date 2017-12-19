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