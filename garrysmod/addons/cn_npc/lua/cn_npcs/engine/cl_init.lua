-- Set the name of the NPC. This will be displayed on the top of the panel.
NPC.name = "Панель управления"
NPC.prop = true

-- Uncomment to make the NPC sit.
--NPC.sequence = "sit"

-- This is the function that gets called when the player presses <E> on the NPC.
function NPC:onStart()
	-- self:addText(<text>) adds text that comes from the NPC.
	self:addText("Перед вами БП с резисторами типа 2M2 G")

	-- self:addOption(<text>, <callback>) is a button that you can pick and it will
	-- run the callback function.
	self:addOption("Ничего не делать.", function()
		-- This code is inside a function that gets ran after pressing the option.
		self:addText("...")

		-- self:addLeave(<leave text>) adds a button that closes the dialogue.
		self:addLeave("...")
	end)

	-- You can have as many options as you need.
	self:addOption("Починить.", function()
		self:addText("На что вы хотели бы заменить резисторы?")

		self:addOption("0,220 Ом +-2%", function()
			--[[
				Chessnut's NPC system comes with an easy ability to network information between
				the client and server.

				You use self:send(<function name>, ...) to have NPC:on<function name> run on the
				opposite state. So here, we tell the server to ignite the player. Look at sv_init.lua
				to see how it looks receiving the message.

				The ellipses (...) means you can pass as many arguments as you want. Here we pass
				the amount of seconds the player will be ignited for.
			--]]
			self:send("Ignite", math.random(5, 10))

			-- Add a leave.
			self:addLeave("Как же так?")
		end)
		self:addLeave("2,2 Om +-2%")
	end)
end