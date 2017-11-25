if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Сила выстрела:Слабо"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Больше кол-во выстрелов", TFA.AttachmentColors["+"], "На 10% ниже отдача", TFA.AttachmentColors["-"], "Пониженный урон"}
ATTACHMENT.Icon = "entities/switch_low.png" 
ATTACHMENT.ShortName = "LOW"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 30 end,
		["Recoil"] = function(wep,stat) return stat * 0.90 end,
		["ClipSize"] = function(wep,stat) return 100 end,
	},
}


function ATTACHMENT:Detach( wep )
if wep:Clip1() > 50 then
wep:SetClip1( 50 )
end
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end
