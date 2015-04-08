--[[
Player Manager
--]]
util.AddNetworkString("ACLRP_SendVars")

function GM:InitialPlayerDB(ply)
data = sql.Query("SELECT rpname, wallet, salary FROM aclrp_player WHERE uid = " .. ply:UniqueID() .. ";")
	if not data then

		sql.Query([[REPLACE INTO aclrp_player VALUES(]]..ply:UniqueID()..[[, ]]..sql.SQLStr(ply:Nick())..[[, ]] ..(30)..[[, ]]..(10000).. ");")
		print("PLAYER MISSING SQL INFO CREATING")

	end
	

end