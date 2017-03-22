if game.GetMap() == "gm_upstatespeedway" then

	_GM.Racing.Checkpoints["gm_upstatespeedway"] = {
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4269, 10, 152 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 6072, -129, 173 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 9144, -878, 131 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 8232, 2677,130 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 10178, 5904, 633 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 7119, 6488, 399 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 8604, 4426, 696 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 8198, 6573, 672 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4037, 3615, 932 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 2747, 5090, 988 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 1113, 4582, 932 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 2245, 2133, 795 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( -474, 2104, 554 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 1543, 691, 466 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 2926, -2548, 112 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4877, -3395, 129 ) },
	}


	_GM.Racing.StartFinish["gm_upstatespeedway"] = {
		{Vector( 5320, -2100, 250 ), Angle( 0, 10, 90 )}
	}

	for k, v in pairs( ents.FindByClass( "sky_camera" ) ) do
		v:Remove()
	end
end