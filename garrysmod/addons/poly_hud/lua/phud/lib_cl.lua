
-----------------------------------------------------
phud.ScreenScaleEx = function(x, ...)
  if x ~= nil then
    return ScreenScale(x), phud.ScreenScaleEx(...)
  end
end
phud.max = function(arr, fn)
  local val = -math.huge
  for _index_0 = 1, #arr do
    local v = arr[_index_0]
    local _ = fn(v)
    if _ > val then
      val = _
    end
  end
  return val
end
phud.storeArgs = function(...)
  local storeArgs
  storeArgs = function(i, a, ...)
    if i == 0 then
      return 
    end
    local next = storeArgs(i - 1, ...)
    if next then
      return function(after)
        return a, next(after)
      end
    else
      return function(after)
        if after then
          return a, after()
        end
        return a
      end
    end
  end
  local c = select('#', ...)
  if c == 0 then
    return function() end
  end
  return storeArgs(c, ...)
end
phud.fnBind = function(func, ...)
  local _1 = phud.storeArgs(...)
  return function(...)
    local _2 = phud.storeArgs(...)
    return func(_1(_2))
  end
end
phud.waitForSpawn = function(func)
  local try
  try = function()
    if IsValid(LocalPlayer()) then
      return func()
    else
      return timer.Simple(1, try)
    end
  end
  return try()
end
phud.curry = function(fn, arguments)
  if arguments == 1 then
    return fn
  end
  return function(a)
    local newFunc
    newFunc = function(...)
      return fn(a, ...)
    end
    return phud.curry(newFunc, arguments - 1)
  end
end
phud.hooks = {
  HUDPaint = { },
  PostDrawTranslucentRenderables = { }
}
phud.identityFunc = function(val)
  return function()
    return val
  end
end
