
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
local blur = phud.blurTexture
vgui.Register('phud_main_v2', {
  Init = function(self)
    self.corner = ScreenScale(8)
    do
      local _with_0 = vgui.Create('phud_tile_profile', self)
      _with_0:SetSizeEx(45, 50)
      _with_0.n_MarginLeft = 0
      _with_0:SetCorner(self.corner)
      _with_0:SetPaintedManually(true)
      self.profile = _with_0
    end
    do
      local _with_0 = vgui.Create('phud_tile_info', self)
      _with_0:SetSizeEx(130, 50)
      _with_0.n_MarginLeft = -self.corner + ScreenScale(1)
      _with_0:SetCorner(self.corner)
      self.info = _with_0
    end
  end,
  PerformLayout = function(self)
    local w = 0
    local h = 0
    do
      local _with_0 = self.profile
      _with_0:PerformLayout()
    end
    do
      local _with_0 = self.info
      _with_0:PerformLayout()
    end
    local xpos = 0
    local _list_0 = self:GetChildren()
    for _index_0 = 1, #_list_0 do
      local panel = _list_0[_index_0]
      local pw, ph = panel:GetSize()
      xpos = xpos + (panel.n_MarginLeft or 0)
      panel:SetPos(xpos, 0)
      xpos = xpos + (pw + (panel.n_MarginRight or 0))
      if ph > h then
        h = ph
      end
    end
    w = xpos
    self:SetSize(w, h)
    return self:SetPos(ScreenScale(1), ScrH() - h - ScreenScale(1))
  end,
  Paint = function(self, w, h)
    do
      local _with_0 = self.profile
      _with_0:SetPaintedManually(false)
      _with_0:PaintManual()
      _with_0:SetPaintedManually(true)
      return _with_0
    end
  end
})
vgui.Register('phud_tile_info', {
  Init = function(self)
    self:InitBase()
    do
      local _with_0 = Label('', self)
      _with_0:SetFont('phud_8')
      _with_0:SetTextColor({
        r = 255,
        g = 255,
        b = 255,
        a = 255
      })
      _with_0:SizeToContents()
      self.nameLabel = _with_0
    end
    do
      local _with_0 = vgui.Create('phud_tile_bar', self)
      _with_0:SetValues(function()
        local localPlayer = LocalPlayer()
        return localPlayer:Health(), localPlayer:Armor(), localPlayer:GetMaxHealth()
      end)
      _with_0:SetBar(function(health, armor, maxHealth)
        return {
          r = 155,
          g = 0,
          b = 0,
          a = 155
        }, math.Clamp(health / maxHealth, 0, 1)
      end)
      _with_0:AddText((phud.language.getPhrase('HEALTH')), function(health)
        return true, health
      end)
      _with_0:AddText((phud.language.getPhrase('ARMOR')), function(health, armor)
        if armor <= 0 then
          return false
        end
        return true, armor
      end)
      self.barHealth = _with_0
    end
    do
      local _with_0 = vgui.Create('phud_tile_bar', self)
      _with_0:SetValues(function()
        local localPlayer = LocalPlayer()
        return localPlayer.DarkRPVars and localPlayer.DarkRPVars.money or 0
      end)
      _with_0:AddText((phud.language.getPhrase('MONEY')), function(money)
        return true, (phud.language.getPhrase('CURRENCY')), string.Comma(money)
      end)
      self.barMoney = _with_0
    end
	
    do
      local _with_0 = vgui.Create('phud_tile_bar', self)
      _with_0:SetValues(function()
        local localPlayer = LocalPlayer()
        local DarkRPVars = localPlayer.DarkRPVars
        if not (DarkRPVars) then
          return nil, nil
        end
        return DarkRPVars.job, DarkRPVars.salary
      end)
      _with_0:AddText((phud.language.getPhrase('JOB')), function(job)
        if not job then
          return true, 'unknown'
        end
        return true, job
      end)
      _with_0:AddText((phud.language.getPhrase('SALARY')), function(job, salary)
        if not salary then
          return false
        end
        if salary <= 0 then
          return false
        end
        return true, (phud.language.getPhrase('CURRENCY')), salary
      end)
      self.barJob = _with_0
    end
	
	    do
      local _with_0 = vgui.Create('phud_tile_bar', self)
      _with_0:SetValues(function()
        local localPlayer = LocalPlayer()
        return localPlayer:getDarkRPVar('level')
      end)
      _with_0:AddText((phud.language.getPhrase('LVL')), function(lvl)
        if not lvl then
          return true, 'unknown'
        end
        return true, lvl
      end)
      self.barLevel = _with_0
    end
    self.bars = {
      self.barHealth,
      self.barMoney,
      self.barJob,
      self.barLevel
    }
    self.layout = { }
    self.lastThink = RealTime()
  end,
  SetCorner = function(self, c)
    if c == nil then
      c = ScreenScale(8)
    end
    self.corner = c
  end,
  SetSizeEx = function(self, width, height)
    self.height = height
    self.width = width
    self:SetTall(ScreenScale(height))
    return self:SetWide(ScreenScale(width))
  end,
  Think = function(self)
    do
      if not self.lastUpdate or CurTime() - self.lastUpdate > 1 then
        self.lastUpdate = CurTime()
        do
          local _with_0 = self.nameLabel
          _with_0:SetText(LocalPlayer():Name())
          _with_0:SizeToContents()
          _with_0:SetPos(ScreenScale(12), (self.corner * 1.5 - self.nameLabel:GetTall()) * 0.5)
        end
        if LocalPlayer():getDarkRPVar('HasGunlicense') then
          do
            local _with_0 = self.nameLabel
            _with_0.PaintOver = function(_, w, h) end
            _with_0:SetWide(self.nameLabel:GetWide() + 32)
          end
          local gunMat = Material('icon16/gun.png')
          self.nameLabel.PaintOver = function(_, w, h)
            surface.SetMaterial(gunMat)
            surface.SetDrawColor(255, 255, 255, 255)
            return surface.DrawTexturedRect(w - 24, h * 0.5 - 12, 24, 24)
          end
        else
          do
            local _with_0 = self.nameLabel
            _with_0.PaintOver = function() end
          end
        end
      end
    end
    do
      local delta = RealTime() - self.lastThink
      self.lastThink = RealTime()
      local animRate = delta * 5
      local relayout = false
      local _list_0 = self.bars
      for _index_0 = 1, #_list_0 do
        local bar = _list_0[_index_0]
        if bar:DoUpdate(animRate) then
          relayout = true
        end
      end
      if relayout then
        local multiRowColumnIterator
        multiRowColumnIterator = function(rows)
          local iterators = { }
          local colNo = 0
          local _list_1 = self.bars
          for _index_0 = 1, #_list_1 do
            local bar = _list_1[_index_0]
            table.insert(iterators, bar:ColumnIterator())
          end
          return function()
            local any = false
            colNo = colNo + 1
            local ma, mb = 0, 0
            for _index_0 = 1, #iterators do
              local iter = iterators[_index_0]
              local a, b = iter()
              if a ~= nil then
                any = true
                if a > ma then
                  ma = a
                end
                if b > mb then
                  mb = b
                end
              end
            end
            if any then
              return colNo, ma, mb
            else
              return nil
            end
          end
        end
        local x = ScreenScale(5)
        for colNo, maxCaptionWidth, maxInfoWidth in multiRowColumnIterator(self.bars) do
          local _list_1 = self.bars
          for _index_0 = 1, #_list_1 do
            local bar = _list_1[_index_0]
            bar:SetColumn(colNo, x, x + maxCaptionWidth)
          end
          x = x + (maxCaptionWidth + maxInfoWidth)
        end
        local neededWidth = math.max(ScreenScale(self.width), x + ScreenScale(10))
        if neededWidth ~= self:GetWide() then
          self:SetWide(neededWidth)
          return self:InvalidateLayout()
        end
      end
    end
  end,
  PerformLayout = function(self)
    local w, h = self:GetSize()
    self:PolyBegin()
    self.polyHeader = self:PolyAdd({
      {
        x = 0,
        y = 0
      },
      {
        x = w - self.corner,
        y = 0
      },
      {
        x = w,
        y = self.corner * 1.5
      },
      {
        x = self.corner,
        y = self.corner * 1.5
      }
    })
    self:PolyEnd()
    do
      local padding = ScreenScale(1)
      local y = self.corner * 1.5 + padding
      h = h - y
      local barH = h / #self.bars - padding * ((#self.bars - 1) / #self.bars)
      local _list_0 = self.bars
      for _index_0 = 1, #_list_0 do
        local bar = _list_0[_index_0]
        do
          bar:SetPos(self.corner, y)
          bar:SetSize(w - self.corner, barH)
          bar:PerformLayout()
        end
        y = y + (barH + padding)
      end
    end
  end,
  Paint = function(self)
    draw.NoTexture()
    surface.SetDrawColor(0, 0, 0, 240)
    if self.polyHeader then
      return surface.DrawPoly(self.polyHeader)
    end
  end
}, 'phud_tile')
vgui.Register('phud_tile_bar', {
  Init = function(self)
    self:InitBase()
    self.elements = { }
    self.lerp = { }
    self.n_lastThink = CurTime()
  end,
  PerformLayout = function(self)
    local w, h = self:GetSize()
    self:PolyBegin()
    self.polyMain = self:PolyAdd({
      {
        x = 0,
        y = 0
      },
      {
        x = w,
        y = 0
      },
      {
        x = w,
        y = h
      },
      {
        x = 0,
        y = h
      }
    })
    return self:PolyEnd()
  end,
  SetBar = function(self, fn_bar)
    self.fn_bar = fn_bar
  end,
  SetValues = function(self, values)
    self.fn_values = values
  end,
  AddText = function(self, s_caption, fn_gen)
    return table.insert(self.elements, {
      caption = (function()
        do
          local _with_0 = Label(s_caption, self)
          _with_0:SetTextColor(Color(230, 230, 230))
          _with_0:SetFont('phud_6')
          _with_0:SizeToContents()
          return _with_0
        end
      end)(),
      fn_gen = fn_gen,
      w_caption = 0,
      w_info = 0,
      panels = { },
      parent = self,
      SetCaptionPos = function(self, x)
        return self.caption:SetPos(x, (self.parent:GetTall() - self.caption:GetTall()) * 0.5)
      end,
      SetInfoPos = function(self, x)
        local pheight = self.parent:GetTall()
        local _list_0 = self.panels
        for _index_0 = 1, #_list_0 do
          local panel = _list_0[_index_0]
          panel:SetPos(x, (pheight - panel:GetTall()) * 0.5)
          x = x + panel:GetWide()
        end
      end
    })
  end,
  SetColumn = function(self, index, x1, x2)
    local el = self.elements[index]
    if not (el) then
      return 
    end
    el:SetCaptionPos(x1)
    return el:SetInfoPos(x2)
  end,
  ColumnIterator = function(self)
    local index = 0
    return function()
      index = index + 1
      local el = self.elements[index]
      if not el then
        return nil
      end
      return el.w_caption, el.w_info
    end
  end,
  DoUpdate = function(self, lerp)
    if self:UpdateValues(lerp) then
      return self:UpdatePanels()
    end
    return false
  end,
  UpdateValues = function(self, lerpBy)
    local delta = false
    local values = {
      self:fn_values()
    }
    local lerp = self.lerp
    if #values ~= #lerp then
      delta = true
    end
    for i = #values + 1, #lerp do
      lerp[i] = nil
    end
    for k, v_raw in pairs(values) do
      local v_lerp = lerp[k]
      local t_vlerp = type(v_lerp)
      local t_vraw = type(v_raw)
      if t_vraw ~= t_vlerp then
        delta = true
        lerp[k] = v_raw
      end
      if t_vraw == 'number' then
        if math.abs(lerp[k] - v_raw) > 0.01 then
          lerp[k] = Lerp(lerpBy, lerp[k], v_raw)
          delta = true
        end
      elseif v_raw ~= v_lerp then
        v_lerp = v_raw
        delta = true
        lerp[k] = v_raw
      end
    end
    return delta
  end,
  UpdatePanels = function(self)
    local doElement
    doElement = function(el, visible, ...)
      local delta = false
      if visible then
        el.caption:SetVisible(true)
        el.w_caption = el.caption:GetWide() + ScreenScale(2.5)
        el.w_info = 0
        for i = select('#', ...) + 1, #el.panels do
          el.panels[i]:Remove()
          el.panels[i] = nil
        end
        for i = 1, select('#', ...) do
          if not el.panels[i] then
            do
              local _with_0 = Label('', self)
              _with_0:SetFont('phud_8')
              _with_0:SetTextColor(color_white)
              el.panels[i] = _with_0
            end
          end
          local p = el.panels[i]
          local text = select(i, ...)
          text = tostring(text)
          if p:GetText() ~= text then
            do
              p:SetText(text)
              p:SizeToContents()
            end
            delta = true
          end
          el.w_info = el.w_info + (p:GetWide() + ScreenScale(5))
        end
      else
        if el.w_caption > 0 then
          delta = true
        end
        el.caption:SetVisible(false)
        el.w_caption = 0
        el.w_info = 0
        local _list_0 = el.panels
        for _index_0 = 1, #_list_0 do
          local p = _list_0[_index_0]
          p:SetVisible(false)
        end
      end
      return delta
    end
    if self.fn_bar then
      self.c_barColor, self.n_barFrac = self.fn_bar(unpack(self.lerp))
    end
    local roundedLerp = { }
    for k, v in pairs(self.lerp) do
      if type(v) == 'number' then
        roundedLerp[k] = math.Round(v)
      else
        roundedLerp[k] = v
      end
    end
    local delta = false
    for k, el in ipairs(self.elements) do
      if doElement(el, el.fn_gen(unpack(roundedLerp))) then
        delta = true
      end
    end
    return delta
  end,
  Paint = function(self, w, h)
    draw.NoTexture()
    surface.SetDrawColor(0, 0, 0, 155)
    if self.polyMain then
      surface.DrawPoly(self.polyMain)
    end
    if self.c_barColor and self.n_barFrac then
      surface.SetDrawColor(self.c_barColor)
      return surface.DrawRect(0, 0, w * self.n_barFrac, h)
    end
  end
}, 'phud_tile')
return vgui.Register('phud_tile_profile', {
  Init = function(self)
    self:InitBase()
    self.p_AvatarImage = vgui.Create('AvatarImage', self)
    do
      local _with_0 = self.p_AvatarImage
      _with_0:SetPaintedManually(true)
    end
    local tryAgain
    tryAgain = function()
      if not IsValid(LocalPlayer()) then
        return timer.Simple(1, tryAgain)
      else
        return self.p_AvatarImage:SetPlayer(LocalPlayer(), 184)
      end
    end
    return tryAgain()
  end,
  SetCorner = function(self, c)
    if c == nil then
      c = ScreenScale(8)
    end
    self.corner = c
  end,
  PerformLayout = function(self)
    local w, h = self:GetSize()
    do
      local _with_0 = self.p_AvatarImage
      _with_0:SetSize(math.max(w, h), math.max(w, h))
      _with_0:Center()
    end
    self.polyOuter = {
      {
        x = 0,
        y = 0
      },
      {
        x = w - self.corner,
        y = 0
      },
      {
        x = w,
        y = self.corner * 1.5
      },
      {
        x = w,
        y = h
      },
      {
        x = 0,
        y = h
      }
    }
    self.polyMask2 = {
      {
        x = 3,
        y = 3
      },
      {
        x = w - self.corner - 1.5,
        y = 3
      },
      {
        x = w - 3,
        y = self.corner * 1.5 + 1.5
      },
      {
        x = w - 3,
        y = h - 3
      },
      {
        x = 3,
        y = h - 3
      }
    }
  end,
  Paint = function(self, w, h)
    render.SetStencilEnable(true)
    render.ClearStencil()
    render.SetStencilWriteMask(1)
    render.SetStencilTestMask(1)
    render.SetStencilReferenceValue(1)
    render.SetStencilCompareFunction(STENCIL_ALWAYS)
    render.SetStencilPassOperation(STENCIL_REPLACE)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    surface.SetDrawColor(255, 0, 0, 255)
    draw.NoTexture()
    if self.polyOuter then
      surface.DrawPoly(self.polyOuter)
    end
    render.SetStencilCompareFunction(STENCIL_EQUAL)
    render.SetStencilPassOperation(STENCIL_KEEP)
    render.SetStencilFailOperation(STENCIL_KEEP)
    render.SetStencilZFailOperation(STENCIL_KEEP)
    self.p_AvatarImage:SetPaintedManually(false)
    self.p_AvatarImage:PaintManual()
    self.p_AvatarImage:SetPaintedManually(true)
    return render.SetStencilEnable(false)
  end
}, 'phud_tile')
