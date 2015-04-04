AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
if CLIENT then return end

if SERVER then
util.AddNetworkString("StartRadio")
util.AddNetworkString("NeedRadio")
util.AddNetworkString("ReturnRadio")


end
Broad = 0
Station = 00000

function ENT:Initialize()

	self:SetModel( "models/props_lab/reciever_cart.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
	
end
          

function ENT:Think()

end



 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )	



if(Broad == 0 ) then Broad = 1 

net.Start("StartRadio")
net.WriteFloat( 53937 )
net.Broadcast()

timer.Simple(1,function() Broad = 0 end)
end


	
end

net.Receive("NeedRadio",function()

net.Start("StartRadio")
net.WriteFloat( 53937 )
net.Broadcast()

end)