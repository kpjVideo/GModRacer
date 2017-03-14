--[[---------------------------------------------------------
   Library: _GM.SV_Networking
   Desc: Nested functions for all networked functions from server -> client  &  client -> server
   Functions:
   			PlayerSetup( Entity ) - Forces player(s) into character creation
   			LoadPlayer( Entity ) - Loads player data from SQL, will call PlayerSetup if data is not present
   			RegisterNetworkedString( ) - Registers all required networking strings
-----------------------------------------------------------]]

_GM.SV_Networking = {}

Ranks = {}
Ranks["3"] = ASS_LVL_GUEST
Ranks["4"] = ASS_LVL_SERVER_OWNER
Ranks["9"] = ASS_LVL_DEVELOPER
Ranks["15"] = ASS_LVL_SUPER_ADMIN
Ranks["7"] = ASS_LVL_ADMIN
Ranks["17"] = ASS_LVL_MODERATOR
Ranks["27"] = ASS_LVL_PLATINUM
Ranks["26"] = ASS_LVL_DIAMOND
Ranks["25"] = ASS_LVL_GOLD
Ranks["24"] = ASS_LVL_SILVER
Ranks["23"] = ASS_LVL_BRONZE

function _GM.SV_Networking:UpdateLocation( _Player )
   local __playerIP = string.Explode( ":", _Player:IPAddress() )

   http.Fetch( "http://freegeoip.net/json/" .. __playerIP[1],
      function( body )
         local __returned = util.JSONToTable( body )

         if not __returned or __returned == nil then
               _Player:SetNW2String( "CountryName", "Unknown" )

               return
         end

         _Player:SetNW2String( "Country", __returned.country_code )
         _Player:SetNW2String( "CountryName", __returned.country_name )
      end,
      function( error )
         _GM.ErrorHandler:DebugPrint( 1, "GEOIP Failed for: " .. _Player:Nick(), Color( 255, 0, 0 ) )
         //houston, we have a problem...
      end
   )
end

function _GM.SV_Networking:PlayerSetup( _Player )

	if _Player.ProfileLoaded then
		
		_GM.ErrorHandler:DebugPrint( 1, "Attempted to setup: " .. _Player:Nick() .. "\nskipped because character is already accounted for!", Color( 0, 255, 0 ) )

		return
	end

	_GM.ErrorHandler:DebugPrint( 1, "Attempting to setup: " .. _Player:Nick(), Color( 255, 0, 0 ) )

   _Player:SetNW2String( "Country", "" )
   _Player:SetNW2String( "CountryName", "Unknown" )

	local _SteamID = _Player:SteamID()
	local _Model = _Player:GetModel()
	local _Color = _Player:GetPlayerColor()
	local _WeaponColor = _Player:GetWeaponColor()

	_GM.MYSQL:DebugQuery("INSERT INTO `_players` (`_steamid`, `_cash`, `_model`, `_xp`, `_rank`, `_color`, `_physgun`) VALUES ( '" .. _GM.MYSQL:Escape( _SteamID ) .. "', '15000', '" ..  _GM.MYSQL:Escape( _Model ) .. "', '0', '3', '" .. _GM.MYSQL:Escape( math.Round( _Color.x, 5 ) .. ";" .. math.Round( _Color.y, 5 ) .. ";" .. math.Round( _Color.z, 5 )  .. ";" ) .. "', '" .. _GM.MYSQL:Escape( math.Round( _WeaponColor.x, 5 ) .. ";" .. math.Round( _WeaponColor.y, 5 ) .. ";" .. math.Round( _WeaponColor.z, 5 )  .. ";" ) .. "' )")
	_Player.ProfileLoaded = true

   _GM.SV_Networking:UpdateLocation( _Player )
end

function _GM.SV_Networking:PlayerLoadout( _Player )

	_Player:StripWeapons()

	if _Player:GetRankLevel( ) <= 1 and _Player:Team() == 1 then
		_Player:Give("gmod_camera")
		_Player:Give("weapon_physgun")
		_Player:Give("gmod_tool")
	end
end

hook.Add( 'PlayerInitialSpawn', '_LoadData', function( _Player )

	if _Player:IsValid() then
		_GM.SV_Networking:LoadPlayer( _Player )
	end

   _Player:SetMoveType( MOVETYPE_NOCLIP )

   timer.Simple( 0.5, function() _Player:SetMoveType( MOVETYPE_NOCLIP ) _GM.SV_Networking:PlayerLoadout( _Player ) end)
end)

function util.GetAlivePlayers()
   local alive = {}
   for k, p in pairs(player.GetAll()) do
      if IsValid(p) and p:Alive() and p:Team() == 1 then
         table.insert(alive, p)
      end
   end

   return alive
end

function util.GetNextAlivePlayer(ply)
   local alive = util.GetAlivePlayers()

   if #alive < 1 then return nil end

   local prev = nil
   local choice = nil

   if IsValid(ply) then
      for k,p in pairs(alive) do
         if prev == ply then
            choice = p
         end

         prev = p
      end
   end

   if not IsValid(choice) then
      choice = alive[1]
   end

   return choice
end

plymeta = FindMetaTable( "Player" )

local oldSpectate = plymeta.Spectate
function plymeta:Spectate(type)
   oldSpectate(self, type)

   -- NPCs should never see spectators. A workaround for the fact that gmod NPCs
   -- do not ignore them by default.
   self:SetNoTarget(true)

   if type == OBS_MODE_ROAMING then
      self:SetMoveType(MOVETYPE_NOCLIP)
   end
end

local oldSpectateEntity = plymeta.SpectateEntity
function plymeta:SpectateEntity(ent)
   oldSpectateEntity(self, ent)

   if IsValid(ent) and ent:IsPlayer() then
      self:SetupHands(ent)
   end
end

local oldUnSpectate = plymeta.UnSpectate
function plymeta:UnSpectate()
   oldUnSpectate(self)
   self:SetNoTarget(false)
end

hook.Add( 'KeyRelease', 'KappaJ.Racing.KeyRelease.DisableUse', function( _Player, _Key )
      if _Key == IN_USE then
         return false
      end
end)

hook.Add('KeyPress', 'Spec', function(ply, key)
   if not IsValid(ply) then return end

   -- Spectator keys
   if ply:Team() == TEAM_SPECTATOR then
      ply:StripWeapons()
      local ang = ply:EyeAngles()

      if ang.r ~= 0 then
         ang.r = 0
         ply:SetEyeAngles(ang)
      end

      --[[
      if key == IN_ATTACK then
         -- snap to random guy
         ply:Spectate(OBS_MODE_ROAMING)
         ply:SetEyeAngles(angle_zero) -- After exiting propspec, this could be set to awkward values
         ply:SpectateEntity(nil)

         local alive = util.GetAlivePlayers()

         if #alive < 1 then return end

         local target = table.Random(alive)
         if IsValid(target) then
            ply:SetPos(target:EyePos())
            ply:SetEyeAngles(target:EyeAngles())
         end
      ]]
      --
      if key == IN_ATTACK2 or key == IN_ATTACK then
         -- spectate either the next guy or a random guy in chase
         local target = util.GetNextAlivePlayer(ply:GetObserverTarget())

         if IsValid( target ) then

            ply:Spectate(ply.spec_mode or OBS_MODE_CHASE)

            if target:GetVehicle():IsValid() then
               ply:SpectateEntity(target:GetVehicle())
            else
               ply:SpectateEntity(target)
            end

         end

      elseif key == IN_USE then
         return false
      elseif key == IN_DUCK then
         local pos = ply:GetPos()
         local ang = ply:EyeAngles()
         local target = ply:GetObserverTarget()

         if IsValid(target) and target:IsPlayer() then
            pos = target:EyePos()
            ang = target:EyeAngles()
         end

         -- reset
         ply:Spectate(OBS_MODE_ROAMING)
         ply:SpectateEntity(nil)

         --ply:SetPos(pos)
         --ply:SetEyeAngles(ang)
         return true
      elseif key == IN_JUMP then
         -- unfuck if you're on a ladder etc
         if not (ply:GetMoveType() == MOVETYPE_NOCLIP) then
            ply:SetMoveType(MOVETYPE_NOCLIP)
         end
      elseif key == IN_RELOAD then
         local tgt = ply:GetObserverTarget()
         if not IsValid(tgt) or not tgt:IsPlayer() then return end

         if not ply.spec_mode or ply.spec_mode == OBS_MODE_CHASE then
            ply.spec_mode = OBS_MODE_IN_EYE
         elseif ply.spec_mode == OBS_MODE_IN_EYE then
            ply.spec_mode = OBS_MODE_CHASE
         end

         -- roam stays roam
         ply:Spectate(ply.spec_mode)
      end
   end
end)

function _P:Invis( _Bool )

   self:SetRenderMode( RENDERMODE_TRANSALPHA )

   if _Bool then
      self:SetColor( Color( self:GetColor().r, self:GetColor().g, self:GetColor().b, 0 ) )
   else
      self:SetColor( Color( self:GetColor().r, self:GetColor().g, self:GetColor().b, 255 ) )
   end
end

hook.Add( 'PlayerSpawn', '_GiveWeapons', function( _Player )
	_GM.SV_Networking:PlayerLoadout( _Player )

	_Player:SetTeam( TEAM_SPECTATOR )
   _Player:SetMoveType( MOVETYPE_NOCLIP )
   _Player:Invis( true )
end)

hook.Add( 'PlayerNoClip', '_StopNoclipping', function( _Player )
      return _Player:GetAssLevel() == ASS_LVL_DEVELOPER || _Player:GetAssLevel() == ASS_LVL_SERVER_OWNER
end)

function _P:IsAdmin()
      return self:GetAssLevel() == ASS_LVL_SERVER_OWNER || self:GetAssLevel() == ASS_LVL_DEVELOPER
end

function _P:IsSuperAdmin()
   return self:GetAssLevel() == ASS_LVL_SERVER_OWNER || self:GetAssLevel() == ASS_LVL_DEVELOPER
end


function _GM.SV_Networking:LoadPlayer( _Entity )

    if _Entity.ProfileLoaded then
    	return
    end


	if not _Entity:IsPlayer() then
		return
	end

   _Entity:SetNW2String( "Country", "" )
   _Entity:SetNW2String( "CountryName", "Unknown" )

   _GM.SV_Networking:UpdateLocation( _Entity )

	_GM.MYSQL:Query("SELECT `_steamid`, `_cash`, `_model`, `_xp`, `_rank`, `_color`, `_physgun`, `_races_won` FROM `_players` WHERE `_steamid`='" .. _Entity:SteamID() .. "'", function ( _PlayerData )
		
		if not _Entity or not _Entity:IsValid() then return end

      if  #_PlayerData[1].data == 0 and IsValid( _Entity ) then 

         _GM.SV_Networking:PlayerSetup( _Entity )

         return
      else
         _Entity.ProfileLoaded = true
      end

      

		local _RawData = _PlayerData[1].data[1]
		local _SteamID = _RawData._steamid
		local _Cash = _RawData._cash
		local _Model = _RawData._model
		local _Items = _RawData._inventory
		local _XP = _RawData._xp
		local _Rank = _RawData._rank
		local _Color = _RawData._color
		local _Physgun = _RawData._physgun
		local _Races_Won = _RawData._races_won

      _Entity:SetNW2Int( "RacesWon", _Races_Won )

		local ConvertedColor = string.Explode( ';', _Color )
		local ConvertedPhysgun = string.Explode( ';', _Physgun )

		_Entity:SetPlayerColor( Vector( tonumber( ConvertedColor[1] ) or 1, tonumber( ConvertedColor[2] ) or 1, tonumber( ConvertedColor[3] ) or 1 ) )
		_Entity:SetWeaponColor( Vector( tonumber( ConvertedPhysgun[1] ) or 1, tonumber( ConvertedPhysgun[2] ) or 1, tonumber( ConvertedPhysgun[3] ) or 1 ) )

		//_Entity:SetCash( _Cash )
		//_Entity:SetXP( _XP )

		RANK = Ranks[ tostring( _Rank ) ] 

		if RANK then
			_Entity:SetAssLevel(RANK)
			_GM.SV_Networking:PlayerLoadout( _Entity )

			_GM.ErrorHandler:DebugPrint( 1, _Entity:Nick() .. "'s set rank to: " .. tostring( _Rank ) ..  "", Color( 255, 0, 0 ) )
		end
	end)

	_GM.SV_Networking:PlayerLoadout( _Entity )
    _GM.ErrorHandler:DebugPrint( 1, _Entity:Nick() .. "'s profile has been successfully loaded.", Color( 255, 0, 0 ) )
end

function _GM.SV_Networking:RegisterNetworkedStrings( )
	util.AddNetworkString("_BeginRace")
end

_GM.SV_Networking:RegisterNetworkedStrings()


concommand.Add("VC_OpenCarDealerMenu", function()
   
   ent = nil

   for k, v in pairs( ents.FindByClass( "vc_npc_cardealer" ) ) do
      ent = v
   end

   if IsValid(ent) then
      ent:VC_Menu_CD_Open( Entity(1) )
   end
end)