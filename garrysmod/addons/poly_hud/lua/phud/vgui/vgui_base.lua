
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
local quad
quad = function(x, y, w, h)
  return function()
    return x, y, w, h
  end
end
return vgui.Register('phud_tile', {
  InitBase = function(self)
    self.__intern_polygons = { }
    self.__intern_quads = { }
    self.polygons = { }
    self.quads = { }
  end,
  QuadBegin = function(self)
    for k, v in ipairs(self.__intern_quads) do
      self.__intern_quads[k] = nil
    end
  end,
  QuadAdd = function(self, x, y, w, h)
    local q = quad(x, y, w, h)
    table.insert(self.__intern_quads, q)
    return quad(q())
  end,
  PolyBegin = function(self)
    for k, v in ipairs(self.__intern_polygons) do
      self.__intern_polygons[k] = nil
    end
  end,
  PolyAdd = function(self, _poly)
    local poly
    do
      local _accum_0 = { }
      local _len_0 = 1
      for _index_0 = 1, #_poly do
        local node = _poly[_index_0]
        if #node == 2 then
          _accum_0[_len_0] = {
            x = node[1],
            y = node[2]
          }
        else
          _accum_0[_len_0] = {
            x = node.x,
            y = node.y
          }
        end
        _len_0 = _len_0 + 1
      end
      poly = _accum_0
    end
    table.insert(self.__intern_polygons, poly)
    do
      local _accum_0 = { }
      local _len_0 = 1
      for _index_0 = 1, #poly do
        local node = poly[_index_0]
        _accum_0[_len_0] = {
          x = node.x,
          y = node.y
        }
        _len_0 = _len_0 + 1
      end
      poly = _accum_0
    end
    return poly
  end,
  PolyEnd = function(self)
    local x, y = self:LocalToScreen(0, 0)
    do
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = self.__intern_polygons
      for _index_0 = 1, #_list_0 do
        local poly = _list_0[_index_0]
        local tru
        do
          local _accum_1 = { }
          local _len_1 = 1
          for _index_1 = 1, #poly do
            local vert = poly[_index_1]
            _accum_1[_len_1] = {
              x = vert.x + x,
              y = vert.y + y
            }
            _len_1 = _len_1 + 1
          end
          tru = _accum_1
        end
        local _value_0 = tru
        _accum_0[_len_0] = _value_0
        _len_0 = _len_0 + 1
      end
      self.polygons = _accum_0
    end
  end,
  QuadEnd = function(self)
    local x, y = self:LocalToScreen(0, 0)
    do
      local _accum_0 = { }
      local _len_0 = 1
      local _list_0 = self.__intern_quads
      for _index_0 = 1, #_list_0 do
        local q = _list_0[_index_0]
        local _x, _y, w, h = q()
        local _value_0 = quad(x + _x, y + _y, w, h)
        _accum_0[_len_0] = _value_0
        _len_0 = _len_0 + 1
      end
      self.quads = _accum_0
    end
  end,
  PolyDraw = function(self)
    local _list_0 = self.polygons
    for _index_0 = 1, #_list_0 do
      local p = _list_0[_index_0]
      surface.DrawPoly(p)
    end
  end,
  QuadDraw = function(self)
    local _list_0 = self.quads
    for _index_0 = 1, #_list_0 do
      local q = _list_0[_index_0]
      surface.DrawTexturedRect(q())
    end
  end,
  DrawForBlurEffect = function(self)
    draw.NoTexture()
    surface.SetDrawColor(255, 255, 255)
    self:PolyDraw()
    return self:QuadDraw()
  end,
  SetSizeEx = function(self, ...)
    return self:SetSize(ScreenScaleEx(...))
  end
})
