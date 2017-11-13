// Love Manolis Vrondakis. @vrondakis

surface.CreateFont( "HeadBar", { // XP Bar font
	 font = "Tahoma",
	 size = 13,
	 weight = 500,
	 blursize = 0,
	 scanlines = 0,
} )

surface.CreateFont("LevelPrompt", { // Level prompt font
	font = "Francois One",
	size = 70,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
}) 


// I hate this fucking DrawDisplay function. Eurgh.
local function DrawDisplay()
local shouldDraw, players = hook.Call("HUDShouldDraw", GAMEMODE, "DarkRP_EntityDisplay")
	if shouldDraw == false then return end
	local shootPos = LocalPlayer():GetShootPos()
	local aimVec = LocalPlayer():GetAimVector()
	for k, ply in pairs(players or player.GetAll()) do
		if not ply:Alive() then continue end
		local hisPos = ply:GetShootPos()
		if GAMEMODE.Config.globalshow and ply ~= localplayer then
				local pos = ply:EyePos()
				pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
				pos = pos:ToScreen()
				pos.y = pos.y-20
		elseif not GAMEMODE.Config.globalshow and hisPos:Distance(shootPos) < 250 then
			local pos = hisPos - shootPos
			local unitPos = pos:GetNormalized()

				local trace = util.QuickTrace(shootPos, pos, localplayer)
				if trace.Hit and trace.Entity ~= ply then return end
					local pos = ply:EyePos()
					pos.z = pos.z + 10 -- The position we want is a bit above the position of the eyes
					pos = pos:ToScreen()
					pos.y = pos.y-20
		end
	end
 
	local tr = LocalPlayer():GetEyeTrace()

end
local OldXP = 0
local xp_bar = Material("tlcimages/xp_bar.png","noclamp smooth")
local function HUDPaint()
	if not LevelSystemConfiguration then return end
	if not LevelSystemConfiguration.EnableHUD then return end
	local PlayerLevel = LocalPlayer():getDarkRPVar('level')
	local PlayerXP = LocalPlayer():getDarkRPVar('xp')
	
	// Draw the XP Bar
	local percent = ((PlayerXP or 0)/(((10+(((PlayerLevel or 1)*((PlayerLevel or 1)+1)*90))))*LevelSystemConfiguration.XPMult)) // Gets the accurate level up percentage
	
	local drawXP = Lerp(8*FrameTime(),OldXP,percent)
	OldXP = drawXP
	local percent2 = percent*100
	percent2 = math.Round(percent2)
	percent2 = math.Clamp(percent2, 0, 99) //Make sure it doesn't round past 100%

	local posX = ScrW()/2
	local offset = -1
	local posY = ScrH()-46/2
	
	surface.SetDrawColor(0,0,0,200)
	surface.DrawRect(posX-(580/2)+offset,posY-(46/2),580,25)

	// Draw the XP Bar before the texture
	surface.SetDrawColor(LevelSystemConfiguration.LevelBarColor[1],LevelSystemConfiguration.LevelBarColor[2],LevelSystemConfiguration.LevelBarColor[3],255)
	surface.DrawRect(posX-(580/2)+offset,posY-(46/2),560*drawXP,25)

	//Render the texture
	surface.SetMaterial(xp_bar)
	surface.SetDrawColor(255,255,255,255)
	surface.DrawTexturedRect( posX-(746/0.602), posY-(46/0.118),  2500,822)

	// Render the text
	draw.DrawText(percent2 ..'%', "HeadBar", posX,posY-(25/1.2),(LevelSystemConfiguration.XPTextColor or Color(255,255,255,255)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)


	DrawDisplay()
end
hook.Add("HUDPaint", "manolis:MVLevels:HUDPaintA", HUDPaint) // IS THAT UNIQUE ENOUGH FOR YOU, FUCKING GMOD HOOKING BULLSHIT.


