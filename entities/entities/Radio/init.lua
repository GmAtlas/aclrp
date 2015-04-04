AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
if CLIENT then return end



function ENT:Initialize()

	self:SetModel( "models/props/cs_office/radio.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	
end
          

function ENT:Think()

end



 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )	


	
end

