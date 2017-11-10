
-----------------------------------------------------
local arrested
arrested = function() end
usermessage.Hook("GotArrested", function(msg)
  local StartArrested = CurTime()
  local ArrestedUntil = msg:ReadFloat()
  local Scrw = ScrW()
  local Scrh = ScrH()
  arrested = function()
    if CurTime() - StartArrested <= ArrestedUntil and LocalPlayer():getDarkRPVar("Arrested") then
      return draw.DrawNonParsedText(DarkRP.getPhrase("youre_arrested", math.ceil(ArrestedUntil - (CurTime() - StartArrested))), "DarkRPHUD1", Scrw / 2, Scrh - Scrh / 12, color_white, 1)
    elseif not LocalPlayer():getDarkRPVar("Arrested") then
      arrested = function() end
    end
  end
end)
return table.insert(phud.hooks.HUDPaint, function()
  return arrested()
end)
