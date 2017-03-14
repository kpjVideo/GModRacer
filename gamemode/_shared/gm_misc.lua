_GM.Miscellaneous = {}
_GM.Miscellaneous.BaseWidth = 1920
_GM.Miscellaneous.BaseHeight = 1080

function _GM.Miscellaneous:scaleW( SW )
	return ScrW() * ( ( SW or 0 ) / _GM.Miscellaneous.BaseWidth )
end

function _GM.Miscellaneous:scaleH( SH )
	return ScrH() * ( ( SH or 0 ) / _GM.Miscellaneous.BaseHeight )
end


local bad_hooks = {
	{"Think", "SGM_Speed_Think_429"},
	{"Think", "SGM_Speed_Think"},
	{"Think", "SGM_Power_Think"},
	{"Think", "SGM_Speed_Think_MP412"},
	{"PlayerTick", "TickWidgets"},
	{"Tick", "Resizer.Tick"},
	{"PlayerCanHearPlayersVoice", "PlayerCanHearPlayersVoice_plugins/ass_mute.lua"},
	{"Think", "TDMPonFiero_hlights"},
	{"Think", "TDMBoost_242Turbo"},
	{"Think", "TaurusSyncChanges"},
	{"Think", "TDMBoost_SilviaS15"},
	{"Think", "TDMAirbrake_MerSLR"},
	{"Think", "TDMAirbrake_P1"},
	{"Think", "TDMAirbrake_VeyronSS"},
	{"Think", "TDMBoost_CAYENNE09"},
	{"Think", "TDMBoost_MR2GT"},
	{"Think", "TDMWheelBlur"},
	{"Think", "TDMBoost_GTR"},
	{"Think", "TDMP1_Spoiler"},
	{"Think", "TDMBoost_Shelby1000"},
	{"Think", "TDMBoost_EclipseGSX"},
	{"Think", "TDMBoost_VeyronSS"},
	{"Think", "TDMBoost_850R"},
}

--[[---------------------------------------------------------
   Name: _GM.Miscellaneous:RemoveBadHooks( _Table )
   Desc: This is used to remove various laggy think hooks used in vehicle packs
-----------------------------------------------------------]]

function _GM.Miscellaneous:RemoveBadHooks( _Table )
	if not _Table or not istable( _Table ) then
		return
	end

	for k, v in pairs( _Table ) do
		hook.Remove( v[1], v[2] )
		_GM.ErrorHandler:DebugPrint( 1, 'Successfully removed hook: ' .. v[2] .. ' (' .. v[1] .. ')', Color( 0, 0, 255 ) )
	end
end

_GM.Miscellaneous:RemoveBadHooks( bad_hooks )

function scaleX( SW )
	return ScrW() * ( ( SW or 0 ) / _GM.Miscellaneous.BaseWidth )
end

function scaleH( SH )
	return ScrH() * ( ( SH or 0 ) / _GM.Miscellaneous.BaseHeight )
end

hook.Add( 'OnReloaded', '_Reload', function()
	for _key, _value in pairs( player.GetAll() ) do
		_value:Notify( 'Gamemode Reloaded' )
	end
end)

function NestedHasValue(tab, str, index)
	for k, v in pairs(tab) do
		if v[index] ==  str then
			return true
		end
	end

	return false
end