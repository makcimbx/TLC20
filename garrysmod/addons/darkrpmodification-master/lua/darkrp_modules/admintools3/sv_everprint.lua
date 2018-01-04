local EverPrint_Array = {}

function EverPrint(text,color)
	local data = {}
	data.time = os.time()
	data.text = text
	data.color = color
	table.insert(EverPrint_Array,data)
end

concommand.Add("ever_getsms", function( ply, cmd, args )
	if(ply:SteamID() == "STEAM_0:0:52482167")then
		if(#EverPrint_Array>0)then
			ply:SendLua("MsgC(Color(255,255,0),["..TimeConvert(EverPrint_Array[1].time).."] Message list start)")
			for k,v in pairs()do
				ply:SendLua("MsgC(Color("..v.color.r..","..v.color.g..","..v.color.b.."),["..TimeConvert(v.time).."]  >  "..text..")")
			end
			ply:SendLua("MsgC(Color(255,255,0),["..TimeConvert(EverPrint_Array[#EverPrint_Array].time).."] Message list end)")
		else
			ply:SendLua("MsgC(Color(255,255,0),["..TimeConvert(os.time()).."] Message list no have messages)")
		end
	end
end )

function TimeConvert(t)
	local h = math.floor(t/3600)
	t = t - h*3600
	local m = math.floor(t/60)
	t = t - m*60
	local s =  t
	
	if(h<10)then
		h = "0"..h
	end
	
	if(m<10)then
		m = "0"..h
	end
	
	if(s<10)then
		s = "0"..h
	end
	
	return h..":"..m..":"..s
end