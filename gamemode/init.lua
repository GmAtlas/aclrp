include("shared.lua") 
include("base/sv_player.lua")
include("base/sh_jobs.lua")
include("base/sv_gamemodefunctions.lua")
include("base/sv_db.lua")

AddCSLuaFile("base/sv_player.lua")
AddCSLuaFile("base/sh_jobs.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua" )
AddCSLuaFile( "base/cl_gwen.lua" )

DEFINE_BASECLASS( "gamemode_sandbox" )

