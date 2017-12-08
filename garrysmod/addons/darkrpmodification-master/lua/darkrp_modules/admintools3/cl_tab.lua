local function PlayerInit()
	if(IsValid(LocalPlayer()))then
		net.Start("TC2.0_Connect")
		net.SendToServer()
		hook.Remove( "Think", "FUCLINGPLAYERINIT_1_Ever" )
	end
end
hook.Add( "Think", "FUCLINGPLAYERINIT_1_Ever", PlayerInit )

local c_list = {}
local sb = false
local sb_c = false

net.Receive("TC2.0_Send", function(l,ply)
	c_list = net.ReadTable()
	sb = false
end)

net.Receive("TC2.0_Update", function(l,ply)
	local tab = net.ReadString()
	local t = net.ReadString()
	
	if(t=="r")then
		table.RemoveByValue( c_list, tab )
	else
		table.insert( c_list, tab )
	end
	sb = false
end)

local tabs = {
	language.GetPhrase("spawnmenu.category.entities"),
	language.GetPhrase("spawnmenu.category.weapons"),
	language.GetPhrase("spawnmenu.category.npcs"),
	language.GetPhrase("spawnmenu.category.postprocess"),
	language.GetPhrase("spawnmenu.category.vehicles"),
	language.GetPhrase("spawnmenu.category.dupes"), 
	language.GetPhrase("spawnmenu.category.saves")
}

local function removeOldTabls2()
	if(string.lower(serverguard.player:GetRank(LocalPlayer()))=="user" and sb_c == false)then c_list = {} sb = false sb_c = true end
	if(sb==false)then
		g_SpawnMenu = vgui.Create( "SpawnMenu" )
		g_SpawnMenu:SetVisible( false )
		
		CreateContextMenu() 

		hook.Run( "PostReloadToolsMenu" )
		
		for x, z in pairs( tabs ) do
			for k,v in pairs(g_SpawnMenu.CreateMenu.Items)do
				if(v.Tab:GetText()==z)then
					local t = false
					for w,e in pairs(c_list)do
						if(language.GetPhrase("spawnmenu.category."..e)==v.Tab:GetText())then
							t = true
						end
					end
					if(t==false)then
						g_SpawnMenu.CreateMenu:CloseTab( v.Tab, true )
					end
				end
			end
		end 
		sb=true
		if(string.lower(serverguard.player:GetRank(LocalPlayer()))!="user")then sb_c = false end
	end
end
hook.Add("SpawnMenuOpen", "blockmenutabs", removeOldTabls2)

concommand.Add("ConnectOther",function()
	RunString( [[LocalPlayer():ConCommand("connect 94.23.180.165:27015")]] )
end)
