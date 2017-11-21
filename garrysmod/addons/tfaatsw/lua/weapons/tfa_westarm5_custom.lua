SWEP.PrintName			= "WESTAR-M5"			
SWEP.Author				= "TFA, Servius (custom mode add KTKycT)"
SWEP.ViewModelFOV      	= 56
SWEP.Slot				= 2
SWEP.HoldType				= "ar2"
SWEP.Base					= "tfa_gun_base"
SWEP.Instructions				= "This gun is called 'WESTAR M5' not WEST-AR-M5. This is for the idiots that have been saying its the latter of the two." --Instructions Tooltip
SWEP.Category = "TFA Star Wars"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.ViewModel				= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel				= "models/weapons/w_irifle.mdl"
SWEP.Primary.Sound = Sound ("weapons/dc15a/DC15A_fire.ogg");
SWEP.Primary.ReloadSound = Sound ("weapons/shared/standard_reload.ogg");
SWEP.Primary.GLSound = Sound("TFA_INS2_GP30.1")
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Primary.Recoil			= 0.2
SWEP.Primary.Damage			= 60
SWEP.Primary.NumShots		= 1
SWEP.Primary.Spread			= 0.003
SWEP.Primary.IronAccuracy = .001
SWEP.Primary.ClipSize		= 70
SWEP.Primary.RPM = 90/0.175
SWEP.Primary.DefaultClip	= 500
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.MaxPenetrationCounter = 0
SWEP.Secondary.IronFOV = 70
SWEP.ShowWorldModel = false
SWEP.UseHands = true
SWEP.SelectiveFire = true
SWEP.FireModes = {
	"Auto",
	"3Burst",
	"Single"
}
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -9.122, 0) },
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.855, 4.977, -0.5), angle = Angle(0, 0, 0) },
	["v_weapon.famas"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(10.965, 0.958, 0) }
}
SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_alphablaster.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0, 0, 17.226), angle = Angle(-0.541, -2.112, -97.883), size = Vector(0.864, 0.864, 0.864), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }, 
	["gl"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_gp25.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.2, 5.0, -6), angle = Angle(100,-97, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false},
	["scope_mosin_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "v_weapon.bolt", rel = "", pos = Vector(-0.04, -1.77, -7.53), angle = Angle(-98, 90, 0), size = Vector(0.421, 0.421, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false, active = false }
	}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_alphablaster.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.083, 1.235, -3.258), angle = Angle(0, -90, 166.97), size = Vector(0.848, 0.848, 0.848), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.IronSightsSensitivity = 0.25 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5
----Swft Base Code
SWEP.TracerCount = 1
SWEP.MuzzleFlashEffect = ""
SWEP.TracerName = "effect_sw_laser_blue"
SWEP.Secondary.IronFOV = 70
SWEP.Primary.KickUp = 0.2
SWEP.Primary.KickDown = 0.3
SWEP.Primary.KickHorizontal = 0.3
SWEP.Primary.KickRight = 0.2
SWEP.Primary.ProjectileModel = "models/weapons/tfa_ins2/upgrades/a_projectile_gp25.mdl"
SWEP.DisableChambering = true
SWEP.ImpactDecal = "FadingScorch"
SWEP.ImpactEffect = "effect_sw_impact" --Impact Effect
SWEP.RunSightsPos = Vector(2.127, 0, 1.355)
SWEP.RunSightsAng = Vector(-15.775, 10.023, -5.664)
SWEP.BlowbackEnabled = true
SWEP.BlowbackVector = Vector(0,-3,0.1)
SWEP.Blowback_Shell_Enabled = false
SWEP.Blowback_Shell_Effect = ""
SWEP.ThirdPersonReloadDisable=false
SWEP.Primary.DamageType = DMG_SHOCK
SWEP.DamageType = DMG_SHOCK

SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay

SWEP.RTMaterialOverride = nil -- Take the material you want out of print(LocalPlayer():GetViewModel():GetMaterials()), subtract 1 from its index, and set it to this.
SWEP.RTOpaque = false -- Do you want your render target to be opaque?
SWEP.RTCode = nil--function(self) return end --This is the function to draw onto your rendertarget

SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 75 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-6.101, -9.814, -1.1)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_Westarm5 = Vector(-6.3, -2.814, 2.0)
SWEP.IronSightsAng_Westarm5 = Vector(0, 0, 0)

SWEP.Attachments = {
	[7] = { offset = { 0, 0 }, atts = { "tfa_westernm5_scope" }, order = 1 },
	[8] = { offset = { 0, 0 }, atts = { "grenadelauncher_m5" }, order = 3 }
	}

SWEP.AttachmentDependencies = {}--{["si_acog"] = {"bg_rail"}}
SWEP.AttachmentExclusions = {}--{ ["si_iron"] = {"bg_heatshield"} }

SWEP.RTAttachment_Westarm5 = 7
SWEP.ScopeOverlayTransforms_Westarm5 = {
	-0.002,-0.21
}
SWEP.ScopeAngleTransforms_Westarm5 = Angle(0.0,0.0,0.0)
SWEP.ScopeDistanceMin_Westarm5 = 9.5
SWEP.ScopeDistanceRange_Westarm5 = 8
DEFINE_BASECLASS( SWEP.Base )