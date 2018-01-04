ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Base = "speeder_base"
ENT.Type = "vehicle"

ENT.PrintName = "AT-RT"
ENT.Author = "Liam0102, Imagundi, Anti Cheat"
ENT.Category = "Star Wars Vehicles: Republic"
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false;
ENT.AdminSpawnable = false;
ENT.AutomaticFrameAdvance =  true; 

ENT.Vehicle = "ATRT"; 
ENT.EntModel = "models/swbf3/vehicles/rep_at-rt.mdl"; 


ENT.StartHealth = 2500; // Starting Health

list.Set("SWVehicles", ENT.PrintName, ENT);
if SERVER then

ENT.NextUse = {Use = CurTime(),Fire = CurTime()};
ENT.FireSound = Sound("weapons/xwing_shoot.wav");


AddCSLuaFile();
function ENT:SpawnFunction(pl, tr)
	local e = ents.Create("atrt");
	e:SetPos(tr.HitPos + Vector(0,0,10));
	e:SetModelScale( e:GetModelScale() * 0.4, 0 )
	e:SetAngles(Angle(0,pl:GetAimVector():Angle().Yaw+0,0));
	e:Spawn();
	e:Activate();
	return e;
end

function ENT:Initialize()
	self.BaseClass.Initialize(self);
	local driverPos = self:GetPos()+self:GetUp()*133+self:GetForward()*-15+self:GetRight()*0; // Position of the drivers seat
	local driverAng = self:GetAngles()+Angle(0,-90,0); // The angle of the drivers seat
	self.SpeederClass = 2;
	self.SeatClass = "phx_seat3"
	self:SpawnChairs(driverPos,driverAng,false)
	
	self.ForwardSpeed = 210; //Your speed
	self.BoostSpeed = 250; // Boost Speed
	self.AccelSpeed = 3; // Acceleration
	self.HoverMod = 1;
	self.CanBack = true;
	self.StartHover = 15;
	self.WeaponLocations = {
	self:GetPos()+self:GetRight()*0+self:GetUp()*100+self:GetForward()*80, // Position of weapon
	self:GetPos()+self:GetRight()*0+self:GetUp()*95+self:GetForward()*80,
	}
	self.Bullet = CreateBulletStructure(1500,"blue"); // First number is damage, second is colour. red or green
	self.WeaponDir = self:GetAngles():Forward()*-1
	self:SpawnWeapons();
	self.StandbyHoverAmount = 15;	
	self.CanShoot = true;
	self.NextUse.Fire = 1; 
	end

local ZAxis = Vector(0,0,1);


function ENT:Think()
	self:NextThink(CurTime())
	if(self.Inflight) then
	
local angleforsave = self.Pilot:GetAimVector():Angle()
local needangle = self:WorldToLocalAngles( angleforsave )
self:ManipulateBoneAngles(self:LookupBone("pulsegun"), needangle );		

	if self:GetNWInt("Speed") >= 10 and self:GetNWInt("Speed") < 50 then
				self:ResetSequence( self:LookupSequence( "digi" ) );
				self:ResetSequenceInfo()
				self:SetPlaybackRate( 0.5 )
	elseif self:GetNWInt("Speed")  >= 50 and self:GetNWInt("Speed") < 80 then
				self:ResetSequence( self:LookupSequence( "digi" ) );
				self:ResetSequenceInfo()
				self:SetPlaybackRate( 0.8 )
	elseif self:GetNWInt("Speed")  >= 80 and self:GetNWInt("Speed") < 200 then
				self:ResetSequence( self:LookupSequence( "digi" ) );
				self:ResetSequenceInfo()
				self:SetPlaybackRate( 1.3 )
	elseif self:GetNWInt("Speed")  >= 200 then
				self:ResetSequence( self:LookupSequence( "digi" ) );
				self:ResetSequenceInfo()
				self:SetPlaybackRate( 1.8 )
	end
			
			
		if self:GetNWInt("Speed") <= 0 then
				self:SetSequence( self:LookupSequence( "idle" ) );
				self:ResetSequenceInfo()
				self:SetCycle( 0 )
		end
	end	
	self.BaseClass.Think(self)
end
	
function ENT:Exit(driver,kill)
	
	self.BaseClass.Exit(self,driver,kill);
		self:SetSequence( self:LookupSequence( "idle" ) );
		self:ResetSequenceInfo()
		self:SetCycle( 0 )
end
	
	
function ENT:PhysicsSimulate( phys, deltatime )
	self.BackPos = self:GetPos()+self:GetRight()*-70+self:GetUp()*15; // This is the back one
	self.FrontPos = self:GetPos()+self:GetRight()*100+self:GetUp()*15; // Front one
	self.MiddlePos = self:GetPos()+self:GetUp()*15; // Middle one
	if(self.Inflight) then
		local UP = ZAxis; // Up direction. Leave
		self.RightDir = self.Entity:GetRight(); // Which way is right, local to the model
		self.FWDDir = self.Entity:GetForward(); // Forward Direction. Local to the model.	
		

		
		self:RunTraces(); // Ignore

		self.ExtraRoll = Angle(0,0,self.YawAccel / 2*-.1); // ignore
		if(!self.WaterTrace.Hit) then
			if(self.FrontTrace.HitPos.z >= self.BackTrace.HitPos.z) then
				self.PitchMod = Angle(math.Clamp((self.BackTrace.HitPos.z - self.FrontTrace.HitPos.z),-45,45)/3*-1,0,0)
			else
				self.PitchMod = Angle(math.Clamp(-(self.FrontTrace.HitPos.z - self.BackTrace.HitPos.z),-45,45)/3*-1,0,0)
			end
		end

	end
	
	self.BaseClass.PhysicsSimulate(self,phys,deltatime);
	

end

end

if CLIENT then
	ENT.Sounds={
		Engine=Sound("ambient/atmosphere/ambience_base.wav"),
	}
	
	//Ignore
	local Health = 0;
	local Speed = 0;
	local Target;
	local Turret;
	function ENT:Think()
		self.BaseClass.Think(self);
		local p = LocalPlayer();
		local Flying = p:GetNWBool("Flying"..self.Vehicle);
		if(Flying) then
			Health = self:GetNWInt("Health");
			Speed = self:GetNWInt("Speed");
		end
		
	end

	ENT.HasCustomCalcView = true;
	local View = {}
	local function CalcView()
		
		local p = LocalPlayer();
        local self = p:GetNWEntity("ATRT", NULL)
        local DriverSeat = p:GetNWEntity("DriverSeat",NULL);
		local PassengerSeat = p:GetNWEntity("PassengerSeat",NULL);
        if(IsValid(self)) then
 
			if(IsValid(DriverSeat)) then
				if(DriverSeat:GetThirdPersonMode()) then
					local pos = self:GetPos()+self:GetForward()*-130+self:GetUp()*200;
					local face = self:GetAngles() + Angle(0,0,0);
					//local face = ((self:GetPos() + Vector(0,0,100))- pos):Angle();
						View.origin = pos;
						View.angles = face;
					return View;
				end
			end
        end
    end
    hook.Add("CalcView", "ATRTView", CalcView)
   
    hook.Add( "ShouldDrawLocalPlayer", "ATRTDrawPlayerModel", function( p )
        local self = p:GetNWEntity("ATRT", NULL);
        local DriverSeat = p:GetNWEntity("DriverSeat",NULL);
		local PassengerSeat = p:GetNWEntity("PassengerSeat",NULL);
        if(IsValid(self)) then
            if(IsValid(DriverSeat)) then
                if(DriverSeat:GetThirdPersonMode()) then
                    return true;
                end
			elseif(IsValid(PassengerSeat)) then
				if(PassengerSeat:GetThirdPersonMode()) then
					return true;
                end
            end
        end
    end);
	
	function ATRTReticle()
	
		local p = LocalPlayer();
		local Flying = p:GetNWBool("FlyingATRT");// Flying with your unique name
		local self = p:GetNWEntity("ATRT"); // Unique name
		if(Flying and IsValid(self)) then		
			local WeaponsPos = {self:GetPos()};
			
			SW_Speeder_Reticles(self,WeaponsPos)
			SW_Speeder_DrawHull(1000)
			SW_Speeder_DrawSpeedometer()

		end
	end
	hook.Add("HUDPaint", "ATRTReticle", ATRTReticle) //Unique names again
	
	
end