TOOL.Category           = "Ever Tools"
TOOL.Name               = "Gravity"
TOOL.Command            = nil
TOOL.ConfigName         = ""

TOOL.firstpos = nil
TOOL.twopos = nil

function TOOL:Holster()

	RunConsoleCommand( "developer", "0" )

end

function TOOL:Deploy()

	RunConsoleCommand( "developer", "1" )

end

function TOOL:Reload(trace)
	if(SERVER)then return true end
	self.firstpos = nil
	self.twopos = nil
    return true
end

function TOOL:RightClick(trace)
	if(SERVER)then return true end
	net.Start("GRT_Save")
		net.WriteVector(self.firstpos)
		net.WriteVector(self.twopos)
	net.SendToServer()
    return true
end

function TOOL:LeftClick(trace)
	if(SERVER)then return true end
    if(self.firstpos==nil)then
		self.firstpos = trace.HitPos
	else
		self.twopos = trace.HitPos
	end
    return true
end

function TOOL:Think()
	if(SERVER)then return true end
    if(self.firstpos!=nil)then
		debugoverlay.Sphere( self.firstpos, 5, 0.01, Color( 0, 255, 0,10 ), false )
	end
	
    if(self.twopos!=nil)then
		debugoverlay.Sphere( self.twopos, 5, 0.01, Color( 255, 0, 0,10 ), false )
	end
	
    if(self.firstpos!=nil and self.twopos!=nil)then
		debugoverlay.Box( self.firstpos, Vector(0,0,0), self.twopos-self.firstpos, 0.01, Color( 0, 0, 255,10 ) )
	end
	
end

if CLIENT then
    language.Add( "Tool.ever.name", "Создавай зоны с гравитацией!" )
    language.Add( "Tool.ever.desc", "Создание гравитационных зон" )
    language.Add( "Tool.ever.0", "Левый клик: добавить первую точку.")
    language.Add( "Tool.ever.1", "Левый клик: добавить следующую точку.")
    language.Add( "Tool.ever.2", "Правый клик: сохранить зону.")
    language.Add( "Tool.ever.3", "R: сбросить.")
end
