
SHop = SHop or {}
SHop.Cache = SHop.Cache or {}
SHop.Action = SHop.Action or {}
SHop.Config = SHop.Config or {}

--[[ Keep the server name short --]]
--[[ The php side will return all other data needed -- ]]
SHop.Config.Servers = {
	{Name = "Serious Roleplay", ServerIP = "54.36.151.237", Port = "27015"},
}

SHop.Config.ChatCommands = {"!join", "!servers"}

--[[ When the servers recache should we ask players via chat if they wanna join? ]]--
SHop.Config.Adverts = false

--[[ How often will it recache the serverrs? Keep this high. --]]
SHop.Config.Refresh = 500
