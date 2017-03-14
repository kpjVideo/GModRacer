if game.GetMap() == "gm_upstatespeedway" then

	_GM.Racing.Checkpoints = {}
	_GM.Racing.StartFinish = {}

	_GM.Racing.Checkpoints["gm_upstatespeedway"] = {
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4256, 196, 118 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 4741, 898, 131 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 6114, -185, 102 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 7927, -1848, 94 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 9160, 793, 102 ) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 8257, 2681, 113) },
		{ 'models/props_phx/construct/plastic/plastic_angle_360.mdl', Vector( 9634, 7417, 597 ) },
	}

	_GM.Racing.StartFinish["gm_upstatespeedway"] = {
		{Vector( 5320, -2100, 250 ), Angle( 0, 10, 90 )}
	}
--[[
setpos 9634.201172 7417.782715 597.429138;setang -0.203658 160.223068 0.000000
] getpos 
setpos 7761.317383 4555.221680 659.655762;setang -4.295657 -14.580349 0.000000
] getpos 
setpos 8479.341797 6467.753418 650.362305;setang 1.512342 151.541916 0.000000
] getpos 
setpos 5873.279297 4303.633789 891.606812;setang -0.071658 -109.259804 0.000000
] getpos 
setpos 3081.335693 5053.114258 943.333191;setang 0.060342 166.787933 0.000000
] getpos 
setpos 1099.878540 4555.120117 901.737854;setang -0.269658 -83.454041 0.000000
] getpos 
setpos 511.439789 595.429626 712.483093;setang 4.152341 164.477844 0.000000
] getpos 
setpos 1574.096313 758.238281 412.085205;setang 2.568342 -71.802376 0.000000
] getpos 
setpos 2544.822998 -1029.129639 248.582932;setang 4.218342 -73.716370 0.000000
] getpos 
setpos 4208.072266 -3358.172852 98.658997;setang 2.238342 -8.178196 0.000000
] getpos 
setpos 5367.208496 -2367.755615 113.180176;setang 1.776342 102.833847 0.000000

]]
end