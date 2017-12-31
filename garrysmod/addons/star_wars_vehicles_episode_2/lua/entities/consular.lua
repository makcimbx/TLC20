//HOW TO PROPERLY MAKE AN ADDITIONAL SHIP ADDON OFF OF MINE.
 
//Do not copy everything out of my addon. You don't need it. Shall explain later.
 
//Leave this stuff the same
ENT.RenderGroup = RENDERGROUP_OPAQUE;
ENT.Base = "fighter_base";
ENT.Type = "vehicle";
 
//Edit appropriatly. I'd prefer it if you left my name (Since I made the base, and this ConsularC)
ENT.PrintName = "Consular-class Cruiser";
ENT.Author = "Liam0102";
 
// Leave the same
ENT.Category = "Star Wars"; // Techincally you could change this, but personally I'd leave it so they're all in the same place (Looks more proffesional).
ENT.AutomaticFrameAdvance = true;
ENT.Spawnable = true;
ENT.AdminSpawnable = false;
ENT.AdminOnly = true; //Set to true for an Admin vehicle.
 
ENT.EntModel = "models/consular_c/syphadias/consular_c_m.mdl" //The oath to the model you want to use.
ENT.Vehicle = "ConsularC" //The internal name for the ship. It cannot be the same as a different ship.
ENT.StartHealth = 35000; //How much health they should have.
ENT.Allegiance = "Republic";

if SERVER then
 
ENT.FireSound = Sound("weapons/xwing_shoot.wav"); // The sound to make when firing the weapons. You do not need the sounds folder at the start
ENT.NextUse = {Wings = CurTime(),Use = CurTime(),Fire = CurTime(),LightSpeed=CurTime(),Switch=CurTime(),}; //Leave this alone for the most part.
ENT.HyperDriveSound = Sound("vehicles/hyperdrive.mp3");
 
AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
    local e = ents.Create("consular"); // This should be the same name as the file
    local spawn_height = 20; // How high above the ground the vehicle spawns. Change if it's spawning too high, or spawning in the ground.
   
    e:SetPos(tr.HitPos + Vector(0,0,spawn_height));
    e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw,0));
    e:Spawn();
    e:Activate();
    return e;
end
 
function ENT:Initialize()
 
 
    self:SetNWInt("Health",self.StartHealth); // Set the ship health, to the start health as made earlier
   
    //The locations of the weapons (Where we shoot out of), local to the ship. These largely just take a lot of tinkering.
    self.WeaponLocations = {
        Right = self:GetPos() + self:GetForward() * -30 + self:GetRight() * 432 + self:GetUp() * -17.25,
        TopRight = self:GetPos() + self:GetForward() * -30 + self:GetRight() * 432 + self:GetUp() * -17.25,
        TopLeft = self:GetPos() + self:GetForward() * -30 + self:GetRight() * -432 + self:GetUp() * -17.25,
        Left = self:GetPos() + self:GetForward() * -30 + self:GetRight() * -432 + self:GetUp() * -17.25,
    }
    self.WeaponsTable = {}; // IGNORE. Needed to give players their weapons back
    self.BoostSpeed = 2500; // The speed we go when holding SHIFT
    self.ForwardSpeed = 1500; // The forward speed
    self.UpSpeed = 600; // Up/Down Speed
    self.AccelSpeed = 8; // How fast we get to our previously set speeds
    self.CanBack = true; // Can we move backwards? Set to true if you want this.
    self.CanRoll = false; // Set to true if you want the ship to roll, false if not
    self.CanStrafe = true; // Set to true if you want the ship to strafe, false if not. You cannot have roll and strafe at the same time
    self.CanStandby = true; // Set to true if you want the ship to hover when not inflight
    self.CanShoot = false; // Set to true if you want the ship to be able to shoot, false if not
   
    self.AlternateFire = false // Set this to true if you want weapons to fire in sequence (You'll need to set the firegroups below)
    self.FireGroup = {"Left","Right","TopLeft","TopRight"} // In this example, the weapon positions set above will fire with Left and TopLeft at the same time. And Right and TopRight at the same time.
    self.OverheatAmount = 50 //The amount a ship can fire consecutively without overheating. 50 is standard.
    self.DontOverheat = false; // Set this to true if you don't want the weapons to ever overheat. Mostly only appropriate on Admin vehicles.
    self.MaxIonShots = 20; // The amount of Ion shots a vehicle can take before being disabled. 20 is the default.
	self.LandDistance = 800;
   
    self.LandOffset = Vector(0,0,0); // Change the last 0 if you're vehicle is having trouble landing properly. (Make it larger)
    self:SpawnInterior();
    self:SpawnMisc();
	
	self.OGForward = 1500;
	self.OGBoost = 2500;
	self.OGUp = 600;
	
	self.WarpDestination = Vector(0,0,0);
	
	if(WireLib) then
		Wire_CreateInputs(self, { "Destination [VECTOR]", })
	else
		self.DistanceMode = true;
	end
	self.ExitModifier = {x=300,y=0,z=20}; 
	self.SeatPos = {
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*-50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*-100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-350+self:GetUp()*200+self:GetRight()*-150,self:GetAngles()},
		
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*150,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*-50,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*-100,self:GetAngles()},
		{self:GetPos()+self:GetForward()*-450+self:GetUp()*200+self:GetRight()*-150,self:GetAngles()},
	}
	self:SpawnSeats();
	
    self.Bullet = CreateBulletStructure(60,"red",false); // The first number is bullet damage, the second colour. green and red are the only options. (Set to blue for ion shot, the damage will be halved but ships will be disabled after consecutive hits). The final one is for splash damage. Set to true if you don't want splashdamage.
   
    self.BaseClass.Initialize(self); // Ignore, needed to work

end
 
function ENT:SpawnInterior()
 
    local e = ents.Create("prop_dynamic");
    e:SetModel("models/consular_c/syphadias/consular_c_f.mdl");
    e:SetPos(self:GetPos());
    e:SetAngles(self:GetAngles());
    e:Spawn();
    e:Activate();
    e:SetParent(self);
    //e:GetPhysicsObject():EnableCollisions(false);
    self.Interior = e;
   
end
 
function ENT:SpawnMisc()
 
    local e = ents.Create("prop_dynamic");
    e:SetModel("models/consular_c/syphadias/consular_c_b.mdl");
    e:SetPos(self:GetPos());
    e:SetAngles(self:GetAngles());
    e:Spawn();
    e:Activate();
    e:SetParent(self);
    //e:GetPhysicsObject():EnableCollisions(false);
    self.Misc = e;
   
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
		e.IsConsularSeat = true;
		e.Consular = self;

		self.Seats[k] = e;
	end

end

hook.Add("PlayerEnteredVehicle","ConsularSeatEnter", function(p,v)
	if(IsValid(v) and IsValid(p)) then
		if(v.IsConsularSeat) then
			p:SetNetworkedEntity("ConsularC",v:GetParent());
		end
	end
end);

hook.Add("PlayerLeaveVehicle", "ConsularSeatExit", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsConsularSeat) then
			local e = v.Consular;
			if(IsValid(e)) then
				p:SetPos(e:GetPos() + e:GetRight()*e.ExitModifier.x + e:GetForward() * e.ExitModifier.y + e:GetUp() * e.ExitModifier.z);
			end
			p:SetNetworkedEntity("ConsularC",NULL);
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
			
			local fx = EffectData()
				fx:SetOrigin(self:GetPos())
				fx:SetEntity(self.Interior)
			util.Effect("propspawn",fx)
			
			local fx = EffectData()
				fx:SetOrigin(self:GetPos())
				fx:SetEntity(self.Misc)
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
 
    ENT.CanFPV = false; // Set to true if you want FPV
    ENT.EnginePos = {}
    ENT.Sounds={
        //Engine=Sound("ambient/atmosphere/ambience_base.wav"),
		Engine=Sound("vehicles/mf/mf_fly5.wav"),
    }
 
	local LightSpeed = 0;
	function ENT:Think()
		self.BaseClass.Think(self);
		
		local p = LocalPlayer();
		local Flying = self:GetNWBool("Flying".. self.Vehicle);
		local IsFlying = p:GetNWBool("Flying"..self.Vehicle);
		local TakeOff = self:GetNWBool("TakeOff");
		local Land = self:GetNWBool("Land");
		
		if(Flying) then
			if(!TakeOff and !Land) then
				self:FlightEffects();
			end
			LightSpeed = self:GetNWInt("LightSpeed");
		end

	end
	
	function ENT:FlightEffects()
		self.EnginePos = {
			self:GetPos()+self:GetForward()*-880+self:GetUp()*190,
			self:GetPos()+self:GetForward()*-880+self:GetUp()*190+self:GetRight()*-435,
			self:GetPos()+self:GetForward()*-880+self:GetUp()*190+self:GetRight()*435,
		}
		local normal = (self:GetForward() * -1):GetNormalized()
		local roll = math.Rand(-90,90)
		local p = LocalPlayer()		
		local FWD = self:GetForward();
		local id = self:EntIndex();
		
		for k,v in pairs(self.EnginePos) do
				
			local blue = self.FXEmitter:Add("sprites/bluecore",v)
			blue:SetVelocity(normal)
			blue:SetDieTime(0.03)
			blue:SetStartAlpha(255)
			blue:SetEndAlpha(255)
			blue:SetStartSize(180)
			blue:SetEndSize(100)
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
 
    //This is where we set how the player sees the ship when flying
	local View = {}
	local lastpos, lastang;
	local function CalcView()
		
		local p = LocalPlayer();
		local self = p:GetNWEntity("ConsularC")
		local pos,face;
		if(IsValid(self)) then
			
			if(LightSpeed == 2) then
				pos = lastpos;
				face = lastang;

				View.origin = pos;
				View.angles = face;
			else
				pos = self:GetPos()+self:GetUp()*700+LocalPlayer():GetAimVector():GetNormal()*-2000;			
				face = ((self:GetPos() + Vector(0,0,100))- pos):Angle()
				View =  SWVehicleView(self,2000,700,fpvPos);
			end
			
			lastpos = pos;
			lastang = face;
			
			return View;
		end
	end
    hook.Add("CalcView", "ConsularCView", CalcView) // This is very important. Make sure the middle arguement is unique. In this case the ship name + view
 
    local function ConsularCReticle() //Make this unique. Again Ship name + Reticle
       
        local p = LocalPlayer();
        local Flying = p:GetNWBool("FlyingConsularC");
        local self = p:GetNWEntity("ConsularC");
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
    hook.Add("HUDPaint", "ConsularCReticle", ConsularCReticle) // Here you need to make the middle argument something unique again. I've set it as what the function is called. Could be anything. And the final arguement should be the function just made.
 
end
 
/*
Put this file in lua/entities/
Then package up the addon like normal and upload.
Now you need to set your addon on the upload page, to require my addon.
This way the only thing in your addon is the unique files, and should I make any changes to fighter_base and the sounds etc. you'll get those changes.
 
Make sure this is the only file in lua/entities/
 
*/