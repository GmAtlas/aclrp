AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )

include("shared.lua") 
if CLIENT then return end



function ENT:Initialize()

	self:SetModel( "models/props/de_inferno/tree_small.mdl" ) 
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_NONE )   
	self:SetSolid( SOLID_VPHYSICS )         
	print(self.FCount)
local tree = self

timer.Create("TREE_"..self:EntIndex(),10,0,function()

tree:SetNWInt("FRUITCOUNT", tonumber(tree:GetNWInt("FRUITCOUNT")) + 1  )

end)


end
          

function ENT:Think()

end



 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )	

if(tonumber(self:GetNWInt("FRUITCOUNT")) <= 0 ) then return end
local fruit = ents.Create("Fruit")
fruit:SetPos( self:GetPos()+Vector(0,40,100) )
fruit:Spawn()

self:SetNWInt("FRUITCOUNT",tonumber(self:GetNWInt("FRUITCOUNT"))-1 )
	
end

