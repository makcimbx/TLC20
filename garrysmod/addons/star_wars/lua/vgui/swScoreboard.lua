if (!SW.EnableScoreboard) then return end

local PANEL = { }
local cl = Material("ggui/star_wars/close.png")
local lowRes = ScrH() <= 720

for k , v in pairs(player.GetAll()) do
    v.Scoreboard = nil
end

function PANEL:Init()
    self:SetSize(lowRes and 906 or 1280 , lowRes and 488 or 720)
    self:Center()
    self:SetTitle("")
    self:MakePopup()
    self:SetDraggable(false)
    self:ShowCloseButton(false)
    self.cl = vgui.Create("DButton" , self)
    self.cl:SetSize(16 , 16)
    self.cl:SetPos(self:GetWide() - 42 , 18)
    self.cl:SetText("")

    self.cl.DoClick = function()
        self:Hide()
    end

    self.cl.Paint = function(s , w , h)
        surface.SetMaterial(cl)
        surface.SetDrawColor(s:IsHovered() and Color(218 , 198 , 0) or Color(0 , 198 , 218))
        surface.DrawTexturedRect(0 , 0 , w , h)
    end

    self.List = vgui.Create("DScrollPanel" , self)
    self.List:SetSize(lowRes and 860 or 1172 , lowRes and 385 or 550)
    self.List:SetPos(lowRes and 24 or 48 , lowRes and 70 or 104)
    self.List.Players = { }
    self:ReCreate()
    self:SkinScrollbar(self.List:GetVBar())
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

PANEL.NextPos = 0
PANEL.SortMode = 1
PANEL.SortOuts = { "Name" , "Kills" , "Deaths" , "Ping" , "Job" }
PANEL.Inverse = false

function PANEL:ReCreate()
    self.k = #self.List.Players
    self.i = self.k

    for k , v in pairs(self.List.Players) do
        if (v.IsOn) then
            v:SetSize(self.List:GetWide() , 24)
            v.Avatar:SetPlayer(v.Player , 16)
            v.Avatar:SetPos(2 , 3)
            v.Avatar:SetSize(16 , 16)
            v.IsOn = false
        end

        if (v._selected) then
            v._selected = false
            v:SetSize(self.List:GetWide() , 64)
            v.IsOn = true
            self.i = k
        end
    end

    for k , v in pairs(self.List.Players) do
        v:SetPos(0 , 24 * (k - 1) + (self.i < k and 40 or 0))
    end
end

PANEL.i = 0

function PANEL:Think()
    for k , v in pairs(player.GetAll()) do
        if (not IsValid(v.Scoreboard)) then
            local ply = vgui.Create("swPlayer" , self.List)
            ply:SetSize(self:GetParent():GetWide() , 24)
            ply:SetPlayer(v)
            ply:SetPos(0 , 24 * (k - 1))
            v.Scoreboard = ply
            table.insert(self.List.Players , ply)
            table.sort(self.List.Players , function(a , b)
                if IsValid(a.Player) and IsValid(b.Player) then
                    return a.Player:Nick() < b.Player:Nick()
                else
                    return true
                end
            end)

            for l , it in pairs(self.List.Players) do
                if (it.Player == LocalPlayer()) then
                    self.List.Players[ l ] = self.List.Players[ 1 ]
                    self.List.Players[ 1 ] = it
                end
            end

            self:ReCreate()

            return
        end
    end

    if (#self.List.Players ~= #player.GetAll()) then
        for k , v in pairs(self.List.Players) do
            v:Remove()
        end

        self.List.Players = { }
        self:ReCreate()
    end

    for k , v in pairs(self.List.Players) do
        if (not IsValid(v.Player)) then
            v:Remove()
        end
    end
end

local bg = lowRes and Material("ggui/star_wars/sb.png") or surface.GetTextureID("ggui/star_wars/scoreboard")
local rowSize = 0
local initialRow = lowRes and 48 or 72
local bannerTop = lowRes and 53 or 82

function PANEL:Paint(w , h)
    rowSize = w / 5
    surface.SetDrawColor(color_white)

    if (lowRes) then
        surface.SetMaterial(bg)
    else
        surface.SetTexture(bg)
    end

    surface.DrawTexturedRect(0 , 0 , lowRes and 1024 or 2048 , lowRes and 512 or 1024)
    draw.SimpleTextOutlined("Scoreboard" , lowRes and "sw_ui_24" or "sw_ui_32" , w / 2 , lowRes and 16 or 36 , Color(0 , 150 , 0) , TEXT_ALIGN_CENTER , TEXT_ALIGN_CENTER , 1 , Color(0 , 79 , 0))
    draw.SimpleTextOutlined(#player.GetAll() .. "/" .. game.MaxPlayers() , "old_republic_24" , w - 38 , h - (lowRes and 22 or 34) , Color(176 , 226 , 235) , TEXT_ALIGN_RIGHT , TEXT_ALIGN_CENTER , 1 , Color(96 , 146 , 155))
    draw.SimpleText("Player Name" , "sw_ui_18b" , initialRow , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Player Name" , "sw_ui_18" , initialRow , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Kills" , "sw_ui_18b" , initialRow + rowSize , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Kills" , "sw_ui_18" , initialRow + rowSize , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Deaths" , "sw_ui_18b" , initialRow + rowSize * 2 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Deaths" , "sw_ui_18" , initialRow + rowSize * 2 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Job" , "sw_ui_18b" , initialRow + rowSize * 3 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Job" , "sw_ui_18" , initialRow + rowSize * 3 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Ping" , "sw_ui_18b" , initialRow + rowSize * 4 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)
    draw.SimpleText("Ping" , "sw_ui_18" , initialRow + rowSize * 4 , bannerTop , Color(176 , 226 , 235) , TEXT_ALIGN_LEFT , TEXT_ALIGN_CENTER)

    if(not input.IsKeyDown(KEY_TAB)) then
        self:Hide()
    end
end

derma.DefineControl("swScoreboard" , "Scoreboard" , PANEL , "DFrame")
local PLY = { }
PLY.Name = ""
PLY.Kills = 0
PLY.Deaths = 0
PLY.Job = ""
local dg = surface.GetTextureID("vgui/gradient_down")
local dgb = surface.GetTextureID("vgui/gradient_up")

function PLY:Init()
    self.Avatar = vgui.Create("AvatarImage" , self)
    self.Avatar:SetPos(2 , 3)
    self.Avatar:SetSize(16 , 16)
    self:SetText("")
end

function PLY:SetPlayer(ply , k)
    self.Player = ply
    self.k = k
    self.Avatar:SetPlayer(ply , 16)

    if (ply:IsBot()) then
        self.Name = ply:SteamName()
    else
        self.Name = ply:getDarkRPVar("rpname" , ply:SteamName())
    end
end

function PLY:Paint(w , h)
    surface.SetDrawColor(82 , 191 , 230 , 10)
    surface.DrawRect(4 , h - 2 , w , 1)

    if (IsValid(self.Player)) then
        if (self:IsHovered() or self.IsOn) then
            surface.SetTexture(dg)
            surface.SetDrawColor(self.IsOn and Color(125 , 100 , 3) or Color(3 , 65 , 88))
            surface.DrawTexturedRect(0 , 0 , w , h - 3)
            surface.SetTexture(dgb)
            surface.SetDrawColor(self.IsOn and Color(125 , 100 , 3 , 100) or Color(3 , 65 , 88 , 100))
            surface.DrawTexturedRect(0 , 0 , w , h - 3)
        elseif (not self.Player:Alive()) then
            surface.SetTexture(dg)
            surface.SetDrawColor(Color(48 , 9 , 9))
            surface.DrawTexturedRect(0 , 0 , w , h - 3)
            surface.SetTexture(dgb)
            surface.SetDrawColor(Color(48 , 9 , 9 , 100))
            surface.DrawTexturedRect(0 , 0 , w , h - 3)
        end

        draw.SimpleText(self.Player:Nick() , "sw_ui_18b" , initialRow - 24 - (not lowRes and 24 or 0) , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Player:Nick() , "sw_ui_18" , initialRow - 24 - (not lowRes and 24 or 0) , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Kills , "sw_ui_18b" , initialRow - 24 + rowSize - (not lowRes and 8 or 8) , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Kills , "sw_ui_18" , initialRow - 24 + rowSize - (not lowRes and 8 or 8) , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Deaths , "sw_ui_18b" , initialRow - 24 + rowSize * 2 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Deaths , "sw_ui_18" , initialRow - 24 + rowSize * 2 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Job , "sw_ui_18b" , initialRow - 32 + rowSize * 3 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Job , "sw_ui_18" , initialRow - 32 + rowSize * 3 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Player:Ping() , "sw_ui_18b" , initialRow - 32 + rowSize * 4 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)
        draw.SimpleText(self.Player:Ping() , "sw_ui_18" , initialRow - 32 + rowSize * 4 , 2 , Color(82 , 191 , 230) , TEXT_ALIGN_CENTER , TEXT_ALIGN_TOP)

        if (self.IsOn) then
            draw.SimpleText("SteamID:" , "sw_ui_18" , 64 , 22 , Color(255 , 255 , 255) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText("SteamID64:" , "sw_ui_18" , 64 , 38 , Color(255 , 255 , 255) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText(self.Player:SteamID() , "sw_ui_18" , 158 , 22 , Color(255 , 255 , 255 , 100) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText(self.Player:SteamID64() , "sw_ui_18" , 158 , 38 , Color(255 , 255 , 255 , 100) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText("Money:" , "sw_ui_18" , w / 2 , 22 , Color(255 , 255 , 255) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText(DarkRP.formatMoney(self.Player:getDarkRPVar("money" , 0)) , "sw_ui_18" , w / 2 + 58 , 22 , Color(100 , 255 , 100 , 200) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText("Steam Name:" , "sw_ui_18" , w / 2 , 38 , Color(255 , 255 , 255) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
            draw.SimpleText(self.Player:SteamName() , "sw_ui_18" , w / 2 + 105 , 38 , Color(255 , 255 , 100 , 200) , TEXT_ALIGN_LEFT , TEXT_ALIGN_TOP)
        end
    else
        return
    end

    self.Kills = self.Player:Frags()
    self.Deaths = self.Player:Deaths()
    self.Job = team.GetName(self.Player:Team())
end

function PLY:OnMousePressed(c)
    if (c == 108 and self.IsOn) then
        self:SetSize(806 , 24)
        self.Avatar:SetSize(16 , 16)
        self.Avatar:SetPos(2 , 3)
        self.Avatar:SetPlayer(self.Player , 16)
        self:GetParent():GetParent():GetParent():ReCreate()
    elseif (c == 107) then
        self:DoClick()
    end
end

function PLY:DoClick()
    if (self.IsOn) then
        local menu = DermaMenu()

        menu:AddOption("Copy SteamID" , function()
            SetClipboardText(self.Player:SteamID())
        end):SetIcon("icon16/book.png")

        menu:AddOption("Copy SteamID64" , function()
            SetClipboardText(self.Player:SteamID64())
        end):SetIcon("icon16/computer.png")

        menu:AddOption("Copy Name" , function()
            SetClipboardText(self.Player:SteamName())
        end):SetIcon("icon16/user_suit.png")

        menu:AddOption("Copy RPName" , function()
            SetClipboardText(self.Player:Nick())
        end):SetIcon("icon16/group.png")

        menu:AddOption("Open profile" , function()
            gui.OpenURL("https://steamcommunity.com/profiles/" .. self.Player:SteamID64())
        end):SetIcon("icon16/world.png")

        menu:Open()

        return
    end

    self._selected = true
    self.Avatar:SetPlayer(self.Player , 32)
    self.Avatar:SetSize(32 , 32)
    self.Avatar:SetPos(22 , 24)
    self:GetParent():GetParent():GetParent():ReCreate()
end

derma.DefineControl("swPlayer" , "Scoreboard" , PLY , "DButton")

if (IsValid(SW.Score)) then
    SW.Score:Remove()
end

hook.Add("ScoreboardShow" , "SW.Scoreboard" , function()
    if (not IsValid(SW.Score)) then
        SW.Score = vgui.Create("swScoreboard")
    else
        SW.Score:Show()
    end

    return false
end)

hook.Add("ScoreboardHide" , "SW.Scoreboard" , function()
    if (IsValid(SW.Score)) then
        SW.Score:Hide()
    end
end)
