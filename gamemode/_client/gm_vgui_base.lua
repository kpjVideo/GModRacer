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

local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

function PANEL:Init()

	self.Offset = 0
	self.Scroll = 0
	self.CanvasSize = 1
	self.BarSize = 1

	self.btnUp = vgui.Create( "DButton", self )
	self.btnUp:SetText( "" )
	self.btnUp.DoClick = function( self ) self:GetParent():AddScroll( -1 ) end
	self.btnUp.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonUp", panel, w, h ) end

	self.btnDown = vgui.Create( "DButton", self )
	self.btnDown:SetText( "" )
	self.btnDown.DoClick = function( self ) self:GetParent():AddScroll( 1 ) end
	self.btnDown.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonDown", panel, w, h ) end

	self.btnGrip = vgui.Create( "DScrollBarGrip", self )

	self:SetSize( 15, 15 )
	self:SetHideButtons( false )

end

function PANEL:SetEnabled( b )

	if ( !b ) then

		self.Offset = 0
		self:SetScroll( 0 )
		self.HasChanged = true

	end

	self:SetMouseInputEnabled( b )
	self:SetVisible( b )

	-- We're probably changing the width of something in our parent
	-- by appearing or hiding, so tell them to re-do their layout.
	if ( self.Enabled != b ) then

		self:GetParent():InvalidateLayout()

		if ( self:GetParent().OnScrollbarAppear ) then
			self:GetParent():OnScrollbarAppear()
		end

	end

	self.Enabled = b

end

function PANEL:Value()

	return self.Pos

end

function PANEL:BarScale()

	if ( self.BarSize == 0 ) then return 1 end

	return self.BarSize / ( self.CanvasSize + self.BarSize )

end

function PANEL:SetUp( _barsize_, _canvassize_ )

	self.BarSize = _barsize_
	self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

	self:SetEnabled( _canvassize_ > _barsize_ )

	self:InvalidateLayout()

end

function PANEL:OnMouseWheeled( dlta )

	if ( !self:IsVisible() ) then return false end

	-- We return true if the scrollbar changed.
	-- If it didn't, we feed the mousehweeling to the parent panel

	return self:AddScroll( dlta * -2 )

end

function PANEL:AddScroll( dlta )

	local OldScroll = self:GetScroll()

	dlta = dlta * 25
	self:SetScroll( self:GetScroll() + dlta )

	return OldScroll != self:GetScroll()

end

function PANEL:SetScroll( scrll )

	if ( !self.Enabled ) then self.Scroll = 0 return end

	self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )

	self:InvalidateLayout()

	-- If our parent has a OnVScroll function use that, if
	-- not then invalidate layout (which can be pretty slow)

	local func = self:GetParent().OnVScroll
	if ( func ) then

		func( self:GetParent(), self:GetOffset() )

	else

		self:GetParent():InvalidateLayout()

	end

end

function PANEL:AnimateTo( scrll, length, delay, ease )

	local anim = self:NewAnimation( length, delay, ease )
	anim.StartPos = self.Scroll
	anim.TargetPos = scrll
	anim.Think = function( anim, pnl, fraction )

		pnl:SetScroll( Lerp( fraction, anim.StartPos, anim.TargetPos ) )

	end

end

function PANEL:GetScroll()

	if ( !self.Enabled ) then self.Scroll = 0 end
	return self.Scroll

end

function PANEL:GetOffset()

	if ( !self.Enabled ) then return 0 end
	return self.Scroll * -1

end

function PANEL:Think()
end

function PANEL:Paint( w, h )

	derma.SkinHook( "Paint", "VScrollBar", self, w, h )
	return true

end

function PANEL:OnMousePressed()

	local x, y = self:CursorPos()

	local PageSize = self.BarSize

	if ( y > self.btnGrip.y ) then
		self:SetScroll( self:GetScroll() + PageSize )
	else
		self:SetScroll( self:GetScroll() - PageSize )
	end

end

function PANEL:OnMouseReleased()

	self.Dragging = false
	self.DraggingCanvas = nil
	self:MouseCapture( false )

	self.btnGrip.Depressed = false

end

function PANEL:OnCursorMoved( x, y )

	if ( !self.Enabled ) then return end
	if ( !self.Dragging ) then return end

	local x, y = self:ScreenToLocal( 0, gui.MouseY() )

	-- Uck.
	y = y - self.btnUp:GetTall()
	y = y - self.HoldPos

	local BtnHeight = self:GetWide()
	if ( self:GetHideButtons() ) then BtnHeight = 0 end

	local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()

	y = y / TrackSize

	self:SetScroll( y * self.CanvasSize )

end

function PANEL:Grip()

	if ( !self.Enabled ) then return end
	if ( self.BarSize == 0 ) then return end

	self:MouseCapture( true )
	self.Dragging = true

	local x, y = self.btnGrip:ScreenToLocal( 0, gui.MouseY() )
	self.HoldPos = y

	self.btnGrip.Depressed = true

end

function PANEL:PerformLayout()

	local Wide = self:GetWide()
	local BtnHeight = Wide
	if ( self:GetHideButtons() ) then BtnHeight = 0 end
	local Scroll = self:GetScroll() / self.CanvasSize
	local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( BtnHeight * 2 ) ), 10 )
	local Track = self:GetTall() - ( BtnHeight * 2 ) - BarSize
	Track = Track + 1

	Scroll = Scroll * Track

	self.btnGrip:SetPos( 0, BtnHeight + Scroll )
	self.btnGrip:SetSize( Wide, BarSize )

	if ( BtnHeight > 0 ) then
		self.btnUp:SetPos( 0, 0, Wide, Wide )
		self.btnUp:SetSize( Wide, BtnHeight )

		self.btnDown:SetPos( 0, self:GetTall() - BtnHeight )
		self.btnDown:SetSize( Wide, BtnHeight )
		
		self.btnUp:SetVisible( true )
		self.btnDown:SetVisible( true )
	else
		self.btnUp:SetVisible( false )
		self.btnDown:SetVisible( false )
		self.btnDown:SetSize( Wide, BtnHeight )
		self.btnUp:SetSize( Wide, BtnHeight )
	end

end

derma.DefineControl( "DVScrollBar_Anim", "A Scrollbar", PANEL, "Panel" )

local PANEL = {}

AccessorFunc( PANEL, "Padding",         "Padding" )
AccessorFunc( PANEL, "pnlCanvas",         "Canvas" )

function PANEL:Init()

        self.pnlCanvas         = vgui.Create( "Panel", self )
        self.pnlCanvas.OnMousePressed = function( self, code ) self:GetParent():OnMousePressed( code ) end
        self.pnlCanvas:SetMouseInputEnabled( true )
        self.pnlCanvas.PerformLayout = function( pnl )
        
                self:PerformLayout()
                self:InvalidateParent()
        
        end
        
        self.VBar = vgui.Create( "DVScrollBar_Anim", self )
		self.VBar:SetVisible( false )
		self.VBar:SetPos( -100, -100 )
        self:SetPadding( 0 )
        self:SetMouseInputEnabled( true )
        
        self:SetPaintBackgroundEnabled( false )
        self:SetPaintBorderEnabled( false )
        self:SetPaintBackground( false )

end

function PANEL:AddItem( pnl )

        pnl:SetParent( self:GetCanvas() )
        
end

function PANEL:OnChildAdded( child )

        self:AddItem( child )

end

function PANEL:SizeToContents()

        self:SetSize( self.pnlCanvas:GetSize() )
        
end

function PANEL:GetVBar()

        return self.VBar
        
end

function PANEL:GetCanvas()

        return self.pnlCanvas

end

function PANEL:InnerWidth()

        return self:GetCanvas():GetWide()

end

function PANEL:Rebuild()

        self:GetCanvas():SizeToChildren( false, true )
                
        if ( self.m_bNoSizing && self:GetCanvas():GetTall() < self:GetTall() ) then

                self:GetCanvas():SetPos( 0, (self:GetTall()-self:GetCanvas():GetTall()) * 0.5 )
        
        end
        
end

function PANEL:OnMouseWheeled( dlta )

        return self.VBar:OnMouseWheeled( dlta )
        
end

local l = 0
local iOffsett = 0

function PANEL:Think( )
	l = Lerp( FrameTime() * 2, l, iOffsett )

	self.pnlCanvas:SetPos( 0, l )
end

function PANEL:OnVScroll( iOffset )
	iOffsett = iOffset
end

function PANEL:ScrollToChild( panel )

        self:PerformLayout()
        
        local x, y = self.pnlCanvas:GetChildPosition( panel )
        local w, h = panel:GetSize()
        
        y = y + h * 0.5;
        y = y - self:GetTall() * 0.5;

        self.VBar:AnimateTo( y, 0.5, 0, 0.5 );
        
end

function PANEL:PerformLayout()

        local Wide = self:GetWide()
        local YPos = 0
        
        self:Rebuild()
        
        self.VBar:SetUp( self:GetTall(), self.pnlCanvas:GetTall() )
        YPos = self.VBar:GetOffset()
                
       // if ( self.VBar.Enabled ) then Wide = Wide - self.VBar:GetWide() end

        self.pnlCanvas:SetPos( 0, YPos )
        self.pnlCanvas:SetWide( Wide )
        
        self:Rebuild()


end

function PANEL:Clear()

        return self.pnlCanvas:Clear()

end

derma.DefineControl( "DScrollPanel_nobar", "", PANEL, "DPanel" )


local PANEL = {}

AccessorFunc( PANEL, "m_iOverlap",			"Overlap" )
AccessorFunc( PANEL, "m_bShowDropTargets",	"ShowDropTargets", FORCE_BOOL )

function PANEL:Init()

	self.Panels = {}
	self.OffsetX = 0
	self.FrameTime = 0

	self.pnlCanvas = vgui.Create( "DDragBase", self )
	self.pnlCanvas:SetDropPos( "6" )
	self.pnlCanvas:SetUseLiveDrag( false )
	self.pnlCanvas.OnModified = function() self:OnDragModified() end

	self.pnlCanvas.UpdateDropTarget = function( Canvas, drop, pnl )
		if ( !self:GetShowDropTargets() ) then return end
		DDragBase.UpdateDropTarget( Canvas, drop, pnl )
	end

	self.pnlCanvas.OnChildAdded = function( Canvas, child )

		local dn = Canvas:GetDnD()
		if ( dn ) then

			child:Droppable( dn )
			child.OnDrop = function()

				local x, y = Canvas:LocalCursorPos()
				local closest, id = self.pnlCanvas:GetClosestChild( x, Canvas:GetTall() / 2 ), 0

				for k, v in pairs( self.Panels ) do
					if ( v == closest ) then id = k break end
				end

				table.RemoveByValue( self.Panels, child )
				table.insert( self.Panels, id, child )

				self:InvalidateLayout()

				return child

			end
		end

	end

	self:SetOverlap( 0 )

	--self.btnLeft = vgui.Create( "DButton", self )
	--self.btnLeft:SetText( "" )
	--self.btnLeft.Paint = function( panel, w, h )
	--	derma.SkinHook( "Paint", "ButtonLeft", panel, w, h )
	--end

	--self.btnRight = vgui.Create( "DButton", self )
	--self.btnRight:SetText( "" )
	--self.btnRight.Paint = function( panel, w, h )
	--	derma.SkinHook( "Paint", "ButtonRight", panel, w, h )
	--end

end

function PANEL:OnDragModified()
	-- Override me
end

function PANEL:SetUseLiveDrag( bool )
	self.pnlCanvas:SetUseLiveDrag( bool )
end

function PANEL:MakeDroppable( name )
	self.pnlCanvas:MakeDroppable( name )
end

function PANEL:AddPanel( pnl )

	table.insert( self.Panels, pnl )

	pnl:SetParent( self.pnlCanvas )
	self:InvalidateLayout(true)

end

function PANEL:OnMouseWheeled( dlta )

	self.OffsetX = self.OffsetX + dlta * -( LocalPlayer( ).ScrollSpeed or 60 )
	self:InvalidateLayout( true )

	return true

end

function PANEL:Think()

	-- Hmm.. This needs to really just be done in one place
	-- and made available to everyone.
	local FrameRate = VGUIFrameTime() - self.FrameTime
	self.FrameTime = VGUIFrameTime()

	--if ( self.btnRight:IsDown() ) then
	--	self.OffsetX = self.OffsetX + (500 * FrameRate)
	--	self:InvalidateLayout( true )
	--end

	--if ( self.btnLeft:IsDown() ) then
	--	self.OffsetX = self.OffsetX - (500 * FrameRate)
	--	self:InvalidateLayout( true )
	--end

	if ( dragndrop.IsDragging() ) then

		local x, y = self:LocalCursorPos()

		if ( x < 30 ) then
			self.OffsetX = self.OffsetX - (350 * FrameRate)
		elseif ( x > self:GetWide() - 30 ) then
			self.OffsetX = self.OffsetX + (350 * FrameRate)
		end

		self:InvalidateLayout( true )

	end

end

function PANEL:PerformLayout()

	local w, h = self:GetSize()

	self.pnlCanvas:SetTall( h )

	local x = 0

	for k, v in pairs( self.Panels ) do

		if not v:IsValid() then continue end

		v:SetPos( x, 0 )
		v:SetTall( h )
		v:ApplySchemeSettings()

		x = x + v:GetWide() - self.m_iOverlap

	end

	self.pnlCanvas:SetWide( x + self.m_iOverlap )

	if ( w < self.pnlCanvas:GetWide() ) then
		self.OffsetX = math.Clamp( self.OffsetX, 0, self.pnlCanvas:GetWide() - self:GetWide() )
	else
		self.OffsetX = 0
	end

	self.pnlCanvas.x = self.OffsetX * -1
end

derma.DefineControl( "GM.Racer.DHorizontalScroller", "", PANEL, "Panel" )



local PANEL = {}

AccessorFunc( PANEL, "m_fAnimSpeed",	"AnimSpeed" )
AccessorFunc( PANEL, "Entity",			"Entity" )
AccessorFunc( PANEL, "vCamPos",			"CamPos" )
AccessorFunc( PANEL, "fFOV",			"FOV" )
AccessorFunc( PANEL, "vLookatPos",		"LookAt" )
AccessorFunc( PANEL, "aLookAngle",		"LookAng" )
AccessorFunc( PANEL, "colAmbientLight",	"AmbientLight" )
AccessorFunc( PANEL, "colColor",		"Color" )
AccessorFunc( PANEL, "bAnimated",		"Animated" )

function PANEL:Init()

	self.Entity = nil
	self.LastPaint = 0
	self.DirectionalLight = {}
	self.FarZ = 4096

	self:SetCamPos( Vector( 50, 50, 50 ) )
	self:SetLookAt( Vector( 0, 0, 40 ) )
	self:SetFOV( 70 )

	self:SetText( "" )
	self:SetAnimSpeed( 0.5 )
	self:SetAnimated( false )

	self:SetAmbientLight( Color( 50, 50, 50 ) )

	self:SetDirectionalLight( BOX_TOP, Color( 255, 255, 255 ) )
	self:SetDirectionalLight( BOX_FRONT, Color( 255, 255, 255 ) )

	self:SetColor( Color( 255, 255, 255, 255 ) )

end

function PANEL:SetDirectionalLight( iDirection, color )
	self.DirectionalLight[ iDirection ] = color
end

function PANEL:SetModel( strModelName )

	-- Note - there's no real need to delete the old
	-- entity, it will get garbage collected, but this is nicer.
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
		self.Entity = nil
	end

	-- Note: Not in menu dll
	if ( !ClientsideModel ) then return end

	self.Entity = ClientsideModel( strModelName, RENDER_GROUP_OPAQUE_ENTITY )
	if ( !IsValid( self.Entity ) ) then return end

	self.Entity:SetNoDraw( true )
	self.Entity:SetIK( false )

	-- Try to find a nice sequence to play
	local iSeq = self.Entity:LookupSequence( "walk_all" )
	if ( iSeq <= 0 ) then iSeq = self.Entity:LookupSequence( "WalkUnarmed_all" ) end
	if ( iSeq <= 0 ) then iSeq = self.Entity:LookupSequence( "walk_all_moderate" ) end

	if ( iSeq > 0 ) then self.Entity:ResetSequence( iSeq ) end

end

function PANEL:GetModel()

	if ( !IsValid( self.Entity ) ) then return end

	return self.Entity:GetModel()

end

function PANEL:DrawModel()

	local curparent = self
	local rightx = self:GetWide()
	local leftx = 0
	local topy = 0
	local bottomy = self:GetTall()
	local previous = curparent
	while( curparent:GetParent() != nil ) do
		curparent = curparent:GetParent()
		local x, y = previous:GetPos()
		topy = math.Max( y, topy + y )
		leftx = math.Max( x, leftx + x )
		bottomy = math.Min( y + previous:GetTall(), bottomy + y )
		rightx = math.Min( x + previous:GetWide(), rightx + x )
		previous = curparent
	end
	render.SetScissorRect( leftx, topy, rightx, bottomy, true )

	local ret = self:PreDrawModel( self.Entity )
	if ( ret != false ) then
		self.Entity:DrawModel()
		self:PostDrawModel( self.Entity )
	end

	render.SetScissorRect( 0, 0, 0, 0, false )

end

function PANEL:PreDrawModel( ent )
	return true
end

function PANEL:PostDrawModel( ent )

end

function PANEL:Paint( w, h )

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

end

function PANEL:RunAnimation()
	self.Entity:FrameAdvance( ( RealTime() - self.LastPaint ) * self.m_fAnimSpeed )
end

function PANEL:StartScene( name )

	if ( IsValid( self.Scene ) ) then
		self.Scene:Remove()
	end

	self.Scene = ClientsideScene( name, self.Entity )

end

function PANEL:LayoutEntity( Entity )

	--
	-- This function is to be overriden
	--

	if ( self.bAnimated ) then
		self:RunAnimation()
	end

	Entity:SetAngles( Angle( 0, RealTime() * 10 % 360, 0 ) )

end

function PANEL:OnMousePressed()

	local x, y = self:CursorPos()

	local PageSize = self.BarSize

	if ( y > self.btnGrip.y ) then
		self:SetScroll( self:GetScroll() + PageSize )
	else
		self:SetScroll( self:GetScroll() - PageSize )
	end

end

function PANEL:OnMouseReleased()

	self.Dragging = false
	self.DraggingCanvas = nil
	self:MouseCapture( false )

end

function PANEL:OnCursorMoved( x, y )

	if ( !self.Enabled ) then return end
	if ( !self.Dragging ) then return end

	local x, y = self:ScreenToLocal( 0, gui.MouseY() )

	-- Uck.
	y = y - self.btnUp:GetTall()
	y = y - self.HoldPos

	local BtnHeight = self:GetWide()
	if ( self:GetHideButtons() ) then BtnHeight = 0 end

	local TrackSize = self:GetTall() - BtnHeight * 2 --[[ - self.btnGrip:GetTall() ]]

	y = y / TrackSize

	self:SetScroll( y * self.CanvasSize )

end

function PANEL:OnRemove()
	if ( IsValid( self.Entity ) ) then
		self.Entity:Remove()
	end
end

function PANEL:GenerateExample( ClassName, PropertySheet, Width, Height )

	local ctrl = vgui.Create( ClassName )
	ctrl:SetSize( 300, 300 )
	ctrl:SetModel( "models/props_junk/PlasticCrate01a.mdl" )
	ctrl:GetEntity():SetSkin( 2 )

	PropertySheet:AddSheet( ClassName, ctrl, nil, true, true )

end

derma.DefineControl( "DModelPanel_CUSTOM", "A panel containing a model", PANEL, "DButton" )

local PANEL = {}

AccessorFunc( PANEL, "m_bChecked", "Checked", FORCE_BOOL )

Derma_Hook( PANEL, "Paint", "Paint", "CheckBox" )
Derma_Hook( PANEL, "ApplySchemeSettings", "Scheme", "CheckBox" )
Derma_Hook( PANEL, "PerformLayout", "Layout", "CheckBox" )

Derma_Install_Convar_Functions( PANEL )

function PANEL:Init()

	self:SetSize( 15, 15 )
	self:SetText( "" )

	self._col = Color( 205, 205, 205, 255 )
	self._b = 100
end

function PANEL:IsEditing()
	return self.Depressed
end

function PANEL:SetValue( val )

	if ( tonumber( val ) == 0 ) then val = 0 end // Tobool bugs out with "0.00"
	val = tobool( val )

	self:SetChecked( val )
	self.m_bValue = val

	self:OnChange( val )

	if ( val ) then val = "1" else val = "0" end
	self:ConVarChanged( val )

end

function PANEL:DoClick()

	self:Toggle()

end

function PANEL:Toggle()

	if ( self:GetChecked() == nil || !self:GetChecked() ) then
		self:SetValue( true )
	else
		self:SetValue( false )
	end

end

function PANEL:OnChange( bVal )

	-- For override

end

function PANEL:Think()

	self:ConVarStringThink()

end

local _A = Material( "proximity/checkmark.png", "smooth noclamp" )

function LerpColor(tr,tg,tb,from,to)
	tg = tg || tr
	tb = tb || tr
	return Color(Lerp(tr,from.r,to.r),Lerp(tg,from.g,to.g),Lerp(tb,from.b,to.b))
end

function PANEL:Paint( w, h )
	if self:GetChecked() && self._col && self._b then
		self._col = LerpColor(0.05, 0.05, 0.04, self._col, Color( 49, 153, 220, 255 ) )

		draw.RoundedBox( 4, 0, 0, w, h, self._col )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( _A )

		self._b = Lerp( FrameTime() * 15, self._b, 360 )

		surface.DrawTexturedRectRotated( w / 2, h / 2, w, h, self._b )

	else
		self._col = LerpColor(0.04, 0.04, 0.04, self._col, Color( 49, 71, 94, 255 ) )
		self._b = 100

		draw.RoundedBox( 4, 0, 0, w, h, Color( 49, 71, 94, 255 ) )
	end
end

derma.DefineControl( "GM.Racer.DCheckBox", "", PANEL, "DButton" )

function PANEL:MakeExample( )
	--fade color to blueish
	--fade in checkmark
	if a then a:Remove() a = nil end

	a = vgui.Create( "DFrame" )
	a:SetPos( ScrW() / 2 - 64, ScrH() / 2 - 64 )
	a:SetSize( 128, 128 )
	a:MakePopup()

	local b = vgui.Create( "DCheckBox", a )
	b:SetSize( 32, 32 )
	b:SetPos( a:GetWide() / 2 - b:GetWide() / 2, a:GetTall() / 2 - b:GetTall() / 2 )
end