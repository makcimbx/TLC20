function ConquestSystem.GetPointColour(point)
	if point.CategoryEnabled then
		for k,v in pairs(DarkRP.getCategories().jobs) do

			if v.name == point.Owner then

				return v.color

			end

		end

		return Color(255,0,0,255)
	else

		return ConquestSystem.FindTeamByCommand(point.Owner).color

	end
end

function ConquestSystem.GetUserColour(ply)
	-- default system, returns darkrp team if flag set, normal team if not.
	if ConquestSystem.Config.DarkRP then

		local job = RPExtraTeams[ply:Team()]
		return job.color

	else

		return team.GetColor(ply:Team())

	end
end

function ConquestSystem.GetTeamName(point, ply)

	if ConquestSystem.Config.DarkRP then

		local job = RPExtraTeams[ply:Team()]

		if point.CategoryEnabled then

			return job.category

		else

			return job.command

		end

	else

		return team.GetName(ply:Team())

	end

end

function ConquestSystem.GetTeamShape(point, ply)

	if ConquestSystem.Config.TeamShapes[ConquestSystem.GetTeamName(point, ply)] ~= nil then

		return ConquestSystem.Config.TeamShapes[ConquestSystem.GetTeamName(point, ply)]

	end

	return 32
end

function ConquestSystem.FindTeamByCommand(command)
	for k,v in pairs(RPExtraTeams) do
		if v.command == command then
			return v
		end
	end
end