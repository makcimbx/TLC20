----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Base Configuration
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

ConfigurationMedicMod.AddonName = "MedicMOD"

-- if set to false, the player would have to press E on the terminal to open the buying menu. 
ConfigurationMedicMod.Terminal3D2D = true

-- Percentage of chance that the shock of the defibrillator works ( Default : 50 )
ConfigurationMedicMod.DefibrillatorShockChance = 50 

ConfigurationMedicMod.MorphineEffectTime = 10

ConfigurationMedicMod.MoneyUnit = "$"

ConfigurationMedicMod.ScanRadioTime = 5

ConfigurationMedicMod.HealedOnChangingJob = true

ConfigurationMedicMod.SurgicalOperationTime = 15
ConfigurationMedicMod.HealthUnitPrice = 1
ConfigurationMedicMod.FractureRepairPrice = 50

ConfigurationMedicMod.ForceRespawn = true 
-- if forcerespawn is set to true :
ConfigurationMedicMod.TimeBeforeRespawn = 60
ConfigurationMedicMod.TimeBeforeRespawnIfStable = 360

ConfigurationMedicMod.DamagePerSecsDuringBleeding = 1 
ConfigurationMedicMod.DamagePerSecsDuringPoisoned = 0.25

-- if the player get X damage on his leg or his arm, then he'll have a fracture
ConfigurationMedicMod.MinimumDamageToGetFractures = 20
ConfigurationMedicMod.MinimumDamageToGetBleeding = 20

ConfigurationMedicMod.CanGetFractures = true
ConfigurationMedicMod.CanGetBleeding = true
ConfigurationMedicMod.CanGetPoisoned = true

ConfigurationMedicMod.DecalsBleeding = true

ConfigurationMedicMod.TimeToQuickAnalyse = 5

-- If the player can do CPR to another player
ConfigurationMedicMod.CanCPR = true
-- CPR Key, list of keys can be find here :  http://wiki.garrysmod.com/page/Enums/BUTTON_CODE
ConfigurationMedicMod.CPRKey = KEY_R

ConfigurationMedicMod.FracturePlayerSpeed = 100

ConfigurationMedicMod.Vehicles["models/perrynsvehicles/ford_f550_ambulance/ford_f550_ambulance.mdl"] = {
	buttonPos = Vector(-40.929615,-139.366989,60.128445),
	buttonAngle = Angle(0,0,90),
	stretcherPos = Vector(0,-80,40),
	stretcherAngle = Angle(0,0,0),
	drawStretcher = false,
	backPos = Vector(0,-170,50)
}

timer.Simple(0, function() -- don't touch this


ConfigurationMedicMod.MedicTeams = { 
	TEAM_MEDIC,
	TEAM_PARAMEDIC,
	}
ConfigurationMedicMod.TeamsCantGetFracture = {
	}
ConfigurationMedicMod.TeamsCantGetBleeding = {
	}
ConfigurationMedicMod.TeamsCantGetPoisoned = {

	}
ConfigurationMedicMod.TeamsCantPracticeCPR = {

	}
ConfigurationMedicMod.TeamsCantReceiveCPR = {

	}

end) -- don't touch this

local lang = ConfigurationMedicMod.Language
local sentences = ConfigurationMedicMod.Sentences
local function AddReagent( name, color ) ConfigurationMedicMod.AddReagent( name, color ) end
local function AddDrug( name, ing1, ing2, ing3, func ) ConfigurationMedicMod.AddDrug( name, ing1, ing2, ing3, func ) end

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Add reagents (ingredients) for drugs
-- AddReagent( name, color )


AddReagent(sentences["Aminophenol"][lang] ,Color(255,0,0))
AddReagent(sentences["Water"][lang], Color(64, 164, 223) )
AddReagent(sentences["Ethanoic anhydride"][lang],Color(255,255,0))
AddReagent(sentences["Potassium iodide"][lang], Color(255,255,255))
AddReagent(sentences["Ethanol"][lang],Color(255,255,255,150))
AddReagent(sentences["Sulfuric acid"][lang],Color(0,255,0))
AddReagent("Calcium ("..string.lower(sentences["Left arm"][lang])..")",Color(120,140,126))
AddReagent("Calcium ("..string.lower(sentences["Right arm"][lang])..")",Color(120,140,126))
AddReagent("Calcium ("..string.lower(sentences["Left leg"][lang])..")",Color(120,140,126))
AddReagent("Calcium ("..string.lower(sentences["Right leg"][lang])..")",Color(120,140,126))

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Add drugs
-- AddDrug( name, reagent1, reagent2, reagent3, function(ply) end )
-- if there is no reagent 2 or 3 then replace them by nil

AddDrug(sentences["Tylenol"][lang], sentences["Aminophenol"][lang], sentences["Water"][lang], sentences["Ethanoic anhydride"][lang], function(ply) ply:MedicNotif(sentences["You have been healed"][lang]) ply:SetHealth(ply:GetMaxHealth()) end )
AddDrug(sentences["Antidote"][lang],sentences["Potassium iodide"][lang], nil, nil, function(ply) ply:SetPoisoned( false ) ply:MedicNotif( sentences["You have stopped your poisoning"][lang], 5 ) end)
AddDrug(sentences["Morphine"][lang], sentences["Water"][lang],sentences["Ethanol"][lang],sentences["Sulfuric acid"][lang], function(ply) ply:SetMorphine( true ) ply:MedicNotif( sentences["You injected some morphine"][lang], 5 ) end)
AddDrug(sentences["Drug"][lang].."("..string.lower(sentences["Left arm"][lang])..")", "Calcium ("..string.lower(sentences["Left arm"][lang])..")", nil, nil, function(ply) ply:SetFracture( false, HITGROUP_LEFTARM) end)
AddDrug(sentences["Drug"][lang].."("..string.lower(sentences["Right arm"][lang])..")", "Calcium ("..string.lower(sentences["Right arm"][lang])..")", nil, nil, function(ply) ply:SetFracture( false, HITGROUP_RIGHTARM) end )
AddDrug(sentences["Drug"][lang].."("..string.lower(sentences["Left leg"][lang])..")", "Calcium ("..string.lower(sentences["Left leg"][lang])..")", nil, nil, function(ply) ply:SetFracture( false, HITGROUP_LEFTLEG) end )
AddDrug(sentences["Drug"][lang].."("..string.lower(sentences["Right leg"][lang])..")", "Calcium ("..string.lower(sentences["Right leg"][lang])..")", nil, nil, function(ply) ply:SetFracture( false, HITGROUP_RIGHTLEG) end )

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- List of entities that can be bought with the terminal
ConfigurationMedicMod.Entities[1] = {
	name = sentences["Bandage"][lang],
	ent = "bandage",
	price = 75,
	mdl = "models/medicmod/bandage/bandage.mdl",
	func = function(ply, ent, price)
		if ply:HasWeapon( ent ) then
			ply:MedicNotif(sentences["You already carry this element on you"][lang])
			return
		end
		ply:addMoney( -price ) 
		ply:Give(ent)
	end
}
ConfigurationMedicMod.Entities[2] = {
	name = sentences["Morphine"][lang],
	ent = "syringe_morphine",
	price = 100,
	mdl = "models/medicmod/syringe/w_syringe.mdl",
	func = function(ply, ent, price)
		if ply:HasWeapon( ent ) then
			ply:MedicNotif(sentences["You already carry this element on you"][lang])
			return
		end
		ply:addMoney( -price ) 
		ply:Give(ent)
	end
}
ConfigurationMedicMod.Entities[3] = {
	name = sentences["Antidote"][lang],
	ent = "syringe_antidote",
	price = 50,
	mdl = "models/medicmod/syringe/w_syringe.mdl",
	func = function(ply, ent, price)
		if ply:HasWeapon( ent ) then
			ply:MedicNotif(sentences["You already carry this element on you"][lang])
			return
		end
		ply:addMoney( -price ) 
		ply:Give(ent)
	end
}
ConfigurationMedicMod.Entities[4] = {
	name = sentences["First Aid Kit"][lang],
	ent = "first_aid_kit",
	price = 400,
	mdl = "models/medicmod/firstaidkit/firstaidkit.mdl",
	func = function(ply, ent, price)
		if ply:HasWeapon( ent ) then
			ply:MedicNotif(sentences["You already carry a medical kit on you"][lang])
			return
		end
		ply:addMoney( -price ) 
		ply:Give(ent)
		local weap = ply:GetWeapon(ent)
		weap:SetBandage( 3 )
		weap:SetAntidote( 1 )
		weap:SetMorphine( 2 )
	end
}

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

ConfigurationMedicMod.DamagePoisoned[DMG_PARALYZE]=true
ConfigurationMedicMod.DamagePoisoned[DMG_POISON]=true
ConfigurationMedicMod.DamagePoisoned[DMG_ACID]=true
ConfigurationMedicMod.DamagePoisoned[DMG_RADIATION]=true

ConfigurationMedicMod.DamageBleeding[DMG_BULLET]=true
ConfigurationMedicMod.DamageBleeding[DMG_CRUSH]=true
ConfigurationMedicMod.DamageBleeding[DMG_SLASH]=true
ConfigurationMedicMod.DamageBleeding[DMG_VEHICLE]=true
ConfigurationMedicMod.DamageBleeding[DMG_BLAST]=true
ConfigurationMedicMod.DamageBleeding[DMG_CLUB]=true
ConfigurationMedicMod.DamageBleeding[DMG_AIRBOAT]=true
ConfigurationMedicMod.DamageBleeding[DMG_BLAST_SURFACE]=true
ConfigurationMedicMod.DamageBleeding[DMG_BUCKSHOT]=true
ConfigurationMedicMod.DamageBleeding[DMG_PHYSGUN]=true
ConfigurationMedicMod.DamageBleeding[DMG_FALL]=true
ConfigurationMedicMod.DamageBleeding[DMG_MEDICMODBLEEDING]=true

ConfigurationMedicMod.DamageBurn[DMG_BURN]=true
ConfigurationMedicMod.DamageBurn[DMG_SLOWBURN]=true

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
