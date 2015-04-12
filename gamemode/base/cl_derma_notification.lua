surface.CreateFont( "anot_f", {
	font = "Coolvetica",
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


local PANEL = {}

function PANEL:Init()
	self.text = ""
	self:SetPos(0,-ScrH()*0.3)
	self:SetSize(ScrW(),ScrH()*0.04)
	self.color = Color(43,44,36,190)
	self.time = 5
	surface.PlaySound("ui/beep22.wav")
end

function PANEL:Paint(w,h)
	draw.RoundedBox(6,0,0,w,h,self.color)
	draw.DrawText(self.text,"anot_f",w/2,h*0.2,color_white,TEXT_ALIGN_CENTER)
end
function PANEL:SetText(t)
	self.text = t
end
function PANEL:SetTime(t)
	self.time = t
end

function PANEL:Close()
	
	
		self:MoveTo( 0, -ScrH()*0.1, 1, 0, 1,nil )
		timer.Simple(5,function()
			self:Remove()
			end)	

	self:OnClose()

		
end

function PANEL:OnClose()


end


function PANEL:PerformLayout()
	local w = surface.GetTextSize(self.text)
		self:SetSize(w*1.5,ScrH()*0.04)
		self:MoveTo( ScrW()/2-(w*0.7), ScrH()*0.001, 1, 0, 1,nil )
		timer.Simple(self.time,function() self:Close() end)
end

vgui.Register( "anot_panel", PANEL )