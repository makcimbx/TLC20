
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
	[TEAM_501CPL] = true,
	[TEAM_501SGT] = true,
	[TEAM_501LT] = true,
	[TEAM_501CPT] = true,
	[TEAM_501MJR] = true,
	[TEAM_501COL] = true,
	[TEAM_501CO] = true,
	[TEAM_212CPL] = true,
	[TEAM_212SGT] = true,
	[TEAM_212LT] = true,
	[TEAM_212CPT] = true,
	[TEAM_212MJR] = true,
	[TEAM_212COL] = true,
	[TEAM_212CO] = true,
	[TEAM_327CPL] = true,
	[TEAM_327SGT] = true,
	[TEAM_327LT] = true,
	[TEAM_327CPT] = true,
	[TEAM_327MJR] = true,
	[TEAM_327COL] = true,
	[TEAM_327CO] = true,
	[TEAM_41CPL] = true,
	[TEAM_41SGT] = true,
	[TEAM_41LT] = true,
	[TEAM_41CPT] = true,
	[TEAM_41MJR] = true,
	[TEAM_41COL] = true,
	[TEAM_41CO] = true,
	[TEAM_91CPL] = true,
	[TEAM_91SGT] = true,
	[TEAM_91LT] = true,
	[TEAM_91CPT] = true,
	[TEAM_91MJR] = true,
	[TEAM_91COL] = true,
	[TEAM_91CO] = true,
	[TEAM_104CPL] = true,
	[TEAM_104SGT] = true,
	[TEAM_104LT] = true,
	[TEAM_104CPT] = true,
	[TEAM_104MJR] = true,
	[TEAM_104COL] = true,
	[TEAM_104CO] = true,
	[TEAM_74CPL] = true,
	[TEAM_74SGT] = true,
	[TEAM_74LT] = true,
	[TEAM_74CPT] = true,
	[TEAM_74MJR] = true,
	[TEAM_74COL] = true,
	[TEAM_74CO] = true,
	[TEAM_EODCPL] = true,
	[TEAM_EODSGT] = true,
	[TEAM_EODLT] = true,
	[TEAM_EODCPT] = true,
	[TEAM_EODMJR] = true,
	[TEAM_EODCOL] = true,
	[TEAM_EODCO] = true,
	[TEAM_PILOTCPL] = true,
	[TEAM_PILOTSGT] = true,
	[TEAM_PILOTLT] = true,
	[TEAM_PILOTCPT] = true,
	[TEAM_PILOTMJR] = true,
	[TEAM_PILOTCOL] = true,
	[TEAM_PILOTCO] = true,
	[TEAM_ARCCPL] = true,
	[TEAM_ARCSGT] = true,
	[TEAM_ARCLT] = true,
	[TEAM_ARCCPT] = true,
	[TEAM_ARCMJR] = true,
	[TEAM_ARCCOL] = true,
	[TEAM_ARCCO] = true,
	[TEAM_GUARDCPL] = true,
	[TEAM_GUARDSGT] = true,
	[TEAM_GUARDLT] = true,
	[TEAM_GUARDCPT] = true,
	[TEAM_GUARDMJR] = true,
	[TEAM_GUARDCOL] = true,
	[TEAM_GUARDCO] = true,
}

function command:OnPlayerExecute(ply, target, arguments)
	if(ply == target or allowedjobs[ply:Team()] != true)then return end
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