include("shared.lua")
AddCSLuaFile("shared.lua")

if SERVER then  return end
	local compmusic = {}

function compmusic.Create()
	return setmetatable({}, compmusic.Meta)
end

local compmusic_meta = {}
compmusic_meta.__index = compmusic_meta

compmusic.Meta = compmusic_meta



function compmusic_meta:PlayURL(url, a)
	sound.PlayURL ( url, "3d", function( station )
	if ( IsValid( station ) ) then
	self.station = station
		self.station:Play()
		self.station:SetVolume(1)
		self.station:SetPos(a)
			
	else

		LocalPlayer():ChatPrint( "Invalid URL!" )

	end
end )
	
end

function compmusic_meta:StopURL()
	
	self.station:Stop()
	
end
function compmusic_meta:SetVol(num)
	
	self.station:SetVolume(num)
	
end

function compmusic_meta:Pause()
	self.station:Pause()
end

function compmusic_meta:Play()
	self.station:Play()
end

function compmusic_meta:Stop()
	self.station:Stop()
end
function compmusic_meta:Shutdown()
	self.station:Stop()
	self.station = nil
	self.radio = nil
end

function compmusic_meta:SetPos(pos)
	self.station:SetPos(pos)
end
local BANDS	= 100
function DrawSpectrum( channel, w, h )

	-- Background
	surface.SetDrawColor( Color(100,100,100,100) )
	surface.DrawRect( 0, 0, w, h )

	if channel:GetState() ~= GMOD_CHANNEL_PLAYING then
		return
	end
		

	local fft = {}
	channel:FFT( fft, FFT_2048 )
	local b0 = 1

	-- surface.SetDrawColor(VisualizerBarColor)

	local x, y
	
	

	for x = 0, BANDS do
		local sum = 0
		local sc = 0
		local b1 = math.pow(2,x*4.0/(BANDS-1))

		if (b1>2048) then b1=2048 end
		if (b1<=b0) then b1=b0+1 end
		sc=10+b1-b0;
		while b0 < b1 do
			sum = sum + fft[b0]
			b0 = b0 + 1
		end

		y = (math.sqrt(sum/math.log10(sc))*1.7*h)-4
		y = math.Clamp(y, 0, h)

		local col = HSVToColor( 120 - (120 * y/h) , 120 - (120 * y/h) , 1 )
		surface.SetDrawColor(col)
	
		surface.DrawRect(
			math.ceil(x*(w/BANDS)*0.8),
			math.ceil(h - y - 1),
			math.ceil(w/BANDS) - 2,
			y + 1
		)
		
	end
	
end


function ENT:Draw()

self:DrawModel()
if(self.radio.station) then
local pos = self:GetPos()
local ang = self:GetAngles()
local ang2 = ang
ang2:RotateAroundAxis(ang2:Forward(),90)
cam.Start3D2D(pos+ang:Right()*-78+ang:Forward()*-75,ang2,0.5)
DrawSpectrum( self.radio.station, 300, 150 )
cam.End3D2D()
end
end



function ENT:Initialize()
self.radio = self.radio or compmusic.Create()
self.radio:PlayURL("http://yp.shoutcast.com/sbin/tunein-station.pls?id=99181824&play_status=1",self:GetPos())

end


function ENT:Think()
if(self.radio.station) then
self.radio:SetPos(self:GetPos() )
end

end

function ENT:OnRemove()
self.radio:Shutdown()

end


