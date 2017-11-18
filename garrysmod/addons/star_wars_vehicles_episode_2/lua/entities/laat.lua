
ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "fighter_base"
ENT.Type = "vehicle"

ENT.PrintName = "LAAT"
ENT.Author = "Liam0102"
ENT.Category = "Star Wars"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true;
ENT.AdminSpawnable = false;

ENT.EntModel = "models/ish/starwars/laat/laat_mk2.mdl"
ENT.Vehicle = "LAAT"
ENT.Allegiance = "Republic";

if SERVER then

ENT.FireSound = Sound("weapons/tie_shoot.wav");
ENT.NextUse = {Wings = CurTime(),Use = CurTime(),Fire = CurTime(),Doors = CurTime(),};
ENT.StartHealth = 7500;

AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
	local e = ents.Create("laat");
	e:SetPos(tr.HitPos + Vector(0,0,10));
	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw,0));
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Initialize()

	self:SetNWInt("Health",self.StartHealth);
	
	self.WeaponLocations = {
		Right = self:GetPos()+self:GetForward()*360+self:GetUp()*25+self:GetRight()*58,
		Left = self:GetPos()+self:GetForward()*360+self:GetUp()*25+self:GetRight()*-58,
	}
	self.WeaponsTable = {};
	self.BoostSpeed = 1750;
	self.ForwardSpeed = 1000;
	self.UpSpeed = 500;
	self.AccelSpeed = 7;
	self.CanBack = true;
	self.CanShoot = true;
	self.AlternateFire = true;
	self.FireGroup = {"Right","Left"}
	
	self.Cooldown = 2;
	self.Overheat = 0;
	self.Overheated = false;
	
	self.Bullet = CreateBulletStructure(70,"green");
	self.GunnerDamage = 1000000000
	self.GunnerRadius = 50
	
	self.LeftCockpit = nil
	self.RightCockpit = nil
	
	self.SeatPos = {
	
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5,self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-24, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-24, self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-45, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-45, self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-68, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-68, self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-90, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-90, self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-113, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-113, self:GetAngles()+Angle(0,180,0)},
		
		{self:GetPos()+self:GetUp()*31+self:GetRight()*-17.5+self:GetForward()*-135, self:GetAngles()},
		{self:GetPos()+self:GetUp()*31+self:GetRight()*17.5+self:GetForward()*-135, self:GetAngles()+Angle(0,180,0)},
	};
	
	self.GunnerSeatPos = {
		{self:GetPos()+self:GetUp()*34+self:GetForward()*52+self:GetRight()*122, self:GetAngles()+Angle(0,-115,0)},
		{self:GetPos()+self:GetUp()*34+self:GetForward()*55+self:GetRight()*-120, self:GetAngles()+Angle(0,-65,0)},
	}

	self.GunnerCockpitPos = {
		self:GetPos()+self:GetUp()*52.4+self:GetForward()*58+self:GetRight()*122,
		self:GetPos()+self:GetUp()*52.4+self:GetForward()*58+self:GetRight()*-122
	}
	
	self.GunnerSeats = {};
	self:SpawnGunnerSeats();
	
	self.LeftWeaponLocations = {
		self:GetPos()+self:GetUp()*52.4+self:GetForward()*95+self:GetRight()*-140,
	}
	
	self.RightWeaponLocations = {
		self:GetPos()+self:GetUp()*52.4+self:GetForward()*95+self:GetRight()*140,	
	}
	
	self:SpawnSeats();
	self.ExitModifier = {x=0,y=87.5,z=20};
	
	self.PilotVisible = true;
	self.PilotPosition = {x=0,y=210,z=130};

	self.HasLookaround = true;
	self.BaseClass.Initialize(self);
	
	// Set Bodygroups after loading base initialize, otherwise there's no model set to run the bodygroups on
	self:SetBodygroup(8,1);
	self:SetBodygroup(9,1);
	self:SetBodygroup(7,1);
	
	self.NextUse.RightFire = 0
	self.NextUse.LeftFire = 0
end

function ENT:SpawnGunnerSeats()
	
	for k,v in pairs(self.GunnerSeatPos) do
		local e = ents.Create("prop_vehicle_prisoner_pod");
		e:SetPos(v[1]);
		e:SetAngles(v[2]);
		e:SetParent(self);
		e:SetModel("models/nova/airboat_seat.mdl");
		e:SetRenderMode(RENDERMODE_TRANSALPHA);
		e:SetColor(Color(255,255,255,0));
		e:Spawn();
		e:Activate();
		e:SetThirdPersonMode(false);
		e:GetPhysicsObject():EnableMotion(false);
		e:GetPhysicsObject():EnableCollisions(false);
		e:SetUseType(ONOFF_USE);
		e.LaatGunnerSeat = true
		e.Ship = self
		self.GunnerSeats[k] = e;
		if(k == 1) then
			e.IsRight = true;
		end
		e.IsLaatGunnerSeat = true;
		e:DrawShadow( false )
	end
	for k,v in pairs(self.GunnerCockpitPos) do
		local prop = ents.Create( "mine_ever" )
		prop:SetParent(self)
		prop:SetPos(v)
		prop.ship = self
		prop:Spawn()
		if(k == 1) then
			prop.right = true;
			self.RightCockpit = prop
			self:SetNWEntity("RightGunner_Cockpit",prop)
		else
			self.LeftCockpit = prop
			self:SetNWEntity("LeftGunner_Cockpit",prop)
		end
		prop:DrawShadow( false )
	end
end

function ENT:GunnerEnter(p,right)
	if(self.Done == true)then return end
	if(p == self.Pilot) then return end;
	if(p == self.LeftGunner) then return end;
	if(p == self.RightGunner) then return end;
	if(self.NextUse.Use < CurTime()) then
		p.lastScale = p:GetModelScale()
		p:SetModelScale( 0.8, 0 )
		if(!right) then
			if(!IsValid(self.LeftGunner)) then
				p:SetNWBool("LeftGunner",true);
				self:SetNWEntity("LeftGunner_ENT",p)
				self.LeftGunner = p;
				p:EnterVehicle(self.GunnerSeats[2]);
			end
		else
			if(!IsValid(self.RightGunner)) then
				p:SetNWBool("RightGunner",true);
				self:SetNWEntity("RightGunner_ENT",p)
				self.RightGunner = p;
				p:EnterVehicle(self.GunnerSeats[1]);
			end
		end
		p:SetNWEntity(self.Vehicle,self);
		self.NextUse.Use = CurTime() + 1;
	end
end

hook.Add( "PlayerUse", "1Ever11125", function( activator, caller )
	if IsValid( activator ) and activator:IsPlayer() then
		if(caller.LaatGunnerSeat == true)then
			return false
		end
	end
end )

hook.Add("CanExitVehicle", "LaatCanExitVehicle", function(v,p)
	if(IsValid(p) and IsValid(v)) then
		if(v.Ship != nil) then 
			if(v.Ship.NextUse.Use < CurTime()) then
				return true
			else	
				return false
			end
		end
	end
end);

hook.Add("PlayerLeaveVehicle", "LaatSeatExit", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsLaatGunnerSeat) then
			local e = v:GetParent();
			e:GunnerExit(false or v.IsRight,p);
		else
			if(v.IsLAATSeat) then
				local e = v.LAAT;
				if(IsValid(e)) then
					if(v.LeftSide) then
						p:SetPos(e:GetPos()+e:GetRight()*65+e:GetUp()*20+e:GetForward()*(-40+math.random(-50,50)));
					elseif(v.RightSide) then
						p:SetPos(e:GetPos()+e:GetRight()*-65+e:GetUp()*20+e:GetForward()*(-40+math.random(-50,50)));
					end
				end
				p:SetNetworkedEntity("LAATSeat",NULL);
				p:SetNetworkedEntity("LAAT",NULL);
				p:SetNetworkedBool("LAATPassenger",false);			
			end
		end
	end
end);

hook.Add("PlayerEnteredVehicle","LAATSeatEnter", function(p,v)
	if(IsValid(v) and IsValid(p)) then
		if(v.IsLAATSeat) then
			if(v.LAAT.Done == true)then return end
			p:SetNetworkedEntity("LAATSeat",v);
			p:SetNetworkedEntity("LAAT",v:GetParent());
			p:SetNetworkedBool("LAATPassenger",true);
		end
	end
end);

function ENT:GunnerExit(right,p)

	local pos = nil
	if(!right) then
		if(IsValid(self.LeftGunner)) then
			self.LeftGunner:SetNWBool("LeftGunner",false);
			self:SetNWEntity("LeftGunner_ENT",nil)
			self.LeftGunner = NULL;
			pos = -self:GetForward()*15-self:GetRight()*110+self:GetUp()*10
		end
	else
		if(IsValid(self.RightGunner)) then
			self.RightGunner:SetNWBool("RightGunner",false);
			self:SetNWEntity("RightGunner_ENT",nil)
			self.RightGunner = NULL;
			pos = -self:GetForward()*15+self:GetRight()*110+self:GetUp()*10
		end
	end
	p:SetModelScale( p.lastScale, 0 )
	p:SetPos(self:GetPos()+pos);
	p:SetNWEntity(self.Vehicle,NULL);
	self.NextUse.Use = CurTime() + 1;
end

function ENT:FireLeft(angPos)

	if(self.NextUse.LeftFire < CurTime()) then
		self:SetNWBool("LAAT_LEFT_FIRE",true)
		self:fireIt("L")
		self.NextUse.LeftFire = CurTime()+0.2;
	end
end

function ENT:FireRight(angPos)

	if(self.NextUse.RightFire < CurTime()) then
		self:SetNWBool("LAAT_RIGHT_FIRE",true)
		self:fireIt("R")
		self.NextUse.RightFire = CurTime()+0.2;
	end
end

function ENT:fireIt(r)
	local startPos = 0
	local endPos = 0
	if(r=="R")then
		startPos = self.RightWeapons[1]:GetPos()
		endPos = self.RightGunner:GetAimVector():Angle():Forward()*10000
		self:SetNWBool("LAAT_RIGHT_FIRE_VECTOR",endPos)
	else
		startPos = self.LeftWeapons[1]:GetPos()
		endPos = self.LeftGunner:GetAimVector():Angle():Forward()*10000
		self:SetNWBool("LAAT_LEFT_FIRE_VECTOR",endPos)
	end
	
	local tr = util.QuickTrace( startPos, endPos, {self,self.RightCockpit,self.LeftCockpit} )
	util.Decal( "fadingscorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal );
	local fx = EffectData()
	fx:SetOrigin(tr.HitPos);
	fx:SetNormal(tr.HitNormal);
	util.Effect( "StunstickImpact", fx, true )
			
	
	if(r=="R")then
		util.BlastDamage( self, self.RightGunner or self, tr.HitPos, self.GunnerRadius, self.GunnerDamage)
	else
		util.BlastDamage( self, self.LeftGunner or self, tr.HitPos, self.GunnerRadius, self.GunnerDamage)
	end
			
	self:EmitSound(self.FireSound,100,math.random(80,120));
end

function ENT:SpawnWeapons()
	self.BaseClass.SpawnWeapons(self);
	self.LeftWeapons = {};
	self.RightWeapons = {};
	
	for k,v in pairs(self.LeftWeaponLocations) do
		local e = ents.Create("prop_physics");
		e:SetModel("models/props_junk/PopCan01a.mdl");
		e:SetPos(v);
		e:Spawn();
		e:Activate();
		e:SetRenderMode(RENDERMODE_TRANSALPHA);
		e:SetSolid(SOLID_NONE);
		e:AddFlags(FL_DONTTOUCH);
		e:SetColor(Color(255,255,255,0));
		e:SetParent(self);
		e:GetPhysicsObject():EnableMotion(false);
		self.LeftWeapons[k] = e;
		e:DrawShadow( false )
	end

	for k,v in pairs(self.RightWeaponLocations) do
		local e = ents.Create("prop_physics");
		e:SetModel("models/props_junk/PopCan01a.mdl");
		e:SetPos(v);
		e:Spawn();
		e:Activate();
		e:SetRenderMode(RENDERMODE_TRANSALPHA);
		e:SetSolid(SOLID_NONE);
		e:AddFlags(FL_DONTTOUCH);
		e:SetColor(Color(255,255,255,0));
		e:SetParent(self);
		e:GetPhysicsObject():EnableMotion(false);
		self.RightWeapons[k] = e;
		e:DrawShadow( false )
	end
end

function ENT:SpawnSeats()
	self.Seats = {};
	for k,v in pairs(self.SeatPos) do
		local e = ents.Create("prop_vehicle_prisoner_pod");
		e:SetPos(v[1]);
		e:SetAngles(v[2]);
		e:SetParent(self);		
		e:SetModel("models/nova/airboat_seat.mdl");
		e:SetRenderMode(RENDERMODE_TRANSALPHA);
		e:SetColor(Color(255,255,255,0));	
		e:Spawn();
		e:Activate();
		e:GetPhysicsObject():EnableMotion(false);
		e:GetPhysicsObject():EnableCollisions(false);
		e.IsLAATSeat = true;
		e.LAAT = self;
		
		if(k % 2 > 0) then
			e.RightSide = true;
		else
			e.LeftSide = true;
		end
		
		self.Seats[k] = e;
	end

end


function ENT:Use(p,vc)

	if(self.Done == true)then return end
	if(p == self.Pilot) then return end;

	self.UsePos = {
		self:GetPos()+self:GetForward()*65+self:GetRight()*-70+self:GetUp()*10,
		self:GetPos()+self:GetForward()*110+self:GetRight()*50+self:GetUp()*140,
	}
	for k,v in pairs(ents.FindInBox(self.UsePos[1],self.UsePos[2])) do
		if(v:IsPlayer() and v == p) then
			if(not self.Inflight) then
				self:Enter(p);
			end
		end
	end
end


function ENT:Think()

	self.BaseClass.Think(self);
	if(IsValid(self.LeftGunner)) then
		if(self.GunnerSeats[1]:GetThirdPersonMode()) then
			self.GunnerSeats[1]:SetThirdPersonMode(false);
		end
		if(self.LeftGunner:KeyDown(IN_ATTACK)) then
			self:FireLeft(self.LeftGunner:GetAimVector():Angle():Forward());
		end
	end
	
	if(IsValid(self.RightGunner)) then
		if(self.GunnerSeats[2]:GetThirdPersonMode()) then
			self.GunnerSeats[2]:SetThirdPersonMode(false);
		end
		if(self.RightGunner:KeyDown(IN_ATTACK)) then
			self:FireRight(self.RightGunner:GetAimVector():Angle():Forward());
		end
	end
	if(self.Inflight) then
		//self.AccelSpeed = math.Approach(self.AccelSpeed,7,0.2);
		if(IsValid(self.Pilot)) then
			if(IsValid(self.Pilot)) then // I don't know why I need this here for a second check but when I don't it causes an error
				if(self.Pilot:KeyDown(IN_RELOAD)) then
					self:ToggleDoors();
				end
			end
			
		end
	end	

	if(self.NextUse.LeftFire+0.05 < CurTime()) then
		self:SetNWBool("LAAT_LEFT_FIRE",false)
	end
	
	if(self.NextUse.RightFire+0.05 < CurTime()) then
		self:SetNWBool("LAAT_RIGHT_FIRE",false)
	end
	
end

function ENT:ToggleDoors()

	if(self.NextUse.Doors < CurTime()) then
		if(self.Door) then
			self:SetBodygroup(8,1);
			self.Door = false;
		else
			self:SetBodygroup(8,3);
			self.Door = true;
		end
		self.NextUse.Doors = CurTime() + 1;
	end
end

function ENT:PhysicsSimulate(phys,d)
	self.BaseClass.PhysicsSimulate(self,phys,d);
	if(self.Inflight) then
		self.Pilot:SetPos(self:GetPos()+self:GetForward()*87.5+self:GetRight()*30+self:GetUp()*20);
		self.Pilot:SetAngles(self:GetAngles());
	end
end

function ENT:Enter(p)
	if(self.Done == true)then return end
	self:SetBodygroup(9,0);
	self.BaseClass.Enter(self,p);
	
end

function ENT:Exit()

	self:SetBodygroup(9,1);
	self.BaseClass.Exit(self);
	
end


end

if CLIENT then

	ENT.EnginePos = {}
	ENT.Sounds={
		//Engine=Sound("ambient/atmosphere/ambience_base.wav"),
		Engine=Sound("vehicles/laat/laat_fly2.wav"),
	}
	ENT.CanFPV = true;

	hook.Add("ScoreboardShow","LAATScoreDisable", function()
		local p = LocalPlayer();	
		local Flying = p:GetNWBool("FlyingLAAT");
		if(Flying) then
			return false;
		end
	end)
	
	//"ambient/atmosphere/ambience_base.wav"
	local View = {}
	local function CalcView()
		
		local p = LocalPlayer();	
		local Flying = p:GetNWBool("FlyingLAAT");
		local Sitting = p:GetNWBool("LAATPassenger");
		local pos, face;
		local self = p:GetNWEntity("LAAT");
	
		
		if(Flying) then
			if(IsValid(self)) then
				local fpvPos = self:GetPos()+self:GetUp()*155+self:GetForward()*210;
				View = SWVehicleView(self,950,400,fpvPos,true);		
				return View;
			end
		elseif(Sitting) then
			local v = p:GetNWEntity("LAATSeat");	
			if(IsValid(v)) then
				if(v:GetThirdPersonMode()) then
					View = SWVehicleView(self,800,350,fpvPos);		
					return View;
				end
			end
		end
		
	end
	hook.Add("CalcView", "LAATView", CalcView)
	
	local MaterialMain			= Material( "effects/sw_laser_green_main" );
	local MaterialFront			= Material( "effects/sw_laser_green_front" );

	hook.Add("PostDrawTranslucentRenderables","Ever_PostDrawTranslucentRenderables", function()
		for k,v in pairs (ents.FindByClass( "laat" ))do
			if(v:GetNWBool("LAAT_LEFT_FIRE") == true)then
				local WeaponsPos = v:GetPos()+v:GetUp()*52.4+v:GetForward()*95+v:GetRight()*-140
				local gunner = v:GetNWEntity("LeftGunner_ENT")
				local cock = v:GetNWEntity("LeftGunner_Cockpit")
				DrawGreenBeam(WeaponsPos,gunner,v,cock)
			end
		
			if(v:GetNWBool("LAAT_RIGHT_FIRE") == true)then
				local WeaponsPos = v:GetPos()+v:GetUp()*52.4+v:GetForward()*95+v:GetRight()*140
				local gunner = v:GetNWEntity("RightGunner_ENT")
				local cock = v:GetNWEntity("RightGunner_Cockpit")
				DrawGreenBeam(WeaponsPos,gunner,cock)
			end
		end
		
	end)
	
	function DrawGreenBeam(startPos,gunner,filt,cock)
		local tr = util.QuickTrace( startPos, gunner:GetAimVector():Angle():Forward()*10000, {filt,cock})
		--debugoverlay.Sphere( startPos, 5, 0.01, Color( 255, 255, 255 ), true )
		--debugoverlay.Sphere( tr.HitPos, 5, 0.01, Color( 255, 0, 0 ), true )
		local endPos2 = tr.HitPos;
		
		render.SetMaterial( MaterialFront );
		render.DrawSprite( startPos, 32*2, 24*2, Color(255,255,255) );
		
		render.SetMaterial( MaterialFront );
		render.DrawSprite( endPos2, 32*3, 24*3, Color(255,255,255) );

		render.SetMaterial( MaterialMain );
		render.DrawBeam( startPos, endPos2, 25, 1, 1, Color(255,255,255) );
	end
	
	hook.Add( "ShouldDrawLocalPlayer", "LAATDrawPlayerModel", function( p )
		local self = p:GetNWEntity("LAAT", NULL);
		local PassengerSeat = p:GetNWEntity("LAATSeat",NULL);
		if(IsValid(self)) then
			if(IsValid(PassengerSeat)) then
				if(PassengerSeat:GetThirdPersonMode()) then
					return true;
				end
			end
		end
	end);
	
	function LAATReticle()
		
		
		local p = LocalPlayer();
		local Flying = p:GetNWBool("FlyingLAAT");
		local self = p:GetNWEntity("LAAT");
		local LeftGunner = p:GetNWBool("LeftGunner");
		local RightGunner = p:GetNWBool("RightGunner");
		
		if(Flying and IsValid(self)) then
			SW_HUD_DrawHull(5000);
			SW_WeaponReticles(self);
			SW_HUD_DrawOverheating(self);
			
			local pos = self:GetPos()+self:GetForward()*240+self:GetUp()*147.5;
			local x,y = SW_XYIn3D(pos);
			
			SW_HUD_Compass(self,x,y);
			SW_HUD_DrawSpeedometer();
		elseif(LeftGunner and IsValid(self)) then
			local WeaponsPos = self:GetPos()+self:GetUp()*50+self:GetForward()*95+self:GetRight()*-140
			
				local tr = util.TraceLine( {
					start = WeaponsPos,
					endpos = WeaponsPos + p:GetAimVector():Angle():Forward()*10000,
				} )

				surface.SetTextColor( 255, 255, 255, 255 );
				
				local vpos = tr.HitPos;
				
				local screen = vpos:ToScreen();
				
				surface.SetFont( "HUD_Crosshair" );	
				local tsW, tsH = surface.GetTextSize("+");
				
				local x,y;
				for k,v in pairs(screen) do
					if k=="x" then
						x = v - tsW/2;
					elseif k=="y" then
						y = v - tsH/2;
					end
				end
				
							
				surface.SetTextPos( x, y );
				surface.DrawText( "+" );
		elseif(RightGunner and IsValid(self)) then
			local WeaponsPos = self:GetPos()+self:GetUp()*50+self:GetForward()*95+self:GetRight()*140
			
				local tr = util.TraceLine( {
					start = WeaponsPos,
					endpos = WeaponsPos + p:GetAimVector():Angle():Forward()*10000,
				} )

				surface.SetTextColor( 255, 255, 255, 255 );
				
				local vpos = tr.HitPos;
				
				local screen = vpos:ToScreen();
				
				surface.SetFont( "HUD_Crosshair" );	
				local tsW, tsH = surface.GetTextSize("+");
				
				local x,y;
				for k,v in pairs(screen) do
					if k=="x" then
						x = v - tsW/2;
					elseif k=="y" then
						y = v - tsH/2;
					end
				end
				
							
				surface.SetTextPos( x, y );
				surface.DrawText( "+" );
	end
	end
	hook.Add("HUDPaint", "LAATReticle", LAATReticle)

end
