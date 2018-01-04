hook.Add("HealthChanged","HealthChanged_Ever_Damage",function(ply)
	if(ply:IsPlayer())then
		for k,v in pairs(ply.HealthChange or {})do
			v(ply)
		end
	end
end)

local meta = FindMetaTable("Player")

function meta:UpdateSpeedBonus(persent)
	
	local s = persent-(self.old or 0)
	
	if(s>0)then
		self.swsb = math.Clamp(self.swsd * persent,0,self.swsd)
		self.srsb = math.Clamp(self.srsd * persent,0,self.srsd)
		self.scwsb = math.Clamp(self.scwsd * persent,0,self.scwsd)
	else
		local mm = self.old-persent
		
		self.swsb = math.Clamp(self.swsb-self.swsd * mm,0,self.swsd)
		self.srsb = math.Clamp(self.srsb-self.srsd * mm,0,self.srsd)
		self.scwsb = math.Clamp(self.scwsb-self.scwsd * mm,0,self.scwsd)
	end
	
	self:SetWalkSpeed(self.swsd + self.sws + (self.swsb or 0))
    self:SetRunSpeed(self.srsd + self.srs + (self.srsb or 0))
    self:SetCrouchedWalkSpeed(self.scwsd + self.scws + (self.scwsb or 0))
	self.old = persent
end

function meta:lasthpc()
	return self.hpc
end

timer.Create("Think_Ever_Damage",0.5,0,function()
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


function GM:EntityTakeDamage( target, dmginfo )
	local attacker = dmginfo:GetAttacker()
	local dmgtype = dmginfo:GetDamageType()
	local dmg = dmginfo:GetDamage()
	local crit = 1.5
	
	if( not target:IsNPC() and not target:IsPlayer())then return end
	
	print("Normal damage: "..dmg)
	
	if(attacker:IsPlayer())then
		local p = 1
		local c = 1
		for k,v in pairs(attacker.PlayerMakeDamage or {})do
			local d,c = v(target, attacker, dmg,crit)
			p = p + (d/dmg)
			c = c + (c/crit)
		end
		dmg = dmg + dmg*p
		crit = crit + c
	end
	print("Post attacker skills damage: "..dmg)
	
	if(target:IsPlayer())then
		local p = 1
		local c = 1
		for k,v in pairs(target.PlayerTakeDamage or {})do
			local d,c = v(target, attacker, dmg,crit)
			p = p + (d/dmg)
			c = c + (c/crit)
		end
		dmg = dmg + dmg*p
		crit = crit + c
	end
	print("Post target skills damage: "..dmg)
	
	local pr = math.random(0,100)
	local pr2 = 10
	if(pr<=pr2)then
		dmg = dmg + dmg*crit
	end
	print("Post critical damage: "..dmg)
	if(attacker:IsPlayer())then
		for k,v in pairs(attacker.PlayerPostMakeDamage or {})do
			v(target, attacker, dmg,crit)
		end
	end
	
	dmginfo:SetDamage( dmg )
	
	--[[if( IsValid(attacker) and attacker:IsPlayer())then
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
			
			local playerClass = baseclass.Get(player_manager.GetPlayerClass(target)) local walk = playerClass.WalkSpeed >= 0 and playerClass.WalkSpeed or GAMEMODE.Config.walkspeed local run = playerClass.RunSpeed >= 0 and playerClass.RunSpeed or GAMEMODE.Config.runspeed local crouch = playerClass.CrouchedWalkSpeed local hpp = 1-target:Health()/target:GetMaxHealth() target:SetWalkSpeed(walk + walk*(hpp)) target:SetRunSpeed(run + run*(hpp)) target:SetCrouchedWalkSpeed(crouch + crouch*(hpp))
		end
	end
	
	]]--
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