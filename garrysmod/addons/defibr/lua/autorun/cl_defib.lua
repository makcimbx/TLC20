
PLYFORCEDEADSPAWN = nil
function Kun_MakeMarker()
	local ply = LocalPlayer()
	if(PLYFORCEDEADSPAWN == nil and Kun_ForceLive == 1) then
	
		PLYFORCEDEADSPAWN = vgui.Create("DFrame")
		PLYFORCEDEADSPAWN:SetSize( 120, 60)
		PLYFORCEDEADSPAWN:Center()
		PLYFORCEDEADSPAWN:SetDraggable( false )
		PLYFORCEDEADSPAWN:SetVisible( true )
		PLYFORCEDEADSPAWN:ShowCloseButton( true )
		PLYFORCEDEADSPAWN:MakePopup()
		PLYFORCEDEADSPAWN:SetTitle("")
		PLYFORCEDEADSPAWN.Paint = function(PLYFORCEDEADSPAWN)
			surface.SetDrawColor( 250, 250, 250, 255) 
			surface.DrawRect(0 , 0, PLYFORCEDEADSPAWN:GetWide(), PLYFORCEDEADSPAWN:GetTall() )
			
			surface.SetDrawColor( 50, 50, 50, 255) 
			surface.DrawRect(2 , 2, PLYFORCEDEADSPAWN:GetWide()-4, PLYFORCEDEADSPAWN:GetTall()-4 )
		end
		
		dbutz = vgui.Create("DButton", PLYFORCEDEADSPAWN)
		dbutz:SetSize(100,20)
		dbutz:SetText("Респавн")
		dbutz:SetPos(10, 30)
		dbutz.DoClick = function()
			net.Start("DarkRP_Kun_ForceSpawn")
			net.SendToServer()
			PLYFORCEDEADSPAWN:Close()
		end
		PLYFORCEDEADSPAWN:SetVisible(false)
	end
	if(ply:Alive() == false and ply:GetNWInt("KunDeathTime") != 0) then
		surface.SetDrawColor( 0, 0, 0, 205) 
		surface.DrawRect(0, 0, ScrW(), ScrH())
		local form = (1 + ply:GetNWInt("ForceAddExDeath") - math.ceil(CurTime() - ply:GetNWInt("KunDeathTime")))
		if(form == 1 or form == 0) then if(PLYFORCEDEADSPAWN != nil and PLYFORCEDEADSPAWN:IsValid()) then PLYFORCEDEADSPAWN:Close() end end
		draw.SimpleText( "Вы мертвы. "..form.." секунд до респавна.", "TargetID", ScrW() / 2, ScrH() / 2, Color(250,250,250,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		if(PLYFORCEDEADSPAWN  != nil and PLYFORCEDEADSPAWN :IsValid() and Kun_ForceLive == 1) then
			if(math.ceil(CurTime() - ply:GetNWInt("KunDeathTime")) >= Kun_ForceLiveTime) then
				if(!ply:Alive()) then
					PLYFORCEDEADSPAWN:SetVisible(true)
				else
					PLYFORCEDEADSPAWN:SetVisible(false)
				end
			end
		end
	end
	if(Kun_DrawHealth == 1 and ply:Alive()) then
		if(ply:IsTeamType("medic")) then
			for k,v in pairs(ents.GetAll()) do
				if(v != nil and v:IsValid() and v:GetClass() == "prop_ragdoll") then
					if(ply:GetPos():Distance( v:GetPos() )) <= 1000 and v:GetNWInt("RagDeathTimeZ")!=0 then
						local pos = v:GetPos():ToScreen()
						local forczersad = Kun_DeathTime
						if(Kun_AddExtraTime == 1) then
							forczersad = forczersad + Kun_ExtraDeathTime
						end
						draw.SimpleText( "Время: "..forczersad - math.ceil(CurTime() - v:GetNWInt("RagDeathTimeZ")), "TargetID", pos.x - 20, pos.y + 30, Color(250,250,250,255))
						surface.SetDrawColor( 250, 250, 250, 255) 
						surface.DrawRect(pos.x, pos.y, 10, 30 )
						surface.DrawRect(pos.x - 10, pos.y + 10, 30, 10 )
					end
				end
			end
		end
	end
end
hook.Add("HUDPaint", "Kun_MakeMarker", Kun_MakeMarker)
