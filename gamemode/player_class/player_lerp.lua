AddCSLuaFile()
local PLAYER = {}

PLAYER.DisplayName			= "ACLRP CLASS"

function PLAYER:GetHandsModel()
	local jobTable = ACLRPJobs[self.Player:Team()]
	if not jobTable then return end

	local model = istable(jobTable.model) and jobTable.model[1] or jobTable.model
	if not model then return end
	
	local name = player_manager.TranslateToPlayerModelName(model)

	return player_manager.TranslatePlayerHands(name)
end

function PLAYER:Spawn()
	local col = self.Player:GetInfo( "cl_playercolor" )
	self.Player:SetPlayerColor( Vector( col ) )

	local col = self.Player:GetInfo( "cl_weaponcolor" )
	self.Player:SetWeaponColor( Vector( col ) )
end

player_manager.RegisterClass("player_lerp", PLAYER, "player_default")