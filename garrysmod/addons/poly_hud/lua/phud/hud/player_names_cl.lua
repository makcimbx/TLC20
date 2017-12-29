
-----------------------------------------------------
local headHeight = Vector(0, 0, 80)
local blur3d2d = CreateMaterial('phud-names-3d2d-blur', 'Refract', {
  ["$model"] = 1,
  ["$dudvmap"] = "models/wireframe",
  ["$normalmap"] = "models/wireframe",
  ["$refractamount"] = "0",
  ["$vertexalpha"] = "1",
  ["$vertexcolor"] = "1",
  ["$translucent"] = "1",
  ["$forcerefract"] = 1,
  ["$bluramount"] = "1",
  ["$nofog"] = "1",
  ["Refract_DX60"] = {
    ["$fallbackmaterial"] = "null"
  }
})
local draw_blur3d2d
draw_blur3d2d = function(x, y, w, h, amount)
  if amount == nil then
    amount = 5
  end
  surface.SetMaterial(blur3d2d)
  surface.SetDrawColor(255, 255, 255, 255)
  local scrw, scrh = ScrW(), ScrH()
  for i = 2, 1, -1 do
    blur3d2d:SetFloat("$blur", amount / i)
    blur3d2d:Recompute()
    render.UpdateFullScreenDepthTexture()
    render.UpdatePowerOfTwoTexture()
    render.UpdateRefractTexture()
    if (render) then
      render.UpdateScreenEffectTexture()
    end
    surface.DrawTexturedRectUV(x, y, w, h, x / scrw, y / scrh, (x + w) / scrw, (y + w) / scrh)
  end
end
surface.CreateFont('phud-3d2d-namefont', {
  font = 'coolvetica',
  size = 50,
  weight = 0
})
surface.CreateFont('phud-3d2d-factfont', {
  font = 'coolvetica',
  size = 35,
  weight = 0
})
local widgets = { }
local addWidget
addWidget = function(color, font, value)
  local drawFunc
  drawFunc = function(x, y, pl)
    local text = value(pl)
    if not text then
      return false
    end
    surface.SetFont(font)
    local tw, th = surface.GetTextSize(text)
    local bw, bh = tw + 3, th
    surface.SetDrawColor(((type(color)) == 'function' and color(pl) or color))
    surface.DrawRect(x, y, 5, bh)
    surface.SetDrawColor(0, 0, 0, 155)
    surface.DrawRect(x + 5, y, bw + 4, bh)
    surface.SetTextPos(x + 7 + (bw - tw) * 0.5, y + (bh - th) * 0.5)
    surface.SetTextColor(255, 255, 255)
    surface.DrawText(text)
    return true, bh
  end
  widgets[#widgets + 1] = drawFunc
end
addWidget(Color(0, 0, 0), 'phud-3d2d-namefont', function(pl)
  return pl:Name()
end)
addWidget(Color(255, 0, 0), 'phud-3d2d-factfont', function(pl)
  return phud.language.getPhrase('HEALTH') .. ': ' .. pl:Health()
end)
do
  local plTeamColor
  plTeamColor = function(pl)
    return (team.GetColor(pl:Team())) or color_white
  end
  addWidget(plTeamColor, 'phud-3d2d-factfont', function(pl)
    return phud.language.getPhrase('JOB') .. ': ' .. (pl:getDarkRPVar("job") or 'Unknown')
  end)
end
addWidget(Color(255, 155, 0), 'phud-3d2d-factfont', function(pl)
  return (pl:getDarkRPVar('HasGunlicense')) and phud.language.getPhrase('GUN LICENSE')
end)
addWidget(Color(0, 153, 255), 'phud-3d2d-factfont', function(pl)
	local level = pl:getDarkRPVar('level') or "-"
  return  phud.language.getPhrase('LVL')..': ' .. level
end)
addWidget(Color(0, 153, 255), 'phud-3d2d-factfont', function(pl)
	local level = everkekul or "-"
  return  phud.language.getPhrase('LVLWAR')..': ' .. level
end)

local drawPlayer
drawPlayer = function(pl)
  local LocalPlayer = LocalPlayer()
  local boneIndex = pl:LookupBone('ValveBiped.Bip01_Head1')
  local bonePos = boneIndex and pl:GetBonePosition(boneIndex) or pl:GetPos()
  local myEyeAngles = LocalPlayer:EyeAngles()
  myEyeAngles.p = 0
  myEyeAngles:RotateAroundAxis(myEyeAngles:Right(), 90)
  myEyeAngles:RotateAroundAxis(myEyeAngles:Up(), -90)
  bonePos = bonePos + myEyeAngles:Forward() * 10
  cam.Start3D2D(bonePos, myEyeAngles, 0.1)
  cam.IgnoreZ(true)
  do
    local y = 0
    for _index_0 = 1, #widgets do
      local w = widgets[_index_0]
      local succ, offy = w(0, y, pl)
      if succ then
        y = y + offy + 4
      end
    end
  end
  cam.IgnoreZ(false)
  return cam.End3D2D()
end
return table.insert(phud.hooks.PostDrawTranslucentRenderables, function()
  local lp = LocalPlayer()
  local tr = lp:GetEyeTrace()
  if IsValid(tr.Entity) and tr.Entity:IsPlayer() then
    return drawPlayer(tr.Entity)
  end
end)
