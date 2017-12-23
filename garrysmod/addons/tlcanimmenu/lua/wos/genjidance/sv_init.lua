

util.AddNetworkString( "wOS.RollMod.CallRestart" )
util.AddNetworkString("StartAnimationGenjiDance")


net.Receive("StartAnimationGenjiDance",function (l,ply)
    local number = net.ReadString()
	local delay = net.ReadString()
    ply:StartRolling(number,delay)
end)


hook.Add( "OnPlayerHitGround", "wOS.RollMod.PlayLandNoise", function( ply, inWater, onFloater, speed )
	if ply.wOS.Landed then return end
	ply:EmitSound( "wos/roll/land.wav" )
	ply.wOS.Landed = true
end )


hook.Add( "PlayerSpawn", "wOS.RollMod.Reset", function( ply )

	ply:SetNW2Float( "wOS.RollTime", 0 )
	ply:SetNW2Int( "wOS.RollDir", 0 )
	ply.wOS = {}
	ply.wOS.LastRoll = 0
	ply.wOS.LastKey = 0
	ply.wOS.Landed = true
	
end )

local meta = FindMetaTable( "Player" )

function meta:OnLadder()

	return self:GetMoveType() == MOVETYPE_LADDER

end

function meta:CanRoll()

	if self:KeyDown( IN_WALK ) then return false end

	local hookcheck = hook.Call( "wOS.RollMod.ShouldRoll", nil, self )
	if hookcheck then return hookcheck end
	
	return ( !self:wOSIsRolling() and self:OnGround() and !self:OnLadder() )
	
end

function meta:StartRolling(number,delay)
	if not self:CanRoll() then return end
	number = tonumber(number)
	hook.Call( "wOS.RollMod.OnRoll", nil, self )
	local time = 0.75
	self:SetNW2Int( "wOS.RollDir", number )

	self:SetNW2Float( "wOS.RollTime", CurTime() + tonumber(delay) )	

	wOS.RollMod:ResetAnimation( self )

	self.wOS.LastRoll = 0
	timer.Simple( time*0.63, function()
		if not IsValid( self ) then return end
		if not self:Alive() then return end
		if not self:wOSIsRolling() then return end
		if not self:OnGround() then self.wOS.Landed = false return end	
	end )
end

