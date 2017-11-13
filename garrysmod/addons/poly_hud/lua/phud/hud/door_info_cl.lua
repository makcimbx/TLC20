
-----------------------------------------------------
/*return table.insert(phud.hooks.HUDPaint, function()
  local lp = LocalPlayer()
  local tr = lp:GetEyeTrace()
  if IsValid(tr.Entity) and tr.Entity:isKeysOwnable() and tr.Entity:GetPos():DistToSqr(lp:GetPos()) < 40000 then
    return tr.Entity:drawOwnableInfo()
  end
end)
