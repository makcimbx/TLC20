--[[
	Battlefront UI
	Created by http://steamcommunity.com/id/Devul/
	Do not redistribute this software without permission from authors

	Developer information: 76561198045250557 : 4601 : 16520

	> If you bind the menu_key to F1, make sure you've disabled the default DarkRP f1 help menu:
		1. open `darkrpmodification/lua/darkrp_config/disabled_defaults.lua`
		2. find the `DarkRP.disabledDefaults["modules"]` table
		3. disable the f1menu module by setting the config to `true`
]]

-- Category registration, for the OPTIONS menu. You can change the icons if you wish, or the names for your own language. Do not edit the id.
bfUI.registerCategory( 
	{
		id = "general configuration",
		name = "ГЛАВНЫЕ",
		image = Material( "bfui/cogwheel.png", "mips smooth" )
	}
)

bfUI.registerCategory( 
	{ 
		id = "appearance", 
		name = "ПЕРСОНАЛИЗАЦИЯ",
		image = Material( "bfui/avatar.png", "mips smooth" )
	}
)

 -- Disables material background image and uses main_color client configuration
bfUI.registerUneditableConfig( 
	{
		id = "background_material_disabled",
		value = false
	}
)

-- Material background path, make sure you FastDL/Workshop it. The default one doesn't require it as I provided content already. :)
bfUI.registerUneditableConfig( 
	{
		id = "background_material", 
		value = Material( "bfui/bfui_background.jpg" )
	} 
)

-- Forces element button titles to be in UPPERCASE or not
bfUI.registerUneditableConfig( 
	{
		id = "element_title_force_uppercase",
		value = true
	}
)

-- Enforces the ability to set clientside customization
bfUI.registerUneditableConfig( 
	{
		id = "can_edit_clientside_settings",
		value = true
	}
)

-- Clientside configurations. These are the things that the Client can modify in the OPTIONS menu.

-- Whether the avatar image is displayed at the top left.
bfUI.registerClientConfig(
	{
		id = "show_avatar", 
		value = true, 
		description = "Whether avatar should be displayed",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Отображать аватар" 
		} 
	}
)

-- The theme's primary colour, that will dictate the button colours also.
bfUI.registerClientConfig(
	{
		id = "main_color", 
		value = Color( 230, 230, 230 ), 
		description = "The theme's primary colour",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Основной цвет темы" 
		} 
	}
)

-- The theme's secondary color, for example when you hover over a button.
bfUI.registerClientConfig(
	{
		id = "secondary_color", 
		value = Color( 255, 200, 0 ), 
		description = "The theme's secondary colour",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Второй цвет темы" 
		} 
	}
)

-- The theme's background gradient colour. It's displayed when the image is out of your view, or you have the background disabled.
bfUI.registerClientConfig(
	{
		id = "gradient_color", 
		value = Color( 25, 25, 25 ), 
		description = "The theme's gradient colour",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Цвет темы" 
		} 
	}
)

-- The fade time with animations.
bfUI.registerClientConfig(
	{
		id = "fade_time", 
		value = 0.5, 
		description = "Fade time for animations within the menu",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Время анимаций (основные)" 
		} 
	}
)

-- The fade time with animations, but only when you press a section/element.
bfUI.registerClientConfig(
	{
		id = "element_pressed_fade_time", 
		value = 0.5, 
		description = "Fade time for when you press an element button",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Время анимаций (выбор кнопок)" 
		} 
	}
)

-- The primary font used within the module.
bfUI.registerClientConfig(
	{
		id = "font", 
		value = "Futura ICG", 
		description = "The primary font",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Основной шрифт" 
		},

		-- Do not edit this
		callback = function()
			hook.Call( "loadFonts" )
		end
	}
)

-- The secondary font used within the module.
bfUI.registerClientConfig(
	{
		id = "font_secondary", 
		value = "Roboto Condensed", 
		description = "The secondary font",

		-- Extra information
		data = { 
			category = "appearance", 
			niceName = "Вторичный шрифт" 
		},

		-- Do not edit this
		callback = function()
			hook.Call( "loadFonts" )
		end
	}
)

--[[ 
	As the description states, Whether to ask to close the frame when you press the close button. Using true will mean yes, and false will make it so it disappears
	without a prompt. Please note that when you use the hotkey, there will never be a prompt.
]]
bfUI.registerClientConfig(
	{
		id = "ask_on_close", 
		value = true, 
		description = "Whether to ask to close the frame when you press the close button",

		-- Extra information
		data = { 
			category = "general configuration", 
			niceName = "Супер Графон" 
		} 
	}
)

bfUI.registerElement( "ГЛАВНАЯ", {
	greeting = "ДОБРО ПОЖАЛОВАТЬ НА TLC CLONE WARS",
	blocks = {
		[ 1 ] = {
			text = "СЕРВЕР ПРОВЕРЕННЫЙ ВРЕМЕНЕМ                                                                         НАМ СКОРО 2 ГОДА",
			sub = "ОСОБЕННОСТИ",
			image = Material( "bfui/block_2.png" )
		},
		[ 2 ] = {
			text = "СОЗДАНО КОМАНДОЙ TLC",
			sub = "КАЧЕСТВО, ОПТИМИЗИРОВАННОСТЬ СКРИПТОВ",
			image = Material( "bfui/block_3.png" )
		},
		[ 3 ] = {
			text = "vk.com/clonewarsrpporus",
			sub = "ВКОНТАКТЕ",
			image = Material( "bfui/block_4.png" )
		}
	},

	-- Currency is global, you only have to define it once.
	currency = {
		{
			image = Material( "bfui/money.png" ),
			-- image = Material( "bfui/creditcard.png" ),
			darkrp = true,
			--pointshop = true,
		},
		--[[
		{
			image = Material( "bfui/creditcard.png" ),
			pointshop = true,
		},
		]]
	}
})

bfUI.registerElement( "ФОРУМ", {
	showURL = "https://thelastcity.ru/index.php"
})

bfUI.registerElement( "АДМИНЫ", {
	--customCheck = function( client, panel ) return client:IsAdmin() or client:IsSuperAdmin() end,

	headerMessage = "Этот лист показывает администрацию в онлайне, обращайтесь к ним если у вас есть проблемы.",
	staff = {
		[ "admin" ] = {
			name = "Администратор",
			color = Color( 255, 255, 255 ),
		},
		[ "superadmin" ] = {
			name = "Супер Администратор",
			color = Color( 51, 125, 255 ),
		},
		[ "headadmin" ] = {
			name = "Главный Администратор",
			color = Color( 255, 0, 0 ),
		},
		--[[
		[ "vip" ] = {
			name = "VIP",
			color = Color( 255, 200, 0 ),
		},
		]]
	}
})

--[[
	Servers element:
	You can register new servers by adding a new entry to the servers table, the design is like so:

	[ "Server Name" ] = {
		icon = Material( "my/path/to/icon.png" ),
		ip = "x.x.x.x", -- Server IP is important, it's used to connect to the server.
		desc = "Description of the server.",
		joinText = "JOIN THE SERVER", -- Replacement text for the join button.
	}
]]
bfUI.registerElement( "СЕРВЕРА", {
	servers = {
		[ "STARWARSRP" ] = {
			icon = Material( "bfui/server_icon.png" ),
			ip = "89.34.97.159",
			desc = "Наш сервер периода войн клонов.",

			joinText = "ПРИСОЕДИНИТЬСЯ"
		}
	}
})

bfUI.registerElement( "ПРАВИЛА", {
	-- This dictates whether a website should load here.
	showURL = "https://vk.com/topic-43701099_34451510"
})


	-- This shows a donation page URL which you can uncomment and set your own URL for.

bfUI.registerElement( "ДОНАТ", {
	showURL = "https://vk.com/topic-43701099_34461503"
})


bfUI.registerElement( "НАСТРОЙКИ", {
	-- This dictates whether the options menu should show here.
	options = true
} )
