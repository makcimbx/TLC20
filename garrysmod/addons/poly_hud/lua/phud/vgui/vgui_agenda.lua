
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
local agendaText = ''
hook.Add('DarkRPVarChanged', 'agenda', function(ply, var, _, new)
  if ply ~= LocalPlayer() then
    return 
  end
  if var ~= 'agenda' then
    return 
  end
  new = new or ''
  agendaText = new:gsub("//", "\n"):gsub("\\n", "\n")
end)
return vgui.Register('phud_agenda', {
  Init = function(self)
    self:InitBase()
    self.corner = ScreenScale(8)
    do
      local _with_0 = Label((phud.language.getPhrase('AGENDA')), self)
      _with_0:SetFont('phud_8')
      _with_0:SizeToContents()
      self.title = _with_0
    end
    self.title:SetPos((ScreenScale(10)), ((ScreenScale(10)) - self.title:GetTall()) * 0.5)
    do
      local _with_0 = Label('', self)
      _with_0:SetFont('phud_8')
      _with_0:SizeToContents()
      self.label = _with_0
    end
  end,
  PerformLayout = function(self)
    self:SetWide(ScrW() * 0.33)
    self:SetPos((ScreenScale(1)), (ScreenScale(1)))
    local w, h = self:GetSize()
    self:PolyBegin()
    self.header = self:PolyAdd({
      {
        0,
        0
      },
      {
        w,
        0
      },
      {
        w,
        ScreenScale(10)
      },
      {
        0,
        ScreenScale(10)
      }
    })
    self.body = self:PolyAdd({
      {
        0,
        ScreenScale(10.5)
      },
      {
        w,
        ScreenScale(10.5)
      },
      {
        w,
        h - ScreenScale(8)
      },
      {
        w - ScreenScale(8),
        h
      },
      {
        0,
        h
      }
    })
    self.agendaText = DarkRP.textWrap(self.agendaTextRaw, 'phud_8', self:GetWide() - (ScreenScale(10)))
    do
      local _with_0 = self.label
      _with_0:SetText(self.agendaText)
      _with_0:SizeToContents()
      _with_0:SetPos((ScreenScale(5)), (ScreenScale(12)))
    end
    self:SetTall(math.max((ScreenScale(12 + 20) + self.label:GetTall()), (ScreenScale(40))))
    return self:PolyEnd()
  end,
  Think = function(self)
    if self.agendaTextRaw ~= agendaText then
      self.agendaTextRaw = agendaText
      return self:PerformLayout()
    end
  end,
  Paint = function(self, w, h)
    draw.NoTexture()
    surface.SetDrawColor(0, 0, 0, 230)
    surface.DrawPoly(self.header)
    surface.SetDrawColor(0, 0, 0, 190)
    return surface.DrawPoly(self.body)
  end
}, 'phud_tile')
