include( 'shared.lua' )

net.Receive( '_PassedCheckpoint', function( _Length, _Player )

	local __entities = {}

	for k, v in pairs( ents.FindInSphere( LocalPlayer():GetPos( ), 256 + 128 ) ) do
		if string.lower( v:GetClass() ) == "_racecheckpoint" then
			table.insert( __entities, v ) --what the fuck am i doing here
		end
	end

	if #__entities <= 0 then
		return --no checkpoint in radius, how da fuk did u send dis?
	end

	local __point = net.ReadEntity( )

	if __point:IsValid() then
		__point.AlreadyPassed = true
	end

	LocalPlayer().CurrentCheckpoint = LocalPlayer().CurrentCheckpoint + 1
end)

function ENT:Draw()
	render.SetColorModulation( 24, 24, 24 )

	if not self.AlreadyPassed then
		self:DrawModel()
	end

end

hook.Add( "PostDrawOpaqueRenderables", "a", function() 
	
	for k, v in pairs( ents.FindByClass( "_racecheckpoint") ) do
		render.SetColorMaterial()
		render.DrawWireframeSphere( v:GetPos(), 256, 16, 16, Color( 255, 255, 255 ), true )
	end

end)

function ENT:Initialize()

end