----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

local lang = ConfigurationMedicMod.Language
local sentences = ConfigurationMedicMod.Sentences

-- add entities to the medic job
timer.Simple(0, function()
	-- add all test tubes
	for k, v in pairs( ConfigurationMedicMod.Reagents ) do

		DarkRP.createEntity(sentences["Test tube"][lang].." : "..k, {
			ent = "test_tube_medicmod",
			model = "models/medicmod/test_tube/testtube.mdl",
			price = 20,
			max = 2,
			cmd = "buytesttube"..string.Replace(k, " "),
			allowed = ConfigurationMedicMod.MedicTeams,
			spawn = function(ply, tr, tblEnt) local ent = ents.Create(tblEnt.ent) ent:SetPos(tr.HitPos) ent:Spawn() ent:SetProduct(k) return ent end,
		})

	end
	
	DarkRP.createEntity("Beaker", {
		ent = "beaker_medicmod",
		model = "models/medicmod/beaker/beaker.mdl",
		price = 30,
		max = 2,
		cmd = "buybeaker",
		allowed = ConfigurationMedicMod.MedicTeams,
	})
	
	DarkRP.createEntity("Drug pot", {
		ent = "drug_medicmod",
		model = "models/medicmod/drug/drug.mdl",
		price = 10,
		max = 2,
		cmd = "buydrugpot",
		allowed = ConfigurationMedicMod.MedicTeams,
	})
	
	DarkRP.createEntity("Blood bag", {
		ent = "bloodbag_medicmod",
		model = "models/medicmod/bloodbag/bloodbag.mdl",
		price = 10,
		max = 2,
		cmd = "buybloodbag",
		allowed = ConfigurationMedicMod.MedicTeams,
	})	
	
	DarkRP.createEntity("Drip", {
		ent = "drip_medicmod",
		model = "models/medicmod/medical_stand/medical_stand.mdl",
		price = 100,
		max = 2,
		cmd = "buydrip",
		allowed = ConfigurationMedicMod.MedicTeams,
	})
end)
