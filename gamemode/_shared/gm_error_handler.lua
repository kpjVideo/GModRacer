_GM.ErrorHandler = {}
_GM.ErrorHandler.Prefix = "[PROX-DEBUG]"

function _GM.ErrorHandler:DebugPrint( _Type, _Message, _Color )
	
	if not GAMEMODE_DEBUG then return end

	if _Type >= 1 and not _Color then
		ErrorNoHalt( _GM.ErrorHandler.Prefix .. " " .. _Message .. "\n" )
	else 
		MsgC( _Color or Color( 255, 0, 0 ), _GM.ErrorHandler.Prefix .. " " .. _Message .. "\n" )
	end

end

if SERVER then

	require 'luaerror'

	luaerror.EnableRuntimeDetour( true )
	luaerror.EnableCompiletimeDetour( true )
	luaerror.EnableClientDetour( true )

	local os

	if system.IsWindows() then
		os = "Windows"
	elseif system.IsOSX() then
		os = "Mac OSX"
	elseif system.IsLinux() then
		os = "Linux"
	else
		os = "Other?"
	end

	hook.Add( 'LuaError', 'KappaJ.Debug.LuaError.Server.Tracking', function( _RunTime, _FullError, _SourceFile, _SourceLine, _ErrorStack, _Stack )
		BroadcastMsg( Color( 255, 255, 255 ), "The server encountered an error @ ", Color( 255, 0, 0 ), _SourceFile, Color( 255, 255, 255 ), " on line ", Color( 255, 0, 0 ), tostring( _SourceLine ), Color( 255, 255, 255 ), " with: ", Color( 255, 0, 0 ), _ErrorStack, Color( 255, 255, 255 ), " ● Tell KappaJ his coding sux")

		_GM.MYSQL:Query( "INSERT INTO _errors (user, hash, full_error, error, realm, addon, gamemode, os, line_number, file, time_stamp) VALUES ('CONSOLE', '', '" .. _GM.MYSQL:Escape( _FullError ) .. "', '" .. _GM.MYSQL:Escape( _ErrorStack ) .. "', 'SERVER', '', '" .. _GM.MYSQL:Escape( GetConVar("gamemode"):GetString() ) .. "', '" .. _GM.MYSQL:Escape( os ) .. "', '" .. _SourceLine .. "', '" .. _GM.MYSQL:Escape( _SourceFile ) .. "', CURRENT_TIMESTAMP)" )
	end)

	hook.Add( 'ClientLuaError', 'KappaJ.Debug.LuaError.Client.Tracking', function( _Player, _FullError, _SourceFile, _SourceLine, _ErrorStack, _Stack )
		_GM.MYSQL:Query( "INSERT INTO _errors (hash, full_error, error, realm, addon, gamemode, os, line_number, file, user, time_stamp) VALUES ('', '" .. _GM.MYSQL:Escape( _FullError ) .. "', '" .. _GM.MYSQL:Escape( _ErrorStack ) .. "', 'CLIENT', '', '" .. _GM.MYSQL:Escape( GetConVar("gamemode"):GetString() ) .. "', '" .. _GM.MYSQL:Escape( os ) .. "', '" .. _SourceLine .. "', '" .. _GM.MYSQL:Escape( _SourceFile ) .. "', '" .. _GM.MYSQL:Escape( _Player:SteamID() ) .. "', CURRENT_TIMESTAMP)" )
	end)

end