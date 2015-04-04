AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
if CLIENT then return end



function ENT:Initialize()

	self:SetModel( "models/props/cs_assault/Dollar.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	
local entphys = self:GetPhysicsObject()
if entphys:IsValid() then
     entphys:EnableGravity(true)
     entphys:Wake()
end
end
          

function ENT:Think()

end



 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )	
Caller:GiveMoney(tonumber(self.ammount))
SafeRemoveEntity(self)

	
end

