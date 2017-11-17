
-----------------------------------------------------
(GM or GAMEMODE).DrawDeathNotice = function(self, x, y)
  if GAMEMODE.Config.showdeaths and self.Sandbox then
    return self.Sandbox.DrawDeathNotice(self, x, y)
  end
end
local DisplayNotify
DisplayNotify = function(msg)
  local txt = msg:ReadString()
  GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
  surface.PlaySound('buttons/lightswitch2.wav')
  return MsgC(Color(255, 20, 20, 255), '[DarkRP] ', Color(200, 200, 200, 255), txt, '\n')
end
usermessage.Hook("_Notify", DisplayNotify);
--(GM or GAMEMODE).HUDShouldDraw = function(self, name)
  --if name == 'CHudHealth' or name == 'CHudBattery' or name == 'CHudSuitPower' then
   -- return false
  --else
    --return self.Sandbox and self.Sandbox.HUDShouldDraw(self, name) or true
 -- end
--end
(GM or GAMEMODE).HUDDrawTargetID = phud.identityFunc(false)
