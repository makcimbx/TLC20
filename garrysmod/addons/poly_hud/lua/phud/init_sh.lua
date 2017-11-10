
-----------------------------------------------------
MsgC(Color(200, 200, 200), '------------------------\n')
MsgC(Color(255, 255, 255), ' phud by thelastpenguin \n')
MsgC(Color(200, 200, 200), '------------------------\n');
(((GAMEMODE or GM).Config or { }).DisabledCustomModules or { })['hud'] = true
phud.include_cl('lib_cl.lua')
phud.include_sh('_config_sh.lua')
phud.include_cl('phud/language_cl.lua')
phud.include_cl('phud/languages/' .. phud.config.language .. '.lua')
phud.include_cl('compatability_cl.lua')
phud.include_cl('vgui/vgui_base.lua')
phud.include_cl('vgui/vgui_agenda.lua')
phud.include_cl('vgui/vgui_hud.lua')
local _list_0 = file.Find('phud/hud/*.lua', 'LUA')
for _index_0 = 1, #_list_0 do
  local file = _list_0[_index_0]
  phud.include_cl('phud/hud/' .. file)
end
return phud.include_cl('hud_cl.lua')
