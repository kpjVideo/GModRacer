AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
 
include( 'shared.lua' )
 
 util.AddNetworkString '_PassedCheckpoint'

function ENT:Initialize()
 
	self:SetModel( 'models/props_phx/construct/plastic/plastic_angle_360.mdl' )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

    local phys = self:GetPhysicsObject()

	if ( phys:IsValid() ) then
		phys:Wake()
	end

	self:SetSubMaterial( 0, 'models/debug/debugwhite' )
	self:SetSubMaterial( 1, 'models/effects/vol_light001' )

	self.Arrow = ents.Create( "prop_physics" )
	self.Arrow:SetModel( 'models/gmod_tower/arrow.mdl' )
	self.Arrow:SetPos( self:LocalToWorld( Vector( 0, 0, 2 ) ) )

	self.Arrow:SetModelScale( 0.8 )

	self.Arrow:SetParent( self )
end
 
function ENT:Use( _Player, _Caller )

end

function ENT:Think()

	self.Arrow:SetAngles( self:LocalToWorldAngles( Angle( 90, 0, 0 ) ) )

	//ratio = Lerp( 0.0001, ratio, 9999 )
	//self.Arrow:SetAngles( self.Arrow:GetAngles() + Angle( 0, ratio % 360, 0 ) )

	for k, v in pairs( ents.FindInSphere( self:GetPos( ), 256 ) ) do
		if v:IsValid() && v:IsPlayer() then

			if v.Checkpoints then
				if v.Checkpoints && v.Checkpoints[ self.CheckPointNum ] then
					continue
				end --already passed

				if self.CheckPointNum > 1 && not v.Checkpoints[ self.CheckPointNum - 1 ] then
					continue
				end

				--PASSED CHECKPOINT

				v.Checkpoints[ self.CheckPointNum ] = true

				self:SetNoDraw( true ) --MOVE INTO CLIENT FROM SERVER - IMPORTANTE
				self.Arrow:SetNoDraw( true ) --MOVE INTO CLIENT FROM SERVER - IMPORTANTE

				net.Start( '_PassedCheckpoint' )
				net.WriteEntity( self )
				net.Send( v )
			end
		end
	end
end