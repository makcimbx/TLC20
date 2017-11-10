ENT.RenderGroup = RENDERGROUP_OPAQUE
ENT.Base = "fighter_base"
ENT.Type = "vehicle"

ENT.PrintName = "Lambda-class Shuttle"
ENT.Author = "Liam0102"
ENT.Category = "Star Wars"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = true;
ENT.AdminSpawnable = false;

ENT.EntModel = "models/starwars/lordtrilobite/ships/lambda_shuttle/lambda_shuttle_landed.mdl"
ENT.Vehicle = "LambdaShuttle"
ENT.StartHealth = 15000;
ENT.Allegiance = "Empire";

ENT.WingsModel = "models/starwars/lordtrilobite/ships/lambda_shuttle/lambda_shuttle_fly_down.mdl"
ENT.ClosedModel = "models/starwars/lordtrilobite/ships/lambda_shuttle/lambda_shuttle_fly_up.mdl"

if SERVER then

ENT.FireSound = Sound("weapons/tie_shoot.wav");
ENT.NextUse = {Wings = CurTime(),Use = CurTime(),Fire = CurTime(),LightSpeed=CurTime(),Switch=CurTime(),};
ENT.HyperDriveSound = Sound("vehicles/hyperdrive.mp3");

AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
	local e = ents.Create("lambda");
	e:SetPos(tr.HitPos + Vector(0,0,0));
	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw+180,0));
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Initialize()

	self:SetNWInt("Health",self.StartHealth);
	
	self.WeaponLocations = {
        RightR = self:GetPos()+self:GetForward()*217.5+self:GetUp()*160+self:GetRight()*242.5,
        LeftL = self:GetPos()+self:GetForward()*217.5+self:GetUp()*160+self:GetRight()*-242.5,
        RightL = self:GetPos()+self:GetForward()*217.5+self:GetUp()*160+self:GetRight()*230,
        LeftR = self:GetPos()+self:GetForward()*217.5+self:GetUp()*160+self:GetRight()*-230,
            
        WingRightR = self:GetPos()+self:GetForward()*217.5+self:GetUp()*102.5+self:GetRight()*253.5,
        WingRightL = self:GetPos()+self:GetForward()*217.5+self:GetUp()*102.5+self:GetRight()*220,
        WingLeftL = self:GetPos()+self:GetForward()*217.5+self:GetUp()*102.5+self:GetRight()*-253.5,
        WingLeftR = self:GetPos()+self:GetForward()*217.5+self:GetUp()*102.5+self:GetRight()*-220,
            
	}
	self.WeaponsTable = {};
	self.BoostSpeed = 2500;
	self.ForwardSpeed = 1000;
	self.UpSpeed = 600;
	self.AccelSpeed = 7;
	self.CanStandby = false;
	self.CanBack = true;
	self.CanRoll = false;
	self.CanStrafe = true;
	self.Cooldown = 2;
	self.CanShoot = true;
	self.Bullet = CreateBulletStructure(65,"green");
	self.FireDelay = 0.2;
	self.AlternateFire = true;
	self.FireGroup = {"RightR","RightL","LeftL","LeftR"};
	self.HasWings = true;
	self.WarpDestination = Vector(0,0,0);
	if(WireLib) then
		Wire_CreateInputs(self, { "Destination [VECTOR]", })
	else
		self.DistanceMode = true;
	end
    self.CanEject = false;
        		
	self.OGBoost = 2500;
	self.OGForward = 1000;
	self.OGUp = 600;
	
	self.ExitModifier = {x=0,y=250,z=180};
	self.PilotOffset = {x=0,y=250,z=180};

    self.PilotVisible = true;
    self.PilotPosition = {x=-35,y=325,z=190}
	self.SeatPos = {
        FrontR = {self:GetPos()+self:GetForward()*320+self:GetRight()*35+self:GetUp()*182.5,self:GetAngles()},
        BackL = {self:GetPos()+self:GetForward()*277.5+self:GetRight()*-50+self:GetUp()*190,self:GetAngles()},
        BackR = {self:GetPos()+self:GetForward()*277.5+self:GetRight()*50+self:GetUp()*190,self:GetAngles()},
            
		{self:GetPos()+self:GetForward()*17.5+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*47.5+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*75+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*105+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*135+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*162.5+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
		{self:GetPos()+self:GetForward()*192.5+self:GetUp()*202.5+self:GetRight()*60,self:GetAngles()+Angle(0,90,0)},
            
		{self:GetPos()+self:GetForward()*17.5+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*47.5+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*75+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*105+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*135+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*162.5+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
		{self:GetPos()+self:GetForward()*192.5+self:GetUp()*202.5+self:GetRight()*-60,self:GetAngles()+Angle(0,-90,0)},
	}
	self:SpawnSeats();
	self.HasLookaround = true;
	self.BaseClass.Initialize(self);
    self:SetSkin(1);
    for k,v in pairs(self.Weapons) do
        if(k == "WingLeft" or k == "WingRight") then
            v.Disabled = true;
        end
    end
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
		e.IsLambdaShuttleSeat = true;
		e.Lambda = self;
        if(k == "FrontR" or k == "BackL" or k == "BackR") then
            e.LambdaFrontSeat = true;
        end
		self.Seats[k] = e;
	end

end
    
function ENT:Enter(p)
    if(!IsValid(self.Pilot)) then
        self:SetModel(self.ClosedModel);
        self:PhysicsInit(SOLID_VPHYSICS);
        self:SkinSwitch(true);
        if(IsValid(self:GetPhysicsObject())) then
            self:GetPhysicsObject():EnableMotion(true);
            self:GetPhysicsObject():Wake();
        end
        self:StartMotionController();
    end
    self.BaseClass.Enter(self,p);
end
    
function ENT:Exit(kill)
    local p = self.Pilot;
    self.BaseClass.Exit(self,kill);
    if(self.Land or self.TakeOff) then
        self:SetModel(self.EntModel);
        self:PhysicsInit(SOLID_VPHYSICS);
        if(IsValid(self:GetPhysicsObject())) then
            self:GetPhysicsObject():EnableMotion(true);
            self:GetPhysicsObject():Wake();
        end
        self:StartMotionController();
        if(IsValid(p)) then
            p:SetEyeAngles(self:GetAngles()+Angle(0,180,0));
        end
    end
    self:SkinSwitch(false);
end
    
function ENT:SkinSwitch(b)
    if(b) then
        if(self.VehicleHealth <= self.StartHealth/2) then
            self:SetSkin(2);
        else
            self:SetSkin(0);
        end
    else
        if(self.VehicleHealth <= self.StartHealth/2) then
            self:SetSkin(3);
        else
            self:SetSkin(1);
        end
    end
            
end
    
function ENT:ToggleWings()
    if(!IsValid(self)) then return end;
	if(self.NextUse.Wings < CurTime()) then
		if(self.Wings) then
			self:SetModel(self.ClosedModel);
            self.FireGroup = {"RightR","RightL","LeftL","LeftR"};
            self.Bullet = CreateBulletStructure(65,"green");
			self.Wings = false;
		else
			self.Wings = true;
			self:SetModel(self.WingsModel);
            self.Bullet = CreateBulletStructure(75,"green");
            self.FireGroup = {"WingRightR","WingRightL","WingLeftL","WingLeftR"};
		end
        for k,v in pairs(self.Weapons) do
            if(!self.Wings and (k=="WingLeftL" or k=="WingLeftR" or k == "WingRightL" or k=="WingRightR")) then
                v.Disabled = true;
            elseif(self.Wings and (k=="LeftL" or k=="LeftR" or k == "RightL" or k=="RightR")) then
                v.Disabled = true;
            end
        end
		self:PhysicsInit(SOLID_VPHYSICS);
        if(IsValid(self:GetPhysicsObject())) then
            self:GetPhysicsObject():EnableMotion(true);
            self:GetPhysicsObject():Wake();
        end
        self:StartMotionController();
		self:SetNWBool("Wings",self.Wings);
		if(IsValid(self.Pilot)) then
			self.Pilot:SetNWBool("SW_Wings",self.Wings);
		end
		self.NextUse.Wings = CurTime() + 1;
	end
end

hook.Add("PlayerEnteredVehicle","LambdaShuttleSeatEnter", function(p,v)
	if(IsValid(v) and IsValid(p)) then
		if(v.IsLambdaShuttleSeat) then
			p:SetNetworkedEntity("LambdaShuttle",v:GetParent());
            p:SetNetworkedEntity("LambdaSeat",v);
		end
	end
end);

hook.Add("PlayerLeaveVehicle", "LambdaShuttleSeatExit", function(p,v)
	if(IsValid(p) and IsValid(v)) then
		if(v.IsLambdaShuttleSeat) then
            if(v.LambdaFrontSeat) then
                local self = v:GetParent();
                p:SetPos(self:GetPos()+self:GetForward()*270+self:GetUp()*170);
            else
                p:SetPos(v:GetPos()+v:GetForward()*55+v:GetUp()*-20+v:GetRight()*20);
            end
			p:SetNetworkedEntity("LambdaShuttle",NULL);
            p:SetNetworkedEntity("LambdaSeat",NULL);
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
            local min = self:GetPos()+self:GetForward()*335+self:GetUp()*185+self:GetRight()*55;
            local max = self:GetPos()+self:GetForward()*235+self:GetUp()*275+self:GetRight()*-55
            for k,v in pairs(ents.FindInBox(min,max)) do
               if(v == p) then
                    self:Enter(p);
                    break;
                end
            end	
		else
			self:Passenger(p);
		end
	else
		if(p != self.Pilot) then
			self:Passenger(p);
		end
	end
end

function ENT:OnTakeDamage(dmg) --########## Shuttle's aren't invincible are they? @RononDex
    self.BaseClass.OnTakeDamage(self,dmg);
	if(dmg:GetAttacker() != self) then
		local health=self:GetNetworkedInt("Health")-(dmg:GetDamage()/2)


        if(health<=self.StartHealth/2) then
            self:SkinSwitch(self.Inflight);
        end
        
		if(health<=(self.StartHealth*0.33)) then
			self.HyperdriveDisabled = true;
		end
	end
end

function ENT:Think()
	self.BaseClass.Think(self);
	if(self.Inflight) then
		if(IsValid(self.Pilot)) then
		
			if(self.Wings) then
				if(self.Pilot:KeyDown(IN_DUCK)  and self.Pilot:KeyDown(IN_ATTACK2) and self.NextUse.LightSpeed < CurTime()) then
					if(!self.LightSpeed and !self.HyperdriveDisabled) then
						self.LightSpeed = true;
						self.LightSpeedTimer = CurTime() + 3;
						self.NextUse.LightSpeed = CurTime() + 20;
						
					end
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
	
	ENT.CanFPV = true;
	ENT.Sounds={
		Engine=Sound("ambient/atmosphere/ambience_base.wav"),
    }
	
	function ENT:Draw() self:DrawModel() end;
	
	local LightSpeed = 0;
	function ENT:Think()
		self.BaseClass.Think(self);
		local p = LocalPlayer();
		local IsFlying = p:GetNWEntity("LambdaShuttle");
		local Flying = self:GetNWBool("Flying".. self.Vehicle);
		if(IsFlying) then
			LightSpeed = self:GetNWInt("LightSpeed");
		end
		
		if(Flying) then
			self.EnginePos = {
				self:GetPos()+self:GetForward()*-395+self:GetUp()*160+self:GetRight()*67.5,
				self:GetPos()+self:GetForward()*-395+self:GetUp()*160+self:GetRight()*-67.5,
			}
			self:FlightEffects();
		end
	end
	
	function ENT:FlightEffects()
		local normal = (self:GetForward() * -1):GetNormalized()
		local roll = math.Rand(-90,90)
		local p = LocalPlayer()		
		local FWD = self:GetForward();
		local id = self:EntIndex();
		
		for k,v in pairs(self.EnginePos) do
			
			
			local dynlight = DynamicLight(id + 4096 * k);
			dynlight.Pos = v;
			dynlight.Brightness = 7;
			dynlight.Size = 350;
			dynlight.Decay = 1024;
			dynlight.R = 75;
			dynlight.G = 75;
			dynlight.B = 255;
			dynlight.DieTime = CurTime()+1;
			
		end
	
	end
	
	local View = {}
	local lastpos, lastang;
	local function LambdaCalcView()
		
		local p = LocalPlayer();
		local self = p:GetNWEntity("LambdaShuttle",NULL)
        local flying = p:GetNWBool("FlyingLambdaShuttle");
		local pos,face;
        if(flying) then
            if(IsValid(self)) then
                local fpvPos = self:GetPos()+self:GetRight()*-35+self:GetForward()*325+self:GetUp()*235;
                if(LightSpeed == 2 and !self:GetFPV()) then
                    pos = lastpos;
                    face = lastang;

                    View.origin = pos;
                    View.angles = face;
                else
                    pos = self:GetPos()+self:GetUp()*650+LocalPlayer():GetAimVector():GetNormal()*-1300;			
                    face = ((self:GetPos() + Vector(0,0,100))- pos):Angle()
                    View =  SWVehicleView(self,1300,650,fpvPos,true);
                end

                lastpos = pos;
                lastang = face;

                return View;
            end
        else
            local v = p:GetNWEntity("LambdaSeat",NULL);
            if(IsValid(v)) then
                if(v:GetThirdPersonMode()) then
                    return SWVehicleView(self,1300,650,fpvPos);
                end
            end
        end
	end
	hook.Add("CalcView", "LambdaShuttleView", LambdaCalcView)
	
	function LambdaShuttleReticle()
		
		local p = LocalPlayer();
		local Flying = p:GetNWBool("FlyingLambdaShuttle");
		local self = p:GetNWEntity("LambdaShuttle");
		if(Flying and IsValid(self)) then
			SW_HUD_DrawHull(4000);
			SW_WeaponReticles(self);
			SW_HUD_DrawOverheating(self);
            
            local pos = self:GetPos()+self:GetForward()*365+self:GetUp()*225;
            local x,y = SW_XYIn3D(pos);
			SW_HUD_Compass(self,x,y);
			SW_HUD_DrawSpeedometer();
			SW_HUD_WingsIndicator("shuttle",x,y);
		end
		if(IsValid(self)) then
			if(LightSpeed == 2) then
				DrawMotionBlur( 0.4, 20, 0.01 );
			end
		end
	end
	hook.Add("HUDPaint", "LambdaShuttleReticle", LambdaShuttleReticle)

    
	hook.Add("ScoreboardShow","LambdaShuttleScoreDisable", function()
		local p = LocalPlayer();	
		local Flying = p:GetNWBool("FlyingLambdaShuttle");
		if(Flying) then
			return false;
		end
	end)
end