AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/rena_haloodst/large_fuel_tank.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)

	if ( SERVER ) then self:PhysicsInit( SOLID_VPHYSICS ) end

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
	--CreateConVar( "simpleammodispenser_givesecondaryammo", "0", 128, "Give Secondary Ammo (SMG grenades/Combine balls" )
end

--function ENT:SpawnFunction( ply, tr, ClassName )

--	if ( !tr.Hit ) then return end

--	local SpawnPos = ply:GetShootPos() + ply:GetForward()*8

--	local ent = ents.Create( ClassName )
--	ent:SetPos(SpawnPos)
--	ent:Spawn()
--	ent:Activate()
--	return ent
--end

function ENT:Use(activator, caller)
    activator:PrintMessage( HUD_PRINTCENTER, "Fuel System: Ждите..." )
    timer.Create( "FuelGiveTimer", 20, 1, 
	function()
	activator:PrintMessage( HUD_PRINTCENTER, "Fuel System: Топливо загружено." )
	activator:SetAmmo(3500, "AirboatGun")
	timer.Stop( "FuelGiveTimer" )
	end)
    --amount11 = activator:getDarkRPVar("TakeFuelInBox")
    --if (amount11 == 1) then
		--DarkRP.notify(activator, 4, 4, "Вы не можете больше взять оружия из ящика!")
	--return end
	--local cfgOne = GetConVar("simpleammodispenser_givesecondaryammo"):GetInt()
	--local primaryAmmoType=activator:GetActiveWeapon():GetPrimaryAmmoType()
	--local secondaryAmmoType=activator:GetActiveWeapon():GetSecondaryAmmoType()
	--activator:setSelfDarkRPVar("TakeFuelInBox", 1)--
	--if cfgOne == 1 then
	--	activator:GiveAmmo(1, secondaryAmmoType)
	--end	
end

function ENT:Think()
end