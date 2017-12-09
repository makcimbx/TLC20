include('shared.lua')

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/


function ENT:Initialize()
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/

local w1,h1,w2,h2 = 0,0,0,0
function ENT:Draw()
	self.Entity:DrawModel()
	render.MaterialOverride("models/props_combine/tpballglow")
	local Pos = self:GetPos()

	local ang = EyeAngles()--LocalPlayer():EyeAngles()
	ang:RotateAroundAxis( ang:Up(), -90 )

	cam.Start3D2D(Pos, Angle( 0, ang.y, 90 ) , 0.2)
        w1,h1 = draw.WordBox(2, -w1/2, -h1-150, "Патроны", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		w2,h2 = draw.WordBox(2, -w2/2, -150, self:GetNWInt( "Ammo" ), "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
    cam.End3D2D()
end