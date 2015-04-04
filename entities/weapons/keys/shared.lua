if SERVER then
AddCSLuaFile("shared.lua")
end

if CLIENT then
SWEP.PrintName = "Keys"
SWEP.Slot = 1
SWEP.SlotPos = 3
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
end

SWEP.Author = ""
SWEP.Instructions = "Left click to lock. Right click to unlock"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "rpg"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

Text = ""
Message = ""
Alpha = 0

if CLIENT then
SWEP.FrameVisible = false
end

function SWEP:Initialize()
if SERVER then self:SetWeaponHoldType("normal") end
end

function SWEP:Deploy()
if SERVER then
self.Owner:DrawViewModel(false)
self.Owner:DrawWorldModel(false)
end
end

function SWEP:Think()
if CLIENT then return end
local trace = self.Owner:GetEyeTrace()
if not IsValid(trace.Entity) then return end
if trace.Entity:GetClass() != "prop_door_rotating" then return end
if trace.Entity:GetNWString("DOwner") == nil or trace.Entity:GetNWString("DOwner") == "" then  end
end

function SWEP:PrimaryAttack()
local trace = self.Owner:GetEyeTrace()

if not IsValid(trace.Entity) then
return
end

if trace.Entity:GetClass() != "prop_door_rotating" and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 65 then
return
end

if trace.Entity:GetNWString("DOwner") != self.Owner:SteamID() then
Message = "This is not your door!" 
return 
end

Message = "Locked"

if SERVER then
if(!trace.Entity:GetNWString("DOwner") == self.Owner:SteamID()) then return end
trace.Entity:Fire("lock", "", 0)
self.Owner:EmitSound(self.Sound,50)
self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
end
end

function SWEP:SecondaryAttack()
local trace = self.Owner:GetEyeTrace()

if not IsValid(trace.Entity) then
return
end

if trace.Entity:GetClass() != "prop_door_rotating" and self.Owner:EyePos():Distance(trace.Entity:GetPos()) > 65 then
return
end

if trace.Entity:GetNWString("DOwner") != self.Owner:SteamID() then
Message = "This is not your door!" 
return 
end

Message = "Unlocked"

if SERVER then
if(!trace.Entity:GetNWString("DOwner") == self.Owner:SteamID()) then return end
trace.Entity:Fire("unlock", "", 0)
self.Owner:EmitSound(self.Sound,70)
self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
end
end

function SWEP:DrawHUD()
if Text != Message then Alpha = 255 end
Alpha = Alpha - 3 
draw.DrawText(Text,"TargetID", ScrW()/2, ScrH()*0.66, Color( 255,255,255,Alpha), TEXT_ALIGN_CENTER )
Text = Message
end
