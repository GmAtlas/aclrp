include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end



local function Draw(self)
	self:DrawModel()
	
	local p = self:GetPos() + Vector(0,0,80)
	
		for _,ent in pairs(ents.FindInSphere(self:GetPos(),500)) do
		if ent:GetClass() == "player" then
		Yaw = (ent:GetPos() - self:GetPos()):Angle().yaw
		a = math.ApproachAngle(self:GetAngles().yaw,Yaw,5)
		local ang = Angle(0, a+90, 90)
		cam.Start3D2D(p, ang, 0.3)
			draw.DrawText("Phelynx's Tilet Shop", "default", 0, 0, Color(200, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()
		end	
	end
end


net.Receive("Shop",function(lel)
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	ent.RenderOverride = Draw
end)


function points(ply)
local points = ply:ReadFloat()
chat.AddText(Color(255,0,0),"[Tilets]",Color(0,255,0),"You now have "..points.." Tilets!")
LocalPlayer():EmitSound("garrysmod/save_load1.wav",100,100)
end
usermessage.Hook("Point",points)







function Rents()

Frame = vgui.Create("DFrame")
Frame:SetSize(300,200)
Frame:SetPos(50,50)
Frame:MakePopup()
Frame:SetTitle("Shop Menu")
Frame.Paint = function()
draw.RoundedBox( 6, 0, 0, Frame:GetWide(), Frame:GetTall(), Color( 255, 255, 255, 150 ) )
end
Button = vgui.Create("DButton",Frame)
Button:SetPos(20,30)
Button:SetText("Buy")
Button.DoClick = function()

RunConsoleCommand("buyapartment")
end


Button2 = vgui.Create("DButton",Frame)
Button2:SetPos(210,30)
Button2:SetText("Load")
Button2.DoClick = function()
RunConsoleCommand("loadapartment")
end

end

