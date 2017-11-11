local bHUD = surface.GetTextureID("ggui/star_wars/hud_back")
local fHUD = surface.GetTextureID("ggui/star_wars/hud_front")
local hBar = surface.GetTextureID("ggui/star_wars/health_bar")
local aBar = surface.GetTextureID("ggui/star_wars/armorbar")
local fBar = surface.GetTextureID("ggui/star_wars/foodbar")
local lowRes = ScrH() <= 720
local r = 128

surface.CreateFont("old_republic_32" , {
    font = "Aero Matics" ,
    size = 30
})

surface.CreateFont("old_republic_24" , {
    font = "Aero Matics" ,
    size = 18
})

surface.CreateFont("sw_ui_24b" , {
    font = "Aero Matics" ,
    size = 24 ,
    blursize = 1
})

surface.CreateFont("sw_ui_24" , {
    font = "Aero Matics" ,
    size = 24
})

surface.CreateFont("sw_ui_32b" , {
    font = "Aero Matics" ,
    size = 32 ,
    blursize = 1
})

surface.CreateFont("sw_ui_32" , {
    font = "Aero Matics" ,
    size = 32
})

surface.CreateFont("sw_ui_48" , {
    font = "Aero Matics" ,
    size = 64
})

surface.CreateFont("sw_ui_48b" , {
    font = "Aero Matics" ,
    size = 64 ,
    blursize = 1
})

surface.CreateFont("sw_ui_18b" , {
    font = "Aero Matics" ,
    size = 18 ,
    blursize = 1
})

surface.CreateFont("sw_ui_18" , {
    font = "Aero Matics" ,
    size = 18
})

surface.CreateFont("sw_ui_14" , {
    font = "Aero Matics" ,
    size = 16
})

surface.CreateFont("sw_ui_14_shadow" , {
    font = "Aero Matics" ,
    size = 16,
    shadow = true
})

if (IsValid(modelPanel)) then
    modelPanel:Remove()
end

local function createDModel()
    if (IsValid(LocalPlayer())) then
        modelPanel = vgui.Create("CircularPlayer")
        modelPanel:SetSize(100 , 100)
        modelPanel:SetPos(40 , ScrH() - 136)
    end
end

local damageList = { }
local damageColors = { Color(235 , 235 , 235) , Color(100 , 255 , 50) , Color(200 , 200 , 50) , Color(255 , 150 , 0) , Color(255 , 0 , 0) }

net.Receive("SW.ShowHitMarker" , function(l , ply)
    local dmg = math.Round(net.ReadFloat())
    local pos = net.ReadVector()

    table.insert(damageList , {
        Damage = dmg ,
        Pos = pos ,
        LifeTime = 3 ,
        TimeStamp = math.Round(CurTime()) ,
        Direction = math.random(-2.5 , 2.5)
    })
end)

hook.Add("PostDrawTranslucentRenderables" , "StarWars.DrawHitMarkers" , function()
    local ang = EyeAngles()
    ang:RotateAroundAxis(ang:Right() , 90)
    ang:RotateAroundAxis(ang:Up() , -90)

    for k , v in pairs(damageList) do
        local progress = v.LifeTime / 3
        cam.IgnoreZ(true)
        cam.Start3D2D(v.Pos + ang:Forward() * (1 - progress) * 16 * v.Direction - ang:Right() * (1 - progress) ^ 2 * 64 , ang , 0.5 - (v.LifeTime / 3) * 0.5)
        local c = damageColors[ math.Clamp(math.ceil(v.Damage / 25) , 1 , 5) ]
        draw.SimpleTextOutlined(v.Damage , "sw_ui_24" , 0 , 0 , Color(c.r , c.g , c.b , progress * 255) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP , 2 , Color(0 , 0 , 0 , progress * 255))
        cam.End3D2D()
        cam.IgnoreZ(false)
        v.LifeTime = v.LifeTime - FrameTime()

        if (v.LifeTime <= 0) then
            table.RemoveByValue(damageList , v)

            return
        end
    end
end)

local function drawCilinder(x , y , radius , seg , ang)
    local cir = { }

    table.insert(cir , {
        x = x ,
        y = y ,
        u = 0.5 ,
        v = 0.5
    })

    for i = 0 , seg do
        local a = math.rad((i / seg) * -360 + ang)

        table.insert(cir , {
            x = x + math.sin(a) * radius ,
            y = y + math.cos(a) * radius ,
            u = math.sin(a) / 2 + 0.5 ,
            v = math.cos(a) / 2 + 0.5
        })
    end

    local a = math.rad(0 + ang)

    table.insert(cir , {
        x = x + math.sin(a) * radius ,
        y = y + math.cos(a) * radius ,
        u = math.sin(a) / 2 + 0.5 ,
        v = math.cos(a) / 2 + 0.5
    })

    return cir
end

function GetAngleBetweenPoints(p1 , p2)
    local xDiff = p2.x - p1.x
    local yDiff = p2.y - p1.y

    return math.atan2(yDiff , xDiff) * (180 / math.pi)
end

local _material = Material("effects/flashlight001")

local function enableClip()
    render.ClearStencil()
    render.SetStencilEnable(true)
    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)
    render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
    render.SetStencilPassOperation(STENCILOPERATION_ZERO)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
    render.SetStencilReferenceValue(1)
end

local function disableClip()
    render.SetStencilEnable(false)
    render.ClearStencil()
end

local function drawClip()
    render.SetStencilFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
    render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
    render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
    render.SetStencilReferenceValue(1)
    draw.NoTexture()
    surface.SetMaterial(_material)
    surface.SetDrawColor(color_black)
end

local radar = surface.GetTextureID("ggui/star_wars/radar")
local radarOut = surface.GetTextureID("ggui/star_wars/radar_out")
local beacon = surface.GetTextureID("ggui/star_wars/plybeacon")
local wp = surface.GetTextureID("ggui/star_wars/weapon")
local nextRadar = 0
local radarTargets = { }
local prg = 0

local function drawRadar()
    surface.SetTexture(radar)
    surface.DrawTexturedRect(SW.RadarPos.x , SW.RadarPos.y , 256 , 256)
    local pw = drawCilinder(SW.RadarPos.x + 108 , SW.RadarPos.y + 102 , 95 , 16 , 0)
    enableClip()
    draw.NoTexture()
    surface.DrawPoly(pw)
    drawClip()

    local pAng = LocalPlayer():InVehicle() and (LocalPlayer():GetVehicle():GetAngles().y + 90) or LocalPlayer():EyeAngles().y

    if (SW.TracedRadar) then
        prg = 1 - (nextRadar - CurTime()) / SW.RadarUpdateRate

        if (nextRadar < CurTime()) then
            nextRadar = CurTime() + SW.RadarUpdateRate
            radarTargets = { }

            for k , v in pairs(ents.FindInSphere(EyePos(),2048)) do
                if (v ~= LocalPlayer() and (v:IsPlayer() or v:IsNPC())) then
                    local traceData = { } //76561198045250532
                    traceData.start = LocalPlayer():EyePos()
                    traceData.endpos = v:GetPos() + Vector(0,0,30) + (v:GetPos() - LocalPlayer():GetPos()):GetNormalized():Angle():Forward() * 32
                    traceData.mask = MASK_VISIBLE_AND_NPCS
                    traceData.filter = LocalPlayer()
                    local tr = util.TraceLine(traceData)

                    if (tr.Entity == v) then
                        table.insert(radarTargets , { tr.Entity:IsPlayer() and tr.Entity:Team() or 1, tr.Entity:GetPos() , tr.Entity:IsPlayer() and tr.Entity:EyeAngles() or tr.Entity:GetAngles(), tr.Entity:IsPlayer()})
                    end
                end
            end
        end

        surface.SetTexture(beacon)

        for k , v in pairs(radarTargets) do
            if (v == LocalPlayer()) then continue end
            local pos = v[ 2 ]
            local dist = pos:Distance(LocalPlayer():GetPos()) / 16
            local deltaY = GetAngleBetweenPoints(pos , LocalPlayer():GetPos()) - 270 - pAng
            local px = dist * math.cos(math.rad(deltaY)) * -1
            local py = dist * math.sin(math.rad(deltaY))
            local c = v[4] and team.GetColor(v[ 1 ]) or Color(200,150,0)
            surface.SetDrawColor(c.r , c.g , c.b , (1 - prg) * 255)
            surface.DrawTexturedRectRotated(SW.RadarPos.x + 109 + px , SW.RadarPos.y + 109 + py , v[4] and 16 or 8 , v[4] and 32 or 16 , v[ 3 ].y - EyeAngles().y + 180)
        end

        prg = prg * (SW.RadarUpdateRate * 3)
        surface.SetTexture(radarOut)
        surface.SetDrawColor(255 , 255 , 255 , 100)
        surface.DrawTexturedRectRotated(SW.RadarPos.x + 110 + prg * 14 , SW.RadarPos.y + 110 + prg * 14 , 256 * prg , 256 * prg , 0)
        prg = prg / (SW.RadarUpdateRate * 3)
    else

        for k , v in pairs(player.GetAll()) do
            if (v == LocalPlayer()) then continue end
            local pos = v:GetPos()
            local dist = pos:Distance(LocalPlayer():GetPos()) / 16
            local deltaY = GetAngleBetweenPoints(pos , LocalPlayer():GetPos()) - 270 - pAng
            local px = dist * math.cos(math.rad(deltaY)) * -1
            local py = dist * math.sin(math.rad(deltaY))
            surface.SetDrawColor(team.GetColor(v:Team()))
            surface.DrawTexturedRectRotated(SW.RadarPos.x + 109 + px , SW.RadarPos.y + 109 + py , 16 , 32 , v:EyeAngles().y - EyeAngles().y + 180)
        end

    end

    surface.SetTexture(beacon)
    surface.SetDrawColor(team.GetColor(LocalPlayer():Team()))
    surface.DrawTexturedRectRotated(SW.RadarPos.x + 108 , SW.RadarPos.y + 108 , 16 , 32 , 180)

    disableClip()

    surface.SetTexture(radarOut)
    surface.SetDrawColor(Color(255 , 255 , 255 , 255))
    surface.DrawTexturedRect(SW.RadarPos.x , SW.RadarPos.y , 256 , 256)
end

local function drawWeapon()
    if (not IsValid(LocalPlayer():GetActiveWeapon())) then return end
    surface.SetTexture(wp)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(ScrW() - 242 , ScrH() - 100 , 256 , 128)
    draw.SimpleText(LocalPlayer():GetActiveWeapon():GetPrintName() , "sw_ui_18" , ScrW() - 242 + 192 / 2 , ScrH() - 88 , Color(150 , 200 , 230) , TEXT_ALIGN_CENTER)

    if (LocalPlayer():GetActiveWeapon():Clip1() <= 0) then
        draw.SimpleText((LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) > 0 and LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) or " No ") .. " Ammo" , "sw_ui_24" , ScrW() - 242 + 192 / 2 , ScrH() - 68 , Color(200 , 180 , 130) , TEXT_ALIGN_CENTER)
    else
        draw.SimpleText(LocalPlayer():GetActiveWeapon():Clip1() .. " / " .. LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()) , "sw_ui_24" , ScrW() - 242 + 192 / 2 , ScrH() - 68 , Color(200 , 180 , 130) , TEXT_ALIGN_CENTER)
    end
end

hook.Add("HUDPaint" , "StarWars.HUDPaint" , function()
    if (not IsValid(modelPanel)) then
        createDModel()
    end

    surface.SetTexture(bHUD)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(32 , ScrH() - 128 - 16 , 512 , 128)

    if not (SW.Score and SW.Score:IsVisible() or SW.F4 and SW.F4:IsVisible()) or lowRes then
        draw.SimpleTextOutlined(LocalPlayer():Nick() , "old_republic_32" , 164 , ScrH() - 148 , Color(176 , 226 , 235) , nil , nil , 1 , color_black)
        draw.SimpleTextOutlined(team.GetName(LocalPlayer():Team()) , "old_republic_24" , 182 , ScrH() - 123 , team.GetColor(LocalPlayer():Team()) , nil , nil , 1 , color_black)
    end

    draw.SimpleTextOutlined(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")) , "old_republic_32" , 136 , ScrH() - 62 , Color(176 , 250 , 100) , nil , nil , 1 , color_black)
    surface.SetTexture(hBar)
    local p = 0.54 * math.Clamp(LocalPlayer():Health() / LocalPlayer():GetMaxHealth() , 0 , 1)
    surface.DrawTexturedRectUV(140 , ScrH() - 98 , 512 * p , 128 , 0 , 0 , p , 1)
    surface.SetTexture(aBar)

    if (SW.DrawHealthAmount) then
        draw.DrawNonParsedText(LocalPlayer():Health() .."HP", "sw_ui_14" , 140 + 512 * p-4, ScrH() - 102 , color_black , 2)
        draw.DrawNonParsedText(LocalPlayer():Health() .."HP" , "sw_ui_14" , 140 + 512 * p-4, ScrH() - 101 , color_white , 2)
    end

    p = 0.47 * (LocalPlayer():Armor() / 100)
    surface.DrawTexturedRectUV(140 , ScrH() - 88 , 512 * p , 128 , 0 , 0 , p , 1)
    surface.SetTexture(fBar)
    if (SW.EnableHungerMod) then
        p = 0.33 * (math.ceil(LocalPlayer():getDarkRPVar("Energy") or 0) / 100)
        surface.DrawTexturedRectUV(140 , ScrH() - 73 , 512 * p , 128 , 0 , 0 , p , 1)
    end
    if (SW.ShowLevelHUD) then
        draw.SimpleText(SW:ShowLevel(LocalPlayer()) , "sw_ui_14" , 150 , ScrH() - 114 , Color(176 , 226 , 235) , TEXT_ALIGN_CENTER)
    end
    local TimeString = os.date("%H:%M" , os.time())
    draw.SimpleText(TimeString , "sw_ui_14" , 380 , ScrH() - 70 , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT)

    if (SW.UseRadar) then
        drawRadar()
    end

    drawWeapon()
end)

local plyMeta = FindMetaTable("Player")
local Page = Material("icon16/page_white_text.png")

timer.Simple(0 , function()
    plyMeta.drawPlayerInfo = function(self)
        local pos = self:EyePos()
        local nick , plyTeam = self:Nick() , self:Team()
        local c = RPExtraTeams[ plyTeam ] and RPExtraTeams[ plyTeam ].color or team.GetColor(plyTeam)
        pos.z = pos.z + 10
        pos = pos:ToScreen()

        if not self:getDarkRPVar("wanted") then
            pos.y = pos.y - 50
        end

        draw.DrawNonParsedText(nick , "sw_ui_32b" , pos.x + 1 , pos.y - 9 , color_black , 1)
        draw.DrawNonParsedText(nick , "sw_ui_32b" , pos.x , pos.y - 10 , c , 1)
        local teamname = self:getDarkRPVar("job") or team.GetName(self:Team())
        draw.DrawNonParsedText(teamname , "sw_ui_24" , pos.x + 1 , pos.y + 40 , color_black , 1)
        draw.DrawNonParsedText(teamname , "sw_ui_24" , pos.x , pos.y + 39 , color_white , 1)

        if (SW.DrawHealth) then
            surface.SetDrawColor(0 , 0 , 0 , 255)
            surface.DrawRect(pos.x - 64 , pos.y + 28 , 128 , 10)
            surface.SetDrawColor(c)
            surface.DrawRect(pos.x - 63 , pos.y + 29 , 126 * math.Clamp(self:Health() / self:GetMaxHealth() , 0 , 1) , 8)
            surface.SetDrawColor(Color(255 , 255 , 255 , 100))
            surface.DrawRect(pos.x - 63 , pos.y + 29 , 126 * math.Clamp(self:Health() / self:GetMaxHealth() , 0 , 1) , 2)
            surface.DrawRect(pos.x - 63 , pos.y + 29 + 6 , 126 * math.Clamp(self:Health() / self:GetMaxHealth() , 0 , 1) , 2)

            if (SW.DrawHealthAmount) then
                draw.DrawNonParsedText(self:Health() .."HP", "sw_ui_14" , pos.x + 1 , pos.y + 25 , color_black , 1)
                draw.DrawNonParsedText(self:Health() .."HP" , "sw_ui_14" , pos.x , pos.y + 24 , color_white , 1)
            end

        end

        if self:getDarkRPVar("HasGunlicense") then
            surface.SetMaterial(Page)
            surface.SetDrawColor(255 , 255 , 255 , 255)
            surface.DrawTexturedRect(pos.x - 16 , pos.y + 60 , 32 , 32)
        end
    end
end)

local PANEL = { }

function PANEL:Init()
    self.modelPanel = vgui.Create("DModelPanel" , self)
    self.modelPanel:SetModel(LocalPlayer():GetModel())
    self.modelPanel:SetPaintedManually(true)
    self.modelPanel.LayoutEntity = function() end

    if (self.modelPanel.Entity:LookupBone("ValveBiped.Bip01_Head1") == nil) then
        local headpos = Vector(0 , 0 , 65)
        self.modelPanel:SetLookAt(headpos)
        self.modelPanel:SetCamPos(headpos - Vector(-17 , 2 , 0))
    else
        local headpos = self.modelPanel.Entity:GetBonePosition(self.modelPanel.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        self.modelPanel:SetLookAt(headpos)
        self.modelPanel:SetCamPos(headpos - Vector(-17 , 2 , 0))
    end
end

function PANEL:PerformLayout()
    self.modelPanel:SetSize(self:GetWide() , self:GetTall())
end

function surface.DrawSector(x , y , r , ang , rot)
    local segments = 360
    local segmentstodraw = 360 * (ang / 360)
    rot = (rot or 0) * (segments / 360)
    local poly = { }
    local temp = { }
    temp[ 'x' ] = x
    temp[ 'y' ] = y
    table.insert(poly , temp)

    for i = 1 + rot , segmentstodraw + rot do
        local temp = { }
        temp[ 'x' ] = math.cos((i * (360 / segments)) * (math.pi / 180)) * r + x
        temp[ 'y' ] = math.sin((i * (360 / segments)) * (math.pi / 180)) * r + y
        table.insert(poly , temp)
    end

    return poly
end

function PANEL:Paint(w , h)
    enableClip()

    if (not self.Circle) then
        self.Circle = surface.DrawSector(w / 2 , h / 2 , h / 2 * 0.85 , 360)
    end

    draw.NoTexture()
    surface.SetDrawColor(color_white)
    surface.DrawPoly(self.Circle)
    drawClip()
    self.modelPanel:SetPaintedManually(false)
    self.modelPanel:PaintManual()

    if (self.modelPanel.Entity:GetModel() ~= LocalPlayer():GetModel()) then
        self.modelPanel:SetModel(LocalPlayer():GetModel())
    end

    self.modelPanel:SetPaintedManually(true)
    disableClip()
    surface.SetTexture(fHUD)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(-6 , -10 , 512 , 128)
end

vgui.Register("CircularPlayer" , PANEL)

local hideHUDElements = {
    [ "CHudWeapon" ] = true ,
    [ "CHudSecondaryAmmo" ] = true ,
    [ "CHudAmmo" ] = true
}

hook.Add("HUDShouldDraw" , "SW.HideHUD" , function(name)
    if hideHUDElements[ name ] then return false end
end)
