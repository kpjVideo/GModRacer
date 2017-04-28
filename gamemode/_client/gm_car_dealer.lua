--[[
    Car Dealer Menu Thing ( Beta )
]]--

net.Receive( "_VEH", function( )
    LocalPlayer().Vehicles = net.ReadTable( )
end )


_GM.Client = {}

surface.CreateFont( "TitleFont", {
    font = "Roboto",
    extended = true,
    size = 25,
    weight = 500,
    antialias = true,
} )

surface.CreateFont( "CloseFont", {
    font = "Roboto",
    extended = true,
    size = 25,
    weight = 500,
    antialias = true,
} )

surface.CreateFont( "BrandFont", {
    font = "Roboto",
    extended = true,
    size = 20,
    weight = 400,
    antialias = true,
} )

surface.CreateFont( "Control", {
    font = "Roboto",
    extended = true,
    size = 18,
    weight = 350,
    antialias = true,
    italic = true
} )

surface.CreateFont( "ControlA", {
    font = "Roboto",
    extended = true,
    size = 12,
    weight = 350,
    antialias = true,
    italic = true
} )

local _Mouse_L = Material( "proximity/racing/mouse_left.png" )
local _Mouse_R = Material( "proximity/racing/mouse_right.png" )
local _R_KEY = Material( "gui/r.png" )
local _Sale = Material( "proximity/racing/sale.png" )

local _Acura = Material( "proximity/racing/brands/acura.png" )
local _Audi = Material( "proximity/racing/brands/audi.png" )
local _Volkswagen = Material( "proximity/racing/brands/volkswagen.png" )
local _Alfa_Romeo = Material( "proximity/racing/brands/alfa_romeo.png" )
local _Bugatti = Material( "proximity/racing/brands/bugatti.png" )
local _BMW = Material( "proximity/racing/brands/bmw.png" )
local _Cadillac = Material( "proximity/racing/brands/cadillac.png" )
local _Chevy = Material( "proximity/racing/brands/chevy.png" )
local _Citroen = Material( "proximity/racing/brands/citroen.png" )
local _Corvette = Material( "proximity/racing/brands/corvette.png" )
local _Dodge = Material( "proximity/racing/brands/dodge.png" )
local _Ferrari = Material( "proximity/racing/brands/ferrari.png" )
local _Fiat = Material( "proximity/racing/brands/fiat.png" )
local _Ford = Material( "proximity/racing/brands/ford.png" )
local _GM_ = Material( "proximity/racing/brands/gm.png" )
local _Honda = Material( "proximity/racing/brands/honda.png" )
local _Rolls_Royce = Material( "proximity/racing/brands/rolls-royce.png" )

local _Settings = Material( "proximity/racing/settings.png" )

local _LerpMe = 0
local _LerpMe2 = 0

function CarDealerOpen()

    if _Car_Dealer then
        _Car_Dealer:Remove()
        _Car_Dealer = nil
    end

    _Car_Dealer = vgui.Create( "DFrame" )
    _Car_Dealer:SetSize( scaleX( 1100 ), scaleH( 900 ) )
    _Car_Dealer:Center()
    _Car_Dealer:SetTitle( "" )
    _Car_Dealer:ShowCloseButton( false )
    _Car_Dealer.Paint = function( self, w, h )
        draw.RoundedBox( 4, 0, 0, w, h, Color( 49, 71, 94 ) )
        draw.RoundedBox( 2, 0, 0, w, 45, Color( 49, 153, 220 ) )
        draw.SimpleText( "Vehicle Inventory", "TitleFont", 10, 45 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

    _Car_Dealer:MakePopup()
    _Car_Dealer:SetDraggable( false )

    local _Selection = 0
    local _selection_temp = 0
    local _BoxHighlighted = 0

    _Name_Brands = {}

    local _Side_Panel = vgui.Create( "DScrollPanel_nobar", _Car_Dealer )
    _Side_Panel:SetSize( 50, _Car_Dealer:GetTall() - 45 )
    _Side_Panel:SetPos( 0, 45 )

    _Side_Panel.Paint = function( self, w, h )

        draw.RoundedBox( 4, 0, 0, w, h, Color( 40, 60, 79 ) )

        _LerpMe = Lerp( FrameTime() * 15, _LerpMe, _Selection )
        draw.RoundedBox( 2, 0, ( _LerpMe * 45 ) - ( self:GetVBar().Scroll ), 3, 45, Color( 49, 153, 220 ) )

        if _BoxHighlighted == 1 then
            _LerpMe2 = Lerp( FrameTime() * 15, _LerpMe2, 160 )
        else
            _LerpMe2 = Lerp( FrameTime() * 15, _LerpMe2, 0 )
        end

        _Side_Panel:SetSize( 50 + _LerpMe2, _Side_Panel:GetTall() )

        if _LerpMe2 >= 110 then
            for k, v in pairs( _Name_Brands ) do
                v:SetVisible( true )
            end
        else
            for k, v in pairs( _Name_Brands ) do
                v:SetVisible( false )
            end
        end
    end

    _Side_Panel.OnCursorEntered = function( self )
        _BoxHighlighted = 1
    end

    _Side_Panel.OnCursorExited = function( self )

        timer.Simple( 1, function()
            if not _Side_Panel:IsHovered() then
                _BoxHighlighted = 0
            end
        end)
    end

    Selections = {}

    function Create_Brand( _Name, _Material, _TempSelect )

        Selections[_TempSelect] = _Name

        local _Brand = vgui.Create( "DButton", _Side_Panel )
        _Brand:SetSize( scaleX( 45 ), scaleH( 45 ) )
        _Brand:SetPos( 5, 45 * ( _TempSelect ) + 2 )
        _Brand:SetText( "" )
        _Brand.Paint = function( self, w, h )
            surface.SetDrawColor( 255, 255, 255 )
            surface.SetMaterial( _Material )
            surface.DrawTexturedRect( 45 / 2 - ( 32 / 2 ), 45 / 2 - ( 32 / 2 ), 32, 32 )
        end
        _Brand.DoClick = function( self )

            if _Selection != _TempSelect then
                CreateVehicles( _TempSelect )
            end

            _Selection = _TempSelect
        end
        _Brand._BoxHighlighted = 0

        _Brand.OnCursorEntered = function( self )
            _BoxHighlighted = 1
        end

        _Brand.OnCursorExited = function( self )
            _BoxHighlighted = 0

            timer.Simple( 1, function()
                for k, v in pairs( _Name_Brands ) do
                    if !v:IsValid( ) then return end
                    v:SetVisible( false )
                end
            end)
        end

        _Side_Panel:AddItem( _Brand )

        surface.SetFont( "BrandFont" )
        local width, height = surface.GetTextSize( _Name ) + 10

        local _Name_Brand = vgui.Create( "DPanel", _Car_Dealer )
        _Name_Brand:SetSize( width + 10, 45 )
        _Name_Brand:SetPos( 50, 45 * ( _TempSelect ) + 45 - ( _Side_Panel:GetVBar().Scroll ) )
        _Name_Brand.Paint = function( self, w, h )
            draw.RoundedBox( 4, 0, 0, w, h, Color( 40, 60, 79 ) )
            draw.SimpleText( _Name, "BrandFont", 5, 45 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

            local __change = 45 * ( _TempSelect ) + 45 - ( _Side_Panel:GetVBar().Scroll - 2 )
            if __change <= 0 then
                _Name_Brand:SetVisible( false )
            else
                _Name_Brand:SetPos( 50, __change )
            end
        end
        _Name_Brand:SetVisible( false )

        table.insert( _Name_Brands, _Name_Brand )
    end

    Create_Brand( "Acura", _Acura, 0 )
    Create_Brand( "Alfa-Romeo", _Alfa_Romeo, 1 )
    Create_Brand( "Audi", _Audi, 2 )
    Create_Brand( "Bugatti", _Bugatti, 3 )
    Create_Brand( "BMW", _BMW, 4 )
    Create_Brand( "Cadillac", _Cadillac, 5 )
    Create_Brand( "Chevrolet", _Chevy, 6 )
    Create_Brand( "Citroen", _Citroen, 7 )
    Create_Brand( "Corvette", _Corvette, 8 )
    Create_Brand( "Dodge", _Dodge, 9 )
    Create_Brand( "Ferrari", _Ferrari, 10 )
    Create_Brand( "Fiat", _Fiat, 11 )
    Create_Brand( "Ford", _Ford, 12 )
    Create_Brand( "GM", _GM_, 13 )
    Create_Brand( "Honda", _Honda, 14 )
    Create_Brand( "Rolls-Royce", _Rolls_Royce, 15 )
    Create_Brand( "Volkswagen", _Volkswagen, 16 )


    Create_Brand( "Settings", _Settings, 17.8 )
    --Create_Brand( "Volkswagen", _Volkswagen, 3 )

    function draw.OutlinedBox( x, y, w, h, thickness, clr )
        surface.SetDrawColor( clr )
        for i=0, thickness - 1 do
            surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
        end
    end

    function DrawShit( self )
        if (not IsValid(self.Entity)) then return end
        local x, y = self:LocalToScreen(0, 0)
        self:LayoutEntity(self.Entity)
        local ang = self.aLookAngle

        if (not ang) then
            ang = (self.vLookatPos - self.vCamPos):Angle()
        end

        cam.Start3D(self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ)
        render.SuppressEngineLighting(true)
        render.SetLightingOrigin(self.Entity:GetPos())
        render.ResetModelLighting(self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255)
        render.SetColorModulation(self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255)
        render.SetBlend((self:GetAlpha() / 255) * (self.colColor.a / 255))

        for i = 0, 6 do
            local col = self.DirectionalLight[i]

            if (col) then
                render.SetModelLighting(i, col.r / 255, col.g / 255, col.b / 255)
            end
        end

        self:DrawModel()
        render.SuppressEngineLighting(false)
        cam.End3D()
        self.LastPaint = RealTime()
    end

    function CreateVehicles( _Selection )

        if _Car_Dealer.ActiveWindows then

            for k, v in pairs( _Car_Dealer.ActiveWindows ) do
                v:Remove()
                v = nil
            end

        end

        _Car_Dealer.ActiveWindows = {}

        if _Selection == 17.8 then --temp for settings

            local amnt = 0

            function AddSettingsPanel( _Name )

                amnt = amnt + 1
                local __Panel = vgui.Create( "DPanel", _Car_Dealer )
                __Panel.Y = 55 * amnt

                if amnt > 1 then
                    __Panel.Y = __Panel.Y + 55 * ( amnt - 1 ) / 2
                end

                __Panel.Paint = function( self, w, h )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 40, 60, 79 ) )
                    draw.SimpleText( _Name, "CloseFont", 10, h / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
                    self:SetPos( 60 + _LerpMe2, self.Y )
                    self:SetSize( 1030 - _LerpMe2, 70 )
                end
                table.insert( _Car_Dealer.ActiveWindows, __Panel )

                return __Panel
            end
            local _Currency = AddSettingsPanel( "Currency" )

            for i=1, 4 do
                local img = {}
                img[1] = "usd"
                img[2] = "euro"
                img[3] = "gbp"
                img[4] = "krona"

                _cur = vgui.Create( "DImageButton", _Currency )
                _cur:SetPos( 64 * i + 704, _Currency:GetTall() / 2 - 8 )
                _cur:SetSize( 64, 64 )
                _cur:SetImage( "proximity/racing/" .. img[i] .. ".png" )
                _cur.DoClick = function() print('hi') end

                _cur.Think = function( self )
                    self:SetPos( 64 * i + 704 - _LerpMe2, _Currency:GetTall() / 2 - 32 )
                end

                table.insert( _Car_Dealer.ActiveWindows, _cur )
            end

            local _FOV_Settings = AddSettingsPanel( "Model Preview FOV" )

            for k, v in pairs( { 70, 80, 90, 100 } ) do
                local _70 = vgui.Create( "DButton", _FOV_Settings )
                _70:SetSize( 48, 48 )
                _70:SetText("")
                _70.DoClick = function() print('hi') end

                _70.Think = function( self )
                    self:SetPos( 64 * k + 714 - _LerpMe2, _Currency:GetTall() / 2 - ( 48 / 2) )
                end

                _70.Paint = function( self, w, h )
                    if LocalPlayer().FOVSetting == v then
                        draw.OutlinedBox( 0, 0, w, h, 1, Color( 49, 153, 220, 255 ) )
                    end

                    draw.SimpleText( v, "CloseFont", w / 2, h / 2, Color( 49, 153, 220 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                end

                _70.DoClick = function( self )
                    LocalPlayer().FOVSetting = v
                end

                table.insert( _Car_Dealer.ActiveWindows, _70 )
            end

            local _Preview_Scroll_Speed = AddSettingsPanel( "Vehicle List Scroll Speed" )

            for k, v in pairs( { 50, 60, 70, 80 } ) do
                local _60 = vgui.Create( "DButton", _Preview_Scroll_Speed )
                _60:SetSize( 48, 48 )
                _60:SetText("")

                _60.Think = function( self )
                    self:SetPos( 64 * k + 714 - _LerpMe2, _Currency:GetTall() / 2 - ( 48 / 2) )
                end

                _60.Paint = function( self, w, h )
                    if LocalPlayer().ScrollSpeed == v then
                        draw.OutlinedBox( 0, 0, w, h, 1, Color( 49, 153, 220, 255 ) )
                    end

                    draw.SimpleText( v, "CloseFont", w / 2, h / 2, Color( 49, 153, 220 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                end

                _60.DoClick = function( self )
                    LocalPlayer().ScrollSpeed = v
                end

                table.insert( _Car_Dealer.ActiveWindows, _60 )
            end


            local _HideLicensePlates = AddSettingsPanel( "Draw License Plates" )

            local _Hide_Checkbox = vgui.Create( "GM.Racer.DCheckBox", _HideLicensePlates )
            _Hide_Checkbox:SetSize( 48, 48 )
            _Hide_Checkbox:SetValue( true )
            _Hide_Checkbox.Think = function( self )
                self:SetPos( ( _Car_Dealer:GetWide() - 128 ) - _LerpMe2, ( 70 / 2 ) - ( 48 / 2 ) )
            end

            local _Hide_ChatBox = AddSettingsPanel( "Draw Chatbox" )

            local _Hide_ChatBox2 = vgui.Create( "GM.Racer.DCheckBox", _Hide_ChatBox )
            _Hide_ChatBox2:SetSize( 48, 48 )
            _Hide_ChatBox2:SetValue( true )
            _Hide_ChatBox2:SetConVar( "gm_racer_showchat" )
            _Hide_ChatBox2.Think = function( self )
                self:SetPos( ( _Car_Dealer:GetWide() - 128 ) - _LerpMe2, ( 70 / 2 ) - ( 48 / 2 ) )
            end

            local _Draw_Gifs = AddSettingsPanel( "Draw Animated Chat Images" )

            local _Draw_Gifs2 = vgui.Create( "GM.Racer.DCheckBox", _Draw_Gifs )
            _Draw_Gifs2:SetSize( 48, 48 )
            _Draw_Gifs2:SetValue( true )
            _Draw_Gifs2.Think = function( self )
                self:SetPos( ( _Car_Dealer:GetWide() - 128 ) - _LerpMe2, ( 70 / 2 ) - ( 48 / 2 ) )
            end

            return
        end

        local _Car_List = vgui.Create( "GM.Racer.DHorizontalScroller", _Car_Dealer )
        _Car_List:SetSize( 1030, 140 )
        _Car_List:SetPos( 60, 745 )
        _Car_List.Vehicles = {}

        _Car_List.Paint = function( self, w, h )

            if !self.pnlCanvas then return end

            local _jew =  ( self.pnlCanvas:GetWide() - self:GetWide() )
            local _num = #self.pnlCanvas:GetChildren()
            local _h = h

            if self.pnlCanvas:GetWide() < self:GetWide() then
                _h = _h - 20
            end

            if self.pnlCanvas:GetWide() > self:GetWide() then
                draw.RoundedBox( 0, 0, 0, w, _h - 20, Color( 40, 60, 79 ) )

                draw.RoundedBox( 4, 5, h - 10, w - 10, 6, Color( 30, 49, 70 ) )
                draw.RoundedBox( 4, 5 + ( self.OffsetX / _jew ) * ( w - 600 / _num - 10 ), h - 10, 600 / _num, 6, Color( 49, 153, 220 ) )
            else
                draw.RoundedBox( 0, 0, 0, w, _h, Color( 40, 60, 79 ) )
            end

            self:SetPos( 60 + _LerpMe2, 745 + ( 140 - _h ) )
            self:SetSize( 1030 - _LerpMe2, 150 )
        end
        table.insert( _Car_Dealer.ActiveWindows, _Car_List )

        local val = 0

        local _Sort = vgui.Create( "DComboBox", _Car_Dealer )
        _Sort:SetSize( 128, 24 )
        _Sort:SetPos( _Car_Dealer:GetWide() - 138, 705 )
        _Sort:AddChoice( "Price ( Descending )" )
        _Sort:AddChoice( "Price ( Ascending )" )
        _Sort.OnSelect = function( panel, index, value )

            if val == index then return end --already the same

            val = index

            if index == 1 then
                Sort_Vehicles( true )
            else
                Sort_Vehicles( false )
            end
        end
        _Sort:SetValue( "Price ( Ascending )" )

        table.insert( _Car_Dealer.ActiveWindows, _Sort )

        _Main_CarView = vgui.Create( "DAdjustableModelPanel", _Car_Dealer )
        _Main_CarView:SetPos( _Car_Dealer:GetWide() / 2, 60 )
        _Main_CarView:SetSize( 1030, 512 + 128 )
        _Main_CarView:SetFOV( LocalPlayer().FOVSetting or 80 )
        _Main_CarView:SetCamPos( Vector( -260, 0, 60 ) )
        _Main_CarView:SetAmbientLight( Color( 200, 200, 200, 100 ) )
        _Main_CarView.CL = {}

        table.insert( _Car_Dealer.ActiveWindows, _Main_CarView )


        _Main_CarView.aLookAngle = Angle( 9, -4, 0 )

        function _Main_CarView:LayoutEntity( _Entity )
            if not _Entity:IsValid() then return end

            _Entity:SetAngles( Angle( 0, 120, 0 ) )
            _Entity:SetPos( Vector( 0, 0, 0 ) )

            return
        end

        function _Main_CarView:PostDrawModel( _Entity )

            if not _Entity:IsValid() then return end

            if _Entity.modelEnt && _Entity.modelEnt:IsValid() then
                _Entity.modelEnt:DrawModel()
            end
        end

        function _Main_CarView:Think( )

            if ( !IsValid( _Main_CarView.Entity ) ) then return end

            if input.IsKeyDown( KEY_R ) then
                _Main_CarView:SetFOV( LocalPlayer().FOVSetting or 80 )
                _Main_CarView:SetCamPos( Vector( -260, 0, 60 ) )
                _Main_CarView.aLookAngle = Angle( 9, -4, 0 )
            end

            if ( !self.Capturing ) then return end

            if ( self.m_bFirstPerson ) then
                return self:FirstPersonControls()
            end
        end

        function _Main_CarView:OnMouseWheeled( _Delta ) return false end

        _Main_CarView.Paint = function( self, w, h )

            _Main_CarView:SetPos( 60 + _LerpMe2, 60 )
            _Main_CarView:SetSize( 1030 - _LerpMe2, 512 + 128 )

            DrawShit( self )

            --draw.OutlinedBox( 0, 0, w, h, 1, Color( 49, 153, 220, 255 ) )

            if self.Capturing then
                self:SetCursor( "blank" )
            else
                self:SetCursor( "hand" )
            end

            surface.SetDrawColor( 255, 255, 255 )

            surface.SetMaterial( _Mouse_L )
            surface.DrawTexturedRect( 5, 5, 24, 24 )
            draw.SimpleText( "Rotate Vehicle", "Control", 30, ( 24 / 2 ) + 6, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        
            surface.SetMaterial( _Mouse_R )
            surface.DrawTexturedRect( 8, 32, 24, 24 )
            draw.SimpleText( "Free-Look", "Control", 31, ( 24 / 2 ) + 33, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )

            surface.SetMaterial( _R_KEY )
            surface.DrawTexturedRect( 9, 62, 18, 18 )
            draw.SimpleText( "Reset View", "Control", 31, ( 18 / 2 ) + 63, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
        end

        --AdjustableModelPanel:SetModel( "models/props_borealis/bluebarrel001.mdl" )
        function ClearBullshit( )
            if _Car_List.Vehicles then
                for k, v in pairs( _Car_List.Vehicles ) do
                    if v && v:IsValid() then
                        v:Remove()
                        v = nil
                    end
                end
            end
        end

        function Sort_Vehicles( _Desc )

            ClearBullshit( )

            for k, v in SortedPairsByMemberValue( VEHICLES, "Price", _Desc ) do
                if v.Manufacture == Selections[_Selection] then
                    --do stuff
                    local _Veh_Panel = vgui.Create( "DModelPanel" )
                    _Veh_Panel:SetSize( 300, 150 )
                    _Veh_Panel:SetModel( v.Model )
                    _Veh_Panel:DockMargin( 0, 0, 2, 0 )
                    _Veh_Panel:Dock( LEFT )
                    _Veh_Panel:SetFOV( 25 )
                    _Veh_Panel:SetCamPos( Vector( 600, 0, 50 ) )
                    _Veh_Panel:SetColor( Color( 255, 255, 255 ) )
                    _Veh_Panel.Entity:SetPos( Vector( 0, 3, 0 ) )
                    _Veh_Panel.ID = v.ID

                    _Car_List:AddPanel( _Veh_Panel )

                    if !_Veh_Panel.Entity.createdModel && _Veh_Panel.Entity:GetModel() == "models/crsk_autos/bmw/i8_2015.mdl" then
                        print("CREATING")
                         _Veh_Panel.Entity.modelEnt = ClientsideModel( "models/crsk_autos/bmw/i8_2015_extra.mdl", RENDER_GROUP_VIEW_MODEL_OPAQUE)
                         _Veh_Panel.Entity.modelEnt:SetPos( _Veh_Panel.Entity:LocalToWorld( Vector( 0,0,0 ) ) )
                        _Veh_Panel.Entity.modelEnt:SetAngles( _Veh_Panel.Entity:LocalToWorldAngles( Angle(0,0,0) ) )
                        _Veh_Panel.Entity.modelEnt:SetParent( _Veh_Panel.Entity )
                        _Veh_Panel.Entity.createdModel = _Veh_Panel.Entity.modelEnt
                    end

                    if !_Veh_Panel.Entity.createdModel && _Veh_Panel.Entity:GetModel() == "models/metrohd/vw_passat_variant.mdl" then
                        print("CREATING")
                        _Veh_Panel.Entity.modelEnt = ClientsideModel( "models/metrohd/vw_passat_variant_extra.mdl", RENDER_GROUP_VIEW_MODEL_OPAQUE)
                        _Veh_Panel.Entity.modelEnt:SetPos( _Veh_Panel.Entity:LocalToWorld( Vector( 0,0,0 ) ) )
                        _Veh_Panel.Entity.modelEnt:SetAngles( _Veh_Panel.Entity:LocalToWorldAngles( Angle(0,0,0) ) )
                        _Veh_Panel.Entity.modelEnt:SetParent( _Veh_Panel.Entity )
                        _Veh_Panel.Entity.createdModel = _Veh_Panel.Entity.modelEnt
                    end

                    function _Veh_Panel:PostDrawModel( _Entity )
                        --wtf crks?
                        if _Entity.modelEnt && _Entity.modelEnt:IsValid() then
                            _Entity.modelEnt:DrawModel()
                        end
                    end

                    local lerp_col = 0.5


                    function ClientsideSubModel( _Entity, _Clause, _Extra )
                        if _Entity:GetModel() == _Clause && !_Entity.createdModel then
                            _Entity.modelEnt = ClientsideModel( _Extra, RENDER_GROUP_VIEW_MODEL_OPAQUE)
                            _Entity.modelEnt:SetPos( _Entity:LocalToWorld( Vector( 0,0,0 ) ) )
                            _Entity.modelEnt:SetAngles( _Entity:LocalToWorldAngles( Angle(0,0,0) ) )
                            _Entity.modelEnt:SetParent( _Entity )
                            table.insert( _Main_CarView.CL, _Entity.modelEnt )
                        end
                    end

                    function _Veh_Panel:LayoutEntity( Entity )  end

                    _Veh_Panel.DoClick = function( self )

                        if _Car_List.Selected == self then return end --already selected my nigga

                        if _Equip then
                            _Equip:Remove()
                            _Equip = nil
                        end

                        if table.HasValue( LocalPlayer().Vehicles, v.ID ) then
                            _Equip = vgui.Create( "DButton", _Car_Dealer )
                            _Equip:SetSize( 150, 32 )
                            _Equip:SetPos( _Car_Dealer:GetWide() - 165, 60 )
                            _Equip:SetText( "" )
                            _Equip.Paint = function( self, w, h )
                                draw.RoundedBox( 4, 0, 0, w, h, Color( 49, 153, 255, lerp_col * 255 ) )
                                draw.SimpleText( "Select", "BrandFont", w / 2, h / 2, Color( 235, 235, 235 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                                if self:IsHovered() then
                                    lerp_col = Lerp( FrameTime() * 5, lerp_col, 1 )
                                else
                                    lerp_col = Lerp( FrameTime() * 10, lerp_col, 0.5 )
                                end

                            end
                            _Equip.DoClick = function()
                                print "YEET"
                            end
                        end

                        _Car_List.Selected = _Veh_Panel

                        for k, v in pairs( _Main_CarView.CL ) do
                            if v:IsValid() then
                                v:Remove()
                                v = nil
                            end
                        end

                        _Main_CarView:SetModel( v.Model )

                        --wtf crks?
                        local _Entity = _Main_CarView:GetEntity()

                        ClientsideSubModel( _Entity, "models/crsk_autos/bmw/i8_2015.mdl", "models/crsk_autos/bmw/i8_2015_extra.mdl" )
                        ClientsideSubModel( _Entity, "models/metrohd/vw_passat_variant.mdl", "models/metrohd/vw_passat_variant_extra.mdl" )
                        ClientsideSubModel( _Entity, "models/metrohd/rroyce_ghost.mdl", "models/metrohd/rroyce_ghost_extra.mdl" )
                    end

                    _Veh_Panel.Paint = function( self, w, h )
                        if ( !IsValid( self.Entity ) ) then return end

                        local x, y = self:LocalToScreen( 0, 0 )

                        self:LayoutEntity( self.Entity )

                        local ang = self.aLookAngle
                        if ( !ang ) then
                            ang = ( self.vLookatPos - self.vCamPos ):Angle()
                        end

                        cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )

                        render.SuppressEngineLighting( true )
                        render.SetLightingOrigin( self.Entity:GetPos() )
                        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
                        render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
                        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) )

                        for i = 0, 6 do
                            local col = self.DirectionalLight[ i ]
                            if ( col ) then
                                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
                            end
                        end

                        self:DrawModel()

                        render.SuppressEngineLighting( false )
                        cam.End3D()

                        self.LastPaint = RealTime()
                        
                        draw.RoundedBox( 0, 0, 0, _Veh_Panel:GetWide(), 25, Color( 20, 20, 20, 200 ) )

                        local col = Color( 255, 255, 255, 255 )
                        if table.HasValue( LocalPlayer().Vehicles, v.ID ) then
                            col = Color( 76, 175, 80, 255 )
                        end

                        draw.SimpleText( v.Name, "BrandFont", _Veh_Panel:GetWide() / 2, 25 / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

                        local __text = "$" .. string.Comma( v.Price )
                        surface.SetFont( "BrandFont" )
                        local ww, hh = surface.GetTextSize( __text )
                        ww = ww + 8

                        draw.RoundedBox( 0, _Veh_Panel:GetWide() - ww, _Veh_Panel:GetTall() - hh * 2, ww, hh, Color( 20, 20, 20, 230 ) )
                        draw.SimpleText( __text, "BrandFont", _Veh_Panel:GetWide() - ww + 4, _Veh_Panel:GetTall() - hh * 1.5, col, TEXT_ALGIN_CENTER, TEXT_ALIGN_CENTER )

                        if v.Sale then
                            surface.SetDrawColor( 255, 255, 255 )
                            surface.SetMaterial( _Sale )
                            surface.DrawTexturedRect( 5, 25, 42, 42 )
                        end

                        --[[
                        draw.RoundedBox( 2, 0, 125, _Veh_Panel:GetWide() / 2, 10, Color( 20, 20, 20, 200 ) )
                        draw.RoundedBox( 2, 0, 125, _Veh_Panel:GetWide() / 2, 10, Color( 244, 67, 54, 200 ) )
                        draw.SimpleText( "Max Speed: " .. v.MaxSpeed, "ControlA", 125 / 2, 130, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                        ]]--

                        if _Car_List.Selected == self then
                            draw.OutlinedBox( 0, 0, w, h - 20, 1, Color( 49, 153, 220, 255 ) )
                        end

                        if self.Dragging then
                            print("YES")
                        end
                    end

                    _Car_List.Vehicles[v.ID] = _Veh_Panel
                end
            end
        end

        Sort_Vehicles( false )
    end

    --CreateVehicles( 0 )

    local _Close_Me = vgui.Create( "DButton", _Car_Dealer )
    _Close_Me:SetSize( scaleX( 45 ), scaleH( 45 ) )
    _Close_Me:SetPos( scaleX( 1100 - 45 ), 0 )
    _Close_Me:SetText( "" )
    _Close_Me.DoClick = function( self )

    	if _Main_CarView && _Main_CarView.CL then
	        for k, v in pairs( _Main_CarView.CL ) do
	            if v && v:IsValid() then
	                v:Remove()
	                v = nil
	            end
	        end
	    end

        if _Car_Dealer then
            _Car_Dealer:Remove()
            _Car_Dealer = nil
        end
    end

    _Close_Me.Paint = function( self, w, h )
        draw.SimpleText( "X", "CloseFont", 10, 45 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
    end

end

net.Receive( "ShowSpare1", function( )
	if CLIENT then
		CarDealerOpen( )
	end
end)