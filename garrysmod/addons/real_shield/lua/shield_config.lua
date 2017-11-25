btShield = btShield or {}

-- Lambda Wars Riot Shield
-- http://steamcommunity.com/sharedfiles/filedetails/?l=czech&id=543527096
-- models/pg_props/pg_weapons/pg_cp_shield_w.mdl

-- GLASS RIOT SHIELD MODEL
-- http://steamcommunity.com/sharedfiles/filedetails/?id=149837821
-- models/arleitiss/riotshield/shield.mdl

-- KOREAN POLICE SHIELD MODEL
-- http://steamcommunity.com/sharedfiles/filedetails/?id=223731572
-- models/thswjdals95/policeshield/shield.mdl


-- COMBINE SHIELD MODEL
-- http://steamcommunity.com/sharedfiles/filedetails/?id=117454900
-- models/cloud/ballisticshield_mod.mdl

-- Nogitsu's Police Shield
-- http://steamcommunity.com/sharedfiles/filedetails/?id=667029302
-- models/riotshield/riotshield.mdl

-- Custom HQ Model Support
-- http://steamcommunity.com/sharedfiles/filedetails/?id=897313173
-- models/custom/ballisticshield.mdl

-- PAYDAY2 FBI Shield
-- http://steamcommunity.com/sharedfiles/filedetails/?id=800483635
-- models/payday2/shield_fbi.mdl

if (SERVER) then
	resource.AddWorkshop(117454900)
	--resource.AddWorkshop(223731572)
	--resource.AddWorkshop(149837821)
	--resource.AddWorkshop(543527096)
	--resource.AddWorkshop(667029302) -- SMALL RIOT SHIELD
	--resource.AddWorkshop(897313173) -- HQ MODEL
	--resource.AddWorkshop(800483635) -- FBI SHIELD
end

btShield.blockSound = {
	"physics/metal/metal_solid_impact_bullet1.wav",
	"physics/metal/metal_solid_impact_bullet2.wav",
	"physics/metal/metal_solid_impact_bullet3.wav",
	"physics/metal/metal_solid_impact_bullet4.wav",
}

/*
	I SUGGEST YOU TO ADD PISTOL/MELEE HOLDTYPE IN THIS LIST
*/
btShield.shieldList = {
	weapon_riotshield = "genericShield",
	weapon_smallcombineshield = "smallCombineShield",
	weapon_koreanshield = "koreanShield",
	weapon_combineshield = "combineShield",
	weapon_fbishield = "fbiShield",
	weapon_hqshield = "hqBalistic",
	weapon_smallriotshield = "smallRiot",
}

btShield.dualWield = {
	"weapon_pistol",
	"weapon_crowbar",
	"weapon_stunstick",
	"weapon_frag",

	"weapon_ttt_glock",
	"weapon_zm_revolver",
	"weapon_ttt_crowbar",
	"weapon_zm_improvised",
	"weapon_ttt_sipistol",
	"weapon_zm_pistol",
}

// You can change health or something in "game"
// If you touch other things, I can't sure what's going to happen to your server.
// I suggest you not to touch things below except health, regenHealth, regenDelay, brokenRegenDelay.

/*
	health = Health of Shield
	regenHealth = Regeneration Health Amount
	regenDelay = Delay between Regen and Latest Damage on the shield.
	brokenRegenDelay = Amount of time required to recover the shield.
*/
btShield.shieldInfo = {
	fbiShield = {
		model = "models/payday2/shield_fbi.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(2, 13, -8),
			ang = Angle(80, 10, 70),
			fpos = Vector(-21, 11, 0),
			fang = Angle(0, 0, 0),
		} ,
		block = {
			pos = Vector(5, 15, -10),
			ang = Angle(-10, -10, -20),
			sizex = 35,
			sizey = 65,
		},
		game = {
			health = 500,
			regenHealth = 9,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},

	hqBalistic = {
		model = "models/custom/ballisticshield.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(2, 13, -8),
			ang = Angle(80, 10, 70),
			fpos = Vector(-23, 14, 0),
			fang = Angle(0, 0, 0),
		} ,
		block = {
			pos = Vector(3, 13, -10),
			ang = Angle(-10, -10, -20),
			sizex = 40,
			sizey = 70,
		},
		game = {
			health = 9999999,
			regenHealth = 9,
			regenDelay = 1,
			brokenRegenDelay = 1,
		},
	},

	smallRiot = {
		model = "models/riotshield/riotshield.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(-0, 20, -0),
			ang = Angle(80, 1, 80),
			fpos = Vector(-13, 10, 7),
			fang = Angle(0, 0, 0),
		} ,
		block = {
			pos = Vector(6, 15, 0),
			ang = Angle(0, -10, -10),
			sizex = 20,
			sizey = 40,
		},
		game = {
			health = 99999,
			regenHealth = 9,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},

	smallCombineShield = {
		model = "models/pg_props/pg_weapons/pg_cp_shield_w.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(-11, 20, -46),
			ang = Angle(80, 1, 80),
			fpos = Vector(-62, 8, 5),
			fang = Angle(0, 0, 0),
		} ,
		block = {
			pos = Vector(6, 10, -2),
			ang = Angle(0, -10, -10),
			sizex = 20,
			sizey = 50,
		},
		game = {
			health = 300,
			regenHealth = 9,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},

	combineShield = {
		model = "models/cloud/ballisticshield_mod.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(3, 12, -35),
			ang = Angle(100, 1, -100),
			fpos = Vector(-53, 16, -4),
			fang = Angle(0, 180, 0),
		} ,
		block = {
			pos = Vector(6, 10, -5),
			ang = Angle(0, -10, -10),
			sizex = 35,
			sizey = 65,
		},
		game = {
			health = 9999999,
			regenHealth = 7,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},

	koreanShield = {
		model = "models/thswjdals95/policeshield/shield.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(3, 12, -28),
			ang = Angle(90, 10, 160),
			fpos = Vector(-43.2, 11, -0.5),
			fang = Angle(0, 90, 0),
		} ,
		block = {
			pos = Vector(8, 8, -2),
			ang = Angle(0, -10, -20),
			sizex = 25,
			sizey = 50,
		},
		game = {
			health = 250,
			regenHealth = 19,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},

	genericShield = {
		model = "models/arleitiss/riotshield/shield.mdl",
		bone = "ValveBiped.Bip01_L_Forearm",
		render = {
			pos = Vector(3, 12, -35),
			ang = Angle(80, 1, 80),
			fpos = Vector(-52, 16, -2),
			fang = Angle(0, 0, 0),
		} ,
		block = {
			pos = Vector(8, 6, -5),
			ang = Angle(0, -10, -10),
			sizex = 35,
			sizey = 70,
		},
		game = {
			health = 3000,
			regenHealth = 7,
			regenDelay = 4,
			brokenRegenDelay = 8,
		},
	},
}



hook.Add("PostGamemodeLoaded", "darkRP_GOGOGO!", function()
	if (DarkRP) then
		DarkRP.createShipment("riotShield", {
			model = "models/arleitiss/riotshield/shield.mdl",
			entity = "weapon_riotshield",
			price = 500,
			amount = 10,
			separate = false,
			pricesep = 200,
			noship = false,
			allowed = {TEAM_GUN}
		})
	end
end)