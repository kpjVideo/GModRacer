_GM.Racing = {}

_GM.Racing.ActiveCheckpoints = {}
_GM.Racing.ActiveArrows = {}

function _GM.Racing:ClearCheckpoints()
	for k, v in pairs( ents.GetAll() ) do
	    if v:GetModel() == "models/gmod_tower/arrow.mdl" or v:GetModel() == "models/props_phx/construct/plastic/plastic_angle_360.mdl" then
	        v:Remove()
	    end
	end

	table.Empty( _GM.Racing.ActiveCheckpoints )
	table.Empty( _GM.Racing.ActiveArrows )
end

if CLIENT then

	net.Receive( "_SpawnPoints", function( _Length )
		local _Points = net.ReadTable()

		for k, v in pairs( _Points ) do

			local CurPoint = ClientsideModel( v[1], RENDERGROUP_BOTH )
			//CurPoint:SetModel( v[1] )
			CurPoint:SetPos( v[2] )
			CurPoint:SetAngles( Angle( -90, 90, 180 ) )
			CurPoint:Spawn()
			CurPoint:SetSubMaterial( 0, 'models/debug/debugwhite' ) 
			CurPoint:SetSubMaterial( 1, 'models/effects/vol_light001' )
			CurPoint:SetColor( Color( 0, 255, 0 ) )
	 		CurPoint:SetMoveType( MOVETYPE_NONE )

	 		local CurArrow = ClientsideModel( "models/gmod_tower/arrow.mdl", RENDERGROUP_BOTH )
	 		//CurArrow:SetModel( 'models/gmod_tower/arrow.mdl' )
			CurArrow:SetPos( v[2] )
			CurArrow:SetAngles( Angle( 0, 90, 180 ) )
			CurArrow:SetModelScale( 0.5 )
			CurArrow:SetColor( Color( 255, 255, 255 ) )
			CurArrow:Spawn()
	 		CurArrow:SetMoveType( MOVETYPE_NONE )
 		end
	end)
else
	util.AddNetworkString("_SpawnPoints")
end

function _GM.Racing:SpawnCheckpoints( _Table )
	if not _Table or not istable( _Table ) or not CLIENT then return end
 
	_GM.Racing:ClearCheckpoints( )
 
	for k, v in pairs( _Table ) do

		local CurPoint = ClientsideModel( v[1], RENDERGROUP_BOTH )
		//CurPoint:SetModel( v[1] )
		CurPoint:SetPos( v[2] )
		CurPoint:SetAngles( Angle( -90, 90, 180 ) )
		CurPoint:Spawn()
		CurPoint:SetSubMaterial( 0, 'models/debug/debugwhite' ) 
		CurPoint:SetSubMaterial( 1, 'models/effects/vol_light001' )
		CurPoint:SetColor( Color( 0, 255, 0 ) )
 		CurPoint:SetMoveType( MOVETYPE_NONE )

 		local CurArrow = ClientsideModel( "models/gmod_tower/arrow.mdl", RENDERGROUP_BOTH )
 		//CurArrow:SetModel( 'models/gmod_tower/arrow.mdl' )
		CurArrow:SetPos( v[2] )
		CurArrow:SetAngles( Angle( 0, 90, 180 ) )
		CurArrow:SetModelScale( 0.5 )
		CurArrow:SetColor( Color( 255, 255, 255 ) )
		CurArrow:Spawn()
 		CurArrow:SetMoveType( MOVETYPE_NONE )

		if _GM.Racing.ActiveArrows and table.Count( _GM.Racing.ActiveArrows ) >= 1 then
			CurArrow.PointEnt = table.GetLastValue( _GM.Racing.ActiveArrows )
			print( "LAST_VALUE: " .. tostring( table.GetLastValue( _GM.Racing.ActiveArrows ) ) .. tostring( table.GetLastValue( _GM.Racing.ActiveArrows ):GetPos() ) )
		end

		if _GM.Racing.ActiveCheckpoints and _GM.Racing.ActiveArrows then
			table.insert( _GM.Racing.ActiveCheckpoints, CurPoint )
			table.insert( _GM.Racing.ActiveArrows, CurArrow )
		end
	end


end

if SERVER then

	if not _GM.Racing.Checkpoints or not _GM.Racing.Checkpoints[game.GetMap()] then
		_GM.ErrorHandler:DebugPrint( 1, "MAP CONFIGURATION FOR: " .. game.GetMap() .. " DOES NOT EXIST!", Color( 255, 0, 0 ) )
		return
	end

	//_GM.Racing:SpawnCheckpoints( _GM.Racing.Checkpoints[game.GetMap()] )
end 