CLASS_CITIZEN = 1

team.SetUp( CLASS_CITIZEN, 'Citizen', Color( 0, 255, 0, 255 ) )

_GM.Weapons = {}
_GM.Weapons[ CLASS_CITIZEN ] = {
	"weapon_fists",
	"weapon_physcannon",
	--"rp_hands",
}

--TO SHARED (EVENTUALLY)

VEHICLES = {}

function RegisterVehicle( _Data )
	VEHICLES[_Data.ID] = _Data

	local _a = list.Get( "Vehicles" )[ _Data.ID ]
	local _script = _a.KeyValues.vehiclescript

	if file.Exists( _script, "GAME" ) then
		local _Data2 = util.KeyValuesToTable( file.Read( _script, "GAME" ) )
		VEHICLES[_Data.ID].MaxRPM = _Data2.engine.maxrpm
		VEHICLES[_Data.ID].MaxSpeed = _Data2.engine.maxspeed
		VEHICLES[_Data.ID].ReverseSpeed = _Data2.engine.maxreversespeed
		VEHICLES[_Data.ID].Gear = _Data2.engine.gear
		VEHICLES[_Data.ID].AutoBrakeFactor = _Data2.engine.autobrakespeedfactor
	end

	VEHICLES[_Data.ID].Model = _a.Model

	print( "REGISTERED: " .. tostring( _Data.ID ) )
end

VEHICLE = {}
VEHICLE.ID = "vwgolfgti14tdm"
VEHICLE.Manufacture = "Volkswagen"
VEHICLE.Name = "Volkswagen Golf"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "tesmodelstdm"
VEHICLE.Manufacture = "Acura"
VEHICLE.Name = "2014 Acura NSX"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )


VEHICLE = {}
VEHICLE.ID = "vwgolfgti14tdm"
VEHICLE.Manufacture = "Volkswagen"
VEHICLE.Name = "Volkswagen Golf GTI"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

--local _a = string.ToTable( file.Read( "scripts/vehicles/tdmcars/teslamodels.txt", "GAME" ) )
--PrintTable( _a )
