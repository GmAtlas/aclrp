ITEM.Name = "ACLRP Item Base"
ITEM.Description = "ACLRP BASE ITEM"
ITEM.Model = "models/error.mdl"

function ITEM:Load()
	self:RegisterPickup( self.UniqueName )
end

function ITEM:SpawnEntity( pos )
	local ent = ents.Create( self.UniqueName )
	ent:SetPos( pos )
	
	return ent
end

if SERVER then
	
	function ITEM:CanPickup( pl, ent )	
		return true
	end
end