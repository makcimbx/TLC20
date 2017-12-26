function GM:PlayerLoadout(ply)
    self.Sandbox.PlayerLoadout(self, ply)


    ply.RPLicenseSpawn = true
    timer.Simple(1, function()
        if not IsValid(ply) then return end
        ply.RPLicenseSpawn = false
    end)

    for k, v in pairs(self.Config.DefaultWeapons) do
        ply:Give(v)
    end

    CAMI.PlayerHasAccess(ply, "DarkRP_GetAdminWeapons", function(access)
        if not access or not IsValid(ply) then return end

        for k,v in pairs(GAMEMODE.Config.AdminWeapons) do
            ply:Give(v)
        end

        if not GAMEMODE.Config.AdminsCopWeapons then return end

        ply:Give("stunstick")
        ply:Give("weaponchecker")
    end)

	for k,v in pairs(getWeaponsFromCuLoad(ply)) do 
		if(v!="-1")then
			ply:Give(v)
		end
	end
	
    ply:SwitchToDefaultWeapon()
end

function BOX_PlayerLoadout(ply)
	if(ply.newSpawn == true)then
		ply.newSpawn = false
		local jobTable = ply:getJobTable()
	
		for k,v in pairs(jobTable.weapons or {}) do
			ply:Give(v,true)
		end
	else
		if((ply:getJobTable().maxAM or 0)==ply:Armor())then
			DarkRP.notify(ply, 1, 4, "Ты не можешь взять больше!")
		else
			ply:SetArmor(ply:getJobTable().maxAM or 0)
		end
	end
end

local function spawn( ply )
	ply:StripAmmo()
	ply.newSpawn = true
	local h = ply:getJobTable().maxHP or 100
	ply:SetMaxHealth(h)
	ply:SetHealth(h)
end
hook.Add( "PlayerSpawn", "EverII_PlayerSpawn", spawn )

local function change(ply, oldTeam, newTeam)
	ply:StripAmmo()
	ply.newSpawn = true
	local h = ply:getJobTable().maxHP or 100
	ply:SetMaxHealth(h)
end
hook.Add( "OnPlayerChangedTeam", "EverII_OnPlayerChangedTeam", change )

local function PlayerDeath( ply, i, a )
	ply:StripAmmo()
	ply.newSpawn = true
end
hook.Add( "PlayerDeath", "EverII_PlayerDeath", PlayerDeath )

local meta = FindMetaTable("Player")
function meta:applyPlayerClassVars(applyHealth)
    local playerClass = baseclass.Get(player_manager.GetPlayerClass(self))

    self:SetWalkSpeed(playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed)
    self:SetRunSpeed(playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed)

    hook.Call("UpdatePlayerSpeed", GAMEMODE, self) -- Backwards compatitibly, do not use

    self:SetCrouchedWalkSpeed(playerClass.CrouchedWalkSpeed)
    self:SetDuckSpeed(playerClass.DuckSpeed)
    self:SetUnDuckSpeed(playerClass.UnDuckSpeed)
    self:SetJumpPower(playerClass.JumpPower)
    self:AllowFlashlight(playerClass.CanUseFlashlight)

    --self:SetMaxHealth(playerClass.MaxHealth >= 0 and playerClass.MaxHealth or (tonumber(GAMEMODE.Config.startinghealth) or 100))
    --if applyHealth then
       --self:SetHealth(playerClass.StartHealth >= 0 and playerClass.StartHealth or (tonumber(GAMEMODE.Config.startinghealth) or 100))
    --end
    self:SetArmor(playerClass.StartArmor)

    self.dropWeaponOnDeath = playerClass.DropWeaponOnDie
    self:SetNoCollideWithTeammates(playerClass.TeammateNoCollide)
    self:SetAvoidPlayers(playerClass.AvoidPlayers)

    hook.Call("playerClassVarsApplied", nil, self)
end


local function spawn3( ply )
	ply:SetPos( Vector(-8153.135742, 6200.348145, -14824.129883) )
	ply:SetEyeAngles( Angle(59.736351, 148.419388, 0.000000) )
end
hook.Add( "PlayerInitialSpawn", "PlayerInitialSpawn", spawn2 )

local function spawn2( ply )
	if(ply.video_newSpawn != true)then
		RunConsoleCommand("sv_tfa_bullet_ricochet", "0")
		ply.respawned = false
		ply.video_newSpawn = true
	end
end
hook.Add( "TC2.0_Connect", "ever23aasdasdas22323", spawn2 )