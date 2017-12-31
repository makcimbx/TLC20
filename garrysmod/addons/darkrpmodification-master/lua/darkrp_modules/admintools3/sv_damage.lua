
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
	
	if( not IsValid(attacker) or not attacker:IsPlayer())then return end
	
	dmg = dmg*GetDamage(attacker)
	
	local pr = math.random(0,100)
	local pr2 = math.random(15,30)
	if(pr<=pr2)then
		dmg = dmg + dmg*GetCrit(attacker)
	end
	dmginfo:SetDamage( dmg )
	net.Start("SW.ShowHitMarker")
		net.WriteFloat(dmg)
		if(IsValid(dmginfo:GetInflictor()) && dmginfo:GetInflictor():GetClass() == "ent_lightsaber") then
			net.WriteVector(dmginfo:GetInflictor():GetPos())
		else
			net.WriteVector(dmginfo:GetDamagePosition() == Vector(0,0,0) and target:GetPos() or dmginfo:GetDamagePosition())
		end
	net.Send(attacker)
end