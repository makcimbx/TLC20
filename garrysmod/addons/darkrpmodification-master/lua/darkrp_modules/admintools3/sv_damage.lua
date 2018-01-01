
local function GetBerserk(ply)
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			if(Berserk!=nil)then
				return true
			end
		end
	end
	return false
end

local function GetResist(ply)
	local dmg = 1.5
	for _, v in pairs( ply.PlayerSkillSpawns or {} ) do
		if(type(v)=="table")then
			dmg = dmg + (v.TakeDamageP or 0)
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
			local oldrun = target:GetRunSpeed() - (target.oldrun or 0)
			local oldwalk = target:GetWalkSpeed() - (target.oldwalk or 0)
			local oldcrouch = target:GetCrouchedWalkSpeed() - (target.oldcrouch or 0)
			
			local hpp = math.Clamp( target:GetMaxHealth()/target:Health(), 0, 10 )
			target:GetRunSpeed(oldrun + oldrun*(hpp-1))
			target:GetWalkSpeed(oldwalk + oldwalk*(hpp-1))
			target:GetCrouchedWalkSpeed(oldcrouch + oldcrouch*(hpp-1))
			target.oldrun = oldrun*(hpp-1)
			target.oldwalk = oldwalk*(hpp-1)
			target.oldcrouch = oldcrouch*(hpp-1)
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