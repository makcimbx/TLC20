local sentences = ConfigurationMedicMod.Sentences
local lang = ConfigurationMedicMod.Language

local function CreateCloseButton( Parent, Panel, color, sx, sy, back, backcolor)
	
	Parent = Parent or ""
	sx = sx or 50
	sy = sy or 20
	color = color or Color(255,255,255,255)
	back = back or false
	backcolor = backcolor or false

	local x,y  = Parent:GetSize()
	
	local CloseButton = vgui.Create("DButton", Parent)
		CloseButton:SetPos(x-sx, 0)
		CloseButton:SetSize(sx,sy)
		CloseButton:SetFont("Trebuchet24")
		CloseButton:SetTextColor( color )
		CloseButton:SetText("X")
		function CloseButton:DoClick()
			Panel:Close()
		end
		CloseButton.Paint = function(s , w , h)
			if back then
				draw.RoundedBox(0,0,0,w , h,backcolor)
			end
		end
		
	return CloseButton
	
end

local function CreateButton( Parent, text, font, colorText, px, py, sx, sy, func, back, backcolor, backcolorbar, sound)
	
	Parent = Parent or ""
	font = font or "Trebuchet18"
	text = text or ""
	px = px or 0
	py = py or 0
	sx = sx or 50
	sound = sound or true
	func = func or function() end
	sy = sy or 50
	colorText = colorText or Color(255,255,255,255)
	back = back or true
	backcolor = backcolor or Color( 0, 100 , 150 )
	backcolorbar = backcolorbar or Color( 0 , 80 , 120 )

	local Button = vgui.Create("DButton", Parent)
		Button:SetPos( px , py )
		Button:SetSize(sx,sy)
		Button:SetFont("Trebuchet24")
		Button:SetTextColor( colorText )
		Button:SetText(text)
		function Button:DoClick()
			func()
			if sound then
				surface.PlaySound( "UI/buttonclick.wav" )
			end
		end
		
		if sound then
			function Button:OnCursorEntered()
				surface.PlaySound( "UI/buttonrollover.wav" )
			end
		end
		
		Button.Paint = function(s , w , h)
			if back then
				if Button:IsHovered() then
					draw.RoundedBox(0,0,0,w , h, Color( backcolor.r + 30, backcolor.g + 30, backcolor.b + 30 ))
					draw.RoundedBox(0,0,h-sy/10,sx , sy/10, Color( backcolorbar.r + 30, backcolorbar.g + 30, backcolorbar.b + 30  ))
				else
					draw.RoundedBox(0,0,0,w , h, backcolor)
					draw.RoundedBox(0,0,h-sy/10,sx , sy/10, backcolorbar)
				end
			end
		end
		
	return Button
	
end

local function CreatePanel( Parent, sx, sy, posx, posy, backcolor, scroll, bar, grip, btn)
	
	Parent = Parent or ""
	sx = sx or 100
	sy = sy or 100
	backcolor = backcolor or Color(35, 35, 35, 255)
	posx = posx or 0
	posy = posy or 0
	scroll = scroll or false
	bar = bar or Color( 30, 30, 30 )
	grip = grip or Color( 0, 140, 208 )
	btn = btn or Color( 4,95,164 )
	
	local typ = "DPanel"
	if scroll then
		typ = "DScrollPanel"
	else
		typ = "DPanel"
	end
	
	local Panel = vgui.Create(typ, Parent)
		Panel:SetSize(sx,sy)
		Panel:SetPos(posx,posy)
		Panel.Paint = function(s , w , h)
			draw.RoundedBox(0,0,0,w , h, backcolor)
		end
		
	if typ == "DScrollPanel" then
	
		local sbar = Panel:GetVBar()
	
		function sbar:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, bar )
		end
		
		function sbar.btnUp:Paint( w, h )
			draw.SimpleText( "?", "Trebuchet24", -3, -4, btn )
		end
		
		function sbar.btnDown:Paint( w, h )
			draw.SimpleText( "?", "Trebuchet24", -3, -4, btn )
		end
		
		function sbar.btnGrip:Paint( w, h )
			draw.RoundedBox( 8, 0, 0, w, h, grip )
		end
	end
		
	return Panel
	
end

local function CreateLabel( Parent, font, text, sx, sy, posx, posy, color, time)
	
	Parent = Parent or ""
	font = font or "Trebuchet24"
	text = text or ""
	sx = sx or 100
	sy = sy or 100
	posx = posx or 0
	posy = posy or 0
	color = color or Color(255,255,255,255)
	time = time or 0

	local EndTime = CurTime() + time
	local SizeString = string.len( text )
	
	local Label = vgui.Create("DLabel", Parent)
		Label:SetPos( posx, posy )
		Label:SetSize( sx,sy )
		if time == 0 then
			Label:SetText( text )
		else
			Label:SetText( "" )
		end
		Label:SetWrap( true )
		Label:SetTextColor(color)
		Label:SetFont(font)
	
		Label.Think = function()
			
			if Label:GetText() == text then
				return
			end
			
			local TimeLeft = EndTime - CurTime()
			local StringSizeP1 = ( TimeLeft / ( time / 100 ) ) / 100
			local StringSize = 1 - StringSizeP1

			Label:SetText( string.sub(text, 0, SizeString * StringSize ))
			
		end
		
	return Label
	
end


local SizeX = 400
local SizeY = 250

net.Receive("MedicMod.MedicMenu", function()
	
	local ent = net.ReadEntity()
	local fract = net.ReadTable()
	
	local FramePrincipal = vgui.Create( "DFrame" )
		FramePrincipal:SetSize( SizeX, SizeY )
		FramePrincipal:SetPos( ScrW()/2 - SizeX/2, ScrH()/2 - SizeY/2 )
		FramePrincipal:SetTitle( "Panel" )
		FramePrincipal:SetDraggable( false )
		FramePrincipal:ShowCloseButton( false )
		FramePrincipal:MakePopup()
		FramePrincipal.Paint = function(s , w , h)
		end
	
	local boxTitle = CreatePanel( FramePrincipal, SizeX, 20, 0, 0, Color(0, 140, 208, 255), false )
	
	local CloseButton = CreateCloseButton( boxTitle, FramePrincipal )
	
	local LabelTitle = CreateLabel( boxTitle, "Trebuchet24", "Medecin", SizeX-40, 20, 50, 0, nil, 0)

	local boxContent = CreatePanel( FramePrincipal, SizeX, SizeY-20, 0, 20, Color(35, 35, 35, 255), true )
	
	local fractn = table.Count(fract)
	
	if LocalPlayer():Health() < 100 or fractn > 0 then
		local money =  ( LocalPlayer():GetMaxHealth() - LocalPlayer():Health() ) * ConfigurationMedicMod.HealthUnitPrice
		
		if fractn > 0 then
			money = money + fractn * ConfigurationMedicMod.FractureRepairPrice
		end
		
		local Label1 = CreateLabel( boxContent, nil, sentences["Hello, you look sick. I can heal you,  it will cost"][lang].." "..money..ConfigurationMedicMod.MoneyUnit.."." , SizeX - 40, SizeY - 35 - 50 - 10, 10, 0, nil, 3)
		local Button1 = CreateButton( boxContent, sentences["Heal me"][lang], nil, nil, SizeX/2-75, SizeY - 50 - 10 - 25, 150, 50,	function() net.Start("MedicMod.MedicStart") net.WriteEntity( ent ) net.SendToServer() FramePrincipal:Close() end )
	else
		local Label1 = CreateLabel( boxContent, nil,  sentences["Hello, you seem healthy-looking today"][lang] , SizeX - 40, SizeY - 35 - 50 - 10, 10, 0, nil, 2)
		local Button1 = CreateButton( boxContent, sentences["Thanks"][lang], nil, nil, SizeX/2-75, SizeY - 50 - 10 - 25, 150, 50,	function() FramePrincipal:Close() end )
	end
		
end)

net.Receive("MedicMod.NotifiyPlayer", function()
	local msg = net.ReadString()
	local time = net.ReadInt( 32 )
	MedicNotif( msg, time )
end)

net.Receive("MedicMod.ScanRadio", function()

	local ent = net.ReadEntity()
	local fractures = net.ReadTable()
		
	ent.fracturesTable = fractures
		
end)

net.Receive("MedicMod.PlayerStartAnimation", function()	

	timer.Simple(0.15, function()

		for k, v in pairs(player.GetAll()) do

		if not v:GetMedicAnimation() then continue end

			if v:GetMedicAnimation() != 0 then
				StartMedicAnimation( v, v:GetMedicAnimation() )
			end
			
		end
	
	end)
	
end)

net.Receive("MedicMod.PlayerStopAnimation", function()	

	timer.Simple(0.15, function()

		for k, v in pairs(player.GetAll()) do
					
			if v:GetMedicAnimation() == 0 and IsValid( v.mdlanim ) then
				StopMedicAnimation( v )
			end
			
		end
	
	end)
	
end)

net.Receive("MedicMod.Respawn", function()
    MedicMod.seconds = net.ReadInt(32)
end)

net.Receive("MedicMod.TerminalMenu", function()
	local ent = net.ReadEntity()
	
	if not IsValid( ent ) then return end

	MedicMod.TerminalMenu( ent )
end)