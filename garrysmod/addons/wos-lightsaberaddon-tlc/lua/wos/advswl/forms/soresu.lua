local FORM = {}

--The name of this form. Do not repeat names of forms!
FORM.Name = "Soresu"

--Who does this form belong to? Options: FORM_SINGLE, FORM_DUAL, FORM_BOTH
FORM.Type = FORM_SINGLE

--What user groups are able to use this form? And which stances?
FORM.UserGroups = { 
	["user"] = { 1 }, 
	["jedi"] = { 1, 2 },
}

FORM.Stances = {}

FORM.Stances[1] = {
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

FORM.Stances[2] = {
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
		Sequence = "flourish_bow_basic",
		Time = 2.0,
		Rate = nil,
	},
	[ "heavy_charge" ] = "h_c1_charge",
}

wOS:RegisterNewForm( FORM )