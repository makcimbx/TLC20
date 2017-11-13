local function makesomedo(ply, args)
    if args == "" then
        DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
        return ""
    end

    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, Color(255,255,0), ply:Nick().." "..text)
            end
        else
            DarkRP.talkToRange(ply, "(("..ply:Nick()..")) "..text, "", 250,Color(255,255,0))
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
	
    local DoSay = function(text)
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, col, ply:Nick().." "..text.." "..t)
            end
        else
            DarkRP.talkToRange(ply, ply:Nick().." "..text.." "..t, "", 250,col)
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
        if text == "" then
            DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
            return ""
        end
        if GAMEMODE.Config.alltalk then
            for _, target in pairs(player.GetAll()) do
                DarkRP.talkToPerson(target, Color(128, 128, 128), ply:Nick().." (( "..text.." ))")
            end
        else
            DarkRP.talkToRange(ply, ply:Nick().." (( "..text.." ))", "", 250,Color(128, 128, 128))
        end
    end
    return args, DoSay
end
DarkRP.defineChatCommand("b", makesomeb)
