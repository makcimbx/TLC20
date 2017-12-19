
SHop = SHop or {}
SHop.Cache = SHop.Cache or {}
SHop.Action = SHop.Action or {}
SHop.Config = SHop.Config or {}

util.AddNetworkString("SHOPOpenMenu")
function SHop.Action:RefreshCache()
	SHop.Cache = {}

	MsgN("---Refreshing the server hop cache!---")
	for k,v in pairs(SHop.Config.Servers) do
		http.Post("http://pgrpdev.site.nfoservers.com/shop/shop.php", { ip = v.ServerIP, port = v.Port}, function( result )
			if result then
				local tbl = util.JSONToTable(result)
				local tbl = table.Add(v, tbl)
				local index = table.Count(SHop.Cache)
				table.insert(SHop.Cache, index+1,  tbl)
			end
		end, function( failed )
			print( failed )
		end )
	end

	timer.Simple(SHop.Config.Refresh, function() SHop.Action:RefreshCache()  end)
end

local function startcache() 
	SHop.Action:RefreshCache()
end
hook.Add( "Initialize", "SHop.Action:loadCache()", startcache)


hook.Add( "PlayerSay", "SHop.ChatCommandCall", function( ply, text, public )
	text = string.lower( text )
	if (table.HasValue(SHop.Config.ChatCommands, text)) then
		net.Start("SHOPOpenMenu")
			net.WriteTable(SHop.Cache)
		net.Send(ply)
		return ""
	end
end )

resource.AddWorkshop(1123239387)