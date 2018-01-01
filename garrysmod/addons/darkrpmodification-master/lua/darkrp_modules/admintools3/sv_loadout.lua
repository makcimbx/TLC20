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

local meta = FindMetaTable( "Player" );


function meta:checkTree(tree)
	local curTree = self.maintree
	
	if(curTree == nil)then
		self:SetPData("curTree",tree)
		self:SetNWString("curTree",tree)
		self.maintree = tree
		return true
	else
		if(tree == curTree)then
			return true
		else
			return curTree
		end
	end
end

function meta:addResetPoints(points)
	self:SetPData("resetPoints",self.resetPoints+points)
	self.resetPoints = self.resetPoints+points
	self:SetNWString("resetPoints",self.resetPoints.."")
end

function meta:checkResetPoints()
	local points = self.resetPoints
	
	if(points-1>=0)then
		self:SetPData("resetPoints",points-1)
		self.resetPoints = points-1
		self:SetPData("curTree",nil) 
		self.maintree = nil
		self:SetNWString("resetPoints",self.resetPoints.."")
		self:SetNWString("curTree",self.maintree)
		return true
	else
		return false
	end
end

function meta:GetMaxArmor()
	return self.MaxArmor or 0;
end

function meta:SetMaxArmor(a)
	self.MaxArmor = a
	self:SetNWInt( "MaxArmor",a )
end

local function wos_everarmorfunc(ply)
	local wos_armor = 0
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			wos_armor = wos_armor + (v.Armor or 0)
		end
	end
	return wos_armor
end

function BOX_PlayerLoadout(ply)
	local am = wos_everarmorfunc(ply)
	if(ply.newSpawn == true)then
		ply.newSpawn = false
		local jobTable = ply:getJobTable()
	
		for k,v in pairs(jobTable.weapons or {}) do
			ply:Give(v,true)
		end
		ply:SetArmor((ply:getJobTable().maxAM or 0) + am)
	else
		if (((ply:getJobTable().maxAM or 0) + (am or 0))==ply:Armor())then
			DarkRP.notify(ply, 1, 4, "Ты не можешь взять больше!")
		else
			ply:SetArmor((ply:getJobTable().maxAM or 0) + am)
		end
	end
end

--[[

	Health
	MaxHealth
	Armor
	RunSpeed
	RunSpeedX
	
]]--

local function wos_everspawnfunc(ply)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			ply:SetMaxHealth(ply:GetMaxHealth() + (v.MaxHealth or 0))
			ply:SetHealth(ply:Health() + (v.Health or 0))
			ply:SetRunSpeed( ply:GetRunSpeed() + (v.RunSpeed or 0) )
			ply:SetRunSpeed( ply:GetRunSpeed() * (v.RunSpeedX or 0) )
		else
			if(type(v)=="function")then
				v(ply)
			end
		end
	end
	ply.AppliedSkills = true
end

local function wos_evermhpfunc(ply)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			ply:SetMaxHealth(ply:GetMaxHealth() + (v.MaxHealth or 0))
		end
	end
end

local function wos_everhpfunc(ply)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			ply:SetHealth(ply:Health() + (v.Health or 0))
		end
	end
end

local function PostSetCurrentSkillHooks( ply )
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	local d = ply:GetMaxHealth()==ply:Health()
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a + wos_everarmorfunc(ply))
	wos_evermhpfunc(ply)
	if(d)then
		ply:SetHealth(h)
		wos_everhpfunc(ply)
	end
end
hook.Add( "PostSetCurrentSkillHooks", "EverPostSetCurrentSkillHooks",PostSetCurrentSkillHooks  )

local function spawn( ply )
	ply:StripAmmo()
	ply.newSpawn = true
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a + wos_everarmorfunc(ply))
	ply:SetHealth(h)
	wos_everspawnfunc(ply)
end
hook.Add( "PlayerSpawn", "EverII_PlayerSpawn", spawn )

local function change(ply, oldTeam, newTeam)
	ply:StripAmmo()
	ply.newSpawn = true
	local d = ply:GetMaxHealth()==ply:Health()
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a + wos_everarmorfunc(ply))
	wos_evermhpfunc(ply)
	if(d)then
		ply:SetHealth(h)
		wos_everhpfunc(ply)
	end
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
	ply:SetMaxArmor(100)
	ply.maintree = ply:GetPData("curTree",nil) 
	ply.resetPoints = tonumber(ply:GetPData("resetPoints","1"))
	ply:SetNWString("resetPoints",ply.resetPoints.."")
	ply:SetNWString("curTree",ply.maintree)
end
hook.Add( "PlayerInitialSpawn", "EverSuper_DalarinPidorPlayerInitialSpawn", spawn3 )

local function spawn2( ply )
	if(ply.video_newSpawn != true)then
		RunConsoleCommand("sv_tfa_bullet_ricochet", "0")
		ply.respawned = false
		ply.video_newSpawn = true
	end
end
hook.Add( "TC2.0_Connect", "ever23aasdasdas22323", spawn2 )