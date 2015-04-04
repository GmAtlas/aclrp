include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end


 function ENT:Draw()
	self:DrawModel()
	
end