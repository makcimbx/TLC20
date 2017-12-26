util.AddNetworkString("GRT_Save")
util.AddNetworkString("sendboxes")

local triggers = {}

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

local function ApplyRagdollPhys(r,g)
	for i=0, r:GetPhysicsObjectCount() - 1 do -- "ragdoll" being a ragdoll entity

		local phys = r:GetPhysicsObjectNum( i )
		phys:EnableGravity( g )

	end
end

local function onThink()
	for k,v in pairs(ents.GetAll())do
		local phys = v:GetPhysicsObject()
		
		if(v:GetClass()=="prop_ragdoll")then
			ApplyRagdollPhys(v,false)
		else
			if ( IsValid(phys) ) then
				if(v:IsPlayer())then
					v:SetGravity( 0.0001 )
				else
					phys:EnableGravity( false )
				end
			end
		end
	end
	
	for k,v in pairs(triggers)do
		local entts = ents.FindInBox( v["start"], v["end"] )
		
		for i = 1, #entts do
			
			local phys = entts[i]:GetPhysicsObject()

			if(entts[i]:GetClass()=="prop_ragdoll")then
				ApplyRagdollPhys(entts[i],true)
			else
				if ( IsValid(phys) ) then
					if(entts[i]:IsPlayer())then
						entts[i]:SetGravity( 1 )
					else
						phys:EnableGravity( true )
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