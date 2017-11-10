	if (CLIENT) then
	
		timer.Create("ClearDecals", 60, 0, function() -- 180 seconds
		RunConsoleCommand("r_cleardecals", "") -- Command that clear decals
		notification.AddLegacy( "Успешно почистил все следы на карте!", NOTIFY_GENERIC, 5 ) -- Message about success clear decals
		-- RunConsoleCommand("cl_removedecals", "") -- Old command that working when sv_cheats 1
		end)
		
		RunConsoleCommand( "r_shadows", 1 )
RunConsoleCommand( "r_shadowrendertotexture", 0 )
RunConsoleCommand( "r_shadowmaxrendered", 0 )
RunConsoleCommand( "mat_shadowstate", 0 )

RunConsoleCommand( "cl_interp", 0.116700 )
RunConsoleCommand( "cl_interp_ratio", 2 )
RunConsoleCommand( "cl_updaterate", 16 )
RunConsoleCommand( "cl_cmdrate", 16 )
--// Disable Gibs
RunConsoleCommand( "cl_phys_props_enable" , 0 )
RunConsoleCommand( "cl_phys_props_max" , 0 )
RunConsoleCommand( "props_break_max_pieces" , 0 )
RunConsoleCommand( "r_propsmaxdist" , 1 )
RunConsoleCommand( "violence_agibs" , 0 )
RunConsoleCommand( "violence_hgibs" , 0 )


			RunConsoleCommand("cl_threaded_bone_setup", 1)
			RunConsoleCommand("cl_threaded_client_leaf_system", 1)
			RunConsoleCommand("r_threaded_client_shadow_manager", 1)
			RunConsoleCommand("r_threaded_particles", 1)
			RunConsoleCommand("r_threaded_renderables", 1)
			RunConsoleCommand("r_queued_ropes", 1)
			RunConsoleCommand("studio_queue_mode", 1)
			RunConsoleCommand("gmod_mcore_test", 1)
			RunConsoleCommand("cl_threaded_bone_setup", 1)
			RunConsoleCommand("cl_threaded_client_leaf_system" , 1)
			RunConsoleCommand("r_threaded_client_shadow_manager", 1)
			RunConsoleCommand("r_threaded_particles", 1)
			RunConsoleCommand("r_threaded_renderables", 1)
			RunConsoleCommand("r_queued_ropes", 1)
			RunConsoleCommand("studio_queue_mode", 1)
			RunConsoleCommand("gmod_mcore_test", 1)
			RunConsoleCommand("mat_queue_mode", -1)
			RunConsoleCommand("cl_threaded_bone_setup", 1)
		
	end
