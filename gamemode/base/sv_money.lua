local peta = FindMetaTable( "Player" )

function peta:AddMoney(amt)
if not amt then return false end
local total = self:GetPlayerValue("wallet",0)+math.floor(amt)
self:SetPlayerValue("wallet",total)
hook.Call("StoreMoney",GAMEMODE,self,total)
end

function GM:PayPlayer(p1,p2,amt)

p1:AddMoney(-amt)
p2:AddMoney(amt)

end

