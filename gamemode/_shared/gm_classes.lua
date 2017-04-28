CLASS_CITIZEN = 1

team.SetUp( CLASS_CITIZEN, 'Citizen', Color( 0, 255, 0, 255 ) )

_GM.Weapons = {}
_GM.Weapons[ CLASS_CITIZEN ] = {
	"weapon_fists",
	"weapon_physcannon",
	--"rp_hands",
}

--TO SHARED (EVENTUALLY)

function RegisterVehicle( _Data )

	if !VEHICLES then
		VEHICLES = {}
	end

	if VEHICLES[_Data.ID] then return end --we already exist, so fuck off

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

	if CLIENT then
		util.PrecacheModel( _a.Model ) --takes way too fucking long for the server...
	end

	print( "REGISTERED: " .. tostring( _Data.ID ) )
end

--[[
VEHICLE = {}
VEHICLE.ID = "vwgolfgti14tdm"
VEHICLE.Manufacture = "Volkswagen"
VEHICLE.Name = "Volkswagen Golf GTI"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )
]]--




VEHICLE = {}
VEHICLE.ID = "vwgolfgti14tdm"
VEHICLE.Manufacture = "Acura"
VEHICLE.Name = "2015 Acura NSX"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "tesmodelstdm"
VEHICLE.Manufacture = "Acura"
VEHICLE.Name = "2014 Acura NSX"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "metrohd_audi_a6"
VEHICLE.Manufacture = "Audi"
VEHICLE.Name = "A6"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "metrohd_vw_passat_variant"
VEHICLE.Manufacture = "Volkswagen"
VEHICLE.Name = "Passat R-Line"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "metrohd_rroyce_ghost"
VEHICLE.Manufacture = "Rolls-Royce"
VEHICLE.Name = "Ghost"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "metrohd_rr_phantom"
VEHICLE.Manufacture = "Rolls-Royce"
VEHICLE.Name = "Phantom"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = "metrohd_rr_phantom_2013"
VEHICLE.Manufacture = "Rolls-Royce"
VEHICLE.Name = "Phantom (2013)"
VEHICLE.Price = 0
RegisterVehicle( VEHICLE )

//CrSk Autos
VEHICLE = {}
VEHICLE.ID = 'crsk_rolls-royce_silverspiritmk3'
VEHICLE.Name = 'Silver Spirit Mk III 1993'
VEHICLE.Manufacture = 'Rolls-Royce'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 83
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 300
VEHICLE.Weight = 4034
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mer_w205'
VEHICLE.Name = 'C-Klasse W205 2014'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 130
VEHICLE.MaxRPM = 3500
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 310
VEHICLE.Weight = 4189
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_cls350'
VEHICLE.Name = 'CLS 350 C218 2012'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 108
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 518
VEHICLE.Weight = 4299
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_lambo_centenario'
VEHICLE.Name = 'Centenario LP770-4 2016'
VEHICLE.Manufacture = 'Lamborghini'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 212
VEHICLE.MaxRPM = 3300
VEHICLE.MaxReverseSpeed = 35
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 752
VEHICLE.Weight = 3527
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_bmw_7er_f02_2012'
VEHICLE.Name = '7er F02 2012'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 100
VEHICLE.MaxRPM = 7000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 550
VEHICLE.Weight = 3968
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_alfaromeo_alfasud'
VEHICLE.Name = 'Alfasud Sprint 1972'
VEHICLE.Manufacture = 'Alfa-Romeo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 130
VEHICLE.MaxRPM = 5400
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 6
VEHICLE.HorsePower = 300
VEHICLE.Weight = 4850
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_bmw_i8'
VEHICLE.Name = 'i8 2015'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 320
VEHICLE.Weight = 3329
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_w124_e500_1992'
VEHICLE.Name = 'W124 E500 1992'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 101
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 450
VEHICLE.Weight = 5071
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_peugeot_508_2011'
VEHICLE.Name = '508 GT 2011'
VEHICLE.Manufacture = 'Peugeot'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 110
VEHICLE.MaxRPM = 7000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 160
VEHICLE.Weight = 3086
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mitsubishi_galante39a'
VEHICLE.Name = 'Galant VR-4 E39A 1987'
VEHICLE.Manufacture = 'Mitsubishi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 79
VEHICLE.MaxRPM = 2800
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 263
VEHICLE.Weight = 3569
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_ford_crownvictoria_1987'
VEHICLE.Name = 'Crown Victoria LTD 1987'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 5050
VEHICLE.MaxReverseSpeed = 35
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 250
VEHICLE.Weight = 4037
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_volks_karmann_ghia'
VEHICLE.Name = 'Karmann Ghia'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 4600
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 266
VEHICLE.Weight = 2899
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_audi_s5_2017'
VEHICLE.Name = 'S5 2017'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 20
VEHICLE.MaxSpeed = 102
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 465
VEHICLE.Weight = 4365
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_g500_2008'
VEHICLE.Name = 'G-Klasse G500 2008'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 7
VEHICLE.HorsePower = 550
VEHICLE.Weight = 6614
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_g_wolf_kurz'
VEHICLE.Name = 'G Wolf Kurz'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 13
VEHICLE.Automatic = 1
VEHICLE.Gears = 1
VEHICLE.HorsePower = 900
VEHICLE.Weight = 13228
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_g500_short_2008'
VEHICLE.Name = 'G-Klasse G500 Short 2008'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 7
VEHICLE.HorsePower = 550
VEHICLE.Weight = 6614
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_alpina_b10'
VEHICLE.Name = 'B10 Bi-Turbo E34'
VEHICLE.Manufacture = 'Alpina'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 103
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 311
VEHICLE.Weight = 4026
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_saleen_s7_twinturbo'
VEHICLE.Name = 'S7 Twin Turbo 2005'
VEHICLE.Manufacture = 'Saleen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 126
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 962
VEHICLE.Weight = 3031
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mitsubishi_lancerevo9'
VEHICLE.Name = 'Lancer Evolution IX MR 2005'
VEHICLE.Manufacture = 'Mitsubishi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 102
VEHICLE.MaxRPM = 3700
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 305
VEHICLE.Weight = 2910
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_peugeot_308gti_2011'
VEHICLE.Name = '308 GTi 2011'
VEHICLE.Manufacture = 'Peugeot'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 110
VEHICLE.MaxRPM = 7000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 160
VEHICLE.Weight = 3086
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_porsche_911_turbos_2017'
VEHICLE.Name = '911 Turbo S 2017'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 119
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 605
VEHICLE.Weight = 3197
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_toyota_chaservtourerx100'
VEHICLE.Name = 'Chaser Tourer V X100 1998'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 84
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 215
VEHICLE.Weight = 3307
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_alfaromeo_montreal'
VEHICLE.Name = 'Montreal 1970'
VEHICLE.Manufacture = 'Alfa-Romeo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 4600
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 266
VEHICLE.Weight = 2899
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_aston_vantagev600_1998'
VEHICLE.Name = 'V8 Vantage V600 1998'
VEHICLE.Manufacture = 'Aston Martin'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 110
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 510
VEHICLE.Weight = 3704
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_gtasa_tampa'
VEHICLE.Name = 'Tampa'
VEHICLE.Manufacture = ''
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 122
VEHICLE.MaxRPM = 3700
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 302
VEHICLE.Weight = 3358
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_peugeot_205_t16_1984'
VEHICLE.Name = '205 Turbo 16 1984'
VEHICLE.Manufacture = 'Peugeot'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 75
VEHICLE.MaxRPM = 8000
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 999999
VEHICLE.HorsePower = 290
VEHICLE.Weight = 2646
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_500sl_1994'
VEHICLE.Name = '500SL R129 1994'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 550
VEHICLE.Weight = 3638
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_alfaromeo_8cspider'
VEHICLE.Name = '8C Spider 2008'
VEHICLE.Manufacture = 'Alfa-Romeo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 550
VEHICLE.Weight = 3638
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_rolls-royce_silvercloud3'
VEHICLE.Name = 'Silver Cloud III 1963'
VEHICLE.Manufacture = 'Rolls-Royce'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 83
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 300
VEHICLE.Weight = 4034
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_mercedes_w140_500se_1992'
VEHICLE.Name = 'W140 500SE 1992'
VEHICLE.Manufacture = 'Mercedes-Benz'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 101
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 450
VEHICLE.Weight = 5071
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_bmw_z4e89'
VEHICLE.Name = 'Z4 E89 sDrive28i 2012'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 100
VEHICLE.MaxRPM = 7000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 550
VEHICLE.Weight = 3968
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crsk_honda_prelude_1996'
VEHICLE.Name = 'Prelude Type SH 1996'
VEHICLE.Manufacture = 'Honda'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 84
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 215
VEHICLE.Weight = 3307
RegisterVehicle( VEHICLE )

--local _a = string.ToTable( file.Read( "scripts/vehicles/tdmcars/teslamodels.txt", "GAME" ) )
--PrintTable( _a )

//TDM Cars
VEHICLE = {}
VEHICLE.ID = 'fer_enzotdm'
VEHICLE.Name = 'Enzo'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 130
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 45
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 650
VEHICLE.Weight = 3009
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vols60tdm'
VEHICLE.Name = 'S60R'
VEHICLE.Manufacture = 'Volvo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 107
VEHICLE.MaxRPM = 4600
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 300
VEHICLE.Weight = 3571
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_camarozl1tdm'
VEHICLE.Name = 'Camaro ZL1'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 107
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 28
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 580
VEHICLE.Weight = 4120
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_250gtotdm'
VEHICLE.Name = '250 GTO'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 92
VEHICLE.MaxRPM = 3400
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 300
VEHICLE.Weight = 2478
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'auds5tdm'
VEHICLE.Name = 'S5'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 102
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 465
VEHICLE.Weight = 4365
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'bmwm613tdm'
VEHICLE.Name = 'M6 2013'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 108
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 552
VEHICLE.Weight = 4079
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'alfa_stradaletdm'
VEHICLE.Name = '33 Stradale'
VEHICLE.Manufacture = 'Alfa-Romeo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 245
VEHICLE.Weight = 1543
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '997gt3tdm'
VEHICLE.Name = '997 GT3'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 113
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 415
VEHICLE.Weight = 3075
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'focussvttdm'
VEHICLE.Name = 'Focus SVT'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 81
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 252
VEHICLE.Weight = 2707
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'civic97tdm'
VEHICLE.Name = 'Civic Type R 97'
VEHICLE.Manufacture = 'Honda'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 82
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 182
VEHICLE.Weight = 2359
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'ferf12tdm'
VEHICLE.Name = 'F12 Berlinetta'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 123
VEHICLE.MaxRPM = 3500
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 730
VEHICLE.Weight = 3594
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'mustanggttdm'
VEHICLE.Name = 'Mustang GT'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 300
VEHICLE.Weight = 3419
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'grandchetdm'
VEHICLE.Name = 'Grand Cherokee 2012'
VEHICLE.Manufacture = 'Jeep'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 465
VEHICLE.Weight = 5256
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_458spidtdm'
VEHICLE.Name = '458 Spider'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 117
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 562
VEHICLE.Weight = 3384
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'auditttdm'
VEHICLE.Name = 'TT 07'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 2000
VEHICLE.MaxSpeed = 89
VEHICLE.MaxRPM = 4300
VEHICLE.MaxReverseSpeed = 28
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 178
VEHICLE.Weight = 2425
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '350ztdm'
VEHICLE.Name = '350z'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 287
VEHICLE.Weight = 3309
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'golfvr6tdm'
VEHICLE.Name = 'Golf VR6 GTi'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 172
VEHICLE.Weight = 2800
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'chr300c12tdm'
VEHICLE.Name = '300C SRT-8 2012'
VEHICLE.Manufacture = 'Chrysler'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 102
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 465
VEHICLE.Weight = 4365
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'dodgeramtdm'
VEHICLE.Name = 'RAM SRT10'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 91
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 14
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 510
VEHICLE.Weight = 5137
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'toytundratdm'
VEHICLE.Name = 'Tundra Crewmax'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 62
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 381
VEHICLE.Weight = 5258
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_impala96tdm'
VEHICLE.Name = 'Impala SS 96'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 81
VEHICLE.MaxRPM = 3500
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 380
VEHICLE.Weight = 3307
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'porcycletdm'
VEHICLE.Name = 'Tricycle'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 14
VEHICLE.MaxRPM = 120
VEHICLE.MaxReverseSpeed = 3
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 1
VEHICLE.Weight = 1102
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'alfa_giuliettatdm'
VEHICLE.Name = 'Giulietta'
VEHICLE.Manufacture = 'Alfa-Romeo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 78
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 231
VEHICLE.Weight = 2910
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 's2000tdm'
VEHICLE.Name = 'S2000'
VEHICLE.Manufacture = 'Honda'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 85
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 247
VEHICLE.Weight = 2756
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '300ctdm'
VEHICLE.Name = '300c'
VEHICLE.Manufacture = 'Chrysler'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 73
VEHICLE.MaxRPM = 4900
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 450
VEHICLE.Weight = 3748
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'nis_leaftdm'
VEHICLE.Name = 'Leaf'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 54
VEHICLE.MaxRPM = 2000
VEHICLE.MaxReverseSpeed = 54
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 107
VEHICLE.Weight = 3360
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'cad_lmptdm'
VEHICLE.Name = 'LMP'
VEHICLE.Manufacture = 'Cadillac'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 116
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 45
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 600
VEHICLE.Weight = 1984
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'wrangler88tdm'
VEHICLE.Name = 'Wrangler 1988'
VEHICLE.Manufacture = 'Jeep'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 50
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 16
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 121
VEHICLE.Weight = 2915
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vol850rtdm'
VEHICLE.Name = '850 R'
VEHICLE.Manufacture = 'Volvo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 96
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 237
VEHICLE.Weight = 3230
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vw_golfr32tdm'
VEHICLE.Name = 'Golf R32'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 96
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 241
VEHICLE.Weight = 3256
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'beetle68tdm'
VEHICLE.Name = 'Beetle 1968'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 51
VEHICLE.MaxRPM = 1500
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 1
VEHICLE.Gears = 7
VEHICLE.HorsePower = 53
VEHICLE.Weight = 2646
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'toyrav4tdm'
VEHICLE.Name = 'RAV4 Sport'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 55
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 160
VEHICLE.Weight = 4332
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'mr2gttdm'
VEHICLE.Name = 'MR2 GT'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 88
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 241
VEHICLE.Weight = 2657
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'ferf430tdm'
VEHICLE.Name = 'F430'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 114
VEHICLE.MaxRPM = 6600
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 483
VEHICLE.Weight = 3197
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '242turbotdm'
VEHICLE.Name = '242 Turbo'
VEHICLE.Manufacture = 'Volvo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 96
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 225
VEHICLE.Weight = 3175
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '370ztdm'
VEHICLE.Name = '370z'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 101
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 332
VEHICLE.Weight = 3267
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'civictypertdm'
VEHICLE.Name = 'Civic Type R'
VEHICLE.Manufacture = 'Honda'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 85
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 198
VEHICLE.Weight = 2348
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'veyrontdm'
VEHICLE.Name = 'Veyron'
VEHICLE.Manufacture = 'Bugatti'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 148
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 29
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 1001
VEHICLE.Weight = 4409
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '918spydtdm'
VEHICLE.Name = '918 Spyder'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 124
VEHICLE.MaxRPM = 4100
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 887
VEHICLE.Weight = 3748
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_c10tdm'
VEHICLE.Name = 'C10'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 64
VEHICLE.MaxRPM = 2800
VEHICLE.MaxReverseSpeed = 18
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 165
VEHICLE.Weight = 3241
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'challenger70tdm'
VEHICLE.Name = 'Challenger 1970'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 75
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 335
VEHICLE.Weight = 3120
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'bmw1mtdm'
VEHICLE.Name = '1M'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 97
VEHICLE.MaxRPM = 3100
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 335
VEHICLE.Weight = 3298
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'audir8plustdm'
VEHICLE.Name = 'R8 Plus'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 999999
VEHICLE.MaxSpeed = 114
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 550
VEHICLE.Weight = 3660
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'volxc90tdm'
VEHICLE.Name = 'XC90'
VEHICLE.Manufacture = 'Volvo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 315
VEHICLE.Weight = 4332
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'ptcruisertdm'
VEHICLE.Name = 'PT Cruiser'
VEHICLE.Manufacture = 'Chrysler'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 73
VEHICLE.MaxRPM = 3500
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 555
VEHICLE.Weight = 3968
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'supratdm'
VEHICLE.Name = 'Supra'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 320
VEHICLE.Weight = 3329
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'bmwm3gtrtdm'
VEHICLE.Name = 'M3 GTR'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 97
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 380
VEHICLE.Weight = 2976
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vwsciroccortdm'
VEHICLE.Name = 'Scirocco R'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 3500
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 261
VEHICLE.Weight = 2963
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'citroenc1tdm'
VEHICLE.Name = 'C1'
VEHICLE.Manufacture = 'Citroen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 60
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 17
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 200
VEHICLE.Weight = 2646
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'c4tdm'
VEHICLE.Name = 'C4'
VEHICLE.Manufacture = 'Citroen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 73
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 125
VEHICLE.Weight = 3307
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'dod_ram_1500tdm'
VEHICLE.Name = 'RAM 1500'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 64
VEHICLE.MaxRPM = 5650
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 310
VEHICLE.Weight = 6283
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'r34tdm'
VEHICLE.Name = 'Skyline R34'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 108
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 276
VEHICLE.Weight = 3439
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_sparktdm'
VEHICLE.Name = 'Spark'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 60
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 17
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 200
VEHICLE.Weight = 2646
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'chargersrt8tdm'
VEHICLE.Name = 'Charger SRT-8'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 104
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 480
VEHICLE.Weight = 3748
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'veyronsstdm'
VEHICLE.Name = 'Veyron SS'
VEHICLE.Manufacture = 'Bugatti'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 150
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 29
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 1200
VEHICLE.Weight = 4400
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'nissilvs15tdm'
VEHICLE.Name = 'Silvia S15'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 75
VEHICLE.MaxRPM = 3300
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 250
VEHICLE.Weight = 2734
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'eb110tdm'
VEHICLE.Name = 'EB110'
VEHICLE.Manufacture = 'Bugatti'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 124
VEHICLE.MaxRPM = 4800
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 536
VEHICLE.Weight = 3527
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'carreragttdm'
VEHICLE.Name = 'Carrera GT'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 119
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 605
VEHICLE.Weight = 3197
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'cad_escaladetdm'
VEHICLE.Name = 'Escalade 2012'
VEHICLE.Manufacture = 'Cadillac'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 62
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 404
VEHICLE.Weight = 5981
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'gt05tdm'
VEHICLE.Name = 'GT 05'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 123
VEHICLE.MaxRPM = 3200
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 420
VEHICLE.Weight = 3351
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'bmwm5e60tdm'
VEHICLE.Name = 'M5 E60'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 119
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 29
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 500
VEHICLE.Weight = 4012
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_f50tdm'
VEHICLE.Name = 'F50'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 113
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 40
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 513
VEHICLE.Weight = 3009
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'transittdm'
VEHICLE.Name = 'Transit'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 2500
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 200
VEHICLE.Weight = 7716
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_stingray427tdm'
VEHICLE.Name = 'Corvette Stingray 427'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 83
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 435
VEHICLE.Weight = 3384
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'priustdm'
VEHICLE.Name = 'Prius'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 62
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 134
VEHICLE.Weight = 3042
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'auds4tdm'
VEHICLE.Name = 'S4'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 333
VEHICLE.Weight = 3638
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'f100tdm'
VEHICLE.Name = 'F100'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 60
VEHICLE.MaxRPM = 2800
VEHICLE.MaxReverseSpeed = 18
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 130
VEHICLE.Weight = 3241
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'raptorsvttdm'
VEHICLE.Name = 'Raptor SVT'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 411
VEHICLE.Weight = 4409
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'porgt3rsrtdm'
VEHICLE.Name = '911 GT3-RSR'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 140
VEHICLE.MaxRPM = 3700
VEHICLE.MaxReverseSpeed = 35
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 445
VEHICLE.Weight = 2690
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'coupe40tdm'
VEHICLE.Name = 'Deluxe Coupe 1940'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 44
VEHICLE.MaxRPM = 2800
VEHICLE.MaxReverseSpeed = 18
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 90
VEHICLE.Weight = 3219
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'dod_ram_3500tdm'
VEHICLE.Name = 'RAM 3500'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 8650
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 950
VEHICLE.Weight = 6283
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'crownvic_taxitdm'
VEHICLE.Name = 'Crown Victoria Taxi'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 85
VEHICLE.MaxRPM = 4500
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 239
VEHICLE.Weight = 4123
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_chevellesstdm'
VEHICLE.Name = 'Chevelle SS'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 450
VEHICLE.Weight = 3799
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vwgolfgti14tdm'
VEHICLE.Name = 'Golf GTI 2014'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 220
VEHICLE.Weight = 3113
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'golfmk2tdm'
VEHICLE.Name = 'Golf MKII'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 72
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 139
VEHICLE.Weight = 2425
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vwcampertdm'
VEHICLE.Name = 'Camper 1965'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 51
VEHICLE.MaxRPM = 1500
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 1
VEHICLE.Gears = 7
VEHICLE.HorsePower = 53
VEHICLE.Weight = 2646
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'wrangler_fnftdm'
VEHICLE.Name = 'Wrangler F&F'
VEHICLE.Manufacture = 'Jeep'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 90
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 350
VEHICLE.Weight = 7055
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'charger2012tdm'
VEHICLE.Name = 'Charger SRT8 2012'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 102
VEHICLE.MaxRPM = 6000
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 465
VEHICLE.Weight = 4365
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'audir8spydtdm'
VEHICLE.Name = 'R8 GT Spyder'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 99999999
VEHICLE.MaxSpeed = 111
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 25
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 560
VEHICLE.Weight = 3781
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'rs4avanttdm'
VEHICLE.Name = 'RS4 Avant'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 101
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 444
VEHICLE.Weight = 3957
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'm3e92tdm'
VEHICLE.Name = 'M3 E92'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 5000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 280
VEHICLE.Weight = 3638
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'audir8tdm'
VEHICLE.Name = 'R8'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 108
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 23
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 650
VEHICLE.Weight = 3086
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = '507tdm'
VEHICLE.Name = '507'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 71
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 19
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 350
VEHICLE.Weight = 2866
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'm1tdm'
VEHICLE.Name = 'M1 1981'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 93
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 14
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 280
VEHICLE.Weight = 2866
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'dod_challenger15tdm'
VEHICLE.Name = 'Challenger 2015'
VEHICLE.Manufacture = 'Dodge'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 5300
VEHICLE.MaxReverseSpeed = 26
VEHICLE.Automatic = 0
VEHICLE.Gears = 5
VEHICLE.HorsePower = 375
VEHICLE.Weight = 4200
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'hon_crxsirtdm'
VEHICLE.Name = 'CR-X SiR'
VEHICLE.Manufacture = 'Honda'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 158
VEHICLE.Weight = 2161
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'vwbeetleconvtdm'
VEHICLE.Name = 'New Beetle Convertible'
VEHICLE.Manufacture = 'Volkswagen'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 75
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 180
VEHICLE.Weight = 3005
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_corv_gsctdm'
VEHICLE.Name = 'Corvette GSC'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 108
VEHICLE.MaxRPM = 5500
VEHICLE.MaxReverseSpeed = 29
VEHICLE.Automatic = 0
VEHICLE.Gears = 4
VEHICLE.HorsePower = 436
VEHICLE.Weight = 3382
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'm5e34tdm'
VEHICLE.Name = 'M5 E34'
VEHICLE.Manufacture = 'BMW'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 103
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 311
VEHICLE.Weight = 4026
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_512trtdm'
VEHICLE.Name = '512 TR'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 113
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 428
VEHICLE.Weight = 3124
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_69camarotdm'
VEHICLE.Name = 'Camaro SS 69'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 360
VEHICLE.Weight = 3307
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'focusrstdm'
VEHICLE.Name = 'Focus RS'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 95
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 28
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 301
VEHICLE.Weight = 3234
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_lafertdm'
VEHICLE.Name = 'LaFerrari'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 126
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 30
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 962
VEHICLE.Weight = 3031
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'wranglertdm'
VEHICLE.Name = 'Wrangler'
VEHICLE.Manufacture = 'Jeep'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 70
VEHICLE.MaxRPM = 3800
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 285
VEHICLE.Weight = 3377
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'toyfjtdm'
VEHICLE.Name = 'FJ Cruiser'
VEHICLE.Manufacture = 'Toyota'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 64
VEHICLE.MaxRPM = 3000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 260
VEHICLE.Weight = 4332
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'jeewillystdm'
VEHICLE.Name = 'Willys'
VEHICLE.Manufacture = 'Jeep'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 55
VEHICLE.MaxRPM = 2500
VEHICLE.MaxReverseSpeed = 16
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 60
VEHICLE.Weight = 2293
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'gtrtdm'
VEHICLE.Name = 'GT-R Black Edition'
VEHICLE.Manufacture = 'Nissan'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 112
VEHICLE.MaxRPM = 3900
VEHICLE.MaxReverseSpeed = 27
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 542
VEHICLE.Weight = 3827
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'f350tdm'
VEHICLE.Name = 'F350 SuperDuty'
VEHICLE.Manufacture = 'Ford'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 80
VEHICLE.MaxRPM = 3600
VEHICLE.MaxReverseSpeed = 20
VEHICLE.Automatic = 1
VEHICLE.Gears = 1
VEHICLE.HorsePower = 385
VEHICLE.Weight = 5445
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'che_blazertdm'
VEHICLE.Name = 'Blazer'
VEHICLE.Manufacture = 'Chevrolet'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 67
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 300
VEHICLE.Weight = 4409
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'cayenne12tdm'
VEHICLE.Name = 'Cayenne Turbo 12'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 101
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 500
VEHICLE.Weight = 4784
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'fer_250gttdm'
VEHICLE.Name = '250GT'
VEHICLE.Manufacture = 'Ferrari'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 87
VEHICLE.MaxRPM = 4200
VEHICLE.MaxReverseSpeed = 21
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 350
VEHICLE.Weight = 2425
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'volxc70tdm'
VEHICLE.Name = 'XC70 Turbo'
VEHICLE.Manufacture = 'Volvo'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 75
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 24
VEHICLE.Automatic = 0
VEHICLE.Gears = 1
VEHICLE.HorsePower = 300
VEHICLE.Weight = 4151
RegisterVehicle( VEHICLE )

VEHICLE = {}
VEHICLE.ID = 'cayennetdm'
VEHICLE.Name = 'Cayenne Turbo S'
VEHICLE.Manufacture = 'Porsche'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 550
VEHICLE.Weight = 5723
RegisterVehicle( VEHICLE )


//Sky Vehicles

VEHICLE = {}
VEHICLE.ID = 'sky_r8_ico'
VEHICLE.Name = '2017 Audi R8 V10'
VEHICLE.Manufacture = 'Audi'
VEHICLE.Price = 0
VEHICLE.MaxSpeed = 99
VEHICLE.MaxRPM = 4000
VEHICLE.MaxReverseSpeed = 22
VEHICLE.Automatic = 0
VEHICLE.Gears = 3
VEHICLE.HorsePower = 550
VEHICLE.Weight = 5723
RegisterVehicle( VEHICLE )