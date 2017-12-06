util.AddNetworkString("TC2.0_Update")
util.AddNetworkString("TC2.0_Send")

local c_list = {}
local dis = {
	["removetab"] = "remove tab from group",
	["addtab"] = "add tab to group",
}

local function OnChangeTeam(ply, rank)
	local succ,err = pcall( function() local v = c_list[rank].tabs end )
	
	local z = {}
	if (succ == true) then
		z = c_list[rank].tabs
	end
	net.Start("TC2.0_Send")
		net.WriteTable( c_list[rank].tabs )
	net.Send(ply)
end
hook.Add( "serverguard.PostSavePlayerRank", "OnChangeTeam_Ever", OnChangeTeam )

local function Load()
	local n = tonumber(GetData("#TC_LIST","0"))
	for k=1,n do
		local data = {}
		data.tabs = {}
		data.group = GetData("TC_LIST_"..k.."_group","-")
		local n2 = tonumber( GetData("#TC_LIST_"..k.."_tab"..k,"0"))
		for z = 1,n2 do
			table.insert(data.tabs,GetData("TC_LIST_"..k.."_tab_"..z.."",v))
		end
		table.insert(c_list[data.group],data)
	end
	
	print( "[TC 2.0] Loaded "..n.." groups" )
end

local function Save()
	SetData("#TC_LIST",#c_list)
	for k,v in pairs(c_list)do
		SetData("TC_LIST_"..k.."_group",v.group)
		SetData("#TC_LIST_"..k.."_tab"..k,#v[v.group])
		for z,v in pairs(v[v.group])do
			SetData("TC_LIST_"..k.."_tab_"..z.."",v)
		end
	end
end

local function Add(ply, cmd, args)
	if(ply:IsSuperAdmin())then return false end
	if(#args<2)then print("[TC 2.0] "..cmd.." [group] [tab] to "..dis[cmd]) return false end
	AddTo(args[1], args[2])
end
concommand.Add( "addtab",Add)

local function Remove(ply, cmd, args)
	if(ply:IsSuperAdmin())then return false end
	if(#args<2)then print("[TC 2.0] "..cmd.." [group] [tab] to "..dis[cmd]) return false end
	RemoveFrom(args[1], args[2])
end
concommand.Add( "removetab",Remove)

local function AddTo(group, tab,p)
	local succ,err = pcall( function() local v = c_list[group].tabs[tab] end )

	if(succ == false)then
		local data = {}
		data.tabs = { tab }
		data.group = group
		table.insert(c_list[group],data)
		Save()
		Update(group,tab,"a")
	else
		table.insert(c_list[group].tabs,tab)
		Save()
		Update(group,tab,"a")
	end
	
	if(p == nil)then
		print( "[TC 2.0] Added '"..tab.."' to '"..group.."'" )
	else
		print( "[TC 2.0] Added '"..tab.."' to '"..group.."' by "..p:SteamID() )
	end
end

local function RemoveFrom(group, tab)
	local succ,err = pcall( function() local v = c_list[group].tabs[tab] end )

	if(succ == true)then
		table.RemoveByValue( c_list[group].tabs, tab )
		Save()
		Update(group,tab,"r")
	end
	
	if(p == nil)then
		print( "[TC 2.0] Removed '"..tab.."' to '"..group.."'" )
	else
		print( "[TC 2.0] Removed '"..tab.."' to '"..group.."' by "..p:SteamID() )
	end
	
end

local function Update(group, tab, t)
	for k,v in pairs(player.GetAll())do
		if(serverguard.player:GetRank(v) == group)then
			net.Start("TC2.0_Update")
				net.WriteString(group)
				net.WriteString(tab)
				net.WriteString(r)
			net.Send(v)
		end
	end
end

timer.Simple(0.5,function()
	Load()
	if(GetData( "tabs_default" )!="1")then
		SetData( "tabs_default","1" )
		AddTo("entities","admin",nil)
		AddTo("weapons","admin",nil)
		AddTo("npcs","admin",nil)
		AddTo("vehicles","admin",nil)
		AddTo("dupes","admin",nil)
		AddTo("cmenu","admin",nil)
	
		AddTo("entities","event_maker",nil)
		AddTo("weapons","event_maker",nil)
		AddTo("npcs","event_maker",nil)
		AddTo("vehicles","event_maker",nil)
		AddTo("dupes","event_maker",nil)
		AddTo("cmenu","event_maker",nil)
	
		AddTo("entities","superadmin",nil)
		AddTo("weapons","superadmin",nil)
		AddTo("npcs","superadmin",nil)
		AddTo("vehicles","superadmin",nil)
		AddTo("dupes","superadmin",nil)
		AddTo("cmenu","superadmin",nil)
	
		AddTo("entities","owner",nil)
		AddTo("weapons","owner",nil)
		AddTo("npcs","owner",nil)
		AddTo("vehicles","owner",nil)
		AddTo("dupes","owner",nil)
		AddTo("cmenu","owner",nil)
	
		AddTo("entities","administation",nil)
		AddTo("weapons","administation",nil)
		AddTo("npcs","administation",nil)
		AddTo("vehicles","administation",nil)
		AddTo("dupes","administation",nil)
		AddTo("cmenu","administation",nil)
	
		AddTo("entities","headadmin",nil)
		AddTo("weapons","headadmin",nil)
		AddTo("npcs","headadmin",nil)
		AddTo("vehicles","headadmin",nil)
		AddTo("dupes","headadmin",nil)
		AddTo("cmenu","headadmin",nil)
	end
end)




