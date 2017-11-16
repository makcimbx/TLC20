-------------------
-- General Settings
-------------------
-- What should we multiply fall damage by while prone. Set to 1 to disable.
prone.config.FallDamageMultiplier = 1.75


-----------------------
-- Key-related settings
-----------------------
-- NOTICE:	Every setting in this section can later be changed
--			by the user with the "prone_config" command.

-- By default is the bind key enabled.
prone.config.DefaultBindKey_Enabled = true

-- What is the default bind key set by the server.
-- See http://wiki.garrysmod.com/page/Enums/KEY
prone.config.DefaultBindKey = KEY_G

-- By default should the player double tap the bind key to go prone.
prone.config.DefaultBindKey_DoubleTap = false

-- By default can the user press the jump key to get up.
prone.config.DefaultJumpToGetUp = true

-- By default must the user double press the jump key to get up.
prone.config.DefaultJumpToGetUp_DoubleTap = false


--------------
-- Move speeds
--------------
-- How fast they move while prone.
prone.config.MoveSpeed = 50

-- How fast they move while getting up or going down.
prone.config.TransitionSpeed = 0


----------------------------
-- Shooting related settings
----------------------------
-- There are no moving and shooting animations while prone so it would look like
-- players aren't shooting when they are. You probably don't want to change this to false.
prone.config.MoveShoot_Restrict = false

-- Weapons in this list can be shot while moving if the ab
prone.config.MoveShoot_Whitelist = {
	weapon_physgun			= true,
	weapon_physcannon		= true,		-- Gravity Gun
	gmod_tool				= true,		-- Toolgun
	gmod_camera				= true,
	weapon_medkit			= true,
	weaponchecker			= true,		-- (DarkRP)
	keys					= true,		-- (DarkRP)
	pocket					= true,		-- (DarkRP)
	weapon_keypadchecker	= true,		-- (DarkRP)
	unarrest_stick			= true,		-- (DarkRP)
	arrest_stick			= true,		-- (DarkRP)
	weapon_zm_carry			= true,		-- (TTT) Magneto Stick
	weapon_ttt_binoculars	= true,		-- (TTT)
	weapon_ttt_unarmed		= true		-- (TTT)
}

--wiltOS Addition: Disables attacking while proned. This is done specifically because of the problems with the reload animations. 
--You can enable this again but expect some silly looking things to happen
prone.config.DisableAttacking = false


--------------------------
-- DarkRP related settings
--------------------------
-- Should we restrict prone by job.
prone.config.Darkrp_RestrictJobs = false

-- Is the job list a whitelist? False for blacklist.
prone.config.Darkrp_IsWhitelist = false

-- If the above setting is true this is the job whitelist. Blacklist otherwise.
prone.config.Darkrp_Joblist = {
	TEAM_POLICE,
	TEAM_GANG
}

-- Any players of these ranks can go prone, no matter of their job.
prone.config.Darkrp_BypassRanks = {
	"superadmin",
	"admin",
	"owner"
}


--------------------
-- Advanced Settings
--------------------
-- Sets the hull height while prone. What you can fit under.
prone.config.HullHeight = 24

-- Sets how low the player's view will be while prone.
prone.config.View = Vector(0, 0, 24)

prone.animations.gettingdown = "pronedown_stand"
prone.animations.gettingup = "proneup_stand"
prone.animations.passive = "prone_walkpassive"

-- These two are not in use right now.
prone.animations.gettingdown_crouch = "pronedown_crouch"
prone.animations.gettingup_crouch = "proneup_crouch"

prone.animations.WeaponAnims = {
	moving = {
		ar2			= "pronewalkidle_mp40",
		camera		= "pronewalkidle_tnt",
		crossbow	= "pronewalkidle_mp44",
		duel		= "pronewalkidle_bolt",
		fist		= "pronewalkaim_gren_stick",
		grenade		= "pronewalkaim_gren_frag",
		knife		= "pronewalkaim_knife",
		magic		= "pronewalkaim_knife",
		melee		= "pronewalkaim_spade",
		melee2		= "pronewalkaim_spade",
		normal		= "pronewalkaim_gren_stick",
		passive		= "pronewalkaim_gren_stick",
		pistol		= "pronewalkidle_pistol",
		physgun		= "pronewalkidle_30cal",
		revolver	= "pronewalkidle_c96",
		rpg			= "pronewalkidle_bazooka",
		shotgun		= "pronewalkidle_mp40",
		slam		= "pronewalkidle_tnt",
		smg			= "pronewalkidle_mp40"
	},
	idle = {
		ar2			= "proneaim_mp40",
		camera		= "proneaim_tnt",
		crossbow	= "proneaim_mp44",
		duel		= "proneaim_bolt",
		fist		= "proneaim_gren_stick",
		grenade		= "proneaim_gren_frag",
		knife		= "proneaim_knife",
		magic		= "proneaim_knife",
		melee		= "proneaim_spade",
		melee2		= "proneaim_spade",
		normal		= "proneaim_gren_stick",
		passive		= "proneaim_gren_stick",
		pistol		= "proneaim_pistol",
		physgun		= "proneaim_30cal_deploy",
		revolver	= "proneaim_c96",
		rpg			= "proneaim_bazooka",
		shotgun		= "proneaim_mp40",
		slam		= "proneaim_tnt",
		smg			= "proneaim_mp40"
	}
}