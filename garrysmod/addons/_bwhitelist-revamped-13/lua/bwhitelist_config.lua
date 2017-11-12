BWhitelist.Config = {} local config = BWhitelist.Config
--[[


	██╗    ██╗ █████╗ ██████╗ ███╗   ██╗██╗███╗   ██╗ ██████╗
	██║    ██║██╔══██╗██╔══██╗████╗  ██║██║████╗  ██║██╔════╝
	██║ █╗ ██║███████║██████╔╝██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
	██║███╗██║██╔══██║██╔══██╗██║╚██╗██║██║██║╚██╗██║██║   ██║
	╚███╔███╔╝██║  ██║██║  ██║██║ ╚████║██║██║ ╚████║╚██████╔╝
	 ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝

	If you are using a leak of BWhitelist, before you even bother to configure it, I warn you that the leak WILL NOT work.

	If you are willing to take the risk, you may be causing yourself a danger. SO DON'T DO IT.

	You can purchase the script on ScriptFodder.

	----------------------------------------------------------------------------------------------------------------------------------------------------------------

	Si tu utilises un leak de BWhitelist, avant que tu te fasses chier à le configurer, je te préviens que ce leak NE MARCHERA PAS.

	Si tu tiens à prendre le risque, tu te poses un danger inutile. ALORS NE LE FAIS PAS.

	Tu peux acheter ce script sur ScriptFodder.

	=================================================================================================================================================================

	██████╗ ██╗    ██╗██╗  ██╗██╗████████╗███████╗██╗     ██╗███████╗████████╗     ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
	██╔══██╗██║    ██║██║  ██║██║╚══██╔══╝██╔════╝██║     ██║██╔════╝╚══██╔══╝    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
	██████╔╝██║ █╗ ██║███████║██║   ██║   █████╗  ██║     ██║███████╗   ██║       ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
	██╔══██╗██║███╗██║██╔══██║██║   ██║   ██╔══╝  ██║     ██║╚════██║   ██║       ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
	██████╔╝╚███╔███╔╝██║  ██║██║   ██║   ███████╗███████╗██║███████║   ██║       ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
	╚═════╝  ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚══════╝╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝

	Please note that there is quite a lot of profanity and insults in this config, mostly because many people can't FUCKING READ
	However, if you can read and you have common sense, we're best bros so you can just ignore the profanity.
	It is also present for comedic purposes, because configuring is boring as fuck.

	WARNING: Are you retarded? Then this might be more difficult for you! The config is very simple and I provide instructions,
			 examples, templates and more but some people still can't figure it out. If that's you, read it again and PLEASE
			 don't make a ticket. We have more important things to attend to and configuration of addons is NEVER the developer's
			 responsibility.

	WARNING: You might need to know English to configure this addon! Wow, surprise surprise, English is a very popular language!
			 Maybe you should learn it if you don't know it. Haha, let's all keep laughing at how France is the least English
			 speaking country in Europe.

	WARNING: Use a fucking syntax text editor! Are you using Notepad? Fuck off! Download Notepad++, Sublime Text or Atom.io.

	███╗   ███╗██╗   ██╗███████╗ ██████╗ ██╗
	████╗ ████║╚██╗ ██╔╝██╔════╝██╔═══██╗██║
	██╔████╔██║ ╚████╔╝ ███████╗██║   ██║██║
	██║╚██╔╝██║  ╚██╔╝  ╚════██║██║▄▄ ██║██║
	██║ ╚═╝ ██║   ██║   ███████║╚██████╔╝███████╗
	╚═╝     ╚═╝   ╚═╝   ╚══════╝ ╚══▀▀═╝ ╚══════╝

	Looking for the MySQL config? Go to bwhitelist_mysql_config.lua.

		 __
	    / /  __ _ _ __   __ _ _   _  __ _  __ _  ___
	   / /  / _` | '_ \ / _` | | | |/ _` |/ _` |/ _ \
	  / /__| (_| | | | | (_| | |_| | (_| | (_| |  __/
	  \____/\__,_|_| |_|\__, |\__,_|\__,_|\__, |\___|
	                    |___/             |___/

	BWhitelist currently supports two languages, English and French.

	If you'd like to contribute to the translation of BWhitelist, please contact me.
	Understand however that you need to be FLUENT in English AND the other language(s).
	A chain is only as strong as its weakest link!

	EXAMPLES:

	config.DefaultLanguage = "English"
	config.DefaultLanguage = "French"

	Change the language below. If you're an idiot and you spell it wrong or something
	it will default to English.

]] config.DefaultLanguage = "English" --[[

	                     ___                    _ _   _           _
	  /\/\   __ ___  __ / _ \___ _ __ _ __ ___ (_) |_| |_ ___  __| |
	 /    \ / _` \ \/ // /_)/ _ \ '__| '_ ` _ \| | __| __/ _ \/ _` |
	/ /\/\ \ (_| |>  </ ___/  __/ |  | | | | | | | |_| ||  __/ (_| |
	\/    \/\__,_/_/\_\/    \___|_|  |_| |_| |_|_|\__|\__\___|\__,_|

	This setting is a list of SteamIDs, SteamID64s and usergroups that
	have maximum permissions to BWhitelist.

	FUCKING READ THIS SHIT OKAY??

	If you have someone in MaxPermitted (this is common sense btw, you retard)
	then you don't need to put them in the next setting, Permissions. Why?
	Because as said above, THEY HAVE MAXIMUM FUCKING PERMISSIONS

	By maximum fucking permissions I mean they can wipe your whole whitelist,
	disable all whitelists, enable all whitelists, etc.

	In the table (or list for you simpletons) you will add SteamIDs, SteamID64s and usergroups.

	A SteamID looks like this:

	STEAM_0:1:40314158

	A SteamID64 looks like this:

	76561198040894045

	and (you should know this as a server owner or "developer" (btw, stop calling yourself a fucking developer,
	I'm a developer, you're a configurer unless you can actually CODE Lua.)) a usergroup is whatever you want it
	to be.

	Here's a few examples of MaxPermitted:

	config.MaxPermitted = {"STEAM_0:1:40314158"}

	config.MaxPermitted = {"76561198074425791","STEAM_0:1:40314158"}

	config.MaxPermitted = {"76561198074425791","STEAM_0:1:40314158","superadmin"}

	config.MaxPermitted = {"superadmin"}

	Do you get it now? A table is a list? Every item is seperated by commas? Good? Okay.

]] config.MaxPermitted = {"superadmin"} --[[

	 __  __            _____                    _ _   _           _ _____  _           _     _   __          ___     _ _       _ _     _
	|  \/  |          |  __ \                  (_) | | |         | |  __ \(_)         | |   | |  \ \        / / |   (_) |     | (_)   | |
	| \  / | __ ___  _| |__) |__ _ __ _ __ ___  _| |_| |_ ___  __| | |  | |_ ___  __ _| |__ | | __\ \  /\  / /| |__  _| |_ ___| |_ ___| |_ ___
	| |\/| |/ _` \ \/ /  ___/ _ \ '__| '_ ` _ \| | __| __/ _ \/ _` | |  | | / __|/ _` | '_ \| |/ _ \ \/  \/ / | '_ \| | __/ _ \ | / __| __/ __|
	| |  | | (_| |>  <| |  |  __/ |  | | | | | | | |_| ||  __/ (_| | |__| | \__ \ (_| | |_) | |  __/\  /\  /  | | | | | ||  __/ | \__ \ |_\__ \
	|_|  |_|\__,_/_/\_\_|   \___|_|  |_| |_| |_|_|\__|\__\___|\__,_|_____/|_|___/\__,_|_.__/|_|\___| \/  \/   |_| |_|_|\__\___|_|_|___/\__|___/

	If this is set to true, then people who are not MaxPermitted (read above) won't be able to disable or enable whitelists.
	If this is set to false, the opposite will apply.

	Examples:

	config.MaxPermittedDisableWhitelists = true
	config.MaxPermittedDisableWhitelists = false

]] config.MaxPermittedDisableWhitelists = true --[[

	                     ___                    _ _   _           _ __ _    _      __    __ _     _ _       _ _     _
	  /\/\   __ ___  __ / _ \___ _ __ _ __ ___ (_) |_| |_ ___  __| / _\ | _(_)_ __/ / /\ \ \ |__ (_) |_ ___| (_)___| |_ ___
	 /    \ / _` \ \/ // /_)/ _ \ '__| '_ ` _ \| | __| __/ _ \/ _` \ \| |/ / | '_ \ \/  \/ / '_ \| | __/ _ \ | / __| __/ __|
	/ /\/\ \ (_| |>  </ ___/  __/ |  | | | | | | | |_| ||  __/ (_| |\ \   <| | |_) \  /\  /| | | | | ||  __/ | \__ \ |_\__ \
	\/    \/\__,_/_/\_\/    \___|_|  |_| |_| |_|_|\__|\__\___|\__,_\__/_|\_\_| .__/ \/  \/ |_| |_|_|\__\___|_|_|___/\__|___/
	                                                                         |_|

	Woah there, isn't that a bit of a mouthful? Don't worry, I can't read that ASCII art, either! It says "MaxPermittedSkipWhitelists".

	Anyway, this is either true or false. If it's true, when someone in MaxPermitted (above) tries to join a whitelisted job, they'll
	be let through regardless of whether they're actually whitelisted or not.

	If it's false, then if they try to join a whitelisted job, they'll go through the standard whitelist check everyone goes through.

	Here's two examples for you dumbasses:

	config.MaxPermittedSkipWhitelists = true

	config.MaxPermittedSkipWhitelists = false

]] config.MaxPermittedSkipWhitelists = false --[[

	   ___                    _         _
	  / _ \___ _ __ _ __ ___ (_)___ ___(_) ___  _ __  ___
	 / /_)/ _ \ '__| '_ ` _ \| / __/ __| |/ _ \| '_ \/ __|
	/ ___/  __/ |  | | | | | | \__ \__ \ | (_) | | | \__ \
	\/    \___|_|  |_| |_| |_|_|___/___/_|\___/|_| |_|___/

	Uh-oh, this is gonna generate a lot of tickets I think!
	Oh yeah, let me just remind you: don't make tickets for
	config support. It says the same thing way up top.

	Anyway, Permissions is how people will be authenticated to
	edit whitelists & open the menu and shit.

	It is a table (or, again, a list) but it's a little different this
	time. This time, it has a "key"! I won't go into further detail
	but you'll see what I mean in the examples.

	The key can be a SteamID, SteamID64, a usergroup or a TEAM_ variable.
	The "value" (what the key "translates" into) will be another table
	containing TEAM_ variables.

	If you want someone to have permission to change the whitelists for any job,
	but not be MaxPermitted, use an asterisk (*) like this:

	config.Permissions = {

		["STEAM_0:1:40314158"] = {

			"*",

		},

	}

	Here's some examples:

	To allow STEAM_0:1:40314158 to edit the whitelist of the team "Stupid Cuntfuck",
	we can do it like this:

	config.Permissions = {

		["STEAM_0:1:40314158"] = {

			TEAM_STUPIDCUNTFUCK,

		},

	}

	To allow both STEAM_0:1:40314158 and 76561198074425791 to edit the whitelist of the team
	"Stupid Cuntfuck" we can do it like this:

	config.Permissions = {

		["STEAM_0:1:40314158"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		["76561198074425791"] = {

			TEAM_STUPIDCUNTFUCK,

		},

	}

	To go even further and add a usergroup, we can do:

	config.Permissions = {

		["STEAM_0:1:40314158"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		["76561198074425791"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		["moderator"] = {

			TEAM_STUPIDCUNTFUCK,

		},

	}

	To go EVEN FURTHER and allow "Stupid Cuntfuck Commander" to edit "Stupid Cuntfuck" we can do:

	config.Permissions = {

		["STEAM_0:1:40314158"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		["76561198074425791"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		["moderator"] = {

			TEAM_STUPIDCUNTFUCK,

		},

		[TEAM_STUPIDCUNTFUCK_COMMANDER] = {

			TEAM_STUPIDCUNTFUCK,

		},

		[TEAM_STUPIDCUNTFUCK_COMMANDER] = {

			"*", -- this will give this job permission to edit the whitelist of any job on the server

		},

	}

	Common errors:

		"table index is nil": this means that your TEAM_ variable is spelt wrong or simply doesn't exist

	Get it now? Great! Now continue below:

]] config.Permissions = {

	

} --[[

	   ___ _           _     ___                                          _
	  / __\ |__   __ _| |_  / __\___  _ __ ___  _ __ ___   __ _ _ __   __| |
	 / /  | '_ \ / _` | __|/ /  / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` |
	/ /___| | | | (_| | |_/ /__| (_) | | | | | | | | | | | (_| | | | | (_| |
	\____/|_| |_|\__,_|\__\____/\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|

	This is pretty obvious but if you're retarded I'll give you the run down.
	This is what the players will type in chat to open the menu.

	Examples:

	config.ChatCommand = "!bwhitelist"

	config.ChatCommand = "!whitelist"

	config.ChatCommand = "/bwhitelist"

	config.ChatCommand = "/whitelist"

]] config.ChatCommand = "!bwhitelist" --[[

	   _   _ _                ___                      _        ___                                          _
	  /_\ | | | _____      __/ __\___  _ __  ___  ___ | | ___  / __\___  _ __ ___  _ __ ___   __ _ _ __   __| |
	 //_\\| | |/ _ \ \ /\ / / /  / _ \| '_ \/ __|/ _ \| |/ _ \/ /  / _ \| '_ ` _ \| '_ ` _ \ / _` | '_ \ / _` |
	/  _  \ | | (_) \ V  V / /__| (_) | | | \__ \ (_) | |  __/ /__| (_) | | | | | | | | | | | (_| | | | | (_| |
	\_/ \_/_|_|\___/ \_/\_/\____/\___/|_| |_|___/\___/|_|\___\____/\___/|_| |_| |_|_| |_| |_|\__,_|_| |_|\__,_|

	BWhitelist, by default, has a console command to open the menu. It is ALWAYS "bwhitelist".
	You can turn it on and off here.

]] config.AllowConsoleCommand = true --[[

	 __ _                                       _     _ _       _ _     _           _  __        _
	/ _\ |__   _____      __/\ /\ _ ____      _| |__ (_) |_ ___| (_)___| |_ ___  __| | \ \  ___ | |__  ___
	\ \| '_ \ / _ \ \ /\ / / / \ \ '_ \ \ /\ / / '_ \| | __/ _ \ | / __| __/ _ \/ _` |  \ \/ _ \| '_ \/ __|
	_\ \ | | | (_) \ V  V /\ \_/ / | | \ V  V /| | | | | ||  __/ | \__ \ ||  __/ (_| /\_/ / (_) | |_) \__ \
	\__/_| |_|\___/ \_/\_/  \___/|_| |_|\_/\_/ |_| |_|_|\__\___|_|_|___/\__\___|\__,_\___/ \___/|_.__/|___/

	If false, players won't see the jobs they're not whitelisted to in the F4 menu.
	If true, players will see the jobs they're not whitelisted to in the F4 menu.

]] config.ShowUnwhitelistedJobs = false --[[

	 ______                _   _             __  __                  _  __
	|  ____|              | | (_)           |  \/  |                | |/ /
	| |__ _   _ _ __   ___| |_ _  ___  _ __ | \  / | ___ _ __  _   _| ' / ___ _   _
	|  __| | | | '_ \ / __| __| |/ _ \| '_ \| |\/| |/ _ \ '_ \| | | |  < / _ \ | | |
	| |  | |_| | | | | (__| |_| | (_) | | | | |  | |  __/ | | | |_| | . \  __/ |_| |
	|_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|_|  |_|\___|_| |_|\__,_|_|\_\___|\__, |
																			  __/ |
																			 |___/
	If false, F1, F2, F3 and F4 will NOT open the menu.
	If 1, F1 will open the menu.
	If 2, F2 will open the menu.
	If 3, F3 will open the menu.
	If 4, F4 will open the menu.

	If your players are saying that their F1/F2/F3/F4 key is not opening the menu
	and you have this on, tell them to rebind their F1, F2, F3 and F4 keys:

	bind f1 gm_showhelp
	bind f2 gm_showteam
	bind f3 gm_showspare1
	bind f4 gm_showspare2

	Examples:

	config.FunctionMenuKey = false

	config.FunctionMenuKey = 1

	config.FunctionMenuKey = 2

	config.FunctionMenuKey = 3

	config.FunctionMenuKey = 4

]] config.FunctionMenuKey = false --[[

	                _        _____         _ _       _     
	     /\        | |      / ____|       (_) |     | |    
	    /  \  _   _| |_ ___| (_____      ___| |_ ___| |__  
	   / /\ \| | | | __/ _ \\___ \ \ /\ / / | __/ __| '_ \ 
	  / ____ \ |_| | || (_) |___) \ V  V /| | || (__| | | |
	 /_/    \_\__,_|\__\___/_____/ \_/\_/ |_|\__\___|_| |_|
	                                                                                                     
	If true, when a player is whitelisted to a job, they will be automatically switched to it.
	If false, they will not.

]] config.AutoSwitch = false