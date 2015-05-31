ITEM.Name = "Money"
ITEM.Description = "Lods of emone.\n\nAmount: $%d"
ITEM.Model = "models/props/cs_assault/money.mdl"
ITEM.Base = "base_aclrp"

function ITEM:GetDescription()
	return string.format( self.Description, self:GetData( "Amount" ) )
end

function ITEM:Use( pl )
	pl:AddMoney( self:GetData( "Amount" ) )
	
	return true
end

function ITEM:SaveData( ent )
	self:SetData( "Amount", ent:Getamount() )
end

function ITEM:LoadData( ent )
	ent:Setamount( self:GetData( "Amount" ) )
end