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

include("shared.lua")


--[[---------------------------------------------------------
   Name: GM:SpawnMenuOpen(ply)
   Desc: Check who is permitted to open the spawn menu
-----------------------------------------------------------]]
function GM:SpawnMenuOpen(ply)
    return true
end

--[[---------------------------------------------------------
   Name: GM:Think()
   Desc: This is constantly run
-----------------------------------------------------------]]
function GM:Think()
    
end

--[[---------------------------------------------------------
   Name: GM:SpawnMenuEnabled()
   Desc: Should the spawn menu be enabled?
-----------------------------------------------------------]]
function GM:SpawnMenuEnabled()
    return true
end

_GM.Resources:IncludeFolder( '_client' )
--_GM.Resources:IncludeFolder( '_client/_character_creation' )
--_GM.Resources:IncludeFolder( '_client/_inventory' )

_GM.Resources:IncludeFolder( '_shared' )
_GM.Resources:IncludeFolder( '_modules' )

_GM.Client = {}
