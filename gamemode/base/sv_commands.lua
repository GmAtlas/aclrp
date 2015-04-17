--[[

]]--

ChatCommands = {}

function AddChatCommand(cmd, callback, prefixconst)
	table.insert(ChatCommands, { cmd = cmd, callback = callback, prefixconst = prefixconst })
end

function GM:PlayerSay(ply, text)
	self.BaseClass:PlayerSay(ply, text)

	for k, v in pairs(ChatCommands) do
		if v.cmd == string.Explode(" ", string.lower(text))[1] then
			return v.callback(ply, "" .. string.sub(text, string.len(v.cmd) + 2, string.len(text)))
		end
	end	
	return text
end 

function dodat(a,b,c)
print(a,b,c)
return ""
end

AddChatCommand("!slay",dodat)