include('shared.lua')

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/


function ENT:Initialize()
end

function ENT:Draw()
	self.Entity:DrawModel()
	render.MaterialOverride("models/props_combine/tpballglow")
	local Pos = self:GetPos()
    local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	
	cam.Start3D2D((Pos + Ang:Up() * 17)- Ang:Forward() * 32, Ang , 0.2)
        draw.WordBox(2, -5 * 0.5 + 50, -16, "Патроны", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		if(self.UnlimitedAmmo==false)then
			draw.WordBox(2, -5 * 0.5 + 50*3.5, -16, self:GetNWInt( "Ammo" ), "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		else
			draw.WordBox(2, -5 * 0.5 + 50*3.5, -16, "∞", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
		end
    cam.End3D2D()
end
