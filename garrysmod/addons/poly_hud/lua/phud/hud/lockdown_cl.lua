
-----------------------------------------------------
return table.insert(phud.hooks.HUDPaint, function()
  if not (GetGlobalBool("DarkRP_LockDown")) then
    return 
  end
  local chbxX, chboxY = chat.GetChatBoxPos()
  local cin = (math.sin(CurTime()) + 1) / 2
  local chatBoxSize = math.floor(ScrH() / 4)
  return draw.DrawNonParsedText(DarkRP.getPhrase("lockdown_started"), "ScoreboardSubtitle", chbxX, chboxY + chatBoxSize, Color(cin * 255, 0, 255 - (cin * 255), 255), TEXT_ALIGN_LEFT)
end)
