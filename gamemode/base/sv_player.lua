--[[
Player Manager
--]]

function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
	
	if ( !phys:IsMoveable() ) then return false end
	if ( ent:GetUnFreezable() ) then return false end
	
	phys:EnableMotion( false )
	
	if ( ent:GetClass() == "prop_vehicle_jeep" ) then
	
		local objects = ent:GetPhysicsObjectCount()
		
		for i = 0, objects - 1 do
		
			local physobject = ent:GetPhysicsObjectNum( i )
			physobject:EnableMotion( false )
		
		end
	
	end

	ply:AddFrozenPhysicsObject( ent, phys )
	
	return true

end


function GM:OnPhysgunReload( weapon, ply )

	ply:PhysgunUnfreeze( weapon )

end

function GM:PlayerAuthed( ply, SteamID, UniqueID )
end

function GM:PlayerCanPickupWeapon( player, entity )

	return true

end


function GM:PlayerCanPickupItem( player, entity )

	return true

end


function GM:CanPlayerUnfreeze( ply, entity, physobject )

	return true

end


function GM:PlayerDisconnected( player )
end


function GM:PlayerSay( player, text, teamonly )

	return text

end



function GM:PlayerDeathThink( pl )

	if ( pl.NextSpawnTime && pl.NextSpawnTime > CurTime() ) then return end

	if ( pl:KeyPressed( IN_ATTACK ) || pl:KeyPressed( IN_ATTACK2 ) || pl:KeyPressed( IN_JUMP ) ) then
	
		pl:Spawn()
	
	end
	
end


function GM:PlayerUse( pl, entity )

	return true

end


function GM:PlayerSilentDeath( Victim )

	Victim.NextSpawnTime = CurTime() + 5
	Victim.DeathTime = CurTime()

end

-- Pool network strings used for PlayerDeaths.
util.AddNetworkString( "PlayerKilled" )
util.AddNetworkString( "PlayerKilledSelf" )
util.AddNetworkString( "PlayerKilledByPlayer" )


function GM:PlayerDeath( ply, inflictor, attacker )

	-- Don't spawn for at least 2 seconds
	ply.NextSpawnTime = CurTime() + 2
	ply.DeathTime = CurTime()
	
	if ( IsValid( attacker ) && attacker:GetClass() == "trigger_hurt" ) then attacker = ply end
	
	if ( IsValid( attacker ) && attacker:IsVehicle() && IsValid( attacker:GetDriver() ) ) then
		attacker = attacker:GetDriver()
	end

	if ( !IsValid( inflictor ) && IsValid( attacker ) ) then
		inflictor = attacker
	end

	
	if ( IsValid( inflictor ) && inflictor == attacker && ( inflictor:IsPlayer() || inflictor:IsNPC() ) ) then
	
		inflictor = inflictor:GetActiveWeapon()
		if ( !IsValid( inflictor ) ) then inflictor = attacker end

	end

	if ( attacker == ply ) then
	
		net.Start( "PlayerKilledSelf" )
			net.WriteEntity( ply )
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " suicided!\n" )
		
	return end

	if ( attacker:IsPlayer() ) then
	
		net.Start( "PlayerKilledByPlayer" )
		
			net.WriteEntity( ply )
			net.WriteString( inflictor:GetClass() )
			net.WriteEntity( attacker )
		
		net.Broadcast()
		
		MsgAll( attacker:Nick() .. " killed " .. ply:Nick() .. " using " .. inflictor:GetClass() .. "\n" )
		
	return end
	
	net.Start( "PlayerKilled" )
	
		net.WriteEntity( ply )
		net.WriteString( inflictor:GetClass() )
		net.WriteString( attacker:GetClass() )

	net.Broadcast()
	
	MsgAll( ply:Nick() .. " was killed by " .. attacker:GetClass() .. "\n" )
	
end


function GM:PlayerInitialSpawn( pl )

	pl:SetTeam( 1 )
	 player_manager.SetPlayerClass(pl,"player_lerp")
	if ( GAMEMODE.TeamBased ) then
		pl:ConCommand( "gm_showteam" )
	end

end

function GM:PlayerSpawnAsSpectator( pl )

	pl:StripWeapons()
	
	if ( pl:Team() == TEAM_UNASSIGNED ) then
	
		pl:Spectate( OBS_MODE_FIXED )
		return
		
	end

	pl:SetTeam( TEAM_SPECTATOR )
	pl:Spectate( OBS_MODE_ROAMING )

end


function GM:PlayerSpawn( pl )


	if ( GAMEMODE.TeamBased && ( pl:Team() == TEAM_SPECTATOR || pl:Team() == TEAM_UNASSIGNED ) ) then

		GAMEMODE:PlayerSpawnAsSpectator( pl )
		return
	
	end

	
	pl:UnSpectate()

	pl:SetupHands()

	player_manager.OnPlayerSpawn( pl )
	player_manager.RunClass( pl, "Spawn" )

	hook.Call( "PlayerLoadout", GAMEMODE, pl )
	
	hook.Call( "PlayerSetModel", GAMEMODE, pl )

end


function GM:PlayerSetModel( pl )

	player_manager.RunClass( pl, "SetModel" )

end


function GM:PlayerSetHandsModel( pl, ent )

	local info = player_manager.RunClass( pl, "GetHandsModel" )
	if ( !info ) then
		local playermodel = player_manager.TranslateToPlayerModelName( pl:GetModel() )
		info = player_manager.TranslatePlayerHands( playermodel )
	end

	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end


function GM:PlayerLoadout( pl )

	player_manager.RunClass( pl, "Loadout" )

end


function GM:PlayerSelectTeamSpawn( TeamID, pl )

	local SpawnPoints = team.GetSpawnPoints( TeamID )
	if ( !SpawnPoints || table.Count( SpawnPoints ) == 0 ) then return end
	
	local ChosenSpawnPoint = nil
	
	for i = 0, 6 do
	
		local ChosenSpawnPoint = table.Random( SpawnPoints )
		if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == 6 ) ) then
			return ChosenSpawnPoint
		end
	
	end
	
	return ChosenSpawnPoint

end



function GM:IsSpawnpointSuitable( pl, spawnpointent, bMakeSuitable )

	local Pos = spawnpointent:GetPos()
	

	local Ents = ents.FindInBox( Pos + Vector( -16, -16, 0 ), Pos + Vector( 16, 16, 64 ) )
	
	if ( pl:Team() == TEAM_SPECTATOR ) then return true end
	
	local Blockers = 0
	
	for k, v in pairs( Ents ) do
		if ( IsValid( v ) && v != pl && v:GetClass() == "player" && v:Alive() ) then
		
			Blockers = Blockers + 1
			
			if ( bMakeSuitable ) then
				v:Kill()
			end
			
		end
	end
	
	if ( bMakeSuitable ) then return true end
	if ( Blockers > 0 ) then return false end
	return true

end


function GM:PlayerSelectSpawn( pl )

	if ( GAMEMODE.TeamBased ) then
	
		local ent = GAMEMODE:PlayerSelectTeamSpawn( pl:Team(), pl )
		if ( IsValid( ent ) ) then return ent end
	
	end

	if ( !IsTableOfEntitiesValid( self.SpawnPoints ) ) then
	
		self.LastSpawnPoint = 0
		self.SpawnPoints = ents.FindByClass( "info_player_start" )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_combine" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_rebel" ) )
		
		-- CS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_counterterrorist" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_terrorist" ) )
		
		-- DOD Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_axis" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_allies" ) )

		-- (Old) GMod Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "gmod_player_start" ) )
		
		-- TF Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_teamspawn" ) )
		
		-- INS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "ins_spawnpoint" ) )

		-- AOC Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "aoc_spawnpoint" ) )

		-- Dystopia Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "dys_spawn_point" ) )

		-- PVKII Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_pirate" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_viking" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_knight" ) )

		-- DIPRIP Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_blue" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "diprip_start_team_red" ) )

		-- OB Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_red" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_blue" ) )

		-- SYN Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_coop" ) )

		-- ZPS Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_human" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombie" ) )

		-- ZM Maps
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_deathmatch" ) )
		self.SpawnPoints = table.Add( self.SpawnPoints, ents.FindByClass( "info_player_zombiemaster" ) )

	end
	
	local Count = table.Count( self.SpawnPoints )
	
	if ( Count == 0 ) then
		Msg("[PlayerSelectSpawn] Error! No spawn points!\n")
		return nil
	end


	for k, v in pairs( self.SpawnPoints ) do
		
		if ( v:HasSpawnFlags( 1 ) && hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, v, true ) ) then
			return v
		end
		
	end
	
	local ChosenSpawnPoint = nil

	for i = 1, Count do

		ChosenSpawnPoint = table.Random( self.SpawnPoints )

		if ( IsValid( ChosenSpawnPoint ) && ChosenSpawnPoint:IsInWorld() ) then
			if ( ( ChosenSpawnPoint == pl:GetVar( "LastSpawnpoint" ) || ChosenSpawnPoint == self.LastSpawnPoint ) && Count > 1 ) then continue end
			
			if ( hook.Call( "IsSpawnpointSuitable", GAMEMODE, pl, ChosenSpawnPoint, i == Count ) ) then
			
				self.LastSpawnPoint = ChosenSpawnPoint
				pl:SetVar( "LastSpawnpoint", ChosenSpawnPoint )
				return ChosenSpawnPoint
			
			end
			
		end
		
	end
	
	return ChosenSpawnPoint

end

function GM:WeaponEquip( weapon )
end


function GM:ScalePlayerDamage( ply, hitgroup, dmginfo )

	if ( hitgroup == HITGROUP_HEAD ) then
	
		dmginfo:ScaleDamage( 2 )
	
	end
	
	
	if ( hitgroup == HITGROUP_LEFTARM ||
		 hitgroup == HITGROUP_RIGHTARM ||
		 hitgroup == HITGROUP_LEFTLEG ||
		 hitgroup == HITGROUP_RIGHTLEG ||
		 hitgroup == HITGROUP_GEAR ) then
	
		dmginfo:ScaleDamage( 0.25 )
	
	end

end


function GM:PlayerDeathSound()
	return false
end


function GM:SetupPlayerVisibility( pPlayer, pViewEntity )
	--AddOriginToPVS( vector_position_here )
end


function GM:OnDamagedByExplosion( ply, dmginfo )
	ply:SetDSP( 35, false )
end


function GM:CanPlayerSuicide( ply )
	return true
end
function GM:PlayerLeaveVehicle( ply, veichle )
end


function GM:CanExitVehicle( veichle, passenger )
	return true
end


function GM:PlayerSwitchFlashlight( ply, SwitchOn )
	return ply:CanUseFlashlight()
end


function GM:PlayerCanJoinTeam( ply, teamid )
	
	local TimeBetweenSwitches = GAMEMODE.SecondsBetweenTeamSwitches or 10
	if ( ply.LastTeamSwitch && RealTime()-ply.LastTeamSwitch < TimeBetweenSwitches ) then
		ply.LastTeamSwitch = ply.LastTeamSwitch + 1
		ply:ChatPrint( Format( "Please wait %i more seconds before trying to change team again", ( TimeBetweenSwitches - ( RealTime() - ply.LastTeamSwitch ) ) + 1 ) )
		return false
	end
	
	
	if ( ply:Team() == teamid ) then
		ply:ChatPrint( "You're already on that team" )
		return false
	end
	
	return true
	
end


function GM:PlayerRequestTeam( ply, teamid )


	if ( !GAMEMODE.TeamBased ) then return end
	
	
	if ( !team.Joinable( teamid ) ) then
		ply:ChatPrint( "You can't join that team" )
	return end
	
	if ( !GAMEMODE:PlayerCanJoinTeam( ply, teamid ) ) then
	
	return end
	
	GAMEMODE:PlayerJoinTeam( ply, teamid )

end


function GM:PlayerJoinTeam( ply, teamid )

	local iOldTeam = ply:Team()
	
	if ( ply:Alive() ) then
		if ( iOldTeam == TEAM_SPECTATOR || iOldTeam == TEAM_UNASSIGNED ) then
			ply:KillSilent()
		else
			ply:Kill()
		end
	end

	ply:SetTeam( teamid )
	ply.LastTeamSwitch = RealTime()
	
	GAMEMODE:OnPlayerChangedTeam( ply, iOldTeam, teamid )

end


function GM:OnPlayerChangedTeam( ply, oldteam, newteam )


	if ( newteam == TEAM_SPECTATOR ) then
	
		local Pos = ply:EyePos()
		ply:Spawn()
		ply:SetPos( Pos )
		
	elseif ( oldteam == TEAM_SPECTATOR ) then
	
	
		ply:Spawn()
	
	else
	
	
	end
	
	PrintMessage( HUD_PRINTTALK, Format( "%s joined '%s'", ply:Nick(), team.GetName( newteam ) ) )
	
end


function GM:PlayerSpray( ply )

	return false

end


function GM:OnPlayerHitGround( ply, bInWater, bOnFloater, flFallSpeed )
	

end


function GM:GetFallDamage( ply, flFallSpeed )

	if( GetConVarNumber( "mp_falldamage" ) > 0 ) then -- realistic fall damage is on
		return ( flFallSpeed - 526.5 ) * ( 100 / 396 ) -- the Source SDK value
	end
	
	return 10

end


function GM:PlayerCanSeePlayersChat( strText, bTeamOnly, pListener, pSpeaker )

	if ( bTeamOnly ) then
		if ( !IsValid( pSpeaker ) || !IsValid( pListener ) ) then return false end
		if ( pListener:Team() != pSpeaker:Team() ) then return false end
	end
	
	return true

end

local sv_alltalk = GetConVar( "sv_alltalk" )

--[[---------------------------------------------------------
	Name: gamemode:PlayerCanHearPlayersVoice()
	Desc: Can this player see the other player's voice?
		Returns 2 bools.
		1. Can the player hear the other player
		2. Can they hear them spacially
-----------------------------------------------------------]]
function GM:PlayerCanHearPlayersVoice( pListener, pTalker )

	local alltalk = sv_alltalk:GetInt()
	if ( alltalk >= 1 ) then return true, alltalk == 2 end

	return pListener:Team() == pTalker:Team(), false

end


function GM:NetworkIDValidated( name, steamid )

	 MsgN( "GM:NetworkIDValidated", name, steamid )
	ServerLog("NetworkIDValidated "..name.." "..steamid)
end

function GM:PlayerShouldTaunt( ply, actid )

	return true

end

function GM:PlayerStartTaunt( ply, actid, length )
end

function GM:AllowPlayerPickup( ply, object )



	return true

end


function GM:PlayerButtonDown( ply, btn ) end
function GM:PlayerButtonUp( ply, btn ) end

concommand.Add( "changeteam", function( pl, cmd, args ) hook.Call( "PlayerRequestTeam", GAMEMODE, pl, tonumber( args[ 1 ] ) ) end )
