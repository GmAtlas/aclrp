AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include("shared.lua") 

if CLIENT then return end



function ENT:Initialize()

self:SetModel( "models/Humans/Group02/Female_03.mdl" ) 
self:SetHullType( HULL_HUMAN ) 
self:SetHullSizeNormal( )
self:SetNPCState( NPC_STATE_SCRIPT )
self:SetSolid(  SOLID_BBOX ) 
self:CapabilitiesAdd( CAP_TURN_HEAD and CAP_ANIMATEDFACE ) 
self:SetUseType( SIMPLE_USE )
self:DropToFloor()
 self:SetMaxYawSpeed( 900 ) 

end
          

function ENT:Think()

for _,ent in pairs(ents.FindInSphere(self:GetPos(),300)) do
if ent:GetClass() == "player" then
Yaw = (ent:GetPos() - self:GetPos()):Angle().yaw
a = math.ApproachAngle(self:GetAngles().yaw,Yaw,10)
self:SetAngles(Angle(0,a,0))

end
end



end
 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )

if Name == "Use" and Caller:IsPlayer() then

self:EmitSound("vo/npc/female01/hi02.wav",100,100)
print("Food")
end

end

