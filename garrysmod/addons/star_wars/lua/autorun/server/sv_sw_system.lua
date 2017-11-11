util.AddNetworkString("SW.ShowHitMarker")

hook.Add("EntityTakeDamage" , "SW.TakeDamage" , function(ent , dmg)
    if (not SW.DrawHitMarkers) then return end
    if (not dmg:GetAttacker():IsPlayer()) then return end
    if ((ent.LastDamage or 0) > CurTime()) then return end
    ent.LastDamage = CurTime() + 0.25
    if (dmg:GetAttacker() ~= ent and ent:IsNPC() or ent:IsPlayer()) then
        MsgN()
        net.Start("SW.ShowHitMarker")
        net.WriteFloat(dmg:GetDamage())
        if(IsValid(dmg:GetInflictor()) && dmg:GetInflictor():GetClass() == "ent_lightsaber") then
            net.WriteVector(dmg:GetInflictor():GetPos())
        else
            net.WriteVector(dmg:GetDamagePosition() == Vector(0,0,0) and ent:GetPos() or dmg:GetDamagePosition())
        end
        net.Send(dmg:GetAttacker())
    end
end)
