function GM:Initialize()

hook.Call("InitializePlayerDatabase")

end


function GM:PlayerInitialSpawn(ply)
	ply:SetTeam(TEAM_CITIZEN)
	self.BaseClass:PlayerInitialSpawn(ply)
	hook.Call("InitialPlayerDB",GAMEMODE,ply)
	hook.Call("LoadPlayerDataInit",GAMEMODE,ply)

end

function GM:PlayerSetModel(ply)
	local team = ply:Team()

		local TEAM = ACLRPJobs[team]
	
		if not TEAM then return end
		local EndModel = ''
		
		if(istable(TEAM.Model)) then
			local found = false
			--[[
			for _,Models in pairs(TEAM.Model) do
				if ChosenModel == string.lower(Models) then
					EndModel = Models
					found = true
					break
				end
			end
			--]]
		
			if found == false then
				EndModel = TEAM.Model[math.random(#TEAM.Model)]
				print(EndModel)
			end
		else 
			EndModel = TEAM.Model
		end

		ply:SetModel(EndModel)
	ply:SetupHands()
end

function GM:PlayerSpawn(ply)
	player_manager.SetPlayerClass(ply, "player_lerp")
	
	
		
		
		
	ply:SetNoCollideWithTeammates(false)
	ply:CrosshairEnable()
	ply:UnSpectate()
	self.BaseClass.BaseClass:PlayerSpawn(ply)
	self.BaseClass:PlayerSpawn(ply)
	ply:SetPlayerValue("hunger",100)
	ply:SetHealth( 100)
	ply:AllowFlashlight(true)

	
end

function GM:PlayerDisconnected( ply )
	 PrintMessage( HUD_PRINTTALK, ply:Name().. " has left the server." )
	 hook.Call("SavePlayer",GAMEMODE,ply)
end 

function GM:PlayerLoadout( ply )

for k,v in pairs(GAMEMODE.Config.baseloadout) do
ply:Give(v)
end

for k,v in pairs(ACLRPJobs[ply:Team()].Weapons) do
ply:Give(v)
end

end


function GM:OnPlayerChangedTeam(  ply, oldTeam, newTeam )
	ply:SetPlayerValue("hunger",100)
	ply:SetPlayerValue("salary",ACLRPJobs[ply:Team()].Salary)
	if(!timer.Exists(ply:UniqueID().."paydaytimer")) then
		timer.Create(ply:UniqueID().."paydaytimer",GAMEMODE.Config.paydaytimer,0,function()
			ply:AddMoney(ACLRPJobs[ply:Team()].Salary or GAMEMODE.Config.basesalary)
			ply:SendLua([[anotify.Create("Pay Day!",5)]])
		end)
	end
end