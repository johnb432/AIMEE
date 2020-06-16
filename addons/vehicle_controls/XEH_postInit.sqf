#include "script_component.hpp"

[
	QGVAR(collisionAction),
	{ isCollisionLightOn (_this select 0) },
	{ (_this select 0) setCollisionLight (_this select 2) },
	{
		GVAR(settingCollisionAction) && { [_this select 1, _this select 0] call FUNC(is_driver) };
	},
	[
		getText (configfile >> "CfgActions" >> "CollisionLightOff" >> "text"),
		getText (configfile >> "CfgActions" >> "CollisionLightOn" >> "text")
	],
	[
		"A3\ui_f\data\igui\cfg\actions\ico_cpt_col_OFF_ca",
		"A3\ui_f\data\igui\cfg\actions\ico_cpt_col_ON_ca"
	],
	["Boat_F", "Air"]
] call FUNC(toggle2_init);

[
	QGVAR(lightsAction),
	{ isLightOn (_this select 0) },
	{ (_this select 0) setPilotLight (_this select 2) },
	{
		GVAR(settingLightsAction) && { "headlights" call EFUNC(main,ignore_keybind_for_input_action) } && { [_this select 1, _this select 0] call FUNC(is_driver) };
	},
	[
		getText (configfile >> "CfgActions" >> "LightOff" >> "text"),
		getText (configfile >> "CfgActions" >> "LightOn" >> "text")
	],
	[
		"A3\ui_f\data\igui\cfg\actions\ico_cpt_land_OFF_ca",
		"A3\ui_f\data\igui\cfg\actions\ico_cpt_land_ON_ca"
	],
	["LandVehicle", "Air"]
] call FUNC(toggle2_init);

[
	QGVAR(hoverAction),
	{ isAutoHoverOn (_this select 0) },
	{
		private _action = if (_this select 2) then { "AutoHover" }
		else { "AutoHoverCancel" };

		(_this select 1) action [_action, _this select 0];
	},
	{
		GVAR(settingHoverAction) && { "AutoHover" call EFUNC(main,ignore_keybind_for_input_action) } && { [_this select 1, _this select 0] call FUNC(is_driver) };
	},
	[
		getText (configfile >> "CfgActions" >> "AutoHoverCancel" >> "text"),
		getText (configfile >> "CfgActions" >> "AutoHover" >> "text")
	],
	[
		"\A3\ui_f\data\igui\cfg\actions\cancelhover_ca.paa",
		"\A3\ui_f\data\igui\cfg\actions\autohover_ca.paa"
	],
	["Helicopter"]
] call FUNC(toggle2_init);

[
	QGVAR(manualAction),
	{ isManualFire (_this select 0) },
	{
		private _action = if (_this select 2) then { "ManualFire" }
		else { "ManualFireCancel" };

		(_this select 1) action [_action, _this select 0];
	},
	{
		GVAR(settingManualAction) && { "heliManualFire" call EFUNC(main,ignore_keybind_for_input_action) } && { [_this select 1, _this select 0] call FUNC(can_manual) };
	},
	[
		getText (configfile >> "CfgActions" >> "ManualFireCancel" >> "text"),
		getText (configfile >> "CfgActions" >> "ManualFire" >> "text")
	],
	[
		"\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_cancel_manualfire_ca.paa",
		"\A3\ui_f\data\igui\cfg\actions\obsolete\ui_action_manualfire_ca.paa"
	],
	["LandVehicle", "Air", "Ship"]
] call FUNC(toggle2_init);

[
	QGVAR(engineAction),
	{ isEngineOn (_this select 0) },
	{ (_this select 0) engineOn (_this select 2) },
	{
		GVAR(settingEngineAction) && ( "engineToggle" call EFUNC(main,ignore_keybind_for_input_action) && { "engineControlACE" call EFUNC(main,ignore_keybind_for_input_action) }) && { [_this select 1, _this select 0] call FUNC(is_driver) };
	},
	[
		getText (configfile >> "CfgActions" >> "EngineOff" >> "text"),
		getText (configfile >> "CfgActions" >> "EngineOn" >> "text")
	],
	[
		"\A3\ui_f\data\igui\cfg\actions\engine_off_ca.paa",
		"\A3\ui_f\data\igui\cfg\actions\engine_on_ca.paa"
	],
	["LandVehicle", "Air", "Ship"]
] call FUNC(toggle2_init);

call FUNC(gear_init);
call FUNC(init_flaps);
call FUNC(init_user_actions);
call FUNC(init_arty_computer);