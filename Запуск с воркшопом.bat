@echo off 
cls  
title srcds.com Watchdog 
:srcds 
echo (%time%) srcds started. 
start /wait srcds.exe -game garrysmod -console +gamemode starwarsrp +map gm_flatgrass -authkey 47B65BAE537D8A03D5617AF2AF4F27A6 +maxplayers 1337 +port 27015 +r_hunkalloclightmaps 0  -debug -tickrate 13 +host_workshop_collection 1200118016
goto srcds
quit
