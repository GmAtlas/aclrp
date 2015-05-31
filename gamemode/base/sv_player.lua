--[[
Player Manager
--]]
util.AddNetworkString("ACLRP_SendVars")
util.AddNetworkString("ANotify")


local peta = FindMetaTable("Player")

function peta:GetPlayerInfo()
	return ACLRP:GetPlayerData(self,function(info)
	print(info)
	
	end)
end


function GM:ShowTeam(ply)
end


function GM:DoPlayerDeath( ply, attacker, dmginfo )
 
local DeathRagdoll = CORPSE.Create(ply)
ply.server_ragdoll = DeathRagdoll
ply.death_ragdoll = DeathRagdoll
end

function GM:PlayerDeath(ply,inflictor, attacker)
	self.BaseClass:PlayerDeath(ply,inflictor, attacker)
	ply.NextSpawnTime = CurTime() + 100
	ply.DeathTime = CurTime()

end
function GM:PlayerDeathThink( ply )
	ply:SetPlayerValue("deathtimer",ply.NextSpawnTime-CurTime())
	if ( ply.NextSpawnTime && ply.NextSpawnTime > CurTime() ) then return end

	if ( ply:KeyPressed( IN_ATTACK ) || ply:KeyPressed( IN_ATTACK2 ) || ply:KeyPressed( IN_JUMP ) ) then
	
		ply:Spawn()
	
	end
	
end