local PANEL = {}
local cos, sin, rad = math.cos, math.sin, math.rad

AccessorFunc( PANEL, "m_masksize", "MaskSize", FORCE_NUMBER )

function PANEL:Init()
    self.Avatar = vgui.Create("AvatarImage", self)
    self.Avatar:SetPaintedManually(true)
    self:SetMaskSize( 24 )
end

function PANEL:PerformLayout()
    self.Avatar:SetSize(self:GetWide(), self:GetTall())
end

function PANEL:SetPlayer( id )
    self.Avatar:SetPlayer( id, self:GetWide() )
end

function PANEL:Paint(w, h)
    render.ClearStencil() -- some people are so messy
    render.SetStencilEnable(true)

    render.SetStencilWriteMask( 1 )
    render.SetStencilTestMask( 1 )

    render.SetStencilFailOperation( STENCILOPERATION_REPLACE )
    render.SetStencilPassOperation( STENCILOPERATION_ZERO )
    render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_NEVER )
    render.SetStencilReferenceValue( 1 )
    
    local _m = self.m_masksize
    
    local circle, t = {}, 0
    for i = 1, 360 do
        t = rad(i*720)/720
        circle[i] = { x = w/2 + cos(t)*_m, y = h/2 + sin(t)*_m }
    end
    draw.NoTexture()
    surface.SetDrawColor(color_white)
    surface.DrawPoly(circle)

    render.SetStencilFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilPassOperation( STENCILOPERATION_REPLACE )
    render.SetStencilZFailOperation( STENCILOPERATION_ZERO )
    render.SetStencilCompareFunction( STENCILCOMPARISONFUNCTION_EQUAL )
    render.SetStencilReferenceValue( 1 )

    self.Avatar:SetPaintedManually(false)
    self.Avatar:PaintManual()
    self.Avatar:SetPaintedManually(true)

    render.SetStencilEnable(false)
    render.ClearStencil() -- you're welcome, bitch.
end

vgui.Register("AvatarCircleMask", PANEL)

surface.CreateFont( "Countdown", {
    font = "Roboto",
    extended = true,
    size = 25,
    weight = 500,
    antialias = true,
} )

surface.CreateFont( "Health", {
    font = "akbar",
    extended = true,
    size = 100,
    weight = 1000,
    antialias = true,
} )

--[[
hook.Add( "CalcView", "MyCalcView", function( ply, pos, angles, fov )
    local view = {}

    view.origin = pos-( angles:Forward()*100 )
    view.angles = angles
    view.fov = fov
    view.drawviewer = true

    return view
end)
]]--

//PrintTable( hook.GetTable().CalcView )


--[[
if not __VCCalcReference then
    __VCCalcReference = hook.GetTable().CalcView.VC_ViewCalc_Shared
end

if __VCCalcReference then
    hook.Remove( "CalcView", "VC_ViewCalc_Shared" );
    hook.Add( "CalcView", "NEW_VC_ViewCalc_Shared", function( ... )

       local _tab = __VCCalcReference( ... );

       if !_tab then return; end

       _tab.drawvieewer = true;

        return _tab;
    end)
end
]]--

RACE_LENGTH = 360

hook.Add( "ShouldDrawLocalPlayer", "_Blyat", function( _Player )
    if _Player:GetVehicle() and _Player:GetVehicle():IsValid() then
        return true
    end
end)

hook.Remove( "ShouldDrawLocalPlayer", "_Blyat" )

hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.Health", function()
    if VC_LOADED and LocalPlayer():InVehicle() and LocalPlayer():GetVehicle():IsValid() then
        draw.SimpleText( "Health: " .. tostring( math.Round( LocalPlayer():GetVehicle():VC_GetHealth(true) ) ), "Health", ScrW() / 2 - 940, ( ScrH() / 2 ) - 525, Color( 0, 0, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP )
    end
end)

net.Receive( "_GameOver", function ( _length )
    local _Player = LocalPlayer()

    timer.Destroy("RaceCountdown")
    timer.Destroy("Countdown")

    hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.Countdown")
    hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.RaceCountdown")

end)

local lerp = 0

function MakeNoteBar( _String, _Timer, _Timer_Length )

    local _w = 500
    local _h = 30
    local _additive = 2

    draw.RoundedBox( 2, ScrW() / 2 - ( _w / 2 ), 5, _w, _h, Color( 33, 33, 33, 255 ) )
    
    if _Timer then

        local _t = timer.TimeLeft( _Timer )

        lerp = Lerp( 2 * FrameTime(), lerp, math.Round( _t ) / _Timer_Length )

        local _w2 = math.Round( _t ) / _Timer_Length

        _additive = 1

        draw.RoundedBox( 2, ScrW() / 2 - ( _w / 2 ), _h + 2, 500 * lerp, 3, Color( 2, 136, 209, 255 ) )
    end

    draw.SimpleText( _String, "Countdown", ScrW() / 2, 17 + _additive, Color( 2, 136, 209 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

net.Receive( "_BeginRace", function( _Length )

    timer.Destroy("RaceCountdown")
    timer.Destroy("Countdown")

    hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.Countdown")
    hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.RaceCountdown")

    local _Player = LocalPlayer()

    if not GetGlobalBool("RACE") then
         _Player:Notify("NOT ELEGIBLE")
        return
    end

    _Player:Notify("RACE STARTING!!!")

    local __countdownfrom = 10
    local __curTime = 10

    function RaceCoutner()
        print("RACE COUNTER ATTMEMPTED")

        hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.RaceCountdown", function()

            local __text = "GO!"

            if timer.TimeLeft( "RaceCountdown" ) <= RACE_LENGTH - 1 then
                __text = tostring( string.FormattedTime( math.Round( timer.TimeLeft( "RaceCountdown" ) ), "%02i:%02i" ) )
            end

            if _Player:GetNW2Bool("LOST") then
                __text = "You lost :("

                --[[
                timer.Simple( 2, function()
                    print("YEET")
                    __text = "Waiting for other players to finish... (" .. tostring( string.FormattedTime( math.Round( timer.TimeLeft( "RaceCountdown" ) ), "%02i:%02i" ) ) .. ")"
                end)
                ]]--
            end

            MakeNoteBar( __text, "RaceCountdown", 360 )
        end)

        timer.Create( "RaceCountdown", RACE_LENGTH, 1, function()
            hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.RaceCountdown")
            timer.Destroy("RaceCountdown")
        end)
    end

    timer.Create( "Countdown", 1, __countdownfrom, function()
        __curTime = __curTime - 1

        if __curTime == 4 then
            surface.PlaySound( "vo/k_lab/kl_initializing02.wav" )
        end

        if __curTime <= 0 then
            hook.Remove("HUDPaint", "KappaJ.Debug.HUDPaint.Countdown")

            RaceCoutner()

            timer.Destroy("Countdown")
        end
    end)

    timer.Create( "dummy", 10, 1, function()

    end)

    hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.Countdown", function()
        MakeNoteBar( tostring( string.FormattedTime( __curTime, "%02i:%02i" ) ), "dummy", 10 )
    end)

end)