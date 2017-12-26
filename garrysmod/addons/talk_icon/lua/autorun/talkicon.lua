
CreateConVar('talkicon_computablecolor', 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE, 'Compute color from location brightness.')
CreateConVar('talkicon_showtextchat', 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE, 'Show icon on using text chat.')
CreateConVar('talkicon_ignoreteamchat', 1, FCVAR_ARCHIVE + FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE, 'Disable over-head icon on using team chat.')

if (SERVER) then

	RunConsoleCommand('mp_show_voice_icons', '0')

	--[[for k=1,60 do
		local a = "0"..k
		if(k>10)then a = k end
		resource.AddFile('materials/istyping/istyping_'..a..'_00_00.png')
	end
	
	for k=1,45 do
		local a = "0"..k
		if(k>10)then a = k end
		resource.AddFile('materials/istalking/istalking_'..a..'_00_00.png')
	end]]--

	util.AddNetworkString('TalkIconChat')

	net.Receive('TalkIconChat', function(_, ply)
		local bool = net.ReadBool()
		ply:SetNW2Bool('ti_istyping', (bool ~= nil) and bool or false)
	end)

elseif (CLIENT) then

	local computecolor = GetConVar('talkicon_computablecolor')
	local showtextchat = GetConVar('talkicon_showtextchat')
	local noteamchat = GetConVar('talkicon_ignoreteamchat')
	local voice_mat = Material('istalking.vmt')
	local text_mat = Material('istalking.vmt')
	local addsempai = Material('addsempai.png')
	local sempai = Material('sempai.png')
	
	local text_array = {}
	local voice_array = {}
	
	for k=0,44 do
		local a = "0"..k
		if(k>=10)then a = k end
		local mat = Material('istalking/istalking_'..a..'_00_00.png')
		table.insert(voice_array,mat)
	end
	
	for k=0,59 do
		local a = "0"..k
		if(k>=10)then a = k end
		local mat = Material('istyping/istyping_'..a..'_00_00.png')
		table.insert(text_array,mat)
	end
	
	local i = 1
	local i2 = 1
	
	hook.Add('PostPlayerDraw', 'TalkIcon', function(ply)
		if(i>60)then i=1 end
		if(i2>45)then i2=1 end
		if ply == LocalPlayer() and GetViewEntity() == LocalPlayer()
			and (GetConVar('thirdperson') and GetConVar('thirdperson'):GetInt() != 0) then return end
		if not ply:Alive() then return end
		if not ply:IsSpeaking() and not (showtextchat:GetBool() and ply:GetNW2Bool('ti_istyping')) then return end

		local pos = ply:GetPos() + Vector(0, 0, ply:GetModelRadius() + 15)
		local attachment = ply:GetAttachment(ply:LookupAttachment('eyes'))
		if attachment then
			pos = ply:GetAttachment(ply:LookupAttachment('eyes')).Pos + Vector(0, 0, 25*ply:GetModelScale())
		end

		local color_var = 255

		if computecolor:GetBool() then
			local computed_color = render.ComputeLighting(ply:GetPos(), Vector(0, 0, 1))
			local max = math.max(computed_color.x, computed_color.y, computed_color.z)
			color_var = math.Clamp(max * 255 * 1.11, 0, 255)
		end
		i = i + 0.5
		if(ply:IsSpeaking())then
			i2 = i2 + 0.25
		end
		
		local ang = EyeAngles()--LocalPlayer():EyeAngles()
		ang:RotateAroundAxis( ang:Up(), -90 )
		--ang:RotateAroundAxis( ang:Right(), 90 )
		
		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 1 ) 
			surface.SetDrawColor( color_var, color_var, color_var, 255 )
			surface.SetMaterial( ply:IsSpeaking() and voice_array[math.floor(i2)] or text_array[math.floor(i)]	) -- If you use Material, cache it!
			surface.DrawTexturedRect( -6, -6 , 12, 12 )
		cam.End3D2D()
		
		--render.DrawSprite(pos, 12, 12, Color(color_var, color_var, color_var, 255))
	end)
	
	hook.Add('PostPlayerDraw', 'TalkIco2n', function(ply)

		local pos = ply:GetPos() + Vector(0, 0, ply:GetModelRadius() + 15)
		local attachment = ply:GetAttachment(ply:LookupAttachment('eyes'))
		if attachment then
			pos = ply:GetAttachment(ply:LookupAttachment('eyes')).Pos + Vector(0, 0, 25*ply:GetModelScale())
		end

		local color_var = 255

		if computecolor:GetBool() then
			local computed_color = render.ComputeLighting(ply:GetPos(), Vector(0, 0, 1))
			local max = math.max(computed_color.x, computed_color.y, computed_color.z)
			color_var = math.Clamp(max * 255 * 1.11, 0, 255)
		end
		
		local ang = EyeAngles()--LocalPlayer():EyeAngles()
		ang:RotateAroundAxis( ang:Up(), -90 )
		--ang:RotateAroundAxis( ang:Right(), 90 )
		
		cam.Start3D2D( pos, Angle( 0, ang.y, 90 ), 1 ) 
			surface.SetDrawColor( color_var, color_var, color_var, 255 )
			if(ply:GetNWBool("train_wait",false)!=false)then
				surface.SetMaterial( addsempai 	) -- If you use Material, cache it!
				surface.DrawTexturedRect( -6-5, -6+12 , 6, 6 )
			end
			if(ply:GetNWEntity("sempai") == LocalPlayer())then
				surface.SetMaterial( sempai	) -- If you use Material, cache it!
				surface.DrawTexturedRect( -6-5, -6+12 , 6, 6 )
			else
				if(LocalPlayer():GetNWEntity("sempai") == ply)then
					surface.SetMaterial( sempai	) -- If you use Material, cache it!
					surface.DrawTexturedRect( -6-5, -6+12 , 6, 6 )
				end
			end
		cam.End3D2D()
		
		--render.DrawSprite(pos, 12, 12, Color(color_var, color_var, color_var, 255))
	end)

	hook.Add('StartChat', 'TalkIcon', function(isteam)
		if isteam and noteamchat:GetBool() then return end
		net.Start('TalkIconChat')
			net.WriteBool(true)
		net.SendToServer()
	end)

	hook.Add('FinishChat', 'TalkIcon', function()
		net.Start('TalkIconChat')
			net.WriteBool(false)
		net.SendToServer()
	end)

	hook.Add("InitPostEntity", "RemoveChatBubble", function()
		hook.Remove("StartChat", "StartChatIndicator")
		hook.Remove("FinishChat", "EndChatIndicator")
	end)

end