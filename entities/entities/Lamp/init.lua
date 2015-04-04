AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
if CLIENT then return end

if SERVER then


end

function ENT:Initialize()
self:SetNWInt("Power_Connected",1)
	self:SetModel( "models/props_interiors/Furniture_Lamp01a.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         

	self:SetPos(self:GetPos()+Vector(0,0,100))
	
end
          

function ENT:Think()

end



 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )	





	
end

