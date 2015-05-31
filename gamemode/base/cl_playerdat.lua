ACLRPPlayerInfo = {}

local peta = FindMetaTable( 'Player' )

net.Receive("ACLRP-PlayerInfo",function()
	ACLRPPlayerInfo = util.JSONToTable( net.ReadString() )
end)

function GetPlayerValue(id, default)
		return ACLRPPlayerInfo[id] ~= nil and ACLRPPlayerInfo[id] or default
end

function peta:GetValue(id, default)
		return GetPlayerValue(id, default)
end