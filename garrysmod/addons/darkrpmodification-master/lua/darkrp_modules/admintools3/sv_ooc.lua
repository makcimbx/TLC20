DarkRP.removeChatCommand("/")
DarkRP.removeChatCommand("a")
DarkRP.removeChatCommand("ooc")

local lastDelay = 0
local OOCDelay = 1
local OOCGlobal = true
timer.Simple( 5, function()
	OOCDelay = tonumber(GetData( "OOCDelay", "1" ))
	OOCGlobal = tobool(GetData( "OOCGlobal", "true" ))
end )

local function OOC(ply, args)
    if GAMEMODE.Config.ooc == false or OOCGlobal==false then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("disabled", DarkRP.getPhrase("ooc"), ""))
        return ""
    end
	
	if(lastDelay>CurTime())then DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("disabled", DarkRP.getPhrase("ooc"), "")) return "" end

    lastDelay = CurTime() + OOCDelay
	
	local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        local col = team.GetColor(ply:Team())
        local col2 = Color(255,255,255,255)
        if not ply:Alive() then
            col2 = Color(255,200,200,255)
            col = col2
        end
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, col, "(" .. DarkRP.getPhrase("ooc") .. ") " .. ply:Name(), col2, text, ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("/", OOC, true, 1.5)
DarkRP.defineChatCommand("a", OOC, true, 1.5)
DarkRP.defineChatCommand("ooc", OOC, true, 1.5)

local function sooc(ply, args)
	local adm = ply:CanCMD("sooc")
	if !adm then
		return ""
	end
	
    OOCGlobal = !OOCGlobal
	SetData( "OOCGlobal", OOCGlobal )
	
	args = "включен"
	if(OOCGlobal==false)then
		args = "выключен"
	end

    local DoSay = function()
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, Color(153,153,255), "(( ООС чат "..args.." ))", Color(0,0,0), "", ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("sooc", sooc, true, 1.5)
DarkRP.defineChatCommand("/sooc", sooc, true, 1.5)

local function oocdelay(ply, args)
	local adm = ply:CanCMD("oocdelay")
	if !adm then
		return ""
	end
	
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end
    if tonumber(args) == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end
	OOCDelay = tonumber(args)
	SetData( "OOCDelay", OOCDelay )
	
    local DoSay = function()
        for k,v in pairs(player.GetAll()) do
            DarkRP.talkToPerson(v, Color(153,153,255), "(( ООС задержка установлена на "..tonumber(args).." сек. ))", Color(0,0,0), "", ply)
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("od", oocdelay, true, 1.5)
DarkRP.defineChatCommand("/od", oocdelay, true, 1.5)
