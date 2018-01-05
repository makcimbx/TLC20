
if(CLIENT) then
	SWEP.PrintName = "Defibrillator"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

local tohide = {["CHudAmmo"] = false,["CHudSecondaryAmmo"] = false}
local function Kun_HideHud(name)
	local ply = LocalPlayer()
	if(ply != nil and ply:IsValid() and ply:GetActiveWeapon() != nil and ply:GetActiveWeapon():IsValid() and ply:GetActiveWeapon():GetClass() == "darkrp_defibrillator") then
		if (tohide[name] != nil) then 
			return false
		end 
	end
end 
hook.Add("HUDShouldDraw", "Kun_HideHud", Kun_HideHud)

function SWEP:DrawHUD()
	surface.SetDrawColor( 0, 0, 0, 255) 
	surface.DrawRect(ScrW() / 2 - 50, ScrH() / 2 + 30, 100, 20)
	draw.SimpleText( "Charge: "..LocalPlayer():GetNWInt("DefibCharge").."/"..Kun_DefibChargeAmtNeed, "TargetID", ScrW() / 2, ScrH() / 2 + 40, Color(250,250,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	return
end