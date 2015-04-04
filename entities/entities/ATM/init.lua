AddCSLuaFile( "cl_init.lua" ) 
AddCSLuaFile( "shared.lua" )
include("shared.lua") 

require( "mysqloo" )


if CLIENT then return end
if SERVER then

util.AddNetworkString("atmneed")
util.AddNetworkString("atmreturn")




end






function ENT:Initialize()

self:SetModel( "models/props/cs_assault/TicketMachine.mdl" ) 
self:PhysicsInit( SOLID_VPHYSICS )      
self:SetMoveType( MOVETYPE_NONE )   
self:SetSolid( SOLID_VPHYSICS )         


end
          

function ENT:Think()

end


 
function ENT:OnTakeDamage()

end


function ENT:AcceptInput( Name, Activator, Caller )


Caller:SendLua("OpenATM()")

end

function Deposit(ply,cmd,arg)
if(!arg[1]) then return end
if(!ply:HaveMoney(arg[1]-1) )then return end
ply:LoseMoney( tonumber( arg[1]) )



if(!sql.Query("SELECT sid,money FROM ATM WHERE sid = '"..ply:SteamID().."'")) then
print("Not")
sql.Query("INSERT INTO ATM VALUES('"..ply:SteamID().."','"..arg[1].."' )")
else print("YAH")
sql.Query("UPDATE ATM SET money = '"..tonumber( GetATMMoney(ply) )+tonumber(arg[1]).."' WHERE sid = '"..ply:SteamID().."' ") 


end

end
concommand.Add("Deposit",Deposit)



function GetATMMoney(ply)

if(sql.Query("SELECT money FROM ATM WHERE sid = '"..ply:SteamID().."' ")) then

for k,v in pairs( sql.Query("SELECT money FROM ATM WHERE sid = '"..ply:SteamID().."' ") ) do
return v["money"]
end
else
return "0"
end


end


net.Receive("atmneed",function()
local ply = net.ReadEntity()
net.Start("atmreturn")
net.WriteString(GetATMMoney(ply))
net.Send(ply)
end)

function Withdraw(ply,cmd,arg)

if(!arg[1]) then print( "noarg ") return end
if(!sql.Query("SELECT sid,money FROM ATM WHERE sid = '"..ply:SteamID().."'")) then return print( "noselect ") else
if(tonumber(arg[1]) > tonumber(GetATMMoney(ply)) ) then return print( "greater ")  else
sql.Query("UPDATE ATM SET money = '"..tonumber( GetATMMoney(ply) ) - tonumber(arg[1]).."' WHERE sid = '"..ply:SteamID().."' ") 
ply:GiveMoney(arg[1])
end
end


end
concommand.Add("withdraw",Withdraw)


