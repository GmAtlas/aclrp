include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end



function ENT:Draw()
	self:DrawModel()
	
if(self:GetNWInt("Power_Connected") == 0 or nil ) then return end
                local light = DynamicLight(self:EntIndex()+9001)
                
                if light then
            
                        light.Pos =self:GetPos()+Vector(0,0,100)
                        light.r = 100
                        light.g = 100
                        light.b = 100
                        light.Brightness = 0.8
                        light.Size = 1000
                        light.Decay = 0
                        light.DieTime = CurTime() + 0.3
                end
    

 






end