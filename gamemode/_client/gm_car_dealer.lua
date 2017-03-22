--[[
	Car Dealer Menu Thing ( Beta )
]]--

_GM.Client = {}
_GM.Client.VGUI = {}

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

local _Acura = Material( "acura.png" )
local _Audi = Material( "audi.png" )
local _Volkswagen = Material( "volkswagen.png" )
local _Alfa_Romeo = Material( "alfa_romeo.png" )
local _Bugatti = Material( "bugatti.png" )
local _BMW = Material( "bmw.png" )
local _Cadillac = Material( "cadillac.png" )
local _Chevy = Material( "chevy.png" )
local _Citroen = Material( "citroen.png" )
local _Corvette = Material( "corvette.png" )
local _Dodge = Material( "dodge.png" )

local _LerpMe = 0
local _LerpMe2 = 0

function _GM.Client.VGUI:CarDealerOpen()

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

	local _Side_Panel = vgui.Create( "DScrollPanel", _Car_Dealer )
	_Side_Panel:SetSize( 50, _Car_Dealer:GetTall() - 45 )
	_Side_Panel:SetPos( 0, 45 )

	_Side_Panel.Paint = function( self, w, h )
		draw.RoundedBox( 4, 0, 0, w, h, Color( 40, 60, 79 ) )

		_LerpMe = Lerp( FrameTime() * 15, _LerpMe, _Selection )
		draw.RoundedBox( 2, 0, _LerpMe * 45, 3, 45, Color( 49, 153, 220 ) )

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
					v:SetVisible( false )
				end
			end)
		end

		_Side_Panel:AddItem( _Brand )

		surface.SetFont( "BrandFont" )
		local width, height = surface.GetTextSize( _Name ) + 10

		local _Name_Brand = vgui.Create( "DPanel", _Car_Dealer )
		_Name_Brand:SetSize( width + 10, 45 )
		_Name_Brand:SetPos( 50, 45 * ( _TempSelect ) + 45 )
		_Name_Brand.Paint = function( self, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, Color( 40, 60, 79 ) )
			draw.SimpleText( _Name, "BrandFont", 5, 45 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
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

	--Create_Brand( "Volkswagen", _Volkswagen, 3 )

	function draw.OutlinedBox( x, y, w, h, thickness, clr )
		surface.SetDrawColor( clr )
		for i=0, thickness - 1 do
			surface.DrawOutlinedRect( x + i, y + i, w - i * 2, h - i * 2 )
		end
	end

	function CreateVehicles( _Selection )

		local _Car_List = vgui.Create( "DScrollPanel", _Car_Dealer )
		_Car_List:SetSize( 1030, 150 )
		_Car_List:SetPos( 60, 740 )
		_Car_List.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0 + _LerpMe2, 0, w, h, Color( 40, 60, 79 ) )
		end

		for k, v in pairs( VEHICLES ) do
			if v.Manufacture == Selections[_Selection] then
				--do stuff
				local _Veh_Panel = vgui.Create( "DModelPanel", _Car_List )
				_Veh_Panel:SetSize( 300, 150 )
				_Veh_Panel:SetModel( v.Model )
				_Veh_Panel:DockMargin( 0, 0, 2, 0 )
				_Veh_Panel:Dock( LEFT )
				_Veh_Panel:SetFOV( 25 )
				_Veh_Panel:SetCamPos( Vector( 600, 0, 50 ) )
				_Veh_Panel:SetColor( Color( 255, 255, 255 ) )
				_Veh_Panel.Entity:SetPos( Vector( 0, 3, 0 ) )
				function _Veh_Panel:LayoutEntity( Entity )	end

				_Veh_Panel.DoClick = function()
					_Veh_Panel.Selected = true
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

					if _Veh_Panel.Selected then
						draw.OutlinedBox( 0, 0, w, h, 1, Color( 49, 153, 220, 255 ) )
					end
				end
			end
		end

	end

	--CreateVehicles( 0 )

	local _Close_Me = vgui.Create( "DButton", _Car_Dealer )
	_Close_Me:SetSize( scaleX( 45 ), scaleH( 45 ) )
	_Close_Me:SetPos( scaleX( 1100 - 45 ), 0 )
	_Close_Me:SetText( "" )
	_Close_Me.DoClick = function( self )
		if _Car_Dealer then
			_Car_Dealer:Remove()
			_Car_Dealer = nil
		end
	end

	_Close_Me.Paint = function( self, w, h )
        draw.SimpleText( "X", "CloseFont", 10, 45 / 2, Color( 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
	end

end

//_GM.Client.VGUI:CarDealerOpen()
