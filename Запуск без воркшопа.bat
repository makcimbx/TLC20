@echo off 
cls  
title srcds.com Watchdog 
:srcds 
echo (%time%) srcds started. 
start /wait srcds.exe -game garrysmod -console +gamemode darkrp +map rp_ussr_military_tlc -authkey 47B65BAE537D8A03D5617AF2AF4F27A6 +maxplayers 1337 +port 27015 +r_hunkalloclightmaps 0  -debug -tickrate 66 //+host_workshop_collection 938873891
goto srcds
quit
