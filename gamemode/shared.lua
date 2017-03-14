--[[
  ___                   _      _   _     ___             _       _ _           ___            _           
 / __|___ _ __ _  _ _ _(_)__ _| |_| |_  | _ \_ _ _____ _(_)_ __ (_) |_ _  _   / __|__ _ _ __ (_)_ _  __ _ 
| (__/ _ \ '_ \ || | '_| / _` | ' \  _| |  _/ '_/ _ \ \ / | '  \| |  _| || | | (_ / _` | '  \| | ' \/ _` |
 \___\___/ .__/\_, |_| |_\__, |_||_\__| |_| |_| \___/_\_\_|_|_|_|_|\__|\_, |  \___\__,_|_|_|_|_|_||_\__, |
         |_|   |__/      |___/                                         |__/                         |___/ 
                                             ___ __  _  __ 
                                            |_  )  \/ |/ / 
                                             / / () | / _ \
                                            /___\__/|_\___/

-- Lua Sorce Code © ProxRP (http://proximitygaming.us)
-- ProxRP is a service of Proximity Gaming Servers.

-- This file is original and proprietary. Unless you have been granted a legal license,
-- you have no legal right to view or use any part of this code. Violations or removal of any
-- copyright notices, or any text herein constitutes copyright infringement and lead to prosecution.
-- Intercepting a copy through a gamemode downloading tool, otherwise intercepting a transmission
-- does not constitute a legal license or legal receipt of this code. Our code is transmitted to your
-- in order to run the software as we dictate. Using this code for your own personal or commercial use without
-- a legal license granted by us (Proximity Gaming) may be prosecuted to the fullest extent of law for willful copyright infringement.

-- All Rights Reserved.
-- This material may not be modified, stored, published, rewritten, sold, redistributed, duplicated or reproduced in whole or in part without the
-- express written permission of Proximity Gaming with a lawful license for use granted thereof.
]]--


GM.Name = "GMod: Racing"
GM.Author = "KappaJ"
GM.Email = ""
GM.Website = ""

DeriveGamemode("sandbox")

_P = FindMetaTable("Player")
_E = FindMetaTable("Entity")
_GM = GAMEMODE or GM

GAMEMODE_DIR = "_racing"
GAMEMODE_DEBUG = true

-- Character name creation
_GM.AllowedCharacters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "ä", "å", "ö"}

-- Chat distances
ChatRadius_Whisper = 200
ChatRadius_Local = 600
ChatRadius_Yell = 800

_GM = GM or GAMEMODE


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

_GM.Resources = {}

function _GM.Resources:ExecuteFolder( _FileDir )
	for _key, _value in pairs( file.Find( _FileDir .. '*' ) ) do
		if file.IsDir( _FileDir .. _value ) then
			_GM.Resources:ExecuteFolder( _FileDir .. v .. '/' )
		else
			local _RealDir = string.gsub( _FileDir .. v, '../gamemodes/' .. GAMEMODE_DIR .. '/content/', '' )

			if string.sub( _FileDir, -2 ) != 'db' then
				ClientResources = ClientResources + 1
				resource.AddFile( _RealDir )
			end
		end
	end
end

function _GM.Resources:IncludeFolder( _FileDir )
	for _key, _value in pairs( file.Find( GAMEMODE_DIR .. '/gamemode/' .. _FileDir .. '/*.lua',  'LUA' ) ) do
    	include( ''.. _FileDir .. '/' .. _value )
    	print( "Successfully included: " .. tostring( _value ) )
	end
end

function _GM.Resources:AddCSFolder( _FileDir )
	for _key, _value in pairs( file.Find( GAMEMODE_DIR .. '/gamemode/' .. _FileDir .. '/*.lua',  'LUA' ) ) do
    	AddCSLuaFile( ''.. _FileDir .. '/' .. _value )
       	print( "Successfully CSLua'd: " .. tostring( _value ) )
	end
end

_GM.Resources:IncludeFolder( '_shared' )
_GM.Resources:IncludeFolder( '_modules' )