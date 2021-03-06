local job_types = {
	["Citizens"] = "medic",
}

local p = FindMetaTable( "Player" )

function p:IsTeamType(x)
	local job = self:getJobTable()
	if(job_types[job.category]==x)then
		return true
	end
	return false
end

serverguard.permission:Add("sooc")
serverguard.permission:Add("oocdelay")

function p:CanCMD(x)
	return serverguard.ranks:HasPermission(serverguard.player:GetRank(self), x)
end
