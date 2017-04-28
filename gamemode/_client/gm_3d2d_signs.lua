surface.CreateFont( "START", {
	font = "Roboto",
	extended = true,
	size = 110,
	weight = 500,
	antialias = true,
	additive = false,
	italic = true,
} )

surface.CreateFont( "_Type_Font", {
	font = "Roboto",
	extended = true,
	size = 80,
	weight = 300,
	antialias = true,
	additive = false,
	italic = true,
} )

hook.Add("VC_CanEditAdminSettings", "VC_CanEditAdminSettings_2", function(ply, default)
     return true
end)

local _MaterialLol = Material( "proximity/race_start" )


hook.Add( "PostDrawOpaqueRenderables", "KappaJ.Racing.PostDrawOpaqueRenderables.StartEnd", function()
	 
     local __test = LocalPlayer():EyeAngles()
     __test:RotateAroundAxis( __test:Right(), 90 )
     __test:RotateAroundAxis( __test:Up(), -90 )

     cam.Start3D2D( _GM.Racing.StartFinish[game.GetMap()][1][1] - Vector( 250, 50, -30 ) or Vector( 0, 0, 0 ), _GM.Racing.StartFinish[game.GetMap()][1][2] or Angle(0,0,0), 0.5 )
     	  surface.SetDrawColor( 255, 255, 255, 255 )
     	  surface.SetMaterial( _MaterialLol	)
     	  surface.DrawTexturedRect( 0, 0, 1024, 256 )
     cam.End3D2D()

     cam.Start3D2D( _GM.Racing.StartFinish[game.GetMap()][1][1] or Vector( 0, 0, 0 ), _GM.Racing.StartFinish[game.GetMap()][1][2] or Angle(0,0,0), 0.5 )
           draw.DrawText("START","START",0,0,Color(255,0,0,255),TEXT_ALIGN_CENTER)
     cam.End3D2D()
end)

local matMaterial = Material( "pp/texturize" )
matMaterial:SetTexture( "$fbtexture", render.GetScreenEffectTexture() )

local pp_texturize = CreateClientConVar( "pp_texturize", "", false, false )
local pp_texturize_scale = CreateClientConVar( "pp_texturize_scale", "1", true, false )
	
hook.Add( "RenderScreenspaceEffects", "RenderTexturize", function()

	if GetGlobalBool( "WINNER" ) then
		DrawTexturize( 1, Material( "pp/texturize/plain.png" ) )
	end

end )

local _bad_ = {
	CHudHealth = true,
	CHudCrosshair = true,
	CHudDeathNotice = true,
	CHudZoom = true,
	CTargetID = true,
	CHudWeaponSelection = true,
	CHudWeapon = true,
	CHudHistoryResource = true,
}

hook.Add( "HUDShouldDraw", "KappaJ.Debug.HUDShouldDraw.HideBad", function( _Name )
	if ( _bad_[ _Name ] ) then
		return false
	end
end)

local _bad = {
	CHudGMod = true,
}

hook.Add( "HUDShouldDraw", "KappaJ.Debug.HUDShouldDraw.WinnerInfo", function( _Name )

	if GetGlobalBool("WINNER") then
		if ( _bad[ _Name ] ) then
			return true
		end
	end

end)

net.Receive( "_Winner_Screen", function( _Length, _Player )
	
	if _Avatar && _Avatar:IsValid() then
		_Avatar:Remove()
		_Avatar = nil
	end

	local _Entity = net.ReadEntity( )
	local Text_Interpolate = 0

	surface.PlaySound( "misc/freeze_cam.wav" )

	_Avatar = vgui.Create( "AvatarCircleMask" )
	_Avatar:SetPlayer( _Entity )
	_Avatar:SetSize( scaleX( 256 ), scaleH( 256 ) )
	_Avatar:SetMaskSize( 256 / 2 )
	_Avatar:SetPos( scaleX( 30 ), scaleH( Text_Interpolate ) )

	hook.Add( "HUDPaint", "KappaJ.Debug.HUDPaint.WinnerInfo", function( )

		if not GetGlobalBool("WINNER") then
			if _Avatar && _Avatar:IsValid() then
				_Avatar:Remove()
				_Avatar = nil
			end

			return
		end

		local _Name = _Entity:Nick()
		local _Veh_Type = _Entity:GetVehicle()

		surface.SetFont( "START" )
		local w,h = surface.GetTextSize( _Name )

		Text_Interpolate = Lerp( FrameTime() * 3, Text_Interpolate, ScrH() / 2 - ( h / 2 ) - 70 )

		if _Avatar && _Avatar:IsValid() then
			print("VALID YO")
			_Avatar:SetPos( scaleX( 50 ), scaleH( Text_Interpolate ) )
		end

		if _Entity:IsValid() && _Entity:InVehicle() && _Veh_Type:IsValid() then
			DrawEnchantedText(1, _Name, "START", ScrW() / 2 - ( w / 2 ) - 550, Text_Interpolate, Color( 255, 0, 0 ), Color( 100, 0, 0 ) )
			DrawEnchantedText(1, _Veh_Type:GetNW2String("Name"), "_Type_Font", ScrW() / 2 - ( w / 2 ) - 570, Text_Interpolate + 100, Color( 255, 0, 0 ), Color( 100, 0, 0 ) )
		
			if Entity(1):GetNW2Int("NewTime") <= Entity(1):GetNW2Int("BestTime") then
				DrawRainbowText( 2, "PERSONAL RECORD " .. " (" .. string.FormattedTime( Entity(1):GetNW2Int("NewTime"), "%02im %02is" ) .. ")", "_Type_Font", ScrW() / 2 - ( w / 2 ) - 570, Text_Interpolate + 170, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP ) 
			end
		end
	end)

end)