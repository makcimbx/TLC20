if !CustomBanMsg then CustomBanMsg = {} end
--[[ Settings ]]--

	CustomBanMsg.NotifyAll = true --If this is true, when a banned person tries joining, everyone will be notified in chat
	CustomBanMsg.NotifyOnlyAdmins = false -- If this is true, then it will only notify admins, if ULX or Evolve is enabled then anyone with specified permissions
	
	
	CustomBanMsg.Banned = {}
	
		CustomBanMsg.Banned.Msg = 
		[[_________________You are banned_________________
		
		Админ: {AdminName}

		Причина: {Reason}

		Время бана: {TimeBan}

		Осталось времени: {TimeLeft}
		]] -- Message that the banned person will get. {AdminName} = Admin's that banned them, name. {Reason} = Reason of the ban. {TimeBan} = Time of ban. {TimeLeft} = Time left until unban. 

		CustomBanMsg.Banned.ChatMsg = "{Name} попытался присоединиться к серверу, пока был забанен за {Reason}" -- {Name} = Persons name, {Reason} = Reason of their ban
		CustomBanMsg.Banned.ChatColor = Color(255,0,0) -- Color that the previous message will be



	CustomBanMsg.WrongPass = {}	
	
		CustomBanMsg.WrongPass.Msg = [[
		--------------------------------------------------------------------
		                          Неправильный пароль			
		--------------------------------------------------------------------
		]] -- Message that anyone with wrong password will get
		
		CustomBanMsg.WrongPass.ChatMsg = "{Name} попытался присоединиться с неправильным паролем: {Pass}" -- {Name} = Persons name, {Pass} = Password that they tried to join with
		CustomBanMsg.WrongPass.ChatColor = Color(255,0,0) -- Color that the previous message will be
	
	
	
	
	
--[[ /Settings ]]-- DO NOT edit anything further than this, if you don't know what you are doing!!



--[[ Send colored chat message to player]]--
if SERVER then
	util.AddNetworkString( "CustomBanMsgChat" )
end

function CustomBanMsg.Chat( Ply, ... )
	
		
	if CLIENT then

		chat.AddText( ... )
	
	elseif SERVER then
		if Ply == "All" then
		
			net.Start( "CustomBanMsgChat" )
				net.WriteTable({ ... })
			net.Broadcast()
		else
		
			if not IsValid(Ply) then return end
			net.Start( "CustomBanMsgChat" )
				net.WriteTable({ ... })
			net.Send( Ply )
		end
	end
end

if CLIENT then
	net.Receive( "CustomBanMsgChat", function()
		chat.AddText( unpack( net.ReadTable() ) )
	end)		
end

--[[ /Send colored chat message to player]]--