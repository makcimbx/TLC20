
local function GetBerserk(ply)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			if(v.Berserk!=nil)then
				return true
			end
		end
	end
	return false
end

local function GetResist(ply)
	local dmg = 1
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			dmg = dmg + (v.TakeDamageP or 0)
			dmg = dmg - (v.TakeDamagePP or 0)
		end
	end
	return dmg
end

local function GetCrit(ply)
	local crit = 1.5
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			crit = crit + (v.CritP or 0)
		end
	end
	return crit
end

local function GetDamage(ply)
	local damage = 1
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			damage = damage + (v.DamageP or 0)
		end
	end
	return damage
end

function GM:EntityTakeDamage( target, dmginfo )
	local attacker = dmginfo:GetAttacker()
	local dmg = dmginfo:GetDamage()
	local dmgtype = dmginfo:GetDamageType()
	
	if( IsValid(attacker) and attacker:IsPlayer())then
		dmg = dmg*GetDamage(attacker)
		
		local pr = math.random(0,100)
		local pr2 = math.random(15,30)
		if(pr<=pr2)then
			dmg = dmg + dmg*GetCrit(attacker)
		end
	end
	
	if(target:IsPlayer())then
		local b = GetBerserk(target)
		if(b == true)then
			local r = GetResist(target)
			dmg = dmg + dmg*r
			--[[
			    self:SetWalkSpeed(playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed)
				self:SetRunSpeed(playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed)

				hook.Call("UpdatePlayerSpeed", GAMEMODE, self) -- Backwards compatitibly, do not use

				self:SetCrouchedWalkSpeed(playerClass.CrouchedWalkSpeed)
				self:SetDuckSpeed(playerClass.DuckSpeed)
				self:SetUnDuckSpeed(playerClass.UnDuckSpeed)
				self:SetJumpPower(playerClass.JumpPower)
				self:AllowFlashlight(playerClass.CanUseFlashlight)
			]]--
			local playerClass = baseclass.Get(player_manager.GetPlayerClass(target))
			local walk = playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed
			local run = playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed
			local crouch = playerClass.CrouchedWalkSpeed
			
			local hpp = math.Clamp( target:GetMaxHealth()/target:Health(), 0, 10 )
			target:SetRunSpeed(walk + walk*(hpp-1))
			target:SetWalkSpeed(run + run*(hpp-1))
			target:SetCrouchedWalkSpeed(crouch + crouch*(hpp-1))
			print(target)
		end
	end
	
	dmginfo:SetDamage( dmg )
	if( IsValid(attacker) and attacker:IsPlayer())then
		net.Start("SW.ShowHitMarker")
			net.WriteFloat(dmg)
			if(IsValid(dmginfo:GetInflictor()) && dmginfo:GetInflictor():GetClass() == "ent_lightsaber") then
				net.WriteVector(dmginfo:GetInflictor():GetPos())
			else
				net.WriteVector(dmginfo:GetDamagePosition() == Vector(0,0,0) and target:GetPos() or dmginfo:GetDamagePosition())
			end
		net.Send(attacker)
	end
end