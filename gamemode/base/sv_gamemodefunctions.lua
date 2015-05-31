function GM:Initialize()

hook.Call("InitializePlayerDatabase")
hook.Call("LoadDataProvider",self)
end


function GM:PlayerInitialSpawn(ply)

		self.BaseClass:PlayerInitialSpawn(ply)
		ply:SetTeam(TEAM_CITIZEN)
		ply:GetPlayerInfo()

end

function GM:PlayerSetModel(ply)
	ply:GetPlayerValue("Model","models/players/Group01/male_02.mdl")
	ply:SetupHands()
end

function GM:PlayerSpawn(ply)
	
		
	ply:SetNoCollideWithTeammates(false)
	ply:CrosshairEnable()
	ply:UnSpectate()
	
	self.BaseClass.BaseClass:PlayerSpawn(ply)
	self.BaseClass:PlayerSpawn(ply)
	
	ply:SetPlayerValue("hunger",100)
	ply:SetHealth( 100 )
	
	player_manager.SetPlayerClass(ply, "player_lerp")
	player_manager.OnPlayerSpawn( ply )
	player_manager.RunClass( ply, "Spawn" )
	
	ply:GetPlayerInfo()
	
	if(ply:IsArrested()) then
	ply:Arrest()
	end
	
	
		SafeRemoveEntity(ply.death_ragdoll)
	
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

