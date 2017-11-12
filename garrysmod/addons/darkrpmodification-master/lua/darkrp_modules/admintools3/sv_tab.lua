util.AddNetworkString("sendgrp")
util.AddNetworkString("initit-fck")

local function OnChangeTeam(id, allows, denies, new_group, old_group)
	local c = 0
	local pl = nil
	for k,v in pairs(player.GetAll())do
		if(v:SteamID()==id)then
			pl = v
			for x,z in pairs (c_list)do
				if(z.group==new_group)then
					c = x
					break
				end
			end
			break
		end
	end
	if(c!=0)then
		local z = c_list[c]
		net.Start("sendgrp")
			net.WriteString(#z.tabs)
			for q,b in pairs(z.tabs)do
				net.WriteString(b)
			end
		net.Send(pl)
	else
		net.Start("sendgrp")
			net.WriteString(0)
		net.Send(pl)
	end
end
hook.Add( "ULibUserGroupChange", "OnChangeTeam_Ever", OnChangeTeam )

c_list = {}

net.Receive("initit-fck", function(l,ply)
	local c = 0
	for x,z in pairs (c_list)do
		if(z.group==ply:GetUserGroup())then
			c = x
			break
		end
	end
	if(c!=0)then
		local z = c_list[c]
		net.Start("sendgrp")
			net.WriteString(#z.tabs)
			for q,b in pairs(z.tabs)do
				net.WriteString(b)
			end
		net.Send(ply)
	else
		net.Start("sendgrp")
			net.WriteString(0)
		net.Send(ply)
	end
end)

concommand.Add( "tabs_addto", function( ply, cmd, args )
	if(ply:IsSuperAdmin())then
		if(#args<2)then ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] --ERROR!-- tabs_addto [tab] [group] - example" ) return false end
		AddGroupTo(args[1],args[2],ply)
	end
end)

concommand.Add( "tabs_removefrom", function( ply, cmd, args )
	if(ply:IsSuperAdmin())then
		if(#args<2)then ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] --ERROR!-- tabs_removefrom [tab] [group] - example" ) return false end
		RemoveGroupFrom(args[1],args[2],ply)
	end
end)

concommand.Add( "tabs_getall", function( ply, cmd, args )
	if(ply:IsSuperAdmin())then
		local strng = "[TABS CONTROL] -- Start List --\n"
		ply:PrintMessage( HUD_PRINTCONSOLE, strng ) 
		for k,v in pairs(c_list)do
			strng=""
			strng = strng.."    "..v.group.." ["
			for x,z in pairs(v.tabs)do
				strng = strng.." "..z
			end
			strng = strng.."]\n"
			ply:PrintMessage( HUD_PRINTCONSOLE, strng ) 
		end
		strng=""
		strng = strng.."[TABS CONTROL] -- End List --\n"
		ply:PrintMessage( HUD_PRINTCONSOLE, strng ) 
	end
end)


concommand.Add( "tabs_help", function( ply, cmd, args )
	if(ply:IsSuperAdmin())then
		local strng = "[TABS CONTROL] -- Start Help List --\n"
	
		strng = strng.."    tabs_getall - list of all whitelisted groups and tabs\n"
		strng = strng.."    tabs_addto [tab] [group] - add [group] in whitelist to [tab]\n"
		strng = strng.."    tabs_removefrom [tab] [group] - remove [group] frome whitelist of [tab]\n"
		if(IsValid(ply))then
			ply:PrintMessage( HUD_PRINTCONSOLE, strng ) 
		end
		strng = ""
		strng = strng.."    All tabs\n"
		strng = strng.."        entities\n"
		strng = strng.."        weapons\n"
		strng = strng.."        npcs\n"
		strng = strng.."        postprocess\n"
		strng = strng.."        vehicles\n"
		strng = strng.."        dupes\n"
		strng = strng.."        saves\n"
		
		strng = strng.."[TABS CONTROL] -- End List --\n"
		if(IsValid(ply))then
			ply:PrintMessage( HUD_PRINTCONSOLE, strng ) 
		else
			print(strng)
		end
	end
end)

function AddGroupTo(tab, group,ply)
		local c = 0
		for k,v in pairs(c_list)do
			if(v.group == group)then
				c = k
			end
		end
		
		if(c!=0)then
			local v = c_list[c]
			local have = false
			for x,z in pairs(v.tabs)do
				if(z==tab)then
					have = true
					break
				end
			end
			if(not have)then
				table.insert(v.tabs,tab)
			else
				if(IsValid(ply))then
					ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] --Error!-- Group "..group.." whitelisted to "..tab.."." )
				else
					print("[TABS CONTROL] --Error!-- Group "..group.." whitelisted to "..tab..".")
				end
			end
		else
			local dt = {}
			dt.group = group
			dt.tabs = {}
			table.insert(dt.tabs,tab)
			table.insert(c_list,dt)
		end
		if(IsValid(ply))then
			print("[TABS CONTROL] "..ply:SteamID().." add "..group.." in whitelist of "..tab..".")
			ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] Group "..group.." added in whitelist of "..tab.."." )
		else
			print("[TABS CONTROL] 'Console' add "..group.." in whitelist of "..tab..".")
		end
		
	SaveList(group)
end

function RemoveGroupFrom(tab, group, ply)
	local c = 0
	for k,v in pairs(c_list)do
		if(v.group == group)then
			for x,z in pairs(v.tabs)do
				print(z.." == "..tab)
				if(z==tab)then
					table.remove( v.tabs, x ) 
					c = x
					break
				end
			end
			break
		end
	end
		
	if(c==0)then
		if(IsValid(ply))then
			ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] --Error!-- Group "..group.." not whitelisted. " )
		else
			print("[TABS CONTROL] --Error!-- Group "..group.." not whitelisted. ")
		end
	else
		if(IsValid(ply))then
			print("[TABS CONTROL] "..ply:SteamID().." remove "..group.." from "..tab..".")
			ply:PrintMessage( HUD_PRINTCONSOLE, "[TABS CONTROL] Group "..group.." remove from "..tab.."." )
		else
			print("[TABS CONTROL] 'Console' remove "..group.." from "..tab..".")
		end
		SaveList(group)
	end
	
	
end

function LoadList()
	local c = GetData( "#c_Ever_list", 0 )
	for k=1,c do
		local data = {}
		data.group = GetData( "c_Ever_list_group"..k )
		data.tabs = {}
		
		local c2 = GetData( "#c_Ever_list_t"..k )
		for x=1,c2 do
			table.insert(data.tabs, GetData( "c_Ever_list_tab"..k.."*"..x,z ))
		end
		table.insert(c_list, data)
	end
end

function SaveList(group)
	SetData( "#c_Ever_list", #c_list )
	for k,v in pairs(c_list) do
		SetData( "c_Ever_list_group"..k,v.group )
		SetData( "#c_Ever_list_t"..k,#v.tabs )
		for x,z in pairs(v.tabs)do
			SetData( "c_Ever_list_tab"..k.."*"..x,z )
		end
	end
	SendG(group)
end

function SendG(group)
	for k,v in pairs(player.GetAll())do
		if(v:GetUserGroup()==group)then
			for x,z in pairs (c_list)do
				if(z.group==group)then
					net.Start("sendgrp")
						net.WriteString(#z.tabs)
						for q,b in pairs(z.tabs)do
							net.WriteString(b)
						end
					net.Send(v)
				end
			end
		end
	end
end
timer.Simple(0.5,function()
	LoadList()
	if(GetData( "tabs_default" )!="1")then
		SetData( "#EVER@@2","1" )
		AddGroupTo("entities","admin",nil)
		AddGroupTo("weapons","admin",nil)
		AddGroupTo("npcs","admin",nil)
		AddGroupTo("vehicles","admin",nil)
		AddGroupTo("dupes","admin",nil)
		AddGroupTo("cmenu","admin",nil)
	
		AddGroupTo("entities","event_maker",nil)
		AddGroupTo("weapons","event_maker",nil)
		AddGroupTo("npcs","event_maker",nil)
		AddGroupTo("vehicles","event_maker",nil)
		AddGroupTo("dupes","event_maker",nil)
		AddGroupTo("cmenu","event_maker",nil)
	
		AddGroupTo("entities","superadmin",nil)
		AddGroupTo("weapons","superadmin",nil)
		AddGroupTo("npcs","superadmin",nil)
		AddGroupTo("vehicles","superadmin",nil)
		AddGroupTo("dupes","superadmin",nil)
		AddGroupTo("cmenu","superadmin",nil)
	
		AddGroupTo("entities","owner",nil)
		AddGroupTo("weapons","owner",nil)
		AddGroupTo("npcs","owner",nil)
		AddGroupTo("vehicles","owner",nil)
		AddGroupTo("dupes","owner",nil)
		AddGroupTo("cmenu","owner",nil)
	
		AddGroupTo("entities","administation",nil)
		AddGroupTo("weapons","administation",nil)
		AddGroupTo("npcs","administation",nil)
		AddGroupTo("vehicles","administation",nil)
		AddGroupTo("dupes","administation",nil)
		AddGroupTo("cmenu","administation",nil)
	
		AddGroupTo("entities","headadmin",nil)
		AddGroupTo("weapons","headadmin",nil)
		AddGroupTo("npcs","headadmin",nil)
		AddGroupTo("vehicles","headadmin",nil)
		AddGroupTo("dupes","headadmin",nil)
		AddGroupTo("cmenu","headadmin",nil)
	end
end)