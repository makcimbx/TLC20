resource.AddFile("resource/fonts/BebasNeue.otf")
AS = AS or {}
local ScreenHeight
if CLIENT then
	ScreenHeight = ScrH()
else
	ScreenHeight = 20
end
--CONFIG--
AS.BoxSize = ScreenHeight/12 -- Change the default box size. It depends on your screen height.
AS.HeightOffset = ScreenHeight/5 -- Change vertical position of the hud. It also depends on your screens height.
AS.Spacing = 10 -- Change spacing between the boxes
AS.SideSpacing = 14 -- Change the spacing between the screen edge and the hud
AS.RectMul = 3 -- How long should the weapon boxes be
AS.AutoHideTime = 4 -- Time after the hud hides (in seconds)

AS.SelectedColor = Color(140, 140, 140, 255) -- Selected box color 
AS.OutlineColor = Color(30,30,30,255) -- Outline color
AS.UnselectedColor = Color(60,60,60,255)  -- Unselected box color
AS.UnselectedAltColor = Color(75, 75, 75, 255) -- Unselected color used in additional weapon boxes
AS.EmptyColor = Color(40,40,40,255) -- Empty box color
AS.WepBoxOutlineColor = Color(30,30,30,255)  -- Color of the border around weapon icon box
AS.WepBoxBackgroundColor = Color(60,60,60,255) -- Color of the weapon icon box
AS.UnselectedFontColor = Color(255, 255, 255, 100) -- Font color used in unselected boxes
AS.SelectedFontColor = Color(255, 255, 255, 255) -- Font color used in selected boxes

AS.AllowDisabling = 1 -- Allow players to disable the hud through the menu or the command. (aesthetic_menu 0)

AS.WeaponRotationSpeed = 50
AS.WeaponModelColor = Color(200, 200, 200, 55) -- Change the displayed weapons color
AS.WeaponMaterialOverride = "models/wireframe" -- Change to "" if you don't want to override material / "models/wireframe" for the default wireframe look
AS.DefaultWeaponModel = "models/weapons/w_toolgun.mdl" -- If a weapon doesn't have a world model what should we use?

AS.MovingSound = "Player.WeaponSelectionMoveSlot" -- Sound when switching weapons
AS.SelectionSound = "Player.WeaponSelected" -- Weapon selection sound

-- Header font
surface.CreateFont( "AS.HeaderFont", {
    font = "Impact",    
	size = ScreenHeight/28,
	weight = 10,
	blursize = 0,
	scanlines = 2,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = true,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
})

-- Main font
surface.CreateFont( "AS.NormalSizeFont", {
    font = "BebasNeue",    
	size = ScreenHeight/54,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = true,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = true,
	outline = true,
})