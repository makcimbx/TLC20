if (!SW.EnableF4) then return end

SW.F4 = nil
local cl = Material("ggui/star_wars/close.png")
local lowRes = ScrH() <= 720
local lWidth = lowRes and 220 or 200
local PANEL = { }
PANEL.Categories = { }
PANEL.Child = { }

function PANEL:Init()
    SW.F4 = self
    self:SetSize(lowRes and 1024 or 1160 , lowres and 512 or 720)
    self:Center()
    self:SetTitle("")
    self:ShowCloseButton(false)
    self:MakePopup()
    self.cl = vgui.Create("DButton" , self)
    self.cl:SetSize(16 , 16)
    self.cl:SetPos(self:GetWide() - 32 , 12)
    self.cl:SetText("")

    self.cl.DoClick = function()
        self:Remove()
    end

    self.cl.Paint = function(s , w , h)
        surface.SetMaterial(cl)
        surface.SetDrawColor(s:IsHovered() and Color(218 , 198 , 0) or Color(0 , 198 , 218))
        surface.DrawTexturedRect(0 , 0 , w , h)
    end

    self:GenerateCategories()
end

local bg = lowRes and Material("ggui/star_wars/f4.png") or surface.GetTextureID("ggui/star_wars/f4menu")

function PANEL:Paint(w , h)
    if (lowRes) then
        surface.SetMaterial(bg)
    else
        surface.SetTexture(bg)
    end

    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(0 , 0 , lowRes and 1024 or 2048 , lowRes and 512 or 1024)
    surface.SetDrawColor(255 , 255 , 255 , 10)
    surface.DrawRect(lowRes and 32 or 42 , h - (lowRes and 74 or 78) , lWidth , 1)
    draw.SimpleText(SW.F4Title , "sw_ui_24b" , lowRes and 32 or 42 , h - (lowRes and 68 or 74) , Color(200 , 200 , 50))
    draw.SimpleText(SW.F4Title , "sw_ui_24" , lowRes and 32 or 42 , h - (lowRes and 68 or 74) , Color(255 , 200 , 100))
end

local can = { }
can.__index = __index

function can.canBuyentities(item)
    local ply = LocalPlayer()
    if istable(item.allowed) and not table.HasValue(item.allowed , ply:Team()) then return false end
    if item.customCheck and not item.customCheck(ply) then return false end
    local canbuy , _ , _ , price = hook.Call("canBuyCustomEntity" , nil , ply , item)
    local cost = price or item.getPrice and item.getPrice(ply , item.price) or item.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyshipments(ship)
    local ply = LocalPlayer()
    if not table.HasValue(ship.allowed , ply:Team()) then return false end
    if ship.customCheck and not ship.customCheck(ply) then return false end
    local canbuy , _ , _ , price = hook.Call("canBuyShipment" , nil , ply , ship)
    local cost = price or ship.getPrice and ship.getPrice(ply , ship.price) or ship.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyweapons(ship)
    local ply = LocalPlayer()
    if GAMEMODE.Config.restrictbuypistol and not table.HasValue(ship.allowed , ply:Team()) then return false end
    if ship.customCheck and not ship.customCheck(ply) then return false end
    local canbuy , _ , _ , price = hook.Call("canBuyPistol" , nil , ply , ship)
    local cost = price or ship.getPrice and ship.getPrice(ply , ship.pricesep) or ship.pricesep
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyammo(item)
    local ply = LocalPlayer()
    if item == nil then return false , true end
    if item.customCheck and not item.customCheck(ply) then return false end
    local canbuy , _ , _ , price = hook.Call("canBuyAmmo" , nil , ply , item)
    local cost = price or item.getPrice and item.getPrice(ply , item.price) or item.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyvehicles(item)
    local ply = LocalPlayer()
    local cost = item.getPrice and item.getPrice(ply , item.price) or item.price
    if istable(item.allowed) and not table.HasValue(item.allowed , ply:Team()) then return false end
    if item.customCheck and not item.customCheck(ply) then return false , true end
    local canbuy , suppress , message , price = hook.Call("canBuyVehicle" , nil , ply , item)
    cost = price or cost
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function PANEL:GenerateCategories()
    self.Categories = DarkRP.getCategories()
    self.Cats = { }
    local i = 0
    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(lWidth , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29)
    cat.Text = "In-Game"
    cat.Selected = false
    cat.Disabled = true
    cat.DoClick = function() end
    i = i + 1
    table.insert(self.Cats , cat)

    for k , v in pairs(self.Categories) do
        if (k ~= "jobs") then
            local am = 0

            for _ , cat in pairs(v) do
                for _ , item_def in pairs(cat.members) do
                    if (not can[ "canBuy" .. k ]) then
                        am = am + #cat.members
                        continue
                    end

                    if (can[ "canBuy" .. k ] and not can[ "canBuy" .. k ](item_def)) then continue end
                    am = am + 1
                end
            end

            if (am == 0) then continue end
        end

        if (v.canSee and not v:canSee(LocalPlayer())) then continue end
        local cat = vgui.Create("sw.f4.category" , self)
        cat:SetSize(lowRes and 230 or 210 , 29)
        cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29)
        cat.Text = string.upper(k[ 1 ]) .. string.sub(k , 2)
        cat.Selected = false
        i = i + 1
        table.insert(self.Cats , cat)
    end

    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(230 , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    cat.Text = "Информация"
    cat.Selected = false
    cat.Disabled = true
    cat.DoClick = function() end
    i = i + 1
    local fc = vgui.Create("sw.f4.category" , self)
    fc:SetSize(230 , 29)
    fc:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    fc.Text = "Правила"
    fc.Selected = false
    fc.ForceGold = true
    fc:DoClick()
    table.insert(self.Cats , fc)
    i = i + 1
    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(230 , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    cat.Text = "Вконтакте"
    cat.Selected = false
    cat.ForceGold = true

    cat.DoClick = function()
        gui.OpenURL(SW.WebsitePage)
    end

    table.insert(self.Cats , cat)
end

function PANEL:SkinScrollbar(sbar)
    sbar:SetWide(13)

    function sbar:Paint(w , h)
        draw.RoundedBox(0 , 1 , 2 , w , h , Color(20 , 20 , 20 , 20))
    end

    function sbar.btnUp:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 96 , 108))
    end

    function sbar.btnDown:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 95 , 108))
    end

    function sbar.btnGrip:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 65 , 88))
    end
end

function PANEL:OnRemove()
    for k , v in pairs(self.Child or { }) do
        v:Remove()
    end
end

function PANEL:SetSelection(str)
    for k , v in pairs(self.Cats) do
        v.Selected = v.Text == str
    end

    if (IsValid(self.Content)) then
        for k , v in pairs(self.Content.Child) do
            v:Remove()
        end

        self.Content:Remove()
    end

    self.Content = vgui.Create("DScrollPanel" , self)
    self:SkinScrollbar(self.Content:GetVBar())
    self.Content:SetPos(lowRes and 280 or 268 , lowRes and 68 or 84)
    self.Content.Child = { }
    self.Content:SetSize(lowRes and 706 or 870 , lowRes and 396 or 600)

    if (str == "Jobs" or str == "Правила") then
        if (str == "Jobs") then
            self.Content:SetSize(lowRes and 450 or 550 , lowRes and 396 or 585)
            self:createJobSection()
        else
            self:createRules()
        end
    else
        self:createEntities(string.lower(str))
    end
end

function PANEL:createRules()
    self.Content.Paint = function(s , w , h)
        draw.SimpleText("Правила:" , "sw_ui_48b" , w / 2 , 0 , Color(0 , 198 , 218) , TEXT_ALIGN_CENTER)
        draw.SimpleText("Правила:" , "sw_ui_48" , w / 2 , 0 , Color(0 , 198 , 218) , TEXT_ALIGN_CENTER)

        for k , v in pairs(SW.Rules) do
            draw.SimpleText("-" .. v , "sw_ui_24b" , 24 , 48 + k * 28 , Color(150 , 198 , 218))
            draw.SimpleText("-" .. v , "sw_ui_24" , 24 , 48 + k * 28 , Color(150 , 198 , 218))
        end

        surface.SetDrawColor(Color(255 , 255 , 255 , 10))
        surface.DrawRect(24 , 62 , w - 48 , 2)
    end
end

local cl = Material("ggui/star_wars/close.png")
local lowRes = ScrH() <= 720
local lWidth = lowRes and 220 or 200
local PANEL = { }
PANEL.Categories = { }
PANEL.Child = { }

function PANEL:Init()
    SW.F4 = self
    self:SetSize(lowRes and 1024 or 1160 , lowres and 512 or 720)
    self:Center()
    self:SetTitle("")
    self:ShowCloseButton(false)
    self:MakePopup()
    self.cl = vgui.Create("DButton" , self)
    self.cl:SetSize(16 , 16)
    self.cl:SetPos(self:GetWide() - 32 , 12)
    self.cl:SetText("")

    self.cl.DoClick = function()
        self:Remove()
    end

    self.cl.Paint = function(s , w , h)
        surface.SetMaterial(cl)
        surface.SetDrawColor(s:IsHovered() and Color(218 , 198 , 0) or Color(0 , 198 , 218))
        surface.DrawTexturedRect(0 , 0 , w , h)
    end

    self:GenerateCategories()
end

local bg = lowRes and Material("ggui/star_wars/f4.png") or surface.GetTextureID("ggui/star_wars/f4menu")

function PANEL:Paint(w , h)
    if (lowRes) then
        surface.SetMaterial(bg)
    else
        surface.SetTexture(bg)
    end

    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(0 , 0 , lowRes and 1024 or 2048 , lowRes and 512 or 1024)
    surface.SetDrawColor(255 , 255 , 255 , 10)
    surface.DrawRect(lowRes and 32 or 42 , h - (lowRes and 74 or 78) , lWidth , 1)
    draw.SimpleText(SW.F4Title , "sw_ui_24b" , lowRes and 32 or 42 , h - (lowRes and 68 or 74) , Color(200 , 200 , 50))
    draw.SimpleText(SW.F4Title , "sw_ui_24" , lowRes and 32 or 42 , h - (lowRes and 68 or 74) , Color(255 , 200 , 100))
end

local can = { }
can.__index = __index

function can.canBuyentities(item)
    local ply = LocalPlayer()
    if istable(item.allowed) and not table.HasValue(item.allowed , ply:Team()) then return false end
    if item.customCheck and not item.customCheck(ply) then return false end
    local canbuy , suppress , message , price = hook.Call("canBuyCustomEntity" , nil , ply , item)
    local cost = price or item.getPrice and item.getPrice(ply , item.price) or item.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyshipments(ship)
    local ply = LocalPlayer()
    if not table.HasValue(ship.allowed , ply:Team()) then return false end
    if ship.customCheck and not ship.customCheck(ply) then return false end
    local canbuy , suppress , message , price = hook.Call("canBuyShipment" , nil , ply , ship)
    local cost = price or ship.getPrice and ship.getPrice(ply , ship.price) or ship.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyweapons(ship)
    local ply = LocalPlayer()
    if GAMEMODE.Config.restrictbuypistol and not table.HasValue(ship.allowed , ply:Team()) then return false end
    if ship.customCheck and not ship.customCheck(ply) then return false end
    local canbuy , suppress , message , price = hook.Call("canBuyPistol" , nil , ply , ship)
    local cost = price or ship.getPrice and ship.getPrice(ply , ship.pricesep) or ship.pricesep
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyammo(item)
    local ply = LocalPlayer()
    if item == nil then return false , true end
    if item.customCheck and not item.customCheck(ply) then return false end
    local canbuy , suppress , message , price = hook.Call("canBuyAmmo" , nil , ply , item)
    local cost = price or item.getPrice and item.getPrice(ply , item.price) or item.price
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function can.canBuyvehicles(item)
    local ply = LocalPlayer()
    local cost = item.getPrice and item.getPrice(ply , item.price) or item.price
    if istable(item.allowed) and not table.HasValue(item.allowed , ply:Team()) then return false end
    if item.customCheck and not item.customCheck(ply) then return false , true end
    local canbuy , suppress , message , price = hook.Call("canBuyVehicle" , nil , ply , item)
    cost = price or cost
    if not ply:canAfford(cost) then return false end
    if canbuy == false then return false end

    return true
end

function PANEL:GenerateCategories()
    self.Categories = DarkRP.getCategories()
    self.Cats = { }
    local i = 0
    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(lWidth , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29)
    cat.Text = "In-Game"
    cat.Selected = false
    cat.Disabled = true
    cat.DoClick = function() end
    i = i + 1
    table.insert(self.Cats , cat)

    for k , v in pairs(self.Categories) do
        if (k ~= "jobs") then
            local am = 0

            for _ , cat in pairs(v) do
                for _ , item_def in pairs(cat.members) do
                    if (not can[ "canBuy" .. k ]) then
                        am = am + #cat.members
                        continue
                    end

                    if (can[ "canBuy" .. k ] and not can[ "canBuy" .. k ](item_def)) then continue end
                    am = am + 1
                end
            end

            if (am == 0) then continue end
        end

        if (v.canSee and not v:canSee(LocalPlayer())) then continue end
        local cat = vgui.Create("sw.f4.category" , self)
        cat:SetSize(lowRes and 230 or 210 , 29)
        cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29)
        cat.Text = string.upper(k[ 1 ]) .. string.sub(k , 2)
        cat.Selected = false
        i = i + 1
        table.insert(self.Cats , cat)
    end

    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(230 , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    cat.Text = "Information"
    cat.Selected = false
    cat.Disabled = true
    cat.DoClick = function() end
    i = i + 1
    local fc = vgui.Create("sw.f4.category" , self)
    fc:SetSize(230 , 29)
    fc:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    fc.Text = "Rules"
    fc.Selected = false
    fc.ForceGold = true
    fc:DoClick()
    table.insert(self.Cats , fc)
    i = i + 1
    local cat = vgui.Create("sw.f4.category" , self)
    cat:SetSize(230 , 29)
    cat:SetPos(lowRes and 26 or 36 , (lowRes and 55 or 84) + i * 29 + 8)
    cat.Text = "VKontakte"
    cat.Selected = false
    cat.ForceGold = true

    cat.DoClick = function()
        gui.OpenURL(SW.WebsitePage)
    end

    table.insert(self.Cats , cat)
end

function PANEL:SkinScrollbar(sbar)
    sbar:SetWide(13)

    function sbar:Paint(w , h)
        draw.RoundedBox(0 , 1 , 2 , w , h , Color(20 , 20 , 20 , 20))
    end

    function sbar.btnUp:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 96 , 108))
    end

    function sbar.btnDown:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 95 , 108))
    end

    function sbar.btnGrip:Paint(w , h)
        draw.RoundedBox(0 , 1 , 0 , w , h , Color(3 , 65 , 88))
    end
end

function PANEL:OnRemove()
    for k , v in pairs(self.Child or { }) do
        v:Remove()
    end
end

function PANEL:SetSelection(str)
    for k , v in pairs(self.Cats) do
        v.Selected = v.Text == str
    end

    if (IsValid(self.Content)) then
        for k , v in pairs(self.Content.Child) do
            v:Remove()
        end

        self.Content:Remove()
    end

    self.Content = vgui.Create("DScrollPanel" , self)
    self:SkinScrollbar(self.Content:GetVBar())
    self.Content:SetPos(lowRes and 280 or 268 , lowRes and 68 or 84)
    self.Content.Child = { }
    self.Content:SetSize(lowRes and 706 or 870 , lowRes and 396 or 600)

    if (str == "Jobs" or str == "Rules") then
        if (str == "Jobs") then
            self.Content:SetSize(lowRes and 450 or 550 , lowRes and 396 or 585)
            self:createJobSection()
        else
            self:createRules()
        end
    else
        self:createEntities(string.lower(str))
    end
end

function PANEL:createRules()
    self.Content.Paint = function(s , w , h)
        draw.SimpleText("Правила:" , "sw_ui_48b" , w / 2 , 0 , Color(0 , 198 , 218) , TEXT_ALIGN_CENTER)
        draw.SimpleText("Правила:" , "sw_ui_48" , w / 2 , 0 , Color(0 , 198 , 218) , TEXT_ALIGN_CENTER)

        for k , v in pairs(SW.Rules) do
            draw.SimpleText("-" .. v , "sw_ui_24b" , 24 , 48 + k * 28 , Color(150 , 198 , 218))
            draw.SimpleText("-" .. v , "sw_ui_24" , 24 , 48 + k * 28 , Color(150 , 198 , 218))
        end

        surface.SetDrawColor(Color(255 , 255 , 255 , 10))
        surface.DrawRect(24 , 62 , w - 48 , 2)
    end
end

function PANEL:createEntities(kind)
    local lastY = 0

    for _ , v in pairs(self.Categories[ kind ]) do
        if (#v.members == 0) then continue end
        local category = v.categorises
        local panel = vgui.Create("DPanel" , self.Content)
        panel:SetPos(0 , lastY)
        local c = v.color

        panel.Paint = function(s , w , h)
            surface.SetDrawColor(Color(c.r * 1.5 , c.g * 1.5 , c.b * 1.5))
            surface.DrawRect(0 , 0 , w - 19 , 32)
            surface.SetDrawColor(v.color)
            surface.DrawRect(1 , 1 , w - 21 , 30)
            surface.SetDrawColor(Color(c.r * 0.3 , c.g * 0.3 , c.b * 0.3))
            surface.DrawRect(1 , 1 , w - 21 , 24)
            draw.SimpleText(v.name , "sw_ui_18b" , 8 , 4 , Color(0 , 198 , 218))
            draw.SimpleText(v.name , "sw_ui_18" , 8 , 4 , Color(0 , 198 , 218))
        end

        local i = 0

        for k , item_def in pairs(v.members) do
            if (can[ "canBuy" .. category ] and not can[ "canBuy" .. category ](item_def)) then continue end
            local item = vgui.Create("sw.f4.item" , panel)
            item:SetSize(self.Content:GetWide() - 19 , 64)
            item:SetPos(0 , 33 + i * 66)
            item:SetData(item_def , kind)
            i = i + 1
        end

        panel:SetSize(self.Content:GetWide() , 32 + i * 66)

        if (i == 0) then
            panel:Remove()
        else
            lastY = lastY + panel:GetTall()
        end
    end
end

function PANEL:createJobSection()
    local lastY = 0

    for k , v in pairs(self.Categories[ "jobs" ]) do
        if (v:canSee(LocalPlayer())) then
            if (#v.members == 0) then continue end
            local panel = vgui.Create("DPanel" , self.Content)
            panel:SetSize(self.Content:GetWide() , 32 + #v.members * 66)
            panel:SetPos(0 , lastY)
            local c = v.color

            panel.Paint = function(s , w , h)
                surface.SetDrawColor(Color(c.r * 1.5 , c.g * 1.5 , c.b * 1.5))
                surface.DrawRect(0 , 0 , w - 19 , 32)
                surface.SetDrawColor(v.color)
                surface.DrawRect(1 , 1 , w - 21 , 30)
                surface.SetDrawColor(Color(c.r * 0.3 , c.g * 0.3 , c.b * 0.3))
                surface.DrawRect(1 , 1 , w - 21 , 24)
                draw.SimpleText(v.name , "sw_ui_18b" , 8 , 4 , Color(0 , 198 , 218))
                draw.SimpleText(v.name , "sw_ui_18" , 8 , 4 , Color(0 , 198 , 218))
            end

            for k , v in pairs(v.members) do
                local job = vgui.Create("sw.f4.job" , panel)
                job:SetSize(self.Content:GetWide() - 19 , 64)
                job:SetPos(0 , 33 + 66 * (k - 1))
                job.Data = v
                job.Team = v.team
                job.Job = v.name
                job:Initialize()
                self.Content.model = job.VModel
            end

            lastY = lastY + panel:GetTall()
        end
    end

    self.JobInfo = vgui.Create("DPanel" , self)
    table.insert(self.Content.Child , self.JobInfo)
    self.JobInfo:SetSize(lowRes and 244 or 312 , lowRes and 396 or 600)
    self.JobInfo:SetPos(lowRes and 740 or 822 , 68)
    self.JobInfo.mdl = vgui.Create("DModelPanel" , self.JobInfo)
    self.JobInfo.mdl:SetModel(LocalPlayer():GetModel())
    self.JobInfo.mdl:SetSize(self.JobInfo:GetWide() , lowRes and 148 or 320)
    self.JobInfo.mdl.LayoutEntity = function() end

    if (self.JobInfo.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") == nil) then
        local headpos = Vector(0 , 0 , 65)
        self.JobInfo.mdl:SetLookAt(headpos)
        self.JobInfo.mdl:SetCamPos(headpos - Vector(-17 , 2 , 0)) -- Move cam in front of face
        -- Move cam in front of face
    else
        local headpos = self.JobInfo.mdl.Entity:GetBonePosition(self.JobInfo.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        self.JobInfo.mdl:SetLookAt(headpos)
        self.JobInfo.mdl:SetCamPos(headpos - Vector(-17 , 2 , 0))
    end

    self.JobInfo.mdl.oPaint = self.JobInfo.mdl.Paint

    self.JobInfo.mdl.Paint = function(s , w , h)
        s:oPaint(w , h)

        if (s.Job) then
            draw.SimpleText(s.Job.name , "sw_ui_24b" , 2 , 0 , Color(s.Job.color.r * 1.5 , s.Job.color.g * 1.5 , s.Job.color.b * 1.5) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            draw.SimpleText(s.Job.name , "sw_ui_24" , 2 , 0 , Color(s.Job.color.r * 1.5 , s.Job.color.g * 1.5 , s.Job.color.b * 1.5) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
        end
    end

    self.JobInfo.desc = vgui.Create("DScrollPanel" , self.JobInfo)
    self.JobInfo.desc:SetPos(4 , lowRes and 156 or 324)
    self.JobInfo.desc:SetSize(self.JobInfo:GetWide() - 8 , lowRes and 105 or 140)
    self:SkinScrollbar(self.JobInfo.desc:GetVBar())
    self.JobInfo.desc.Text = vgui.Create("DPanel" , self.JobInfo.desc)

    self.JobInfo.desc.Text.Paint = function(s , w , h)
        if (self.JobInfo.Job) then
            local textList = string.Wrap("sw_ui_14" , self.JobInfo.Job.description , w)
            draw.SimpleText("Description:" , "sw_ui_14" , 4 , 0 , Color(150 , 255 , 50 , 125) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)

            for k , v in pairs(textList) do
                draw.SimpleText(v , "sw_ui_14" , 4 , (k - 1) * 20 + 18 , Color(200 , 200 , 200 , 125) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            end

            s:SetSize(lowRes and 218 or 286 , #textList * 20 + 18)
        end
    end

    self.JobInfo.Paint = function(s , w , h)
        surface.SetDrawColor(Color(255 , 255 , 255 , 100))

        if (s.Job) then
            draw.SimpleText("$" .. s.Job.salary .. "/hr" , "sw_ui_18b" , w - 8 , lowRes and 2 or 22 , Color(80 , 200 , 20) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            draw.SimpleText("$" .. s.Job.salary .. "/hr" , "sw_ui_18" , w - 8 , lowRes and 2 or 22 , Color(80 , 200 , 20) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            surface.SetDrawColor(Color(0 , 8 , 18))
            surface.DrawRect(2 , h - 130 , w - 4 , 128)
            surface.SetDrawColor(Color(255 , 255 , 255 , 100))
            surface.DrawRect(2 , lowRes and 148 or 320 , w - 4 , 2)
            surface.DrawRect(2 , lowRes and 290 or 496 , w - 4 , 2)
            draw.SimpleText("Loadout:" , "sw_ui_24b" , 4 , h - 130 , Color(200 , 200 , 20) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText("Loadout:" , "sw_ui_24" , 4 , h - 130 , Color(200 , 200 , 20) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            local weps = ""

            for k , v in pairs(s.Job.weapons) do
                weps = (weps or "") .. v .. (k == #s.Job.weapons and "." or ", ")
            end

            local textList = string.Wrap(lowRes and "sw_ui_14" or "sw_ui_24" , weps , w)

            for k , v in pairs(textList) do
                draw.SimpleText(v , lowRes and "sw_ui_14" or "sw_ui_24" , 4 , h - 124 + k * 20 , Color(200 , 200 , 200) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            end
        end
    end
end

derma.DefineControl("swF4Menu" , "STarWars" , PANEL , "DFrame")
local BTN = { }

function BTN:Init()
    self:SetText("")
end

local b = Material("ggui/star_wars/f4_selection.png")

function BTN:Paint(w , h)
    if (not self.Disabled and self:IsHovered()) then
        surface.SetDrawColor(color_white)
        surface.SetMaterial(b)
        surface.DrawTexturedRect(0 , 0 , w , 32)
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)

    if (not self.Disabled) then
        draw.SimpleText((self.Selected and "> " or "") .. self.Text , "sw_ui_24b" , 22 , 4 , (self.Selected or self.ForceGold) and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
        draw.SimpleText((self.Selected and "> " or "") .. self.Text , "sw_ui_24" , 22 , 4 , (self.Selected or self.ForceGold) and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
    else
        draw.SimpleText(self.Text , "sw_ui_24" , 22 , 6 , Color(225 , 226 , 235 , 50) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
    end
end

function BTN:DoClick()
    self:GetParent():SetSelection(self.Text)
end

derma.DefineControl("sw.f4.category" , "StarWars" , BTN , "DButton")
local JOB = { }
JOB.Can = true

function JOB:Init()
    self:SetText("")
end

local dg = surface.GetTextureID("vgui/gradient_down")
local dgb = surface.GetTextureID("vgui/gradient_up")

function JOB:Paint(w , h)
    if ((self:IsHovered() or self.Join:IsHovered()) or (self.Team == LocalPlayer():Team())) then
        surface.SetTexture(dg)
        surface.SetDrawColor((self.Team == LocalPlayer():Team()) and Color(125 , 100 , 3) or Color(3 , 65 , 88))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
        surface.SetTexture(dgb)
        surface.SetDrawColor((self.Team == LocalPlayer():Team()) and Color(125 , 100 , 3 , 100) or Color(3 , 65 , 88 , 100))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)

        if (self:IsHovered() or self.Join:IsHovered()) then
            self:GetParent():GetParent():GetParent():GetParent().JobInfo.Job = self.Data
            self:GetParent():GetParent():GetParent():GetParent().JobInfo.mdl:SetModel(self.VModel.model)
            self:GetParent():GetParent():GetParent():GetParent().JobInfo.mk = markup.Parse("<font=sw_ui_14><colour=100, 255, 10>Description:\n</colour><colour=255, 255, 255, 50>" .. self.Data.description .. "</colour></font>" , 244)
        end
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)
    draw.SimpleText((self.Selected and "> " or "") .. self.Job , "sw_ui_24b" , 72 , 16 , self.Selected and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText((self.Selected and "> " or "") .. self.Job , "sw_ui_24" , 72 , 16 , self.Selected and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText(#team.GetPlayers(self.Data.team) .. " Players" , "sw_ui_18" , w - 8 , 6 , self.Selected and Color(235 , 226 , 176 , (self:IsHovered() or self.Join:IsHovered()) and 255 or 25) or Color(176 , 226 , 235 , (self:IsHovered() or self.Join:IsHovered()) and 255 or 25) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
    surface.SetDrawColor(255 , 255 , 255 , 40)
    surface.DrawRect(72 , 28 , w - 78 , 1)
end

function JOB:OnMousePressed()
end

function JOB:Initialize()
    self.VModel = vgui.Create("SpawnIcon" , self)
    self.VModel:SetSize(60 , 60)
    self.VModel:SetPos(0 , 0)
    self.VModel:SetModel(istable(self.Data.model) and self.Data.model[ 1 ] or self.Data.model)
    self.VModel.model = istable(self.Data.model) and self.Data.model[ 1 ] or self.Data.model
    self.VModel:SetTooltip("Select your preffered model")
    self.Can = true

    if (istable(self.Data.model)) then
        self.VModel.OnMousePressed = function(sd)
            local mdls = self.Data.model
            local list = vgui.Create("DFrame")
            list:SetPos(gui.MouseX() , gui.MouseY())
            list:SetSize(4 * 66 , math.ceil(#mdls / 4) * 66)
            list:ShowCloseButton(false)
            list:SetTitle("")
            list:SetDraggable(false)
            table.insert(SW.F4.Child , list)

            list.Paint = function(s , w , h)
                surface.SetDrawColor(75 , 75 , 75)
                surface.DrawRect(0 , 0 , w , h)
                surface.SetDrawColor(30 , 30 , 30)
                surface.DrawRect(1 , 1 , w - 2 , h - 2)
            end

            for k , v in pairs(mdls) do
                local icon = vgui.Create("SpawnIcon" , list)
                icon:SetSize(64 , 64)
                icon:SetPos((k - 1) % 4 * 66 , math.ceil(k / 4) * 66 - 66)
                icon:SetModel(v)
                icon:SetTooltip("")

                icon.OnMousePressed = function(s)
                    list:Remove()

                    if (IsValid(self.VModel)) then
                        self.VModel.model = v

                        if (IsValid(sd)) then
                            sd:SetModel(v)
                            sd:SetTooltip("")
                            DarkRP.setPreferredJobModel(self.Data.team , v)
                        end
                    end

                    if (IsValid(self)) then
                        self:GetParent():GetParent():GetParent():GetParent().JobInfo.mdl:SetModel(v)
                    end
                end
            end

            list:MakePopup()
        end
    end

    local join = vgui.Create("DButton" , self)
    join:SetSize(96 , 24)
    join:SetPos(self:GetWide() - 100 , 34)
    join:SetText("")

    join.Paint = function(s , w , h)
        if (self.Can) then
            surface.SetDrawColor(s:IsHovered() and Color(235 , 226 , 176) or Color(50 , 140 , 235))
        else
            surface.SetDrawColor(s:IsHovered() and Color(235 , 100 , 50) or Color(100 , 0 , 0))
        end

        surface.DrawRect(0 , 0 , w , h)
        surface.SetDrawColor(Color(25 , 25 , 25))
        surface.DrawRect(2 , 2 , w - 4 , h - 4)
        draw.SimpleText(self.Can and (LocalPlayer():Team() == self.Data.team and "Joined" or "Join") or "Not Allowed" , "sw_ui_18b" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Can and (LocalPlayer():Team() == self.Data.team and "Joined" or "Join") or "Not Allowed" , "sw_ui_18" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
    end

    join.DoClick = fn.Compose{ function() end , fn.Partial(RunConsoleCommand , "darkrp" , self.Data.command) }

    --[[function()
    if (self.Can) then
    MsgN("darkrp ", self.Data.command)

    RunConsoleCommand("darkrp", "job", self.Data.command)
end
end
]]
if (self.Data.max > 0 and self.Data.max <= #team.GetPlayers(self.Data.team)) then
    self.Can = false
    join:SetTooltip("Max players in this team")
end

if (self.Data.customCheck and not self.Data:customCheck(LocalPlayer())) then
    self.Can = false
    join:SetTooltip("You are not allowed to join")
end

if (self.Data.NeedToChangeFrom and not self.Data.NeedToChangeFrom ~= LocalPlayer():Team()) then
    self.Can = false
    join:SetTooltip("You need to come from " .. team.GetName(self.Data.NeedToChangeFrom))
end

self.Join = join
end

function JOB:DoClick()
    self:GetParent():SetSelection(self.Text)
end

derma.DefineControl("sw.f4.job" , "StarWars" , JOB , "DPanel")
local ITEM = { }

function ITEM:Init()
end

function ITEM:Paint(w , h)
    if (self:IsHovered()) then
        surface.SetTexture(dg)
        surface.SetDrawColor(Color(3 , 65 , 88))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
        surface.SetTexture(dgb)
        surface.SetDrawColor(Color(3 , 65 , 88 , 100))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)

    if (self.Data) then
        draw.SimpleText(self.Data.name , "sw_ui_24b" , 72 , 16 , Color(100 , 150 , 220) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Data.name , "sw_ui_24" , 72 , 16 , Color(100 , 150 , 220) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
        local cost = self.Data.price or self.Data.getPrice and self.Data.getPrice(ply , self.Data.price) or self.Data.price

        if (cost == 0 and self.Data.pricesep) then
            cost = self.Data.pricesep
        end

        draw.SimpleText(DarkRP.formatMoney(cost) , "sw_ui_24b" , w - 8 , 14 , LocalPlayer():canAfford(cost) and Color(100 , 255 , 50) or Color(255 , 150 , 50) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_CENTER)
        draw.SimpleText(DarkRP.formatMoney(cost) , "sw_ui_24" , w - 8 , 14 , LocalPlayer():canAfford(cost) and Color(100 , 255 , 50) or Color(255 , 150 , 50) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_CENTER)
    end

    surface.SetDrawColor(255 , 255 , 255 , 40)
    surface.DrawRect(72 , 28 , w - 78 , 1)
end

function ITEM:SetData(data , kind)
    self.Data = data
    self.VModel = vgui.Create("SpawnIcon" , self)
    self.VModel:SetSize(60 , 60)
    self.VModel:SetPos(2 , 0)
    self.VModel:SetModel(self.Data.model)
    self.VModel.model = self.Data.model
    self.VModel:SetTooltip("")
    self.Can = can[ "canBuy" .. kind ](self.Data)
    local purch = vgui.Create("DButton" , self)
    purch:SetSize(96 , 24)
    purch:SetPos(self:GetWide() - 96 , 34)
    purch:SetText("")

    purch.Paint = function(s , w , h)
        if (self.Can) then
            surface.SetDrawColor(s:IsHovered() and Color(235 , 226 , 176) or Color(50 , 140 , 235))
        else
            surface.SetDrawColor(s:IsHovered() and Color(235 , 100 , 50) or Color(100 , 0 , 0))
        end

        surface.DrawRect(0 , 0 , w , h)
        surface.SetDrawColor(Color(25 , 25 , 25))
        surface.DrawRect(2 , 2 , w - 4 , h - 4)
        draw.SimpleText(self.Can and "Buy" or "Not Allowed" , "sw_ui_18b" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Can and "Buy" or "Not Allowed" , "sw_ui_18" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
    end

    purch.DoClick = function()
        if (self.Can) then
            local cmds = {
                entities = "" ,
                weapons = "" ,
                vehicles = "vehicle" ,
                shipments = "shipment" ,
                ammo = "ammo"
            }

            if (kind == "entities") then
                RunConsoleCommand("DarkRP" , data.cmd)
            else
                RunConsoleCommand("DarkRP" , "buy" .. cmds[ kind ] , kind == "ammo" and data.id or data.name)
            end
        end
    end
    --[[
    if (data.allowed and not table.HasValue(data.allowed, LocalPlayer():Team())) then
    self.Can = false
    purch:SetTooltip("Your job doesn't allow you to buy this item")

    return
end

if (data.customCheck and not data:customCheck(LocalPlayer())) then
self.Can = false
purch:SetTooltip(data.CustomCheckFailMsg and data:CustomCheckFailMsg(LocalPlayer()) or "You are not allowed to buy this")

return
end

if (not LocalPlayer():canAfford(data.price)) then
self.Can = false
purch:SetTooltip("You don't have enough money")

return
end

local canbuy, _, message, _ = hook.Call(kind == "shipments" and "canBuyShipment" or (kind == "weapons" and "canBuyPistol" or (kind == "ammo" and "canBuyAmmo" or (kind == "vehicles" and "canBuyVehicle" or "canBuyCustomEntity"))), nil, LocalPlayer(), data)

if (canbuy == false) then
self.Can = false
purch:SetTooltip(message)

return
end
]]
end

derma.DefineControl("sw.f4.item" , "StarWars" , ITEM , "DPanel")

net.Receive("SW.OpenF4" , function()
    if (IsValid(f4_menu)) then
        f4_menu:Remove()
    end

    f4_Menu = vgui.Create("swF4Menu")
end)

local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local string_Explode = string.Explode
local ipairs = ipairs

function string.Wrap(font , text , width)
    surface_SetFont(font)
    local sw = surface_GetTextSize(' ')
    local ret = { }
    local w = 0
    local s = ''
    local t = string_Explode('\n' , text)

    for i = 1 , #t do
        local t2 = string_Explode(' ' , t[ i ] , false)

        for i2 = 1 , #t2 do
            local neww = surface_GetTextSize(t2[ i2 ])

            if (w + neww >= width) then
                ret[ #ret + 1 ] = s
                w = neww + sw
                s = t2[ i2 ] .. ' '
            else
                s = s .. t2[ i2 ] .. ' '
                w = w + neww + sw
            end
        end

        ret[ #ret + 1 ] = s
        w = 0
        s = ''
    end

    if (s ~= '') then
        ret[ #ret + 1 ] = s
    end

    return ret
end

function PANEL:createEntities(kind)
    local lastY = 0

    for _ , v in pairs(self.Categories[ kind ]) do
        if (#v.members == 0) then continue end
        local category = v.categorises
        local panel = vgui.Create("DPanel" , self.Content)
        panel:SetPos(0 , lastY)
        local c = v.color

        panel.Paint = function(s , w , h)
            surface.SetDrawColor(Color(c.r * 1.5 , c.g * 1.5 , c.b * 1.5))
            surface.DrawRect(0 , 0 , w - 19 , 32)
            surface.SetDrawColor(v.color)
            surface.DrawRect(1 , 1 , w - 21 , 30)
            surface.SetDrawColor(Color(c.r * 0.3 , c.g * 0.3 , c.b * 0.3))
            surface.DrawRect(1 , 1 , w - 21 , 24)
            draw.SimpleText(v.name , "sw_ui_18b" , 8 , 4 , Color(0 , 198 , 218))
            draw.SimpleText(v.name , "sw_ui_18" , 8 , 4 , Color(0 , 198 , 218))
        end

        local i = 0

        for k , item_def in pairs(v.members) do
            if (can[ "canBuy" .. category ] and not can[ "canBuy" .. category ](item_def)) then continue end
            local item = vgui.Create("sw.f4.item" , panel)
            item:SetSize(self.Content:GetWide() - 19 , 64)
            item:SetPos(0 , 33 + i * 66)
            item:SetData(item_def , kind)
            i = i + 1
        end

        panel:SetSize(self.Content:GetWide() , 32 + i * 66)

        if (i == 0) then
            panel:Remove()
        else
            lastY = lastY + panel:GetTall()
        end
    end
end

function PANEL:createJobSection()
    local lastY = 0

    for k , v in pairs(self.Categories[ "jobs" ]) do
        if (not v.canSee || (v.canSee and v:canSee(LocalPlayer()))) then
            if (#v.members == 0) then continue end
            local panel = vgui.Create("DPanel" , self.Content)
            panel:SetSize(self.Content:GetWide() , 32 + #v.members * 66)
            panel:SetPos(0 , lastY)
            local c = v.color

            panel.Paint = function(s , w , h)
                surface.SetDrawColor(Color(c.r * 1.5 , c.g * 1.5 , c.b * 1.5))
                surface.DrawRect(0 , 0 , w - 19 , 32)
                surface.SetDrawColor(v.color)
                surface.DrawRect(1 , 1 , w - 21 , 30)
                surface.SetDrawColor(Color(c.r * 0.3 , c.g * 0.3 , c.b * 0.3))
                surface.DrawRect(1 , 1 , w - 21 , 24)
                draw.SimpleText(v.name , "sw_ui_18b" , 8 , 4 , Color(0 , 198 , 218))
                draw.SimpleText(v.name , "sw_ui_18" , 8 , 4 , Color(0 , 198 , 218))
            end

            for k , v in pairs(v.members) do
                local job = vgui.Create("sw.f4.job" , panel)
                job:SetSize(self.Content:GetWide() - 19 , 64)
                job:SetPos(0 , 33 + 66 * (k - 1))
                job.Data = v
                job.Team = v.team
                job.Job = v.name
                job:Initialize()
                self.Content.model = job.VModel
            end

            lastY = lastY + panel:GetTall()
        end
    end

    self.JobInfo = vgui.Create("DPanel" , self)
    table.insert(self.Content.Child , self.JobInfo)
    self.JobInfo:SetSize(lowRes and 244 or 312 , lowRes and 396 or 600)
    self.JobInfo:SetPos(lowRes and 740 or 822 , 68)
    self.JobInfo.mdl = vgui.Create("DModelPanel" , self.JobInfo)
    self.JobInfo.mdl:SetModel(LocalPlayer():GetModel())
    self.JobInfo.mdl:SetSize(self.JobInfo:GetWide() , lowRes and 148 or 320)
    self.JobInfo.mdl.LayoutEntity = function() end

    if (self.JobInfo.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") == nil) then
        local headpos = Vector(0 , 0 , 65)
        self.JobInfo.mdl:SetLookAt(headpos)
        self.JobInfo.mdl:SetCamPos(headpos - Vector(-17 , 2 , 0)) -- Move cam in front of face
        -- Move cam in front of face
    else
        local headpos = self.JobInfo.mdl.Entity:GetBonePosition(self.JobInfo.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
        self.JobInfo.mdl:SetLookAt(headpos)
        self.JobInfo.mdl:SetCamPos(headpos - Vector(-17 , 2 , 0))
    end

    self.JobInfo.mdl.oPaint = self.JobInfo.mdl.Paint

    self.JobInfo.mdl.Paint = function(s , w , h)
        s:oPaint(w , h)

        if (s.Job) then
            draw.SimpleText(s.Job.name , "sw_ui_24b" , 2 , 0 , Color(s.Job.color.r * 1.5 , s.Job.color.g * 1.5 , s.Job.color.b * 1.5) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            draw.SimpleText(s.Job.name , "sw_ui_24" , 2 , 0 , Color(s.Job.color.r * 1.5 , s.Job.color.g * 1.5 , s.Job.color.b * 1.5) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
        end
    end

    self.JobInfo.desc = vgui.Create("DScrollPanel" , self.JobInfo)
    self.JobInfo.desc:SetPos(4 , lowRes and 156 or 324)
    self.JobInfo.desc:SetSize(self.JobInfo:GetWide() - 8 , lowRes and 105 or 140)
    self:SkinScrollbar(self.JobInfo.desc:GetVBar())
    self.JobInfo.desc.Text = vgui.Create("DPanel" , self.JobInfo.desc)

    self.JobInfo.desc.Text.Paint = function(s , w , h)
        if (self.JobInfo.Job) then
            local textList = string.Wrap("sw_ui_14" , self.JobInfo.Job.description , w)
            draw.SimpleText("Description:" , "sw_ui_14" , 4 , 0 , Color(150 , 255 , 50 , 125) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)

            for k , v in pairs(textList) do
                draw.SimpleText(v , "sw_ui_14" , 4 , (k - 1) * 20 + 18 , Color(200 , 200 , 200 , 125) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            end

            s:SetSize(lowRes and 218 or 286 , #textList * 20 + 18)
        end
    end

    self.JobInfo.Paint = function(s , w , h)
        surface.SetDrawColor(Color(255 , 255 , 255 , 100))

        if (s.Job) then
            draw.SimpleText("$" .. s.Job.salary .. "/hr" , "sw_ui_18b" , w - 8 , lowRes and 2 or 22 , Color(80 , 200 , 20) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            draw.SimpleText("$" .. s.Job.salary .. "/hr" , "sw_ui_18" , w - 8 , lowRes and 2 or 22 , Color(80 , 200 , 20) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
            surface.SetDrawColor(Color(0 , 8 , 18))
            surface.DrawRect(2 , h - 130 , w - 4 , 128)
            surface.SetDrawColor(Color(255 , 255 , 255 , 100))
            surface.DrawRect(2 , lowRes and 148 or 320 , w - 4 , 2)
            surface.DrawRect(2 , lowRes and 290 or 496 , w - 4 , 2)
            draw.SimpleText("Loadout:" , "sw_ui_24b" , 4 , h - 130 , Color(200 , 200 , 20) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText("Loadout:" , "sw_ui_24" , 4 , h - 130 , Color(200 , 200 , 20) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            local weps = ""

            for k , v in pairs(s.Job.weapons) do
                weps = (weps or "") .. v .. (k == #s.Job.weapons and "." or ", ")
            end

            local textList = string.Wrap(lowRes and "sw_ui_14" or "sw_ui_24" , weps , w)

            for k , v in pairs(textList) do
                draw.SimpleText(v , lowRes and "sw_ui_14" or "sw_ui_24" , 4 , h - 124 + k * 20 , Color(200 , 200 , 200) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            end
        end
    end
end

derma.DefineControl("swF4Menu" , "STarWars" , PANEL , "DFrame")
local BTN = { }

function BTN:Init()
    self:SetText("")
end

local b = Material("ggui/star_wars/f4_selection.png")

function BTN:Paint(w , h)
    if (not self.Disabled and self:IsHovered()) then
        surface.SetDrawColor(color_white)
        surface.SetMaterial(b)
        surface.DrawTexturedRect(0 , 0 , w , 32)
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)

    if (not self.Disabled) then
        draw.SimpleText((self.Selected and "> " or "") .. self.Text , "sw_ui_24b" , 22 , 4 , (self.Selected or self.ForceGold) and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
        draw.SimpleText((self.Selected and "> " or "") .. self.Text , "sw_ui_24" , 22 , 4 , (self.Selected or self.ForceGold) and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
    else
        draw.SimpleText(self.Text , "sw_ui_24" , 22 , 6 , Color(225 , 226 , 235 , 50) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
    end
end

function BTN:DoClick()
    self:GetParent():SetSelection(self.Text)
end

derma.DefineControl("sw.f4.category" , "StarWars" , BTN , "DButton")
local JOB = { }
JOB.Can = true

function JOB:Init()
    self:SetText("")
end

local dg = surface.GetTextureID("vgui/gradient_down")
local dgb = surface.GetTextureID("vgui/gradient_up")

function JOB:Paint(w , h)
    if ((self:IsHovered() or self.Join:IsHovered()) or (self.Team == LocalPlayer():Team())) then
        surface.SetTexture(dg)
        surface.SetDrawColor((self.Team == LocalPlayer():Team()) and Color(125 , 100 , 3) or Color(3 , 65 , 88))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
        surface.SetTexture(dgb)
        surface.SetDrawColor((self.Team == LocalPlayer():Team()) and Color(125 , 100 , 3 , 100) or Color(3 , 65 , 88 , 100))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)

        if (IsValid(SW.F4.JobInfo) and (self:IsHovered() or self.Join:IsHovered())) then

            SW.F4.JobInfo.Job = self.Data
            SW.F4.JobInfo.mdl:SetModel(self.VModel.model)
            SW.F4.JobInfo.mk = markup.Parse("<font=sw_ui_14><colour=100, 255, 10>Description:\n</colour><colour=255, 255, 255, 50>" .. self.Data.description .. "</colour></font>" , 244)
        end
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)
    draw.SimpleText((self.Selected and "> " or "") .. self.Job , "sw_ui_24b" , 72 , 16 , self.Selected and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText((self.Selected and "> " or "") .. self.Job , "sw_ui_24" , 72 , 16 , self.Selected and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText(#team.GetPlayers(self.Data.team) .. " Players" , "sw_ui_18" , w - 8 , 6 , self.Selected and Color(235 , 226 , 176 , (self:IsHovered() or self.Join:IsHovered()) and 255 or 25) or Color(176 , 226 , 235 , (self:IsHovered() or self.Join:IsHovered()) and 255 or 25) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_TOP)
    surface.SetDrawColor(255 , 255 , 255 , 40)
    surface.DrawRect(72 , 28 , w - 78 , 1)
end

function JOB:OnMousePressed()
end

function JOB:Initialize()
    self.VModel = vgui.Create("SpawnIcon" , self)
    self.VModel:SetSize(60 , 60)
    self.VModel:SetPos(0 , 0)
    self.VModel:SetModel(istable(self.Data.model) and self.Data.model[ 1 ] or self.Data.model)
    self.VModel.model = istable(self.Data.model) and self.Data.model[ 1 ] or self.Data.model
    self.VModel:SetTooltip("Select your preffered model")
    self.Can = true

    if (istable(self.Data.model)) then
        self.VModel.OnMousePressed = function(sd)
            local mdls = self.Data.model
            local list = vgui.Create("DFrame")
            list:SetPos(gui.MouseX() , gui.MouseY())
            list:SetSize(4 * 66 , math.ceil(#mdls / 4) * 66)
            list:ShowCloseButton(false)
            list:SetTitle("")
            list:SetDraggable(false)
            table.insert(SW.F4.Child , list)

            list.Paint = function(s , w , h)
                surface.SetDrawColor(75 , 75 , 75)
                surface.DrawRect(0 , 0 , w , h)
                surface.SetDrawColor(30 , 30 , 30)
                surface.DrawRect(1 , 1 , w - 2 , h - 2)
            end

            for k , v in pairs(mdls) do
                local icon = vgui.Create("SpawnIcon" , list)
                icon:SetSize(64 , 64)
                icon:SetPos((k - 1) % 4 * 66 , math.ceil(k / 4) * 66 - 66)
                icon:SetModel(v)
                icon:SetTooltip("")

                icon.OnMousePressed = function(s)
                    list:Remove()

                    if (IsValid(self.VModel)) then
                        self.VModel.model = v

                        if (IsValid(sd)) then
                            sd:SetModel(v)
                            sd:SetTooltip("")
                            DarkRP.setPreferredJobModel(self.Data.team , v)
                        end
                    end

                    if (IsValid(self)) then
                        self:GetParent():GetParent():GetParent():GetParent().JobInfo.mdl:SetModel(v)
                    end
                end
            end

            list:MakePopup()
        end
    end

    local join = vgui.Create("DButton" , self)
    join:SetSize(96 , 24)
    join:SetPos(self:GetWide() - 100 , 34)
    join:SetText("")

    join.Paint = function(s , w , h)
        if (self.Can) then
            surface.SetDrawColor(s:IsHovered() and Color(235 , 226 , 176) or Color(50 , 140 , 235))
        else
            surface.SetDrawColor(s:IsHovered() and Color(235 , 100 , 50) or Color(100 , 0 , 0))
        end

        surface.DrawRect(0 , 0 , w , h)
        surface.SetDrawColor(Color(25 , 25 , 25))
        surface.DrawRect(2 , 2 , w - 4 , h - 4)
        draw.SimpleText(self.Can and (LocalPlayer():Team() == self.Data.team and "Joined" or "Join") or "Not Allowed" , "sw_ui_18b" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Can and (LocalPlayer():Team() == self.Data.team and "Joined" or "Join") or "Not Allowed" , "sw_ui_18" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
    end

    join.DoClick = fn.Compose{ function() end , fn.Partial(RunConsoleCommand , "darkrp" , self.Data.command) }

    --[[function()
    if (self.Can) then
    MsgN("darkrp ", self.Data.command)

    RunConsoleCommand("darkrp", "job", self.Data.command)
end
end
]]
if (self.Data.max > 0 and self.Data.max <= #team.GetPlayers(self.Data.team)) then
    self.Can = false
    join:SetTooltip("Max players in this team")
end

if (self.Data.customCheck and not self.Data:customCheck(LocalPlayer())) then
    self.Can = false
    join:SetTooltip("You are not allowed to join")
end

if (self.Data.NeedToChangeFrom and not self.Data.NeedToChangeFrom ~= LocalPlayer():Team()) then
    self.Can = false
    join:SetTooltip("You need to come from " .. team.GetName(self.Data.NeedToChangeFrom))
end

self.Join = join
end

function JOB:DoClick()
    self:GetParent():SetSelection(self.Text)
end

derma.DefineControl("sw.f4.job" , "StarWars" , JOB , "DPanel")
local ITEM = { }

function ITEM:Init()
end

function ITEM:Paint(w , h)
    if (self:IsHovered()) then
        surface.SetTexture(dg)
        surface.SetDrawColor(Color(3 , 65 , 88))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
        surface.SetTexture(dgb)
        surface.SetDrawColor(Color(3 , 65 , 88 , 100))
        surface.DrawTexturedRect(0 , 0 , w , h - 3)
    end

    surface.SetDrawColor(25 , 140 , 200 , 10)
    surface.DrawRect(8 , h - 1 , w - 12 , 1)

    if (self.Data) then
        draw.SimpleText(self.Data.name , "sw_ui_24b" , 72 , 16 , Color(100 , 150 , 220) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Data.name , "sw_ui_24" , 72 , 16 , Color(100 , 150 , 220) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
        local cost = self.Data.price or self.Data.getPrice and self.Data.getPrice(ply , self.Data.price) or self.Data.price

        if (cost == 0 and self.Data.pricesep) then
            cost = self.Data.pricesep
        end

        draw.SimpleText(DarkRP.formatMoney(cost) , "sw_ui_24b" , w - 8 , 14 , LocalPlayer():canAfford(cost) and Color(100 , 255 , 50) or Color(255 , 150 , 50) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_CENTER)
        draw.SimpleText(DarkRP.formatMoney(cost) , "sw_ui_24" , w - 8 , 14 , LocalPlayer():canAfford(cost) and Color(100 , 255 , 50) or Color(255 , 150 , 50) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_CENTER)
    end

    surface.SetDrawColor(255 , 255 , 255 , 40)
    surface.DrawRect(72 , 28 , w - 78 , 1)
end

function ITEM:SetData(data , kind)
    self.Data = data
    self.VModel = vgui.Create("SpawnIcon" , self)
    self.VModel:SetSize(60 , 60)
    self.VModel:SetPos(2 , 0)
    self.VModel:SetModel(self.Data.model)
    self.VModel.model = self.Data.model
    self.VModel:SetTooltip("")
    self.Can = can[ "canBuy" .. kind ](self.Data)
    local purch = vgui.Create("DButton" , self)
    purch:SetSize(96 , 24)
    purch:SetPos(self:GetWide() - 96 , 34)
    purch:SetText("")

    purch.Paint = function(s , w , h)
        if (self.Can) then
            surface.SetDrawColor(s:IsHovered() and Color(235 , 226 , 176) or Color(50 , 140 , 235))
        else
            surface.SetDrawColor(s:IsHovered() and Color(235 , 100 , 50) or Color(100 , 0 , 0))
        end

        surface.DrawRect(0 , 0 , w , h)
        surface.SetDrawColor(Color(25 , 25 , 25))
        surface.DrawRect(2 , 2 , w - 4 , h - 4)
        draw.SimpleText(self.Can and "Buy" or "Not Allowed" , "sw_ui_18b" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
        draw.SimpleText(self.Can and "Buy" or "Not Allowed" , "sw_ui_18" , w / 2 , h / 2 , s:IsHovered() and Color(235 , 226 , 176) or Color(176 , 226 , 235) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER)
    end

    purch.DoClick = function()
        if (self.Can) then
            local cmds = {
                entities = "" ,
                weapons = "" ,
                vehicles = "vehicle" ,
                shipments = "shipment" ,
                ammo = "ammo"
            }

            if (kind == "entities") then
                RunConsoleCommand("DarkRP" , data.cmd)
            else
                RunConsoleCommand("DarkRP" , "buy" .. cmds[ kind ] , kind == "ammo" and data.id or data.name)
            end
        end
    end
    --[[
    if (data.allowed and not table.HasValue(data.allowed, LocalPlayer():Team())) then
    self.Can = false
    purch:SetTooltip("Your job doesn't allow you to buy this item")

    return
end

if (data.customCheck and not data:customCheck(LocalPlayer())) then
self.Can = false
purch:SetTooltip(data.CustomCheckFailMsg and data:CustomCheckFailMsg(LocalPlayer()) or "You are not allowed to buy this")

return
end

if (not LocalPlayer():canAfford(data.price)) then
self.Can = false
purch:SetTooltip("You don't have enough money")

return
end

local canbuy, _, message, _ = hook.Call(kind == "shipments" and "canBuyShipment" or (kind == "weapons" and "canBuyPistol" or (kind == "ammo" and "canBuyAmmo" or (kind == "vehicles" and "canBuyVehicle" or "canBuyCustomEntity"))), nil, LocalPlayer(), data)

if (canbuy == false) then
self.Can = false
purch:SetTooltip(message)

return
end
]]
end

derma.DefineControl("sw.f4.item" , "StarWars" , ITEM , "DPanel")

net.Receive("SW.OpenF4" , function()
    if (IsValid(f4_menu)) then
        f4_menu:Remove()
    end

    f4_Menu = vgui.Create("swF4Menu")
end)

local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local string_Explode = string.Explode
local ipairs = ipairs

function string.Wrap(font , text , width)
    surface_SetFont(font)
    local sw = surface_GetTextSize(' ')
    local ret = { }
    local w = 0
    local s = ''
    local t = string_Explode('\n' , text)

    for i = 1 , #t do
        local t2 = string_Explode(' ' , t[ i ] , false)

        for i2 = 1 , #t2 do
            local neww = surface_GetTextSize(t2[ i2 ])

            if (w + neww >= width) then
                ret[ #ret + 1 ] = s
                w = neww + sw
                s = t2[ i2 ] .. ' '
            else
                s = s .. t2[ i2 ] .. ' '
                w = w + neww + sw
            end
        end

        ret[ #ret + 1 ] = s
        w = 0
        s = ''
    end

    if (s ~= '') then
        ret[ #ret + 1 ] = s
    end

    return ret
end
