util.AddNetworkString("ACLRP_SendVars")
util.AddNetworkString("ACLRP-PlayerInfo")

ACLRPPlayerInfo = {}

local peta = FindMetaTable( 'Player' )


function peta:LoadPlayerData()
	local data = sql.Query("SELECT * from aclrp_player WHERE uid = "..self:UniqueID())
		for k,v in pairs(data[1]) do
			self:SetPlayerValue(k,v)
		end
		self:SendPlayerInfo()
	return data[1].rpname,data[1].wallet,data[1].uid,data[1].salary
end
hook.Add("LoadPlayerDataInit","lpdi",function(ply) ply:LoadPlayerData() end)
	
function peta:GetPlayerValue(id,default)
	if(ACLRPPlayerInfo[self:UniqueID()] ~= nil and ACLRPPlayerInfo[self:UniqueID()][id] ~= nil) then
		return ACLRPPlayerInfo[self:UniqueID()][id]
	else
		return default
	end
end

	function peta:SetPlayerValue(id, value)
		if not ACLRPPlayerInfo[self:UniqueID()] then ACLRPPlayerInfo[self:UniqueID()]={} end
		ACLRPPlayerInfo[self:UniqueID()][id] = value
		
		if IsValid(player.GetByUniqueID(self:UniqueID())) then
			self:SendPlayerInfo()
	
		end
	end

	function peta:SendPlayerInfo()
		if not ACLRPPlayerInfo[self:UniqueID()] then return end
		net.Start("ACLRP-PlayerInfo")
			net.WriteString( util.TableToJSON( ACLRPPlayerInfo[self:UniqueID()] ) )
		net.Send(self)
	end

