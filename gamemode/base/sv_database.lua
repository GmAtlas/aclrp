function GM:LoadDataProvider()
	local path = self.FolderName.."/gamemode/providers/" .. self.Config.DataProvider .. ".lua"
	print(path)
	if not file.Exists(path, "LUA") then
		error("PROVIDER FAILED" .. path)
	end
 
	PROVIDER = {}
	PROVIDER.__index = {}
	PROVIDER.ID = self.Config.DataProvider 
		
	include(path)
		
	ACLRP.DataProvider = PROVIDER
	print(ACLRP.DataProvider)
	PROVIDER = nil
end
hook.Add("LoadDataProvider",GAMEMODE,LoadDataProvider)

function ACLRP:GetPlayerData(ply, callback) 
	self.DataProvider:GetData(ply, function(info)
		callback( util.TableToJSON(info) )
	end)
end 
 

function ACLRP:SetWallet(ply, money)
	self.DataProvider:SetWallet(ply, money)
end
--[[
function GG:GivePlayerPoints(ply, points)
	self.DataProvider:GivePoints(ply, points, items)
end

function GG:TakePlayerPoints(ply, points)
	self.DataProvider:TakePoints(ply, points)
end

function GG:SavePlayerItem(ply, item_id, data)
	self.DataProvider:SaveItem(ply, item_id, data)
end

function GG:GivePlayerItem(ply, item_id, data)
	self.DataProvider:GiveItem(ply, item_id, data)
end

function GG:TakePlayerItem(ply, item_id)
	self.DataProvider:TakeItem(ply, item_id)
end
--]]