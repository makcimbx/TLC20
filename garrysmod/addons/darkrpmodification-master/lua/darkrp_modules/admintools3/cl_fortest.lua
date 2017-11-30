local ru_string = "ИиДиНнАаХхОоЙй"
local eng_string = "FfUuCcKkYyOoSsEeLlFf"

concommand.Add( "ru_test", function( ply, cmd, args )
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 100, 100 )
	DermaPanel:SetSize( 300, 300 )
	DermaPanel:SetTitle( "My new Derma frame" )
	DermaPanel:SetDraggable( true )
	DermaPanel:MakePopup()
	
	local DPanel = vgui.Create( "DPanel",DermaPanel )
	DPanel:SetPos( 10, 30 ) -- Set the position of the panel
	DPanel:SetSize( 300-20, 300-40 ) -- Set the size of the panel

	local DLabel = vgui.Create( "DLabel", DPanel )
	DLabel:SetPos( 10, 10 ) -- Set the position of the labelвСловСловСловСлов

	DLabel:SetFont( "questionFont" ) -- Set the position of the label
	DLabel:SetText( "Слов Слов2 Слов3 Слов4 Слов5 Слов6 Слов7 Слов8 Слов9 Слов10 Слов11 Слов12AAAAAAAAAAAafFFF FFF AAAAAA EFFGGGG" ) -- Set the text of the label
	DLabel:SizeToContents() -- Size the label to fit the text in it
	DLabel:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
	DLabel:SetText(CalculateSize(DLabel:GetText(),DLabel:GetFont(),DPanel:GetWide()-30))
	DLabel:SizeToContents() -- Size the label to fit the text in it
end )

function CalculateSize(text,font,maxsize)
	surface.SetFont( font )
	local x, y = surface.GetTextSize( text )
	
	local code = {}
	
	for k,v in utf8.codes( text )do
		table.insert(code,v)
	end
	
	local word = ""
	local line = {}
	local i = 1
	line[i] = {}
	
	for k,v in pairs(code) do
		word = word..utf8.char(v)
		table.insert(line[i],utf8.char(v))
		local x,y = surface.GetTextSize( word )
		if(x>maxsize)then
			local w = line[i][#line[i]]
			table.remove(line[i],#line[i])
			word = ""
			i=i+1
			line[i] = {w}
		end
	end
	
	local text2 = ""
	
	for k,v in pairs(line) do
		for k,v in pairs(v) do
			text2 = text2..v
		end
		text2 = text2.."\n"
	end
	local x,y = surface.GetTextSize( text2 )
	print(y)
	
	return text2,y
end
