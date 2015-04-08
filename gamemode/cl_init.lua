include("shared.lua")
AddCSLuaFile("shared.lua")
 
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/cl_*","LUA"),true) do
include(GM.FolderName.."/gamemode/base/"..v)

end 
for k,v in SortedPairs(file.Find(GM.FolderName.."/gamemode/base/sh_*","LUA"),true) do
include(GM.FolderName.."/gamemode/base/"..v)

end 

function GM:Initialize()
end


	
	
	