if SERVER then

function chatCommandANTICHEAT( ply, text, public )
    if (string.sub(text, 1, 10) == "!gotoevent" or string.sub(text, 1, 10) == "/gotoevent") then --if the first 4 letters are /die, kill him
	
         local ip="195.62.52.237:27016" 
		 
		 ply:SendLua([[LocalPlayer():ConCommand("connect ]]..tostring(ip)..[[")]]) 
		 
         return(false) --Hides the "/die" from chat
    end
end
hook.Add( "PlayerSay", "chatCommandANTICHEAT", chatCommandANTICHEAT );


end