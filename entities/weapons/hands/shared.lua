if SERVER then
AddCSLuaFile("shared.lua")
end

if CLIENT then
SWEP.PrintName = "Hands"
SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
end

SWEP.Author = "NeonElectron"
SWEP.Instructions = "non threatening"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""


if CLIENT then
SWEP.FrameVisible = false
end

function SWEP:Initialize()
 self:SetWeaponHoldType("normal") 
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:Think()

end

function SWEP:PrimaryAttack()

end

function SWEP:SecondaryAttack()

end

function SWEP:DrawHUD()

end
