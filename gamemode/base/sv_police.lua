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

function peta:IsArrested()
	return self:GetPlayerValue("arrested",false)
end
function peta:Arrest()
self:SetPlayerValue("arrested", true)
self:StripWeapons()
self:SetPos(table.Random(ACLRP_JailPoints[game.GetMap()]))
for k,v in pairs(player.GetAll()) do
v:SendLua("anotify.Create('"..self:Nick().." Has been arrested! Reason:"..self:GetPlayerValue("warrentreason","nil").."',5)"  )
end
end

function peta:Warrent(reason)
	self:SetPlayerValue("warrent",true)
	self:SetPlayerValue("warrentreason",reason)
end

function peta:UnWarrent()
	self:SetPlayerValue("warrent",nil)
	self:SetPlayerValue("warrentreason","")
end
function peta:IsWanted()
	return (self:GetPlayerValue("warrent") == true)
end