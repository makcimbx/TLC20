
function GM:PlayerLoadout(ply)
    self.Sandbox.PlayerLoadout(self, ply)


    ply.RPLicenseSpawn = true
    timer.Simple(1, function()
        if not IsValid(ply) then return end
        ply.RPLicenseSpawn = false
    end)

    --[[local jobTable = ply:getJobTable()

    for k,v in pairs(jobTable.weapons or {}) do
        ply:Give(v)
    end

    if jobTable.PlayerLoadout then
        local val = jobTable.PlayerLoadout(ply)
        if val == true then
            ply:SwitchToDefaultWeapon()
            return
        end
    end

    if jobTable.ammo then
        for k, v in pairs(jobTable.ammo) do
            ply:SetAmmo(v, k)
        end
    end]]--

    for k, v in pairs(self.Config.DefaultWeapons) do
        ply:Give(v)
    end

    CAMI.PlayerHasAccess(ply, "DarkRP_GetAdminWeapons", function(access)
        if not access or not IsValid(ply) then return end

        for k,v in pairs(GAMEMODE.Config.AdminWeapons) do
            ply:Give(v)
        end

        if not GAMEMODE.Config.AdminsCopWeapons then return end

        --ply:Give("door_ram")
        --ply:Give("arrest_stick")
        --ply:Give("unarrest_stick")
        ply:Give("stunstick")
        ply:Give("weaponchecker")
    end)

    ply:SwitchToDefaultWeapon()
end

function BOX_PlayerLoadout(ply)
	if(ply.newSpawn == true)then
		ply.newSpawn = false
		local jobTable = ply:getJobTable()
	
		for k,v in pairs(jobTable.weapons or {}) do
			ply:Give(v,true)
		end
	else
		if((ply:getJobTable().maxAM or 0)==ply:Armor())then
			DarkRP.notify(ply, 1, 4, "Ты не можешь взять больше!")
		else
			ply:SetArmor(ply:getJobTable().maxAM or 0)
		end
	end
end

local function spawn( ply )
	ply:StripAmmo()
	ply.newSpawn = true
	PrintTable(RPExtraTeams[ply:Team()])
	ply:SetHealth(ply:getJobTable().maxHP or 100)
end
hook.Add( "PlayerSpawn", "PlayerSpawn", spawn )

local function change(ply, oldTeam, newTeam)
	ply:StripAmmo()
	ply.newSpawn = true
end
hook.Add( "OnPlayerChangedTeam", "Ever_OnPlayerChangedTeam", change )

local function PlayerDeath( ply, i, a )
	ply:StripAmmo()
	ply.newSpawn = true
end
hook.Add( "PlayerDeath", "Ever_PlayerDeath", PlayerDeath )