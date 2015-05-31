util.AddNetworkString("ACLRP_SendVars")
util.AddNetworkString("ACLRP-PlayerInfo")

ACLRPPlayerInfo = {}

local peta = FindMetaTable( 'Player' )
	
function peta:GetPlayerValue(id,default)
	if(ACLRPPlayerInfo[self:UniqueID()] ~= nil and ACLRPPlayerInfo[self:UniqueID()][id] ~= nil) then
		return ACLRPPlayerInfo[self:UniqueID()][id]
		
	else
		return default
	end
end

	function peta:SetPlayerValue(id, value,broadcast)
		if not ACLRPPlayerInfo[self:UniqueID()] then ACLRPPlayerInfo[self:UniqueID()]={} end
		ACLRPPlayerInfo[self:UniqueID()][id] = value
		
		if ( IsValid(player.GetByUniqueID(self:UniqueID()) ) && !broadcast ) then
			self:SendPlayerInfo()
			hook.Call("SavePlayer",GAMEMODE,self)
		end
		if(broadcast) then
		
		
		end
	end

	function peta:SendPlayerInfo()
		if not ACLRPPlayerInfo[self:UniqueID()] then return end
		net.Start("ACLRP-PlayerInfo")
			net.WriteString( util.TableToJSON( ACLRPPlayerInfo[self:UniqueID()] ) )
		net.Send(self)
	end
function SetGlobalValue(id,value,broadcast)
local tab = {}
	for k,v in pairs(player.GetAll()) do
		if(v:IsWanted()) then
		table.insert(tab,{ply = v:UniqueID(),reason = v:GetPlayerValue("warrentreason","a niger") })
		end
	end
	PrintTable(tab)
	for k,v in pairs(player.GetAll()) do
		v:SetPlayerValue("wantedplayers",util.TableToJSON(tab))
	end
end
