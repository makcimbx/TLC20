AddCSLuaFile()
local playerMeta = FindMetaTable("Player")
function playerMeta:SetupDataTables()
	self:NetworkVar( "Bool", 0, "Cangugdc" )
	if (SERVER) then
		self:SetCangugdc( false )
	 end
end

hook.Add( "Think", "Antiinfinitistun", function() 
for k, v in pairs( player.GetAll() ) do
	if v:GetNWBool("Cangugdc") == true and timer.RepsLeft("syphonfreeze" .. v:SteamID()) == nil then
		if (SERVER) then SendUserMessage("blackScreen", v, false) v:UnLock() end
			v:SetNWBool("Cangugdc", false)
		end
	end
end)
