
-----------------------------------------------------
local vcTex = surface.GetTextureID("voice/icntlk_pl")
return table.insert(phud.hooks.HUDPaint, function()
  if not (LocalPlayer().DRPIsTalking) then
    return 
  end
  local chbxX, chbxY = chat.GetChatBoxPos()
  local rot = math.sin((CurTime() * 3))
  local backwards = 0
  if rot < 0 then
    rot = 1 - (1 + rot)
    backwards = 180
  end
  surface.SetTexture(vcTex)
  surface.SetDrawColor(255, 0, 0)
  return surface.DrawTexturedRectRotated(ScrW() - 100, chbxY or 0, rot * 96, 96, backwards)
end)
