

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "LL-30M"			
	SWEP.Author				= "Syntax_Error752"
	SWEP.ViewModelFOV      	= 70
	SWEP.Slot				= 1
	SWEP.SlotPos			= 5
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/killicons/LL30")
	
	killicon.Add( "weapon_752_ll30", "HUD/killicons/LL30", Color( 255, 80, 0, 255 ) )
	
end

SWEP.HoldType				= "pistol"
SWEP.Base					= "tfa_swsft_base"

SWEP.Category = "TFA Star Wars"

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= false

SWEP.ViewModel				= "models/weapons/v_LL30.mdl"
SWEP.WorldModel				= "models/weapons/w_LL30.mdl"

SWEP.Primary.Sound = Sound ("weapons/LL30_fire.wav");
SWEP.Primary.ReloadSound = Sound ("weapons/LL30_reload.wav");

SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false

SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 55
SWEP.Primary.NumShots		= 1
SWEP.Primary.Spread			= 0.0005
SWEP.Primary.IronAccuracy = 0.0001
SWEP.Primary.ClipSize		= 25
SWEP.Primary.RPM = 350
SWEP.Primary.DefaultClip	= 75
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.TracerName = "effect_sw_laser_red"

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector(-3.681, -6.755, 2.869)
SWEP.IronSightsAng = Vector(0, 0, 0)

--Misc
SWEP.IronRecoilMultiplier=0.0001 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.1  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=0.9  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=0.5  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier=0.5  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier=0.0001 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier=0.7 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier=1.1--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier=0.7--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.03 --The time to enter ironsights/exit it.
SWEP.NearWallTime = 0.0025 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.0005 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.5 --Multiply the player's movespeed by this when sighting.
SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/rtcircle.mdl", bone = "Box01", rel = "", pos = Vector(-2.609, -2.51, -0.04), angle = Angle(0, 180, 0), size = Vector(0.259, 0.259, 0.259), color = Color(255, 255, 255, 255), surpresslightning = false, material = "!tfa_rtmaterial", skin = 0, bodygroup = {} }
}

local function  drawFilledCircle( x, y, radius, seg )
	local kirkle = {}

	table.insert(kirkle, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert(kirkle, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert(kirkle, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly(kirkle)
end
	
local weaponcol = Color(0.435*255,0.10*255,0.7*255,255)

local ceedee = {}

SWEP.RTMaterialOverride = -1 --the number of the texture, which you subtract from GetAttachment

SWEP.RTOpaque = true

local g36
if surface then
	g36 = surface.GetTextureID("scope/gdcw_nvgilluminatedduplex") --the texture you vant to use
end

SWEP.RTCode = function( self, mat )
	
	render.OverrideAlphaWriteEnable( true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-256,-256,512,512)
	render.OverrideAlphaWriteEnable( true, true)
	
	local ang = self.Owner:EyeAngles()
	
	local AngPos = self.Owner:GetViewModel():GetAttachment(1)
	
	if AngPos then
	
		ang = AngPos.Ang
		
		ang:RotateAroundAxis(ang:Right(), -0.02)
		ang:RotateAroundAxis(ang:Up(), 0.07)

	end
	

	
	ceedee.angles = ang
	ceedee.origin = self.Owner:GetShootPos()
	
	ceedee.x = 0
	ceedee.y = 0
	ceedee.w = 512	
	ceedee.h = 512
	ceedee.fov = 6
	ceedee.drawviewmodel = false
	ceedee.drawhud = false
	
	
	if self.CLIronSightsProgress>0.01 then
		render.RenderView(ceedee)
	end
		
	render.OverrideAlphaWriteEnable( false, true)
	
	
	cam.Start2D()
		draw.NoTexture()
		surface.SetDrawColor(ColorAlpha(color_black,0))
		surface.DrawTexturedRect(0,0,512,512)
		surface.SetDrawColor(color_white)
		surface.SetTexture(g36)
		surface.DrawTexturedRect(-256,-256,1024,1024)
		draw.NoTexture()
		surface.SetDrawColor(ColorAlpha(color_black,(1-self.CLIronSightsProgress)*255))
		surface.DrawTexturedRect(0,0,512,512)
	cam.End2D()
	
end
SWEP.IronSightsSensitivity = 0.25 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.

SWEP.DoProceduralReload = true
SWEP.ProceduralReloadTime = 1.5