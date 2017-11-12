BWhitelist.Config.MySQL = {} local MySQL = BWhitelist.Config.MySQL

--[[

	This should be pretty self explanatory.

	I'll add some warnings.

	WARNING: Don't use fucking localhost! It doesn't work with Garry's Mod!

	WARNING: Again, like the normal config, don't make tickets about the
			 MySQL config unless there REALLY is an issue.

	If your user account doesn't have a password (not recommended) leave the Password
	field blank.

]]

MySQL.Enabled  = false
MySQL.Host     = ""
MySQL.Username = ""
MySQL.Password = ""
MySQL.Database = ""
MySQL.Port     = 3306
