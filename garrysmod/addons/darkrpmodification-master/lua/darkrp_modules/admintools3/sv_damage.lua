
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

hook.Add("HealthChanged","HealthChanged_Ever_Damage",function(ply)
	local b = GetBerserk(ply)
	if(b == true)then
		
		local playerClass = baseclass.Get(player_manager.GetPlayerClass(ply))
		local walk = playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed
		local run = playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed
		local crouch = playerClass.CrouchedWalkSpeed
		
		local hpp = 1-ply:Health()/ply:GetMaxHealth()
		ply:SetWalkSpeed(walk + walk*(hpp))
		ply:SetRunSpeed(run + run*(hpp))
		ply:SetCrouchedWalkSpeed(crouch + crouch*(hpp))
	end
end)

hook.Add("Think","Think_Ever_Damage",function()
	for k,v in pairs(player.GetAll())do
		if(v.lasthp == nil)then
			v.lasthp = v:Health()
		else
			if(v.lasthp != v:Health())then
				v.lasthp = v:Health()
				hook.Call("HealthChanged",nil,v)
			end
		end
	end
end)


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
			
			local playerClass = baseclass.Get(player_manager.GetPlayerClass(target))
			local walk = playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed
			local run = playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed
			local crouch = playerClass.CrouchedWalkSpeed
			
			local hpp = 1-target:Health()/target:GetMaxHealth()
			target:SetWalkSpeed(walk + walk*(hpp))
			target:SetRunSpeed(run + run*(hpp))
			target:SetCrouchedWalkSpeed(crouch + crouch*(hpp))
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