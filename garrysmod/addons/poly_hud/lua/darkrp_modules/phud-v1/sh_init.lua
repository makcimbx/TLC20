
-----------------------------------------------------
phud = { }
phud.noop = function() end
phud.include_sv = SERVER and include or phud.noop
phud.include_cl = SERVER and AddCSLuaFile or include
phud.include_sh = function(...)
  phud.include_cl(...)
  return phud.include_sv(...)
end
return phud.include_sh('phud/init_sh.lua')
