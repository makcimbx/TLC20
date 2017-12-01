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
	
	return text2,y
end

function CalculateSize2(text,font,maxsize)
	surface.SetFont( font )
	
	local array = string.Split( text, " " )

	local word = ""
	local line = {}
	local i = 1
	line[i] = {}
	newline = true
	
	
	for k,v in pairs(array) do
		if(newline==false)then word = word.." " end
		word = word..v
		table.insert(line[i],v)
		local x,y = surface.GetTextSize( word )
		newline = false
		if(x>maxsize)then
			local w = line[i][#line[i]]
			table.remove(line[i],#line[i])
			word = w
			newline = true
			i=i+1
			line[i] = {w}
		end
	end
	
	local text2 = ""
	
	for k,v in pairs(line) do
		for k,v in pairs(v) do
			if(k!=1)then text2 = text2.." " end
			text2 = text2..v
		end
		text2 = text2.."\n"
	end
	local x,y = surface.GetTextSize( text2 )
	
	return text2,y
end