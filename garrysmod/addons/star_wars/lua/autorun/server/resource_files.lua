resource.AddWorkshop("1138475161")
util.AddNetworkString("SW.OpenF4")

hook.Add("ShowSpare2","OpenDarkrPMenu",function(ply)
    net.Start("SW.OpenF4")
    net.Send(ply)
end)
