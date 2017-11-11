SW = { }
SW.F4Title = "TLC Community"
SW.DrawHitMarkers = true
SW.EnableHungerMod = false
SW.EnableF4 = true
SW.EnableScoreboard = true

if CLIENT then

    SW.UseChatbox = false
    SW.WebsitePage = "http://google.com/"
    SW.UseRadar = true
    SW.TracedRadar = false
    SW.RadarUpdateRate = 1
    SW.DrawHealth = true
    SW.DrawHealthAmount = true

    SW.RadarPos = {
        x = ScrW() - 256 ,
        y = 64
    }

    SW.Rules = { "Don't jump" , "Don't disrespect" , "Don't spam mic" , "Use common sense" , "Be smart" , "You can't shout allah akbar" }
end

SW.ShowLevelHUD = true

function SW:ShowLevel(ply)
    if (gLevel) then
        return gLevel.getLevel(LocalPlayer())
    elseif (ply.GetLevel) then
        return ply:GetLevel()
    elseif (ply:getDarkRPVar("level" , 0) ~= nil) then
        return ply:getDarkRPVar("level" , 1)
    else
        return 1
    end
end
