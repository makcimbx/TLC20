
local Leak_Protection_Status=[[OK]]
/* READ THIS BEFORE HAVE PROBLEM PLEASE,

If you find my work serious know they are all my other scripts here: https://originahl-scripts.com/gmod-scripts
I'm not only an simple coder you can see and support my creativity:

My Facebook Page: https://www.facebook.com/zworld.afterlife/
My Drawing: http://steamcommunity.com/id/zworld-dev/images/
My Steam Group: http://steamcommunity.com/groups/zworld-afterlife
My servers here: https://zworld-afterlife.com/fr/servers


----1.Script Activation & antileak----
Tout ce que tu dois savoir: https://originahl-scripts.com/fr/help
All you must know:  https://originahl-scripts.com/en/help

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
local exemplesteamid64=""

function jRight(a)
if a:SteamID()==JSP_CONFIG.OwnerSteamID then return true end
if a:IsAdmin()==true then if JSP_CONFIG.Allow_Admin==1 then return true end end
if a:IsSuperAdmin()==true then if JSP_CONFIG.Allow_SUPER_Admin==1 then return true end end
for _,c in ipairs(JSP_CONFIG.Allow_ULX_GROUP_CAN_ACCESS_PANEL)do if a:IsUserGroup(c)then return true end end
return false
end

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
AddCSLuaFile("config.lua")
include('config.lua')

function jsp_ntinit(self)
timer.Simple(0.3,function()
if IsValid(self)then
self:SetNWInt("ent_red",self.ent_red)
end
end)timer.Simple(0.4,function()
if IsValid(self)then
self:SetNWInt("ent_green",self.ent_green)
end
end)timer.Simple(0.5,function()
if IsValid(self)then
self:SetNWInt("ent_bleu",self.ent_bleu)
end
end)timer.Simple(0.6,function()
if IsValid(self)then
self:SetNWString("ent_jnom",self.ent_jnom)
end
end)timer.Simple(0.7,function()
if IsValid(self)then
self:SetNWInt("ent_visible",self.ent_visible)
self:SetColor(Color(self.ent_red,self.ent_green,self.ent_bleu,255))
end
end)
end

local function jsp_ntsave()
local zontentmap={}
for _,c in ipairs(ents.FindByClass("job_spawn_point"))do
if c.zpersistance==1 then
table.insert(zontentmap,{c:GetPos(),c:GetNWInt("ent_red"),c:GetNWInt("ent_green"),c:GetNWInt("ent_bleu"),c:GetNWString("ent_jnom"),c:GetNWInt("ent_visible"),c.autLjob,c.autLulx,c.autLteamG,"1"})
end
end
local icifconvert=util.TableToJSON(zontentmap)
file.CreateDir("nordahl_player_spawnpoint")
file.Write("nordahl_player_spawnpoint/"..game.GetMap()..".txt",icifconvert)
end

function ENT:Initialize()
self.Entity:SetModel("models/hunter/blocks/cube025x025x025.mdl")
self.Entity:PhysicsInit(SOLID_VPHYSICS)
self.Entity:SetMoveType(MOVETYPE_NONE)
self.Entity:SetSolid(SOLID_VPHYSICS)
self.Entity:SetUseType(SIMPLE_USE)
self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
if self.zpersistance==nil then
self.ent_red=20
self.ent_green=90
self.ent_bleu=200
self.ent_jnom="Name"
self.ent_visible=JSP_CONFIG.entvisible
self.autLjob={}
self.autLulx={}
self.autLteamG={}
self.zpersistance=0
end
local phys=self.Entity:GetPhysicsObject()
if(phys:IsValid())then
phys:Wake()
self.Entity:GetPhysicsObject():EnableMotion(false)
end
self.Entity:DrawShadow(false)
jsp_ntinit(self)
self.Cache={}
end

function ENT:OnRemove(a)
local zpersistance=self.zpersistance
if zpersistance!=1 then return end
local GetPos=self:GetPos()
local ent_red=self.ent_red
local ent_green=self.ent_green
local ent_bleu=self.ent_bleu
local ent_jnom=self.ent_jnom
local ent_visible=self.ent_visible
local autLjob=self.autLjob
local autLulx=self.autLulx
local autLteamG=self.autLteamG
timer.Simple(2,function()
local ent2=ents.Create("job_spawn_point")
ent2:SetAngles(Angle(0,0,0))
ent2:SetPos(GetPos)
ent2:Spawn()
ent2.ent_red=ent_red
ent2.ent_green=ent_green
ent2.ent_bleu=ent_bleu
ent2.ent_jnom=ent_jnom
ent2.ent_visible=ent_visible
ent2.autLjob=autLjob
ent2.autLulx=autLulx
ent2.autLteamG=autLteamG
ent2.zpersistance=1
end)
end

function playerspawnpoint_open(a,b,c)
if jRight(a)and IsValid(a.pent)then
nord_JSP_begin(a,a.pent)
end
end
concommand.Add('playerspawnpoint_open',playerspawnpoint_open)

function ENT:Use(a)
if jRight(a)then
--self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

if !nord_JSP_begin then
print("")
print("The script 'nordahl_area_restrictor' is not enabled.")
print("Please read the description of the script")
print("Information - English        : https://originahl-scripts.com/en/help")
print("Information - Français       : https://originahl-scripts.com/fr/help")
print("")
a:ConCommand("jsp_info")
else
a.pent=self
nord_JSP_begin(a,self)
end
end
end

function ENT:Think()return true end

local function sprecoitlescoulor(a,b,c)
if jRight(a)and IsValid(a.pent)then
a.pent:SetNWInt("ent_red",math.Round(tonumber(c[1])))
a.pent.ent_red=math.Round(tonumber(c[1]))
a.pent:SetNWInt("ent_green",math.Round(tonumber(c[2])))
a.pent.ent_green=math.Round(tonumber(c[2]))
a.pent:SetNWInt("ent_bleu",math.Round(tonumber(c[3])))
a.pent.ent_bleu=math.Round(tonumber(c[3]))
a.pent:SetColor(Color(math.Round(tonumber(c[1])),math.Round(tonumber(c[2])),math.Round(tonumber(c[3])),255))
end
end
concommand.Add("sprecoitlescoulor",sprecoitlescoulor)

function spawncubedebug(a,b,c)
if jRight(a)and IsValid(a.pent)then
if a:GetNWInt("spawncubedebug")==1 then
a:SetNWInt("spawncubedebug",0)
else
a:SetNWInt("spawncubedebug",1)
end
end
end
concommand.Add("spawncubedebug",spawncubedebug)

function spHidethecube(a,b,c)
if jRight(a)and IsValid(a.pent)then
if a.pent:GetNWInt("ent_visible")==1 then
a.pent:SetNWInt("ent_visible",0)
a.pent.ent_visible=0
else
a.pent:SetNWInt("ent_visible",1)
a.pent.ent_visible=1
end
end
end
concommand.Add("spHidethecube",spHidethecube)

function spsetname(a,b,c)
if jRight(a)and IsValid(a.pent)then
a.pent.ent_jnom=c[1]
a.pent:SetNWInt("ent_jnom",c[1])
end
end
concommand.Add("spsetname",spsetname)

function RemovetheSPJ(a,b,c)
if jRight(a)and IsValid(a.pent)then
print("Spawn Point is deleted by ",a)
a.pent:Remove()
end
end
concommand.Add("RemovetheSPJ",RemovetheSPJ)


function nordahl_admineyes_disable(a,b,c)
if jRight(a)and IsValid(a)then
a:SetNWInt("spawncubedebug",0)
end
end
concommand.Add("nordahl_admineyes_disable",nordahl_admineyes_disable)

function nordahl_admineyes_enable(a,b,c)
if jRight(a)and IsValid(a)then
a:SetNWInt("spawncubedebug",1)
end
end
concommand.Add("nordahl_admineyes_enable",nordahl_admineyes_enable)

function nordahl_hide_all_cubemodel(a,b,c)
if jRight(a)and IsValid(a)then for _,c in ipairs(ents.FindByClass("job_spawn_point"))do c:SetNWInt("ent_visible",0)c.ent_visible=0 end 
jsp_ntsave()
end
end
concommand.Add("nordahl_hide_all_cubemodel",nordahl_hide_all_cubemodel)

function nordahl_show_all_cubemodel(a,b,c)
if jRight(a)and IsValid(a)then for _,c in ipairs(ents.FindByClass("job_spawn_point"))do c:SetNWInt("ent_visible",1)c.ent_visible=1 end 
jsp_ntsave()
end
end
concommand.Add("nordahl_show_all_cubemodel",nordahl_show_all_cubemodel)

function nordahl_make_allspawnpoint_persistent(a,b,c)
if jRight(a)and IsValid(a)then
for _,c in ipairs(ents.FindByClass("job_spawn_point"))do
c.zpersistance=1
end
jsp_ntsave()
end
end
concommand.Add("nordahl_make_allspawnpoint_persistent",nordahl_make_allspawnpoint_persistent)

function Zworld_SPJSauvegarde1(a)
if jRight(a)and IsValid(a.pent)then
a.pent.zpersistance=1
jsp_ntsave()
end
end
concommand.Add("Zworld_SPJSauvegarde1",Zworld_SPJSauvegarde1)

function Zworld_SPJSauvegarde0(a)
if jRight(a)and IsValid(a.pent)then
a.pent.zpersistance=0
jsp_ntsave()
end
end
concommand.Add("Zworld_SPJSauvegarde0",Zworld_SPJSauvegarde0)

function nordahl_player_spawnpoint_cleanup(a)
if jRight(a)then
for _,c in ipairs(ents.FindByClass("job_spawn_point"))do
c:Remove()
file.Write("nordahl_player_spawnpoint/"..game.GetMap()..".txt","")
end
end
end
concommand.Add("nordahl_player_spawnpoint_cleanup",nordahl_player_spawnpoint_cleanup)

if rered==nil then
rered=1
timer.Simple(2,function()
local files=file.Read("nordahl_player_spawnpoint/"..game.GetMap()..".txt","DATA")
if(!files)then
file.CreateDir("nordahl_player_spawnpoint")
file.Write("nordahl_player_spawnpoint/"..game.GetMap()..".txt","")
end
local barricade=file.Read("nordahl_player_spawnpoint/"..game.GetMap()..".txt")
if barricade!="" then 
for k,v in pairs(util.JSONToTable(file.Read("nordahl_player_spawnpoint/"..game.GetMap()..".txt")))do
local ent2=ents.Create("job_spawn_point")
ent2:SetAngles(Angle(0,0,0))
ent2:SetPos(v[1])
ent2:Spawn()
ent2.ent_red=tonumber(v[2])
ent2.ent_green=tonumber(v[3])
ent2.ent_bleu=tonumber(v[4])
ent2.ent_jnom=tostring(v[5])
ent2.ent_visible=tonumber(v[6])
ent2.autLjob=v[7]
ent2.autLulx=v[8]
ent2.autLteamG=v[9]
jsp_ntinit(ent2)
ent2.Cache={}
ent2:DrawShadow(false)
ent2.zpersistance=1
end
end
end)
end

function Zworld_SPsave(a)
if jRight(a)and IsValid(a.pent)then
jsp_ntsave()
end
end
concommand.Add("Zworld_SPsave",Zworld_SPsave)

function Zworld_SP_Dup(a)
local self=a.pent
if jRight(a)and IsValid(self)then
local ent2=ents.Create("job_spawn_point")
ent2:SetAngles(Angle(0,0,0))
ent2:SetPos(self:GetPos()+Vector(0,0,20))
ent2.ent_red=self.ent_red
ent2.ent_green=self.ent_green
ent2.ent_bleu=self.ent_bleu
ent2.ent_jnom=self.ent_jnom
ent2.ent_visible=tonumber(self.ent_visible)
ent2.zpersistance=0
ent2.autLjob=self.autLjob
ent2.autLulx=self.autLulx
ent2.autLteamG=self.autLteamG
ent2:Spawn()

end
end
concommand.Add("Zworld_SP_Dup",Zworld_SP_Dup)

function XYZNordJSP2(pl,self)
if(self.TeamBased)then
local ent=self:PlayerSelectTeamSpawn(pl:Team(),pl)
if(IsValid(ent))then return ent end
end
if(!IsTableOfEntitiesValid(self.SpawnPoints))then
self.LastSpawnPoint=0
self.SpawnPoints=ents.FindByClass("info_player_start")
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_deathmatch"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_combine"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_rebel"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_counterterrorist"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_terrorist"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_axis"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_allies"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("gmod_player_start"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_teamspawn"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("ins_spawnpoint"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("aoc_spawnpoint"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("dys_spawn_point"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_pirate"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_viking"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_knight"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("diprip_start_team_blue"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("diprip_start_team_red"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_red"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_blue"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_coop"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_human"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_zombie"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_deathmatch"))
self.SpawnPoints=table.Add(self.SpawnPoints,ents.FindByClass("info_player_zombiemaster"))
end
local Count=table.Count(self.SpawnPoints)
if(Count==0)then
return nil
end
for k,v in pairs(self.SpawnPoints)do
if(v:HasSpawnFlags(1)&& hook.Call("IsSpawnpointSuitable",self,pl,v,true))then
return v
end
end
local ChosenSpawnPoint=nil
for i=1,Count do
ChosenSpawnPoint=table.Random(self.SpawnPoints)
if(IsValid(ChosenSpawnPoint)&& ChosenSpawnPoint:IsInWorld())then
if((ChosenSpawnPoint==pl:GetVar("LastSpawnpoint")|| ChosenSpawnPoint==self.LastSpawnPoint)&& Count > 1)then continue end

if(hook.Call("IsSpawnpointSuitable",self,pl,ChosenSpawnPoint,i==Count))then

self.LastSpawnPoint=ChosenSpawnPoint
pl:SetVar("LastSpawnpoint",ChosenSpawnPoint)
return ChosenSpawnPoint
end
end
end
return ChosenSpawnPoint

end

if JSP_CONFIG.USeWorkshopContent==1 then
resource.AddWorkshop("493897275")
end

hook.Add("PhysgunPickup","JSP_Pickup_Entities",function(ply,ent)
if ent:GetClass()=="job_spawn_point" then
if jRight(ply)and ent:GetNWInt("ent_visible")==1 then return true end
return false
end
end)


-----0-----00011----------10--------------0-----------------

--------------0-1-0----------------1-1-1---------1-0-01-0-0-1--0

