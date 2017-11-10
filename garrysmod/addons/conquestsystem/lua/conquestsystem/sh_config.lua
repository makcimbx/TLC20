ConquestSystem.Config = {

	DarkRP = true,								-- enable darkrp teams?

	CaptureTime = 5,							-- the amount of time required to capture a point in seconds.

	TeamShapes = {}, 							-- DO NOT MODIFY (see below table)

	Visibility = {

		SeeThroughWalls = true,				-- show the icon even when the player is behind a wall/world.

		Fade = {

			Enabled = true,				-- set the icon to fade in or not.

			FadeInStartDistance = 1000, 			-- how far (in m) the player should be before the icon STARTS to fade in.
			FadeInEndDistance = 500			-- how far (in m) the player is for the icon to be TOTALLY visible.
		}

	},

	Fonts = {

		Tag = "DermaLarge",						-- the font to draw the TAG on the hud.

		Name = "DermaDefaultBold",				-- the font for the NAME underneath the circle on the hud.

		Distance = "DermaDefaultBold"			-- the font for the DISTANCE underneath the NAME on the hud.
		
	},

	Colours = {

		TagFill = Color(255,255,255, 255),		-- colour of the TAG text.

		NameFill = Color(255,255,255, 255),		-- colour of the NAME text.

		DistanceFill = Color(255,255,255, 255),			-- colour of the DISTANCE text.

		HUDIconBackgroundCircle = Color(24,24,24, 255), 	-- colour of the circle behind the main coloured circle.

		HUDIconUncaptured = Color(255,255,255, 255), 		-- colour of the main coloured circle when no one owns it.

	},

	Sizes = {

		IconForegroundShapeRadius = 45,				-- radius of the foreground shape.


	},

	Positioning = {

		WhenCapturing = function(screenWidth, screenHeight)

			return Vector(screenWidth/2, ConquestSystem.Config.Sizes.IconForegroundShapeRadius/2 + 10)   					-- the position of the icon while capturing, initially top middle.

		end,

		TextPaddingTop = 5,
		TextSpacing = 6

	}
}

--[[-------------------------------------------------------------------------
BETA!
Assign the number of sides the polygon shape should have for a particular team.
TeamShapes[JOB/CATEGORY]  = number of sides.
eg. TeamShapes["Citizen"] = 3 would make the citizen team's hud icon a triangle.
---------------------------------------------------------------------------]]
ConquestSystem.Config.TeamShapes["Citizen"] = 5