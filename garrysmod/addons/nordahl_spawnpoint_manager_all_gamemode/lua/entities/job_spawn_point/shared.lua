
local Ver="3.0"
if NCS_VER==nil then
NCS_VER={}
NCS_VER["nordahl_spawnpoint_manager_all_gamemode"]=Ver
else
NCS_VER["nordahl_spawnpoint_manager_all_gamemode"]=Ver
end

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
local exemplesteamid64="{{ user.id }}"

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Player_Spawn_Point"
ENT.Author			= "Nordahl"
ENT.Contact        = "nordahl@zworld-afterlife.com"
ENT.Information		= ""
ENT.Category		= "Nordahl Scripts"
ENT.Ver=Ver
ENT.Spawnable			= true
ENT.AdminSpawnable		= true