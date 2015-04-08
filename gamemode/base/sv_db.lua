function InitPlayerDB()
sql.Query([[
			CREATE TABLE IF NOT EXISTS aclrp_player(
				uid BIGINT NOT NULL PRIMARY KEY,
				rpname VARCHAR(45),
				salary INTEGER NOT NULL DEFAULT 45,
				wallet INTEGER NOT NULL,
				UNIQUE(rpname)
			);
		]])
		
end

hook.Add("InitializePlayerDatabase","InitPDB",InitPlayerDB)

function GM:StoreMoney(ply, amount)
	if not IsValid(ply) then return end
	if not isnumber(amount) or amount < 0 or amount >  100000000000  then return end

	sql.Query([[UPDATE aclrp_player SET wallet = ]] .. amount .. [[ WHERE uid = ]] .. ply:UniqueID())
end

function GM:StoreSalary(ply, amount)
	ply:SetPlayerValue("salary", math.floor(amount))

	sql.Query([[UPDATE aclrp_player SET salary = ]] .. amount .. [[ WHERE uid = ]] .. ply:UniqueID())

	return amount
end

function GM:SavePlayer(ply)
sql.Query([[UPDATE aclrp_player SET wallet = ]].. ply:GetPlayerValue("wallet",0)..[[, salary = ]]..ply:GetPlayerValue("salary",1) ..[[ WHERE uid = ]]..ply:UniqueID())

end
