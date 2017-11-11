	if (CLIENT) then
	
		timer.Create("ClearDecals", 60, 0, function() -- 180 seconds
		RunConsoleCommand("r_cleardecals", "") -- Command that clear decals
		notification.AddLegacy( "Успешно почистил все следы на карте!", NOTIFY_GENERIC, 5 ) -- Message about success clear decals
		-- RunConsoleCommand("cl_removedecals", "") -- Old command that working when sv_cheats 1
		end)
    end
