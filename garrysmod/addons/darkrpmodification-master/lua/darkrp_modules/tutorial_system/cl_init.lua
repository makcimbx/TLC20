local function TrainEnd()
	net.Start("StartTest")
	
	net.SendToServer()
end

hook.Add( "PostServerIntro", "Ever_PostServerIntro", function( ply )
	TrainEnd()
end )
