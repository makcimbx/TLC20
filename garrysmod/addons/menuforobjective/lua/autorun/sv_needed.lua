if SERVER then	

util.AddNetworkString("ObjectiveMenuHoly")


net.Receive("ObjectiveMenuHoly",function (l,ply)
    s1 = net.ReadString()
    s2 = net.ReadString()
    s3 = net.ReadString()
    s4 = net.ReadString()
    s5 = net.ReadString()
    s6 = net.ReadString()
	file.Write("anticheat_option/s1.txt",s1)
    file.Write("anticheat_option/s2.txt",s2)
    file.Write("anticheat_option/s3.txt",s3)
    file.Write("anticheat_option/s4.txt",s4)
    file.Write("anticheat_option/s5.txt",s5)
    file.Write("anticheat_option/s6.txt",s6)
    BroadcastLua( " s1 = \""..s1.."\"" )
    BroadcastLua( " s2 = \""..s2.."\"" )
    BroadcastLua( " s3 = \""..s3.."\"" )
    BroadcastLua( " s4 = \""..s4.."\"" )
    BroadcastLua( " s5 = \""..s5.."\"" )
    BroadcastLua( " s6 = \""..s6.."\"" )
end)

function Anticheat_Menu_Hule()
local s1=file.Read("anticheat_option/s1.txt","DATA")
local s2=file.Read("anticheat_option/s1.txt","DATA")
local s3=file.Read("anticheat_option/s1.txt","DATA")
local s4=file.Read("anticheat_option/s1.txt","DATA")
local s5=file.Read("anticheat_option/s1.txt","DATA")
local s6=file.Read("anticheat_option/s1.txt","DATA")
if (!s1 or !s2 or !s3 or !s4 or !s5 or !s6) then
file.CreateDir("anticheat_option")
file.Write("anticheat_option/s1.txt","")
file.Write("anticheat_option/s2.txt","")
file.Write("anticheat_option/s3.txt","")
file.Write("anticheat_option/s4.txt","")
file.Write("anticheat_option/s5.txt","")
file.Write("anticheat_option/s6.txt","")
s1 = ""
s2 = ""
s3 = ""
s4 = ""
s5 = ""
s6 = ""
else
SetGlobalString(s1,file.Read("anticheat_option/s1.txt","DATA"))
SetGlobalString(s2,file.Read("anticheat_option/s2.txt","DATA"))
SetGlobalString(s3,file.Read("anticheat_option/s3.txt","DATA"))
SetGlobalString(s4,file.Read("anticheat_option/s4.txt","DATA"))
SetGlobalString(s5,file.Read("anticheat_option/s5.txt","DATA"))
SetGlobalString(s6,file.Read("anticheat_option/s6.txt","DATA"))
end
end
hook.Add("Initialize", "Anticheat_Menu_Hule", Anticheat_Menu_Hule)

function Transfer_On_Player_spawn_Anti(ply)
s1=tostring(file.Read("anticheat_option/s1.txt","DATA"))
s2=tostring(file.Read("anticheat_option/s2.txt","DATA"))
s3=tostring(file.Read("anticheat_option/s3.txt","DATA"))
s4=tostring(file.Read("anticheat_option/s4.txt","DATA"))
s5=tostring(file.Read("anticheat_option/s5.txt","DATA"))
s6=tostring(file.Read("anticheat_option/s6.txt","DATA"))
ply:SendLua( " s1 = \""..s1.."\"" )
ply:SendLua( " s2 = \""..s2.."\"" )
ply:SendLua( " s3 = \""..s3.."\"" )
ply:SendLua( " s4 = \""..s4.."\"" )
ply:SendLua( " s5 = \""..s5.."\"" )
ply:SendLua( " s6 = \""..s6.."\"" )
end
hook.Add("TC2.0_Connect", "Transfer_On_Player_spawn_Anti", Transfer_On_Player_spawn_Anti)

end