
local boxes = {}
local send = false

net.Receive("sendboxes",function()
	boxes = {}
	local n = tonumber(net.ReadString())
	for k=1,n do
		local data = {}
		data["start"] = net.ReadVector()
		data["end"] = net.ReadVector()
		table.insert(boxes,data)
	end
	send = true
end)

local function onThink2()
	if(send)then
		for k,v in pairs(boxes)do

			debugoverlay.Box( v["start"], Vector(0,0,0), v["end"]-v["start"], 0.01, Color( 0, 0, 255,1 ) )
		end
	end
end
hook.Add( "Think", "Ever_DrawBoxes", onThink2 )

concommand.Add("disableboxes",function( ply, cmd, args )
	send = false
end)