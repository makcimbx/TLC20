-- Copyright 2016, George "Stalker" Petrou. Enjoy!

wOS = wOS or {}

--Enable this if you want to use a wiltOS Modified Prone mod.
--THIS IS VERY EXPERIMENTAL! There aren't those pretty reload animations directly for HL2 weapons. 
--You MUST install the DOD:S Animation Extension on your server if you enable this
wOS.EnablewiltOSProneMod = false

if not wOS.EnablewiltOSProneMod then return end

if SERVER then
	resource.AddWorkshop( "848953556" )
end

prone = prone or {}
prone.animations = prone.animations or {}
prone.config = prone.config or {}

-- YearMonthDay
prone.Version = 20161126.2

-- States
PRONE_GETTINGDOWN	= 0
PRONE_INPRONE		= 1
PRONE_GETTINGUP		= 2
PRONE_NOTINPRONE	= 3

-- The impulse number to be used for toggling prone.
-- If anybody steals my number there will be hell to pay.
PRONE_IMPULSE = 127

-- If this is true then the prone mod will try to add compatibility for addons which it doesn't work well with.
prone.AddonCompatibility = true

function prone.WritePlayer(ply)
	if IsValid(ply) then
		net.WriteUInt(ply:EntIndex(), 7)
	else
		net.WriteUInt(0, 7)
	end
end

function prone.ReadPlayer()
	local i = net.ReadUInt(7)
	if not i then
		return
	end
	return Entity(i)
end

hook.Add("Initialize", "prone.Initialize", function()
	-- Make sure we load the files in the right order. Config first, then sh_prone, then the rest.
	if SERVER then

		AddCSLuaFile("prone/config.lua")
		AddCSLuaFile("prone/sh_prone.lua")
		AddCSLuaFile("prone/cl_prone.lua")
		AddCSLuaFile( "prone/cl_wiltos_extension.lua" )

		include("prone/config.lua")
		include("prone/sh_prone.lua")
		include("prone/sv_prone.lua")
	else
		include("prone/config.lua")
		include("prone/sh_prone.lua")
		include("prone/cl_prone.lua")
		include( "prone/cl_wiltos_extension.lua" )
	end
end)

-- Sandbox C-Menu
if CLIENT then
	hook.Add("PopulateToolMenu", "prone.SandboxOptionsMenu", function()
		spawnmenu.AddToolMenuOption("Utilities", "User", "prone_options", "Prone Options", "", "", function(panel)
			panel:SetName("Prone Mod")
			panel:AddControl("Header", {
				Text = "",
				Description = "Configuration menu for the Prone Mod."
			})

			panel:AddControl("Checkbox", {
				Label = "Enable the bind key",
				Command = "prone_bindkey_enabled"
			})

			panel:AddControl("Checkbox", {
				Label = "Double-tap the bind key",
				Command = "prone_bindkey_doubletap"
			})

			panel:AddControl("Checkbox", {
				Label = "Can press jump to get up",
				Command = "prone_jumptogetup"
			})

			panel:AddControl("Checkbox", {
				Label = "Double-tap jump to get up",
				Command = "prone_jumptogetup"
			})

			panel:AddControl("Numpad", {
				Label = "Set the Bind-Key",
				Command = "prone_bindkey_key"
			})
		end)
	end)
end

print( "[wOS] Experimental Prone Mod has been enabled!" )