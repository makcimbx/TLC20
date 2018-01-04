surface.CreateFont( "titleFont", {
	font = "Roboto Th",
	size = 56,
	weight = 400,
	antialias = true
} )

surface.CreateFont( "questionFont", {
	font = "Roboto Th",
	size = 34,
	weight = 400,
	antialias = true
} )

surface.CreateFont( "chooseFont", {
	font = "Roboto Lt",
	size = 24,
	weight = 400,
	antialias = true
} )
surface.CreateFont( "buttonsFont", {
	font = "Roboto Lt",
	size = 22,
	weight = 400,
	antialias = true
} )
surface.CreateFont( "buttonsFontSmall", {
	font = "Roboto Lt",
	size = 14,
	weight = 400,
	antialias = true
} )

net.Receive("firsttimert", function()

	local mainFrame = vgui.Create("DAlert")
	mainFrame:SetTitle(rtLang.welcomeTitle)
	mainFrame:SetText(rtLang.welcomeText)
	mainFrame.okTxt = rtLang.welcomeOk
	mainFrame.cancelTxt1 = rtLang.welcomeCancel
	mainFrame.CType_1 = rtLang.welcomeCType_1
	mainFrame.offset1 = rtLang.welcomeOffset1
	
end)

net.Receive("questions", function()

	local mainFrame = vgui.Create("DFrame")
	mainFrame:SetSize( ScrW(),  ScrH() * 0.8 )
	mainFrame:SetBackgroundBlur( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:SetTitle("")
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color( 41, 128, 185))
	end

	local contentHolder = vgui.Create("DPanel", mainFrame)
	contentHolder:SetSize( mainFrame:GetWide() * 0.7,  mainFrame:GetTall() * 0.9 )
	contentHolder:Center()
	contentHolder.Paint = function() end

	local titleLabel = vgui.Create("DLabel", contentHolder)
	titleLabel:SetText(rtLang.questionsTitle)
	titleLabel:SetFont("titleFont")
	titleLabel:SizeToContents()
	titleLabel:SetPos(0, 0)
	titleLabel:SetColor(Color(255, 255, 255))

	local questionsHolder = vgui.Create( "DPanelList", contentHolder)
	questionsHolder:SetSize( contentHolder:GetWide() - 5, contentHolder:GetTall() - 170 )
	questionsHolder:SetPos( 0, 100 )
	questionsHolder:SetSpacing( 50 )
	questionsHolder:EnableHorizontal( false )
	questionsHolder:EnableVerticalScrollbar( true )

	local question = {}
	local quest = {}
	local choose = {}
	local questionBlock = {}
	local my_answers = {}
	
	
	for k,v in pairs(rtLang.Questions) do
		local id = k
		my_answers[id] = 0
		--local size = 0
		questionBlock[id] = vgui.Create( "DPanel" )
		questionBlock[id]:SetTall( 250 )
		questionBlock[id].Paint = function() end
		questionBlock[id].quest = {}
		questionBlock[id].label = {}

		question[id] = vgui.Create( "DLabel", questionBlock[id])
	    question[id]:SetPos(0,0)
		--question[id]:SetWrap( true )
	    question[id]:SetFont("questionFont")
	    question[id]:SetText(v["question"])
	    question[id]:SetColor(Color(255, 255, 255))
		question[id]:SetWide( contentHolder:GetWide() - 5)
		--question[id]:SetAutoStretchVertical( true)
		local text1,y1 = CalculateSize2(question[id]:GetText(),question[id]:GetFont(),question[id]:GetWide()-30)
		question[id]:SetText(text1)
		question[id]:SetTall(y1) -- Size the label to fit the text in it
		--size = size + question[id]:GetTall()

	    --[[choose[id] = vgui.Create("DComboBox", questionBlock[id])
	    choose[id]:SetSize( questionsHolder:GetWide() - 20 , 40 )
		choose[id]:SetFont("chooseFont")
		choose[id]:SetValue( rtLang.defualtOption )
		choose[id]:SetPos(0, question[id]:GetTall())
		choose[id].Paint = function()
			draw.RoundedBox( 0, 0, 0, choose[id]:GetWide(), choose[id]:GetTall(), Color( 255,255,255, 255) )
		end]]--
		local kk = 0
		
		local answers = v["answers"]
		for k,v in pairs( answers ) do
		
		--local x,y = 
		
		if(v!="")then
			kk = kk +1
			questionBlock[id].quest[k] = vgui.Create( "DButton",questionBlock[id] )
			questionBlock[id].quest[k]:SetText("")
			questionBlock[id].quest[k]:SetSize( contentHolder:GetWide() - 5, 80 )
			--questionBlock[id].quest[k]:SetTall( 80 )
			questionBlock[id].quest[k]:SetColor(Color(255,255,255))
			questionBlock[id].quest[k]:SetFont("buttonsFont")
			--questionBlock[id].quest[k]:SetPos( 0, question[id]:GetTall()+80*(kk-1)-30 )
			questionBlock[id].quest[k].color = Color( 231, 76, 60)
			questionBlock[id].quest[k].Paint = function()
				draw.RoundedBox( 0, 0, 0, questionBlock[id].quest[k]:GetWide(), questionBlock[id].quest[k]:GetTall(), questionBlock[id].quest[k].color )
			end

			questionBlock[id].quest[k].DoClick = function()
				if(my_answers[id]!=0 and my_answers[id]!=k)then
					questionBlock[id].quest[my_answers[id]].color = Color( 231, 76, 60)
					my_answers[id] = k
					questionBlock[id].quest[k].color = Color( 46, 204, 113 )
				else
					my_answers[id] = k
					questionBlock[id].quest[k].color = Color( 46, 204, 113 )
				end
			end
		
			questionBlock[id].label[k] = vgui.Create( "DLabel", questionBlock[id].quest[k])
			questionBlock[id].label[k]:SetText(v)
			questionBlock[id].label[k]:SetFont("buttonsFont")
			questionBlock[id].label[k]:SetSize( contentHolder:GetWide() - 10, 70 )
			questionBlock[id].label[k]:SetWrap( true )
			questionBlock[id].label[k]:SetColor(Color(255, 255, 255))
			questionBlock[id].label[k]:SetPos(5,5)
			local text1,y1 = CalculateSize2(questionBlock[id].label[k]:GetText(),questionBlock[id].label[k]:GetFont(),questionBlock[id].quest[k]:GetWide()-20)
			questionBlock[id].label[k]:SetText(text1)
			questionBlock[id].label[k]:SetTall(y1)
			questionBlock[id].quest[k]:SetTall(y1)
			if(k>1)then
				if(IsValid(questionBlock[id].quest[k]) and IsValid(questionBlock[id].quest[k-1]))then
					local xx,yy = questionBlock[id].quest[k-1]:GetPos()
					questionBlock[id].quest[k]:SetPos( 0, yy+questionBlock[id].quest[k-1]:GetTall() )
				end
			else
				questionBlock[id].quest[k]:SetPos( 0, question[id]:GetTall()+y1*(kk-1)-30 )
			end
		end
		--size = size + questionBlock[id].quest[k]:GetTall()
		
			--choose[id]:AddChoice( v, k )
		end
		questionBlock[id]:SizeToChildren( false, true )
		--questionBlock[id]:SetTall( size )

		questionsHolder:AddItem( questionBlock[id] )
	end

	local sendButton = vgui.Create("DButton", contentHolder)
	sendButton:SetText(rtLang.questionsOk)
	sendButton:SetSize(140, 40)
	sendButton:SetColor(Color(255,255,255))
	sendButton:SetFont("buttonsFont")
	sendButton:SetPos( contentHolder:GetWide() - (sendButton:GetWide() + 5), contentHolder:GetTall() - (sendButton:GetTall() + 5) )
	sendButton.Paint = function()
		draw.RoundedBox( 0, 0, 0, sendButton:GetWide(), sendButton:GetTall(), Color( 46, 204, 113 ) )
	end
	sendButton.DoClick = function()
		local answers = {}
		local allgood
		for k,v in pairs(my_answers) do
			if my_answers[k]!=0 then 
				table.insert(answers, my_answers[k])
				allgood = true
			else
				EverDerma("Ошибка",rtLang.forgotAnswer,{{text="Ок",func = function() end}})
				--Derma_Query(rtLang.forgotAnswer, "Error", "Ok")
				allgood = false
				break
			end
		end
		--print(allgood)
		if allgood then
			net.Start("checkanswers")
				net.WriteTable(answers)
				mainFrame:Close()
			net.SendToServer()
		end
	end

	--[[local cancelButton = vgui.Create("DButton", contentHolder)
	cancelButton:SetText(rtLang.questionsCancel)
	cancelButton:SetSize(140, 40)
	cancelButton:SetPos( contentHolder:GetWide() - (cancelButton:GetWide() + 150), contentHolder:GetTall() - (cancelButton:GetTall() + 5) )
	cancelButton:SetColor(Color(255,255,255))
	cancelButton:SetFont("buttonsFont")
	cancelButton.Paint = function()
		draw.RoundedBox( 0, 0, 0, cancelButton:GetWide(), cancelButton:GetTall(), Color( 231, 76, 60))
	end
	cancelButton.DoClick = function()
		RunConsoleCommand("rt_cancel")
	end	]]--
end)

local maxplys = 0--5

function Legion()
	
	local tbl = table.Copy( rtLang.Legions )
	local mn = 150
	for a,z in pairs(tbl)do
		z.can = true
		z.n = 0
		for k,v in pairs(player.GetAll())do
			if(v:getJobTable().category == z.category)then
				z.n = z.n + 1
			end
		end
		if(mn>z.n)then
			mn = z.n
		end
	end
	for a,z in pairs(tbl)do
		if(math.abs(mn-z.n)>=maxplys) then
			z.can = false
		end
	end
	
	local target_legion = 0
	local mainFrame = vgui.Create("DFrame")
	mainFrame:SetSize( ScrW(),  ScrH() * 0.8 )
	mainFrame:SetBackgroundBlur( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:SetTitle("")
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color( 41, 128, 185))
	end

	local contentHolder = vgui.Create("DPanel", mainFrame)
	contentHolder:SetSize( mainFrame:GetWide() * 0.7,  mainFrame:GetTall() * 0.9 )
	contentHolder:Center()
	contentHolder.Paint = function() end

	local titleLabel = vgui.Create("DLabel", contentHolder)
	titleLabel:SetText(rtLang.legionTitle)
	titleLabel:SetFont("titleFont")
	titleLabel:SizeToContents()
	titleLabel:SetPos(0, 0)
	titleLabel:SetColor(Color(255, 255, 255))

	local questionsHolder = vgui.Create( "DPanelList", contentHolder)
	questionsHolder:SetSize( contentHolder:GetWide() - 5, contentHolder:GetTall() - 170 )
	questionsHolder:SetPos( 0, 100 )
	questionsHolder:SetSpacing( 10 )
	questionsHolder:EnableHorizontal( false )
	questionsHolder:EnableVerticalScrollbar( true )

	local question = {}
	local choose = {}
	local questionBlock = {}
	for k,v in pairs(tbl) do
		local id = k
		if(v.can)then
			questionBlock[id] = vgui.Create( "DButton" )
			questionBlock[id]:SetText(v.name)
			questionBlock[id]:SetTall( 45 )
			questionBlock[id]:SetColor(Color(255,255,255))
			questionBlock[id]:SetFont("buttonsFont")
			questionBlock[id]:SetPos( contentHolder:GetWide() - (questionBlock[id]:GetWide() + 5), contentHolder:GetTall() - (questionBlock[id]:GetTall() + 5) )
			questionBlock[id].color = Color( 231, 76, 60)
			questionBlock[id].Paint = function()
				draw.RoundedBox( 0, 0, 0, questionBlock[id]:GetWide(), questionBlock[id]:GetTall(), questionBlock[id].color )
			end

			questionBlock[id].DoClick = function()
				if(target_legion!=0)then questionBlock[target_legion].color = Color( 231, 76, 60) end
				questionBlock[id].color = Color( 46, 204, 113 )
				target_legion = id
			end
		
			questionsHolder:AddItem( questionBlock[id] )
		end
	end

	local sendButton = vgui.Create("DButton", contentHolder)
	sendButton:SetText(rtLang.legionOk)
	sendButton:SetSize(140, 40)
	sendButton:SetColor(Color(255,255,255))
	sendButton:SetFont("buttonsFont")
	sendButton:SetPos( contentHolder:GetWide() - (sendButton:GetWide() + 5), contentHolder:GetTall() - (sendButton:GetTall() + 5) )
	sendButton.Paint = function()
		draw.RoundedBox( 0, 0, 0, sendButton:GetWide(), sendButton:GetTall(), Color( 46, 204, 113 ) )
	end
	sendButton.DoClick = function()
		if(target_legion!=0)then
			mainFrame:Close()
			LocalPlayer().legion = target_legion
			local mainFrame = vgui.Create("DAlert")
			mainFrame:SetTitle(rtLang.passedTitle)
			mainFrame:SetText(rtLang.passedText)
			mainFrame.okTxt = rtLang.passedOk
			mainFrame.cancelTxt1 = rtLang.passedCancel
			mainFrame:Passed()
		else
			EverDerma("Ошибка","Вы не выбрали легион",{{text="Ок",func = function() end}})
		end
	end
end

net.Receive("rtresults", function()

	if net.ReadBool() then
		Legion()
	else
		local mainFrame = vgui.Create("DAlert")
		mainFrame:SetTitle(string.format( rtLang.failedTitle, net.ReadString() ))
		mainFrame:SetText(rtLang.failedText)
		mainFrame.okTxt = rtLang.failedOk
	end

end)
	
--[[Admin shit]]--

net.Receive("addquestions", function()

	local mainFrame = vgui.Create( "DFrame" )
	mainFrame:SetSize( 500, 500 )
	mainFrame:SetTitle( "" )
	mainFrame:SetVisible( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color(226,226,226) )
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), 30, Color( 52, 73, 94 ) )
	end
	
	local closeButton = vgui.Create("DButton", mainFrame)
	closeButton:SetSize( 70, 30 )
	closeButton:SetPos( 430 , 0 )
	closeButton:SetColor( Color( 255, 255, 255 ))
	closeButton:SetText("X")
	closeButton:SetVisible( true )

	closeButton.Paint = function( )
		if closeButton.isHover then
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 192, 57, 43 ) )
		else
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 231, 76, 60 ) )
		end
	end

	closeButton.OnCursorEntered = function()
		closeButton.isHover = true
	end

	closeButton.OnCursorExited = function()
		closeButton.isHover = false
	end

	closeButton.DoClick = function()
		mainFrame:Close()
	end

	local titleLabel = vgui.Create("DLabel", mainFrame)
	titleLabel:SetText( "New question" )
	titleLabel:SetFont("questionFont")
	titleLabel:SetColor( Color( 255, 255, 255 ) )
	titleLabel:SizeToContents()
	titleLabel:SetPos( 6, -2 )


	local contentHolder = vgui.Create("DPanel", mainFrame)
	contentHolder:SetSize( 480, 430 )
	contentHolder:SetPos( 10, 40 )

	local explainLabel = vgui.Create("DLabel", contentHolder)
	explainLabel:SetFont("buttonsFont")
	explainLabel:SetPos( 10, 10 )
	explainLabel:SetColor( Color( 52, 73, 94 ) )
	explainLabel:SetAutoStretchVertical( true )
	explainLabel:SetWide( 430 )
	explainLabel:SetWrap( true )
	explainLabel:SetText("Here you need to write your question and the answers then select the correct answer.")

	local questionEntry = vgui.Create("DTextEntry", contentHolder)
	questionEntry:SetPos( 10, 115 )
	questionEntry:SetSize( 460, 30 )
	questionEntry:SetFont("buttonsFont")
	questionEntry:SetText("Write here the question!")

	answerEntry = {}
	answerCheckbox = {}

	answerEntry[1] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[1]:SetPos( 50, 150 )
	answerEntry[1]:SetSize( 420, 30 )
	answerEntry[1]:SetFont("buttonsFont")
	answerEntry[1]:SetText("Write here the first answer!")

	local answerCheckbox1 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox1:SetPos( 20, 158 )
	answerCheckbox1:SetValue( 1 )

	answerEntry[2] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[2]:SetPos( 50, 185 )
	answerEntry[2]:SetSize( 420, 30 )
	answerEntry[2]:SetFont("buttonsFont")
	answerEntry[2]:SetText("Write here the second answer!")

	local answerCheckbox2 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox2:SetPos( 20, 193 )
	answerCheckbox2:SetValue( 2 )

	answerEntry[3] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[3]:SetPos( 50, 220 )
	answerEntry[3]:SetSize( 420, 30 )
	answerEntry[3]:SetFont("buttonsFont")
	answerEntry[3]:SetText("Write here the third answer!")

	local answerCheckbox3 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox3:SetPos( 20, 228 )
	answerCheckbox3:SetValue( 3 )

	answerEntry[4] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[4]:SetPos( 50, 255 )
	answerEntry[4]:SetSize( 420, 30 )
	answerEntry[4]:SetFont("buttonsFont")
	answerEntry[4]:SetText("Write here the fourth answer!")

	local answerCheckbox4 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox4:SetPos( 20, 263 )
	answerCheckbox4:SetValue( 4 )

	local group = {answerCheckbox1, answerCheckbox2, answerCheckbox3, answerCheckbox4}
	answerCheckbox1:SetGroup(group)
	answerCheckbox2:SetGroup(group)
	answerCheckbox3:SetGroup(group)
	answerCheckbox4:SetGroup(group)

	local addButton = vgui.Create("DButton", contentHolder)
	addButton:SetSize( 180, 40 )
	addButton:SetPos( 275, 370 )
	addButton:SetColor( Color( 255, 255, 255) )
	addButton:SetFont("buttonsFont")
	addButton:SetText("Add question")
	addButton.DoClick = function()
		local rightanswer
		for i, button in ipairs(group) do
			if button:GetSelected() then
				rightanswer = button:GetValue()
			end
		end
		net.Start("addquestion")
			local answers = { string.Replace(answerEntry[1]:GetValue(), "'", ""), string.Replace(answerEntry[2]:GetValue(), "'", ""), string.Replace(answerEntry[3]:GetValue(), "'", ""), string.Replace(answerEntry[4]:GetValue(), "'", "") }
			--PrintTable({questionEntry:GetValue(), util.TableToJSON(answers), rightanswer})
			net.WriteTable({questionEntry:GetValue(), util.TableToJSON(answers), rightanswer})
		net.SendToServer()
		mainFrame:Close()
	end
	addButton.Paint = function()
		draw.RoundedBox( 0, 0, 0, addButton:GetWide(), addButton:GetTall(), Color( 41, 128, 185 ) )
	end

end)

local p = FindMetaTable("Panel")

function p:GetPosY()
	local x,y = self:GetPos()
	return y
end

function p:GetPosX()
	local x,y = self:GetPos()
	return x
end

function EverDerma(title, inner, buttons)
	
	if(#buttons == 0)then return end
	
	local mainFrame = vgui.Create("DFrame")
	mainFrame:SetSize( ScrW()* 0.6,  ScrH() * 0.6 )
	mainFrame:SetBackgroundBlur( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:SetTitle("")
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color( 41, 128, 185))
	end

	local contentHolder = vgui.Create("DPanel", mainFrame)
	contentHolder:SetSize( mainFrame:GetWide() * 0.7,  mainFrame:GetTall() * 0.9 )
	contentHolder:Center()
	contentHolder.Paint = function() 
		--draw.RoundedBox( 0, 0, 0, contentHolder:GetWide(), contentHolder:GetTall(), Color( 101, 128, 185))
	end

	local titleLabel = vgui.Create("DLabel", contentHolder)
	titleLabel:SetText(title)
	titleLabel:SetFont("titleFont")
	titleLabel:SizeToContents()
	titleLabel:SetPos(contentHolder:GetWide()/2, 0)
	titleLabel:SetColor(Color(255, 255, 255))
	titleLabel:CenterHorizontal()
	
	local questionsHolder = vgui.Create( "DPanelList", contentHolder)
	questionsHolder:SetSize( contentHolder:GetWide() - 5, contentHolder:GetTall() - 170 )
	questionsHolder:SetPos( 0, 100 )
	questionsHolder:SetSpacing( 10 )
	questionsHolder:EnableHorizontal( false )
	questionsHolder:EnableVerticalScrollbar( true )
	questionsHolder.Paint = function()
		--draw.RoundedBox( 0, 0, 0, questionsHolder:GetWide(), questionsHolder:GetTall(), Color( 11, 28, 15))
	end
		
	local label = vgui.Create( "DLabel" )
	label:SetText(inner)
	label:SetFont("buttonsFont")
	label:SetSize( questionsHolder:GetWide() - 10, 70 )
	label:SetWrap( true )
	label:SetColor(Color(255, 255, 255))
	label:SetPos(5,5)
	local text1,y1 = CalculateSize2(label:GetText(),label:GetFont(),questionsHolder:GetWide() - 10) --[[ .."1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" ]]-- 
	label:SetText(text1)
	label:SetTall(y1)
	
	if(y1<questionsHolder:GetTall())then
		questionsHolder:SetTall(y1)
	end
	
	questionsHolder:AddItem( label )
	
	
	local contentHolder2 = vgui.Create("DPanel", contentHolder)
	contentHolder2:SetSize( contentHolder:GetWide(), 50)--contentHolder:GetTall()-questionsHolder:GetTall()-100 )
	contentHolder2:SetPos( 0, questionsHolder:GetPosY()+questionsHolder:GetTall()+5 )
	contentHolder2.Paint = function()
		--draw.RoundedBox( 0, 0, 0, contentHolder2:GetWide(), contentHolder2:GetTall(), Color( 101, 28, 185))
	end
	
	for k,v in pairs(buttons)do
		local sendButton = vgui.Create("DButton", contentHolder2)
		sendButton:SetText(v.text)
		sendButton:SetSize((contentHolder2:GetWide()-(#buttons+1)*5)/#buttons, 40)
		sendButton:SetColor(Color(255,255,255))
		sendButton:SetFont("buttonsFont")
		sendButton:SetPos( (k-1)*(sendButton:GetWide())+5*k, contentHolder2:GetTall()/2-sendButton:GetTall()/2 )
		sendButton.Paint = function()
			draw.RoundedBox( 0, 0, 0, sendButton:GetWide(), sendButton:GetTall(), v.color or Color( 46, 204, 113 ) )
		end
		sendButton.DoClick = function() v.func() mainFrame:Close() end
	end
	
	
	contentHolder:SetTall(contentHolder2:GetPosY()+contentHolder2:GetTall())
	mainFrame:SetSize( contentHolder:GetWide()* 1.1,  contentHolder:GetTall() * 1.25 )
	contentHolder:Center()
	mainFrame:Center()
	
end

net.Receive("adminselectquestion", function()

	local mainFrame = vgui.Create( "DFrame" )
	mainFrame:SetSize( 500, 500 )
	mainFrame:SetTitle( "" )
	mainFrame:SetVisible( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color(226,226,226) )
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), 30, Color( 52, 73, 94 ) )
	end
	
	local closeButton = vgui.Create("DButton", mainFrame)
	closeButton:SetSize( 70, 30 )
	closeButton:SetPos( 430 , 0 )
	closeButton:SetColor( Color( 255, 255, 255 ))
	closeButton:SetText("X")
	closeButton:SetVisible( true )

	closeButton.Paint = function( )
		if closeButton.isHover then
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 192, 57, 43 ) )
		else
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 231, 76, 60 ) )
		end
	end

	closeButton.OnCursorEntered = function()
		closeButton.isHover = true
	end

	closeButton.OnCursorExited = function()
		closeButton.isHover = false
	end

	closeButton.DoClick = function()
		mainFrame:Close()
	end

	local title = vgui.Create("DLabel", mainFrame)
	title:SetText( "Select question to edit." )
	title:SetFont("titlefont")
	title:SetColor( Color( 255, 255, 255 ) )
	title:SizeToContents()
	title:SetPos( 6, 2 )

	local questlist = vgui.Create( "DListView", mainFrame )
	questlist:SetSize( 480, 430 )
	questlist:SetPos( 10, 40 )
	questlist:SetMultiSelect( false )
	questlist:AddColumn( "ID" )
	questlist:AddColumn( "Question" )
	
	for k,v in pairs(net.ReadTable()) do
		questlist:AddLine( v.id, v.question )
	end

	questlist.OnRowRightClick = function ( btn, line )
	    local questsOptions = DermaMenu()
		questsOptions:AddOption("Delete Question", function() 
			Derma_Query("Are you sure that you want to delete this question?", "Warning!",
				"Yes", function() RunConsoleCommand("question_delete", questlist:GetLine(line):GetValue(1)) questlist:RemoveLine(line) end,
				"No")
		end )
		questsOptions:AddOption("Edit Question", function() 
			RunConsoleCommand("question_request", questlist:GetLine(line):GetValue(1))
		end )
	    questsOptions:Open()
	end

	questlist.DoDoubleClick = function( id, line )
		RunConsoleCommand("question_request", questlist:GetLine(line):GetValue(1))
	end

end )

net.Receive("editquestionmenu", function()
	
	local data = net.ReadTable()

	local mainFrame = vgui.Create( "DFrame" )
	mainFrame:SetSize( 500, 500 )
	mainFrame:SetTitle( "" )
	mainFrame:SetVisible( true )
	mainFrame:SetDraggable( false )
	mainFrame:ShowCloseButton( false )
	mainFrame:Center()
	mainFrame:MakePopup()
	mainFrame.Init = function()
		mainFrame.startTime = SysTime()
	end
	mainFrame.Paint = function()
		Derma_DrawBackgroundBlur(mainFrame, mainFrame.startTime)
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), mainFrame:GetTall(), Color(226,226,226) )
		draw.RoundedBox( 0, 0, 0, mainFrame:GetWide(), 30, Color( 52, 73, 94 ) )
	end
	
	local closeButton = vgui.Create("DButton", mainFrame)
	closeButton:SetSize( 70, 30 )
	closeButton:SetPos( 430 , 0 )
	closeButton:SetColor( Color( 255, 255, 255 ))
	closeButton:SetText("X")
	closeButton:SetVisible( true )

	closeButton.Paint = function( )
		if closeButton.isHover then
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 192, 57, 43 ) )
		else
			draw.RoundedBox( 0, 0, 0, closeButton:GetWide(), closeButton:GetTall(), Color( 231, 76, 60 ) )
		end
	end

	closeButton.OnCursorEntered = function()
		closeButton.isHover = true
	end

	closeButton.OnCursorExited = function()
		closeButton.isHover = false
	end

	closeButton.DoClick = function()
		mainFrame:Close()
	end

	local titleLabel = vgui.Create("DLabel", mainFrame)
	titleLabel:SetText( "New question" )
	titleLabel:SetFont("questionFont")
	titleLabel:SetColor( Color( 255, 255, 255 ) )
	titleLabel:SizeToContents()
	titleLabel:SetPos( 6, -2 )


	local contentHolder = vgui.Create("DPanel", mainFrame)
	contentHolder:SetSize( 480, 430 )
	contentHolder:SetPos( 10, 40 )

	local explainLabel = vgui.Create("DLabel", contentHolder)
	explainLabel:SetFont("buttonsFont")
	explainLabel:SetPos( 10, 10 )
	explainLabel:SetColor( Color( 52, 73, 94 ) )
	explainLabel:SetAutoStretchVertical( true )
	explainLabel:SetWide( 430 )
	explainLabel:SetWrap( true )
	explainLabel:SetText("Here you need to write your question and the answers then select the correct answer.")

	local questionEntry = vgui.Create("DTextEntry", contentHolder)
	questionEntry:SetPos( 10, 115 )
	questionEntry:SetSize( 460, 30 )
	questionEntry:SetFont("buttonsFont")
	questionEntry:SetText(data[1]["question"])

	answerEntry = {}
	answerCheckbox = {}

	answerEntry[1] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[1]:SetPos( 50, 150 )
	answerEntry[1]:SetSize( 420, 30 )
	answerEntry[1]:SetFont("buttonsFont")
	

	local answerCheckbox1 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox1:SetPos( 20, 158 )
	answerCheckbox1:SetValue( 1 )

	answerEntry[2] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[2]:SetPos( 50, 185 )
	answerEntry[2]:SetSize( 420, 30 )
	answerEntry[2]:SetFont("buttonsFont")
	

	local answerCheckbox2 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox2:SetPos( 20, 193 )
	answerCheckbox2:SetValue( 2 )

	answerEntry[3] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[3]:SetPos( 50, 220 )
	answerEntry[3]:SetSize( 420, 30 )
	answerEntry[3]:SetFont("buttonsFont")
	

	local answerCheckbox3 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox3:SetPos( 20, 228 )
	answerCheckbox3:SetValue( 3 )

	answerEntry[4] = vgui.Create("DTextEntry", contentHolder)
	answerEntry[4]:SetPos( 50, 255 )
	answerEntry[4]:SetSize( 420, 30 )
	answerEntry[4]:SetFont("buttonsFont")
	

	local answerCheckbox4 = vgui.Create( "DChoice", contentHolder)
	answerCheckbox4:SetPos( 20, 263 )
	answerCheckbox4:SetValue( 4 )


	local group = {answerCheckbox1, answerCheckbox2, answerCheckbox3, answerCheckbox4}
	answerCheckbox1:SetGroup(group)
	answerCheckbox2:SetGroup(group)
	answerCheckbox3:SetGroup(group)
	answerCheckbox4:SetGroup(group)

	local addButton = vgui.Create("DButton", contentHolder)
	addButton:SetSize( 180, 40 )
	addButton:SetPos( 275, 370 )
	addButton:SetColor( Color( 255, 255, 255) )
	addButton:SetFont("buttonsFont")
	addButton:SetText("Edit qusetion")
	addButton.DoClick = function()
		local rightanswer
		for i, button in ipairs(group) do
			if button:GetSelected() then
				rightanswer = button:GetValue()
			end
		end
		net.Start("editquestion")
			local answers = { string.Replace(answerEntry[1]:GetValue(), "'", ""), string.Replace(answerEntry[2]:GetValue(), "'", ""), string.Replace(answerEntry[3]:GetValue(), "'", ""), string.Replace(answerEntry[4]:GetValue(), "'", "") }
			net.WriteTable({questionEntry:GetValue(), util.TableToJSON(answers), rightanswer, data[1]["id"]})
		net.SendToServer()
		mainFrame:Close()
	end
	addButton.Paint = function()
		draw.RoundedBox( 0, 0, 0, addButton:GetWide(), addButton:GetTall(), Color( 41, 128, 185 ) )
	end
	local answers = util.JSONToTable(data[1]["answers"])
	for k,v in pairs(answers) do
		answerEntry[k]:SetText(answers[k])
	end
	for i, button in ipairs(group) do
		if i == tonumber(data[1]["rightanswer"]) then
			button:SetSelected( true )
		end
	end

end)