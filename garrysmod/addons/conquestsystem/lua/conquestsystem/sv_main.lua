AddCSLuaFile("sh_config.lua")
AddCSLuaFile("sh_interface.lua")
AddCSLuaFile("cl_main.lua")
AddCSLuaFile("ui/base.lua")
AddCSLuaFile("ui/cq_button.lua")
AddCSLuaFile("ui/cq_listview.lua")


--[[-------------------------------------------------------------------------
HOOKS
---------------------------------------------------------------------------]]
-- ConquestSystem_PointCaptured 	args=team name
-- ConquestSystem_CapturedPointTick args=team name
-- ConquestSystem_PointLost 		args=team name

--[[-------------------------------------------------------------------------

NETWORK
---------------------------------------------------------------------------]]
util.AddNetworkString("CS_NETPOINTS")
util.AddNetworkString("CS_NETCONFIG")
util.AddNetworkString("CS_NOTIF")

resource.AddFile("materials/conquestsystem/circle32.png")
resource.AddFile("materials/conquestsystem/circle64.png")
resource.AddFile("materials/conquestsystem/circle128.png")
resource.AddFile("materials/conquestsystem/square32.png")
resource.AddFile("materials/conquestsystem/square64.png")
resource.AddFile("materials/conquestsystem/square128.png")
resource.AddFile("materials/conquestsystem/triangle32.png")
resource.AddFile("materials/conquestsystem/triangle64.png")
resource.AddFile("materials/conquestsystem/triangle128.png")

ConquestSystem.Points = {}

--[[-------------------------------------------------------------------------
UTIL
---------------------------------------------------------------------------]]
function ConquestSystem.GetContestedPoint(ply)
	local plyPos = ply:GetPos()

	for k,v in pairs(ConquestSystem.Points) do
		local dist = math.Distance(plyPos.x, plyPos.y, v.Position.x, v.Position.y)

		if dist < v.Radius then
			return v
		end
	end

	return nil
end

function ConquestSystem.RefreshPointContests()
	for k,v in pairs(ConquestSystem.Points) do

		v.ContestedBy = {}

	end
end

function ConquestSystem.GetContestingTeam(point)
	for k,v in pairs(point.ContestedBy) do return k end
end

function ConquestSystem.Notify(ply, contents, type)
	net.Start("CS_NOTIF")
	net.WriteString(contents)
	net.WriteInt(type, 8)
	net.Send(ply)
end


--[[-------------------------------------------------------------------------
MAIN
---------------------------------------------------------------------------]]

-- creates a point, returns the id inside the points table
function ConquestSystem.CreatePoint(name, tag, position, radius, categoryEnabled, shape, disallowedTeams)
	table.insert(ConquestSystem.Points, {
		Name = name,
		Tag = tag,
		Position = position,
		Radius = radius,
		Owner = nil,
		ContestedBy = {}, 
		Capturing = nil,
		Shape = shape,
		CategoryEnabled = categoryEnabled,
		Color = ConquestSystem.Config.Colours.HUDIconUncaptured,
		DisallowedTeams = disallowedTeams
	})
end

function ConquestSystem.DeletePoint(tag)

	local removeIndex = 0

	for k,v in pairs(ConquestSystem.Points) do

		if v.Tag == tag then

			removeIndex = k

			break

		end

	end

	table.remove(ConquestSystem.Points, removeIndex)

	ConquestSystem.DeleteFromSQL(tag)

end

-- checks the positions of all players to trigger contesting/capturing
function ConquestSystem.CheckPositions()

	ConquestSystem.RefreshPointContests()

	-- contest any points.
	for k,v in pairs(player.GetAll()) do

		local capturePoint = ConquestSystem.GetContestedPoint(v)

		if capturePoint ~= nil then

			local plyTeam = ConquestSystem.GetTeamName(capturePoint, v)

			-- are we allowed to capture this point
			local allowed = true
			if ConquestSystem.Config.DarkRP and capturePoint.DisallowedTeams ~= nil then

				for k,v in pairs(capturePoint.DisallowedTeams) do

					if v == plyTeam then

						allowed = false

					end

				end

			else

			end

			if allowed then

				-- ensure our team in the list
				if capturePoint.ContestedBy[plyTeam] == nil then

					capturePoint.ContestedBy[plyTeam] = true

				end

			end

		end

	end

	-- check count of contesting teams at the point
	for k,v in pairs(ConquestSystem.Points) do

		if v.Owner ~= nil then

			hook.Run("ConquestSystem_CapturedPointTick", v.Owner)

		end

		-- if the point is being contested by multiple unique teams right now.
		local numContestingTeams = table.Count(v.ContestedBy)

		if numContestingTeams > 1  then -- point being fought over.

			-- reset capturing time and owner.
			v.Capturing = nil

		elseif numContestingTeams == 1 then -- point with one team in it.

			local teamContesting = ConquestSystem.GetContestingTeam(v)

			-- if the contesting team hasn't captured this point
			if teamContesting ~= v.Owner then

				if v.Capturing == nil then -- this point previously was fought over.

				    -- store what time we started capturing this.
					v.Capturing = CurTime()

				else -- this point is currently being captured.

					local captureDifference = CurTime() - v.Capturing
					
					if ConquestSystem.Config.CaptureTime <= captureDifference then

						if v.Owner ~= nil then

							hook.Run("ConquestSystem_PointLost", v.Owner)

						end

						-- point has been captured
						v.Owner = teamContesting

						v.Capturing = nil

						hook.Run("ConquestSystem_PointCaptured", v.Owner)

					end

				end

			end

		elseif numContestingTeams == 0 then -- point with no one in it.

			v.Capturing = nil

		end

	end

	ConquestSystem.NetworkVars()

end



--[[-------------------------------------------------------------------------
SQL
---------------------------------------------------------------------------]]--
function ConquestSystem.SaveToSQL()

	-- update / insert into table

	for k,v in pairs(ConquestSystem.Points) do

		local isEnabled = 0
		if v.CategoryEnabled then isEnabled = 1 end
			
	    -- does this point exist in the table
		local queryResult = sql.Query("SELECT name FROM conq_points_120 WHERE tag = " .. sql.SQLStr(v.Tag))

		if queryResult ~= nil then

			-- update the row
			local query = sql.Query("UPDATE conq_points_120 SET name=" .. sql.SQLStr(v.Name) .. ", x=" .. v.Position.x ..", y=" .. v.Position.y .. ", z=" .. v.Position.z .. ", radius=" .. v.Radius .. ", categoryenabled=" .. isEnabled .. ", shape=" .. sql.SQLStr(v.Shape) .. " WHERE tag=" .. sql.SQLStr(v.Tag) .. "")

		else

			-- insert new row
			local query = "INSERT INTO conq_points_120 (`tag`, `name`, `x`, `y`, `z`, `radius`, `categoryenabled`, `shape`) VALUES (" .. sql.SQLStr(v.Tag) .. ", " .. sql.SQLStr(v.Name) .. ", '" .. v.Position.x .. "', '" .. v.Position.y .. "', '" .. v.Position.z .. "', '" .. v.Radius .. "', '" .. isEnabled .. "', " .. sql.SQLStr(v.Shape) .. ")"
			local result = sql.Query(query)

		end

		local query = sql.Query("DELETE FROM conq_points_teams_120 WHERE tag = " .. sql.SQLStr(v.Tag))

		if v.DisallowedTeams ~= nil then

			for i,j in pairs(v.DisallowedTeams) do

				local query = sql.Query("INSERT INTO conq_points_teams_120 (`tag`, `job`) VALUES (" .. sql.SQLStr(v.Tag) .. ", " .. sql.SQLStr(j) .. ")")

			end

		end

	end

end


function ConquestSystem.LoadFromSQL()

	ConquestSystem.Points = {}

	-- load from sql table

	local queryResult = sql.Query("SELECT * FROM conq_points_120")
	if queryResult == nil then return end

	for k,v in pairs(queryResult) do
		local isEnabled = false
		if tonumber(v.categoryenabled) == 1 then isEnabled = true end

		local query = sql.Query("SELECT * FROM conq_points_teams_120 WHERE tag = " .. sql.SQLStr(v.tag) .."")
		local disallowedTeams = {}
		if query ~= nil then
			for i,j in pairs(query) do
				table.insert(disallowedTeams, j.job)
			end
		end

		ConquestSystem.CreatePoint(v.name, v.tag, Vector(v.x, v.y, v.z), tonumber(v.radius), isEnabled, v.shape, disallowedTeams)

	end
end

function ConquestSystem.DeleteFromSQL(tag)

	local query = sql.Query("DELETE FROM conq_points_120 WHERE tag=" .. sql.SQLStr(tag))
	local query = sql.Query("DELETE FROM conq_points_teams_120 WHERE tag=" .. sql.SQLStr(tag))

	local foundIndex = -1
	for k,v in pairs(ConquestSystem.Points) do

		if v.Tag == tag then

			foundIndex = k 

		end

	end

	if foundIndex ~= -1 then
		table.remove(ConquestSystem.Points, foundIndex)
	end

end

function ConquestSystem.ValidateConcommand(tag, name, radius, shape)
	-- check if any point exists with this tag.
	local doesExist = false
	for k,v in pairs(ConquestSystem.Points) do

		if string.lower(v.Tag) == string.lower(tag) then

			doesExist = true

		end
	end

	-- check validity of input
	local isValid = true
	if tag == nil or name == nil or radius == nil then 

		isValid = false

	elseif string.len(tag) > 1 or tonumber(radius) == nil then

		isValid = false

	end

	if string.find(shape, "circle") ~= nil or string.find(shape, "square") ~= nil or string.find(shape, "triangle") ~= nil then

	else

		isValid = true

	end

	if not doesExist and isValid then


		return { "Success", 2 }

	else

		if doesExist then return { "Point `" .. tag .."` already exists.", 1} end
		if tag == nil or name == nil or radius == nil then return {"All inputs are required.", 1}  end
		if string.len(tag) > 1 then return {"Tag can only have 1 character.", 1} end
		if tonumber(radius) == nil then return {"Radius must be a number.", 1} end
		if string.find(shape, "circle") ~= nil or string.find(shape, "square") ~= nil or string.find(shape, "triangle") ~= nil then return {"Shape must be valid.", 1} end
	end

	return { "Error", 1 }
end

--[[-------------------------------------------------------------------------
Concommands

concommand.Add("CheckPositions", function() ConquestSystem.CheckPositions() end)

concommand.Add("savetosql", function() ConquestSystem.SaveToSQL() end)

concommand.Add("loadfromsql", function() ConquestSystem.LoadFromSQL() end)
---------------------------------------------------------------------------]]

concommand.Add("ConquestSystem_Sv_CreatePoint", function(ply, cmd, args)
	if not ply:IsAdmin() then return false end

	local tag = args[1]
	local name = args[2]
	local radius = args[3]
	local categoryEnabled = args[4]
	local shape = args[5]

	args[6] = string.Replace(args[6], "'", "\"")
	local disallowedTeams = util.JSONToTable(args[6])

	local isEnabled = false
	if tonumber(categoryEnabled) == 1 then isEnabled = true or disallowedTeams ~= nil end
	
	local validation = ConquestSystem.ValidateConcommand(tag, name, radius, shape)
	if validation[1] == "Success" then

		ConquestSystem.CreatePoint(name, tag, ply:GetPos(), tonumber(radius) * 100, isEnabled, shape, disallowedTeams)
		ConquestSystem.SaveToSQL()

		ConquestSystem.NetworkVars()
	else

		ConquestSystem.Notify(ply, validation[1], validation[2])

	end
end)

concommand.Add("ConquestSystem_Sv_EditPoint", function(ply, cmd, args)
	if not ply:IsAdmin() then return false end

	local tag = args[1]
	local name = args[2]
	local radius = args[3]
	local categoryEnabled = args[4]
	local shape = args[5]

	args[6] = string.Replace(args[6], "'", "\"")
	local disallowedTeams = util.JSONToTable(args[6])


	local isEnabled = false
	if tonumber(categoryEnabled) == 1 then isEnabled = true end


	local validation = ConquestSystem.ValidateConcommand(tag, name, radius, shape)
	if validation[1] == "Success" or string.find(validation[1], "already exists") ~= nil or disallowedTeams ~= nil then

		local foundPoint
		for k,v in pairs(ConquestSystem.Points) do
			if v.Tag == tag then

				foundPoint = v
				break

			end

		end

		ConquestSystem.DeletePoint(tag)
		ConquestSystem.CreatePoint(name, tag, foundPoint.Position, tonumber(radius) * 100, isEnabled, shape, disallowedTeams)
		ConquestSystem.SaveToSQL()

		ConquestSystem.NetworkVars()

	else

		ConquestSystem.Notify(ply, validation[1], validation[2])

	end
end)

concommand.Add("ConquestSystem_Sv_DeletePoint", function(ply, cmd, args)
	if not ply:IsAdmin() then return false end

	local tag = args[1]

	ConquestSystem.DeletePoint(tag)
	ConquestSystem.SaveToSQL()


end)


--[[-------------------------------------------------------------------------
 Entry Point
 ---------------------------------------------------------------------------]]
 function WaitCallback(checkCallback, validCallback)
	if checkCallback() then
		validCallback()
	else
		timer.Simple(1, function() 
			WaitCallback(checkCallback, validCallback)
		end)
	end
end


 timer.Simple(2, function() 
	if not sql.TableExists("conq_points_120") then

		-- create table
		local queryResult = sql.Query("CREATE TABLE conq_points_120 ( tag varchar(255), name varchar(255), x real, y real, z real, radius real, categoryenabled int, shape varchar(255) )")

	end

	if not sql.TableExists("conq_points_teams_120") then

		local query = sql.Query("CREATE TABLE conq_points_teams_120 ( tag varchar(255), job varchar(255) ) ")

	end
end)


timer.Simple(4, function()

	WaitCallback(function()
		return (sql.TableExists("conq_points_120") and sql.TableExists("conq_points_teams_120"))
	end,
	function()
		ConquestSystem.LoadFromSQL()
	end)

	if timer.Exists("CS_UPLOOP") then

		timer.Remove("CS_UPLOOP")

	end

	timer.Create("CS_UPLOOP", 1, 0, function()

		ConquestSystem.CheckPositions()

	end)
end)

function ConquestSystem.NetworkVars()
	net.Start("CS_NETPOINTS")

	net.WriteUInt(table.Count(ConquestSystem.Points), 32)

	for i=1, table.Count(ConquestSystem.Points) do

		net.WriteUInt(tonumber(i), 32)
		net.WriteTable(ConquestSystem.Points[i])

	end

	net.Broadcast()
end