local function makesomedo(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end
	
	--local babycol = team.GetColor(ply:Team())

    local DoSay = function(text)
		local ents = ents.FindInSphere(ply:EyePos(), 250)
        for k, v in pairs(ents) do
			if v:IsPlayer() then
				serverguard.Notify(v, Color(255,255,0), args, " ("..ply:GetName()..")");
			end
		end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("do", makesomedo)

local function makesometry(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end

	local l = math.Rand( 0, 100 ) 
	local t = "[Неудачно]"
	local col = Color(255,0,0)
	if(l>50)then
		t = "[Удачно]"
		col = Color(0,255,0)
	end
	
	local babycol = team.GetColor(ply:Team())
	
    local DoSay = function(text)
		local ents = ents.FindInSphere(ply:EyePos(), 250)
        for k, v in pairs(ents) do
			if v:IsPlayer() then
				serverguard.Notify(v, babycol, ply:GetName(), Color(255,255,255), " "..text.." ",col,t);
			end
		end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("try", makesometry)

local function makesomeb(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end

    local DoSay = function(text)
		local ents = ents.FindInSphere(ply:EyePos(), 250)
        for k, v in pairs(ents) do
			if v:IsPlayer() then
				serverguard.Notify(v, Color(128, 128, 128), ply:GetName(), " (( ", args, " )) ");
			end
		end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("b", makesomeb)

local function roll(ply, args)
	local rnd = math.random(0,100)
    local DoSay = function(text)
		local ents = ents.FindInSphere(ply:EyePos(), 250)
        for k, v in pairs(ents) do
			if v:IsPlayer() then
				serverguard.Notify(v, SERVERGUARD.NOTIFY.GREEN, ply:GetName(), SERVERGUARD.NOTIFY.WHITE, " выпало ", SERVERGUARD.NOTIFY.RED, rnd.."");
			end
		end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("roll", roll)

DarkRP.declareChatCommand{
	command = "/",
	description = "ooc",
	delay = 1.5
}

DarkRP.declareChatCommand{
	command = "a",
	description = "ooc",
	delay = 1.5
}

DarkRP.declareChatCommand{
	command = "ooc",
	description = "ooc",
	delay = 1.5
}