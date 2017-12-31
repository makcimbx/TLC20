

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "DC-15S"			
	SWEP.Author				= "Syntax_Error752"
	SWEP.ViewModelFOV      	= 50
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/killicons/DC15S")
	
	killicon.Add( "weapon_752_dc15s", "HUD/killicons/DC15S", Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType				= "ar2"
SWEP.Base					= "tfa_swsft_base"

SWEP.Category = "TFA Star Wars"

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true

SWEP.ViewModel				= "models/weapons/v_DC15S.mdl"
SWEP.WorldModel				= "models/weapons/w_DC15S.mdl"

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.Sound = Sound ("weapons/DC15S_fire.wav");
SWEP.Primary.ReloadSound = Sound ("weapons/DC15S_reload.wav");

SWEP.Primary.Recoil			= 0.1
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Spread			= .0030
SWEP.Primary.IronAccuracy = .0002
SWEP.Primary.ClipSize		= 50
SWEP.Primary.RPM = 550
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.TracerName = "effect_sw_laser_blue"

SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

--Misc
SWEP.IronRecoilMultiplier=0.0001 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.0001  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=0.9  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=0.5  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier=0.5  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier=0.0002 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier=0.7 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier=2.5--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier=1.5--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.3 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.9 --Multiply the player's movespeed by this when sighting.
SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.

SWEP.IronSightsPos = Vector(-4.06, -9.219, 1.395)
SWEP.IronSightsAng = Vector(-0.454, 0.7, 0.5)

SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["v_thompson"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/swbf3/rep/blaster.mdl", bone = "v_thompson.root5", rel = "", pos = Vector(1.904, 5.247, -0.265), angle = Angle(0.699, 2.354, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/swbf3/rep/blaster.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.491, 0.898, 0.773), angle = Angle(-11.723, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
