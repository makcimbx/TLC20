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
	Ang:RotateAroundAxis(Ang:Up(), 90)
	
	cam.Start3D2D((Pos + Ang:Up() * 17)- Ang:Forward() * 32, Ang , 0.2)
        draw.WordBox(2, -5 * 0.5 + 110, -16, "Оружие", "HUDNumber5", Color(0, 0, 0, 0), Color(255, 255, 255, 255))
    cam.End3D2D()
end