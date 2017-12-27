

-- How many seconds does the player have to put that second tap in for double-tap rolling
wOS.RollMod.Sensitivity = 0.3

--Speed you go when you are rolling
wOS.RollMod.RollSpeed = 200

--These are the damage types you can dodge while rolling. 
--Set them to true so they are dodgeable, false for the opposite
wOS.RollMod.Dodgeables = {}
wOS.RollMod.Dodgeables[ DMG_GENERIC ] = false
wOS.RollMod.Dodgeables[ DMG_CRUSH ] = false
wOS.RollMod.Dodgeables[ DMG_BULLET ] = true
wOS.RollMod.Dodgeables[ DMG_SLASH ] = true
wOS.RollMod.Dodgeables[ DMG_BURN ] = false
wOS.RollMod.Dodgeables[ DMG_BLAST ] = false
wOS.RollMod.Dodgeables[ DMG_SHOCK ] = true
wOS.RollMod.Dodgeables[ DMG_SONIC ] = false
wOS.RollMod.Dodgeables[ DMG_ENERGYBEAM ] = false
wOS.RollMod.Dodgeables[ DMG_BUCKSHOT ] = true

wOS.RollMod.Animations = {}
wOS.RollMod.Animations[2] = "wos_genji_dance"
wOS.RollMod.Animations[3] = "cwalk_magic"
wOS.RollMod.Animations[4] = "wos_animation_test_kek"

wOS.RollMod.Animations[8] = "menu_gman"
wOS.RollMod.Animations[9] = "pose_ducking_01"
wOS.RollMod.Animations[10] = "pose_standing_01"
wOS.RollMod.Animations[11] = "pose_standing_02"
wOS.RollMod.Animations[12] = "pose_standing_03"
wOS.RollMod.Animations[13] = "pose_standing_04"
wOS.RollMod.Animations[14] = "seq_baton_swing"
wOS.RollMod.Animations[15] = "taunt_cheer"
wOS.RollMod.Animations[16] = "taunt_reverse"
wOS.RollMod.Animations[17] = "wos_bs_shared_kick"

wOS.RollMod.Animations[18] = "wos_signal_advance"
wOS.RollMod.Animations[19] = "wos_signal_forward"
wOS.RollMod.Animations[20] = "wos_signal_group"
wOS.RollMod.Animations[21] = "wos_signal_halt"
wOS.RollMod.Animations[22] = "wos_signal_left"
wOS.RollMod.Animations[23] = "wos_signal_right"
wOS.RollMod.Animations[24] = "wos_signal_takecover"
wOS.RollMod.Animations[25] = "death_dance_loop"

wOS.RollMod.Animations[27] = "kungfu_standing_kick01"
wOS.RollMod.Animations[28] = "aoc_peasant_idle5"
wOS.RollMod.Animations[29] = "tlc_animation_russiandance"
wOS.RollMod.Animations[30] = "tlc_animation_chest"
wOS.RollMod.Animations[31] = "tlc_animation_otjim"
wOS.RollMod.Animations[32] = "tlc_animation_prised"
wOS.RollMod.Animations[33] = "tlc_animation_sdatsya"
wOS.RollMod.Animations[34] = "tlc_animation_stoika"


