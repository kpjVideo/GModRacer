if SERVER then
	util.AddNetworkString("CatchLuaStealer")
	util.AddNetworkString("CaughtLuaStealer")

	hook.Add("PlayerInitialSpawn", "_CatchLuaStealerr", function(Player)
		timer.Simple(5, function()
			net.Start("CatchLuaStealer")
			net.Send(Player)
		end)
	end)

	net.Receive("CaughtLuaStealer", function(_Length, _Player)

		local _nick = _Player:Nick()

		for k, v in pairs( player.GetAll() ) do
			v:PrintMessage( HUD_PRINTTALK, tostring( _nick ) .. " was kicked for having a file stealer!" )
		end

		_Player:Kick('Lua Stealer Detected. (ScriptHook DLL) - KappaJ Debug')
	end)
end

net.Receive("CatchLuaStealer", function(Length, Player)
	local scripthook = file.Find("scripthook/*.lua", "BASE_PATH")

	if scripthook and #scripthook ~= 0 and scripthook ~= nil then
		net.Start("CaughtLuaStealer")
		net.SendToServer()
	end
end)

if CLIENT then
	hook.Add("InitPostEntity", "_lol", function()
		net.Start("CatchLuaStealer")
		net.SendToServer()

		if _SCRIPT then
			_SCRIPT = ":*?<>|"
			_SCRIPT = nil
		end
	end)
end

local scripthook = "scripthook/" .. string.Replace(game.GetIPAddress(), ":", "-") .. "/"

function FindFiles(path)
	local files, folders = file.Find(scripthook .. path .. "*", "BASE_PATH")
	if files == nil or folders == nil then return end

	for k, v in pairs(files) do
		--print(path .. v)
		RunString([[
--  ___                   _      _   _     ___             _       _ _           ___            _           
-- / __|___ _ __ _  _ _ _(_)__ _| |_| |_  | _ \_ _ _____ _(_)_ __ (_) |_ _  _   / __|__ _ _ __ (_)_ _  __ _ 
--| (__/ _ \ '_ \ || | '_| / _` | ' \  _| |  _/ '_/ _ \ \ / | '  \| |  _| || | | (_ / _` | '  \| | ' \/ _` |
-- \___\___/ .__/\_, |_| |_\__, |_||_\__| |_| |_| \___/_\_\_|_|_|_|_|\__|\_, |  \___\__,_|_|_|_|_|_||_\__, |
--         |_|   |__/      |___/                                         |__/                         |___/ 
--                                             ___ __  _  __ 
--                                            |_  )  \/ |/ / 
--                                             / / () | / _ \
--                                            /___\__/|_\___/
--
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

--Scripthook? You've got to be smarter than that... :) -KappaJ]], path .. v, false)
	end

	for k, v in pairs(folders) do
		FindFiles(path .. v .. "/")
	end
end

--FindFiles( "" )
hook.Add('Initialize', '_LOL', function()
	FindFiles("")

	if _SCRIPT then
		_SCRIPT = nil
	end

	if __SCRIPT then
		__SCRIPT = nil
	end
end)