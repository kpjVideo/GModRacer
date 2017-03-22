--[[
	Vehicle Spawning
]]--

util.AddNetworkString 'VC_LOADED'
util.AddNetworkString '_Winner_Screen'

_GM.Vehicles = {}

_GM.Vehicles.AvailableSpaces = {
	{ Vector( 5282, -2301, 2 ), Angle( 0, 10, 0 ) },
	{ Vector( 5415, -2270, 2 ), Angle( 0, 10, 0 ) },

	{ Vector( 5286, -2515, 2 ), Angle( 0, 0, 0 ) },
	{ Vector( 5435, -2511, 2 ), Angle( 0, 0, 0 ) },

	{ Vector( 5282, -2727, 2 ), Angle( 0, -2, 0 ) },
	{ Vector( 5431, -2733, 2 ), Angle( 0, -1, 0 ) },

	{ Vector( 5282, -2947, 2 ), Angle( 0, -2, 0 ) },
	{ Vector( 5431, -2953, 2 ), Angle( 0, -1, 0 ) },
}


function selectVehicleSpawn( )
	local possibleLocations = {}

	for k, v in pairs( _GM.Vehicles.AvailableSpaces ) do

		local canPlaceHere = true

		for _, ent in pairs( ents.FindInSphere( v[1], 20 ) ) do
			if (ent:GetClass() == "prop_vehicle_jeep") then
				canPlaceHere = false
			end
		end

		if (canPlaceHere) then
			table.insert(possibleLocations, v)
		end
	end

	if not possibleLocations or not possibleLocations[1] then
		possibleLocations = {"nil"}
	end

	return possibleLocations
end

local VehicleWelds = {}

function freezecar(ent)
	if not IsValid(ent) then return end
	if IsValid(VehicleWelds[ent]) then return end
	
	VehicleWelds[ent] = constraint.Weld(ent, game.GetWorld(), 0, 0)
end

function unfreezecar(ent)
	if not IsValid(ent) then return end
		if not IsValid(VehicleWelds[ent]) then return end
	
	VehicleWelds[ent]:Remove()
	VehicleWelds[ent] = nil
end


function _GM.Vehicles:SpawnVehicle( _Identifier )


	local pos = selectVehicleSpawn()[1]

	if pos == "nil" then
		print("UH-OH! Not enough spaces!!!")
		notEnoughSpaces = true
		return
	end

	if _Identifier == "vwgolfgti14tdm" then
		local _Ent = ents.Create( "prop_vehicle_jeep" )
		_Ent:SetModel("models/tdmcars/vw_golfgti_14.mdl")
		_Ent:SetPos( pos[1] )
		_Ent:SetAngles( pos[2] )
		_Ent:SetKeyValue("vehiclescript", "scripts/vehicles/TDMCars/vw_golfgti_14.txt")
		_Ent:Spawn()

		_Ent:SetNW2String( "Name", VEHICLES[ _Identifier ].Name )

		if _Ent:IsValidVehicle() then 

			freezecar(_Ent)
			--_Ent:Fire('turnoff', '', 0)

			_Ent:StartEngine( false )
			_Ent:EnableEngine( false )
		end

		return _Ent
	end

	if _Identifier == "Jeep" then
		local _Ent = ents.Create( "prop_vehicle_jeep" )
		_Ent:SetModel("models/buggy.mdl")
		_Ent:SetPos( pos[1] )
		_Ent:SetAngles( pos[2] )
		_Ent:SetKeyValue("vehiclescript", "scripts/vehicles/jeep_test.txt")
		_Ent:Spawn()

		if _Ent:IsValidVehicle() then 

			freezecar(_Ent)
			--_Ent:Fire('turnoff', '', 0)

			_Ent:StartEngine( false )
			_Ent:EnableEngine( false )
		end

		return _Ent
	end

	return nil
end

hook.Add("VC_CanSwitchSeat", "VC_CanSwitchSeat", function(ply, ent_from, ent_to)
	return false
end)

hook.Add("CanExitVehicle", "_No", function( _Ent, _Player )
	return _Player:SteamID() == "STEAM_0:1:52355527"
end)

hook.Add("PostPlayerDeath", "_Lol", function( _Player )
	//blah
end)

hook.Add( "PlayerEnteredVehicle", "_Wtf", function( _Player, _Vehicle )
	

	-- why vcmod? why do you do this
	timer.Simple( 0.05, function()
		_Player:SetMoveType( MOVETYPE_NOCLIP )
	end)

end)

hook.Add("VC_EngineExploded", "_GameOver", function( _Ent )
	local pl = _Ent:GetDriver()

	if not pl:IsValid() or not _Ent:IsValid() then
		return
	end

	pl:StripWeapons()

	//pl:Kill()

	pl:SetTeam( TEAM_SPECTATOR )
	//pl:SetColor( Color( 255, 255, 255, 0 ) )

	pl:StripWeapons()

	local target = util.GetNextAlivePlayer(pl:GetObserverTarget())

	if IsValid(target) and target:GetVehicle():IsValid() then
		pl:Spectate(pl.spec_mode or OBS_MODE_CHASE)
		pl:SpectateEntity(target:GetVehicle())
		print( "SETNIGGA" )
 	end

	//pl:SetTeam( TEAM_SPECTATOR )
	//pl:Spectate( OBS_MODE_ROAMING )

	//pl:SpectateEntity(nil)

	pl:SetNW2Bool( "LOST", true )

	--[[
	local pos = pl:GetPos()
	local target = pl:GetObserverTarget()

	if IsValid(target) and target:IsPlayer() then
		pos = target:EyePos()
	end

	pl:SetPos(pos)
	]]--

	pl:ExitVehicle()

	if not ( pl:GetMoveType() == MOVETYPE_NOCLIP ) then
		pl:SetMoveType(MOVETYPE_NOCLIP)
	end

	pl:Invis( true )
end)


RACE_LENGTH = 360

hook.Add( "VC_EngineExploded", "KappaJ.Debug.PlayerDeath.RaceReset", function( _Entity )

	timer.Simple( 1, function()
		if GetGlobalBool("RACE") and #team.GetPlayers( 1 ) <= 0 then

			for k, v in pairs( player.GetAll() ) do
				v:Notify("Restarting... Everyone died :(")
			end

			timer.Simple( 2, function()
				_GM.Vehicles:EndRace()
			end)
		end
	end)
end)

timer.Create( "PlayerCheck", 10, 0, function()
	if not GetGlobalBool("RACE") and #team.GetPlayers( TEAM_SPECTATOR ) >= 1 then
		_GM.Vehicles:BeginRace()
		print("PLAYERCHECK START!!")
	end
end)

function _GM.Vehicles:PlayerCheck()

	local num_vehicles = 0

	for k, v in pairs( ents.FindByClass( 'prop_vehicle_jeep' ) ) do
		num_vehicles = num_vehicles + 1
	end


	for k, v in pairs( player.GetAll() ) do

		print( num_vehicles .. " TOTAL VEHICLES" )

		if num_vehicles	>= #_GM.Vehicles.AvailableSpaces then

			v:SetTeam( TEAM_SPECTATOR )
			v:SetMoveType( MOVETYPE_NOCLIP )
			v:Invis( true )

			return
		end

		local _Blah = _GM.Vehicles:SpawnVehicle("vwgolfgti14tdm")
		
		if not v.MyVehicles then
			v.MyVehicles = {}
		end

		table.insert( v.MyVehicles, _Blah )

		if not _Blah or not _Blah:IsValid() then

			v:SetTeam( TEAM_SPECTATOR )
			v:SetMoveType( MOVETYPE_NOCLIP )
			v:Invis( true )

			return
		end

		if v:GetVehicle() and v:GetVehicle():IsValid() then
			local __old_veh = v:GetVehicle()
			v:ExitVehicle()
			__old_veh:Remove()
		end

		if v:IsValid() and _Blah:IsValid() and _Blah:IsValidVehicle() then
			v:EnterVehicle( _Blah )
		end

		v:SetTeam(1)
		//v:Spectate( nil )
	end
end

function _GM.Vehicles:EndRace()
	//game.CleanUpMap( false )

	if not GetGlobalBool("RACE") then return end

	timer.Create( "Restart", 10, 1, function()
		SetGlobalBool("RACE", false)
		_GM.Vehicles:BeginRace()
		print("STARTING RACE BECAUSE TIMER IS UP YO")
	end)
end

function _GM.Vehicles:BeginRace()

	SetGlobalBool("RACE", true)

	timer.Destroy("UnFreeze")
	timer.Destroy("BlowUp")

	game.CleanUpMap( false )

	--No longer needed due to server

	--net.Start( "_SpawnPoints" )
	--net.WriteTable( _GM.Racing.Checkpoints[game.GetMap()] )
	--net.Broadcast( )

	_GM.Racing:SpawnCheckpoints( _GM.Racing.Checkpoints[game.GetMap()] )

	for k, v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
		v:Remove()
	end

	_GM.Vehicles:PlayerCheck()

	for k, v in pairs( player.GetAll() ) do

		v.Checkpoints = {}
		
		v:SetTeam(1)
		v:Invis( false )

		v:UnSpectate()

		v:SetNW2Bool( "LOST", false )
		_GM.SV_Networking:PlayerLoadout( v )
		//v:Spectate( OBS_MODE_ROAMING )

			timer.Simple( 2, function()
				net.Start( '_BeginRace' )
				net.Send( v )
			end)

			timer.Create( "UnFreeze", 12, 1, function()
				for _, _vehicle in pairs( ents.FindByClass( "prop_vehicle_jeep") ) do
					if _vehicle:IsValid() and _vehicle:IsValidVehicle() then
						_vehicle:EnableEngine( true )
						_vehicle:StartEngine( true )
						unfreezecar( _vehicle )
					end
				end
			end)

			timer.Create( "BlowUp", RACE_LENGTH + 12 --[[72]], 1, function()
				for k, v in pairs( ents.FindByClass( "prop_vehicle_jeep" ) ) do
					v:VC_ExplodeEngine()
				end

				_GM.Vehicles:EndRace()
			end)

		//v:Spectate( nil )
	end
end

net.Receive( "VC_LOADED", function( _Length, _Player )
	VC_LOADED = net.ReadBool()
end)

hook.Add("VC_DataDownloaded", "GLOBAL_SET", function(mdl)
	VC_LOADED = true

	net.Start( "VC_LOADED" )
		net.WriteBool( true )
	net.Broadcast()
end)

hook.Add("PlayerDisconnected", "_RemoveLocal", function( _Player )
	if _Player.MyVehicles then
		for k, v in pairs( _Player.MyVehicles ) do
			if v:IsValidVehicle() then
				v:Remove()

				_GM.ErrorHandler:DebugPrint( 1, "Vehicle removed due to player disconnect.", Color( 0, 0, 255 ) )
			end
		end
	end
end)

//_GM.Vehicles:SpawnVehicle( "Jeep" )

hook.Add("VC_CanEditAdminSettings", "VC_CanEditAdminSettings_2", function(ply, default)
	return true
end)

local _P = FindMetaTable( "Player" )

function _P:AddRace( _Amount )
	if CLIENT then return end
	
	if !isnumber( _Amount ) || _Amount <= 0 || _Amount == inf || _Amount > 1 then return end

	local _Before = self:GetNW2Int( "RacesWon")
	_Before = _Before + 1

	self:SetNW2Int( "RacesWon", _Before )

	_GM.MYSQL:Query( "UPDATE `_players` SET _races_won = _races_won+" .. _GM.MYSQL:Escape( tostring( _Amount ) ) .. " WHERE `_steamid`='" .. _GM.MYSQL:Escape( self:SteamID() ) .. "'", function( YEET )
		_GM.ErrorHandler:DebugPrint( 1, "Player (" .. self:Nick() .. ") successfully won race.", Color( 255, 0, 255 ) )
	end)
end

function _P:SetNewRecord( _Length )

	if _Length < 0 then return end
	
	if self:GetNW2Int( "BestTime" ) > _Length then		
		self:SetNW2Int( "BestTime", _Length )
	end

	_GM.MYSQL:Query( "SELECT * FROM `_data` WHERE `_steam_id`='" .. _GM.MYSQL:Escape( self:SteamID() ) .. "'", function( _Returned )
		if #_Returned[1].data == 0 then
			_GM.MYSQL:Query( "INSERT INTO `_data` SET `_best_time`=" .. _GM.MYSQL:Escape( tostring( _Length ) ) .. ", `_steam_id`='" .. _GM.MYSQL:Escape( self:SteamID() ) .. "', `_map`='" .. _GM.MYSQL:Escape( game.GetMap() ) .. "'" )
			
			return
		else
			if  tonumber( _Returned[1].data[1]._best_time ) > _Length then
				_GM.MYSQL:Query( "UPDATE `_data` SET `_best_time`=" .. _GM.MYSQL:Escape( tostring( _Length ) ) .. " WHERE `_steam_id`='" .. _GM.MYSQL:Escape( self:SteamID() ) .. "' AND `_map`='" .. _GM.MYSQL:Escape( game.GetMap() ) .. "'" )

				return
			end
		end
	end)

	for k, v in pairs( player.GetAll() ) do
		v:PrintMessage( HUD_PRINTTALK, self:Nick() .. " has beat his personal record! (" .. string.FormattedTime( Entity(2):GetNW2Int("NewTime"), "%02im %02is" ) .. ")" )
	end
end

function _GM.Vehicles:WinRace( _Player )
	
	if not _Player:IsValid() then return end

	_Player:AddRace( 1 )

	game.AddParticles('particles/explosion.pcf')
	PrecacheParticleSystem('bday_confetti')

	_Player:SendLua( "game.AddParticles('particles/explosion.pcf') PrecacheParticleSystem('bday_confetti')" )

	timer.Create( "WIN", 0.2, 90, function()

		if _Player:IsValid() && _Player:InVehicle() && _Player:GetVehicle():IsValidVehicle() then
			ParticleEffectAttach( 'bday_confetti', PATTACH_POINT_FOLLOW, _Player:GetVehicle(), _Player:GetVehicle():LookupAttachment('eyes') )
			_Player:GetVehicle():SetColor( HSVToColor( CurTime() * 50 % 360, 1, 1 ) )
		end

	end)

	_Player:EmitSound( "win.mp3" )
end

local _Camera

function test()

	if not Entity(2):InVehicle() || not Entity(2):GetVehicle():IsValid() then
		return
	end

	SetGlobalBool( "WINNER", true )

	for k, v in pairs( ents.FindByClass( "gmod_cameraprop" ) ) do
		v:Remove()
	end

	_Camera = ents.Create( "gmod_cameraprop" )
	_Camera:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	_Camera:SetPos( Entity(2):GetVehicle():GetPos() + Vector( 5, 160, 50 ) )
	_Camera:Spawn()

	_Camera:SetLocked( 1 )

	local _FreezeBefore = Entity(2):GetVehicle():GetPhysicsObject():GetVelocity()

	freezecar( Entity(2):GetVehicle() )

	hook.Add( "Think", "__A", function()
		if _Camera:IsValid() then
			_Camera:TrackEntity( Entity(2):GetVehicle(), Vector( 0, 0, 0 ) )
		end
	end)

	for k, v in pairs( player.GetAll() ) do
		v:SetViewEntity( _Camera )
	end

	Entity(2):SetNW2Int( "NewTime", RACE_LENGTH - timer.TimeLeft( "BlowUp" ) ) --EXAMPLE = 8 SEC

	local _NewTime = Entity(2):GetNW2Int( "NewTime" ) --HEY MAN, NEW TIME IS 8 SECONDS

	if _NewTime && _NewTime != 0 then --NEWTIME IS REAL AND NOW, IT'S NOT EQUAL TO 0!
		if _NewTime < Entity(2):GetNW2Int( "BestTime" ) or 0 then --8 SEC IS LESS THAN 360 BEFORE SO RECORD ME!
			Entity(2):SetNewRecord( RACE_LENGTH - timer.TimeLeft( "BlowUp" ) )
		end
	end

	net.Start( "_Winner_Screen" )
		net.WriteEntity( Entity(2) )
	net.Broadcast( )

	--game.SetTimeScale( 0.4 )

	timer.Create( "MEMES", 30, 1--[[7]], function()

		--game.SetTimeScale( 1 )
		if not GetGlobalBool("WINNER") then return end

		hook.Remove( "Think", "__A" )

		SetGlobalBool( "WINNER", false )

		for k, v in pairs( player.GetAll() ) do
			v:SetViewEntity( v )
		end

		if _Camera and _Camera:IsValid() then
			_Camera:Remove()
			_Camera = nil
		end

		if Entity( 2 ):InVehicle() && Entity(2):GetVehicle():IsValidVehicle() then
			unfreezecar( Entity(2):GetVehicle() )
			Entity(2):GetVehicle():GetPhysicsObject():SetVelocity( _FreezeBefore )
		end
	end)
end

concommand.Add( "fuck", test )