if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Включение прицела"
--ATTACHMENT.ID = "base" -- normally this is just your filename
ATTACHMENT.Description = { TFA.AttachmentColors["="], "7x прицел", TFA.AttachmentColors["-"], "На 30% медленней скорость прицеливания",  TFA.AttachmentColors["-"], "На 10% медленей хотьба при прицеливание" }
ATTACHMENT.Icon = "entities/switch_scopem5.png" --Revers to label, please give it an icon though!  This should be the path to a png, like "entities/tfa_ammo_match.png"
ATTACHMENT.ShortName = "M5"

local fov = 90 / 7 / 2 -- Default FOV / Scope Zoom / screenscale

ATTACHMENT.WeaponTable = {
	["VElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["scope_mosin"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		},
		["scope_mosin_lens"] = {
			["active"] = true
		}
	},
	["WElements"] = {
		["rail_sights"] = {
			["active"] = true
		},
		["scope_mosin"] = {
			["active"] = true
		},
		["sights_folded"] = {
			["active"] = false
		}
	},
	["IronSightsPos"] = function( wep, val ) return wep.IronSightsPos_Westarm5 or val end,
	["IronSightsAng"] = function( wep, val ) return wep.IronSightsAng_Westarm5 or val end,
	["IronSightsSensitivity"] = function(wep,val)
		local res = val * wep:Get3DSensitivity( )
		return res, false, true
	end ,
	["Secondary"] = {
		["IronFOV"] = function( wep, val ) return val * 0.9 end,
		["ScopeZoom"] = function( wep, val ) return 8.7 end
	},
	["IronSightTime"] = function( wep, val ) return val * 1.30 end,
	["IronSightMoveSpeed"] = function(stat) return stat * 0.9 end,
	["RTScopeFOV"] = fov,
	["RTOpaque"] = -1,
	["RTMaterialOverride"] = -1
}

local shadowborder = 256

local cd = {}

local myret
local myshad
local debugcv = GetConVar("cl_tfa_debug_rt")

ATTACHMENT.FOV = fov
ATTACHMENT.Reticule = "models/weapons/tfa_ins2/optics/mosin_crosshair"

function ATTACHMENT:Attach(wep)
	if not IsValid(wep) then return end
	wep.RTCodeOld = wep.RTCodeOld or wep.RTCode
	wep.RTCode = function( myself , rt, scrw, scrh)
		if not IsValid(myself.Owner) then return end
		local rttw, rtth
		rttw = ScrW()
		rtth = ScrH()
		local att, ts
		if wep:VMIV() then
			att = wep.OwnerViewModel:GetAttachment( wep.RTAttachment_Westarm5 or 0 )
		end
		if att and att.Pos then
			if not wep.LastOwnerPos then
				wep.LastOwnerPos = wep.Owner:GetShootPos()
			end

			local owoff = wep.Owner:GetShootPos() - wep.LastOwnerPos
			wep.LastOwnerPos = wep.Owner:GetShootPos()
			local pos = att.Pos - owoff
			ts = pos:ToScreen()
		end
		if not myret then
			myret = Material( self.Reticule )
		end
		if not myshad then
			myshad = Material( "vgui/scope_shadowmask_test")
		end

		local ang = myself.Owner:EyeAngles()
		if wep.ScopeAngleTransforms_Mosin then
			ang:RotateAroundAxis(ang:Right(), wep.ScopeAngleTransforms_Westarm5.p )
			ang:RotateAroundAxis(ang:Up(), wep.ScopeAngleTransforms_Westarm5.y )
			ang:RotateAroundAxis(ang:Forward(), wep.ScopeAngleTransforms_Westarm5.r )
		end
		cd.angles = ang
		cd.origin = myself.Owner:GetShootPos()
		cd.x = 0
		cd.y = 0
		cd.w = rttw
		cd.h = rtth
		cd.fov = self.FOV
		cd.drawviewmodel = false
		cd.drawhud = false
		render.Clear(0, 0, 0, 255, true, true)
		if myself.CLIronSightsProgress > 0.005 then
			render.RenderView(cd)
		end
		cam.Start2D()
		if ts then
			local scrpos = ts

			scrpos.x = scrpos.x / scrw
			scrpos.y = scrpos.y / scrh

			scrpos.x = scrpos.x - 0.5
			scrpos.y = scrpos.y - 0.5
			if wep.ScopeOverlayTransforms_Mosin then
				scrpos.x = scrpos.x + wep.ScopeOverlayTransforms_Westarm5[1]
				scrpos.y = scrpos.y + wep.ScopeOverlayTransforms_Westarm5[2]
			end
			scrpos.x = scrpos.x * rttw
			scrpos.y = scrpos.y * rtth
			scrpos.x = math.Clamp(scrpos.x, -1024, 1024)
			scrpos.y = math.Clamp(scrpos.y, -1024, 1024)

			if wep.ScopeOverlayTransformMultiplier_Mosin then
				scrpos.x = scrpos.x * wep.ScopeOverlayTransformMultiplier_Westarm5
				scrpos.y = scrpos.y * wep.ScopeOverlayTransformMultiplier_Westarm5
			end

			if not self.scrpos then
				self.scrpos = scrpos
			end

			self.scrpos.x = math.Approach(self.scrpos.x, scrpos.x, (scrpos.x - self.scrpos.x) * FrameTime() * 10)
			self.scrpos.y = math.Approach(self.scrpos.y, scrpos.y, (scrpos.y - self.scrpos.y) * FrameTime() * 10)
			scrpos = self.scrpos

			local rtow, rtoh = 0, 0
			if wep.RTScopeOffset_Mosin then
				rtow = self.RTScopeOffset_Mosin[1] * rttw
				rtoh = self.RTScopeOffset_Mosin[2] * rtth
			end
			local rtw, rth = rttw * 1, rtth * 1
			if self.RTScopeScale_Mosin then
				rtw = rtw * self.RTScopeScale_Mosin[1]
				rth = rth * self.RTScopeScale_Mosin[2]
			end
			local distfac = math.pow( 1 - math.Clamp( ( att.Pos:Distance( wep.Owner:GetShootPos() ) - ( wep.ScopeDistanceMin_Westarm5 or 2 ) ) / ( wep.ScopeDistanceRange_Westarm5 or 10 ), 0, 1 ), 1 )
			rtw = Lerp( distfac, rtw * 0.1, rtw * 2 )
			rth = Lerp( distfac, rth * 0.1, rth * 2 )
			local cpos = Vector( -scrpos.x + rttw / 2, -scrpos.y + rtth / 2, 0 )
			cpos.x = math.Round(cpos.x)
			cpos.y = math.Round(cpos.y)

			surface.SetMaterial(myret)
			surface.SetDrawColor(color_white)
			if debugcv and debugcv:GetBool() then
				surface.DrawTexturedRect( rttw / 2 - rtw / 4 + rtow, rtth / 2 - rth / 4 + rtoh, rtw / 2, rth / 2)
			else
				surface.DrawTexturedRect( cpos.x - rtw / 4 + rtow, cpos.y - rth / 4 + rtoh, rtw / 2, rth / 2)

				surface.SetMaterial(myshad)
				surface.SetDrawColor(color_white)
				surface.DrawTexturedRect( cpos.x - rtw / 2, cpos.y - rth / 2, rtw, rth )

				surface.SetDrawColor(color_black)
				surface.DrawRect( cpos.x - rtw / 2 - 2047, cpos.y - 1024, 2048, 2048)
				surface.DrawRect( cpos.x + rtw / 2 - 1, cpos.y - 1024, 2048, 2048)
				surface.DrawRect( cpos.x - 1024, cpos.y - rtw / 2 - 2047, 2048, 2048)
				surface.DrawRect( cpos.x - 1024, cpos.y + rtw / 2 - 1, 2048, 2048)
			end
		else
			surface.SetMaterial(myret)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(0,0,rttw,rtth)
			surface.SetMaterial(myshad)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(-shadowborder, -shadowborder, shadowborder * 2 + rttw , shadowborder * 2 + rtth )
		end
		surface.SetDrawColor(ColorAlpha(color_black, 255 * (1 - myself.CLIronSightsProgress)))
		surface.DrawRect(0, 0, scrw, scrh)
		cam.End2D()
	end
end

function ATTACHMENT:Detach(wep)
	if not IsValid(wep) then return end
	wep.RTCode = wep.RTCodeOld
	wep.RTCodeOld = nil
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
