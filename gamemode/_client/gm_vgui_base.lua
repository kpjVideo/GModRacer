--[[
local _Gradient = Material("gui/gradient_up")

local _a = 0

hook.Add("HUDPaint", "KappaJ.asd", function()

	if LocalPlayer():IsValid() and LocalPlayer():InVehicle() then
		if LocalPlayer():GetVehicle():IsValidVehicle() then

			local _temp = LocalPlayer():GetVehicle():GetNWString("VC_Health")

			if _temp != "" then
				_a = Lerp( 2 * FrameTime(), _a, tonumber( _temp ) )

				surface.SetDrawColor(Color(0, 0, 0, 255))

				local _WID = 500
				local _HEI = 20

				surface.DrawRect( ScrW() / 2 - ( _WID / 2 ), 54, _WID, _HEI )

				surface.SetDrawColor(HSVToColor( ( _a ) % 360, 1, 1) )
				surface.SetMaterial(_Gradient)
				surface.DrawTexturedRect( ScrW() / 2 - ( _WID / 2 ), 54, _WID, _HEI )

				surface.SetDrawColor(HSVToColor( ( _a + 20 ) % 360, 1, 1) )
				surface.SetMaterial( _Gradient )
				surface.DrawTexturedRectUV( ScrW() / 2 - ( _WID / 2 ), 54, _WID, _HEI, 0, 1, 1, 0)

				draw.SimpleTextOutlined( "Health: " .. math.Round( _temp / LocalPlayer():GetVehicle():GetMaxHealth() )  .. "%", "PPanelFont", ScrW() / 2, 57, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color( 0, 0, 0, 255 ) )
			end
		end
	end
end)
]--

--[[--------------------------------
	Panels
----------------------------------]]

surface.CreateFont( "PPanelFont", {
	font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 15,
	weight = 1000,
	antialias = true,
} )

local PANEL = {}

local downGradient = Material("vgui/gradient-d")
local upGradient = Material("vgui/gradient-u")
local blur = Material( "pp/blurscreen" )

function PANEL:Paint(w, h)

	local x, y = self:LocalToScreen(0, 0)
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, 2 do
		blur:SetFloat("$blur", (i / 3) * 2)
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH() )
	end

	draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
	
	surface.SetDrawColor(0, 0, 0, 150)
	surface.SetMaterial(downGradient)
	surface.DrawTexturedRect(2, 2, w, h)

	if self.InventoryPanel then
		local border = 5
		draw.RoundedBox( 0, border, 62, self:GetWide() - ( border * 2 ), 1, Color( 220, 220, 220, 150 ) )
		--draw.RoundedBox( 0, 0, 26, self:GetWide(), 1, Color( 220, 220, 220, 150 ) )
	end

end

derma.DefineControl("PFrame", "_ProxFrame", PANEL, "DFrame")

local PANEL = {}

function PANEL:Init()
	self.mousecolor = Color( 0, 0, 0, 100 )
	self.textcolor = Color( 220, 220, 220, 220 )
end

function PANEL:Paint(w, h)

	self:SetTextColor( self.textcolor )

	--if not self.overme then return end

	local x, y = self:LocalToScreen(0, 0)
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, 2 do
		blur:SetFloat("$blur", (i / 3) * 2)
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH() )
	end

	draw.RoundedBox( 0, 0, 0, w, h, self.mousecolor )
	
	surface.SetDrawColor(self.mousecolor.r, self.mousecolor.g, self.mousecolor.b, self.mousecolor.a)
	surface.SetMaterial(downGradient)
	surface.DrawTexturedRect(0, 0, w, h)
end

function PANEL:OnCursorEntered()
	self.mousecolor = Color( 0, 0, 0, 150 )
	self.textcolor = Color( 200, 200, 200, 220 )
	self.overme = true
end

function PANEL:OnCursorExited()
	self.mousecolor = Color( 0, 0, 0, 100 )
	self.textcolor = Color( 220, 220, 220, 220 )
	self.overme = nil
end

derma.DefineControl("PButton", "_ProxButton", PANEL, "DButton")



surface.CreateFont( "PPanelTextFont", {
	font = "Roboto",
	size = 15,
	weight = 1000,
	antialias = true,
} )

local PANEL = {}

function PANEL:Init()
	self.mousecolor = Color( 0, 0, 0, 100 )
	self.paneltext = ""
end

function PANEL:Paint(w, h)



	draw.RoundedBox( 0, 0, 0, w, h, self.mousecolor )
	
	surface.SetDrawColor(self.mousecolor.r, self.mousecolor.g, self.mousecolor.b, self.mousecolor.a)
	surface.SetMaterial(downGradient)
	surface.DrawTexturedRect(0, 0, w, h)

	draw.SimpleText( self.paneltext, 'PPanelTextFont', w / 2, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

function PANEL:CreateInv()
	local mdl = vgui.Create( "PSpawnIcon", self )
	mdl:SetModel( "models/props_junk/wood_crate001a_damaged.mdl" )
	mdl:SetSize( self:GetWide() - 5, self:GetTall() - 5 )
	mdl:Center()
	mdl:InvalidateLayout( true )
	mdl:SetParent( self )
end


function PANEL:OnCursorEntered()
	self.mousecolor = Color( 0, 0, 0, 150 )
end

function PANEL:OnCursorExited()
	self.mousecolor = Color( 0, 0, 0, 100 )
end

function PANEL:SetPanelText( _Text )
	self.paneltext = _Text
end

derma.DefineControl("PPanel", "_ProxPanel", PANEL, "DPanel")







local PANEL = {}

function PANEL:Init()

	--self:EnableHorizontal( true )
	--self:EnableVerticalScrollbar()
	self:SetSpacing( 2 )
	self:SetPadding( 2 )

end

function PANEL:Paint()
	if not self.RenderBackground then
		return false
	end
end

derma.DefineControl( "PPanelSelect", "_ProxSelectPanel", PANEL, "DPanelList" )

function PANEL:Init()
	self.mousecolor = Color( 0, 0, 0, 100 )
	self.paneltext = ""
end

function PANEL:OnCursorEntered()
	self.mousecolor = Color( 0, 0, 0, 150 )
end

function PANEL:OnCursorExited()
	self.mousecolor = Color( 0, 0, 0, 100 )
end

function PANEL:Paint(w, h)

	--if not self.overme then return end

	draw.RoundedBox( 0, 0, 0, w, h, self.mousecolor )
	
	surface.SetDrawColor(self.mousecolor.r, self.mousecolor.g, self.mousecolor.b, self.mousecolor.a)
	surface.SetMaterial(downGradient)
	surface.DrawTexturedRect(0, 0, w, h)

	draw.SimpleText( self.paneltext, 'PPanelTextFont', w / 2, h / 2, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end




local PANEL = {}

AccessorFunc( PANEL, "m_strModelName",	"ModelName" )
AccessorFunc( PANEL, "m_iSkin",			"SkinID" )
AccessorFunc( PANEL, "m_strBodyGroups",	"BodyGroup" )
AccessorFunc( PANEL, "m_strIconName",	"IconName" )

function PANEL:Init()

	self:SetDoubleClickingEnabled( false )
	self:SetText( "" )

	--self.Icon = vgui.Create( "ModelImage", self )
	--self.Icon:SetMouseInputEnabled( false )
	--self.Icon:SetKeyboardInputEnabled( false )

	self:SetSize( 60, 60 )

	self.m_strBodyGroups = "000000000"

end

function PANEL:DoClick() return end
function PANEL:Paint() return end
function PANEL:PaintOver() return end
function PANEL:DoRightClick() return end
function PANEL:PerformLayout() self.Icon:StretchToParent( 0, 0, 0, 0 ) self:GetParent():PerformLayout()  end
function PANEL:DoClick() self:GetParent().DropAction() end
function PANEL:OnCursorEntered() self:GetParent():OnCursorEntered() end
function PANEL:OnCursorExited() self:GetParent():OnCursorExited() end
function PANEL:SelectPanel( pnl ) self:GetParent():SelectPanel( pnl ) end
function PANEL:FindBestActive() self:GetParent():FindBestActive() end
function PANEL:AddPanel( pnl, tblConVars ) self:GetParent():AddPanel( pnl, tblConVars ) end
function PANEL:OnActivePanelChanged() self:GetParent():OnActivePanelChanged() end
function PANEL.DropAction( Slot, RcvSlot ) self:GetParent().DropAction( Slot, RcvSlot ) end
function PANEL:OnMousePressed( mousecode ) self:GetParent():OnMousePressed( mousecode ) end
function PANEL:OnMouseReleased( mousecode ) self:GetParent():OnMouseReleased( mousecode ) end
function Derma_DrawBackgroundBlur() return false end

derma.DefineControl( "PSpawnIcon", "_ProxSpawnIcon", PANEL, "SpawnIcon" )



local PANEL = {}

AccessorFunc( PANEL, "m_pPropertySheet",	"PropertySheet" )
AccessorFunc( PANEL, "m_pPanel",			"Panel" )

Derma_Hook( PANEL, "Paint", "Paint", "Tab" )

function PANEL:Init()

	self:SetMouseInputEnabled( true )
	self:SetContentAlignment( 7 )
	self:SetTextInset( 0, 0 )

end

function PANEL:Setup( label, pPropertySheet, pPanel, strMaterial )

	self:SetText( "  " .. label )
	self:SetPropertySheet( pPropertySheet )
	self:SetPanel( pPanel )

	if ( strMaterial ) then

		self.Image = vgui.Create( "DImage", self )
		self.Image:SetImage( strMaterial )
		self.Image:SizeToContents()
		self:InvalidateLayout()

	end

end

function PANEL:IsActive()
	return self:GetPropertySheet():GetActiveTab() == self
end

function PANEL:DoClick()

	self:GetPropertySheet():SetActiveTab( self )

end

function PANEL:PerformLayout()

	self:ApplySchemeSettings()

	if ( !self.Image ) then return end

	self.Image:SetPos( 10, 3 )

	if ( !self:IsActive() ) then
		self.Image:SetImageColor( Color( 255, 255, 255, 155 ) )
	else
		self.Image:SetImageColor( Color( 255, 255, 255, 255 ) )
	end

end

function PANEL:UpdateColours( skin )

	if ( self:IsActive() ) then

		if ( self:GetDisabled() )	then return self:SetTextStyleColor( skin.Colours.Tab.Active.Disabled ) end
		if ( self:IsDown() )		then return self:SetTextStyleColor( skin.Colours.Tab.Active.Down ) end
		if ( self.Hovered )			then return self:SetTextStyleColor( skin.Colours.Tab.Active.Hover ) end

		return self:SetTextStyleColor( skin.Colours.Tab.Active.Normal )

	end

	if ( self:GetDisabled() )	then return self:SetTextStyleColor( skin.Colours.Tab.Inactive.Disabled ) end
	if ( self:IsDown() )		then return self:SetTextStyleColor( skin.Colours.Tab.Inactive.Down ) end
	if ( self.Hovered )			then return self:SetTextStyleColor( skin.Colours.Tab.Inactive.Hover ) end

	return self:SetTextStyleColor( skin.Colours.Tab.Inactive.Normal )

end

function PANEL:GetTabHeight()
	return 28
end

function PANEL:ApplySchemeSettings()

	local ExtraInset = 10

	if ( self.Image ) then
		ExtraInset = ExtraInset + self.Image:GetWide()
	end

	self:SetTextInset( ExtraInset, 10 )
	local w, h = self:GetContentSize()
	h = self:GetTabHeight()

	self:SetSize( w + 10, h )

	DLabel.ApplySchemeSettings( self )

end

derma.DefineControl( "PTab", "_ProxPTab", PANEL, "DTab" )

local PANEL = {}

function PANEL:AddSheet( label, panel, material, NoStretchX, NoStretchY, Tooltip )

	if ( !IsValid( panel ) ) then return end

	local Sheet = {}

	Sheet.Name = label

	Sheet.Tab = vgui.Create( "PTab", self )
	Sheet.Tab:Setup( label, self, panel, material )

	Sheet.Panel = panel
	Sheet.Panel.NoStretchX = NoStretchX
	Sheet.Panel.NoStretchY = NoStretchY
	Sheet.Panel:SetPos( self:GetPadding() - 4, 20 + self:GetPadding() )
	Sheet.Panel:SetVisible( false )

	panel:SetParent( self )

	table.insert( self.Items, Sheet )

	if ( !self:GetActiveTab() ) then
		self:SetActiveTab( Sheet.Tab )
		Sheet.Panel:SetVisible( true )
	end

	self.tabScroller:AddPanel( Sheet.Tab )

	return Sheet

end


derma.DefineControl( "PPropertySheet", "_ProxPropertySheet", PANEL, "DPropertySheet" )





















--Accessory shit
--Created by RedMist and edited/fixed by Marcus cause he's cool like dat

if CLIENT then
	Accessories = { 
		["horsehead"] = { type = "Model", model = "models/horsie/horsiemask.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(3.4, 3.599, 0), angle = Angle(-82.987, 104.026, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["duck_tube"] = { type = "Model", model = "models/captainbigbutt/skeyler/accessories/duck_tube.mdl", bone = "ValveBiped.Bip01_Spine", rel = "", pos = Vector(-2.597, -2.597, 0), angle = Angle(0, 100, 90), size = Vector(1.799, 1.799, 1.799), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["star_band"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/starband.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(3.635, 0, 0), angle = Angle(180, 90, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["deadmau5_2"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(255, 93, 0, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5_red"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5_white"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5_purple"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(160, 32, 240, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5_blue"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(0, 0, 255, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5_green"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(0, 255, 0, 255), surpresslightning = false, material = "", skin = 6, bodygroup = {} },
		["deadmau5"] = { type = "Model", model = "models/captainbigbutt/skeyler/hats/deadmau5.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.4, 0, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}

	Accessories["panda_mask"] = { type = "Model", model = "models/snowzgmod/payday2/masks/maskjeanclaude.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(2.596, 2.596, 0), angle = Angle(180, 90, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	Accessories["cig_unlit"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(0.899, 0, 0), angle = Angle(0, 0, 90), size = Vector(0.135, 0.135, 0.081), color = Color(255, 67, 0, 255), surpresslightning = true, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }
	Accessories["cig_cherry"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_Head1", rel = "", pos = Vector(0.899, 0, 0), angle = Angle(0, 0, 90), size = Vector(0.15, 0.15, 0.079), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/debug/debugwhite", skin = 0, bodygroup = {} }

	function GetBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			pos, ang = GetBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBoneMatrix(bone)
			if (m) then
				pos, ang = m:GetTranslation(), m:GetAngles()
			end
		
		end
		
		return pos, ang
	end
	
	function GetRagBoneOrientation( basetab, tab, ent, bone_override )
		
		local bone, pos, ang
		if (tab.rel and tab.rel != "") then
			
			local v = basetab[tab.rel]
			
			if (!v) then return end
			
			pos, ang = GetRagBoneOrientation( basetab, v, ent )
			
			if (!pos) then return end
			
			pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
				
		else
		
			bone = ent:LookupBone(bone_override or tab.bone)

			if (!bone) then return end
			
			pos, ang = Vector(0,0,0), Angle(0,0,0)
			local m = ent:GetBonePosition(bone)
			if (m) then
				pos, ang = m, m:Angle()
			end
		
		end
		
		return pos, ang
	end
	
	function CreateModels( v, ply )

		if (!v) then return end

		// Create the clientside models here because Garry says we cant do it in the render hook
			if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
					string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
				
				v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
				if (IsValid(v.modelEnt)) then
					v.modelEnt:SetPos(ply:GetPos())
					v.modelEnt:SetAngles(ply:GetAngles())
					v.modelEnt:SetParent(ply)
					v.modelEnt:SetNoDraw(true)
					v.createdModel = v.model

					print( "CREATEDMODELS ENTPOS: " .. tostring( ply:GetPos() ) )
				else
					v.modelEnt = nil
				end
				
			elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
				and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
				
				local name = v.sprite.."-"
				local params = { ["$basetexture"] = v.sprite }
				// make sure we create a unique name based on the selected options
				local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
				for i, j in pairs( tocheck ) do
					if (v[j]) then
						params["$"..j] = 1
						name = name.."1"
					else
						name = name.."0"
					end
				end

				v.createdSprite = v.sprite
				v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
				
			end
			return v.modelEnt
		
	end
end


-- TEXT LIB

local function m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)

    if (xalign == TEXT_ALIGN_CENTER) then
        x = x - (textw / 2)
    elseif (xalign == TEXT_ALIGN_RIGHT) then
        x = x - textw
    end

    if (yalign == TEXT_ALIGN_BOTTOM) then
        y = y - texth
    end

    return x, y
end

function DrawShadowedText(shadow, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    draw.SimpleText(text, font, x + shadow, y + shadow, Color(0, 0, 0, color.a or 255), xalign, yalign)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function GlowColor(col1, col2, mod)
    local newr = col1.r + ((col2.r - col1.r) * (mod))
    local newg = col1.g + ((col2.g - col1.g) * (mod))
    local newb = col1.b + ((col2.b - col1.b) * (mod))

    return Color(newr, newg, newb)
end

function DrawEnchantedText(speed, text, font, x, y, color, glow_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local glow_color = glow_color or Color(127, 0, 255)
    local texte = string.Explode("", text)
    local x, y = m_AlignText(text, font, x, y, xalign, yalign)
    surface.SetFont(font)
    local chars_x = 0

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char)
        local color_glowing = GlowColor(glow_color, color, math.abs(math.sin((RealTime() - (i * 0.08)) * speed)))
        draw.SimpleText(char, font, x + chars_x, y, color_glowing, xalign, yalign)
        chars_x = chars_x + charw
    end
end

function DrawFadingText(speed, text, font, x, y, color, fading_color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local color_fade = GlowColor(color, fading_color, math.abs(math.sin((RealTime() - 0.08) * speed)))
    draw.SimpleText(text, font, x, y, color_fade, xalign, yalign)
end

local col1 = Color(0, 0, 0)
local col2 = Color(255, 255, 255)
local next_col = 0

function DrawRainbowText(speed, text, font, x, y, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    next_col = next_col + 1 / (100 / speed)

    if (next_col >= 1) then
        next_col = 0
        col1 = col2
        col2 = ColorRand()
    end

    draw.SimpleText(text, font, x, y, GlowColor(col1, col2, next_col), xalign, yalign)
end

function DrawGlowingText(static, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local initial_a = 20
    local a_by_i = 5
    local alpha_glow = math.abs(math.sin((RealTime() - 0.1) * 2))

    if (static) then
        alpha_glow = 1
    end

    for i = 1, 2 do
        draw.SimpleTextOutlined(text, font, x, y, color, xalign, yalign, i, Color(color.r, color.g, color.b, (initial_a - (i * a_by_i)) * alpha_glow))
    end

    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function DrawBouncingText(style, intesity, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local texte = string.Explode("", text)
    surface.SetFont(font)
    local chars_x = 0
    local x, y = m_AlignText(text, font, x, y, xalign, yalign)

    for i = 1, #texte do
        local char = texte[i]
        local charw, charh = surface.GetTextSize(char)
        local y_pos = 1
        local mod = math.sin((RealTime() - (i * 0.1)) * (2 * intesity))

        if (style == 1) then
            y_pos = y_pos - math.abs(mod)
        elseif (style == 2) then
            y_pos = y_pos + math.abs(mod)
        else
            y_pos = y_pos - mod
        end

        draw.SimpleText(char, font, x + chars_x, y - (5 * y_pos), color, xalign, yalign)
        chars_x = chars_x + charw
    end
end

local next_electric_effect = CurTime() + 0
local electric_effect_a = 0

function DrawElectricText(intensity, text, font, x, y, color, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local charw, charh = surface.GetTextSize(text)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)

    if (electric_effect_a > 0) then
        electric_effect_a = electric_effect_a - (1000 * FrameTime())
    end

    surface.SetDrawColor(102, 255, 255, electric_effect_a)

    for i = 1, math.random(5) do
        line_x = math.random(charw)
        line_y = math.random(charh)
        line_x2 = math.random(charw)
        line_y2 = math.random(charh)
        surface.DrawLine(x + line_x, y + line_y, x + line_x2, y + line_y2)
    end

    local effect_min = 0.5 + (1 - intensity)
    local effect_max = 1.5 + (1 - intensity)

    if (next_electric_effect <= CurTime()) then
        next_electric_effect = CurTime() + math.Rand(effect_min, effect_max)
        electric_effect_a = 255
    end
end

function DrawFireText(intensity, text, font, x, y, color, xalign, yalign, glow, shadow)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    surface.SetFont(font)
    local charw, charh = surface.GetTextSize(text)
    local fire_height = charh * intensity

    for i = 1, charw do
        local line_y = math.random(fire_height, charh)
        local line_x = math.random(-4, 4)
        local line_col = math.random(255)
        surface.SetDrawColor(255, line_col, 0, 150)
        surface.DrawLine(x - 1 + i, y + charh, x - 1 + i + line_x, y + line_y)
    end

    if (glow) then
        DrawGlowingText(true, text, font, x, y, color, xalign, yalign)
    end

    if (shadow) then
        draw.SimpleText(text, font, x + 1, y + 1, Color(0, 0, 0), xalign, yalign)
    end

    draw.SimpleText(text, font, x, y, color, xalign, yalign)
end

function DrawSnowingText(intensity, text, font, x, y, color, color2, xalign, yalign)
    local xalign = xalign or TEXT_ALIGN_LEFT
    local yalign = yalign or TEXT_ALIGN_TOP
    local color2 = color2 or Color(255, 255, 255)
    draw.SimpleText(text, font, x, y, color, xalign, yalign)
    surface.SetFont(font)
    local textw, texth = surface.GetTextSize(text)
    surface.SetDrawColor(color2.r, color2.g, color2.b, 255)

    for i = 1, intensity do
        local line_y = math.random(0, texth)
        local line_x = math.random(0, textw)
        surface.DrawLine(x + line_x, y + line_y, x + line_x, y + line_y + 1)
    end
end