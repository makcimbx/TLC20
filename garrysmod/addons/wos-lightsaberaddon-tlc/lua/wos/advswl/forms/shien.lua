local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Shien/Djem So"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_SINGLE

--What user groups are able to use this form? And which stances?
FORM.UserGroups = { 
	["user"] = { 1 }, 
	["jedi"] = { 1, 2, 3 },
}

FORM.Stances = {}

FORM.Stances[1] = {
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


FORM.Stances[3] = {
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

wOS:RegisterNewForm( FORM )