--[[Server Boost: Animations by XTC
	If this file is uploaded anywhere publicly, it was stolen.]]

include("sboosta_settings.lua")

local logtofile = GetSBoostASetting("LogToFile")
local function PrintMessage(msg)
	Msg("[ServerBoost] ", msg, "\n")
	if logtofile then
		file.Append("SBoost_Animations.txt", os.date() .. "   " .. msg.."\n")
	end
end

if !GetSBoostASetting("Enable") then 
	PrintMessage("Disabled, re-enable in sboosta_settings.lua")
	return
end

local AnimationsFileCRC = "2389385635"
local DarkRpAnimationsHookCRC = {
["2513805867"] = true, --optimized
["76561198045249764"] = true, --optimized
["3392493512"] = true, --2.7
["553215003"] = true, --2.4.3
}
local AnimationsFileCodeSegments = "5abdc7abcde96af65ba4caf0218de78f661938627979f86d87926c615e8137ca"

local FuncNames = {
	"HandlePlayerJumping",
	"HandlePlayerDucking",
	"HandlePlayerNoClipping",
	"HandlePlayerVaulting",
	"HandlePlayerSwimming",
	"HandlePlayerLanding",
	"HandlePlayerDriving",
	"UpdateAnimation",
	"CalcMainActivity",
	"TranslateActivity",
	"DoAnimationEvent",
}


local ACT_LAND = ACT_LAND
local ACT_MP_JUMP = ACT_MP_JUMP
local ACT_MP_SWIM = ACT_MP_SWIM
local ACT_MP_CROUCHWALK = ACT_MP_CROUCHWALK
local ACT_MP_CROUCH_IDLE = ACT_MP_CROUCH_IDLE
local ACT_GMOD_NOCLIP_LAYER = ACT_GMOD_NOCLIP_LAYER
local ACT_VM_PRIMARYATTACK = ACT_VM_PRIMARYATTACK
local ACT_VM_SECONDARYATTACK = ACT_VM_SECONDARYATTACK
local ACT_MP_ATTACK_CROUCH_PRIMARYFIRE = ACT_MP_ATTACK_CROUCH_PRIMARYFIRE
local ACT_MP_ATTACK_STAND_PRIMARYFIRE = ACT_MP_ATTACK_STAND_PRIMARYFIRE
local ACT_MP_RELOAD_CROUCH = ACT_MP_RELOAD_CROUCH
local ACT_MP_RELOAD_STAND = ACT_MP_RELOAD_STAND
local ACT_INVALID = ACT_INVALID
local GESTURE_SLOT_CUSTOM = GESTURE_SLOT_CUSTOM
local GESTURE_SLOT_JUMP = GESTURE_SLOT_JUMP
local GESTURE_SLOT_ATTACK_AND_RELOAD = GESTURE_SLOT_ATTACK_AND_RELOAD
local MOVETYPE_NOCLIP = MOVETYPE_NOCLIP
local PLAYERANIMEVENT_ATTACK_PRIMARY = PLAYERANIMEVENT_ATTACK_PRIMARY
local PLAYERANIMEVENT_ATTACK_SECONDARY = PLAYERANIMEVENT_ATTACK_SECONDARY
local PLAYERANIMEVENT_RELOAD = PLAYERANIMEVENT_RELOAD
local PLAYERANIMEVENT_CANCEL_RELOAD = PLAYERANIMEVENT_CANCEL_RELOAD
local PLAYERANIMEVENT_JUMP = PLAYERANIMEVENT_JUMP
local FL_ONGROUND = FL_ONGROUND

local CurTime = CurTime
local isfunction = isfunction
local max = math.max
local min = math.min
local GetGamemode = gmod.GetGamemode
local hCall = hook.Call
local IsValid = IsValid
local RecipientFilter = RecipientFilter
local umsg = umsg

local ENTITY = debug.getregistry().Entity
local PLAYER = debug.getregistry().Player
local VECTOR = debug.getregistry().Vector

local IsFlagSet = ENTITY.IsFlagSet
local GetMoveType = ENTITY.GetMoveType
local WaterLevel = ENTITY.WaterLevel
local Length2D = VECTOR.Length2D
local Length2DSqr = VECTOR.Length2DSqr
local SetCycle = ENTITY.SetCycle
local Crouching = PLAYER.Crouching
local InVehicle = PLAYER.InVehicle
local IsVehicle = ENTITY.IsVehicle
local AnimResetGestureSlot = PLAYER.AnimResetGestureSlot
local Length = VECTOR.Length
local LengthSqr = VECTOR.LengthSqr
local GetVehicle = PLAYER.GetVehicle
local GetClass = ENTITY.GetClass
local SetPlaybackRate = ENTITY.SetPlaybackRate
local TranslateWeaponActivity = PLAYER.TranslateWeaponActivity
local GetModel = ENTITY.GetModel
local LookupSequence = ENTITY.LookupSequence
local AnimRestartGesture = PLAYER.AnimRestartGesture
local IsPlayer = ENTITY.IsPlayer
local GetAllowWeaponsInVehicle = PLAYER.GetAllowWeaponsInVehicle
local GetActiveWeapon = PLAYER.GetActiveWeapon
local KeyDown = PLAYER.KeyDown
local Team = PLAYER.Team
local GetEyeTrace = PLAYER.GetEyeTrace
local GetTable = ENTITY.GetTable
--todo: optimize getvehicleclass



local function OnGround(ent)
	return IsFlagSet(ent, FL_ONGROUND)
end

local function AnimRestartMainSequence(ply)
	return SetCycle(ply, 0)
end

local JumpingHooks = false
local DuckingHooks = false
local NoClippingHooks = false
local VaultingHooks = false
local SwimmingHooks = false
local LandingHooks = false
local DrivingHooks = false


local function CopyOrigFuncs()
	ORIGANI = {} --global is needed for lua refreshes
	for _, name in pairs(FuncNames) do
		ORIGANI[name] = GAMEMODE[name]
	end
end
hook.Add("Initialize", "SBoostA_FunctionOverwriteCheck", CopyOrigFuncs)


local function CheckAnimationsCRC()
	return util.CRC(file.Read("gamemodes/base/gamemode/animations.lua", "GAME")) == AnimationsFileCRC
end

local gmname = engine.ActiveGamemode()

local function CRCFunc(func)
	local dinfo = debug.getinfo(func)

	local file = file.Read(dinfo.short_src, "GAME")

	file = string.Explode("\n", file, false)

	local funcstr = table.concat(file, "\n", dinfo.linedefined, dinfo.lastlinedefined)

	return util.CRC(funcstr)
end

local function CheckDarkRPAnimations()
	local calcmain = hook.GetTable()["CalcMainActivity"]
	if not calcmain then return false end
	local func = calcmain["darkrp_animations"]
	if not func then return false end

	if DarkRpAnimationsHookCRC[CRCFunc(func)] or debug.getinfo(func).short_src == "addons/sboost_animations/lua/sboosta_main.lua" then
		return true
	else
		PrintMessage("Warning: The default darkrp animations hook has been modified (" .. CRCFunc(func) .. "), so optimized darkrp code will NOT be loaded. If the 'darkrp_animations' hook has not been modified, set 'IgnoreDarkRPAnimationsCRC' to true in the settings.")
		return false
	end
end


local function ToggleHookStatus(name)
	if name == "HandlePlayerJumping" then
		JumpingHooks = true
	elseif name == "HandlePlayerDucking" then
		DuckingHooks = true
	elseif name == "HandlePlayerNoClipping" then
		NoClippingHooks = true
	elseif name == "HandlePlayerVaulting" then
		VaultingHooks = true
	elseif name == "HandlePlayerSwimming" then
		SwimmingHooks = true
	elseif name == "HandlePlayerLanding" then
		LandingHooks = true
	elseif name == "HandlePlayerDriving" then
		DrivingHooks = true
	end
end

local boostpath = "addons/sboost_animations/lua/sboosta_main.lua"
local vanillapath = "gamemodes/base/gamemode/animations.lua"

local function UpdateAnimationHooks()
	local hooks = hook.GetTable()

	for _, name in pairs(FuncNames) do
		if hooks[name] and table.Count(hooks[name]) > 0 then
			local fname, func = next(hooks[name])
			local src = debug.getinfo(func).short_src
			if src == boostpath then continue end
			PrintMessage("Warning: " .. name .. " has a hook '" .. fname .. "' from " .. src .. ". This may limit performance boost.")
			ToggleHookStatus(name)
		end
	end
end


local function CheckAnimationFuncOverwrites()
	local overwrite = false
	for _, name in pairs(FuncNames) do
		if ORIGANI[name] != GAMEMODE[name] then
			local src = debug.getinfo(GAMEMODE[name]).short_src
			if src == vanillapath or src == boostpath then continue end
			PrintMessage("Error: " .. name .. " function overwritten by " .. src .. ". To resolve this conflict, remove the associated addon or hook.")
			overwrite = true
		end
	end
	return overwrite
end



local m_bJumping = {}
local m_fGroundTime = {}
local m_bFirstJumpFrame = {}
local m_flJumpStartTime = {}
local CalcIdeal = {}
local m_bWasNoclipping = {}
local m_bInSwim = {}
local CalcSeqOverride = {}
local m_bWasOnGround = {}
local HandleAnimation = {}
local SaidHi = {}
local ThrewPoop = {}

local function CleanupAnimationTables(ent)
	if IsPlayer(ent) then
		if m_bJumping[ent] then
			m_bJumping[ent] = nil
		end
		if m_fGroundTime[ent] then
			m_fGroundTime[ent] = nil
		end
		if m_bFirstJumpFrame[ent] then
			m_bFirstJumpFrame[ent] = nil
		end
		if m_flJumpStartTime[ent] then
			m_flJumpStartTime[ent] = nil
		end
		if CalcIdeal[ent] then
			CalcIdeal[ent] = nil
		end
		if m_bWasNoclipping[ent] then
			m_bWasNoclipping[ent] = nil
		end
		if m_bInSwim[ent] then
			m_bInSwim[ent] = nil
		end
		if CalcSeqOverride[ent] then
			CalcSeqOverride[ent] = nil
		end
		if m_bWasOnGround[ent] then
			m_bWasOnGround[ent] = nil
		end
		if SaidHi[ent] then
			SaidHi[ent] = nil
		end
		if ThrewPoop[ent] then
			ThrewPoop[ent] = nil
		end
	else
		if HandleAnimation[ent] then
			HandleAnimation[ent] = nil
		end
	end
	
end
hook.Add("EntityRemoved", "SBoostA_CleanupAnimationTables", CleanupAnimationTables)

local function UpdateHandleAnimation(pVehicle)

	if ( !IsVehicle(pVehicle) ) then return end

	if ( !HandleAnimation[pVehicle] && pVehicle.GetVehicleClass ) then
		local c = pVehicle:GetVehicleClass()
		local t = list.Get( "Vehicles" )[ c ]
		if ( t && t.Members && t.Members.HandleAnimation ) then
			HandleAnimation[pVehicle] = t.Members.HandleAnimation
		end
	end

end
hook.Add("OnEntityCreated", "SBoostA_VehicleHandleAnimations", UpdateHandleAnimation)



local SequenceCache = {}
local function LookupCachedSequence(ply, seq)
	local model = GetModel(ply)

	if not SequenceCache[model] then
		SequenceCache[model] = {}
	end

	if not SequenceCache[model][seq] then
		SequenceCache[model][seq] = LookupSequence(ply, seq)
	end

	return SequenceCache[model][seq]
end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerJumping( ply, velocity )

	if ( GetMoveType(ply) == MOVETYPE_NOCLIP ) then
		m_bJumping[ply] = false
		return
	end

	-- airwalk more like hl2mp, we airwalk until we have 0 velocity, then it's the jump animation
	-- underwater we're alright we airwalking
	if ( !m_bJumping[ply] && !OnGround(ply) && WaterLevel(ply) <= 0 ) then

		if ( !m_fGroundTime[ply] ) then

			m_fGroundTime[ply] = CurTime()
			
		elseif ( CurTime() - m_fGroundTime[ply] ) > 0 && Length2DSqr(velocity) < 0.25 then

			m_bJumping[ply] = true
			m_bFirstJumpFrame[ply] = false
			m_flJumpStartTime[ply] = 0

		end
	end

	if m_bJumping[ply] then
	
		if m_bFirstJumpFrame[ply] then

			m_bFirstJumpFrame[ply] = false
			AnimRestartMainSequence(ply)

		end
		
		if ( WaterLevel(ply) >= 2 ) || ( ( CurTime() - m_flJumpStartTime[ply] ) > 0.2 && OnGround(ply) ) then

			m_bJumping[ply] = false
			m_fGroundTime[ply] = nil
			AnimRestartMainSequence(ply)

		end
		
		if m_bJumping[ply] then
			CalcIdeal[ply] = ACT_MP_JUMP
			return true
		end
	end

	return false

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerDucking( ply, velocity )

	if ( !Crouching(ply) ) then return false end

	if ( Length2DSqr(velocity) > 0.25 ) then
		CalcIdeal[ply] = ACT_MP_CROUCHWALK
	else
		CalcIdeal[ply] = ACT_MP_CROUCH_IDLE
	end

	return true

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerNoClipping( ply, velocity )

	if ( GetMoveType(ply) != MOVETYPE_NOCLIP || InVehicle(ply) ) then

		if ( m_bWasNoclipping[ply] ) then

			m_bWasNoclipping[ply] = nil
			AnimResetGestureSlot( ply, GESTURE_SLOT_CUSTOM )

		end

		return

	end

	if ( !m_bWasNoclipping[ply] ) then

		AnimRestartGesture( ply, GESTURE_SLOT_CUSTOM, ACT_GMOD_NOCLIP_LAYER, false )

	end

	return true

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerVaulting( ply, velocity )

	if ( LengthSqr(velocity) < 1000000 ) then return end
	if ( OnGround(ply) ) then return end

	CalcIdeal[ply] = ACT_MP_SWIM

	return true

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerSwimming( ply, velocity )

	if ( WaterLevel(ply) < 2 or OnGround(ply) ) then
		m_bInSwim[ply] = false
		return false
	end

	CalcIdeal[ply] = ACT_MP_SWIM
	m_bInSwim[ply] = true

	return true

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerLanding( ply, velocity, WasOnGround )

	if ( GetMoveType(ply) == MOVETYPE_NOCLIP ) then return end

	if ( OnGround(ply) && !WasOnGround ) then
		AnimRestartGesture( ply, GESTURE_SLOT_JUMP, ACT_LAND, true )
	end

end


-----------------------------------------------------------------------------------------------------------------------
local function HandlePlayerDriving( ply )

	if ( !InVehicle(ply) ) then return false end

	local pVehicle = GetVehicle(ply)

	if ( HandleAnimation[pVehicle] ) then
		local seq = HandleAnimation[pVehicle]( ply )
		if ( seq != nil ) then
			CalcSeqOverride[ply] = seq
		end
	end

	if ( CalcSeqOverride[ply] == -1 ) then -- pVehicle.HandleAnimation did not give us an animation
		local class = GetClass(pVehicle)

		if ( class == "prop_vehicle_jeep" ) then
			CalcSeqOverride[ply] = LookupCachedSequence( ply, "drive_jeep" )
		elseif ( class == "prop_vehicle_airboat" ) then
			CalcSeqOverride[ply] = LookupCachedSequence( ply, "drive_airboat" )
		elseif ( class == "prop_vehicle_prisoner_pod" && GetModel(pVehicle) == "models/vehicles/prisoner_pod_inner.mdl" ) then
			CalcSeqOverride[ply] = LookupCachedSequence( ply, "drive_pd" )
		else
			CalcSeqOverride[ply] = LookupCachedSequence( ply, "sit_rollercoaster" )
		end
	end
	
	local use_anims = ( CalcSeqOverride[ply] == LookupCachedSequence( ply, "sit_rollercoaster" ) || CalcSeqOverride[ply] == LookupCachedSequence( ply, "sit" ) )
	if ( use_anims && GetAllowWeaponsInVehicle(ply) && IsValid( GetActiveWeapon(ply) ) ) then
		local holdtype = GetActiveWeapon(ply):GetHoldType()
		if ( holdtype == "smg" ) then holdtype = "smg1" end

		local seqid = LookupCachedSequence( ply, "sit_" .. holdtype )
		if ( seqid != -1 ) then
			CalcSeqOverride[ply] = seqid
		end
	end

	return true
end


-----------------------------------------------------------------------------------------------------------------------
local function UpdateAnimation( GM, ply, velocity, maxseqgroundspeed )

	local len = Length(velocity)
	local movement = 1.0

	if ( len > 0.2 ) then
		movement = ( len / maxseqgroundspeed )
	end

	local rate = min( movement, 2 )

	-- if we're under water we want to constantly be swimming..
	if ( WaterLevel(ply) >= 2 ) then
		rate = max( rate, 0.5 )
	elseif ( OnGround(ply) && len >= 1000 ) then
		rate = 0.1
	end

	SetPlaybackRate( ply, rate )

end


-----------------------------------------------------------------------------------------------------------------------
local function CalcMainActivity( GM, ply, velocity )

	CalcIdeal[ply] = ACT_MP_STAND_IDLE
	CalcSeqOverride[ply] = -1

	if LandingHooks then
		hCall( "HandlePlayerLanding", GM, ply, velocity, m_bWasOnGround[ply] )
	else
		HandlePlayerLanding( ply, velocity, m_bWasOnGround[ply] )
	end


	if
		(NoClippingHooks and hCall( "HandlePlayerNoClipping", GM, ply, velocity )) or
		HandlePlayerNoClipping( ply, velocity )
		or
		(DrivingHooks and hCall( "HandlePlayerDriving", GM, ply )) or
		HandlePlayerDriving( ply )
		or
		(VaultingHooks and hCall( "HandlePlayerVaulting", GM, ply, velocity )) or
		HandlePlayerVaulting( ply, velocity )
		or
		(JumpingHooks and hCall( "HandlePlayerJumping", GM, ply, velocity )) or
		HandlePlayerJumping( ply, velocity )
		or
		(SwimmingHooks and hCall( "HandlePlayerSwimming", GM, ply, velocity )) or
		HandlePlayerSwimming( ply, velocity )
		or
		(DuckingHooks and hCall( "HandlePlayerDucking", GM, ply, velocity )) or
		HandlePlayerDucking( ply, velocity )
		then

	else

		local len2d = Length2DSqr(velocity)
		if ( len2d > 22500 ) then
			CalcIdeal[ply] = ACT_MP_RUN
		elseif ( len2d > 0.25 ) then
			CalcIdeal[ply] = ACT_MP_WALK
		end

	end

	m_bWasOnGround[ply] = OnGround(ply)
	m_bWasNoclipping[ply] = ( GetMoveType(ply) == MOVETYPE_NOCLIP && !InVehicle(ply) )

	return CalcIdeal[ply], CalcSeqOverride[ply]

end

local IdleActivity = ACT_HL2MP_IDLE
local IdleActivityTranslate = {}
IdleActivityTranslate[ ACT_MP_STAND_IDLE ]					= IdleActivity
IdleActivityTranslate[ ACT_MP_WALK ]						= IdleActivity + 1
IdleActivityTranslate[ ACT_MP_RUN ]							= IdleActivity + 2
IdleActivityTranslate[ ACT_MP_CROUCH_IDLE ]					= IdleActivity + 3
IdleActivityTranslate[ ACT_MP_CROUCHWALK ]					= IdleActivity + 4
IdleActivityTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ]	= IdleActivity + 5
IdleActivityTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	= IdleActivity + 5
IdleActivityTranslate[ ACT_MP_RELOAD_STAND ]				= IdleActivity + 6
IdleActivityTranslate[ ACT_MP_RELOAD_CROUCH ]				= IdleActivity + 6
IdleActivityTranslate[ ACT_MP_JUMP ]						= ACT_HL2MP_JUMP_SLAM
IdleActivityTranslate[ ACT_MP_SWIM ]						= IdleActivity + 9
IdleActivityTranslate[ ACT_LAND ]							= ACT_LAND

-----------------------------------------------------------------------------------------------------------------------
local function TranslateActivity( GM, ply, act )

	local newact = TranslateWeaponActivity( ply, act )

	-- select idle anims if the weapon didn't decide
	if ( act == newact ) then
		return IdleActivityTranslate[ act ]
	end

	return newact

end

-----------------------------------------------------------------------------------------------------------------------
local function DoAnimationEvent( GM, ply, event, data )

	if ( event == PLAYERANIMEVENT_ATTACK_PRIMARY ) then
	
		if Crouching(ply) then
			AnimRestartGesture( ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_ATTACK_CROUCH_PRIMARYFIRE, true )
		else
			AnimRestartGesture( ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_ATTACK_STAND_PRIMARYFIRE, true )
		end
		
		return ACT_VM_PRIMARYATTACK
	
	elseif ( event == PLAYERANIMEVENT_ATTACK_SECONDARY ) then
	
		-- there is no gesture, so just fire off the VM event
		return ACT_VM_SECONDARYATTACK
		
	elseif ( event == PLAYERANIMEVENT_RELOAD ) then
	
		if Crouching(ply) then
			AnimRestartGesture( ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_RELOAD_CROUCH, true )
		else
			AnimRestartGesture( ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MP_RELOAD_STAND, true )
		end
		
		return ACT_INVALID
		
	elseif ( event == PLAYERANIMEVENT_JUMP ) then
	
		m_bJumping[ply] = true
		m_bFirstJumpFrame[ply] = true
		m_flJumpStartTime[ply] = CurTime()
	
		AnimRestartMainSequence(ply)
	
		return ACT_INVALID
	
	elseif ( event == PLAYERANIMEVENT_CANCEL_RELOAD ) then
	
		AnimResetGestureSlot( ply, GESTURE_SLOT_ATTACK_AND_RELOAD )
		
		return ACT_INVALID
	end

end


local function DarkRPAnimations(ply, velocity)

	-- Dropping weapons/money
	if GetTable(ply)["anim_DroppingItem"] then
		AnimRestartGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_DROP, true)
		ply.anim_DroppingItem = nil
	end

	-- Giving items
	if GetTable(ply)["anim_GivingItem"] then
		AnimRestartGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_GIVE, true)
		ply.anim_GivingItem = nil
	end

	-- Hobo throwing poop
	local Weapon = GetActiveWeapon(ply)
	if not ThrewPoop[ply] and KeyDown(ply, IN_ATTACK) and RPExtraTeams[Team(ply)] and RPExtraTeams[Team(ply)].hobo and IsValid(Weapon) and GetClass(Weapon) == "weapon_bugbait" then
		ThrewPoop[ply] = true
		AnimRestartGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)

		local RP = RecipientFilter()
		RP:AddAllPlayers()

		umsg.Start("anim_throwpoop", RP)
			umsg.Entity(ply)
		umsg.End()
	end

	if ThrewPoop[ply] and not KeyDown(ply, IN_ATTACK) then
		ThrewPoop[ply] = nil
	end

	-- Saying hi/hello to a player
	if not SaidHi[ply] and KeyDown(ply, IN_ATTACK) and IsValid(Weapon) and GetClass(Weapon) == "weapon_physgun" then
		local ent = GetEyeTrace(ply).Entity
		if IsValid(ent) and IsPlayer(ent) then
			SaidHi[ply] = true
			AnimRestartGesture(ply, GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_SIGNAL_GROUP, true)

			local RP = RecipientFilter()
			RP:AddAllPlayers()

			umsg.Start("anim_sayhi", RP)
				umsg.Entity(ply)
			umsg.End()
		end
	elseif SaidHi[ply] and not KeyDown(ply, IN_ATTACK) then
		SaidHi[ply] = nil
	end

end



local function LoadAnimationsOptimizer()

	PrintMessage("Checking for conflicts..")

	if !GetSBoostASetting("IgnoreAnimationsCRC") and !CheckAnimationsCRC() then
		PrintMessage("Error: Animations file CRC does not match expected, this is likely due to a gmod update. Update this addon to fix this issue.")
		return
	end

	if !GetSBoostASetting("IgnoreFunctionOverwrites") and CheckAnimationFuncOverwrites() then
		return --this prints its own message
	end

	if CheckDarkRPAnimations() then
		PrintMessage("DarkRP animations found, replacing with optimized code")
		hook.Remove("CalcMainActivity", "darkrp_animations")
		hook.Add("CalcMainActivity", "darkrp_animations", DarkRPAnimations)
	end

	UpdateAnimationHooks()

	PrintMessage("No serious conflicts detected, loading all optimized functions.")

	GetGamemode().CalcMainActivity = CalcMainActivity
	GetGamemode().UpdateAnimation = UpdateAnimation

	GetGamemode().DoAnimationEvent = DoAnimationEvent
	GetGamemode().TranslateActivity = TranslateActivity

	GetGamemode().HandlePlayerJumping = HandlePlayerJumping
	GetGamemode().HandlePlayerDucking = HandlePlayerDucking
	GetGamemode().HandlePlayerNoClipping = HandlePlayerNoClipping
	GetGamemode().HandlePlayerVaulting = HandlePlayerVaulting
	GetGamemode().HandlePlayerSwimming = HandlePlayerSwimming
	GetGamemode().HandlePlayerLanding = HandlePlayerLanding
	GetGamemode().HandlePlayerDriving = HandlePlayerDriving

	PrintMessage("Successfully loaded")

end

local function DelayedLoad()
	local delay = GetSBoostASetting("LoadDelay")
	PrintMessage("Checking for conflicts in " .. delay .. " seconds.")
	timer.Simple(delay, LoadAnimationsOptimizer)
end

DelayedLoad()