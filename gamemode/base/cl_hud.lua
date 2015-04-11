--[[]]--

local ScrW,ScrH = ScrW(),ScrH()
local healthi = Material("lerp/Health_Icon.png")
local walleti = Material("lerp/Wallet_Icon.png")
local salaryi = Material("lerp/Salary_Icon.png")
local hungeri = Material("lerp/Hunger_Icon.png")

surface.CreateFont( "ACLRP_HUD_HP", {
	font = "Arial",
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )


function GM:HUDPaint()
surface.SetDrawColor(43,44,36,190)
surface.DrawRect(ScrW*0.01,ScrH*0.78,ScrW*0.2,ScrH*0.2)	

surface.SetDrawColor(255,255,255,255)
surface.SetMaterial(healthi)
surface.DrawTexturedRect(ScrW*0.015,ScrH*0.82,ScrW*0.02,ScrH*0.03)

surface.SetDrawColor(255,255,255,255)
surface.SetMaterial(hungeri)
surface.DrawTexturedRect(ScrW*0.015,ScrH*0.86,ScrW*0.02,ScrH*0.03)

surface.SetDrawColor(255,255,255,255)
surface.SetMaterial(salaryi)
surface.DrawTexturedRect(ScrW*0.015,ScrH*0.9,ScrW*0.02,ScrH*0.03)
draw.DrawText("Salary: ","ACLRP_HUD_HP",ScrW*0.057,ScrH*0.9,color_white,TEXT_ALIGN_CENTER)
draw.DrawText("$"..LocalPlayer():GetValue("salary",GAMEMODE.Config.basesalary),"ACLRP_HUD_HP",ScrW*0.1,ScrH*0.9,color_white,TEXT_ALIGN_RIGHT)

surface.SetDrawColor(255,255,255,255)
surface.SetMaterial(walleti)
surface.DrawTexturedRect(ScrW*0.015,ScrH*0.94,ScrW*0.02,ScrH*0.03)

draw.DrawText("Wallet: ","ACLRP_HUD_HP",ScrW*0.057,ScrH*0.94,color_white,TEXT_ALIGN_CENTER)
draw.DrawText("$"..LocalPlayer():GetValue("wallet",0),"ACLRP_HUD_HP",ScrW*0.08,ScrH*0.94,color_white)

draw.DrawText(team.GetName(LocalPlayer():Team()),"ACLRP_HUD_HP",ScrW*0.112,ScrH*0.785,color_white,TEXT_ALIGN_CENTER)

-- hp bar

draw.DrawText(LocalPlayer():Health(),"ACLRP_HUD_HP",ScrW*0.11,ScrH*0.823,color_white,TEXT_ALIGN_CENTER)

local health = LocalPlayer():Health()
local maxhealth = 100
local healthratio = math.Round(health*10/maxhealth)/60
surface.SetDrawColor(100, 141, 45,170)
surface.DrawRect(ScrW*0.037,ScrH*0.82,ScrW*healthratio,ScrH*0.03)

draw.DrawText(LocalPlayer():GetValue("hunger",100),"ACLRP_HUD_HP",ScrW*0.11,ScrH*0.863,color_white,TEXT_ALIGN_CENTER)

local hunger = LocalPlayer():GetValue("hunger",100)
local maxhunger = 100
local hungerratio = math.Round(hunger*10/maxhunger)/60
surface.SetDrawColor(245, 215, 110,170)
surface.DrawRect(ScrW*0.037,ScrH*0.86,ScrW*hungerratio,ScrH*0.03)

if(LocalPlayer():GetValue("warrent",nil) != nil) then
	
	draw.DrawText(LocalPlayer():GetValue("warrentreason",""),"ACLRP_HUD_HP",ScrW*0.5,ScrH*0.5,color_white,TEXT_ALIGN_CENTER)
	
end

end





local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then
		return false
	end

end )