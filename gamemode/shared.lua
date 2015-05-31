GM.Name = "AclRP"
GM.Author = "Atlas/Setu_Sertao, Mr.White"
GM.Email = "leveluptime@apexgamecommunity.com"
GM.Website = "site.apex.gs"
GM.TeamBased = true
include("player_class/player_lerp.lua")
AddCSLuaFile("player_class/player_lerp.lua")
DeriveGamemode( "sandbox" )

ACLRP = {}
ACLRP.__index = ACLRP

function GM:CreateTeams()

end



 