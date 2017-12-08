util.AddNetworkString("TC2.0_Update")
util.AddNetworkString("TC2.0_Send")
util.AddNetworkString("TC2.0_Connect")

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

function Load()
	local n = tonumber(GetData("#TC_LIST","0"))
	for k=1,n do
		local tabs = {}
		local n2 = tonumber( GetData("#TC_LIST_"..k.."_tab","0"))
		for z = 1,n2 do
			table.insert(tabs,GetData("TC_LIST_"..k.."_tab_"..z.."","0"))
		end
		local g = GetData("TC_LIST_"..k.."_group","-")
		c_list[g] = {}
		c_list[g].tabs = tabs
		c_list[g].group = g
	end
	MsgC( Color( 255, 0, 0 ),"[TC 2.0] Loaded "..n.." groups\n")  
end

function Save()
	SetData("#TC_LIST",table.Count(c_list))
	local kk = 1
	for k,v in pairs(c_list)do
		SetData("TC_LIST_"..kk.."_group",v.group)
		SetData("#TC_LIST_"..kk.."_tab",#v.tabs)
		for z,v in pairs(v.tabs)do
			SetData("TC_LIST_"..kk.."_tab_"..z.."",v)
		end
		kk = kk + 1
	end
end

function GetList(ply, cmd, args)
	if(serverguard.player:HasPermission(ply, "Tabs_GetList") == false)then return false end
	for k,v in pairs(c_list)do
		if(ply==NULL)then
			MsgC( Color( 255, 0, 0 ),v.group.."\n") 
			for k,v in pairs(v.tabs)do
				MsgC( Color( 0, 255, 0 ),"	["..k.."] '"..v.."'\n") 
			end
		else
			ply:SendLua("MsgC( Color( 255, 0, 0 ), \""..v.group.."\\n\")") 
			for k,v in pairs(v.tabs)do
				ply:SendLua("MsgC( Color( 0, 255, 0 ), \"	["..k.."] '"..v.."'\\n\")") 
			end
		end
	end
end
concommand.Add( "tabs_list",GetList)

local tbs = {
	"entities",
	"weapons",
	"npcs",
	"postprocess",
	"vehicles",
	"dupes", 
	"saves"
}

function GetTList(ply, cmd, args)
	if(serverguard.player:HasPermission(ply, "Tabs_GetList") == false)then return false end
	if(ply==NULL)then
		MsgC( Color( 255, 0, 0 ),"[TC 2.0 TABS]\n") 
		for k,v in pairs(tbs)do
			MsgC( Color( 0, 255, 0 ),"	["..k.."] '"..v.."'\n") 
		end
	else
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"[TC 2.0 TABS]\\n\")") 
		for k,v in pairs(tbs)do
			ply:SendLua("MsgC( Color( 0, 255, 0 ),\"	["..k.."] '"..v.."'\\n\")") 
		end
	end
end
concommand.Add( "tabs_tlist",GetTList)

function Help(ply, cmd, args)
	if(serverguard.player:HasPermission(ply, "Tabs_GetHelp") == false)then return false end
	if(ply==NULL)then
		MsgC( Color( 255, 0, 0 ),"[TC 2.0 HELP]\n") 
		MsgC( Color( 255, 0, 0 ),"tabs_addtab [group] [tab] ") MsgC( Color( 0, 255, 0 ),"-add tab to group\n") 
		MsgC( Color( 255, 0, 0 ),"tabs_removetab [group] [tab] ") MsgC( Color( 0, 255, 0 ),"-delete tab from group\n") 
		MsgC( Color( 255, 0, 0 ),"tabs_list ") MsgC( Color( 0, 255, 0 ),"-open saved list\n") 
		MsgC( Color( 255, 0, 0 ),"tabs_tlist ")  MsgC( Color( 0, 255, 0 ),"-open list of tabs\n") 
	else
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"[TC 2.0 HELP]\\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"tabs_addtab [group] [tab] \") MsgC( Color( 0, 255, 0 ),\"-add tab to group\\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"tabs_removetab [group] [tab] \") MsgC( Color( 0, 255, 0 ),\"-delete tab from group\\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"tabs_list \") MsgC( Color( 0, 255, 0 ),\"-open saved list\\n\")") 
		ply:SendLua("MsgC( Color( 255, 0, 0 ),\"tabs_tlist \")  MsgC( Color( 0, 255, 0 ),\"-open list of tabs\\n\")") 
	end
end
concommand.Add( "tabs_help",Help)

function Add(ply, cmd, args)
	if(serverguard.player:HasPermission(ply, "Tabs_AddTab") == false)then return false end
	if(#args<2)then
		if(ply!=NULL)then
			ply:SendLua("MsgC( Color( 255, 0, 0 ), \"[TC 2.0] Error! Use '"..cmd.." [group] [tab]' to "..dis[cmd].."\\n\")")  
		else
			MsgC( Color( 255, 0, 0 ),"[TC 2.0] Error! Use '"..cmd.." [group] [tab]' to "..dis[cmd].."\n") 
		end
		return false 
	end
	AddTo(args[1], args[2],ply)
end
concommand.Add( "tabs_addtab",Add)

function Remove(ply, cmd, args)
	if(serverguard.player:HasPermission(ply, "Tabs_RemoveTab") == false)then return false end
	if(#args<2)then
		if(ply!=NULL)then
			ply:SendLua("MsgC( Color( 255, 0, 0 ), \"[TC 2.0] Error! Use '"..cmd.." [group] [tab]' to "..dis[cmd].."\\n\")")  
		else
			MsgC( Color( 255, 0, 0 ),"[TC 2.0] Error! Use '"..cmd.." [group] [tab]' to "..dis[cmd].."\n") 
		end
		return false 
	end
	RemoveFrom(args[1], args[2],ply)
end
concommand.Add( "tabs_removetab",Remove)

function AddTo(group, tab,p)
	p = p or NULL
	local succ,err = pcall( function() local v = c_list[group].tabs end )
	local s = false
	pcall( function() s = table.KeyFromValue(c_list[group].tabs,tab) or false end)
	
	if(s!=false)then
		if(p != NULL)then
			p:SendLua("MsgC( Color( 255, 0, 0 ), \"[TC 2.0] Tab '"..tab.."' in '"..group.."' exists\\n\")")
		else
			MsgC( Color( 255, 0, 0 ),"[TC 2.0] Tab '"..tab.."' in '"..group.."' exists\n")  
		end
	else
		if(succ == false)then
			c_list[group] = {}
			c_list[group].tabs = { tab }
			c_list[group].group = group
			Save()
			Update(group,tab,"a")
		else
			table.insert(c_list[group].tabs,tab)
			Save()
			Update(group,tab,"a")
		end
		
		if(p != NULL)then
			p:SendLua("MsgC( Color( 0, 255, 0 ), \"[TC 2.0] Added '"..tab.."' to '"..group.."'\\n\")")
			MsgC( Color( 0, 255, 0 ),"[TC 2.0] Added '"..tab.."' to '"..group.."' by "..p:SteamID().."\n")  
		else
			MsgC( Color( 0, 255, 0 ),"[TC 2.0] Added '"..tab.."' to '"..group.."' by console\n")  
		end
	end
end

function RemoveFrom(group, tab,p)
	p = p or NULL
	local s = false
	pcall( function() s = table.KeyFromValue(c_list[group].tabs,tab) or false end)
	
	if(s != false)then
		table.RemoveByValue( c_list[group].tabs, tab )
		Save()
		Update(group,tab,"r")
	
		if(p != NULL)then
			p:SendLua("MsgC( Color( 0, 255, 0 ), \"[TC 2.0] Removed '"..tab.."' from '"..group.."'\\n\")")
			MsgC( Color( 0, 255, 0 ),"[TC 2.0] Removed '"..tab.."' from '"..group.."' by "..p:SteamID().."\n")  
		else
			MsgC( Color( 0, 255, 0 ),"[TC 2.0] Removed '"..tab.."' from '"..group.."' by console\n")  
		end
	else
		if(p != NULL)then
			p:SendLua("MsgC( Color( 255, 0, 0 ), \"[TC 2.0] Tab '"..tab.."' in '"..group.."' or '"..group.."' doent exists\\n\")")
		else
			MsgC( Color( 255, 0, 0 ),"[TC 2.0] Tab '"..tab.."' in '"..group.."' or '"..group.."' doent exists\n")  
		end
	end
	
end

function Update(group, tab, t)
	for k,v in pairs(player.GetAll())do
		if(string.lower(serverguard.player:GetRank(v)) == string.lower(group))then
			net.Start("TC2.0_Update")
				net.WriteString(tab)
				net.WriteString(t)
			net.Send(v)
		end
	end
end

timer.Simple(0.5,function()
	Load()
	if(GetData( "tabs_default" )!="1")then
		SetData( "tabs_default","1" )
		/*AddTo("entities","admin")
		AddTo("weapons","admin")
		AddTo("npcs","admin")
		AddTo("vehicles","admin")
		AddTo("dupes","admin")
		AddTo("cmenu","admin")
	
		AddTo("entities","event_maker")
		AddTo("weapons","event_maker")
		AddTo("npcs","event_maker")
		AddTo("vehicles","event_maker")
		AddTo("dupes","event_maker")
		AddTo("cmenu","event_maker")
	
		AddTo("entities","superadmin")
		AddTo("weapons","superadmin")
		AddTo("npcs","superadmin")
		AddTo("vehicles","superadmin")
		AddTo("dupes","superadmin")
		AddTo("cmenu","superadmin")
	
		AddTo("entities","owner")
		AddTo("weapons","owner")
		AddTo("npcs","owner")
		AddTo("vehicles","owner")
		AddTo("dupes","owner")
		AddTo("cmenu","owner")
	
		AddTo("entities","administation")
		AddTo("weapons","administation")
		AddTo("npcs","administation")
		AddTo("vehicles","administation")
		AddTo("dupes","administation")
		AddTo("cmenu","administation")
	
		AddTo("entities","headadmin")
		AddTo("weapons","headadmin")
		AddTo("npcs","headadmin")
		AddTo("vehicles","headadmin")
		AddTo("dupes","headadmin")
		AddTo("cmenu","headadmin")*/
	end
end)

local function PlayerConnect( l,ply )
	local succ,err = pcall( function() local v = c_list[string.lower(serverguard.player:GetRank(ply))].tabs end )
	
	local z = {}
	if (succ == true) then
		z = c_list[string.lower(serverguard.player:GetRank(ply))].tabs
	end
	
	net.Start("TC2.0_Send")
		net.WriteTable( z )
	net.Send(ply)
end
net.Receive("TC2.0_Connect", PlayerConnect)