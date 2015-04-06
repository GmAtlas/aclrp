--[[
Player Manager
--]]
util.AddNetworkString("ACLRP_SendVars")

function GM:InitialPlayerDB(ply)
data = sql.Query("SELECT rpname, wallet, salary FROM darkrp_player WHERE uid = " .. ply:UniqueID() .. ";")
	if data ~= true then

		sql.Query([[REPLACE INTO aclrp_player VALUES(]]..ply:UniqueID()..[[, ]]..sql.SQLStr(ply:Nick())..[[, ]] ..(30)..[[, ]]..(10000).. ");")
		

	end
	

end