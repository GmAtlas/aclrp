include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end



local function Draw(self)
	self:DrawModel()
	
end




-----------------------------------------------------------
--Define Radio as a global variable my  functions can call--
------------------------------------------------------------    
Radio = nil  -- omg global var
ID = 00000
-----------------------------------------------------------
--This function is is my hacky way to globalize the radio--
-----------------------------------------------------------

function Rad(Radi)        

Radio = Radi               
end


    
function StopMusic()
Radio:Stop()
end


function PlayMusic()
Radio:Play()
end


function SetVolume(number)
Radio:SetVolume(number)
end

function ENT:Think()
if(Radio) then
Radio:SetPos(self:GetPos())
end


end

function ENT:OnRemove()

if Radio then
StopMusic()
end


end

net.Receive("StartRadio",function()
if Radio then

StopMusic()

end

ID = net.ReadFloat()

sound.PlayURL( "http://yp.shoutcast.com/sbin/tunein-station.pls?id="..ID.."&play_status=1" , "3d", Rad)















end)














