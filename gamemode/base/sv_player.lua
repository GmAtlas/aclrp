--[[
Player Manager
--]]
util.AddNetworkString("ACLRP_SendVars")
util.AddNetworkString("ANotify")


local peta = FindMetaTable("Player")

function GM:InitialPlayerDB(ply)
data = sql.Query("SELECT rpname, wallet, salary FROM aclrp_player WHERE uid = " .. ply:UniqueID() .. ";")
	if not data then

		sql.Query([[REPLACE INTO aclrp_player VALUES(]]..ply:UniqueID()..[[, ]]..sql.SQLStr(ply:Nick())..[[, ]] ..(GAMEMODE.Config.basesalary)..[[, ]]..(GAMEMODE.Config.startingcash).. ");")
		print("PLAYER MISSING SQL INFO CREATING")

	end
	

end

