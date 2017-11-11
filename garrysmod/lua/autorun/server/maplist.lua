--This is a list of your server's maps which are available through the workshop
--Each one uses the map file's name and the workshop ID
maplist = {}

maplist["rp_venator_tlc"] = "739330687"
maplist["rp_scifi"] = "670961247"
maplist["fs_hoth"] = "660464983"
maplist["gm_jakku_v5"] = "730302729"
maplist["rp_kamino_extensive"] = "774517123"
maplist["mustafar"] = "577727672"
maplist["rp_mos_mesric_v2"] = "614696420"
maplist["rp_naboo_city_v1"] = "225115060"
maplist["rp_nar_shaddaa_v2"] = "485317056"
maplist["rp_tatooine_dunesea_v1"] = "216974337"
maplist["hfg_swrp_geonosis"] = "598786140"
maplist["gm_emp_cyclopean"] = "613051969"
maplist["gm_emp_palmbay"] = "613064894"
maplist["gm_emp_arid"] = "613039682"
maplist["gm_emp_bush"] = "613041835"
maplist["gm_emp_canyon"] = "613043504"
maplist["gm_emp_chain"] = "613046581"
maplist["gm_emp_coast"] = "613048219"
maplist["gm_emp_crossroads"] = "613050025"
maplist["gm_emp_duststorm"] = "613053117"
maplist["gm_emp_escort"] = "613054910"
maplist["gm_emp_isle"] = "613059763"
maplist["gm_emp_midbridge"] = "613062694"
maplist["gm_emp_mvalley2"] = "613063827"
maplist["gm_emp_slaughtered"] = "613067448"
maplist["gm_emp_streetsoffire"] = "613069064"
maplist["gm_emp_urbanchaos"] = "613071062"
maplist["gm_diprip_dam"] = "613028047"


--add more maps here


local map = game.GetMap() -- Get's the current map name
local workshopid = maplist[map] 
-- Finds the workshop ID for the current map name from the table above

if( workshopid != nil )then
	--If the map is in the table above, add it through workshop
	print( "[WORKSHOP] Setting up maps. " ..map.. " workshop ID: " ..workshopid )
	resource.AddWorkshop( workshopid )
else
	--If not, ) then hope the server has FastDL or the client has the map
	print( "[WORKSHOP] Not available for current map. Using FastDL instead hopefully..." )
end