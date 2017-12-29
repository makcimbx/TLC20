net.Receive("SendCSC", function()
	local useTag = (net.ReadBool() and ClearChat)
	local group = net.ReadString()
	local message = net.ReadString()
	local nick = net.ReadString()
	local server = net.ReadString()
	local useCSC = net.ReadBool()

	local args = {}

	if useCSC then
		table.insert(args, Color(63, 137, 255))
		table.insert(args, "[TLC] ")
	end

	if server != "" then
		 table.insert( args, "[" .. server .. "] ")
	end

	if useTag then
		local tag = (ClearChat.GetTags()[group] and ClearChat.GetTags()[group] or "")
		local col = tag[2]
		table.insert(args, col)
		table.insert(args, tag[1] .. " ")
	end
	table.insert(args, Color(255, 255, 255))
	table.insert(args, nick .. ": ")
	table.insert(args, message)

	chat.AddText(unpack(args))
end)