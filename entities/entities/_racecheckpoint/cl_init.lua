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

	timer.Simple( 5, function() hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.CheckpointTime") end )

	local _YEET = string.FormattedTime( math.Round( RACE_LENGTH - timer.TimeLeft( "RaceCountdown" ) ), "%02i:%02i" )

	hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.CheckpointTime", function( )
		if timer.Exists( "RaceCountdown" ) && _YEET then
			draw.SimpleText( tostring( _YEET ), "Countdown", ScrW() / 2, ScrH() / 2 - 200, Color( util.Glow( 1, 0, 0, 255 ) ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end)

	surface.PlaySound( 'buttons/button9.wav' ) --buttons/button17.wav
end)

function ENT:Draw()
	render.SetColorModulation( 24, 24, 24 )

	if self.AlreadyPassed then
		self:SetNoDraw( true )

		if self:GetChildren()[1]:IsValid() then
			local _ent = self:GetChildren()[1]
			_ent:SetNoDraw( true )
		end
		
		return
	end

	self:DrawModel()
end

function ENT:Initialize()

end