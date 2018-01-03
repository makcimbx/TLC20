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
	
	if(curTree == "*" or curTree == "" or curTree == "-")then
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

function meta:GetMaxArmor(a)
	return self.MaxArmor
end

function BOX_PlayerLoadout(ply)
	local am = 0
	if(ply.newSpawn == true)then
		ply.newSpawn = false
		local jobTable = ply:getJobTable()
	
		for k,v in pairs(jobTable.weapons or {}) do
			ply:Give(v,true)
		end
		ply:SetArmor(ply:GetMaxArmor())--(ply:getJobTable().maxAM or 0) + am)
	else
		if (ply:GetMaxArmor()==ply:Armor())then
			DarkRP.notify(ply, 1, 4, "Ты не можешь взять больше!")
		else
			ply:SetArmor(ply:GetMaxArmor())
		end
	end
end

local function PostSetCurrentSkillHooks( ply )
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	local d = ply:GetMaxHealth()==ply:Health()
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a + 0)
	ply:SetHealth(h)
	CheckSpawnSkills(ply)
end
hook.Add( "PostSetCurrentSkillHooks", "EverPostSetCurrentSkillHooks",PostSetCurrentSkillHooks  )

local function spawn( ply )
	ply:StripAmmo()
	ply.newSpawn = true
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a + 0)
	ply:SetHealth(h)
	CheckSpawnSkills(ply)
end
hook.Add( "PlayerSpawn", "EverII_PlayerSpawn", spawn )

local function change(ply, oldTeam, newTeam)
	ply:StripAmmo()
	ply.newSpawn = true
	local d = ply:GetMaxHealth()==ply:Health()
	local h = ply:getJobTable().maxHP or 100
	local a = ply:getJobTable().maxAM or 0
	ply:SetMaxHealth(h)
	ply:SetMaxArmor(a)
	ply:SetHealth(h)
	CheckSpawnSkills(ply)
end
hook.Add( "OnPlayerChangedTeam", "EverII_OnPlayerChangedTeam", change )

local function PlayerDeath( ply, i, a )
	ply:StripAmmo()
	ply.newSpawn = true
end
hook.Add( "PlayerDeath", "EverII_PlayerDeath", PlayerDeath )

function meta:applyPlayerClassVars(applyHealth)
    local playerClass = baseclass.Get(player_manager.GetPlayerClass(self))

	self.swsd = playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed
    self.srsd = playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed
	self.scwsd = playerClass.CrouchedWalkSpeed
    self.sdsd = playerClass.DuckSpeed
    self.sudsd = playerClass.UnDuckSpeed
    self.sjpd = playerClass.JumpPower
	
    self:SetWalkSpeed(self.swsd)
    self:SetRunSpeed(self.srsd)

    hook.Call("UpdatePlayerSpeed", GAMEMODE, self) -- Backwards compatitibly, do not use
	
    self:SetCrouchedWalkSpeed(self.scwsd)
    self:SetDuckSpeed(self.sdsd)
    self:SetUnDuckSpeed(self.sudsd)
    self:SetJumpPower(self.sjpd)
    self:AllowFlashlight(playerClass.CanUseFlashlight)
	
	self:Ssws(0)
	self:Ssrs(0)
	self:Sscws(0)
	self:Ssds(0)
	self:Ssuds(0)
	self:Ssjp(0)
	self.swso = self.swsd--walk = 160
	self.srso = self.srsd--run = 240
	self.scwso = self.scwsd--0.3
	self.sdso = self.sdsd--0.3
	self.sudso = self.sudsd--0.3
	self.sjpo = self.sjpd--jump power = 200
	
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

function CheckSpawnSkills(ply)
	ply:Ssws(0)
	ply:Ssrs(0)
	ply:Sscws(0)
	ply:Ssds(0)
	ply:Ssuds(0)
	ply:Ssjp(0)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		v(ply)
	end
end

local function spawn3( ply )
	ply:SetPos( Vector(-8153.135742, 6200.348145, -14824.129883) )
	ply:SetEyeAngles( Angle(59.736351, 148.419388, 0.000000) )
	ply.maintree = ply:GetPData("curTree","*") 
	ply.resetPoints = tonumber(ply:GetPData("resetPoints","1"))
	ply:SetNWString("resetPoints",ply.resetPoints.."")
	ply:SetNWString("curTree",ply.maintree)
	ply:SetMaxArmor(100)
	CheckSpawnSkills(ply)
	
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

function meta:Gsws(a)
	return self.sws
end

function meta:Gsrs(a)
	return self.srs
end

function meta:Gscws(a)
	return self.scws
end

function meta:Gsds(a)
	return self.sds
end

function meta:Gsuds(a)
	return self.suds
end

function meta:Gsjp(a)
	return self.sjp
end

function meta:Ssws(a)
	self.sws = a
end

function meta:Ssrs(a)
	self.srs = a
end

function meta:Sscws(a)
	self.scws = a
end

function meta:Ssds(a)
	self.sds = a
end

function meta:Ssuds(a)
	self.suds = a
end

function meta:Ssjp(a)
	self.sjp = a
end

function meta:getswsd()
	return self.swsd
end

function meta:getsrsd()
	return self.srsd
end

function meta:getscwsd()
	return self.scwsd
end

function meta:getsdsd()
	return self.sdsd
end

function meta:getsudsd()
	return self.sudsd
end

function meta:getsjpd()
	return self.sjpd
end

timer.Create("Think_Ever_Speed",0.5,0,function()
	for k,v in pairs(player.GetAll())do
		if(v.sws!=v.swso or v.srs!=v.srso or v.scws!=v.scwso or v.sds!=v.sdso or v.suds!=v.sudso or v.sjp!=v.sjpo or v.af!=v.afo)then
			v:UpdateSpeeds()
		end
	end
end)

function meta:UpdateSpeeds()
	local playerClass = baseclass.Get(player_manager.GetPlayerClass(self))

    self:SetWalkSpeed(self.swsd + self.sws + (self.swsb or 0))
    self:SetRunSpeed(self.srsd + self.srs + (self.srsb or 0))
    self:SetCrouchedWalkSpeed(self.scwsd + self.scws + (self.scwsb or 0))
    self:SetDuckSpeed(self.sdsd + self.sds + (self.sdsb or 0))
    self:SetUnDuckSpeed(self.sudsd + self.suds + (self.sudsb or 0))
    self:SetJumpPower(self.sjpd + self.sjp + (self.sjpb or 0))
	
	self.swso = self.sws
	self.srso = self.srs
	self.scwso = self.scws
	self.sdso = self.sds
	self.sudso = self.suds
	self.sjpo = self.sjp
end