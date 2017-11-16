
--[[-------------------------------------------------------------------
	Advanced Combat System Core Net Functions:
		Needed for the thing to work!
			Powered by
						  _ _ _    ___  ____  
				__      _(_) | |_ / _ \/ ___| 
				\ \ /\ / / | | __| | | \___ \ 
				 \ V  V /| | | |_| |_| |___) |
				  \_/\_/ |_|_|\__|\___/|____/ 
											  
 _____         _                 _             _           
|_   _|__  ___| |__  _ __   ___ | | ___   __ _(_) ___  ___ 
  | |/ _ \/ __| '_ \| '_ \ / _ \| |/ _ \ / _` | |/ _ \/ __|
  | |  __/ (__| | | | | | | (_) | | (_) | (_| | |  __/\__ \
  |_|\___|\___|_| |_|_| |_|\___/|_|\___/ \__, |_|\___||___/
                                         |___/             
----------------------------- Copyright 2017, David "King David" Wiltos ]]--[[
							  
	Lua Developer: King David
	Contact: http://steamcommunity.com/groups/wiltostech
		
-- Copyright 2017, David "King David" Wiltos ]]--

wOS = wOS or {}
wOS.Form = wOS.Form or {}
wOS.Form.Singles = wOS.Form.Singles or {}
wOS.Form.Duals = wOS.Form.Duals or {}

util.AddNetworkString( "wOS.SendForm" )

function wOS.SendFormData( ply )

	net.Start( "wOS.SendForm" )
		net.WriteTable( wOS.Form )
	net.Send( ply )

end

hook.Add( "PlayerInitialSpawn", "wOS.FormLocalization", function( ply ) wOS.SendFormData( ply ) end )

wOS.Form.Singles[ "Versatile" ] = {}
wOS.Form.Singles[ "Versatile" ][1] = {
	[ "run" ] = "vanguard_f_run",
	[ "idle" ] = "vanguard_f_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_r_left_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_r_right_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_r_s1_t2",
		Time = 0.6,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "judge_r_s1_t1",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

wOS.Form.Singles[ "Versatile" ][2] = {
	[ "run" ] = "vanguard_b_run",
	[ "idle" ] = "vanguard_b_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_b_left_t1",
		Time = 0.4,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_b_right_t1",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_b_s2_t2",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "judge_r_s1_t1",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

wOS.Form.Singles[ "Versatile" ][3] = {
	[ "run" ] = "vanguard_h_run",
	[ "idle" ] = "vanguard_h_idle",
	[ "light_left" ] = {
		Sequence = "vanguard_h_left_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_h_right_t2",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "vanguard_h_s1_t1",
		Time = 0.85,
		Rate = 1.5,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 2,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s1_t1",
		Time = 0.6,
		Rate = 1,
	},
	[ "heavy" ] = {
		Sequence = "judge_r_s1_t1",
		Time = nil,
		Rate = 0.8,
	},
	[ "heavy_charge" ] = "judge_r_s3_charge",
}

wOS.Form.Singles[ "Aggressive" ] = {}
wOS.Form.Singles[ "Aggressive" ][1] = {
	[ "run" ] = "phalanx_r_run",
	[ "idle" ] = "phalanx_r_idle",
	[ "light_left" ] = {
		Sequence = "phalanx_r_left_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_r_right_t3",
		Time = 0.7,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "phalanx_r_s1_t2",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "phalanx_b_s1_t1",
		Time = 2.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "phalanx_b_s4_charge",
}

wOS.Form.Singles[ "Aggressive" ][2] = {
	[ "run" ] = "phalanx_b_run",
	[ "idle" ] = "phalanx_b_idle",
	[ "light_left" ] = {
		Sequence = "phalanx_b_left_t3",
		Time = 1.0,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_b_right_t2",
		Time = 0.7,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "phalanx_b_s2_t3",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "phalanx_b_s1_t1",
		Time = 2.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "phalanx_b_s4_charge",
}

wOS.Form.Singles[ "Aggressive" ][3] = {
	[ "run" ] = "phalanx_h_run",
	[ "idle" ] = "phalanx_h_idle",
	[ "light_left" ] = {
		Sequence = "phalanx_b_s2_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "phalanx_h_right_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "phalanx_h_s1_t1",
		Time = 1.2,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "phalanx_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "phalanx_a_right_t1",
		Time = 0.6,
		Rate = 1.7,
	},
	[ "air_forward" ] = {
		Sequence = "phalanx_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "phalanx_b_s1_t1",
		Time = 2.0,
		Rate = 0.5,
	},
	[ "heavy_charge" ] = "phalanx_b_s4_charge",
}

wOS.Form.Singles[ "Defensive" ] = {}
wOS.Form.Singles[ "Defensive" ][1] = {
	[ "run" ] = "judge_r_run",
	[ "idle" ] = "judge_r_idle",
	[ "light_left" ] = {
		Sequence = "judge_r_left_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_r_right_t3",
		Time = 0.5,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_r_s1_t2",
		Time = 0.6,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "judge_a_right_t1",
		Time = 0.6,
		Rate = 2.0,
	},
	[ "air_forward" ] = {
		Sequence = "judge_a_s1_t2",
		Time = 0.4,
		Rate = 2.0,
	},
	[ "heavy" ] = {
		Sequence = "flourish_bow_basic",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "h_c1_charge",
}

wOS.Form.Singles[ "Defensive" ][2] = {
	[ "run" ] = "judge_b_run",
	[ "idle" ] = "judge_b_idle",
	[ "light_left" ] = {
		Sequence = "judge_b_left_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_b_right_t1",
		Time = 0.9,
		Rate = 1.4,
	},
	[ "light_forward" ] = {
		Sequence = "judge_b_s2_t2",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "judge_a_right_t1",
		Time = 0.6,
		Rate = 2.0,
	},
	[ "air_forward" ] = {
		Sequence = "judge_a_s1_t2",
		Time = 0.4,
		Rate = 2.0,
	},
	[ "heavy" ] = {
		Sequence = "flourish_bow_basic",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "h_c1_charge",
}

wOS.Form.Singles[ "Defensive" ][3] = {
	[ "run" ] = "judge_h_run",
	[ "idle" ] = "judge_h_idle",
	[ "light_left" ] = {
		Sequence = "judge_b_left_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_b_right_t1",
		Time = 0.9,
		Rate = 1.4,
	},
	[ "light_forward" ] = {
		Sequence = "judge_b_s2_t2",
		Time = 0.8,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "judge_a_left_t1",
		Time = 0.6,
		Rate = 1.6,
	},
	[ "air_right" ] = {
		Sequence = "judge_a_right_t1",
		Time = 0.6,
		Rate = 2.0,
	},
	[ "air_forward" ] = {
		Sequence = "judge_a_s1_t2",
		Time = 0.4,
		Rate = 2.0,
	},
	[ "heavy" ] = {
		Sequence = "flourish_bow_basic",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "h_c1_charge",
}

wOS.Form.Singles[ "Agile" ] = {}
wOS.Form.Singles[ "Agile" ][1] = {
	[ "run" ] = "ryoku_r_run",
	[ "idle" ] = "ryoku_r_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_r_left_t1",
		Time = 0.7,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_r_c1_t1",
		Time = 0.6,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "vanguard_a_right_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "ryoku_b_s2_t3",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS.Form.Singles[ "Agile" ][2] = {
	[ "run" ] = "ryoku_b_run",
	[ "idle" ] = "ryoku_b_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_b_left_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_b_right_t1",
		Time = nil,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_b_s2_t2",
		Time = 0.8,
		Rate = 1.2,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "vanguard_a_right_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "ryoku_b_s2_t3",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS.Form.Singles[ "Agile" ][3] = {
	[ "run" ] = "ryoku_h_run",
	[ "idle" ] = "ryoku_h_idle",
	[ "light_left" ] = {
		Sequence = "ryoku_h_left_t1",
		Time = 0.8,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "ryoku_h_right_t1",
		Time = 0.8,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_h_s1_t1",
		Time = 0.9,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence =  "vanguard_a_left_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "vanguard_a_right_t1",
		Time = 0.4,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "ryoku_a_s2_t1",
		Time = 0.6,
		Rate = 1.5,
	},
	[ "heavy" ] = {
		Sequence = "ryoku_b_s2_t3",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS.Form.Duals[ "Arrogant" ] = {}
wOS.Form.Duals[ "Arrogant" ][1] = {
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "ryoku_r_right_t1",
		Time = 1.3,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "judge_r_s3_t2",
		Time = 1.4,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "judge_h_left_t3",
		Time = 1.5,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "pure_r_left_t3",
		Time = 1.2,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS.Form.Duals[ "Arrogant" ][2] = {
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "h_right_t3",
		Time = 1.6,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "r_c6_t1",
		Time = 1.2,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_r_c6_t3",
		Time = 1.0,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "ryoku_b_right_t3",
		Time = 1.8,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

wOS.Form.Duals[ "Arrogant" ][3] = {
	[ "idle" ] = "ryoku_idle_lower",
	[ "run" ] = "ryoku_run_lower",
	[ "light_left" ] = {
		Sequence = "ryoku_r_c4_t1",
		Time = 1.0,
		Rate = nil,
	},
	[ "light_right" ] = {
		Sequence = "vanguard_h_right_t3",
		Time = 0.8,
		Rate = nil,
	},
	[ "light_forward" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = nil,
		Rate = nil,
	},
	[ "air_left" ] = {
		Sequence = "ryoku_a_left_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_right" ] = {
		Sequence = "ryoku_a_right_t1",
		Time = 1,
		Rate = 1.5,
	},
	[ "air_forward" ] = {
		Sequence = "vanguard_a_s1_t1",
		Time = 0.6,
		Rate = 1.2,
	},
	[ "heavy" ] = {
		Sequence = "pure_b_right_t3",
		Time = 1.5,
		Rate = nil,
	},
	[ "heavy_charge" ] = "ryoku_b_s1_charge",
}

hook.Add( "Initialize", "wOS.FormCreationTables", function()

	wOS.Form.LocalizedForms = {}
	wOS.Form.IndexedForms = {}
	
	for form, _ in pairs( wOS.Form.Singles ) do
		wOS.Form.LocalizedForms[ #wOS.Form.LocalizedForms + 1 ] = form
		wOS.Form.IndexedForms[ form ] = #wOS.Form.LocalizedForms
	end
	
	for form, _ in pairs( wOS.Form.Duals ) do
		wOS.Form.LocalizedForms[ #wOS.Form.LocalizedForms + 1 ] = form
		wOS.Form.IndexedForms[ form ] = #wOS.Form.LocalizedForms
	end

end )