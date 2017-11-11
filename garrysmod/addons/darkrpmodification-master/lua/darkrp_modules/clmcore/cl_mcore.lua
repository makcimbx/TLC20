
-----------------------------------------------------
net.Receive( "ClearLagsDed", function( len)

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
end)



local gmod_mcore_test = GetConVarString("gmod_mcore_test")
local mat_queue_mode = GetConVarString("mat_queue_mode")
local cl_threaded_bone_setup = GetConVarString("cl_threaded_bone_setup")
local cl_interp = GetConVarString("cl_interp")
local cl_interp_ratio = GetConVarString("cl_interp_ratio")
local cl_updaterate = GetConVarString("cl_updaterate")
local cl_cmdrate =  GetConVarString("cl_cmdrate")

RunConsoleCommand( "cl_interp", "0.116700" )
RunConsoleCommand( "cl_interp_ratio", "2" )
RunConsoleCommand( "cl_updaterate", "16" )
RunConsoleCommand( "cl_cmdrate", "16" )
RunConsoleCommand("gmod_mcore_test", "1")
RunConsoleCommand("mat_queue_mode", "-1")
RunConsoleCommand("cl_threaded_bone_setup", "1")

hook.Add("ShutDown", "mcore", function()
RunConsoleCommand("gmod_mcore_test", gmod_mcore_test)
RunConsoleCommand("mat_queue_mode", mat_queue_mode)
RunConsoleCommand("cl_threaded_bone_setup", cl_threaded_bone_setup)
RunConsoleCommand( "cl_interp", cl_interp)
RunConsoleCommand( "cl_interp_ratio", cl_update_ratio )
RunConsoleCommand( "cl_updaterate", cl_updaterate )
RunConsoleCommand( "cl_cmdrate", cl_cmdrate )













end)













