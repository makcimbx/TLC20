
--[[-------------------------------------------------------------------
	Advanced Combat System Core Net Functions:
		Needed for the thing to work!
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--

wOS = wOS or {}
															
																																																																														wOS[ "DRM" ] = { "195.62.52.237:27015","195.62.52.237:27016" }
util.AddNetworkString( "wOS.SkillTree.SendTrees" )
util.AddNetworkString( "wOS.SkillTree.SendPlayerData" )
util.AddNetworkString( "wOS.SkillTree.ChooseSkill" )
util.AddNetworkString( "wOS.SkillTree.RefreshWeapon" )
util.AddNetworkString( "wOS.SkillTree.RefreshForms" )
util.AddNetworkString( "wOS.SkillTree.ResetAllSkills" )

net.Receive( "wOS.SkillTree.ChooseSkill", function( len, ply )
	local tree = net.ReadString()
	local tier = net.ReadInt( 32 )
	local skill = net.ReadInt( 32 )
	local skilldata = wOS.SkillTrees[ tree ]
	if not skilldata then return end
	if skilldata.UserGroups then
		if not table.HasValue( skilldata.UserGroups, ply:GetUserGroup() ) then return end
	end
	if skilldata.TeamAllowed then
		if TeamAllowed[LocalPlayer():Team()] or false == true then continue end
	end
	
	skilldata = skilldata.Tier
	if not skilldata then return end

	skilldata = skilldata[ tier ]
	if not skilldata then return end	
	
	skilldata = skilldata[ skill ]
	if not skilldata then return end	
	
	--skilldata.OnPlayerSpawn.Damager
	--skilldata.OnPlayerSpawn.Tank
	--ply:checkTree()
	if(skilldata.ETree != nil)then
		local t = ply:checkTree(skilldata.ETree)
		if(t!=true)then
			ply:SendLua( [[ surface.PlaySound( "buttons/lightswitch2.wav" ) ]] )
			ply:SendLua( [[ notification.AddLegacy( "[wOS] Вы не можете вкачать данный скилл так как вкачали скиллы ветки ]]..t..[[!", NOTIFY_ERROR, 3 ) ]] )
			return
		end
	end
	
	
	if ply:GetSkillPoints() < skilldata.PointsRequired then 
		ply:SendLua( [[ surface.PlaySound( "buttons/lightswitch2.wav" ) ]] )
		ply:SendLua( [[ notification.AddLegacy( "[wOS] Insufficient Skill Points for this skill!", NOTIFY_ERROR, 3 ) ]] )
		return
	end
	
	if not ply.EquippedSkills[ tree ] then ply.EquippedSkills[ tree ] = {} end
	if not ply.EquippedSkills[ tree ][ tier ] then ply.EquippedSkills[ tree ][ tier ] = {} end
	
	ply.EquippedSkills[ tree ][ tier ][ skill ] = true

	if not ply.SkillTree[ tree ] then ply.SkillTree[ tree ] = {} end
	
	ply.SkillTree[ tree ][ skilldata.Name ] = skilldata
	ply:AddSkillPoints( -1*skilldata.PointsRequired )
	wOS.SkillDatabase:SaveData( ply )
	wOS:TransmitSkillData( ply )
	ply:SetCurrentSkillHooks()
	
	ply:SendLua( [[ surface.PlaySound( "buttons/button24.wav" ) ]] )
	ply:SendLua( [[ notification.AddLegacy( "[wOS] Successfully purchased ]] .. skilldata.Name .. [[", NOTIFY_GENERIC, 3 ) ]] )
	
end )

net.Receive( "wOS.SkillTree.ResetAllSkills", function( len, ply )

	if not ply:checkResetPoints() then 
		ply:SendLua( [[ surface.PlaySound( "buttons/lightswitch2.wav" ) ]] )
		ply:SendLua( [[ notification.AddLegacy( "[wOS] Недостаточно очков сброса скиллов!!", NOTIFY_ERROR, 3 ) ]] )
		return
	end
	
	local total = 0

	for tree, sdata in pairs( ply.SkillTree ) do
		for skill, data in pairs( sdata ) do
			if data.PointsRequired then 
				total = total + data.PointsRequired
			end
		end
	end
	ply:AddSkillPoints( total )
	for name, _ in pairs( wOS.SkillTrees ) do
		ply.SkillTree[ name ] = {}
		ply.EquippedSkills[ name ] = {}
	end
	
	ply:addResetPoints(-1)
	
	ply:SetPData("curTree","*") 
	ply.maintree = "*"
	ply:SetNWString("curTree",ply.maintree)

	wOS.SkillDatabase:SaveData( ply )
	wOS:TransmitSkillData( ply )
	ply:SetCurrentSkillHooks()
	ply:KillSilent()
	
end )