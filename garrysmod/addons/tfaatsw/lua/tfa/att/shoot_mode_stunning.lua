if not ATTACHMENT then
	ATTACHMENT = {}
end

ATTACHMENT.Name = "Оглушающий режим"
ATTACHMENT.Description = { TFA.AttachmentColors["+"], "Оглушение цели на 10 секунд", TFA.AttachmentColors["-"], "Нету урона" }
ATTACHMENT.Icon = "entities/switch_stun.png"
ATTACHMENT.ShortName = "Stun"

ATTACHMENT.WeaponTable = {
	["Primary"] = {
		["Damage"] = function(wep,stat) return 1 end,
		["Recoil"] = function(wep,stat) return stat * 0.95 end,
	},
}

function ATTACHMENT:Attach( wep )

wep.PrimaryAttackOLD = wep.PrimaryAttack
wep.Primary.Automatic = false
wep.SelectiveFire = false
wep.OnlyBurstFire = true 
wep.TracerName = "effect_sw_stun_blue"
wep:SetFireMode(2)

wep.PrimaryAttack = function (myself, ...)	
wep.PrimaryAttackOLD(myself, ...)
	if timer.RepsLeft( "CDDC15s" ..myself.Owner:UserID() ) != nil then return end 
			local trace = myself.Owner:GetEyeTrace()
					if trace.HitPos:Distance(myself.Owner:GetShootPos()) >= 770 then return end
						if trace.Entity:IsPlayer() and trace.Entity:Team() != ( TEAM_obiwan or TEAM_plokoon or TEAM_shaakti or TEAM_analkin or TEAM_REVAN or TEAM_chlen ) then
						ply = trace.Entity 
						if (SERVER) then SendUserMessage("blackScreen", ply, true) ply:Lock() end
						ply:SetNWBool("Cangugdc", true)
				
						timer.Create("syphonfreeze" .. ply:SteamID(), 10, 1, function()
						if (SERVER) then SendUserMessage("blackScreen", ply, false) ply:UnLock() end
						ply:SetNWBool("Cangugdc", false)
						end) 
						timer.Create("CDDC15s" .. myself.Owner:UserID(), 60, 1, function() if CLIENT then notification.AddLegacy( "Оглушающий режим готов(DC15S)", NOTIFY_GENERIC, 2 ) end end)
			end
	end
end

function ATTACHMENT:Detach( wep )
wep.PrimaryAttack = wep.PrimaryAttackOLD
wep.Primary.Automatic = true
wep:SetFireMode(1)
wep.SelectiveFire = true
wep.OnlyBurstFire = false
wep.TracerName = "effect_sw_laser_blue"
wep.DefaultFireMode = ""
end

if not TFA_ATTACHMENT_ISUPDATING then
	TFAUpdateAttachments()
end

--OCF || Content || Pack Deleted