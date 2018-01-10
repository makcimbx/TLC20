

if(SERVER) then
	util.AddNetworkString( "DarkRP_Kun_GetDeathTime" )
	util.AddNetworkString( "DarkRP_Kun_CS_SetDeathTime" )
	util.AddNetworkString( "DarkRP_Kun_ForceSpawn" )
end

Kun_ForceHealth = 150 --Set the revived persons health to 25 upon revival.
Kun_ForceLive = 1 --Set to 0 to disable the force-spawn button.
Kun_ForceLiveTime = 5 --After ten seconds the button will be able to spawn you.

Kun_DefibChargeAmtNeed = 2 --Amt of charges needed to revive someone.
Kun_DefibChargeTime = 2 --Time between charges.
Kun_SaveCharges = 1 --Set to 0 to make it so they don't have to recharge if they switch weapons.

Kun_RespawnTime = 60 --Time between player respawn.
Kun_DeathTime = 60 --Time spent between life and death.

Kun_DrawHealth = 1 --Set to 0 to disable the white cross shown on death
Kun_DeathText = "Респавн через. . " --Text to display on death.
Kun_GiveReviveMoney = 20 --Give $20 for reviving someone.
Kun_allowedJobs = {
	["74ct"] = true,
	["74trp"] = true,
	["74cpl"] = true,
	["74sgt"] = true,
	["74lt"] = true,
	["74cpt"] = true,
	["74mjr"] = true,
	["74col"] = true,
	["74co"] = true,
	["74cc"] = true,
	["74mc"] = true,
}

Kun_DefJobName = "Citizen" --Medic Team name
Kun_AddExtraTime = 1 --If there are medics, make people stay dead for longer?
Kun_ExtraDeathTime = 10 --Add another 60 seconds to the timer.\
Kun_NoRagdollCollision = 1 --Set to 0 to make bodies collide with stuff.

Kun_SpawnWepsOnDeath = 1 --This will force the player to drop any weapons within the following table upon death.
Kun_DeathItemTbl = {
	"",
}

KunDeadPeople = {} --Dont touch

AddCSLuaFile( "cl_defib.lua" )
resource.AddFile( "models/kundefib/v_defibrillator.mdl" )

function Kun_DoDeath(ply)
	local ragdoll = ents.Create("prop_ragdoll")
	ragdoll:SetPos(ply:GetPos())
	ragdoll:SetModel(ply:GetModel())
	ragdoll:Spawn()
	ragdoll:SetNWString("RagNameZ",ply:Nick())
	ragdoll:SetNWString("RagDeathTimeZ",CurTime())
	if(Kun_NoRagdollCollision == 1) then
		ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON )
	end
	ply:SetNWInt("KunDeathTime",CurTime())
	ply.PriorDeathJob = ply:Team()
	ply.KunitsRagdoll = ragdoll
	ragdoll.PlyGuy = ply
	ragdoll:GetPhysicsObject():SetVelocity(ply:GetPhysicsObject():GetVelocity())
	timer.Simple(0.01, function()
		if(ply:GetRagdollEntity() != nil and	ply:GetRagdollEntity():IsValid()) then
			ply:GetRagdollEntity():Remove()
		end
	end )
	ragdoll:GetPhysicsObject():SetVelocity(ply:GetVelocity())
end
hook.Add( "DoPlayerDeath", "Kun_DoDeath", Kun_DoDeath )

function Kun_Death(ply)
	forceaddexdt = Kun_DeathTime
	kunaddedextime = 0
	if(Kun_AddExtraTime == 1) then
		for k,v in pairs(player.GetAll()) do
			if(team.GetName(v:Team()) == Kun_DefJobName) then
				if(kunaddedextime == 0) then
					kunaddedextime = 1
					forceaddexdt = (forceaddexdt + Kun_ExtraDeathTime)
				end
			end
		end
	end
	
	ply:SetNWInt("ForceAddExDeath",forceaddexdt)

	ply.KunWepTbl = {}
	ply.KunDead = CurTime() + forceaddexdt
	ply.KunDied = CurTime()
	for k,v in pairs(ply:GetWeapons()) do
		ply.KunWepTbl[table.Count(ply.KunWepTbl) + 1] = v:GetClass()
	end
	timer.Simple(forceaddexdt, function() if(ply:IsValid()) then ply.KunDead = 0 end end )
end
hook.Add( "PlayerDeath", "Kun_Death", Kun_Death )

function Kun_DeathThink(ply)
	if(ply.KunDead != nil and CurTime() > ply.KunDead) then
		ply:Spawn()
		return true
	end
	if(ply.KunDead == nil) then ply:Spawn() end
	return false
end
hook.Add( "PlayerDeathThink", "Kun_DeathThink", Kun_DeathThink )

function Kun_MakeWep(wtype,pos)
	local ent = ents.Create(wtype)
	ent:SetPos(pos)
	ent:Spawn()
end

function Kun_DoSpawn(ply)
	if(ply.KunitsRagdoll != nil and ply.KunitsRagdoll:IsValid()) then
		if(Kun_SpawnWepsOnDeath == 1) then
			for k,v in pairs(Kun_DeathItemTbl) do
				for a,b in pairs(ply.KunWepTbl) do
					if(v == b) then
						local pos = ply.KunitsRagdoll:GetPos()
						pos:Add(Vector(0,0,20))
						Kun_MakeWep(b,pos)
					end
				end
			end
		end
		ply:SetNWInt("KunDeathTime",0)
		ply.KunitsRagdoll:Remove()
		for k,v in pairs(KunDeadPeople) do
			if(v.Name == ply:Nick()) then
				KunDeadPeople[k] = nil
			end
		end
	end
end
hook.Add( "PlayerSpawn", "Kun_DoSpawn", Kun_DoSpawn )

function Kun_DoDizco(ply)
	if(ply.KunitsRagdoll != nil and ply.KunitsRagdoll:IsValid()) then
		ply.KunitsRagdoll:Remove()
	end
end
hook.Add( "PlayerDisconnected", "Kun_DoDizco", Kun_DoDizco )

function KunDefib_Charge(ply)
	if(ply.DefibChargeTime != nil and (CurTime() - ply.DefibChargeTime) <= Kun_DefibChargeTime) then return end
	ply.DefibChargeTime = CurTime()
	ply:SetNWInt("DefibCharge",ply:GetNWInt("DefibCharge") + 1)
	ply:EmitSound("weapons/physcannon/superphys_small_zap"..math.random(1,4)..".wav")
	if(ply:GetNWInt("DefibCharge")  >= Kun_DefibChargeAmtNeed) then
		ply:SetNWInt("DefibCharge",Kun_DefibChargeAmtNeed)
		ply:EmitSound("buttons/button1.wav")
	end
end

function Defib_Shoot(ply,ent)
	if(ply.FireTime == nil) then ply.FireTime = 0 end
	if((CurTime() - ply.FireTime) >= 5) then
		ply.FireTime = CurTime()
		if(ply:GetNWInt("DefibCharge") >= Kun_DefibChargeAmtNeed) then
			if(ent != nil and ent:IsValid() and ent:GetClass() == "prop_ragdoll") then
				ply:EmitSound(("ambient/energy/zap1.wav"))
				ply:SetNWInt("DefibCharge",0) 
				local targ = ent.PlyGuy
				if(ent.PlyGuy != nil and ent.PlyGuy:IsValid() and targ.SleepRagdoll == nil) then
					targ:Spawn()
					targ:SetHealth(Kun_ForceHealth)
					targ:SetPos(ent:GetPos())
					if(targ.PriorDeathJob == targ:Team()) then
						for k,v in pairs(targ.KunWepTbl) do
							targ:Give(v)
						end
					end
					ply:addMoney(Kun_GiveReviveMoney)
				end
				ent:Remove()
			end
		else
			ply:EmitSound("buttons/combine_button_locked.wav")
		end
	end
end

net.Receive( "DarkRP_Kun_ForceSpawn", function( length, ply )
	ply:Spawn()
end )