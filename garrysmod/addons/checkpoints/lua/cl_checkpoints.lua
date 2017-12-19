local raceCheckpoints = {}
local currentCheckpoint = 1
local raceFinished = false
local lastCheck = 0

local z = 0
local up = true
local smooth = 0

--derma vars
local selectedPlayers = {}
local selectedCheckpoints = {}
local selectedStartpoint = {}
--
net.Receive("sendRaceCheckpoints",function (  )
	raceCheckpoints = net.ReadTable()
	if(#raceCheckpoints > 0) then
		for i=1, #raceCheckpoints do
			for b=1, #raceCheckpoints[i] do
			end
		end
	end
end)
hook.Add("Tick","checkCheckpointPos",function (  )
	if(#raceCheckpoints > 0) then
		if not raceFinished then
			if LocalPlayer():GetPos():Distance(raceCheckpoints[currentCheckpoint]['pos']) < 100 then
				if lastCheck < CurTime() then
					net.Start("checkCheckpoint")
					net.SendToServer()
					lastCheck = CurTime() + 0.5
				end
			end
		end
	end
end)

hook.Add("PostDrawOpaqueRenderables","drawCheckpoints",function (  )

	if up then
		smooth = math.Approach(smooth, 20, 10*FrameTime())
	else
		smooth = math.Approach(smooth, -20, 10*FrameTime())
	end
	if smooth >= 20 then
		up = false
	elseif smooth <= 0 then
		up = true
	end

	local ang = LocalPlayer():EyeAngles()
	 
	 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	local a = Angle(0,0,0)
	a:RotateAroundAxis(Vector(1,0,0),90)
	a.y = LocalPlayer():GetAngles().y - 90

	
	--print("Checkpoints: "..#raceCheckpoints)
	--print(aceFinished)
	if(#raceCheckpoints > 0) then
		if raceFinished==false then
		--for i=1, #raceCheckpoints do
			cam.Start3D2D(raceCheckpoints[currentCheckpoint]['pos'],Angle(0,0,0),1)
				drawCheckpoint()
			cam.End3D2D()

			cam.Start3D2D(Vector(raceCheckpoints[currentCheckpoint]['pos'].x, raceCheckpoints[currentCheckpoint]['pos'].y,raceCheckpoints[currentCheckpoint]['pos'].z+smooth),Angle(0,ang.y,90),1)
				drawCheckpointArrow()
			cam.End3D2D()
		--end
		end
	end

	if(#selectedCheckpoints > 0) then

		for i=1, #selectedCheckpoints do
			cam.Start3D2D(selectedCheckpoints[i],Angle(0,0,0),1)
				drawCheckpoint()
			cam.End3D2D()
			cam.Start3D2D(Vector(selectedCheckpoints[i].x, selectedCheckpoints[i].y,selectedCheckpoints[i].z+smooth),Angle(0,ang.y,90),1)
				drawCheckpointArrow()
			cam.End3D2D()
		end
	end
	
end)

net.Receive("currentCheckpoint",function (  )
	
	currentCheckpoint = net.ReadInt(32)
	if currentCheckpoint > #raceCheckpoints then
		raceFinished = true
	else
		raceFinished = false 
	end

end)
function Ply(name)
	name = string.lower(name);
	for _,v in ipairs(player.GetHumans()) do
		if(string.find(string.lower(v:Name()),name,1,true) != nil)
			then return v;
		end
	end
end
/*
function openGui(  )
	if not LocalPlayer():IsAdmin() then print("Not admin") return end
	local Frame = vgui.Create( "DFrame" )
	
	Frame:SetSize( 500, 500 )
	Frame:SetPos( ScrW()/2-Frame:GetWide()/2, ScrH()/2-Frame:GetTall()/2 )
	Frame:SetTitle( "Race configurator" )
	Frame:SetVisible( true )
	Frame:SetDraggable( false )
	Frame:ShowCloseButton( true )
	function Frame:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, 500, 25, Color( 0, 0, 0,200 ) )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 0, 0, 0,180 ) )
		draw.SimpleText("Players to add to race: ","Trebuchet24",125,25,Color(0,255,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
		draw.SimpleText("Checkpoints in race: ","Trebuchet24",125,250,Color(0,255,0,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_TOP)
	end
	

	local PlayerList = vgui.Create("DListView",Frame)
	PlayerList:SetPos(2,50)
	PlayerList:SetSize(250,250-50-2)
	PlayerList:SetMultiSelect(true)
	PlayerList:AddColumn("Name")
	
	function PlayerList:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255,255 ) )
	end
	for k,v in pairs(player.GetAll()) do
		PlayerList:AddLine(v:Nick()) -- Add lines
	end

	local Positions = vgui.Create("DListView",Frame)
	Positions:SetPos(2,275)
	Positions:SetSize(250,250-50-2)
	Positions:SetMultiSelect(true)
	Positions:AddColumn("Position")
	function Positions:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255,255 ) )
	end
	if #selectedCheckpoints > 0 then
		for i=1, #selectedCheckpoints do
			Positions:AddLine(selectedCheckpoints[i])
		end
	end
	local DermaButton = vgui.Create( "DButton", Frame ) // Create the button and parent it to the frame
	DermaButton:SetText( "Add checkpoint" )					// Set the text on the button
	DermaButton:SetPos( 2, 500-25 )					// Set the position on the frame
	DermaButton:SetSize( 123, 23 )					// Set the size
	DermaButton.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
		table.insert(selectedCheckpoints,LocalPlayer():GetPos())
		Positions:AddLine(LocalPlayer():GetPos())
	end
	function DermaButton:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 150, 255, 150,255 ) )
	end
	local ButtonRemoveCheckpoints = vgui.Create( "DButton", Frame ) // Create the button and parent it to the frame
	ButtonRemoveCheckpoints:SetText( "Remove checkpoints" )					// Set the text on the button
	ButtonRemoveCheckpoints:SetPos( 125, 500-25 )					// Set the position on the frame
	ButtonRemoveCheckpoints:SetSize( 123, 23 )					// Set the size
	ButtonRemoveCheckpoints.DoClick = function()				// A custom function run when clicked ( note the . instead of : )
		table.Empty(selectedCheckpoints)
		Positions:Clear()
	end
	function ButtonRemoveCheckpoints:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 150, 150,255 ) )
	end

	local ButtonStartRace = vgui.Create( "DButton", Frame )
	ButtonStartRace:SetText( "Start Race" )
	ButtonStartRace:SetPos( 300, 500-25 )
	ButtonStartRace:SetSize( 150-5, 23 )
	ButtonStartRace.DoClick = function()				

	local lines = PlayerList:GetSelected()

	for _, line in pairs( lines ) do
	    table.insert(selectedPlayers,Ply(line:GetColumnText(1)))
	end
	
		if #selectedPlayers==0 then LocalPlayer():PrintMessage(HUD_PRINTTALK,"No players were selected!") return end
		if #selectedStartpoint==0 then LocalPlayer():PrintMessage(HUD_PRINTTALK,"No startpoint was selected!") return end
		if #selectedCheckpoints==0 then LocalPlayer():PrintMessage(HUD_PRINTTALK,"No checkpoints were selected!") return end

		net.Start("createRace")
			net.WriteTable(selectedPlayers)
			net.WriteTable(selectedCheckpoints)
			net.WriteString("Race #1")
			net.WriteVector(selectedStartpoint[1])
		net.SendToServer()
		Frame:Close()
		selectedCheckpoints = {}
		selectedPlayers = {}
	end
	function ButtonStartRace:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 150, 255, 150,255 ) )
	end


	local StartPoint = vgui.Create("DListView",Frame)
	StartPoint:SetPos(254,50)
	StartPoint:SetSize(250-8,35)
	StartPoint:SetMultiSelect(false)
	StartPoint:AddColumn("Pos")
	StartPoint.OnRowRightClick = function (  )
	local lines = StartPoint:GetSelected()
		for _, line in pairs( lines ) do

		    net.Start("tptostartpoint")
		    	net.WriteVector(line:GetColumnText(1))
		    net.SendToServer()
		end
	end
	if #selectedStartpoint > 0 then
		for i=1, #selectedStartpoint do
			StartPoint:AddLine(selectedStartpoint[i])
		end
	end

	function StartPoint:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 255, 255, 255,255 ) )
	end

	local ButtonStartpoint = vgui.Create( "DButton", Frame )
	ButtonStartpoint:SetText( "Set StartPoint" )
	ButtonStartpoint:SetPos( 300, 87 )
	ButtonStartpoint:SetSize( 150-5, 23 )
	ButtonStartpoint.DoClick = function()
		StartPoint:Clear()
		table.Empty(selectedStartpoint)
		StartPoint:AddLine(LocalPlayer():GetPos())
		table.insert(selectedStartpoint,LocalPlayer():GetPos())		
	end

	function ButtonStartpoint:Paint( w, h )
		draw.RoundedBox( 8, 0, 0, w, h, Color( 150, 255, 150,255 ) )

	end



	Frame:MakePopup()

end*/
net.Receive("openRaceSystem",function (  )
	openGui()
end)
local triangle = {
	{ x = 0, y = -10 },
	{ x = -20, y = -70 },
	{ x = 20, y = -70 },


}
function drawCheckpoint(  )
	surface.SetDrawColor(255,0,0,255)
	surface.DrawCircle( 0, 0, 20,Color(255,255,255,255))

end

function drawCheckpointArrow(  )
	surface.SetDrawColor(255,51,51,120)
	draw.NoTexture()
	surface.DrawRect( -5, -70, 10, 60 )
end



concommand.Add( "race", function( ply, cmd, args )
	local a = args[1]
	if(a!=nil)then
		for k,v in pairs(PreRaces) do
			if(PreRaces[a]!=nil)then
				MakeMyRace(ply,a)
				break
			end
		end
	end
end )

function MakeMyRace(ply,a)
	local positions = PreRaces[a].pos
	net.Start("createRace")
		net.WriteTable({ply})
		net.WriteTable(positions)
		net.WriteString(CurTime()+math.random( 100, 4000 ) )
		net.WriteVector(PreRaces[a].spawn)
	net.SendToServer()
end

function removeRace ()
	net.Start("removeRace")
	net.SendToServer()
end

PreRaces = {
	["venator1"]={ 
		spawn = Vector(-733.354858, 124.577042, -367.968750),
		pos = {
			Vector(-225.999084, -893.152466, -431.968750),
			Vector(-264.096863, -1331.950317, -431.968750),
			Vector(593.769409, -1355.023193, -437.437592),
			Vector(3592.942871, -1344.427490, -687.390015),
			Vector(4027.288574, -1209.854370, -687.968750),
			Vector(4033.654297, 0.514900, -687.968750),
			Vector(4030.939453, 1100.725342, -687.968750),
			Vector(3884.086914, 1343.038818, -687.968750),
			Vector(1855.397949, 1343.617798, -542.596985),
			Vector(-772.139221, 1342.833984, -431.968750),
			Vector(-3724.320557, 1333.724487, -239.968750),
			Vector(-3712.868408, -280.002289, -239.968750),
			Vector(-3687.333740, -1332.840576, -239.968750),
			Vector(-2313.570068, -1345.672729, -246.036224),
			Vector(-312.671509, -1350.510986, -431.968750),
			Vector(-257.144379, -465.766388, -431.968750),
		}
	},
	["venator2"]={ 
		spawn = Vector(5707.540527, 3.097362, -175.968750),
		pos = {
			Vector(5366.245605, -139.541092, -175.968750),
			Vector(5312.303223, -555.440979, -127.968750),
			Vector(5296.305664, -2045.948730, -127.968750),
			Vector(3962.232422, -2085.105713, -127.968750),
			Vector(3897.492432, -597.396240, -127.968750),
			Vector(5304.548340, -542.279968, -127.968750),
			Vector(5707.337891, 3.916607, -175.968750),
			Vector(5374.811523, 138.569519, -175.968750),
			Vector(5294.573242, 589.675903, -127.968750),
			Vector(5311.611328, 2032.842896, -127.968750),
			Vector(3883.748047, 2091.680908, -127.968750),
			Vector(3940.258545, 720.009094, -127.968750),
			Vector(5293.310059, 536.732788, -127.968750),
			Vector(5731.342773, -2.257371, -175.968750),
			Vector(4855.189941, -3.276406, -31.968750),
			Vector(3610.591797, -14.658297, 96.031250),
			Vector(3391.686035, 1198.639404, 96.031250),
			Vector(277.277557, 1060.674561, 96.031250),
			Vector(-266.908997, 315.707794, 96.031250),
			Vector(-3461.099121, 310.862427, 96.031250),
			Vector(-6867.254883, 320.564728, 96.031250),
			Vector(-8034.725586, -9.330488, 96.031250),
			Vector(-6343.780762, -348.067749, 96.031250),
			Vector(-2750.225342, -314.236755, 96.031250),
			Vector(148.787827, -391.419495, 96.031250),
			Vector(3436.992920, -1137.520874, 96.031250),
			Vector(3611.615723, -5.582922, 96.031250),
			Vector(5703.734375, -4.867967, -175.968750),
		}
	},
	["pilots"]={ 
		spawn = Vector(5303.625977, 556.990051, -127.968750),
		pos = {
			Vector(4602.992188, 2894.921143, 133.273636),
			Vector(3918.670166, 4165.373535, 555.556274),
			Vector(2056.528809, 5633.462402, 997.891846),
			Vector(72.036896, 5472.601074, 1179.129272),
			Vector(-1085.030518, 3911.119141, 1296.631470),
			Vector(-2076.631592, 1758.099976, 1556.844971),
			Vector(-2817.915283, -108.465363, 1797.393677),
			Vector(-2805.915527, -2478.293457, 1577.463745),
			Vector(-2295.590332, -4214.426270, 410.172546),
			Vector(-468.031586, -3289.906494, -828.064575),
			Vector(1186.272583, -1309.962036, -1453.159180),
			Vector(2516.779785, 717.488464, -1633.952393),
			Vector(3075.418457, 2344.184082, -1130.152710),
			Vector(4038.340576, 3667.498779, -77.012390),
			Vector(6114.179688, 3614.843506, 1641.541992),
			Vector(7860.383301, 2061.115967, 3170.993652),
			Vector(9994.971680, 1216.855103, 3720.381836),
			Vector(11256.840820, -679.264465, 2787.646729),
			Vector(11888.692383, -1879.218872, 1582.448853),
			Vector(12152.077148, -3628.050537, -612.683044),
			Vector(10116.766602, -2617.196289, -2071.128418),
			Vector(7721.117676, -189.107208, -2347.769775),
			Vector(5599.227051, 2154.284180, -1575.621216),
			Vector(4305.139648, 3816.148438, -413.652771),
		}
	},
	["bridge"]={ 
		spawn = Vector(7439.910645, -272.921356, 4160.031250),
		pos = {
			Vector(8121.668457, -322.307343, 4160.031250),
			Vector(8627.904297, -138.489822, 4160.031250),
			Vector(5704.958008, -7.564751, 624.031250),
			Vector(5154.706543, -22.014389, 624.031250),
			Vector(4860.949707, -157.805786, 548.031250),
			Vector(4292.853027, -280.132141, 512.031250),
			Vector(4286.129883, -558.099121, 512.031250),
			Vector(4292.853027, -280.132141, 512.031250),
			Vector(4879.653809, -150.607422, 548.031250),
			Vector(5113.095703, -148.366867, 624.031250),
			Vector(5113.418457, 30.780954, 624.031250),
			Vector(4884.574219, 174.081238, 548.031250),
			Vector(4289.498535, 282.977661, 512.031250),
			Vector(4286.010254, 554.388733, 512.031250),
			Vector(4289.498535, 282.977661, 512.031250),
			Vector(4844.931152, 168.006485, 548.031250),
			Vector(5105.192871, 123.323845, 624.031250),
			Vector(5059.202637, -3.164846, 624.031250),
			Vector(4127.200684, 3.933766, 624.031250),
			Vector(3595.126953, 200.437027, 624.031250),
			Vector(3397.922607, -22.906799, 624.031250),
			Vector(3623.390137, -191.499481, 624.031250),
			Vector(3997.134766, -2.920108, 624.031250),
			Vector(5685.471680, -4.422629, 624.031250),
		}
	},
	["enj"]={ 
		spawn = Vector(6862.958496, 426.776245, -175.968750),
		pos = {
			Vector(6769.098633, 134.620163, -175.968750),
			Vector(6454.615234, 0.175242, -175.968750),
			Vector(6149.375977, 1.924650, -175.968750),
			Vector(5933.277832, 0.478614, -175.968750),
			Vector(5360.133789, -8.058502, -121.992813),
			Vector(4627.844727, 5.376535, -31.968750),
			Vector(3625.541016, -0.227099, 96.031250),
			Vector(2940.352539, 1718.748291, 96.031250),
			Vector(3613.592041, 7.962414, 96.031250),
			Vector(4551.544434, 3.696755, -20.686859),
			Vector(5772.588867, 102.597443, -175.968750),
			Vector(5747.263672, 1059.616333, -175.968750),
			Vector(5539.732910, 1406.940796, -687.968750),
			Vector(5101.570313, 1285.053955, -687.968750),
			Vector(5543.470703, 1378.454956, -687.968750),
			Vector(5760.670898, 1174.602417, 624.031250),
			Vector(5754.723145, 109.395988, 624.031250),
			Vector(5657.014160, -131.224304, 624.031250),
			Vector(8649.069336, -147.093155, 4160.031250),
			Vector(8208.908203, -311.468292, 4160.031250),
			Vector(7387.539551, -274.048279, 4160.031250),
			Vector(7033.818848, -328.200317, 4160.031250),
		}
	},
}

