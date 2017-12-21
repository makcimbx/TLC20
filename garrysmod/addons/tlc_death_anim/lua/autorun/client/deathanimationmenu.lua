
local randomanims = GetConVar( 'deathanimation_random' )

local BadBeginnings = { "g_", "p_", "e_", "b_", "bg_", "hg_", "tc_", "aim_", "turn", "gest_", "pose_", "auto_", "layer_", "posture", "bodyaccent", "a_" }
local BadStrings = { "gesture", "posture", "_trans_", "_rot_", "gest", "aim", "bodyflex_", "delta", "ragdoll", "spine", "arms" } -- Copied from RobotBoy655's easy animation tool code

local function GetGoodAnimationsAndDo( ent, func, tbl ) -- This is just used to run a function if a sequence is valid

	for _, seq in pairs( ent:GetSequenceList() ) do
	
		local goodanim = true
		
		for _, str in ipairs( BadStrings ) do
			if ( string.find( string.lower( seq ), str ) ~= nil ) then goodanim = false end
		end
		
		for _, str in ipairs( BadBeginnings ) do
			if ( str == string.Left( string.lower( seq ), string.len( str ) ) ) then goodanim = false end
		end
		
		if tbl then
			for _, str in pairs( tbl ) do
				if str == seq then goodanim = false end
			end
		end
		
		if goodanim then
			func( seq )
		end	
		
	end
	
end



local function UpdateRandomTblCvar( tbl ) -- Update the convar from the table

	local str = ''
	
	for k, line in pairs( tbl:GetLines() ) do
		str = str .. line:GetValue(1) .. ','
	end
	
	RunConsoleCommand( 'deathanimation_random', string.sub( str, 1, #str-1 ) ) -- string.sub to remove the last ,

end

hook.Add( 'PopulateToolMenu', 'DeathAnimationSettings', function()

end )
