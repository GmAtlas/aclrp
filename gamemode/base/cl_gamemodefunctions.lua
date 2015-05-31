local AKeyBinds = {
	["gm_showhelp"] = "ShowHelp",
	["gm_showteam"] = "ShowTeam",
	["gm_showspare1"] = "ShowSpare1",
	["gm_showspare2"] = "ShowSpare2"
}

function draw.OutlinedBox( x, y, w, h, thickness, clr )
	surface.SetDrawColor( clr )
	for i=0, thickness - 1 do
		surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
	end
end


function GM:PlayerBindPress(ply, bind, pressed)
	self.BaseClass:PlayerBindPress(ply, bind, pressed)

	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")
	if bnd and AKeyBinds[bnd] then
		hook.Call(AKeyBinds[bnd], GAMEMODE)
	end
end

function Keys()

print("f2")
end
timer.Simple(0, function() GAMEMODE.ShowTeam = Keys end)