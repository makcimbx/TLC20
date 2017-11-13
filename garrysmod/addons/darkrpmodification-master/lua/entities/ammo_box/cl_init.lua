include('shared.lua')

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/


function ENT:Initialize()
end

/*---------------------------------------------------------
   Name: DrawPre
---------------------------------------------------------*/

function ENT:Draw()
	self.Entity:DrawModel()
	render.MaterialOverride("models/props_combine/tpballglow")
	local Pos = self:GetPos()
    local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	Ang:RotateAroundAxis(Ang:Right(), 90)
		
	cam.Start3D2D((Pos + Ang:Up() * 6)- Ang:Forward() * 23, Ang , 0.2)
        draw.WordBox(2, -5 * 0.5 + 58, -60, "Патроны", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		draw.WordBox(2, -5 * 0.5 + 58*1.85, -35, self:GetNWInt( "Ammo" ), "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
    cam.End3D2D()
	
	Ang:RotateAroundAxis(Ang:Right(), -180)
	cam.Start3D2D((Pos + Ang:Up() * 6)- Ang:Forward() * 23, Ang , 0.2)
        draw.WordBox(2, -5 * 0.5 + 58, -60, "Патроны", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		draw.WordBox(2, -5 * 0.5 + 58*1.85, -35, self:GetNWInt( "Ammo" ), "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
    cam.End3D2D()
end