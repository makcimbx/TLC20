TOOL.Category           = "Ever Tools"
TOOL.Name               = "Gravity"
TOOL.Command            = nil
TOOL.ConfigName         = ""

TOOL.firstpos = nil
TOOL.twopos = nil

if(CLIENT)then
	concommand.Add("f_addV",function( ply, cmd, args )
		local tool = ply:GetTool()
		if(#args!=4 or tool.Name != "Gravity")then return end
		if(args[1]=="1")then
			if(tool.firstpos!=nil)then
				tool.firstpos = tool.firstpos + Vector(tonumber(args[2]),tonumber(args[3]),tonumber(args[4]))
			end
		else
			if(args[1]=="2")then
				if(tool.twopos!=nil)then
					tool.twopos = tool.twopos + Vector(tonumber(args[2]),tonumber(args[3]),tonumber(args[4]))
				end
			end
		end
	end)
end

function TOOL:Holster()
	if(SERVER)then return true end
	RunConsoleCommand( "developer", "0" )

end

function TOOL:Deploy()
	if(SERVER)then return true end
	RunConsoleCommand( "developer", "1" )
end

local c1 = 0
function TOOL:Reload(trace)
	if(SERVER)then return true end
	if(input.IsButtonDown( KEY_E ))then
		if(c1<=CurTime())then
			ZoneDelete()
			c1 = CurTime()+5
		end
		return true
	end
	self.firstpos = nil
	self.twopos = nil
    return true
end

local c = 0

function TOOL:RightClick(trace)
	if(SERVER or c>CurTime())then return true end
	c = CurTime()+5
	if(input.IsButtonDown( KEY_E ))then
		RunConsoleCommand("getboxes")
		return true
	end
	if(self.firstpos!=nil and self.twopos!=nil)then
		net.Start("GRT_Save")
			net.WriteVector(self.firstpos)
			net.WriteVector(self.twopos)
		net.SendToServer()
	end
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
	local ft = RealFrameTime()*2
    if(self.firstpos!=nil)then
		debugoverlay.Sphere( self.firstpos, 5, ft, Color( 0, 255, 0,10 ), false )
		debugoverlay.Text( self.firstpos, "1*", ft, false )
	end
	
    if(self.twopos!=nil)then
		debugoverlay.Sphere( self.twopos, 5, ft, Color( 255, 0, 0,10 ), false )
		debugoverlay.Text( self.twopos, "2*", ft, false )
	end
	
    if(self.firstpos!=nil and self.twopos!=nil)then
		debugoverlay.Sphere( self.firstpos+(self.twopos-self.firstpos)/2, 1, ft, Color( 255, 255, 255,1 ), false )
		debugoverlay.Box( self.firstpos, Vector(0,0,0), self.twopos-self.firstpos, ft, Color( 0, 0, 255,0 ) )
		
		debugoverlay.Line( self.firstpos, Vector(self.twopos.x,self.twopos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.firstpos.x,self.twopos.y,self.firstpos.z), Vector(self.twopos.x,self.firstpos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		
		debugoverlay.Line( Vector(self.firstpos.x,self.twopos.y,self.twopos.z), Vector(self.firstpos.x,self.firstpos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.firstpos.x,self.twopos.y,self.firstpos.z), Vector(self.firstpos.x,self.firstpos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )
		
		debugoverlay.Line( Vector(self.twopos.x,self.firstpos.y,self.twopos.z), Vector(self.twopos.x,self.twopos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.twopos.x,self.firstpos.y,self.firstpos.z), Vector(self.twopos.x,self.twopos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )
		
		debugoverlay.Line( Vector(self.twopos.x,self.firstpos.y,self.twopos.z), Vector(self.firstpos.x,self.firstpos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.twopos.x,self.firstpos.y,self.firstpos.z), Vector(self.firstpos.x,self.firstpos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )
		
		debugoverlay.Line( Vector(self.twopos.x,self.twopos.y,self.firstpos.z), Vector(self.firstpos.x,self.twopos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.twopos.x,self.twopos.y,self.twopos.z), Vector(self.firstpos.x,self.twopos.y,self.firstpos.z), ft, Color( 0, 0, 255,10 ), false )
		
		debugoverlay.Line( self.twopos, Vector(self.firstpos.x,self.firstpos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )
		debugoverlay.Line( Vector(self.twopos.x,self.firstpos.y,self.twopos.z), Vector(self.firstpos.x,self.twopos.y,self.twopos.z), ft, Color( 0, 0, 255,10 ), false )

	end
	
	if(#ever_boxes!=0)then
		local distances = {}
		local distances2 = {}
		for k,v in pairs(ever_boxes)do
			local sc = nil
			cam.Start3D()
				sc = v["center"]:ToScreen()
			cam.End3D()
			if(sc.visible==false)then
				table.insert(distances, 99999999999999)
				distances2[99999999999999] = v["center"]
			else
				local d = math.Distance( sc.x, sc.y, ScrW()/2, ScrH()/2 )
				table.insert(distances, d)
				distances2[d]= {}
				distances2[d].v = v["center"]
				distances2[d].id = k
				distances2[d].vis = sc.visible
			end
		end
		local mind =  math.min( unpack(distances) )
		local v = distances2[mind]
		targetbox = v.id
		if(v.vis==true)then
			debugoverlay.Sphere( v.v, 5, ft, Color( 255, 0, 255,1 ), true )
		end
	end
	
end

if CLIENT then
	
	TOOL.Information = {
		{ name = "left" },
		{ name = "left" },
		{ name = "right" },
		{ name = "reload" },
		{ name = "reload_use" },
		{ name = "right_use" }
	}

	language.Add( "tool.ever", "Создавай зоны с гравитацией!" )
	language.Add( "tool.ever.name", "Создавай зоны с гравитацией!" )
	language.Add( "tool.ever.desc", "Создание гравитационных зон" )
	language.Add( "tool.ever.0", "Добавить первую точку" ) -- Not sure why I keep this
	language.Add( "tool.ever.left", "Добавить вторую точку" )
	language.Add( "tool.ever.right", "Сохранить зону" )
	language.Add( "tool.ever.reload", "Сбросить" )
	language.Add( "tool.ever.right_use", "Загрузить зоны" )
	language.Add( "tool.ever.reload_use", "Удалить зону" )

end
