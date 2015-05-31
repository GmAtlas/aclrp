-- popo

local peta = FindMetaTable("Player")



ACLRP_JailPoints = {
	["rp_downtown_v4c_v3_chirax"] = {
	Vector( -2072.040771, 304.784821, -95.968750 ),
	Vector( -2261.949707, 267.930206, -95.968750 ),
	Vector( -2426.553711, 304.486145, -95.968750 ),		
	},
["rp_rockford_v1b"] = {
	Vector(-7185.4389648438,-5260.5776367188,8.03125),
	Vector(-7519.677734375,-5273.1396484375,8.03125),
	Vector(-7216.3295898438,-5171.3051757813,8.03125),
	Vector(-7509.95703125,-5168.4995117188,8.03125),
	Vector(-7208.9829101563,-5060.6928710938,8.03125),
	Vector(-7519.154296875,-5053.4331054688,8.03125),
}
}

function FindPlyName( name )

	local matches = {}
	
		for k,v in pairs( player.GetAll( ) ) do
			if( v:GetName( ):lower( ):match( name:lower( ) ) ) then
				table.insert(matches,v)
			end
		end
		
		if(#matches == 0 ) then 
			return false 
		end
		return matches[1]
end

function peta:IsArrested()
	return self:GetPlayerValue("arrested",false)
end

function GM:OnArrest(ply)
ply:SetPlayerValue("arrested", true)
ply:SetPlayerValue("arrestedtime",CurTime()+GAMEMODE.Config.jailtime)
	for k,v in pairs(player.GetAll()) do
		v:SendLua("anotify.Create('"..ply:Nick().." Has been arrested! Reason:"..ply:GetPlayerValue("warrentreason","nil").."',5)"  )
		
	end
	ply:Arrest()
	ply:ChatPrint("You will be arrested in "..GAMEMODE.Config.jailtime.." Seconds!")
	timer.Create(ply:UniqueID() .. "jailtimer", GAMEMODE.Config.jailtime, 1, function()
		if IsValid(ply) then 
			ply:UnWarrent()
			ply:SetPlayerValue("arrested", false)
			ply:Spawn()
		end	
	end)
	
end
function peta:Arrest()
	
	self:StripWeapons()
	self:SetPos(table.Random(ACLRP_JailPoints[game.GetMap()]))
	SetGlobalValue()
end

function peta:Warrent(reason)
	
	self:SetPlayerValue("warrent",true)
	self:SetPlayerValue("warrentreason",reason)
	SetGlobalValue()
	timer.Simple(60,function()
	if(self:IsWanted() and !self:IsArrested()) then
	self:UnWarrent()
	end
	end)
end

function dowarrent(ply,strin)

local pl = string.Explode(" ", string.lower(strin))[1] 

local reason =  string.sub(strin, string.len(pl) + 2, string.len(strin))
print(pl,reason,(ply:Team() != TEAM_COP),FindPlyName( pl ))
	if(ply:Team() != TEAM_COP) then return end
	if !FindPlyName(pl) then return end

FindPlyName(pl):Warrent(reason)
SetGlobalValue()
end


function peta:UnWarrent()
	self:SetPlayerValue("warrent",nil)
	self:SetPlayerValue("warrentreason","")
	SetGlobalValue()
end
function peta:IsWanted()
	return (self:GetPlayerValue("warrent") == true)
end
function peta:IsArrested()
	return (self:GetPlayerValue("arrested") == true)
end