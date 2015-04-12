Anotifications = {}	

module("anotify",package.seeall)

function Create(text,tim,color)
	local num = #Anotifications+1
	Anotifications[num] = vgui.Create("anot_panel")
	Anotifications[num]:SetText(text)
	Anotifications[num]:SetTime(tim)
	
end

function Update()

for k,v in pairs(Anotifications) do
if( !IsValid(v)) then
Anotifications[k] = nil
end
end


end
hook.Add("Think","UpdateAnotes",Update)