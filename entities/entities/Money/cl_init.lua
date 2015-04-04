include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end



local function Draw(self)
	self:DrawModel()
	
end