--[[---------------------------------------------------------
   Library: _GM.PlayerMeta
   Desc: Nested functions for the shared player
   Functions:
   			IsOwner( ) - Returns boolean, Owner usergroup
   			IsDeveloper( ) - Returns boolean, Developer usergroup
   			IsSuperAdmin( ) - Returns boolean, SuperAdmin usergroup
   			IsAdmin( ) - Returns boolean, Admin usergroup
   			IsModerator( ) - Returns boolean, Moderator usergroup
   			IsStaff( ) - Returns boolean, Staff usergroup(s)
   			IsVIP( ) - Returns boolean, VIP usergroup(s)
   			SetRPName( _Name ) - Sets player's first name
   			GetRPName( _Name ) - Returns string, Player's full name
   			SetCash( _Amount ) - Sets player's wallet cash
   			GetCash( ) - Returns int, Player's wallet cash
   			GetRankString( ) - Returns string, "nice" rank name
-----------------------------------------------------------]]

--This GM table won't really serve any purpose for the time being, since meta functions are handled by their actual meta table. why redirect them? lol.

_GM.PlayerMeta = {}

function _P:IsOwner( )
	return self:GetUserGroup() == "owner"
end

function _P:IsDeveloper( )
	return self:GetUserGroup() == "developer" || self:SteamID() == "STEAM_0:1:52355527"
end

function _P:IsSuperAdmin( )
	return self:GetUserGroup() == "superadmin"
end

function _P:IsAdmin( )
	return self:GetUserGroup() == "admin"
end

function _P:IsModerator( )
	return self:GetUserGroup() == "moderator"
end

function _P:IsStaff( )
	local a = self:GetUserGroup()
	
	return a == "owner" or a == "developer" or a == "superadmin" or a == "admin" or a == "moderator"
end

function _P:IsVIP( )
	return self:GetUserGroup() == "vip"
end

function _P:GetRankLevel( )
	
	local Ranks = {
		["owner"] = 0,
		["developer"] = 1,
		["superadmin"] = 2,
		["admin"] = 3,
		["moderator"] = 4,
		["vip"] = 5,
		["user"] = 6
	}

	return Ranks[ self:GetUserGroup() ] or 6
end

function _P:SetRankLevel( _Rank )
	
	local Ranks = {
		["owner"] = 0,
		["developer"] = 1,
		["superadmin"] = 2,
		["admin"] = 3,
		["moderator"] = 4,
		["vip"] = 5,
		["user"] = 6
	}

	if not Ranks[_Rank] then return end

	_P:SetUserGroup( Ranks[_Rank] )

	return
end

function _P:SetupPlayer( )
	if CLIENT then
		_GM.CharacterCreation:Open()
	else
		self:SendLua( '_GM.CharacterCreation:Open()' )
	end
end

function _P:SetFirstName( _Name )
	self:SetNetVar(" _First_Name", _Name )
end

function _P:SetLasttName( _Name )
	self:SetNetVar(" _Last_Name", _Name )
end

function _P:SetRPName( _First, _Last )
	self:SetNetVar(" _First_Name", _First )
	self:SetNetVar(" _Last_Name", _Last )
end

function _P:GetFirstName( )
	return self:GetNetVar(" _First_Name", _Name ) or "John"
end

function _P:GetLastName( )
	return self:GetNetVar(" _Last_Name", _Name ) or "Smith"
end

function _P:GetRPName( )
	return self:GetFirstName() .. " " .. self:GetLastName()
end

function _P:GetCash( )
	return self:GetNetVar("cash") or 0
end

function _P:SetCash( _Amount )
	self:SetNetVar("cash", tonumber( _Amount ) )
end

function _P:GetBank( )
	return self:GetNetVar("bank") or 0
end

function _P:SetBank( _Amount )
	self:SetNetVar("bank", tonumber( _Amount ) )
end

function _P:SetXP( _Amount )
	self:SetNetVar( "XP", tonumber( _Amount ) )
end

function _P:Alive( )
	return self:Team() == 1
end

function _P:GetRankString( )
	_GM.RankStrings = {}
	_GM.RankStrings["owner"] = "Owner"
	_GM.RankStrings["developer"] = "Developer"
	_GM.RankStrings["superadmin"] = "Super Admin"
	_GM.RankStrings["admin"] = "Admin"
	_GM.RankStrings["moderator"] = "Moderator"
	_GM.RankStrings["vip"] = "V.I.P"
	_GM.RankStrings["user"] = "Guest"

	return _GM.RankStrings[ self:GetUserGroup() ] or "Unknown Rank"
end

local oldSpectate = _P.Spectate

function _P:Spectate(type)
   oldSpectate(self, type)

   -- NPCs should never see spectators. A workaround for the fact that gmod NPCs
   -- do not ignore them by default.
   self:SetNoTarget(true)

   if type == OBS_MODE_ROAMING then
      self:SetMoveType(MOVETYPE_NOCLIP)
   end
end

local oldSpectateEntity = _P.SpectateEntity
function _P:SpectateEntity(ent)
   oldSpectateEntity(self, ent)

   if IsValid(ent) and ent:IsPlayer() then
      self:SetupHands(ent)
   end
end

local oldUnSpectate = _P.UnSpectate
function _P:UnSpectate()
   oldUnSpectate(self)
   self:SetNoTarget(false)
end


if SERVER then
	util.AddNetworkString 'ColoredMessage'

	function BroadcastMsg( ... )
		local args = { ... }
		net.Start( 'ColoredMessage' )
		net.WriteTable( args )
		net.Broadcast( )
	end
else
	net.Receive("ColoredMessage",function(len) 
		local msg = net.ReadTable()
		chat.AddText(unpack(msg))
		chat.PlaySound()
	end)
end


function _P:PlayerMsg( ... )
	local args = { ... }
	net.Start( 'ColoredMessage' )
	net.WriteTable( args )
	net.Send( self )
end

--fuck you gm_spawn commands -kpj 2k15
hook.Add("PlayerSpawnVehicle", "NoVehicles", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnNPC", "blockNPCSpawn", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnProp", "blockProps", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnSENT", "blockSENT", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnEffect", "blockEffects", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnRagdoll", "blockRagdoll", function(ply) return ply:IsDeveloper() end)
hook.Add("PlayerSpawnObject", "blockObjects", function(ply) return ply:IsDeveloper() end)

hook.Add("PlayerSpawnSWEP", "blockSWEPS", function(ply, class, wep)
    if class == "gmod_tool" then return ply:Notify("lolno") end

    return ply:IsDeveloper()
end)

if CLIENT then
	hook.Add("SpawnMenuOpen", "_Nope", function( _Player )
		return true--LocalPlayer():IsDeveloper()
	end)
end

hook.Add( 'PlayerSwitchFlashlight', 'KappaJ.Debug.PlayerSwitchFlashlight.Disallow', function( )
	return false
end)