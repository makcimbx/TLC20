include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local eye = LocalPlayer():EyeAngles()
	local Pos = self:LocalToWorld( self:OBBCenter() )+Vector( 0, 0, 50 )
	local Ang = Angle( 0, eye.y - 90, 90 )

	cam.Start3D2D(Pos + Vector( 0, 0, math.sin( CurTime() ) * 2 ), Ang, 0.2)
		draw.WordBox(2, -85, 0, "Покупка Вооружения", "PerkTitle", Color(140, 0, 0, 150), Color(255,255,255,255))
		draw.SimpleText( "Покупка оружия для вашего клона-солдата.", "DermaDefault", 0, 35, color_white, 1, 1 )
	cam.End3D2D()
end

function ENT:Think()

end
