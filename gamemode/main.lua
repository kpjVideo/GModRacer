_GM = GM or GAMEMODE

require("tmysql4")

_GM.MYSQL = {}
_GM.MYSQL.Host = "localhost"
_GM.MYSQL.Port = 3306
_GM.MYSQL.User = "root"
_GM.MYSQL.Pass = ""
_GM.MYSQL.DB = "_racing"


if CLIENT_MULTI_STATEMENTS then
	_GM.ErrorHandler:DebugPrint( 1, "TMYSQL4 MODULE LOADED SUCCESSFULLY!", Color( 0, 255, 0 ) )
else
	_GM.ErrorHandler:DebugPrint( 1, "TMYSQL4 DID NOT LOAD PROPERLY! IS THE MODULE INSTALLED?", Color( 255, 0, 0 ) )
	return
end

function _GM.MYSQL:Connect()
	DB, ERR = tmysql.Create( _GM.MYSQL.Host, _GM.MYSQL.User, _GM.MYSQL.Pass, _GM.MYSQL.DB, _GM.MYSQL.Port )
	
	_cur_status, _cur_err = DB:Connect()
	
	if _cur_err or ERR then
		_GM.ErrorHandler:DebugPrint( 1, _cur_err or ERR, Color( 255, 0, 0 ) )
	end
 
	if _cur_status then
		_GM.ErrorHandler:DebugPrint( 1, "Gamemode Database successfully connected: " .. tostring( _GM.MYSQL.Host ), Color( 0, 255, 0 ) )
	else
		_GM.ErrorHandler:DebugPrint( 1, "Gamemode Database failed to connect to MySQL.", Color( 255, 0, 0 ) )
	end
end

_GM.MYSQL:Connect()

function _GM.MYSQL:Disconnect()
	DB:Disconnect()
	_GM.ErrorHandler:DebugPrint( 1, "Database has been disconnected", Color( 255, 255, 0 ) )
	-- ¯\_(ツ)_/¯
end
 
function _GM.MYSQL:Query( _String, _Callback )

	if DB then
		DB:Query( _String, _Callback )
	else
		_GM.ErrorHandler:DebugPrint( 1, "No database detected. wtf?", Color( 255, 0, 0 ) )
	end 
end

function _GM.MYSQL:DebugQuery( _String, _Callback )

	local _NiceString = string.format( _String )
	local _NiceString = ''

	if DB then
		DB:Query( _String, onCompleted )
	else
		_GM.ErrorHandler:DebugPrint( 1, "No database detected. wtf?", Color( 255, 0, 0 ) )
	end

	function onCompleted( _Results )
		
		if _Callback then
			_Callback( _Results )
		end

		if _Results[1].status then
			_GM.ErrorHandler:DebugPrint( 1, "Query " .. _NiceString .. " ran successfully", Color( 255, 255, 0 ) )
		else
			_GM.ErrorHandler:DebugPrint( 1, "Query " .. _NiceString .. " failed!\n" .. _Results[1].error, Color( 255, 0, 0 ) )
			return
		end

		PrintTable( _Results[1].data )
	end
end

function _GM.MYSQL:GetActiveConnections()
	return tmysql.GetTable()
end

function _GM.MYSQL:Escape( _String )
	if not DB then return end
	
	return DB:Escape( _String )
end

function _GM.MYSQL:CreateTable( _Name, _Arguments  )
	--let's make sure we don't accidently write over a pre-existing table... ouch.
	_GM.MYSQL:DebugQuery(" CREATE TABLE IF NOT EXISTS `" .. _GM.MySQL:Escape( _Name ) .. "` ( " .. _GM.MySQL:Escape( _Arguments ) .. " ) COLLATE='latin1_swedish_ci' ENGINE=InnoDB;", function( _Returned ) end)
end

function _GM.MYSQL:CreateRPTables()
	_GM.MYSQL:Query( "SELECT COUNT(*) FROM _players", function( _return )
		if not _return[1].data or table.Count( _return[1].data ) == 0 then
			_GM.ErrorHandler:DebugPrint( 1, "Creating RP tables (They don't seem to exist yet)", Color( 255, 255, 0 ) )

			_GM.MYSQL:CreateTable( '_players', [[
				`_steamid` CHAR(32) NOT NULL, 
				`_races_won` INT NOT NULL,
				`_races_lost` INT NOT NULL,
				`_cash` BIGINT NOT NULL,
				`_model` TEXT(32) NOT NULL,
				`_xp` SMALLINT NOT NULL, 
				`_rank` TEXT(32) NOT NULL, 
				`_color` VARCHAR(32) NOT NULL DEFAULT '1;1;1',
				`_physgun` VARCHAR(32) NOT NULL DEFAULT '1;1;1',
				UNIQUE INDEX `steamid` (`_steamid`)
			]])

			_GM.ErrorHandler:DebugPrint( 1, "Query finished! -- Player RP tables created", Color( 255, 0, 0 ) )
		end
	end)
end

function _GM.MYSQL:CreateDataTables( )
	_GM.MYSQL:Query( "SELECT COUNT(*) FROM _data", function( _return )

		if not _return[1].data or table.Count( _return[1].data ) == 0 then
			_GM.ErrorHandler:DebugPrint( 1, "Creating data tables (They don't seem to exist yet)", Color( 255, 255, 0 ) )

			_GM.MYSQL:CreateTable( '_data', [[
				`_steamid` TEXT NOT NULL, 
				`_best_time` DOUBLE NOT NULL,
				`_map` TEXT NOT NULL,
				UNIQUE KEY `Index 1` (`_steam_id`(100),`_map`(100))
			]])

			_GM.ErrorHandler:DebugPrint( 1, "Query finished! -- Player data tables created", Color( 255, 0, 0 ) )
		end
	end)
end

_GM.MYSQL:CreateRPTables( )
_GM.MYSQL:CreateDataTables( )