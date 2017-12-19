

local main = Material("s_serverhop/main.png", "noclamp smooth")
local b_frame = Material("s_serverhop/b1_frame.png", "noclamp smooth")
local b_n = Material("s_serverhop/b1_n.png", "noclamp smooth")
local b_h = Material("s_serverhop/b1_h.png", "noclamp smooth")
local row_n = Material("s_serverhop/table_row.png", "noclamp smooth")
local row_h = Material("s_serverhop/table_mouse_hover_row.png", "noclamp smooth")
local h_div = Material("s_serverhop/h_div.png", "noclamp smooth")
local v_div = Material("s_serverhop/v_divide.png", "noclamp smooth")



surface.CreateFont( "ServerHop14", {          
	font = "Laconic",
	weight = 400,
	bold = true,
	shadow = true,
	size = 18,
  })

surface.CreateFont( "ServerHop12", {          
	font = "Laconic",
	weight = 400,
	bold = true,
	shadow = true,
	size = 14,
  })

surface.CreateFont( "ServerHopTitle", {          
	font = "Laconic",
	weight = 400,
	bold = true,
	shadow = true,
	size = 24,
  })


local function ReturnValuePop(min, max)
	local pop = "Very Low"
	local math = min / max


	if math <= 0.25 then
		pop = "Low"
	elseif math > 0.25 and math <= 0.50 then
		pop = "Medium"
	elseif math > 0.50 and math <= 0.80 then
		pop = "High"
	elseif math > 0.80 and math <= 0.99 then
		pop = "High"
	elseif math == 1 then
		pop = "Very High"
	end

	return pop

end


net.Receive("SHOPOpenMenu", function()

	local tbl = net.ReadTable()


	local psel;

	local frame = vgui.Create("DFrame")
	frame:SetSize(540, 667)
	frame:Center()
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame:SetTitle("")
	frame.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(main)

		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

		draw.SimpleText("Server Connect", "ServerHopTitle", 120, 35, Color(255, 255, 255), 1, 1)
	end
	frame.select = nil

	local buttonpanel = vgui.Create("DPanel", frame)
	buttonpanel:SetSize(223, 51)
	buttonpanel:SetPos(frame:GetWide()/2+1 , 20)
	buttonpanel.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(b_frame)

		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())
	end

	local closebutton = vgui.Create("DButton", buttonpanel)
	closebutton:SetSize(102, 32)
	closebutton:SetPos(7, 10)
	closebutton.mat = b_n
	closebutton:SetText("")
	closebutton.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(me.mat)

		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

		draw.SimpleText("Close", "ServerHop14", me:GetWide()/2, 15, Color(255, 255, 255), 1, 1)

		
	end
	closebutton.OnCursorEntered = function(me)
		me.mat = b_h
		surface.PlaySound("UI/buttonrollover.wav")
	end
	closebutton.OnCursorExited = function(me)
		me.mat = b_n
	end
	function closebutton:DoClick()
		frame:Remove()
	end

	local connectbutton = vgui.Create("DButton", buttonpanel)
	connectbutton:SetSize(102, 32)
	connectbutton:SetPos(109, 10)
	connectbutton.mat = b_n
	connectbutton:SetText("")
	connectbutton.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(me.mat)

		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

		draw.SimpleText("Connect", "ServerHop14", me:GetWide()/2, 15, Color(255, 255, 255), 1, 1)
	end
	connectbutton.OnCursorEntered = function(me)
		me.mat = b_h
		surface.PlaySound("UI/buttonrollover.wav")
	end
	connectbutton.OnCursorExited = function(me)
		me.mat = b_n
	end
	connectbutton.DoClick = function()
		if frame.select then
			LocalPlayer():ConCommand("connect " .. frame.select)
		end
	end

	local infopanel = vgui.Create("DPanel", frame)
	infopanel:SetSize(490, 35)
	infopanel:SetPos(25, 100)
	infopanel.Paint = function(me)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(row_h)
		surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(h_div)
		surface.DrawTexturedRect(0, me:GetTall()-1, me:GetWide(), 1)
		surface.DrawTexturedRect(0, 0, me:GetWide(), 1)

		draw.SimpleText("Server Name", "ServerHop12", 50, 20, Color(255, 255, 255), 1, 1)

		draw.SimpleText("Gamemode", "ServerHop12", 200, 20, Color(255, 255, 255), 1, 1)

		draw.SimpleText("Player Count", "ServerHop12", 325, 20, Color(255, 255, 255), 1, 1)

		draw.SimpleText("Population Level", "ServerHop12", 425, 20, Color(255, 255, 255), 1, 1)
	end
	
	local DScrollPanel = vgui.Create( "DScrollPanel", frame )
	DScrollPanel:Dock( FILL )
	DScrollPanel:DockMargin(20, 115, 15, 40)

	for k,v in pairs(tbl) do
		local pop = ReturnValuePop(v[3], v[2])

		local DPanel = DScrollPanel:Add( "DPanel" )
		DPanel:SetSize(490, 35)
		DPanel:Dock( TOP )
		DPanel.Connect = v["ServerIP"] .. ":" .. v["Port"]
		DPanel.mat = row_n
		DPanel:DockMargin( 0, 0, 5, 5 )
		DPanel.Paint = function(me)
			surface.SetDrawColor(255, 255, 255, 255)
			surface.SetMaterial(me.mat)
			surface.DrawTexturedRect(0, 0, me:GetWide(), me:GetTall())

			draw.SimpleText(v["Name"], "ServerHop12", 65, 20, Color(255, 255, 255), 1, 1)


			draw.SimpleText(v[1], "ServerHop12", 200, 20, Color(255, 255, 255), 1, 1)

			draw.SimpleText(v[3].."/".. v[2], "ServerHop12", 325, 20, Color(255, 255, 255), 1, 1)

			draw.SimpleText(pop, "ServerHop12", 425, 20, Color(255, 255, 255), 1, 1)

			if psel == me then
				local Var = math.abs( math.sin( CurTime() * 1.5 ) )
				surface.SetDrawColor(Color(46, 204, 113, Var*255))
				surface.DrawOutlinedRect( 0, 0, me:GetWide(), me:GetTall())
			end
		end
		DPanel.OnCursorEntered = function(me)
			me.mat = row_h
		end
		DPanel.OnCursorExited = function(me)
			me.mat = row_n
		end
	
		local btnCon = vgui.Create("DButton", DPanel)
		btnCon:SetSize(490, 35)
		btnCon:Dock( TOP )
		btnCon.Selected = 0
		btnCon:SetText("")
		btnCon.Paint = function() end
		btnCon.OnCursorEntered = function(me)
			DPanel.mat = row_h
			surface.PlaySound("UI/buttonrollover.wav")
		end
		btnCon.OnCursorExited = function(me)
			DPanel.mat = row_n
		end
		btnCon.DoClick = function()
			surface.PlaySound("UI/buttonclick.wav")
			btnCon.Selected = DPanel.Connect
			frame.select = btnCon.Selected
			psel = DPanel
		end

	end
end)