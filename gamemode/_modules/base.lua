_GM.Racing = {}
_GM.Racing.Checkpoints = {}
_GM.Racing.StartFinish = {}

_GM.Racing.ActiveCheckpoints = {}

if SERVER then
	util.AddNetworkString '_Broadcast_Checkpoints'
end

function _GM.Racing:ClearCheckpoints()
	for k, v in pairs( ents.GetAll() ) do
	    if v:GetClass() == "_racecheckpoint" then
	        v:Remove()
	    end
	end

	table.Empty( _GM.Racing.ActiveCheckpoints )
end

function _GM.Racing:SpawnCheckpoints( _Table )

	if not _Table or not istable( _Table ) or not SERVER then return end
 	
	_GM.Racing:ClearCheckpoints( )
 
	for k, v in pairs( _Table ) do
		local CurPoint = ents.Create( '_racecheckpoint' )
		CurPoint:SetPos( v[2] )
		CurPoint:SetAngles( Angle( -90, 90, 180 ) )
		CurPoint:Spawn()

		CurPoint:SetColor( Color( 255, 255, 255 ) )
	 	CurPoint:SetMoveType( MOVETYPE_NONE )
	 	CurPoint.CheckPointNum = k
	 	CurPoint:SetNW2Int( "CheckPointNum", k )

		if _GM.Racing.ActiveCheckpoints then
			_GM.Racing.ActiveCheckpoints[k] = CurPoint
		end
	end

	print("SENT 1")

	timer.Simple( 0.1, function()
		net.Start( '_Broadcast_Checkpoints' )
		net.WriteTable( _GM.Racing.ActiveCheckpoints )
		net.Broadcast( )
	end)
end

if CLIENT then
	net.Receive( '_Broadcast_Checkpoints', function ( )
		_GM.Racing.ActiveCheckpoints = net.ReadTable( )
	end)
end