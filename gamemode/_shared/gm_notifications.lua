if SERVER then
	util.AddNetworkString("_Notify")
else
	net.Receive( "_Notify", function( _Player, _Length )
		local _str = net.ReadString( )
		notification.AddLegacy( _str, net.ReadInt( 32 ) or 0, 5 )
		print( _str )
	end)
end

function _P:Notify( _String, _Type )

	if not self.LastNote then
		self.LastNote = CurTime()
	end
	
	if self.LastNote > CurTime() then return end

	if CLIENT then
		notification.AddLegacy( _String, _Type or 0, 5 )
		print( _String )
	else
		net.Start( "_Notify" )
		net.WriteString( _String )
		net.WriteInt( _Type or 0, 32 )
		net.Send( self )
	end

	self.LastNote = CurTime() + 1
end