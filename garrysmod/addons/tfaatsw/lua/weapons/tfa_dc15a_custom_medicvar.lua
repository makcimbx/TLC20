if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end
if ( CLIENT ) then
	SWEP.PrintName			= "DC-15A Medical Style (custom)"
	SWEP.Author				= "TFA (custom mode add KTKycT)"
	SWEP.ViewModelFOV      	= 50
	SWEP.Slot				= 2
	SWEP.SlotPos			= 3
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/killicons/DC15A")
	killicon.Add( "weapon_752_dc15a", "HUD/killicons/DC15A", Color( 255, 80, 0, 255 ) )
end
SWEP.Base					= "tfa_swsft_base"
SWEP.Category = "TFA Star Wars"
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true
SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 56
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.UseHands = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.736, 5.183, 1.149), angle = Angle(-1.825, 2.803, -0.527) },
	["v_weapon.awm_parent"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.Primary.Sound = Sound ("weapons/dc15a/DC15A_fire.ogg");
SWEP.Primary.ReloadSound = Sound ("weapons/shared/standard_reload.ogg");
SWEP.Primary.GLSound = Sound("TFA_INS2_GP30.1")
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 50
SWEP.Primary.NumShots		= 1


-- Selective Fire Stuff
SWEP.SelectiveFire		= true --Allow selecting your firemode?
SWEP.DisableBurstFire	= false --Only auto/single?
SWEP.OnlyBurstFire		= false --No auto, only burst/single?
SWEP.DefaultFireMode 	= "" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
SWEP.Primary.Spread			= 0.0125
SWEP.Primary.IronAccuracy = .001	-- Ironsight accuracy, should be the same for shotguns
SWEP.Primary.SpreadMultiplierMax = 2 --How far the spread can expand when you shoot.
--Range Related
SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter=1 --The maximum number of ricochets.  To prevent stack overflows.
SWEP.Primary.ClipSize		= 50
SWEP.Primary.RPM = 325
SWEP.Primary.DefaultClip	= 150
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.TracerName = "effect_sw_laser_blue"
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.IronFOV = 70
SWEP.MaxPenetrationCounter = 0

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
SWEP.IronSightsPos = Vector(-7.48, -15.814, 1.54)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronSightsPos_Mosin = Vector(-7.48, -16.814, 0.9)
SWEP.IronSightsAng_Mosin = Vector(0, 0, 0)

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_dc15a_neue.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(0, -2.437, -4.307), angle = Angle(0, 180, 90), size = Vector(0.755, 0.755, 0.755), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(270, 180, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_eotech_lens"] = { type = "Sprite", vmt = true, sprite = "models/weapons/tfa_ins2/optics/eotech_reticule_holo", bone = "A_RenderReticle", rel = "sight_eotech", pos = Vector(0, 0, 0), size = { x = 0.4, y = 0.4 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_rds_lens"] = { type = "Sprite", vmt = true, sprite = "models/weapons/tfa_ins2/optics/aimpoint_reticule_holo", bone = "Lense", rel = "sight_rds", pos = Vector(0, 0, 0), size = { x = 0.212, y = 0.212 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["scope_2xrds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimp2x.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_2xrds_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "Lense_RT", rel = "scope_2xrds", pos = Vector(0, 0, -0.108), angle = Angle(-90, 0, -90), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false },
	["scope_c79"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_elcan.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_c79_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "Lense_RT", rel = "scope_c79", pos = Vector(0, -0.08, 0), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false },
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(0, -0.4, -2), angle = Angle(270, 180, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_kobra_lens"] = { type = "Sprite", sprite = "models/weapons/tfa_ins2/optics/kobra_dot", bone = "A_RenderReticle", rel = "sight_kobra", pos = Vector(0, 0, -0.002), size = { x = 0.638, y = 0.638 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, active = false},
	["scope_po4x"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_po4x24.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_po4x_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "Lense_RT", rel = "scope_po4x", pos = Vector(0, 0, -1.6), angle = Angle(-90, 0, -90), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, active = false },
	["scope_mx4"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_m40.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(-3.8, -2.9, 5), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_mx4_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "RT", rel = "scope_mx4", pos = Vector(0, -0.42, 0), angle = Angle(0, 90, 0), size = Vector(0.522, 0.522, 0.522), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["scope_mosin"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_mosin.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(0.06, -2.4, -13), angle = Angle(-90, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_mosin_lens"] = { type = "Model", model = "models/rtcircle.mdl", bone = "RT", rel = "scope_mosin", pos = Vector(0, -0.783, 0), angle = Angle(0, 90, 0), size = Vector(0.421, 0.421, 0.421), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {}, bonemerge = false, active = false},
	["gl"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_gp25.mdl", bone = "v_weapon.awm_bolt_action", rel = "", pos = Vector(0, 3, 0), angle = Angle(-90,90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false}
	}
	
SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/weapons/w_dc15a_neue.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.35, 0.547, -2.832), angle = Angle(-1.767, -85.473, 166.1), size = Vector(0.675, 0.675, 0.675), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_eotech.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.292, 0, -8.219), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false},
	["scope_po4x"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_po.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-51.667, 0, -3.948), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["scope_c79"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-43.563, 0, -3.852), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["scope_mosin"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_scope_mosin.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.954, 0, -12), angle = Angle(-13, 3, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_kobra.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-28.809, 0, -11.872), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["scope_mx4"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_scope_m40.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2, 1.9, -9), angle = Angle(-13, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["scope_2xrds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-41.842, 0, -4.965), angle = Angle(0, 0, 0), size = Vector(0.759, 0.759, 0.759), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false },
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-41.842, 0, -4.965), angle = Angle(0, 0, 0), size = Vector(0.759, 0.759, 0.759), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false }
	}
SWEP.BlowbackVector = Vector(0,-3,0.025)
SWEP.Blowback_Only_Iron  = false
SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 2.5

SWEP.Attachments = {
	[7] = { offset = { 0, 0 }, atts = { "ins2_si_mosin" }, order = 1 },
	[8] = { offset = { 0, 0 }, atts = { "force_shoot_low", "force_shoot_high"}, order = 2 },
	[9] = { offset = { 0, 0 }, atts = { "grenadelauncher_dc15a" }, order = 3 }
	}

SWEP.AttachmentDependencies = {}--{["si_acog"] = {"bg_rail"}}
SWEP.AttachmentExclusions = {}--{ ["si_iron"] = {"bg_heatshield"} }


SWEP.RTAttachment_Mosin = 7
SWEP.ScopeOverlayTransforms_Mosin = {
	-0.002,-0.21
}
SWEP.ScopeAngleTransforms_Mosin = Angle(0.0,0.0,0.0)
SWEP.ScopeDistanceMin_Mosin = 9.5
SWEP.ScopeDistanceRange_Mosin = 8


--[[3dScopedBase stuff
SWEP.RTMaterialOverride = 0
SWEP.RTScopeAttachment = -1
SWEP.Scoped_3D = true
SWEP.ScopeReticule = "scope/gdcw_vibrantred_nobar" 
SWEP.Secondary.ScopeZoom = 8
SWEP.ScopeReticule_Scale = {2.5,2.5}
SWEP.Secondary.UseACOG			= false	 --Overlay option
SWEP.Secondary.UseMilDot			= false			 --Overlay option
SWEP.Secondary.UseSVD			= false		 --Overlay option
SWEP.Secondary.UseParabolic		= false		 --Overlay option
SWEP.Secondary.UseElcan			= false	 --Overlay option
SWEP.Secondary.UseGreenDuplex		= false		 --Overlay option
if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	--
--end--]]

DEFINE_BASECLASS( SWEP.Base )