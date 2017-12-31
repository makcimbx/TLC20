ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Type = "vehicle"
ENT.Base = "fighter_base"

ENT.PrintName = "Blockade Runner"
ENT.Author = "Liam0102"
ENT.Category = "Star Wars"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true;
ENT.AdminSpawnable = true;
ENT.AdminOnly = true;

ENT.EntModel = "models/blockrun/blockaderunner.mdl"
ENT.Vehicle = "Blockade"
ENT.StartHealth = 30000;
ENT.Allegiance = "Rebels";

if SERVER then

ENT.FireSound = Sound("vehicles/mf/mf_shoot2.wav");
ENT.NextUse = {Wings = CurTime(),Use = CurTime(),Fire = CurTime(),FireMode = CurTime(),LightSpeed=CurTime(),Switch=CurTime(),};
ENT.HyperDriveSound = Sound("vehicles/hyperdrive.mp3");

AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
	local e = ents.Create("blockade");
	e:SetPos(tr.HitPos + Vector(0,0,10));
	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw,0));
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Initialize()
	
	self:SetNWInt("Health",self.StartHealth);
	self:SetNWInt("LightSpeed",0);
	self.CanRoll = false;
	self.CanStrafe = true;
	self.CanBack = true;
	self.CanStandby = true;

	self.WeaponsTable = {};
	//self:SpawnWeapons();
	self.BoostSpeed = 2500;
	self.ForwardSpeed = 1000;
	self.UpSpeed = 600;
	self.AccelSpeed = 8;
	
	self.OGForward = 1000;
	self.OGBoost = 2500;
	self.OGUp = 600;
	
	self.WarpDestination = Vector(0,0,0);
	
	self.Bullet = CreateBulletStructure(300,"red");
	self.WeaponLocations = {}
	if(WireLib) then
		Wire_CreateInputs(self, { "Destination [VECTOR]", })
	else
		self.DistanceMode = true;
	end
	self.PilotOffset = {x=0,y=200,z=200};
	self.ExitModifier = {x=300,y=0,z=20}; 
	//self:SetModelScale(5);
	self.BaseClass.Initialize(self)
	
	
	self.SeatPos = {
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*-50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*-100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*150+self:GetRight()*-150,self:GetAngles()},
		
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*-50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*-100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*150+self:GetRight()*-150,self:GetAngles()},
	}
	self:SpawnSeats();

end

function ENT:SpawnSeats()
	self.Seats = {};
	for k,v in pairs(self.SeatPos) do
		local e = ents.Create("prop_vehicle_prisoner_pod");
		e:SetPos(v[1]);
		e:SetAngles(v[2]+Angle(0,-90,0));
		e:SetParent(self);		
		e:SetModel("models/nova/airboat_seat.mdl");
		e:SetRenderMode(RENDERMODE_TRANSALPHA);
		e:SetColor(Color(255,255,255,0));	
		e:Spawn();
		e:Activate();
		e:SetUseType(USE_OFF);
		e:GetPhysicsObject():EnableMotion(false);
		e:GetPhysicsObject():EnableCollisions(false);
		e.IsBlockadeSeat = true;
		e.Blockade = self;

		self.Seats[k] = e;
	end

end

hook.Add("PlayerEnteredVehicle","BlockadeSeatEnter", function(p,v)
	if(IsValid(v) and IsValid(p)) then
		if(v.IsBlockadeSeat) then
			p:SetNetworkedEntity("Blockade",v:GetParent());
		end
	end
end);

hook.Add("PlayerLeaveVehicle", "BlockadeSeatExit", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsBlockadeSeat) then
			local e = v.Blockade;
			if(IsValid(e)) then
				p:SetPos(e:GetPos() + e:GetRight()*e.ExitModifier.x + e:GetForward() * e.ExitModifier.y + e:GetUp() * e.ExitModifier.z);
			end
			p:SetNetworkedEntity("Blockade",NULL);
		end
	end
end);

function ENT:Passenger(p)
	if(self.NextUse.Use > CurTime()) then return end;
	for k,v in pairs(self.Seats) do
		if(v:GetPassenger(1) == NULL) then
			p:EnterVehicle(v);
			return;			
		end
	end
end

function ENT:Use(p)
	if(not self.Inflight) then
		if(!p:KeyDown(IN_WALK)) then
			self:Enter(p);
		else
			self:Passenger(p);
		end
	else
		if(p != self.Pilot) then
			self:Passenger(p);
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self);
	if(self.Inflight) then
		if(IsValid(self.Pilot)) then
		
			if(self.Pilot:KeyDown(IN_WALK) and self.NextUse.LightSpeed < CurTime()) then
				if(!self.LightSpeed and !self.HyperdriveDisabled) then
					self.LightSpeed = true;
					self.LightSpeedTimer = CurTime() + 3;
					self.NextUse.LightSpeed = CurTime() + 20;
					
				end
			end
			
			if(WireLib) then
				if(self.Pilot:KeyDown(IN_RELOAD) and self.NextUse.Switch < CurTime()) then
					if(!self.DistanceMode) then
						self.DistanceMode = true;
						self.Pilot:ChatPrint("LightSpeed Mode: Distance");
					else
						self.DistanceMode = false;
						self.Pilot:ChatPrint("LightSpeed Mode: Destination");
					end
					self.NextUse.Switch = CurTime() + 1;
				end
			end
			
		end
		if(self.LightSpeed) then
			if(self.DistanceMode) then
				self:PunchingIt(self:GetPos()+self:GetForward()*20000);
			else
				self:PunchingIt(self.WarpDestination);
			end
		end
	end

end

function ENT:PunchingIt(Dest)
	if(!self.PunchIt) then
		if(self.LightSpeedTimer > CurTime()) then
			self.ForwardSpeed = 0;
			self.BoostSpeed = 0;
			self.UpSpeed = 0;
			self.Accel.FWD = 0;
			self:SetNWInt("LightSpeed",1);
			if(!self.PlayedSound) then
				self:EmitSound(self.HyperDriveSound,100);
				self.PlayedSound = true;
			end
			//util.ScreenShake(self:GetPos()+self:GetForward()*-730+self:GetUp()*195+self:GetRight()*3,5,5,10,5000)
		else
			self.Accel.FWD = 4000;
			self.LightSpeedWarp = CurTime()+0.5;
			self.PunchIt = true;
			self:SetNWInt("LightSpeed",2);
		end
	
	else
		if(self.LightSpeedWarp < CurTime()) then
			
			self.LightSpeed = false;
			self.PunchIt = false;
			self.ForwardSpeed = self.OGForward;
			self.BoostSpeed = self.OGBoost;
			self.UpSpeed = self.OGUp;
			self:SetNWInt("LightSpeed",0);
			local fx = EffectData()
				fx:SetOrigin(self:GetPos())
				fx:SetEntity(self)
			util.Effect("propspawn",fx)
			self:EmitSound("ambient/levels/citadel/weapon_disintegrate2.wav", 500)
			self:SetPos(Dest);
			self.PlayedSound = false;
		end
	end
end

function ENT:TriggerInput(k,v)
	if(k == "Destination") then
		self.WarpDestination = v;
	end
end

end

if CLIENT then

	function ENT:Draw() self:DrawModel() end
	
	ENT.EnginePos = {}
	ENT.Sounds={
		Engine=Sound("vehicles/mf/mf_fly5.wav"),
	}
	
	local Health = 0;
	ENT.NextView = CurTime();
	local LightSpeed = 0;
	function ENT:Think()
		self.BaseClass.Think(self);
		
		local p = LocalPlayer();
		local Flying = self:GetNWBool("Flying".. self.Vehicle);
		local IsFlying = p:GetNWBool("Flying"..self.Vehicle);
		local Wings = self:GetNWBool("Wings");
		local TakeOff = self:GetNWBool("TakeOff");
		local Land = self:GetNWBool("Land");
		
		if(Flying) then
			if(!TakeOff and !Land) then
				self:FlightEffects();
			end
			Health = self:GetNWInt("Health");
			LightSpeed = self:GetNWInt("LightSpeed");
		end

	end
	
	//"ambient/atmosphere/ambience_base.wav"
	local View = {}
	local lastpos, lastang;
	local function CalcView()
		
		local p = LocalPlayer();
		local self = p:GetNWEntity("Blockade")
		local pos,face;
		if(IsValid(self)) then
			
			if(LightSpeed == 2) then
				pos = lastpos;
				face = lastang;

				View.origin = pos;
				View.angles = face;
			else
				pos = self:GetPos()+self:GetUp()*650+LocalPlayer():GetAimVector():GetNormal()*-1500;			
				face = ((self:GetPos() + Vector(0,0,100))- pos):Angle()
				View =  SWVehicleView(self,1500,650,fpvPos);
			end
			
			lastpos = pos;
			lastang = face;
			
			return View;
		end
	end
	hook.Add("CalcView", "BlockadeView", CalcView)
	
	function ENT:FlightEffects()
		local normal = (self:GetForward() * -1):GetNormalized()
		local roll = math.Rand(-90,90)
		local p = LocalPlayer()		
		local FWD = self:GetForward();
		local id = self:EntIndex();
		
		self.EnginePos = {
			self:GetPos()+self:GetForward()*-730+self:GetUp()*195+self:GetRight()*3,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*195+self:GetRight()*147,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*195+self:GetRight()*-142,
			
			self:GetPos()+self:GetForward()*-730+self:GetUp()*315+self:GetRight()*-212,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*315+self:GetRight()*-67,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*315+self:GetRight()*67,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*315+self:GetRight()*212,
			
			self:GetPos()+self:GetForward()*-730+self:GetUp()*70+self:GetRight()*-212,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*70+self:GetRight()*-67,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*70+self:GetRight()*67,
			self:GetPos()+self:GetForward()*-730+self:GetUp()*70+self:GetRight()*212,

		}
		for k,v in pairs(self.EnginePos) do
				
			local blue = self.FXEmitter:Add("sprites/bluecore",v)
			blue:SetVelocity(normal)
			blue:SetDieTime(0.03)
			blue:SetStartAlpha(255)
			blue:SetEndAlpha(255)
			blue:SetStartSize(80)
			blue:SetEndSize(30)
			blue:SetRoll(roll)
			blue:SetColor(255,255,255)
			
			local dynlight = DynamicLight(id + 4096 * k);
			dynlight.Pos = v;
			dynlight.Brightness = 5;
			dynlight.Size = 250;
			dynlight.Decay = 1024;
			dynlight.R = 100;
			dynlight.G = 100;
			dynlight.B = 255;
			dynlight.DieTime = CurTime()+1;
			
		end
	
	end
	
	function BlockadeReticle()
		
		local p = LocalPlayer();
		local Flying = p:GetNWBool("FlyingBlockade");
		local self = p:GetNWEntity("Blockade");
		
		if(Flying and IsValid(self)) then
			SW_HUD_DrawHull(6000);
			SW_HUD_Compass(self);
			SW_HUD_DrawSpeedometer();
		end
		
		if(IsValid(self)) then
			
			if(LightSpeed == 2) then
				DrawMotionBlur( 0.4, 20, 0.01 );
			end
		end
	end
	hook.Add("HUDPaint", "BlockadeReticle", BlockadeReticle)

end