if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile( "cl_init.lua" )
end

if(CLIENT) then
	SWEP.Author = "Kunit"
	SWEP.Instructions = "Left click to revive, right click to charge the defibrillator."
	SWEP.Contact = ""
	SWEP.Purpose = ""
	SWEP.DrawAmmo = false
end

SWEP.ViewModel = Model("models/weapons/v_hands.mdl")
SWEP.WorldModel = Model("models/Items/HealthKit.mdl")

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Sound = nil
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawWorldModel(false)
		if(Kun_SaveCharges == 0) then
			self.Owner:SetNWInt("DefibCharge",0) 
		end
	end
end

function SWEP:PrimaryAttack()
	if SERVER then
		local ply = self.Owner
		local ent = ply:GetEyeTrace().Entity
		Defib_Shoot(ply,ent)
	end
end

function SWEP:SecondaryAttack()
	KunDefib_Charge(self.Owner)
end

