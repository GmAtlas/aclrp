ENT.Type            = "ai"
ENT.Base            = "base_ai"

ENT.PrintName       = "Entity Shop"
ENT.Author          = "Nemo"
ENT.Contact         = ""
ENT.Purpose         = ""
ENT.Instructions    = ""
ENT.Category        = "Shop"
ENT.Spawnable       = true

 
function ENT:SetAutomaticFrameAdvance( bUsingAnim ) 
	self.AutomaticFrameAdvance = bUsingAnim
end

