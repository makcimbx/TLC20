local function GetTag( ply )
	
	if not ( IsValid( ply ) and ATAG.EnableScoreboardTag ) then
		return "", Color( 255, 255, 255 )
	end
	
	local name, color = ply:getScoreboardTag()
	return name or "", color or Color( 255, 255, 255 )
end
hook.Add( "aTag_GetScoreboardTag", "aTag_getscoreboardtag", GetTag )