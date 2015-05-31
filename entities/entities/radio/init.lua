AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include("shared.lua") 

if CLIENT then return end


function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal + Vector(0,0,50)

	local ent = ents.Create( "radio" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent

end



function ENT:Initialize()

self:SetModel( "models/hunter/plates/plate025x025.mdl" ) 
self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
 self:SetUseType(SIMPLE_USE)

        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	
 
end


function ENT:Think()


end

function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )

if Name == "Use" and Caller:IsPlayer() then



end

end







