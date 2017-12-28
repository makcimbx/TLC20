local plugin = plugin

plugin:IncludeFile("shared.lua", SERVERGUARD.STATE.CLIENT)
plugin:IncludeFile("sh_commands.lua", SERVERGUARD.STATE.CLIENT)

net.Receive("ever_scale",function()
	local ply = net.ReadEntity()
	local scale = tonumber(net.ReadString())
	
	if not IsValid(ply) then return end
    ply:SetModelScale(scale, 1)
    ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 72 * scale))
    ply:SetHullDuck(Vector(-16, -16, 0), Vector(16, 16, 36 * scale))
end)