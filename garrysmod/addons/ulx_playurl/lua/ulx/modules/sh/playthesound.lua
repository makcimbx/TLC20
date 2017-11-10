if not(CLIENT) then return end

EverAanim = false
local tmE = 0
anMaterial = Material( "content/anime.png" )
 
 
if(CLIENT)then
local function init()
EverAnimePanel = vgui.Create( "DFrame" )
EverAnimePanel:SetPos( ScrW()/2-150, ScrH()/2-(249/1.55+10)/2 )
EverAnimePanel:SetSize( 300, 249/1.55+10 ) 
EverAnimePanel:SetTitle( "" )
EverAnimePanel:SetDraggable( false )
EverAnimePanel:MakePopup()
EverAnimePanel:SetDeleteOnClose( false )
EverAnimePanel:ShowCloseButton( false )
EverAnimePanel:SetVisible( false )

local Pnl = vgui.Create( "DPanel",EverAnimePanel )
Pnl:SetPos( 0, 0 ) -- Set the position of the panel
Pnl:SetSize( 300, 249/1.55+10 ) -- Set the size of the panel

local Pnl2 = vgui.Create( "DPanel",Pnl )
Pnl2:SetPos( 290/2-(441/1.6)/2, 168/2 - (249/1.6)/2 )	-- Move it into frame   
Pnl2:SetSize( 441/1.55, 249/1.55 )	-- Size it to 150x150
Pnl2.Paint = function()
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( anMaterial	) -- If you use Material, cache it!
	surface.DrawTexturedRect( 0, 0, 441/1.55, 249/1.55 )
end

local Text = vgui.Create( "DLabel", Pnl )
Text:SetPos( 15, 5 ) -- Set the position of the label
Text:SetText( "" ) -- Set the text of the label 
Text:SetSize( 300, 100 )	-- Size it to 150x150
Text:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
Text:SetFont( "DermaLarge" )
Text.Paint = function(self)
	draw.SimpleTextOutlined( "Хочешь в аниме пати?", "DermaLarge", 5, 0, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
end

local Time = vgui.Create( "DLabel", Pnl )
Time:SetPos( 15, 15 ) -- Set the position of the label
Time:SetText( "" ) -- Set the text of the label 
Time:SetSize( 300, 100 )	-- Size it to 150x150
Time:SetDark( 1 ) -- Set the colour of the text inside the label to a darker one
Time:SetFont( "DermaLarge" )
Time.Paint = function(self)
	draw.SimpleTextOutlined( "Начало через:"..tmE, "DermaLarge", 5, 15, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
end

local Da = vgui.Create( "DButton", Pnl )
Da:SetText( "Да" )					
Da:SetPos( 25, 168-50 )					
Da:SetSize( 80, 30 )					
Da.DoClick = function()	
	EverAanim = true
	EverAnimePanel:SetVisible( false )
end

local Net = vgui.Create( "DButton", Pnl )
Net:SetText( "Нет" )					
Net:SetPos( 290-(25+80), 168-50 )					
Net:SetSize( 80, 30 )					
Net.DoClick = function()
	EverAanim = false
	EverAnimePanel:SetVisible( false )
end
end
hook.Add( "Initialize", "some_unique_name", init )
end

net.Receive("StartAnime",function()
	if(EverAanim==true)then
		EverAanim = false
		if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
			LocalPlayer().channel:Stop() 
		end 
		sound.PlayURL(ura,"",function(ch) 
			if ch != nil and ch:IsValid() then
				ch:Play() 
				LocalPlayer().channel = ch 
			end 
		end)
	else
		EverAnimePanel:SetVisible( false )
	end
end)

function playsoundpleaseokay(data)
	EverAnimePanel:SetVisible( true )
	ura = data:ReadString()
	tmE = 10
	timer.Create("AnimeTimer",1,tmE+1,function() tmE=tmE-1 end)
end

usermessage.Hook( "ulib_url_sound", playsoundpleaseokay )



function stopsoundpleaseokay(data)
        stopurl = data:ReadString()
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
        sound.PlayURL(stopurl,"",function(ch)
                if ch != nil and ch:IsValid() then
                        ch:Play()
                        LocalPlayer().channel = ch
                end
        end)
end

usermessage.Hook( "ulib_url_stopsound", stopsoundpleaseokay )



function stopmysongplease(data)
local stoppingsong = "You have stopped the URL for yourself."
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
	chat.AddText(Color(0,0,200),stoppingsong)
end

usermessage.Hook("stopmysongplease",stopmysongplease)

function startmysongplease(data)
local startingsong = "You have started a URL for yourself."
        urlme = data:ReadString()
        if LocalPlayer().channel ~= nil && LocalPlayer().channel:IsValid() then
                LocalPlayer().channel:Stop()
        end
        sound.PlayURL(urlme,"",function(ch)
                if ch != nil and ch:IsValid() then
                        ch:Play()
                        LocalPlayer().channel = ch
                end
                end)
	chat.AddText(Color(0,0,200),startingsong)
end

usermessage.Hook("startmysongplease",startmysongplease)