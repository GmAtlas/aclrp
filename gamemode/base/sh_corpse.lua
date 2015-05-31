CORPSE = {}

if SERVER then

function CORPSE.Create(ply)
local rag = ents.Create("prop_ragdoll")
rag:SetModel(ply:GetModel())
rag:SetPos(ply:GetPos())
rag:SetAngles(ply:GetAngles())
rag:Spawn()
return rag
end












end