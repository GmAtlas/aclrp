
local ScrW,ScrH = ScrW(),ScrH()
print(ScrW,ScrH)
local healthi = Material("lerp/Health_Icon.png")
local walleti = Material("lerp/Wallet_Icon.png")
local salaryi = Material("lerp/Salary_Icon.png")
local hungeri = Material("lerp/Hunger_Icon.png")

surface.CreateFont( "ACLRP_HUD_HP", {
	font = "Arial",
	size = 20,
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

surface.CreateFont( "pixel_berry", {
	font = "olney_light",
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
	
	-- HEALTH --
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( healthi ) 
	surface.DrawTexturedRect( 10, ScrH-50, 32,32 )
	
	surface.SetDrawColor(46, 204, 113,60)
	surface.DrawRect(45, ScrH-50, math.Clamp(LocalPlayer():Health(),0,100)*2 ,32)
	surface.SetDrawColor(39, 174, 96)
	surface.DrawOutlinedRect(45, ScrH-50, 200 ,32)
	
	draw.SimpleText(LocalPlayer():Health(),"ACLRP_HUD_HP",130,ScrH-33,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

	-- HUNGER --	

	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( hungeri ) 
	surface.DrawTexturedRect( 10, ScrH-50-32-10, 32,32 )
	
	surface.SetDrawColor(241, 196, 15,60)
	surface.DrawRect(45, ScrH-50-32-10, math.Clamp(LocalPlayer():GetValue("hunger",100),0,100)*2 ,32)
	surface.SetDrawColor(230, 126, 34)
	surface.DrawOutlinedRect(45, ScrH-50-32-10, 200 ,32)
	
	draw.SimpleText(LocalPlayer():GetValue("hunger",100),"ACLRP_HUD_HP",130,ScrH-50-26,color_white,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
	
	-- Wallet -- 
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( walleti ) 
	surface.DrawTexturedRect( 10, ScrH-90-32-10, 36,36 )
	
	surface.SetDrawColor(52, 152, 219,60)
	surface.DrawRect(45, ScrH-90-32-10, 200 ,32)
	surface.SetDrawColor(41, 128, 185)
	surface.DrawOutlinedRect(45, ScrH-90-32-10, 200 ,32)
	
	draw.SimpleText("$"..LocalPlayer():GetValue("wallet",100),"ACLRP_HUD_HP",140,ScrH-100-26,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_LEFT)
	
	-- SALARY --
	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial( salaryi ) 
	surface.DrawTexturedRect( 10, ScrH-130-32-10, 32,32 )
	
	surface.SetDrawColor(231, 76, 60,60)
	surface.DrawRect(45, ScrH-130-32-10, 200 ,32)
	surface.SetDrawColor(192, 57, 43)
	surface.DrawOutlinedRect(45, ScrH-130-32-10, 200 ,32)
draw.SimpleText("$"..LocalPlayer():GetValue("salary",100),"ACLRP_HUD_HP",140,ScrH-140-26,color_white,TEXT_ALIGN_CENTER,TEXT_ALIGN_LEFT)

	local tr = util.GetPlayerTrace( LocalPlayer() )
	local trace = util.TraceLine( tr )
	if (!trace.Hit) then return end
	if (!trace.HitNonWorld) then return end

	local text = ""
	local font = "pixel_berry"
	
	if (trace.Entity:IsPlayer()) then
		text = trace.Entity:Nick()
	else
		return
		
	end

	  local healthcolors = {
      healthy = Color(0,255,0,255),
      hurt    = Color(170,230,10,255),
      wounded = Color(230,215,10,255),
      badwound= Color(255,140,0,255),
      death   = Color(255,0,0,255)}
 

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	
	local MouseX, MouseY = gui.MousePos()
	
	if ( MouseX == 0 && MouseY == 0 ) then
	
		MouseX = ScrW / 2
		MouseY = ScrH / 2
	
	end
	
	local x = MouseX
	local y = MouseY
	
	x = x - w / 2
	y = y + 30

	
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )
	
	y = y + h + 5
	
	local text = trace.Entity:Health() .. "%"

	function HealthToString(health)
      if health > 90 then
         return  healthcolors.healthy
      elseif health > 70 then
         return  healthcolors.hurt
      elseif health > 45 then
         return  healthcolors.wounded
      elseif health > 20 then
         return  healthcolors.badwound
      else
         return  healthcolors.death
      end
   end


	local w, h = surface.GetTextSize( text )
	local x =  MouseX  - w / 2
	

	draw.SimpleText( trace.Entity:Health(), font, x, y,    HealthToString(trace.Entity:Health()) )


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


RegisterLuaAnimation('aclrp_fap', {
	FrameData = {
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = 11.6127
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 2
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					MF = 0.9034,
					RR = 0.9463,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					MF = 0.9034,
					RR = -6.7688,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					MF = 0.9034,
					RR = -6.7688,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					MF = 0.9034,
					RR = -6.7688,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = 17.8533
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -12.8273
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					RR = -42.7928,
					MF = 0.5626
				}
			},
			FrameRate = 5
		},
		{
			BoneInfo = {
				['ValveBiped.Bip01_L_UpperArm'] = {
					RU = -8.8588,
					RR = -6.7688,
					MF = 0.9034,
					RF = -87.3982
				},
				['ValveBiped.Bip01_L_Hand'] = {
					RU = 3.3633,
					MF = 0.5626,
					RR = -42.7928
				},
				['ValveBiped.Bip01_L_Forearm'] = {
					RU = -26.9439,
					RR = 10.9677
				}
			},
			FrameRate = 5
		}
	},
	Type = TYPE_GESTURE
})
Entity(1):SetLuaAnimation("aclrp_fap")
Entity(1):StopLuaAnimation(8)

