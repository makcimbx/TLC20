
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
			table.insert(TrainPlayer,{ply = ply,tm = 300})
			ply.train_wait = true
			ply:SetNWBool( "train_wait", true )
			ply:SendLua("StartTTimer()")
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

local allowedjobs = {
	--["cadet"] = true,
	["501cpl"] = true,
	["501sgt"] = true,
	["501lt"] = true,
	["501cpt"] = true,
	["501mjr"] = true,
	["501col"] = true,
	["501co"] = true,
	["212cpl"] = true,
	["212sgt"] = true,
	["212lt"] = true,
	["212cpt"] = true,
	["212MJR"] = true,
	["212col"] = true,
	["212co"] = true,
	["327cpl"] = true,
	["327sgt"] = true,
	["327lt"] = true,
	["327cpt"] = true,
	["327mjr"] = true,
	["327col"] = true,
	["327co"] = true,
	["41thcpl"] = true,
	["41thsgt"] = true,
	["41thlt"] = true,
	["41thcpt"] = true,
	["41thmjr"] = true,
	["41thcol"] = true,
	["41thco"] = true,
	["91cpl"] = true,
	["91sgt"] = true,
	["91lt"] = true,
	["91cpt"] = true,
	["91mjr"] = true,
	["91col"] = true,
	["91co"] = true,
	["104cpl"] = true,
	["104sgt"] = true,
	["104lt"] = true,
	["140cpt"] = true,
	["104mjr"] = true,
	["104col"] = true,
	["104co"] = true,
	["74cpl"] = true,
	["74sgt"] = true,
	["74lt"] = true,
	["74cpt"] = true,
	["74mjr"] = true,
	["74col"] = true,
	["74co"] = true,
	["eodcpl"] = true,
	["eodsgt"] = true,
	["eodlt"] = true,
	["eodcpt"] = true,
	["eodmjr"] = true,
	["eodcol"] = true,
	["eodco"] = true,
	["pilotcpl"] = true,
	["pilotsgt"] = true,
	["pilotlt"] = true,
	["pilotcpt"] = true,
	["pilotmjr"] = true,
	["pilotcol"] = true,
	["pilotco"] = true,
	["arccpl"] = true,
	["arcsgt"] = true,
	["arclt"] = true,
	["arccpt"] = true,
	["arcmjr"] = true,
	["arccol"] = true,
	["arcco"] = true,
	["guardcpl"] = true,
	["guardsgt"] = true,
	["guardlt"] = true,
	["guardcpt"] = true,
	["guardmjr"] = true,
	["guardcol"] = true,
	["guardco"] = true,
}

function command:OnPlayerExecute(ply, target, arguments)
	if(ply == target or (allowedjobs[ply:getJobTable().command] or false) != true)then return end
	if(game.GetMap()!="rp_chancellor_tlc_b1")then return end
	if target.train_wait!=nil and target.sempai == nil then 
		target.pause = true
		target:SendLua("PauseTTimer()")
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
			net.WriteBool(false)
		net.Send(target)
	else
		serverguard.Notify(ply, SERVERGUARD.NOTIFY.RED,"Вы не обучаете данного игрока!");
	end
	
	return true;
end;
serverguard.command:Add(command);