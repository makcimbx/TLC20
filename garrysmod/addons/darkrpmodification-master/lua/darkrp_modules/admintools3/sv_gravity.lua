util.AddNetworkString("GRT_Save")
util.AddNetworkString("sendboxes")
util.AddNetworkString("GRT_Delete")
util.AddNetworkString("ever_scale")

local triggers = {}

function GravityEnabled()
	if(game.GetMap()=="rp_chancellor_tlc_b1")then
		return true
	end
	return false
end


net.Receive("GRT_Delete",function(l,ply)
	local d = tonumber(net.ReadString())
	RemoveData( "#GRT" )
	for k,v in pairs(triggers) do
		RemoveData( k.."GRT_start_x" )
		RemoveData( k.."GRT_start_y" )
		RemoveData( k.."GRT_start_z" )
		RemoveData( k.."GRT_end_x" )
		RemoveData( k.."GRT_end_y" )
		RemoveData( k.."GRT_end_z" )
	end
	table.remove(triggers,d)
	SetData( "#GRT",#triggers )
	for k,v in pairs(triggers) do
		SetData( k.."GRT_start_x", v["start"].x )
		SetData( k.."GRT_start_y", v["start"].y )
		SetData( k.."GRT_start_z", v["start"].z )
		SetData( k.."GRT_end_x", v["end"].x )
		SetData( k.."GRT_end_y", v["end"].y )
		SetData( k.."GRT_end_z", v["end"].z )
	end
	timer.Simple(0.5,function()
		ply:SendLua("RunConsoleCommand('getboxes')")
	end)
end)

net.Receive("GRT_Save",function(l,ply)
	local data = {}
	data["start"] = net.ReadVector()
	data["end"] = net.ReadVector()
	table.insert(triggers,data)
	SetData( "#GRT", #triggers )
	SetData( #triggers.."GRT_start_x", data["start"].x )
	SetData( #triggers.."GRT_start_y", data["start"].y )
	SetData( #triggers.."GRT_start_z", data["start"].z )
	SetData( #triggers.."GRT_end_x", data["end"].x )
	SetData( #triggers.."GRT_end_y", data["end"].y )
	SetData( #triggers.."GRT_end_z", data["end"].z )
end)

timer.Simple(1,function()
	local n = tonumber(GetData( "#GRT", "0" ))
	for k=1,n do
		local data = {}
		data["start"] = Vector(tonumber(GetData( k.."GRT_start_x", "0" )),tonumber(GetData( k.."GRT_start_y", "0" )),tonumber(GetData( k.."GRT_start_z", "0" )))
		data["end"] = Vector(tonumber(GetData( k.."GRT_end_x", "0" )),tonumber(GetData( k.."GRT_end_y", "0" )),tonumber(GetData( k.."GRT_end_z", "0" )))
		table.insert(triggers,data)
	end
end)

local c = 0

concommand.Add("reloadboxes",function( ply, cmd, args )
	triggers = {}
	if(c<CurTime())then return end
	c = CurTime()+15
	local n = tonumber(GetData( "#GRT", "0" ))
	for k=1,n do
		local data = {}
		data["start"] = Vector(tonumber(GetData( k.."GRT_start_x", "0" )),tonumber(GetData( k.."GRT_start_y", "0" )),tonumber(GetData( k.."GRT_start_z", "0" )))
		data["end"] = Vector(tonumber(GetData( k.."GRT_end_x", "0" )),tonumber(GetData( k.."GRT_end_y", "0" )),tonumber(GetData( k.."GRT_end_z", "0" )))
		table.insert(triggers,data)
	end
end)

function ApplyRagdollPhys(r,g,v)
	if(g == "" or g == nil)then
		g = true
		if(GravityEnabled())then
			g = false
		end
	end
	
	for i=0, r:GetPhysicsObjectCount() - 1 do -- "ragdoll" being a ragdoll entity

		local phys = r:GetPhysicsObjectNum( i )
		phys:EnableGravity( g )
		if(v!=nil)then
			phys:SetVelocityInstantaneous( v )
		end
	end
end

function ApplyGPhys(e,g)
	local phys = e:GetPhysicsObject()

	if(e:GetClass()=="prop_ragdoll")then
		ApplyRagdollPhys(e,tobool( g ))
	else
		if ( IsValid(phys) ) then
			if(e:IsPlayer())then
				ApplyPlayerPhys(e,g)
			else
				ApplyEntPhys(phys,tobool( g ))
			end
		end
	end
end

local function ApplyPlayerPhys(p,g)
	p:SetGravity( g )
end

local function ApplyEntPhys(ph,g)
	if(GravityEnabled())then
		ph:EnableGravity( g )
	end
end

--[[local function spawn12( ply )
	if(GravityEnabled())then
		ApplyPlayerPhys(ply,0.0000000000001)
	end
end
hook.Add( "PlayerSpawn", "ever_grabity_PlayerSpawn", spawn12 )

local dp = {}


local function onThink()
	for k,v in pairs(dp)do
		if ( IsValid(v) ) then
			if(v:GetClass()=="prop_ragdoll")then
				ApplyRagdollPhys(v,false)
			else
				local phys = v:GetPhysicsObject()
				if ( IsValid(phys) ) then
					if(v:IsPlayer())then
						ApplyPlayerPhys(v,0.0000000000001)
					else
						ApplyEntPhys(phys,false)
					end
				end
			end
		end
	end
	
	dp = {}
	if(not GravityEnabled())then return end
	
	
	for k,v in pairs(triggers)do
		local entts = ents.FindInBox( v["start"], v["end"] )
		
		for i = 1, #entts do

			if(entts[i]:GetClass()=="prop_ragdoll")then
				ApplyRagdollPhys(entts[i],true)
				table.insert(dp,entts[i])
			else
				local phys = entts[i]:GetPhysicsObject()
				if ( IsValid(phys) ) then
					if(entts[i]:IsPlayer())then
						ApplyPlayerPhys(entts[i],1)
						table.insert(dp,entts[i])
					else
						ApplyEntPhys(phys,true)
						table.insert(dp,entts[i])
					end
				end
			end
		end
	end
end
hook.Add( "Think", "Ever_GravityCalculate", onThink )

concommand.Add("getboxes",function( ply, cmd, args )
	net.Start("sendboxes")
		net.WriteString(#triggers)
		for k,v in pairs(triggers)do
			net.WriteVector(v["start"])
			net.WriteVector(v["end"])
		end
	net.Send(ply)
end)

hook.Add( "PlayerSpawnedProp","Ever_gravity_PlayerSpawnedProp",function( ply, model, ent )
	if(GravityEnabled())then
		local phys = ent:GetPhysicsObject()
		ApplyEntPhys(phys,false)
	end
end)

hook.Add( "PlayerSpawnedRagdoll","Ever_gravity_PlayerSpawnedRagdoll",function( ply, model, ent )
	if(GravityEnabled())then
		ApplyRagdollPhys(ent,false)
	end
end)

hook.Add( "PlayerSpawnedSENT","Ever_gravity_PlayerSpawnedSENT",function( ply, ent )
	if(GravityEnabled())then
		local phys = ent:GetPhysicsObject()
		ApplyEntPhys(phys,false)
	end
end)

hook.Add( "PlayerSpawnedSWEP","Ever_gravity_PlayerSpawnedSWEP",function( ply, ent )
	if(GravityEnabled())then
		local phys = ent:GetPhysicsObject()
		ApplyEntPhys(phys,false)
	end
end)

hook.Add( "PlayerSpawnedVehicle","Ever_gravity_PlayerSpawnedVehicle",function( ply, ent )
	if(GravityEnabled())then
		local phys = ent:GetPhysicsObject()
		ApplyEntPhys(phys,false)
	end
end)]]--