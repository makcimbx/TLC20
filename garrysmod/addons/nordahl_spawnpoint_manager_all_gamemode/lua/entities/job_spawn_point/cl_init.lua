
local Leak_Protection_Status=[[OK]]
/* READ THIS BEFORE HAVE PROBLEM PLEASE,

If you find my work serious know they are all my other scripts here: https://originahl-scripts.com/gmod-scripts
I'm not only an simple coder you can see and support my creativity:

My Facebook Page: https://www.facebook.com/zworld.afterlife/
My Drawing: http://steamcommunity.com/id/zworld-dev/images/
My Steam Group: http://steamcommunity.com/groups/zworld-afterlife
My servers here: https://zworld-afterlife.com/fr/servers


----1.Script Activation & antileak----
FR : Tout ce que tu dois savoir: https://originahl-scripts.com/fr/help
EN : All you must know:  https://originahl-scripts.com/en/help

----2.Leak----
Our biggest issues here are people who purchase scripts, with the sole purpose of leaking them.
As a developer, if I see my scripts, or any other developer's scripts here for that matter leaked by a member of the ScriptFodder community,
rest assured that I will do everything in my power to ensure you fail.
This includes but not limited to, notifying a moderator / admin of ScriptFodder of your attempt to leak,
with proof of course (because we will find you); ensuring you are banned from the website.
Your access to my script completely revoked without any additional warning.
Your name publicly blasted, with SteamID, on any and all developer forums, including Facepunch.com.
As well as any Steam groups you may be part of (maybe even your friends).
And finally, a phone call to PayPal explaining who you are, and what you are attempting to do.
Which in the future can jeopardize your very own PayPal account and have it limited.
We are developers, this is partially how we make a living, and it helps support our families.
If you have an issue, simply tell me and I'll do everything in my power to fix it.
Attempting charge-backs is not the way to handle a business transaction.
If you are not a leaker, you have nothing to worry about, and I thank you for your purchase.

Keep in mind. The leak destroys the creation and the opportunity to see something new and different on Gmod.

----3.Copyright----
The Zworld-Afterlife scripts are placed at Copyright France since 2012.
zworld-afterlife.com© 2008-2015. Created by Nordahl
Do not publish without my authorization.

With my regards,
Thank You.

By Nordahl                                                                                                                                                                                                                                                                      76561198045250557  
If you find my work serious know they are all my other scripts here: https://originahl-scripts.com/gmod-scripts
*/
local exemplesteamid64="76561198033784269"

include('shared.lua')
include('config.lua')
local zcolorbase=Color(0,255,0,200) local puce="*"


local function eRight(a)
if a:SteamID()==JSP_CONFIG.OwnerSteamID then return true end
if a:IsAdmin()==true then if JSP_CONFIG.Allow_Admin==1 then return true end end
if a:IsSuperAdmin()==true then if JSP_CONFIG.Allow_SUPER_Admin==1 then return true end end
for _,c in ipairs(JSP_CONFIG.Allow_ULX_GROUP_CAN_ACCESS_PANEL)do if a:IsUserGroup(c) then return true end end
if serverguard then for _,c in ipairs(JSP_CONFIG.SERVERGUARD_Access_rank)do if serverguard.player:GetRank(a)==c then return true end end end
return false
end

local files=file.Read("nordahlclient_option/language.txt","DATA")
if (!files) then
file.CreateDir("nordahlclient_option")
file.Write("nordahlclient_option/language.txt","2")
Z_Defaut_Languages=2
else
Z_Defaut_Languages=tonumber(file.Read("nordahlclient_option/language.txt","DATA"))
end

local function nrali(a,msg)
draw.RoundedBox(6,0,0,a:GetWide(),a:GetTall(),Color(150,0,0,255))
draw.RoundedBox(6,0,0,a:GetWide(),a:GetTall()-1,Color(255,255,255,255))
draw.RoundedBox(4,1,a:GetTall()-1-a:GetTall()/3,a:GetWide()-2,a:GetTall()/3,Color(255,210,210,255))
--surface.SetDrawColor(255,255,255,255) 
surface.SetMaterial(matngui2)surface.DrawTexturedRect(0,5,16,16)surface.SetMaterial(matngui2)surface.DrawTexturedRect(a:GetWide()-16,5,16,16)
surface.SetDrawColor(255,255,255,255)draw.SimpleText(msg, "Trebuchet18", a:GetWide()/2, 13, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

local function btngri(a,msg)
draw.RoundedBox(6,0,0,a:GetWide(),a:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,a:GetWide()-2,a:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,a:GetTall()-2-a:GetTall()/3,a:GetWide()-2,a:GetTall()/3,Color(210,210,210,255))
end

local function btnble(a,b,c)
local col1=Color(0,0,90,175)
local col2=Color(200,200,230,255)
if a.val==greenvalue then
col1=Color(0,150,0,175)
col2=Color(200,230,200,255)
end
draw.RoundedBox(6,0,0,a:GetWide(),a:GetTall(),col1)
draw.RoundedBox(6,1,1,a:GetWide()-2,a:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(4,1,a:GetTall()-1-a:GetTall()/3,a:GetWide()-2,a:GetTall()/3,col2)
surface.SetDrawColor(255,255,255,255) 
surface.SetMaterial(Material(c))surface.DrawTexturedRect(5,2,16,16)
surface.SetDrawColor(255,255,255,255)draw.SimpleText(b,"Trebuchet18", a:GetWide()/2+8, 10, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

function nordahl_jpslanguefr(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl="Player Spawn Point Manager"
trajsp_nordahl_a=""
trajsp_nordahl_b="Editez la couleur du point de spawn"
trajsp_nordahl_c1="Admin Eyes"
trajsp_nordahl_c2="Disable Eyes"
trajsp_nordahl_d1="Cacher Model"
trajsp_nordahl_d2="Montrer Model"
trajsp_nordahl_e="Supprimer"
trajsp_nordahl_f="Point de spawn pour"
tra_scrp_nordahl_credit="Fait par Nordahl"
tra_scrp_nordahl_script="Script"
trajsp_nordahl_g="" end

function nordahl_jpslangueen(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl="Player Spawn Point Manager"
trajsp_nordahl_a=""
trajsp_nordahl_b="Edit the color of the spawn point"
trajsp_nordahl_c1="Admin Eyes"
trajsp_nordahl_c2="Disable Eyes"
trajsp_nordahl_d1="Hide Model"
trajsp_nordahl_d2="Show Model"
trajsp_nordahl_e="Remove"
trajsp_nordahl_f="Spawn point for"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script="Script"
trajsp_nordahl_g="" end

function nordahl_jpslanguedu(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Bearbeiten Sie die Farbe der Spawnpunkt"
trajsp_nordahl_c1="Admin Eyes"
trajsp_nordahl_c2="Disable Eyes"
trajsp_nordahl_d1 = "Hide Model"
trajsp_nordahl_d2 = "Show Model"
trajsp_nordahl_e = "Entfernen"
trajsp_nordahl_f="Spawnpunkt für"
tra_scrp_nordahl_credit = "von Nordahl Gemacht"
tra_scrp_nordahl_script="Script"
trajsp_nordahl_g = "" end

function nordahl_jpslangueru(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Измените цвет точки икру"
trajsp_nordahl_c1="Admin Eyes"
trajsp_nordahl_c2="Disable Eyes"
trajsp_nordahl_d1 = "Скрыть Модель"
trajsp_nordahl_d2 = "Показать модель"
trajsp_nordahl_e = "Удалить"
trajsp_nordahl_f="Спаун точка для"
tra_scrp_nordahl_credit = "Сделано Нордалем"
tra_scrp_nordahl_script="Script"
trajsp_nordahl_g = "" end

function nordahl_jpslanguees(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Edite el color del punto de generación"
trajsp_nordahl_c1="Admin Eyes"
trajsp_nordahl_c2="Disable Eyes"
trajsp_nordahl_d1 = "Ocultar Modelo"
trajsp_nordahl_d2 = "Mostrar Modelo"
trajsp_nordahl_e = "Eliminar"
trajsp_nordahl_f="Punto de Spawn para"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script="Script"
trajsp_nordahl_g = "" end

function nordahl_jpslangueel(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Διαχείριση Player Γόνος Point "
trajsp_nordahl_a = " "
trajsp_nordahl_b = " να επεξεργαστείτε το χρώμα του σημείου γόνου "
trajsp_nordahl_c1 = " Μάτια Διαχειριστής"
trajsp_nordahl_c2 = " Off Μάτια "
trajsp_nordahl_d1 = " Απόκρυψη Μοντέλο "
trajsp_nordahl_d2 = " Μοντέλο Οθόνη "
trajsp_nordahl_e = " Κατάργηση "
trajsp_nordahl_f = " Γόνος Σημείο"
tra_scrp_nordahl_credit = " Made by Nordahl "
tra_scrp_nordahl_script = " Σενάριο "
trajsp_nordahl_g="" end

function nordahl_jpslanguept(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Jogador do Spawn Ponto Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Editar a cor do ponto de desova"
trajsp_nordahl_c1 = "admin Eyes"
trajsp_nordahl_c2 = "Desativar Eyes"
trajsp_nordahl_d1 = "Hide Model"
trajsp_nordahl_d2 = "Show Model"
trajsp_nordahl_e = "Remover"
trajsp_nordahl_f = "ponto de Spawn para"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguepl(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Gracz Spawn Punkt Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Edytuj kolor punktu odradzania"
trajsp_nordahl_c1 = "admin Oczy" 
trajsp_nordahl_c2 = "Wyłącz Oczy"
trajsp_nordahl_d1 = "Ukryj model"
trajsp_nordahl_d2 = "Pokaż model"
trajsp_nordahl_e = "Usuń"
trajsp_nordahl_f = "punktu odradzania dla"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslangueit(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Modificare il colore del punto di spawn"
trajsp_nordahl_c1 = "Occhi Admin"
trajsp_nordahl_c2 = "Disabilita Eyes"
trajsp_nordahl_d1 = "Nascondi Modello"
trajsp_nordahl_d2 = "un modello da esposizione"
trajsp_nordahl_e = "Rimuovi"
trajsp_nordahl_f = "punto di spawn per"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguebg(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Мениджър"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Редактиране на цвета на точката на мицел"
trajsp_nordahl_c1 = "Admin Eyes"
trajsp_nordahl_c2 = "Изключване на очите"
trajsp_nordahl_d1 = "Hide Модел"
trajsp_nordahl_d2 = "Покажи Модел"
trajsp_nordahl_e = "Премахване"
trajsp_nordahl_f = "Spawn точка за"
tra_scrp_nordahl_credit = "Произведено от Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguecs(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Hráč potěr Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Upravit barvu spawn pointu"
trajsp_nordahl_c1 = "admin Eyes"
trajsp_nordahl_c2 = "Zakázat Eyes"
trajsp_nordahl_d1 = "Hide Model"
trajsp_nordahl_d2 = "Show Model"
trajsp_nordahl_e = "Odstranit"
trajsp_nordahl_f = "potěr bod pro"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslangueet(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Mängija kudema Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Muuda värvi kudema punkti"
trajsp_nordahl_c1 = "Admin Silmad"
trajsp_nordahl_c2 = "Keela Silmad"
trajsp_nordahl_d1 = "Peida Mudel"
trajsp_nordahl_d2 = "Näita Mudel"
trajsp_nordahl_e = "Eemalda"
trajsp_nordahl_f = "kudema punkti"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguefi(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Muokkaa väri kutemaan piste"
trajsp_nordahl_c1 = "Admin Eyes"
trajsp_nordahl_c2 = "Poista Eyes"
trajsp_nordahl_d1 = "Piilota malli"
trajsp_nordahl_d2 = "Näytä malli"
trajsp_nordahl_e = "Poista"
trajsp_nordahl_f = "Spawn piste"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslangueja(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl="プレイヤースポーンポイントマネージャ"
trajsp_nordahl_a=""
trajsp_nordahl_b="スポーンポイントの色を編集します"
trajsp_nordahl_c1="管理者の目"
trajsp_nordahl_c2="無効アイズ"
trajsp_nordahl_d1="隠すモデル"
trajsp_nordahl_d2="ショーモデル"
trajsp_nordahl_e="削除"
trajsp_nordahl_f="のためのスポーンポイント"
tra_scrp_nordahl_credit="Nordahl製"
tra_scrp_nordahl_script="スクリプト"
trajsp_nordahl_g=""
end
function nordahl_jpslangueko(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "플레이어 스폰 포인트 관리자"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "스폰 지점의 색상을 편집"
trajsp_nordahl_c1 = "관리 눈"
trajsp_nordahl_c2 = "사용 안 함 눈"
trajsp_nordahl_d1 = "숨기기 모델"
trajsp_nordahl_d2 = "쇼 모델"
trajsp_nordahl_e = "제거"
trajsp_nordahl_f = "에 대한 스폰 포인트"
tra_scrp_nordahl_credit = "Nordahl에 의해 만들어"
tra_scrp_nordahl_script = "스크립트"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguelv(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Rediģēt krāsu micēlijs punktu"
trajsp_nordahl_c1 = "Admin Eyes"
trajsp_nordahl_c2 = "Atslēgt Eyes"
trajsp_nordahl_d1 = "Paslēpt modelis"
trajsp_nordahl_d2 = "Show modelis"
trajsp_nordahl_e = "Dzēst"
trajsp_nordahl_f = "Spawn punkts"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslangueno(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player gyte Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Rediger fargen på spawn point"
trajsp_nordahl_c1 = "admin Eyes"
trajsp_nordahl_c2 = "Deaktiver Eyes"
trajsp_nordahl_d1 = "Skjul Model"
trajsp_nordahl_d2 = "Show Model"
trajsp_nordahl_e = "Fjern"
trajsp_nordahl_f = "spawn punkt for"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguero(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Managerul jucătorului Spawn Punct"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Editați culoarea punctului spawn"
trajsp_nordahl_c1 = "Eyes Admin"
trajsp_nordahl_c2 = "Disable Eyes"
trajsp_nordahl_d1 = "Ascunde Model"
trajsp_nordahl_d2 = "Arată modelul"
trajsp_nordahl_e = "Eliminare"
trajsp_nordahl_f = "punctul Spawn pentru"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguesv(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Player Spawn Point Manager"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "Redigera färg leka punkten"
trajsp_nordahl_c1 = "Admin Eyes"
trajsp_nordahl_c2 = "Inaktivera Eyes"
trajsp_nordahl_d1 = "Göm Model"
trajsp_nordahl_d2 = "Visa Model"
trajsp_nordahl_e = "Ta bort"
trajsp_nordahl_f = "Spawn poäng för"
tra_scrp_nordahl_credit = "Made by Nordahl"
tra_scrp_nordahl_script = "Script"
trajsp_nordahl_g = ""
end
function nordahl_jpslanguetr(z)Z_Defaut_Languages=z
if IsValid(LocalPlayer()) then
LocalPlayer():EmitSound("garrysmod/ui_return.wav",60,150)
end
trajsp_nordahl = "Oyuncu Spawn Noktası Yöneticisi"
trajsp_nordahl_a = ""
trajsp_nordahl_b = "doğuş noktasında rengini düzenleme"
trajsp_nordahl_c1 = "Yönetici Gözler"
trajsp_nordahl_c2 = "Devre Dışı Bırak Gözler"
trajsp_nordahl_d1 = "Hide Modeli"
trajsp_nordahl_d2 = "Göster Modeli"
trajsp_nordahl_e = "Kaldır"
trajsp_nordahl_f = "için Spawn noktası"
tra_scrp_nordahl_credit = "Nordahl tarafından yapılmıştır"
tra_scrp_nordahl_script = "Senaryo"
trajsp_nordahl_g = ""
end


if Z_Defaut_Languages==1 then
nordahl_jpslanguefr(1)
elseif Z_Defaut_Languages==2 then
nordahl_jpslangueen(2)
elseif Z_Defaut_Languages==3 then
nordahl_jpslanguees(3)
elseif Z_Defaut_Languages==4 then
nordahl_jpslanguedu(4)
elseif Z_Defaut_Languages==5 then
nordahl_jpslangueru(5)
elseif Z_Defaut_Languages==6 then
nordahl_jpslangueel(6)
elseif Z_Defaut_Languages==7 then
nordahl_jpslanguept(7)
elseif Z_Defaut_Languages==8 then
nordahl_jpslanguepl(8)
elseif Z_Defaut_Languages==9 then
nordahl_jpslangueit(9)
elseif Z_Defaut_Languages==10 then
nordahl_jpslanguebg(10)
elseif Z_Defaut_Languages==11 then
nordahl_jpslanguecs(11)
elseif Z_Defaut_Languages==12 then
nordahl_jpslangueet(12)
elseif Z_Defaut_Languages==13 then
nordahl_jpslanguefi(13)
elseif Z_Defaut_Languages==14 then
nordahl_jpslangueja(14)
elseif Z_Defaut_Languages==15 then
nordahl_jpslangueko(15)
elseif Z_Defaut_Languages==16 then
nordahl_jpslanguelv(16)
elseif Z_Defaut_Languages==17 then
nordahl_jpslangueno(17)
elseif Z_Defaut_Languages==18 then
nordahl_jpslanguero(18)
elseif Z_Defaut_Languages==19 then
nordahl_jpslanguesv(19)
elseif Z_Defaut_Languages==20 then
nordahl_jpslanguetr(20)
else
nordahl_jpslangueen(2)
end

function ENT:Draw()
if self:GetNWInt("ent_visible")==1 then
self.Entity:DrawModel()
end end

local mat = Material( "sprites/sent_ball" )
local mat2 = Material( "vgui/entities/safezoneicon.png" )
local mat3 = Material( "vgui/entities/safezoneicon2.png" )
local mat4 = Material( "icon32/zoom_extend.png" ) --icon64/tool
local mat5 = Material( "models/props_combine/com_shield001a.vmt" )
local mat6 = Material("phoenix_storms/wire/pcb_red.vmt")
local mat7 = Material( "ngui/nordahl_icon/sppt1.png" )

--function zworld_spawnpoint(a,b,c)



net.Receive("SynchJPS",function(len)

LocalPlayer():EmitSound("garrysmod/ui_return.wav",45,100)

local c1=net.ReadString()
local ent=Entity(c1)
local c2=net.ReadString()
local c3=net.ReadTable()
local c4=net.ReadTable()
local c5=net.ReadTable()
local entVer=ent.Ver
if !IsValid(ent) then return end
local jmet=ent:GetNWString('ent_jnom')
local showcube=ent:GetNWInt('ent_visible')
local disk=tonumber(c2)
local zcolorbase=Color(ent:GetNWInt('ent_red'),ent:GetNWInt('ent_green'),ent:GetNWInt('ent_bleu'),255)
local Menu = vgui.Create("DFrame")
Menu:SetSize(600,300)
Menu:SetPos(ScrW()-600-323-10,ScrH()-(Menu:GetTall()+5))
Menu:SetTitle("")
Menu:SetDraggable(true)
Menu:ShowCloseButton(false)
Menu:MakePopup()
Menu.Paint=function()
if !IsValid(ent) then
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
Menu:Close()
return end
draw.RoundedBox(6,0,0,Menu:GetWide(),Menu:GetTall(),Color(38,37,175,255))draw.RoundedBox(6,1,1,Menu:GetWide()-2,Menu:GetTall()-2,Color(255,255,255,255))
surface.SetDrawColor(255,255,255,255) 
surface.SetMaterial(Material("ngui/jps_by_nordahl.png"))surface.DrawTexturedRect(5,4,16,16)
draw.SimpleText(trajsp_nordahl.." Ver "..entVer.." : "..jmet,"Trebuchet18",28, 13, Color(zcolorbase.r/1.5,zcolorbase.g/1.5,zcolorbase.b/1.5), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
draw.SimpleText(trajsp_nordahl_a,"Trebuchet18",20,15, Color(0,0,0), TEXT_ALIGN_LEFT, 0, 1, Color(0,0,0,255))
draw.SimpleText(trajsp_nordahl_b,"Trebuchet18",20,60, Color(0,0,0), TEXT_ALIGN_LEFT, 0, 1, Color(0,0,0,255)) end

local button=vgui.Create("DButton",Menu)
button:SetText("")
button:SetPos(0,26)
button:SetSize( Menu:GetWide(), 30 )
button.Paint=function()
draw.RoundedBox( 0, 1, 0, button:GetWide()-2, button:GetTall(), Color(0,0,0, 255 ) )
draw.RoundedBox(0,1,1,button:GetWide()-2,button:GetTall()-2,Color(186,185,254,255))
draw.RoundedBox(0,1,20,button:GetWide()-2,9,Color(141,138,253,255))
draw.SimpleText(trajsp_nordahl_f..":".." "..jmet,"Trebuchet18",20,15, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
draw.RoundedBox(4,button:GetWide()/2-100,6,200,20-2,Color(zcolorbase.r,zcolorbase.g,zcolorbase.b,255))
draw.RoundedBox(4,button:GetWide()/2-100+1,6+1,198,18-2,Color(0,0,0,255))
draw.RoundedBox(4,button:GetWide()/2-100+1,6+10,198,5,Color(40,40,40,255))
draw.SimpleText("Change the Group?","Trebuchet18",button:GetWide()/2,15, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
button.DoClick=function()end

local textbox1=vgui.Create("DTextEntry",button)
textbox1:SetPos(button:GetWide()/2-100,5)
textbox1:SetSize(200,20)
textbox1:SetText(jmet)
textbox1.OnEnter=function(self)
local strR=string.Replace(self:GetValue(),"","")
textbox1:SetTextColor(Color(0,150,0,255))
RunConsoleCommand("spsetname",strR)
end

local zcolor = vgui.Create("DColorMixer",Menu);
zcolor:SetAlphaBar(false)
zcolor:SetPalette(false)
zcolor:SetWangs(false)	 
zcolor:SetSize(Menu:GetWide()-31,100);
zcolor:SetPos(20,75);
zcolor:SetColor(zcolorbase)
zcolor.Think = function(self)
if colorr!=zcolor:GetColor().r or colorg!=zcolor:GetColor().g or colorb!=zcolor:GetColor().b then
zcolorbase=zcolor:GetColor()
colorr=zcolorbase.r
colorg=zcolorbase.g
colorb=zcolorbase.b
RunConsoleCommand("sprecoitlescoulor",tostring(colorr),tostring(colorg),tostring(colorb))
end
end
-- local button=vgui.Create("DButton",Menu)
-- button:SetText("")
-- button:SetPos(250,160)
-- button:SetSize( 300, 30 )
-- button.Paint=function()
-- draw.RoundedBox(4,button:GetWide()/2-150,6,300,20-2,Color(zcolorbase.r,zcolorbase.g,zcolorbase.b,255))
-- draw.RoundedBox(4,button:GetWide()/2-150+1,6+1,298,18-2,Color(0,0,0,255))
-- draw.RoundedBox(4,button:GetWide()/2-150+1,6+10,298,5,Color(40,40,40,255))
-- draw.SimpleText("Apply this color","Trebuchet18",button:GetWide()/2,15, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
-- end
-- button.DoClick=function()
-- surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
-- RunConsoleCommand("sprecoitlescoulor",tostring(zcolor2.r),tostring(zcolor2.g),tostring(zcolor2.b))
-- end

local zizmatch=vgui.Create("DButton",Menu)
zizmatch:SetText("")
zizmatch:SetPos(20,200)
zizmatch:SetSize(90,90)
zizmatch.Paint=function()
if showlogo==1 then
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(186,254,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(141,253,138,255))

draw.RoundedBox(0,0,0,0,0,Color(255,255,255,255))
surface.SetMaterial(mat4)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText(trajsp_nordahl_c1,"Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
else
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(254,185,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(253,141,138,255))
draw.RoundedBox(0,0,0,0,0,Color(255,0,0,255))
surface.SetMaterial(mat4)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText(trajsp_nordahl_c2,"Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
end
end
zizmatch.DoClick=function()
surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
if showlogo==1 then
showlogo=0
RunConsoleCommand("spawncubedebug","0")
else
showlogo=1
RunConsoleCommand("spawncubedebug","1")
end
end
local zizmatch=vgui.Create("DButton",Menu)
zizmatch:SetText("")
zizmatch:SetPos(120,200)
zizmatch:SetSize(90,90)
zizmatch.Paint=function()
if showcube==1 then
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(186,254,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(141,253,138,255))
draw.RoundedBox(0,0,0,0,0,Color(255,255,255,255))
surface.SetMaterial(mat5)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText(trajsp_nordahl_d1,"Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
else
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(254,185,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(253,141,138,255))
draw.RoundedBox(0,22,22,44,44,Color(255,255,255,255))
surface.SetMaterial(mat6)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText(trajsp_nordahl_d2,"Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
end
end
zizmatch.DoClick=function()
surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
if showcube==1 then
showcube=0
RunConsoleCommand("spHidethecube","0")
else
showcube=1
RunConsoleCommand("spHidethecube","1")
end
end
local zizmatch=vgui.Create("DButton",Menu)
zizmatch:SetText("")
zizmatch:SetPos(220,200)
zizmatch:SetSize(90,90)
zizmatch.Paint=function()
if showcube==1 then
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(186,254,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(141,253,138,255))
draw.RoundedBox(0,0,0,0,0,Color(255,255,255,255))
surface.SetMaterial(mat5)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText("Hide All","Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
else
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(254,185,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(253,141,138,255))
draw.RoundedBox(0,22,22,44,44,Color(255,255,255,255))
surface.SetMaterial(mat6)surface.DrawTexturedRect(22,22,44,44)
draw.SimpleText("Show All","Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
end
end
zizmatch.DoClick=function()
surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
if showcube==1 then
showcube=0
RunConsoleCommand("nordahl_hide_all_cubemodel")
else
showcube=1
RunConsoleCommand("nordahl_show_all_cubemodel")
end
end

local zizmatch=vgui.Create("DButton",Menu)
zizmatch:SetText("")
zizmatch:SetPos(320,200)
zizmatch:SetSize(90,90)
zizmatch.Paint=function()
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(186,254,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(141,253,138,255))

surface.SetMaterial(mat7)surface.DrawTexturedRect(15,5,30,30)
surface.SetMaterial(mat7)surface.DrawTexturedRect(45,30,30,30)
draw.SimpleText("Duplicate","Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
end
zizmatch.DoClick=function()
RunConsoleCommand("Zworld_SP_Dup")surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
Menu:Close()
end


local zizmatch=vgui.Create("DButton",Menu)
zizmatch:SetText("")
zizmatch:SetPos(420,200)
zizmatch:SetSize(90,90)
zizmatch.Paint=function()
draw.RoundedBox(8,1,1,zizmatch:GetWide()-2,zizmatch:GetTall()-2,Color(186,254,185,255))
draw.RoundedBox(6,1,69,zizmatch:GetWide()-2,20,Color(141,253,138,255))
draw.RoundedBox(4,22,22,44,44,Color(255,0,0,255))
draw.SimpleText(trajsp_nordahl_e,"Trebuchet18",45,70, Color(255,255,255), TEXT_ALIGN_CENTER, 0, 1, Color(0,0,0,255))
end
zizmatch.DoClick=function()
surface.PlaySound("ambient/machines/keyboard1_clicks.wav")
RunConsoleCommand("RemovetheSPJ")
Menu:Close() end
local button=vgui.Create("DButton",Menu)button:SetText("")button:SetSize(136,16)
button.Paint=function()
if disk==1 then
draw.RoundedBox(4,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,button:GetWide()-2,button:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(2,1,10,button:GetWide()-2,4,Color(187,254,185,255))
draw.SimpleText("Persistant: ON","Trebuchet18",68,8, Color(0,150,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
else
draw.RoundedBox(4,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,button:GetWide()-2,button:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(2,1,10,button:GetWide()-2,4,Color(254,187,185,255))
draw.SimpleText("Persistant: OFF","Trebuchet18",68,8, Color(150,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
end
button:SetPos(Menu:GetWide()-200,5)
button.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
if disk==1 then disk=0 RunConsoleCommand("Zworld_SPJSauvegarde0") else disk=1 RunConsoleCommand("Zworld_SPJSauvegarde1") end
end


-- local button=vgui.Create("DButton",Menu)button:SetText("")
-- button:SetSize(80,16)
-- button:SetPos(Menu:GetWide()-190-74-94,5)
-- button.Paint=function()
-- draw.RoundedBox(4,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,255))
-- draw.RoundedBox(4,1,1,button:GetWide()-2,button:GetTall()-2,Color(255,255,255,255))
-- draw.RoundedBox(2,1,10,button:GetWide()-2,4,Color(187,254,185,255))
-- draw.SimpleText("Duplicate","Trebuchet18",40,8, Color(79,254,75), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
-- end
-- button.DoClick=function()
-- print(eRight(LocalPlayer()))
-- if eRight(LocalPlayer())==true then RunConsoleCommand("Zworld_SP_Dup")surface.PlaySound("ambient/machines/keyboard5_clicks.wav") end
-- end

local button=vgui.Create("DButton",Menu)button:SetText("")
button:SetSize(60,16)
button:SetPos(Menu:GetWide()-190-74,5)
button.Paint=function()
if disk==1 then
draw.RoundedBox(4,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,button:GetWide()-2,button:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(2,1,10,button:GetWide()-2,4,Color(187,254,185,255))
draw.SimpleText("Save","Trebuchet18",30,8, Color(0,150,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
else
draw.RoundedBox(4,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,button:GetWide()-2,button:GetTall()-2,Color(255,255,255,255))
draw.RoundedBox(2,1,10,button:GetWide()-2,4,Color(254,187,185,255))
draw.SimpleText("Save","Trebuchet18",30,8, Color(150,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
end
end
button.DoClick=function()
RunConsoleCommand("Zworld_SPsave")surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
end

local button=vgui.Create("DButton",Menu)button:SetText("")button:SetSize(16,16)
button.Paint=function()draw.RoundedBox(8,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,0))
end
button:SetPos(Menu:GetWide()-40,5)local zmodcm=vgui.Create("DImage",Menu)zmodcm:SetImage("icon16/Wrench.png")zmodcm:SetSize(16,16)zmodcm:SetPos(Menu:GetWide()-40,5)button.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
local z4=DermaMenu()

local subMenu,optMenu=z4:AddSubMenu("Languages")
optMenu:SetIcon("icon16/world.png")
local flche=""
if Z_Defaut_Languages==1 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Français",function()file.Write("nordahlclient_option/language.txt","1")nordahl_jpslanguefr(1)end):SetImage("ngui/la/fr.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==2 then flche=puce else flche="" end 
subMenu:AddOption(flche.."English",function()file.Write("nordahlclient_option/language.txt","2")nordahl_jpslangueen(2)end):SetImage("ngui/la/en.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==3 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Español",function()file.Write("nordahlclient_option/language.txt","3")nordahl_jpslanguees(3)end):SetImage("ngui/la/es.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==4 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Deutsch",function()file.Write("nordahlclient_option/language.txt","4")nordahl_jpslanguedu(4)end):SetImage("ngui/la/de.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==5 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Russian",function()file.Write("nordahlclient_option/language.txt","5")nordahl_jpslangueru(5)end):SetImage("ngui/la/ru.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==6 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Greek",function()file.Write("nordahlclient_option/language.txt","6")nordahl_jpslangueel(6)end):SetImage("ngui/la/el.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==7 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Portuguese",function()file.Write("nordahlclient_option/language.txt","7")nordahl_jpslanguept(7)end):SetImage("ngui/la/pt.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==8 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Polish",function()file.Write("nordahlclient_option/language.txt","8")nordahl_jpslanguepl(8)end):SetImage("ngui/la/pl.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==9 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Italian",function()file.Write("nordahlclient_option/language.txt","9")nordahl_jpslangueit(9)end):SetImage("ngui/la/it.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==10 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Bulgarian",function()file.Write("nordahlclient_option/language.txt","10")nordahl_jpslanguebg(10)end):SetImage("ngui/la/bg.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==11 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Czech",function()file.Write("nordahlclient_option/language.txt","11")nordahl_jpslanguecs(11)end):SetImage("ngui/la/cs.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==12 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Estonian",function()file.Write("nordahlclient_option/language.txt","12")nordahl_jpslangueet(12)end):SetImage("ngui/la/et.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==13 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Finnish",function()file.Write("nordahlclient_option/language.txt","13")nordahl_jpslanguefi(13)end):SetImage("ngui/la/fi.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==14 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Japanese",function()file.Write("nordahlclient_option/language.txt","14")nordahl_jpslangueja(14)end):SetImage("ngui/la/ja.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==15 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Korean",function()file.Write("nordahlclient_option/language.txt","15")nordahl_jpslangueko(15)end):SetImage("ngui/la/ko.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==16 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Latvian",function()file.Write("nordahlclient_option/language.txt","16")nordahl_jpslanguelv(16)end):SetImage("ngui/la/lv.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==17 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Norwegian",function()file.Write("nordahlclient_option/language.txt","17")nordahl_jpslangueno(17)end):SetImage("ngui/la/no.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==18 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Romanian",function()file.Write("nordahlclient_option/language.txt","18")nordahl_jpslanguero(18)end):SetImage("ngui/la/ro.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==19 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Swedish",function()file.Write("nordahlclient_option/language.txt","19")nordahl_jpslanguesv(19)end):SetImage("ngui/la/sv.png")
subMenu:AddSpacer()
if Z_Defaut_Languages==20 then flche=puce else flche="" end 
subMenu:AddOption(flche.."Turkish",function()file.Write("nordahlclient_option/language.txt","20")nordahl_jpslanguetr(20)end):SetImage("ngui/la/tr.png")
subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(79,254,75,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))end
local subMenu,optMenu=z4:AddSubMenu(tra_scrp_nordahl_script)
optMenu:SetIcon("icon16/wand.png")
subMenu:AddOption(tra_scrp_nordahl_credit,function()gui.OpenURL("https://originahl-scripts.com/profiles/76561198033784269") end):SetImage("ngui/nordahl.png")
subMenu:AddSpacer()
subMenu:AddOption(tra_scrp_nordahl_script.." :)",function()gui.OpenURL("https://originahl-scripts.com/gmod-scripts/1966/reviews-page-1") end):SetImage("icon16/star.png")
subMenu:AddSpacer()
subMenu:AddOption("Workshop Content",function()gui.OpenURL("http://steamcommunity.com/sharedfiles/filedetails/?id=493897275") end)
z4:AddSpacer()

subMenu.Paint=function()draw.RoundedBox(4,0,0,subMenu:GetWide(),subMenu:GetTall(),Color(79,254,75,255))
draw.RoundedBox(4,1,1,subMenu:GetWide()-2,subMenu:GetTall()-2,Color(255,255,255,255))end
z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(79,254,75,255))
draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end

z4:Open()
end


local button=vgui.Create("DButton",Menu)button:SetText("")button:SetSize(16,16)
button.Paint=function()draw.RoundedBox(8,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,0))
end
button:SetPos(Menu:GetWide()-60,5)local zmodcm=vgui.Create("DImage",Menu)zmodcm:SetImage("icon16/arrow_refresh.png")zmodcm:SetSize(16,16)zmodcm:SetPos(Menu:GetWide()-60,5)button.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")Menu:Close()
RunConsoleCommand("playerspawnpoint_open")
end

local button=vgui.Create("DButton",Menu)button:SetText("")button:SetSize(16,16)
button.Paint=function()draw.RoundedBox(8,0,0,button:GetWide(),button:GetTall(),Color(0,0,0,0))
end
button:SetPos(Menu:GetWide()-20,5)local zmodcm=vgui.Create("DImage",Menu)zmodcm:SetImage("icon16/cross.png")zmodcm:SetSize(16,16)zmodcm:SetPos(Menu:GetWide()-20,5)button.DoClick=function()surface.PlaySound("ambient/machines/keyboard5_clicks.wav")Menu:Close()
end








local panel = vgui.Create("DFrame",Menu)
panel:SetSize(323,600)
panel:SetPos(ScrW()-(panel:GetWide()+5),ScrH()-(panel:GetTall()+5))
panel:SetTitle("")
panel:SetDraggable(true)
panel:ShowCloseButton(false)
panel:MakePopup()
panel.Paint=function()draw.RoundedBox(6,0,0,panel:GetWide()-2,panel:GetTall(),Color(38,37,175,255))
draw.RoundedBox(6,1,1,panel:GetWide()-4,panel:GetTall()-2,Color(255,255,255,255))
surface.SetDrawColor(255,255,255,255)
if enabled==0 then
surface.SetMaterial(Material("icon16/cross.png"))surface.DrawTexturedRect(5,5,16,16)
draw.SimpleText("Disabled", "Trebuchet18", 28, 13, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

elseif enabled==1 then
surface.SetMaterial(Material("icon16/accept.png"))surface.DrawTexturedRect(5,5,16,16)
draw.SimpleText("Mode 1 : Autorisation System", "Trebuchet18", 28, 13, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

elseif enabled==2 then
surface.SetMaterial(matngui)surface.DrawTexturedRect(5,5,16,16)
draw.SimpleText("Mode 2 : Autorisation reversed System", "Trebuchet18", 28, 13, Color(0,0,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

end
end

local dpanel=vgui.Create("DPanel",panel)
dpanel:SetSize(panel:GetWide(),panel:GetTall())
dpanel.Paint=function()end
local iist  =vgui.Create("DIconLayout",dpanel)
iist:SetSize(dpanel:GetWide(),dpanel:GetTall())
iist:SetPos(5,25)
iist:SetSpaceY(6)
iist:SetSpaceX(5)
iist:SetBGColor(255,255,0,255)
iist:SetPaintBackgroundEnabled(true)
local undpanel=nil
greenvalue=1

local function miZaJ(crea,t,a,b,c)
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
crea:Clear()
for k,f in pairs(t)do
if f[1]==b then
f[2]=tonumber(c)
end
end
for k,v in pairs(t) do
if v[2]==1 then
crea:AddLine(v[1],zzrugmpod18,zzrugmpod4,k)
else
crea:AddLine(v[1],zzrugmpod18,zzrugmpod5,k)
end
end
RunConsoleCommand(a,b,c)
end

local function miZaJ2(crea,t,a,b,c)
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
crea:Clear()
for k,f in pairs(t)do
if f[2]==b then
f[3]=tonumber(c)
end
end
for k,v in pairs(t) do
if v[3]==1 then
crea:AddLine(v[1],zzrugmpod18,zzrugmpod4,k)
else
crea:AddLine(v[1],zzrugmpod18,zzrugmpod5,k)
end
end
RunConsoleCommand(a,b,c)
end

local function miZaJ3(crea,t,a,b,c,d)
surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
crea:Clear()
table.insert(t,{b,c,d})
for k,v in pairs(t) do
crea:AddLine(v[1],v[2],v[3],k)
end
RunConsoleCommand(a,b,c,d)
end

local function un()
if undpanel then undpanel:Remove() undpanel=nil end
undpanel=vgui.Create("DPanel",panel)
undpanel:SetPos(5,50)
undpanel:SetSize(panel:GetWide()-10,panel:GetTall()-55)
undpanel.Paint=function()
draw.RoundedBox(6,0,0,undpanel:GetWide()-1,undpanel:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,undpanel:GetWide()-3,undpanel:GetTall()-2,Color(zcolorbase.r/1.5,zcolorbase.g/1.5,zcolorbase.b/1.5,255))
end
local list2=vgui.Create("DListView",undpanel)
list2:SetPos(0,30)
list2:SetSize(undpanel:GetWide(),undpanel:GetTall()-30)
list2.Paint=function()
draw.RoundedBox(6,0,0,list2:GetWide()-1,list2:GetTall(),Color(0,0,0,255))
draw.RoundedBox(6,1,1,list2:GetWide()-3,list2:GetTall()-2,Color(zcolorbase.r+100,zcolorbase.g+100,zcolorbase.b+100,255))
end
list2:AddColumn("Job")
for k,v in pairs(c3) do
if v[2]==1 then
list2:AddLine(v[1],zzrugmpod18,zzrugmpod4,k)
else
list2:AddLine(v[1],zzrugmpod18,zzrugmpod5,k)
end
end
list2.OnRowRightClick=function(panel,id,line)
local z4=DermaMenu()
z4:AddOption("Delete",function()RunConsoleCommand("jsp_job_rem",line:GetColumnText(1))table.remove(c3,line:GetColumnText(4)) list2:RemoveLine(id)end):SetImage("icon16/cross.png")
z4:AddSpacer()
z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end
z4:Open()
end

local a=vgui.Create("DButton",undpanel)
a:SetText("")
a:SetPos(5,5)
a:SetSize(100,20)
a.Paint=function()
btnble(a,"Add".." Jobs","icon16/book.png")
end
a.DoClick=function()
surface.PlaySound("garrysmod/ui_return.wav")
local z4=DermaMenu()
for k,v in SortedPairsByMemberValue(team.GetAllTeams(), "Name") do
local Nil=bil
for q,f in pairs(c3) do
if f[1]==v.Name then
Nil=true
end
end
if Nil==nil then
z4:AddOption(v.Name,function()
table.insert(c3,{v.Name,zzrugmpod5})
list2:AddLine(v.Name,zzrugmpod18,zzrugmpod5,#c3)
RunConsoleCommand("jsp_job_add",v.Name)
end):SetImage("icon16/add.png")
z4:AddSpacer()
end
end

z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(0,0,0,255))
draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end
z4:Open()
end
local a=vgui.Create("DButton",undpanel)
a:SetText("")
a:SetPos(110,5)
a:SetSize(80,20)
a.Paint=function()
btnble(a,"Cleanup","icon16/cross.png")
end
a.DoClick=function()
list2:Clear()
RunConsoleCommand("jsp_job_del")
c3={}
surface.PlaySound("garrysmod/ui_return.wav")
end

end
	local function deux()
	if undpanel then undpanel:Remove() undpanel=nil end
	undpanel=vgui.Create("DPanel",panel)
	undpanel:SetPos(5,50)
	undpanel:SetSize(panel:GetWide()-10,panel:GetTall()-55)
	undpanel.Paint=function()
	draw.RoundedBox(6,0,0,undpanel:GetWide()-1,undpanel:GetTall(),Color(0,0,0,255))
	draw.RoundedBox(6,1,1,undpanel:GetWide()-3,undpanel:GetTall()-2,Color(zcolorbase.r/1.5,zcolorbase.g/1.5,zcolorbase.b/1.5,255))
	end
	local list2=vgui.Create("DListView",undpanel)
	list2:SetPos(0,30)
	list2:SetSize(undpanel:GetWide(),undpanel:GetTall()-30)
	list2.Paint=function()
	draw.RoundedBox(6,0,0,list2:GetWide()-1,list2:GetTall(),Color(0,0,0,255))
	draw.RoundedBox(6,1,1,list2:GetWide()-3,list2:GetTall()-2,Color(zcolorbase.r+100,zcolorbase.g+100,zcolorbase.b+100,255))
	end
	list2:AddColumn("ULX Rank Name")
	for k,v in pairs(c4) do
	list2:AddLine(v[1],zzrugmpod18,zzrugmpod5,k)
	end
	list2.OnRowRightClick=function(panel,id,line)
	local z4=DermaMenu()
	z4:AddOption("Delete",function()RunConsoleCommand("jsp_ulx_rem",line:GetColumnText(1))table.remove(c4,line:GetColumnText(4)) list2:RemoveLine(id)end):SetImage("icon16/cross.png")
	z4:AddSpacer()
	z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(0,0,0,255))
	draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end
	z4:Open()
	end
	local dtext=vgui.Create("DTextEntry",undpanel)
	dtext:SetPos(5,5)
	dtext:SetSize(140,20)
	dtext:SetText("Nom du rang et entrée")
	dtext.OnEnter=function(self)
	local strR=string.Replace(self:GetValue(),"","")
	
	local N3l=nil
	for q,f in pairs(c4) do
	if f[1]==strR then
	N3l=true
	end
	end
	if !N3l then
	dtext:SetTextColor(Color(0,150,0,255))
	dtext:SetText("Good")
	RunConsoleCommand("jsp_ulx_add",strR)
	table.insert(c4,{strR,zzrugmpod5})
	list2:AddLine(strR,zzrugmpod18,zzrugmpod5,#c4)
	surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
	else
	dtext:SetTextColor(Color(150,0,0,255))
	dtext:SetText("Exist Already in the list")
	surface.PlaySound("garrysmod/ui_return.wav")
	
	end
	end
	local a=vgui.Create("DButton",undpanel)
	a:SetText("")
	a:SetPos(150,5)
	a:SetSize(80,20)
	a.Paint=function()
	btnble(a,"Cleanup","icon16/cross.png")
	end
	a.DoClick=function()
	list2:Clear()
	RunConsoleCommand("jsp_ulx_del")
	c4={}
	surface.PlaySound("garrysmod/ui_return.wav")
	end
	end

		local function trois()
		if undpanel then undpanel:Remove() undpanel=nil end
		undpanel=vgui.Create("DPanel",panel)
		undpanel:SetPos(5,50)
		undpanel:SetSize(panel:GetWide()-10,panel:GetTall()-55)
		undpanel.Paint=function()
		draw.RoundedBox(6,0,0,undpanel:GetWide()-1,undpanel:GetTall(),Color(0,0,0,255))
		draw.RoundedBox(6,1,1,undpanel:GetWide()-3,undpanel:GetTall()-2,Color(zcolorbase.r/1.5,zcolorbase.g/1.5,zcolorbase.b/1.5,255))
		end
		local list2=vgui.Create("DListView",undpanel)
		list2:SetPos(0,30)
		list2:SetSize(undpanel:GetWide(),undpanel:GetTall()-30)
		list2.Paint=function()
		draw.RoundedBox(6,0,0,list2:GetWide()-1,list2:GetTall(),Color(0,0,0,255))
		draw.RoundedBox(6,1,1,list2:GetWide()-3,list2:GetTall()-2,Color(zcolorbase.r+100,zcolorbase.g+100,zcolorbase.b+100,255))
		end
		list2:AddColumn("Name of the Teamgroup")
		for k,v in pairs(c5) do
		list2:AddLine(v[1],v[2],zzrugmpod4,k)
		end
		list2.OnRowRightClick=function(panel,id,line)
		local z4=DermaMenu()
		z4:AddOption("Delete",function()RunConsoleCommand("jsp_teamgroup_rem",line:GetColumnText(1))table.remove(c5,line:GetColumnText(4)) list2:RemoveLine(id)end):SetImage("icon16/cross.png")
		z4:AddSpacer()
		z4.Paint=function()draw.RoundedBox(4,0,0,z4:GetWide(),z4:GetTall(),Color(0,0,0,255))
		draw.RoundedBox(4,1,1,z4:GetWide()-2,z4:GetTall()-2,Color(255,255,255,255))end
		z4:Open()
		end
		local dtext=vgui.Create("DTextEntry",undpanel)
		dtext:SetPos(5,5)
		dtext:SetSize(140,20)
		dtext:SetText("Nom du rang et entrée")
		dtext.OnEnter=function(self)
		local strR=string.Replace(self:GetValue(),"","")
		
		local N3l=nil
		for q,f in pairs(c5) do
		if f[1]==strR then
		N3l=true
		end
		end
		if !N3l then
		dtext:SetTextColor(Color(0,150,0,255))
		dtext:SetText("Good")
		RunConsoleCommand("jsp_teamg_add",strR)
		table.insert(c5,{strR,zzrugmpod5})
		list2:AddLine(strR,zzrugmpod18,zzrugmpod5,#c5)
		surface.PlaySound("ambient/machines/keyboard5_clicks.wav")
		else
		dtext:SetTextColor(Color(150,0,0,255))
		dtext:SetText("Exist Already in the list")
		surface.PlaySound("garrysmod/ui_return.wav")
		
		end
		end
		local a=vgui.Create("DButton",undpanel)
		a:SetText("")
		a:SetPos(150,5)
		a:SetSize(80,20)
		a.Paint=function()
		btnble(a,"Cleanup","icon16/cross.png")
		end
		a.DoClick=function()
		list2:Clear()
		RunConsoleCommand("jsp_teamgroup_del")
		c5={}
		surface.PlaySound("garrysmod/ui_return.wav")
		end
		end
		
un()

local a=vgui.Create("DButton",iist)
a.val=1
a:SetText("")
a:SetSize(100,20)
a.Paint=function()
btnble(a,"Job List","icon16/book.png")
end
a.DoClick=function()
surface.PlaySound("garrysmod/ui_return.wav")
greenvalue=1
un()
end

local a=vgui.Create("DButton",iist)
a.val=3
a:SetText("")
a:SetSize(100,20)
a.Paint=function()
btnble(a,"U".."L".."X & ".."Ranks","icon16/coins.png")
end
a.DoClick=function()
surface.PlaySound("garrysmod/ui_return.wav")
greenvalue=3
deux()
end

local a=vgui.Create("DButton",iist)
a.val=2
a:SetText("")
a:SetSize(100,20)
a.Paint=function()
btnble(a,"Teamgroup","icon16/user.png")
end
a.DoClick=function()
surface.PlaySound("garrysmod/ui_return.wav")
greenvalue=2
trois()
end
end)

																																																								/* Memory Old script in 2.3																																																																														
																																																								pos=pos:ToScreen()
																																																								draw.RoundedBox(0,0,0,0,0,Color(v:GetNWInt("ent_red"),v:GetNWInt("ent_green"),v:GetNWInt("ent_bleu"),255))																																																																																																																																										
																																																								surface.SetMaterial(mat7)surface.DrawTexturedRect(pos.x-8,pos.y-8,16,16)																																																																																																																																																		
																																																								draw.SimpleText(v:GetNWInt("ent_jnom"),"Trebuchet18",pos.x+14,pos.y-6,Color(v:GetNWInt("ent_red"),v:GetNWInt("ent_green"),v:GetNWInt("ent_bleu"),190),TEXT_ALIGN_LEFT,0)																																																																																																																											
																																																								end																																																																																																																																																																				1966 
																																																								end																																																																																																																																																																				8774 
																																																								end																																																																																																																																																																				2.5 
																																																								end																																																																																																																																																																				{{ script_version_hash }} 
																																																								hook.Add("HUDPaint","nordahl_jbspawnpointeye",wh);	
																																																								*/																																																																																	


local function wh()
if LocalPlayer():GetNWInt("spawncubedebug")==1 then
for k,v in pairs(ents.FindByClass("job_spawn_point")) do
pos=v:GetPos()+Vector(0,0,10)
pos.z=pos.z
pos=pos:ToScreen()
draw.RoundedBox(0,0,0,0,0,Color(v:GetNWInt("ent_red"),v:GetNWInt("ent_green"),v:GetNWInt("ent_bleu"),255))
surface.SetMaterial(mat7)surface.DrawTexturedRect(pos.x-8,pos.y-8,16,16)
surface.SetMaterial(mat7)surface.DrawTexturedRect(pos.x-8,pos.y-8,16,16)
draw.SimpleText("Player Spawn : "..v:GetNWInt("ent_jnom"),"Trebuchet24",pos.x+14,pos.y-6,Color(v:GetNWInt("ent_red"),v:GetNWInt("ent_green"),v:GetNWInt("ent_bleu"),255),TEXT_ALIGN_LEFT,0)
end
end
end
hook.Add("HUDPaint","nordahl_jbspawnpointeye",wh);

local function jsp_info()
print("")
print("The script 'nordahl_area_restrictor' is not enabled.")
print("Please read the description of the script")
print("Information - English        : https://originahl-scripts.com/en/help")
print("Information - Français       : https://originahl-scripts.com/fr/help")
print("")
end
concommand.Add("jsp_info",jsp_info)