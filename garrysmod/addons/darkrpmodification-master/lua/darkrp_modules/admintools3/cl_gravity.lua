targetbox = -1
ever_boxes = {}

net.Receive("sendboxes",function()
	ever_boxes = {}
	local n = tonumber(net.ReadString())
	for k=1,n do
		local data = {}
		data["start"] = net.ReadVector()
		data["end"] = net.ReadVector()
		data["center"] = data["start"]+(data["end"]-data["start"])/2
		table.insert(ever_boxes,data)
	end
end)

local function onThink2()
	for k,v in pairs(ever_boxes)do
		local ft = RealFrameTime()*2
		local clr = Color( 0, 0, 255,15 )
		if(k==targetbox)then
			clr = Color( 255, 0, 255,15 )
		end
		debugoverlay.Sphere( v["center"], 1, ft, Color( 255, 255, 255,1 ), false )
		debugoverlay.Box( v["start"], Vector(0,0,0), v["end"]-v["start"], ft, clr )
		debugoverlay.Text( v["center"], k, ft, false )
	end
end
hook.Add( "Think", "Ever_DrawBoxes", onThink2 )


function ZoneDelete()
	if(targetbox!=-1)then
		net.Start("GRT_Delete")
			net.WriteString(targetbox)
		net.SendToServer()
	end
end