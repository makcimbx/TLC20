
--Special thanks to Chessnut for this beautiful weapon lowering code taken from Nutscript!

local LOWERED_ANGLES = Angle(30, -30, -25)
--[[
hook.Add( "CalcViewModelView", "wOS.Prone.HolsterWeapon", function(weapon, viewModel, oldEyePos, oldEyeAngles, eyePos, eyeAngles)

	if (!IsValid(weapon)) then
		return
	end

	local client = LocalPlayer()
	local value = client.LowerPercent or 0
	
	local fraction = (client.nutRaisedFrac or 0) / 100
	local rotation = weapon.LowerAngles or LOWERED_ANGLES
	
	if weapon.LowerAngles2 then
		rotation = weapon.LowerAngles2
	end
	
	eyeAngles:RotateAroundAxis(eyeAngles:Up(), rotation.p * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Forward(), rotation.y * fraction)
	eyeAngles:RotateAroundAxis(eyeAngles:Right(), rotation.r * fraction)

	client.nutRaisedFrac = Lerp(FrameTime() * 2, client.nutRaisedFrac or 0, value)

	viewModel:SetAngles(eyeAngles)

	if (weapon.GetViewModelPosition) then
		local position, angles = weapon:GetViewModelPosition(eyePos, eyeAngles)

		oldEyePos = position or oldEyePos
		eyeAngles = angles or eyeAngles
	end
	
	return oldEyePos, eyeAngles
end )
]]--