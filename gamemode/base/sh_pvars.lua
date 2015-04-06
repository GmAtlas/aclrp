ACLRP = {}
local maxId = 0
local ACLRPVars = {}
local ACLRPVarsID = {}


local ACLR_ID_BITS = 8
local UNKNOWN_DARKRPVAR = 255 

	
function ACLRP.RegisterVar(name, writeFn, readFn)
	maxId = maxId + 1
	ACLRPVars[name] = {id = maxId, name = name, writeFn = writeFn, readFn = readFn}
	ACLRPVarsID[maxId] = ACLRPVars[name]
end


function ACLRP.WriteNetVar(name, value)
	local Var = ACLRPVars[name]
	net.WriteUInt(Var.id, ACLR_ID_BITS)
	return Var.writeFn(value)
end

function ACLRP.ReadNetVar()
	local VarId = net.ReadUInt(ACLR_ID_BITS)
	local Var = ACLRPVarsID[VarId]

	local val = Var.readFn(value)

	return Var.name, val
end




ACLRP.RegisterVar("Money",net.WriteDouble,net.ReadDouble)
ACLRP.RegisterVar("Nigs",net.WriteString,net.ReadString)