

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )

end

if ( CLIENT ) then

	SWEP.PrintName			= "DC-15AMS"		
	SWEP.Author				= "TFA"
	SWEP.ViewModelFOV      	= 50
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/killicons/DC15A")
	
	killicon.Add( "weapon_752_dc15a", "HUD/killicons/DC15A", Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType				= "ar2"
SWEP.Base					= "tfa_swsft_base"

SWEP.Category = "TFA Bling Wars"

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.HoldType = "ar2"
SWEP.ViewModelFOV = 56
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.UseHands = true

SWEP.ViewModelBoneMods = {
	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.338, 2.914, 0.18), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 1.447, 0) }
}

SWEP.Primary.Sound = Sound ("weapons/DC15A_fire.wav");
SWEP.Primary.ReloadSound = Sound ("weapons/DC15A_reload.wav");

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 60
SWEP.Primary.NumShots		= 2
SWEP.Primary.Spread			= 0.0045
SWEP.Primary.ClipSize		= 50
SWEP.Primary.RPM = 350
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.TracerName = "effect_sw_laser_blue"

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.Secondary.IronFOV = 70

SWEP.IronSightsPos = Vector(-7.401, -18.14, 2.099)
SWEP.IronSightsAng = Vector(-1.89, 0.282, 0)

--Misc
SWEP.IronRecoilMultiplier=0.0001 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.1  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=0.9  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=0.5  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier=0.5  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier=0 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier=0.7 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier=1.1--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier=0.7--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.03 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.0025 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.0005 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.5 --Multiply the player's movespeed by this when sighting.
SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_dc15a_neue2_shadow.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(-0.011, -2.924, -5.414), angle = Angle(180, 0, -89.595), size = Vector(0.95, 0.95, 0.95), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name2"] = { type = "Model", model = "models/weapons/w_dc15a_neue2_shadow.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.279, 0.584, -4.468), angle = Angle(0, -90, 160.731), size = Vector(0.884, 0.884, 0.884), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}


SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false

SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5