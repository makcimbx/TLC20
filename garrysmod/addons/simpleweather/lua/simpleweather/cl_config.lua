CreateClientConVar( "sw_showweather", "1" );
CreateClientConVar( "sw_rain", "1" );
CreateClientConVar( "sw_storm", "1" );
CreateClientConVar( "sw_snow", "1" );
CreateClientConVar( "sw_blizzard", "1" );
CreateClientConVar( "sw_showrainimpact", "1" );
CreateClientConVar( "sw_rainimpactquality", "2" );
CreateClientConVar( "sw_showclock", "1" );

surface.CreateFont( "SW.GUIFont", {
	font = "Trebuchet MS",
	size = 20,
	weight = 500
} );

surface.CreateFont( "SW.GUIFont16", {
	font = "Trebuchet MS",
	size = 16,
	weight = 500
} );

function SW.CreateConfigWindow()
	
	if( SW.ConfigWindow ) then
		
		SW.ConfigWindow:Remove();
		
	end
	
	SW.ConfigWindow = vgui.Create( "DFrame" );
	SW.ConfigWindow:SetSize( 300, 230 );
	SW.ConfigWindow:Center();
	SW.ConfigWindow:SetTitle( "SimpleWeather Config" );
	SW.ConfigWindow:MakePopup();
	function SW.ConfigWindow:Paint( w, h )
		
		surface.SetDrawColor( Color( 50, 50, 50, 255 ) );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( Color( 0, 73, 255, 255 ) );
		surface.DrawRect( 0, 0, w, 24 );
		
	end
	SW.ConfigWindow.lblTitle:SetFont( "SW.GUIFont" );
	SW.ConfigWindow:ShowCloseButton( false );
	SW.ConfigWindow:SetAlpha( 0 );
	SW.ConfigWindow:AlphaTo( 255, 0.2 );
	
	local btn = vgui.Create( "DButton", SW.ConfigWindow );
	btn:SetPos( SW.ConfigWindow:GetWide() - 24, 0 );
	btn:SetSize( 24, 24 );
	btn:SetFont( "marlett" );
	btn:SetText( "r" );
	btn:SetTextColor( Color( 255, 255, 255, 255 ) );
	function btn:DoClick()
		self:SetDisabled( true );
		self:GetParent():SetMouseInputEnabled( false );
		self:GetParent():SetKeyboardInputEnabled( false );
		self:GetParent():AlphaTo( 0, 0.2, 0, function()
			self:GetParent():Remove();
		end );
	end
	function btn:Paint( w, h )
		surface.SetDrawColor( Color( 76, 128, 255, 255 ) );
		surface.DrawRect( 0, 0, w, h );
	end
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 10, 34 );
	check:SetConVar( "sw_showweather" );
	check:SetText( "Particle Effects" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 160, 34 );
	check:SetConVar( "sw_rain" );
	check:SetText( "Rain Particles" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 160, 54 );
	check:SetConVar( "sw_storm" );
	check:SetText( "Storm Particles" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 160, 74 );
	check:SetConVar( "sw_snow" );
	check:SetText( "Snow Particles" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 160, 94 );
	check:SetConVar( "sw_blizzard" );
	check:SetText( "Blizzard Particles" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 10, 114 );
	check:SetConVar( "sw_showrainimpact" );
	check:SetText( "Show Rain Impacts" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local text = vgui.Create( "DLabel", SW.ConfigWindow );
	text:SetPos( 10, 134 );
	text:SetText( "Rain Impact Quality" );
	text:SetFont( "SW.GUIFont16" );
	text:SizeToContents();
	
	local combo = vgui.Create( "DComboBox", SW.ConfigWindow );
	combo:SetPos( 160, 134 );
	combo:SetSize( 130, 20 );
	
	local val = GetConVar( "sw_rainimpactquality" ):GetInt();
	if( val == 1 ) then combo:SetValue( "Low" ) end
	if( val == 2 ) then combo:SetValue( "Medium" ) end
	if( val == 3 ) then combo:SetValue( "High" ) end
	if( val == 4 ) then combo:SetValue( "Ultra" ) end
	combo:AddChoice( "Low", 1 );
	combo:AddChoice( "Medium", 2 );
	combo:AddChoice( "High", 3 );
	combo:AddChoice( "Ultra", 4 );
	function combo:OnSelect( index, value )
		
		RunConsoleCommand( "sw_rainimpactquality", tostring( self:GetOptionData( index ) ) );
		
	end
	
	local pan = vgui.Create( "DPanel", SW.ConfigWindow );
	pan:SetPos( 10, 164 );
	pan:SetSize( SW.ConfigWindow:GetWide() - 20, 1 );
	function pan:Paint( w, h )
		
		surface.SetDrawColor( Color( 255, 255, 255, 20 ) );
		surface.DrawRect( 0, 0, w, h );
		
	end
	
	local check = vgui.Create( "DCheckBoxLabel", SW.ConfigWindow );
	check:SetPos( 10, 174 );
	check:SetConVar( "sw_showclock" );
	check:SetText( "Show Clock" );
	check.Label:SetFont( "SW.GUIFont16" );
	check:SizeToContents();
	
	local panel = vgui.Create( "DPanel", SW.ConfigWindow );
	panel:SetPos( 0, SW.ConfigWindow:GetTall() - 30 );
	panel:SetSize( SW.ConfigWindow:GetWide(), 30 );
	function panel:Paint( w, h )
		surface.SetDrawColor( Color( 60, 60, 60, 255 ) );
		surface.DrawRect( 0, 0, w, h );
	end
	
	local text = vgui.Create( "DLabel", panel );
	text:SetText( "SimpleWeather by Disseminate." );
	text:SetFont( "SW.GUIFont16" );
	text:SizeToContents();
	text:Center();
	
end

function SW.OnPlayerChat( ply, text, team, dead )
	
	if( CLIENT and ply == LocalPlayer() and string.lower( text ) == string.lower( SW.ChatCommand ) ) then
		
		if( !table.HasValue( SW.MapBlacklist, string.lower( game.GetMap() ) ) ) then
			
			SW.CreateConfigWindow();
			return true;
			
		end
		
	end
	
end
hook.Add( "OnPlayerChat", "SW.OnPlayerChat", SW.OnPlayerChat );