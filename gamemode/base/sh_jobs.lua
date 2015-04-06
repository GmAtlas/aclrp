ACLRPJobs= {}
PrintTable(ACLRPJobs)
local JobCrissant = {}
local JCount = 0
function GM:JobRegister(name,custjob)

JCount = JCount + 1
local job = custjob
job.Team = JobCount
job.Name = job.Name 								or "Undefined"
job.CustomCheck = job.CustomCheck				    or function(ply) return true end
job.CustomFail = job.CustomFail 					or "Cannot switch to this job!"
job.Weapons = job.Weapons 							or  {"weapon_phygun","weapon_toolgun"}
job.RequiresVote = job.RequiresVote					or false
job.Salary = job.Salary 							or 60
job.CanStartVote = job.CanStartVote 				or true
job.Model = job.Model 								or {"models/player/group01/male_02.mdl"}
job.Color = job.Color 								or Color(0,255,0)
job.Max = job.Max 									or 10
job.Desc = job.Desc 								or [[ undefined job ]]
job.NChangeFrom = job.NChangeFrom 					or 1

JobCrissant[name] = table.insert(ACLRPJobs, job )
  
	team.SetUp(#ACLRPJobs, name, job.Color)
	local Team = #ACLRPJobs
	if type(job.Model) == "table" then
		for k,v in pairs(job.Model) do util.PrecacheModel(v) end
	else
		util.PrecacheModel(job.Model)
	end
	print("TEAM REGISTERED: "..Team.." "..name.." "..team.GetName(Team) )  
	return Team

end

TEAM_CITIZEN = GM:JobRegister("Citizen",{
Max = 100,
Desc = [[Member of Apex City ]],
Name = "Citizen",
Model = {
"models/player/group01/male_02.mdl",
"models/player/group01/male_03.mdl",
"models/player/group01/male_01.mdl",
"models/player/group01/male_04.mdl",
}
} )
TEAM_HOBO = GM:JobRegister("Hobo",{Max = 5,Desc = [[ Lowest Member of Society]],Salary = 0,NChangeFrom = TEAM_CITIZEN,Model = "models/player/corpse1.mdl",Color = Color(0,0,0)}) 
TEAM_WHORE = GM:JobRegister("WHORE",{Max = 100,Desc = [[Member of Apex City ]],Name = "Citizen"} )