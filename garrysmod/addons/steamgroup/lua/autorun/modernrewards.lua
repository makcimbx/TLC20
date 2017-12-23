if SERVER then
	AddCSLuaFile()
	AddCSLuaFile('cl_modernrewards.lua')
	AddCSLuaFile('sh_rewardsconfig.lua')
	AddCSLuaFile('cl_rewardfonts.lua')
	
	--Add panel files
	AddCSLuaFile('sgrpanels/cl_menubutton.lua')
	
	--Add server files
	include('sv_modernrewards.lua')
	
	--Add resources
	local function AddResourceDir(dir)

	end



end

if CLIENT then
	include('cl_modernrewards.lua')
end