local function CanUseSpawnFunc(a,ply)
	return serverguard.player:HasPermission(ply, a) or serverguard.ranks:HasPermission(serverguard.player:GetRank(ply), a)
end

serverguard.permission:Add("SpawnWeapon");
serverguard.permission:Add("SpawnVehicle");
serverguard.permission:Add("SpawnEntities");
serverguard.permission:Add("SpawnNPC");

function GM:PlayerSpawnSENT(ply, class)
    return CanUseSpawnFunc("SpawnEntities",ply) and self.Sandbox.PlayerSpawnSENT(self, ply, class)
end

function GM:PlayerSpawnSWEP(ply, class, info)
    return CanUseSpawnFunc("SpawnWeapon",ply) and self.Sandbox.PlayerSpawnSWEP(self, ply, class, info)
end

function GM:PlayerGiveSWEP(ply, class, info)
    return CanUseSpawnFunc("SpawnWeapon",ply) and self.Sandbox.PlayerGiveSWEP(self, ply, class, info)
end

function GM:PlayerSpawnVehicle(ply, model, class, info)
    return CanUseSpawnFunc("SpawnVehicle",ply) and self.Sandbox.PlayerSpawnVehicle(self, ply, model, class, info)
end

function GM:PlayerSpawnNPC(ply, type, weapon)
    return CanUseSpawnFunc("SpawnNPC",ply) and self.Sandbox.PlayerSpawnNPC(self, ply, type, weapon)
end