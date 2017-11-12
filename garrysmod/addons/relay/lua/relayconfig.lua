RelayConfig = {
    -- BotToken: To get your bot token, go to https://discordapp.com/developers/applications/me
    -- Create new app, set its name to anything, it doesn't matter
    -- Upgrade the app to bot user and reveal the bot token, copy the token COMPLETELY,
    -- not with double click as it will only copy half of it.
    BotToken = "Mzc5MjIwNDkzMTM3NDc3NjQz.DOm4ZQ.pKU0V3TBDjS7sJp7ZSxgitdgW1M",

    -- To invite the bot to your server, get the client id from the app bot page and replace the
    -- INSERT_CLIENT_ID_HERE below with it.
    -- https://discordapp.com/oauth2/authorize?client_id=INSERT_CLIENT_ID_HERE&scope=bot&permissions=536873984
    -- Then open the link and add your bot with the already given permissions.
    -- NOTICE: The bot needs all of those permissions to work.

    -- RelayChannel: Type the discord text channel name where the messages should be relayed.
    -- Channel name should be without the #
    RelayChannel = "main_chat",

    -- RelayAdminChannel: Type the discord text channel name where all logs and administration should go.
    -- Channel name should be without the #
    -- Empty for disabled
    RelayAdminChannel = "admin_logs",

    -- BotName: The name for the bot in discord.
    BotName = "TLC StarWars Integration",

    -- BotAvatar: URL that should be bot's avatar (png/jpeg only)
    -- Recommended size: 128x128
    -- Blank for none
    BotAvatar = "",

    -- BotStatus: What to display for the playing game on the user list.
    -- Max limit: 32 chars
    -- Blank for none
    BotStatus = "Hello from gmod!",

    -- BotPrefix: Prefix for commands in discord
    BotPrefix = "!",

    -- DefaultAvatar: URL to default profile avatar of user relayed if getting the real one from steam fails.
    DefaultAvatar = "",

    -- ConvertMentions: Convert gmod -> discord to mentions (@username, #channel) to actual mention?
    ConvertMentions = true,

    -- BotAdmins: Any users with this role can use commands from relay.
    -- ["RoleName"] = Commands allowed,
    BotAdmins = {
        ["superadmin"] = {
            "say",
            "kick",
            "rcon",
            "lua_sv",
            "blacklist",
            "unblacklist",
            "screenshot",
        },
    },

    -- CountAsStaff: Any usergroups that should be counted to !status's staff amount.
    -- ["Usergroup"] = true,
    CountAsStaff = {
        ["superadmin"] = true,
    },

    -- Currently all commands available:
    -- say
    -- kick
    -- rcon
    -- lua_sv
    -- blacklist
    -- unblacklist
    -- screenshot

    -- OnlineAnnounce: Announce when server is online?
    OnlineAnnounce = true,

    -- OnlineMessageFormat: String to format which is displayed when server is online
    -- {{type}} will be replaced with the actual value, available types:
    -- {{ip}} = Server's ip
    -- {{joinurl}} = steam://connect/ip url
    -- {{hostname}} = Server's hostname
    OnlineMessageFormat = "Server {{hostname}} is online!",

    -- JoinAnnounce: Announce player joining?
    JoinAnnounce = true,

    -- JoinMessageFormat: String to format which is displayed when somebody starts joining
    -- {{type}} will be replaced with the actual value, available types:
    -- {{name}} = Player's name
    -- {{sid}} = Player's steamid
    -- {{ip}} = Server's ip
    -- {{joinurl}} = steam://connect/ip url
    -- {{hostname}} = Server's hostname
    JoinMessageFormat = "Player {{name}} ({{sid}}) is connecting to the server!",

    -- LeaveAnnounce: Announce player leaving?
    LeaveAnnounce = true,

    -- LeaveMessageFormat: String to format which is displayed when somebody leaves
    -- {{type}} will be replaced with the actual value, available types:
    -- {{name}} = Player's name
    -- {{sid}} = Player's steamid
    -- {{ip}} = Server's ip
    -- {{joinurl}} = steam://connect/ip url
    -- {{hostname}} = Server's hostname
    -- {{reason}} = Disconnect reason
    LeaveMessageFormat = "Player {{name}} ({{sid}}) disconnected ({{reason}})",

    -- TooLongMessage: String to format when someone sends too long message in discord.
    -- {{type}} will be replaced with the actual value, available types:
    -- {{username}} = Discord user's username
    TooLongMessage = "Sorry {{username}}, but that message was too long and wasn't relayed.",

    -- AntiSpamDelay: Delay between resending player join/leave messages.
    -- Useful when someone spams reconnect to flood chat.
    AntiSpamDelay = 5,

    -- NamePrefix: Prefixed in discord name.
    -- Blank for none
    NamePrefix = "[StarWars]",

    -- TeamChatEnabled: Relay team chat?
    TeamChatEnabled = false,

    -- BlockedCommands: If message starts with this, do not relay it.
    -- Empty for none ( {} )
    BlockedCommands = {"!", "/", ".", "@"},

    -- WhitelistedCommands: If anything here, only messages starting with x will be relayed.
    WhitelistedCommands = {},

    -- UlxLogging: Log every ulx action to admin channel?
    -- Will enable ulx logfile.
    UlxLogging = true,

    -- UlxBlacklist: Keywords in log message to not to show.
    -- Used for preventing spam for prop spawns etc.
    UlxBlacklist = {
        
    },

    -- SGLogging: Log every serverguard action to admin channel?
    SGLogging = true,

    -- SGBlacklist: Keywords in log message to not to show.
    -- Used for preventing spam for prop spawns etc.
    SGBlacklist = {
        " used tool \"",
        " un-froze (reloaded) using the physgun",
        " spawned prop \"",
        " spawned ragdoll \"",
        " spawned vehicle \"",
        " spawned effect \"",
        " spawned npc \"",
        " spawned SENt \"",
        " spawned SWEP \"",
        ": " -- Try not to log chat messages
    },

    -- ScreenshottingEnabled: Enable player screenshotting from discord?
    ScreenshottingEnabled = false,
    -- Couple of things here, i am providing the webserver where everything is uploaded.
    -- If i see any abuse, i will blacklist you from using it. Open support ticket if you want to appeal.
    -- Screenshotting uses drm, if you don't want to have any drm's, feel free not to use this.
    -- Why am i using drm for this? I want to protect this code so it is harder to abuse my system.
    -- If you are fine with above, feel free to use this, but just please, don't abuse it.
    -- It may take 5 minutes before your key gets activated

    -- NOTE ABOUT HAVING MULTIPLE SERVERS ENABLED WITH ABOVE FEATURE.
    -- YOU WILL HAVE TO INSTALL ANOTHER COPY OF THIS SCRIPT FOR THE SERVER.
    -- YOU CAN'T USE SAME FILES DUE TO HOW THE DRM WORKS.

    -- CAC: Captures screenshots of cheaters and sends screenshot to discord.
    -- Screenshotting must be ENABLED and AdminChannel.
    CAC = false,
}
