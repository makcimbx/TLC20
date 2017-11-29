local PANEL = {}
 
function PANEL:Init()

	self.okTxt = ""
	self.cancelTxt1 = ""
	self.cancelTxt2 = ""
	self.CType_1 = ""
	self.CType_2 = ""
	self.offset1 = 0
	self.offset2 = 0

	self.mainFrame = vgui.Create("DFrame")
	self.mainFrame:SetSize( ScrW(),  ScrH() * 0.32 )
	self.mainFrame:SetBackgroundBlur( true )
	self.mainFrame:SetDraggable( false )
	self.mainFrame:ShowCloseButton( false )
	self.mainFrame:SetTitle("")
	self.mainFrame:Center()
	self.mainFrame:MakePopup()
	self.mainFrame.Init = function()
		self.mainFrame.startTime = SysTime()
	end
	self.mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(self.mainFrame, self.mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, self.mainFrame:GetWide(), self.mainFrame:GetTall(), Color( 41, 128, 185))
	end

	local contentHolder = vgui.Create("DPanel", self.mainFrame)
	contentHolder:SetSize( self.mainFrame:GetWide() * 0.7,  self.mainFrame:GetTall() * 0.9 )
	contentHolder:Center()
	contentHolder.Paint = function() end

	self.titleLabel = vgui.Create("DLabel", contentHolder)
	self.titleLabel:SetText("11111к")
	self.titleLabel:SetFont("titleFont")
	self.titleLabel:SetPos(0, 0)
	self.titleLabel:SetColor(Color(255, 255, 255))

	self.textLabel = vgui.Create("DLabel", contentHolder)
	self.textLabel:SetText("11111к2")
	self.textLabel:SetPos(0, 100)
	self.textLabel:SetAutoStretchVertical( true )
	self.textLabel:SetWide( contentHolder:GetWide() - 5 )
	self.textLabel:SetWrap( true )
	self.textLabel:SetFont("chooseFont")

	self.sendbutton = vgui.Create("DButton", contentHolder)
	self.sendbutton:SetText("Ок")
	self.sendbutton:SetSize(140, 40)
	self.sendbutton:SetColor(Color(255,255,255))
	self.sendbutton:SetFont("buttonsFont")
	self.sendbutton:SetPos( contentHolder:GetWide() - (self.sendbutton:GetWide() + 5), contentHolder:GetTall() - (self.sendbutton:GetTall() + 5) )
	self.sendbutton.Paint = function()
		if(self.okTxt == "")then self.sendbutton:SetVisible( false ) else self.sendbutton:SetVisible( true ) end
		self.sendbutton:SetText(self.okTxt)
		draw.RoundedBox( 0, 0, 0, self.sendbutton:GetWide(), self.sendbutton:GetTall(), Color( 46, 204, 113 ) )
	end
	self.sendbutton.DoClick = function()
		RunConsoleCommand("rt_questions")
		self.mainFrame:Close()
	end

	self.cancelbutton = vgui.Create("DButton", contentHolder)
	self.cancelbutton:SetText("*")
	self.cancelbutton:SetSize(140, 40)
	self.cancelbutton:SetPos( contentHolder:GetWide() - (self.cancelbutton:GetWide()+self.offset1/2 + 150), contentHolder:GetTall() - (self.cancelbutton:GetTall() + 5) )
	self.cancelbutton:SetColor(Color(255,255,255))
	self.cancelbutton:SetFont("buttonsFont")
	self.cancelbutton.Paint = function()
		if(self.cancelTxt1 == "")then self.cancelbutton:SetVisible( false ) else self.cancelbutton:SetVisible( true ) end
		local x,y = self.cancelbutton:GetSize()
		if(x != 140+self.offset1)then self.cancelbutton:SetSize(140+self.offset1, 40) self.cancelbutton:SetPos( contentHolder:GetWide() - (self.cancelbutton:GetWide()+self.offset1/2 + 150), contentHolder:GetTall() - (self.cancelbutton:GetTall() + 5) ) end
		self.cancelbutton:SetText(self.cancelTxt1)
		draw.RoundedBox( 0, 0, 0, self.cancelbutton:GetWide()+self.offset1, self.cancelbutton:GetTall(), Color( 231, 76, 60))
	end
	self.cancelbutton.DoClick = function()
		RunConsoleCommand("rt_cancel",self.CType_1)
		self.mainFrame:Close()
	end

	self.cancelbutton2 = vgui.Create("DButton", contentHolder)
	self.cancelbutton2:SetText("*")
	self.cancelbutton2:SetSize(140, 40)
	self.cancelbutton2:SetPos( contentHolder:GetWide() - (self.cancelbutton:GetWide() +self.cancelbutton2:GetWide()+self.offset1/2+self.offset2/2 + 155), contentHolder:GetTall() - (self.cancelbutton2:GetTall() + 5) )
	self.cancelbutton2:SetColor(Color(255,255,255))
	self.cancelbutton2:SetFont("buttonsFont")
	self.cancelbutton2.Paint = function()
		if(self.cancelTxt2 == "")then self.cancelbutton2:SetVisible( false ) else self.cancelbutton2:SetVisible( true ) end
		local x,y = self.cancelbutton2:GetSize()
		if(x != 140+self.offset2)then self.cancelbutton2:SetSize(140+self.offset2, 40) self.cancelbutton2:SetPos( contentHolder:GetWide() - (self.cancelbutton:GetWide() +self.cancelbutton2:GetWide()+self.offset1/2+self.offset2/2 + 155), contentHolder:GetTall() - (self.cancelbutton2:GetTall() + 5) ) end
		self.cancelbutton2:SetText(self.cancelTxt2)
		draw.RoundedBox( 0, 0, 0, self.cancelbutton2:GetWide()+self.offset2, self.cancelbutton2:GetTall(), Color( 231, 76, 60))
	end
	self.cancelbutton2.DoClick = function()
		RunConsoleCommand("rt_cancel",self.CType_2)
		self.mainFrame:Close()
	end
end

function PANEL:SetTitle( title )

	self.titleLabel:SetText( title )
	self.titleLabel:SizeToContents()

end
function PANEL:SetText( text )

	self.textLabel:SetText( text )

end
function PANEL:Passed()
	self.sendbutton.DoClick = function()
		self.mainFrame:Close()
		net.Start("addnagrada")
			net.WriteString(LocalPlayer().legion)
		net.SendToServer()
	end
	self.cancelbutton:SetVisible(false)
end
derma.DefineControl("DAlert", "Custom Panel", PANEL)