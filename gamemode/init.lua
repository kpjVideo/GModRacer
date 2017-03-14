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

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("main.lua")

-- We define the baseclass so that the gamemode knows what to derive off of!
DEFINE_BASECLASS( "gamemode_base" )


-- These functions belong to sandbox, so we will include them in here for quick modification...

--[[---------------------------------------------------------
   Name: GM:OnPhysgunFreeze( weapon, phys, ent, player )
   Desc: The physgun wants to freeze a prop
-----------------------------------------------------------]]
function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
    
    -- Don't freeze persistent props (should already be froze)
    if ( ent:GetPersistent() ) then return false end

    BaseClass.OnPhysgunFreeze( self, weapon, phys, ent, ply )

    ply:SendHint( "PhysgunUnfreeze", 0.3 )
    ply:SuppressHint( "PhysgunFreeze" )

    --[[
    if ent:GetClass() == "cn_npc" then
        saveQuests()
        ply:Notify("NPC Position Updated")
    end
    ]]--
end


--[[---------------------------------------------------------
   Name: GM:OnPhysgunReload( weapon, player )
   Desc: The physgun wants to unfreeze
-----------------------------------------------------------]]
function GM:OnPhysgunReload( weapon, ply )

    local num = ply:PhysgunUnfreeze()
    
    if ( num > 0 ) then
        ply:SendLua( "GAMEMODE:UnfrozeObjects("..num..")" )
    end

    ply:SuppressHint( "PhysgunReload" )

end

--[[---------------------------------------------------------
   Name: GM:PlayerUnfrozeObject( )
   Desc: The physgun wants to unfreeze an object
-----------------------------------------------------------]]
function GM:PlayerUnfrozeObject( ply, entity, physobject )

    local effectdata = EffectData()
        effectdata:SetOrigin( physobject:GetPos() )
        effectdata:SetEntity( entity )
    util.Effect( "phys_unfreeze", effectdata, true, true )  
    
end


--[[---------------------------------------------------------
   Name: gamemode:PlayerFrozeObject( )
   Desc: The player has frozen an object
-----------------------------------------------------------]]
function GM:PlayerFrozeObject( ply, entity, physobject )

    if ( DisablePropCreateEffect ) then return end
    
    local effectdata = EffectData()
        effectdata:SetOrigin( physobject:GetPos() )
        effectdata:SetEntity( entity )
    util.Effect( "phys_freeze", effectdata, true, true )    
    
end

_GM.Resources:IncludeFolder( '_server' )

_GM.Resources:AddCSFolder( '_client' )
_GM.Resources:AddCSFolder( '_client/_character_creation' )
_GM.Resources:AddCSFolder( '_client/_inventory' )

_GM.Resources:AddCSFolder( '_shared' )
_GM.Resources:AddCSFolder( '_modules' )