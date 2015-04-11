AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua") 

 
  
DEFINE_BASECLASS( "gamemode_sandbox" )

local longs1 = [[
-----------------------------------------
-				LOADING FILES			- 
]]
print(longs1)
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sh_*","LUA"),true) do
AddCSLuaFile(GM.FolderName.."/gamemode/base/"..v)
include(GM.FolderName.."/gamemode/base/"..v)
print("Shared File: "..v)
end 
 
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/cl_*","LUA"),true) do
AddCSLuaFile(GM.FolderName.."/gamemode/base/"..v)
print("Clientside File: "..v)
end 

for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sv_*","LUA"),true) do
include(GM.FolderName.."/gamemode/base/"..v)
print("Serverside File: "..v)
end 

