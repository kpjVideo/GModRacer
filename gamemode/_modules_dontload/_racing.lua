print "hellothere"

_GM.Racing = {}

_GM.Racing.Checkpoints = {
	{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4868, -1739, -1775 ) },
	{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4858, 1452, -1775 ) },
	{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4582, 4862, -1775 ) },
	{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 1667, 5735, -1775 ) },
}

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

function _GM.Racing:SpawnCheckpoints( _Table )
	if not _Table or not istable( _Table ) or not SERVER then return end

	_GM.Racing:ClearCheckpoints( )
 
	for k, v in pairs( _Table ) do
		local CurPoint = ents.Create( "prop_physics" )
		CurPoint:SetModel( v[1] )
		CurPoint:SetPos( v[2] )
		CurPoint:SetAngles( Angle( -90, 90, 180 ) )
		CurPoint:Spawn()
		CurPoint:SetSubMaterial( 0, 'models/debug/debugwhite' ) 
		CurPoint:SetSubMaterial( 1, 'models/effects/vol_light001' )
		CurPoint:SetColor( Color( 0, 255, 0 ) )
 		CurPoint:SetMoveType( MOVETYPE_NONE )

 		local CurArrow = ents.Create( "prop_physics" )
 		CurArrow:SetModel( 'models/gmod_tower/arrow.mdl' )
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
	_GM.Racing:SpawnCheckpoints( _GM.Racing.Checkpoints )
end 