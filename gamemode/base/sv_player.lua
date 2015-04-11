--[[
Player Manager
--]]
util.AddNetworkString("ACLRP_SendVars")
local peta = FindMetaTable("Player")

function GM:InitialPlayerDB(ply)
data = sql.Query("SELECT rpname, wallet, salary FROM aclrp_player WHERE uid = " .. ply:UniqueID() .. ";")
	if not data then

		sql.Query([[REPLACE INTO aclrp_player VALUES(]]..ply:UniqueID()..[[, ]]..sql.SQLStr(ply:Nick())..[[, ]] ..(30)..[[, ]]..(10000).. ");")
		print("PLAYER MISSING SQL INFO CREATING")

	end
	

end

function peta:IsArrested()
	return self:GetPlayerValue("arrested",false)
end
function peta:Arrest()
self:SetPlayerValue("arrested", true)
end

function peta:Warrent(reason)
	self:SetPlayerValue("warrent",true)
	self:SetPlayerValue("warrentreason",reason)
end

function peta:UnWarrent()
	self:SetPlayerValue("warrent",nil)
	self:SetPlayerValue("warrentreason","")
end