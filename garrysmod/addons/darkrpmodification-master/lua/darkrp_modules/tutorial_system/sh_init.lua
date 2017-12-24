
local command = {};
command.help = "train me pls.";
command.command = "train";
command.arguments = {};
command.bDisallowConsole = true

function command:Execute(ply, silent, arguments)
	if(game.GetMap()!="rp_chancellor_tlc_b1")then return end
	if ply.train_wait==nil then
		if ply:GetPData("tutor_ever","0") != "1" then 
			serverguard.Notify(ply,SERVERGUARD.NOTIFY.WHITE,"Ждите в течении", SERVERGUARD.NOTIFY.GREEN," 5 минут",SERVERGUARD.NOTIFY.WHITE," прибытия",SERVERGUARD.NOTIFY.RED," инструктора",SERVERGUARD.NOTIFY.WHITE,", либо вам будет предложено",SERVERGUARD.NOTIFY.RED,SERVERGUARD.NOTIFY.WHITE, " автоматическое обучение.");
  
			ply.pause = false
			table.insert(TrainPlayer,{ply = ply,tm = 5*60})
			ply.train_wait = true
			ply:SendLua("LocalPlayer().train_wait = true")
		else
			serverguard.Notify(ply,SERVERGUARD.NOTIFY.RED,"Вы уже проходили обучение!");
		end
	end
end;
serverguard.command:Add(command);

command = {};
command.help		= "";
command.command 	= "offertrain";
command.arguments	= {"player"};
command.permissions	= "Offertrain";
command.immunity 	= SERVERGUARD.IMMUNITY.ANY;
command.bSingleTarget = true;

function command:OnPlayerExecute(ply, target, arguments)
	if(ply == target)then return end
	if(game.GetMap()!="rp_chancellor_tlc_b1")then return end
	if target.train_wait!=nil and target.sempai == nil then 
		target.pause = true
		target.presempai = ply
		net.Start("sendtrain")
			net.WriteEntity(ply)
		net.Send(target)
	else
		if(target.sempai != nil)then
			serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED,"Этот игрок уже принял приглашение другого инструктора!");
		else
			serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED,"Этот игрок не нуждается в обучении!");
		end
	end
	
	return true;
end;
serverguard.command:Add(command);


command = {};
command.help		= "";
command.command 	= "offertest";
command.arguments	= {"player"};
command.permissions	= "Offertest";
command.immunity 	= SERVERGUARD.IMMUNITY.ANY;
command.bSingleTarget = true;

function command:OnPlayerExecute(ply, target, arguments)
	if(ply == target)then return end
	if(game.GetMap()!="rp_chancellor_tlc_b1")then return end
	if target.sempai==ply then
		net.Start("offertest")
		net.Send(target)
	else
		serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED,"Вы не обучаете данного игрока!");
	end
	
	return true;
end;
serverguard.command:Add(command);