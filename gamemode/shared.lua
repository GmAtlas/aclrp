GM.Name = "AclRP"
GM.Author = "Atlas/Setu_Sertao, Mr.White"
GM.Email = "leveluptime@apexgamecommunity.com"
GM.Website = "site.apex.gs"
GM.TeamBased = true
include("player_class/player_lerp.lua")
AddCSLuaFile("player_class/player_lerp.lua")
DeriveGamemode( "sandbox" )


function GM:CreateTeams()

end

GM.Config = {}

GM.Config.PayDayTime 				= 300
GM.Config.DefaultPayDay 			= 50 

 