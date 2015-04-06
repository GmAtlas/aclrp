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