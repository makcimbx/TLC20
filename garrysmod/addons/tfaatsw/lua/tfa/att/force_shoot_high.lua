if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Сила выстрела:Сильно"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Повышенный урон", TFA.AttachmentColors["-"], "На 50% больше отдача", TFA.AttachmentColors["-"], "Меньше выстрелов"}
ATTACHMENT.Icon = "entities/switch_high.png" 
ATTACHMENT.ShortName = "HIGH"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 75 end,
		["Recoil"] = function(wep,stat) return stat * 1.50 end,
		["ClipSize"] = function(wep,stat) return 30 end,
	},
}

function ATTACHMENT:Attach( wep )
if wep:Clip1() > 30 then
wep:SetClip1( 30 )
end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
