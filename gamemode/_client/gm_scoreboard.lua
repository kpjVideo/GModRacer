function scaleW( _Width )
    return ScrW() * ( ( _Width or 0) / 1920 )
end

function scaleH( _Height )
    return ScrH() * ( ( _Height or 0) / 1080 )
end

local blur = Material("pp/blurscreen")

function DrawBlurPanel(panel, amount, heavyness)
	local x, y = panel:LocalToScreen(0, 0)
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
	end
end

function DrawBlurRect(x, y, w, h, amount, heavyness)
	local X, Y = 0,0
	local scrW, scrH = ScrW(), ScrH()

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, scrW, scrH)
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

local PANEL = {}

function PANEL:Init()

	mat = {}

	for k, v in pairs( player.GetAll() ) do

		local __flag = v:GetNW2String("Country")

		if __flag == "" then
			__flag = "US"
		end

		mat[v:SteamID()] = Material("icon16/flags/" .. __flag .. ".png")
		
		//print( mat[v:SteamID()] )
	end

	local Wide = 1200
	local High = 500
 
	surface.CreateFont( "HostName", {
		font = "Roboto",
		size = 20,
		weight = 1000,
		antialias = true,
	} )

	surface.CreateFont( "TinyText", {
		font = "Roboto",
		size = 18,
		weight = 500,
		antialias = true,
	} )


	self:SetSize( scaleW( Wide ), scaleH( High ) )
	self:SetPos( scaleW( 1920 / 2 ) - scaleW( Wide / 2 ), 0 )
	self:SetTitle("")
	self:SetDraggable( false )
	self:ShowCloseButton( false ) //disable later
	self:MakePopup()
	self.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, 25, Color( 211, 47, 47, 255 ) )
		draw.SimpleText( GetHostName(), "HostName", w / 2, 25 / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	self:MoveTo( scaleW( 1920 / 2 ) - scaleW( Wide / 2 ), 100, 0.2, 0 )

	self.UpperBar = vgui.Create( "DPanel", self )
	self.UpperBar:SetSize( scaleW( Wide ), scaleH( 25 ) )
	self.UpperBar:SetPos( 0, 25 )
	self.UpperBar.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 244, 67, 54, 255 ) )

		local __racenum = #player.GetAll()
		local __areIS = {"are", "total racers"}
		
		if __racenum <= 1 then
			__areIS = {"is", "racer"}
		end

		//draw.SimpleText( "There " .. __areIS[1] .. " currently " .. #player.GetAll() .. __areIS[2] .. " playing.", "TinyText", 0, 25 / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
		//draw.SimpleText( "This server has been online for: " .. string.NiceTime( SysTime() ), "TinyText", 10, 25 / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER )
			
		draw.SimpleText( "Country", "TinyText", 10, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Name", "TinyText", 180, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Rank", "TinyText", 365, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Current Vehicle", "TinyText", 540, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Races Won", "TinyText", 735, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Races Lost", "TinyText", 915, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Ping (ms)", "TinyText", 1185, 22.5, Color( 255, 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM )

	end

	self.PList = vgui.Create("DPanelList", self)
	self.PList:SetSize(scaleW( 1200 ), scaleH( 1000 ) )
	self.PList:SetPos( 0, scaleH( 50 ) )
	self.PList:SetSpacing( 1 )
	self.PList:SetPadding( 1 )
	self.PList:EnableHorizontal( false )
	self.PList:EnableVerticalScrollbar( true )
end

local _NiceNames = {}
_NiceNames["owner"] = "Owner"
_NiceNames["developer"] = "Developer"
_NiceNames["superadmin"] = "Super-Admin"
_NiceNames["admin"] = "Admin"
_NiceNames["user"] = "Guest"

function PANEL:Think()
	self.PList:Clear()


	for k, v in pairs(player.GetAll()) do
			
		local _SID = v:SteamID()


		self[_SID] = vgui.Create("DPanel", self.PList)
		self[_SID]:SetSize(0, 28)

		self[_SID].Paint = function(self, w, h)

			//DrawBlurPanel(self, 1, 6)
			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 225))

			--if v == Entity(4) then
				--surface.SetMaterial( Material( "icon16/flags/no.png" ) )
			--else
				surface.SetMaterial( mat[_SID] )
			--end

			surface.SetDrawColor(255, 255, 255, 255)
			surface.DrawTexturedRect(5, (28 - 11) / 2, 16, 11)

			local _Name = v:Nick()
			if string.len( _Name ) >= 15 then
				_Name = string.sub( _Name, 0, 15 ) .. "..."
			end

			local __country_name = v:GetNW2String("CountryName")

			if __country_name == "" then
				__country_name = "Unknown"
			end

			draw.SimpleText(__country_name, "TinyText", 30, 5, Color(0, 0, 0, 255), 0, 2)
			draw.SimpleText(_Name, "TinyText", 180, 5, Color(0, 0, 0, 255, 0, 2))
			draw.SimpleText( _NiceNames[v:GetUserGroup()] or "", "TinyText", 365, 5, Color(0, 0, 0, 255), 0, 2)

			local _veh = "Nothing"

			if v:InVehicle() then
				if v:GetVehicle():IsValidVehicle() then
					if v:GetVehicle():GetNW2String("Name") != nil then
						_veh = v:GetVehicle():GetNW2String("Name")
					end
				end
			end

			draw.SimpleText( tostring( _veh ), "TinyText", 540, 5, Color(0, 0, 0, 255), 0, 2)
			draw.SimpleText( v:GetNW2Int( "RacesWon" ) or 0, "TinyText", 735, 5, Color(0, 0, 0, 255), 0, 2)
			draw.SimpleText( 0, "TinyText", 915, 5, Color(0, 0, 0, 255), 0, 2)
			draw.SimpleText(v:Ping(), "TinyText", 1185, 5, Color(0, 0, 0, 255), TEXT_ALIGN_RIGHT, 2)
			//draw.SimpleText(v:Frags() .. " / " .. v:Deaths(), "TinyText", w - 90, 5, Color(255, 255, 255, 200), 2, 2)
		end

		self.PList:AddItem(self[_SID])
	end
end

function PANEL:Paint( w, h )
	//draw.RoundedBox( 0, 0, 0, w, 20, Color( 211, 47, 47, 255 ) )
	return
	//DrawBlurRect( 0, 30, 900, 900, 3, 6 )
	//draw.RoundedBox( 0, 30, 900, 900, 900, Color( 0, 0, 0, 100 ) )
end

vgui.Register("_Scoreboard", PANEL, "DFrame")

function NilScoreboard()
	if _Scoreboard and _Scoreboard:IsValid() then
		_Scoreboard:Remove()
	end

	_Scoreboard = nil
end

hook.Add( "ScoreboardShow", "KappaJ.Debug.Scoreboard.ScoreboardShow", function()
	NilScoreboard()

	_Scoreboard = vgui.Create( "_Scoreboard" )

	return true //override current hooks
end)

hook.Add( "ScoreboardHide", "KappaJ.Debug.Scoreboard.ScoreboardHide", function()
	NilScoreboard()

	return true //override current hooks
end)
