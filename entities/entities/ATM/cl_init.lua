include("shared.lua")
AddCSLuaFile("init.lua")

if SERVER then 
return end

 Open = 0


local function MenuATM()

net.Start("atmneed")
net.WriteEntity(LocalPlayer())
net.SendToServer()


Open = 1
local Frame = vgui.Create("DFrame")
Frame:SetSize(400,400)
Frame:MakePopup( true )
Frame:Center()

net.Receive("atmreturn",function()
DLab = vgui.Create("DLabel",Frame)
DLab:SetPos(160,30)
DLab:SetText("Balance: $"..net.ReadString())
DLab:SizeToContents()
end)

local Text = vgui.Create("DTextEntry", Frame)
Text:SetText("100")
Text:SetPos(160,50)

local button = vgui.Create( "DButton", Frame )
	button:SetSize( 100, 30 )
	button:SetPos( 150, 90 )
	button:SetText( "Deposit" )
	button.DoClick = function( button )
		if(!Text:GetValue() ) then  return end
		RunConsoleCommand("Deposit",Text:GetValue())		

net.Start("atmneed")
net.WriteEntity(LocalPlayer())
net.SendToServer()
net.Receive("atmreturn",function()
DLab:SetText("Balance: $"..net.ReadString())
DLab:SizeToContents()
end)
	

end


local button2 = vgui.Create( "DButton", Frame )
	button2:SetSize( 100, 30 )
	button2:SetPos( 150, 130 )
	button2:SetText( "Withdraw" )
	button2.DoClick = function( button2 )
		if(!Text:GetValue() ) then  return end
		RunConsoleCommand("withdraw",Text:GetValue())		

net.Start("atmneed")
net.WriteEntity(LocalPlayer())
net.SendToServer()
net.Receive("atmreturn",function()
DLab:SetText("Balance: $"..net.ReadString())
DLab:SizeToContents()
end)
	


	end




end






function OpenATM()
if Open == 0 then
MenuATM()
end

timer.Simple(1,function()

Open = 0
end)




end