
-----------------------------------------------------
local ScreenScaleEx, max
do
  local _obj_0 = phud
  ScreenScaleEx, max = _obj_0.ScreenScaleEx, _obj_0.max
end
local type, pairs, table, surface, render, draw, Color
do
  local _obj_0 = _G
  type, pairs, table, surface, render, draw, Color = _obj_0.type, _obj_0.pairs, _obj_0.table, _obj_0.surface, _obj_0.render, _obj_0.draw, _obj_0.Color
end
local blur = Material('pp/blurscreen')
surface.CreateFont('phud_8', {
  font = 'Verdana',
  size = ScreenScale(8),
  weight = 400
})
surface.CreateFont('phud_7', {
  font = 'Verdana Bold',
  size = ScreenScale(7),
  weight = 400
})
surface.CreateFont('phud_6', {
  font = 'Verdana Bold',
  size = ScreenScale(6),
  weight = 1000
})
surface.CreateFont('phud_5', {
  font = 'Verdana Bold',
  size = ScreenScale(5),
  weight = 1000
})
if phud_panels then
  for _index_0 = 1, #phud_panels do
    local pnl = phud_panels[_index_0]
    if ValidPanel(pnl) then
      pnl:Remove()
    end
  end
end
phud_panels = { }
local addElement
addElement = function(panel, shouldShow)
  panel.__sys__isVisible = shouldShow
  table.insert(phud_panels, panel)
  return panel:SetPaintedManually(true)
end
--[[(GAMEMODE or GM).HUDPaint = function()
  render.SetStencilEnable(true)
  render.ClearStencil()
  render.SetStencilWriteMask(1)
  render.SetStencilTestMask(1)
  render.SetStencilReferenceValue(1)
  render.SetStencilCompareFunction(STENCIL_NEVER)
  render.SetStencilPassOperation(STENCIL_REPLACE)
  render.SetStencilFailOperation(STENCIL_REPLACE)
  render.SetStencilZFailOperation(STENCIL_KEEP)
  local drawShit
  drawShit = function(p)
    if not p:IsVisible() then
      return 
    end
    if p.DrawForBlurEffect then
      p:DrawForBlurEffect()
    end
    local cldrn = p:GetChildren()
    for _index_0 = 1, #cldrn do
      local c = cldrn[_index_0]
      drawShit(c)
    end
  end
  for _index_0 = 1, #phud_panels do
    local panel = phud_panels[_index_0]
    local vis = panel:__sys__isVisible()
    panel:SetVisible(vis)
    drawShit(panel)
  end
  render.SetStencilCompareFunction(STENCIL_EQUAL)
  render.SetStencilPassOperation(STENCIL_KEEP)
  render.SetStencilFailOperation(STENCIL_KEEP)
  render.SetStencilZFailOperation(STENCIL_KEEP)
  surface.SetDrawColor(255, 255, 255)
  surface.SetMaterial(blur)
  local amount = 10
  local passes = 5
  if phud.config.blur then
    local scrw, scrh = ScrW(), ScrH()
    for i = 1, passes do
      blur:SetFloat('$blur', (i / passes) * (amount))
      blur:Recompute()
      render.UpdateScreenEffectTexture()
      surface.DrawTexturedRect(0, 0, scrw, scrh)
    end
  end
  render.SetStencilEnable(false)
  for _index_0 = 1, #phud_panels do
    local panel = phud_panels[_index_0]
    do
      panel:SetPaintedManually(false)
      panel:PaintManual()
      panel:SetPaintedManually(true)
    end
  end
  local _list_0 = phud.hooks.HUDPaint
  for _index_0 = 1, #_list_0 do
    local hook = _list_0[_index_0]
    hook()
  end
  if GAMEMODE and GAMEMODE.Sandbox then
    return GAMEMODE.Sandbox:HUDPaint()
  end
end]]--
(GM or GAMEMODE).PostDrawTranslucentRenderables = function()
  local _list_0 = phud.hooks.PostDrawTranslucentRenderables
  for _index_0 = 1, #_list_0 do
    local fn = _list_0[_index_0]
    fn()
  end
end
return phud.waitForSpawn(function()
  addElement((vgui.Create('phud_main_v2')), function()
    return true
  end)
  return addElement((vgui.Create('phud_agenda')), function(self)
    local agenda = LocalPlayer():getAgendaTable()
    if not (agenda) then
      return false
    end
    self.agenda = agenda
    return true
  end)
end)
