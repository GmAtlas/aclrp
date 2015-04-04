include("shared.lua")
include("base/cl_gwen.lua")
function GM:Initialize()
end

function GM:CreateJob(name, color, job)
	local index = table.insert(self.Jobs, job)
		team.SetUp((#self.Jobs), name, color, false)
	return (#self.Jobs)
end

function GM:GetJobData(index)
	return self.Jobs[index] or nil
end

function GM:InitializeJobs()
	if #self.Jobs > 0 then
		self.Jobs = {}
end
end
	TEAM_CITIZEN = self:CreateJob("Citizen", Color(46, 204, 113), {
		model = {
			"models/player/group01/female_01.mdl",
			"models/player/group01/female_02.mdl",
			"models/player/group01/female_03.mdl",
			"models/player/group01/female_04.mdl",
			"models/player/group01/female_05.mdl",
			"models/player/group01/female_06.mdl",
			"models/player/group01/male_01.mdl",
			"models/player/group01/male_02.mdl",
			"models/player/group01/male_03.mdl",
			"models/player/group01/male_04.mdl",
			"models/player/group01/male_05.mdl",
			"models/player/group01/male_06.mdl",
			"models/player/group01/male_07.mdl",
			"models/player/group01/male_08.mdl",
			"models/player/group01/male_09.mdl",
		},
		salary = feather.config.get("salary"),
		cmd = "citizen",
		desc = GetLang("jobcitizen"),
	}) 
	
	
	
	