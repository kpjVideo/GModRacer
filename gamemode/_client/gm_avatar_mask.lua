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

function PANEL:SetSteamID( id )
    self.Avatar:SetSteamID( util.SteamIDTo64( id ) )
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

surface.CreateFont( "LAPS", {
    font = "Roboto",
    extended = true,
    size = 50,
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

local polate = 0

function MakeSquareBar( _Max )

    MAX_CHECKPOINTS = #ents.FindByClass( "_racecheckpoint" )

    local _w = 500
    local _h = 58
    local _additive = 2

    draw.RoundedBox( 2, ScrW() - 133, 5, 128, _h, Color( 33, 33, 33, 255 ) )
    
    if _Max then

        local _T = _Max / MAX_CHECKPOINTS

        polate = Lerp( 2 * FrameTime(), polate, _T )

        _additive = 1

        draw.RoundedBox( 0, ScrW() - 133, _h + 2, 128 * polate, 3, Color( 2, 136, 209, 255 ) )
    end

    draw.SimpleText( tostring( _Max ) .. --[[LAP NUM]] "/" .. tostring( MAX_CHECKPOINTS ), "LAPS", ScrW() - ( 145 / 2 ), 32.5, Color( 2, 136, 209 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

local _WrongWay = Material( "proximity/wrong_way.png" )
local _WaitMe = 0

hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.WrongDirection", function()
    --Eventually detect if looking in wrong direction?
    --I really don't know my way around angle calculations :/

    if LocalPlayer():IsValid() && LocalPlayer():InVehicle() && LocalPlayer():GetVehicle():IsValidVehicle() && LocalPlayer():GetNW2Int( "Checkpoint" ) != nil && LocalPlayer():GetNW2Int( "Checkpoint" ) != MAX_CHECKPOINTS  then
        if _GM.Racing.ActiveCheckpoints && _GM.Racing.ActiveCheckpoints[ LocalPlayer():GetNW2Int( "Checkpoint" ) + 1 ] && _GM.Racing.ActiveCheckpoints[ LocalPlayer():GetNW2Int( "Checkpoint" ) + 1 ]:IsValid() then
            if not _GM.Racing.ActiveCheckpoints[ LocalPlayer():GetNW2Int( "Checkpoint" ) + 1 ]:GetPos():ToScreen().visible then
                _WaitMe = _WaitMe + 1

                --yes, i'm seriously making a timer based on frames, sue me...

                if _WaitMe >= 300 then
                    surface.SetDrawColor( 255, 255, 255, math.abs( math.sin( CurTime() * 1.1 ) ) * 200 )
                    surface.SetMaterial( _WrongWay )
                    surface.DrawTexturedRect( ScrW() / 2 - ( 800 / 2 ) / 2, ScrH() / 2 - ( 490 / 2 ) / 2 - 200, 800 / 2, 490 / 2 )
                end
            else
                _WaitMe = 0
            end
        end
    end
end)

hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.Laps", function()
    if LocalPlayer():GetNW2Int( "Checkpoint" )  != nil then
        MakeSquareBar( LocalPlayer():GetNW2Int( "Checkpoint" ) )
    end
end)

surface.CreateFont( "Ranking", {
    font = "Roboto",
    size = 20,
    weight = 400,
    antialias = true,
} )

hook.Add("HUDPaint", "KappaJ.Debug.HUDPaint.Ranking", function()

    if not LocalPlayer():Alive() then return end

    local __racers = {}

    for k, v in pairs( player.GetAll() ) do

        __racers[k] = { v, v:GetNW2Int( "Checkpoint" ), v:GetNW2Int( "Checkpoint_Time" ) }
        table.sort( __racers, function( x, y )
            local __clause = ( x[2] > y[2] ) --&& ( x[3] < y[3] )

            if x[2] == y[2] then
                return x[3] < y[3]
            end

            return __clause
        end )

        for _, _v in pairs( __racers ) do 

            local __name = _v[1]:Nick()

            local __additive = ( _ - 1 ) * 35

            draw.RoundedBox( 2, 5, 5 + __additive, 175, 30, Color( 33, 33, 33, 255 ) )
            draw.RoundedBox( 2, 5, 5 + __additive, 25, 30, Color( 2, 136, 209, 255 ) )

            draw.SimpleText( _, "Ranking", 6 + 20 / 2, ( 38 / 2 ) + __additive + 1, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

            if _v[1] == LocalPlayer() then
                draw.RoundedBox( 2, 5, 33 + __additive, 175, 3, Color( 2, 136, 209, 255 ) )
            end

            if string.len( __name ) >= 16 then
                __name = string.sub( __name, 0, 13 ) .. "..."
            end

            draw.SimpleText( __name, "Ranking", 35, ( 33 / 2 + 3 ) + __additive, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

        end
    end
end)

net.Receive( "_BeginRace", function( _Length )

    LocalPlayer():SetNW2Int( "Checkpoint", 0 )

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