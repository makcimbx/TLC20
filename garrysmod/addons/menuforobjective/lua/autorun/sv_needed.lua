if SERVER then	

util.AddNetworkString("ObjectiveMenuHoly")


net.Receive("ObjectiveMenuHoly",function (l,ply)
    s1 = net.ReadString()
    s2 = net.ReadString()
    s3 = net.ReadString()
    s4 = net.ReadString()
    s5 = net.ReadString()
    s6= net.ReadString()
    BroadcastLua( " s1 = \""..s1.."\"" )
    BroadcastLua( " s2 = \""..s2.."\"" )
    BroadcastLua( " s3 = \""..s3.."\"" )
    BroadcastLua( " s4 = \""..s4.."\"" )
    BroadcastLua( " s5 = \""..s5.."\"" )
    BroadcastLua( " s6 = \""..s6.."\"" )
end)
end