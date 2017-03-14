AddCSLuaFile( 'cl_init.lua' )
AddCSLuaFile( 'shared.lua' )
 
include( 'shared.lua' )
 
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
	self.Arrow:SetPos( self:LocalToWorld( Vector( 0, 0, 0 ) ) )
	self.Arrow:SetParent( self )
end
 
function ENT:Use( _Player, _Caller )

end
 
function ENT:Think()

end