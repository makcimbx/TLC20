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

local cmds = {
	["superadmin"] = {
		["sooc"] = true,
		["oocdelay"] = true,
	},
}

function p:CanCMD(x)
	local a = cmds[self:GetUserGroup()][x]
	if(a == nil)then
		a = false
	end
	return a
end
