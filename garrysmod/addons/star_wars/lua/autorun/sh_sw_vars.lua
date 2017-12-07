SW = { }
SW.F4Title = "TLC Community"
SW.DrawHitMarkers = true
SW.EnableHungerMod = false
SW.EnableF4 = true
SW.EnableScoreboard = true

if CLIENT then

    SW.UseChatbox = false
    SW.WebsitePage = "https://vk.com/clonewarsrpporus"
    SW.UseRadar = true
    SW.TracedRadar = true
    SW.RadarUpdateRate = 1
    SW.DrawHealth = true
    SW.DrawHealthAmount = true

    SW.RadarPos = {
        x = ScrW() - 256 ,
        y = 64
    }

    SW.Rules = { "Запрещено:" , "MetaGaming" , "JobAbuse" , "PropClimb" , "SpawnKill" , "RDM", "И ещё много всего, подробнее в группе вк" }
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
