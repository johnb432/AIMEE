#include "script_component.hpp"

GVAR(reloadFinished) = true;

_change_ammo = [
	QGVAR(ammoClass),
	"Change Ammo Type",
	"\A3\ui_f\data\igui\cfg\actions\reload_ca.paa",
	{},
	{
		params [
			"_target",
			"_player",
			"_args"
		];

		if (!GVAR(settingAmmoClass) || { _player call EFUNC(main,operating_uav) }) exitWith { false };
		_player == vehicle _player || { _player call CBA_fnc_canUseWeapon };
	},
	FUNC(ammomenus),
	nil,
	nil,
	nil,
	nil,
	nil
] call ace_interact_menu_fnc_createAction;

_change_vehicle_ammo = [
	QGVAR(vehicleAmmoClass),
	"Change Ammo Type",
	"\A3\ui_f\data\igui\cfg\simpletasks\types\rearm_ca.paa",
	{},
	{
		params [
			"_target",
			"_player",
			"_args"
		];

		GVAR(settingVehicleAmmoClass) && { !isTurnedOut _player } && { _player == gunner _target };
	},
	FUNC(ammomenus),
	nil,
	nil,
	nil,
	nil,
	nil
] call ace_interact_menu_fnc_createAction;

[
	"CAManBase",
	1,
	["ACE_SelfActions"],
	_change_ammo,
	true
] call ace_interact_menu_fnc_addActionToClass;

[
	"LandVehicle",
	1,
	["ACE_SelfActions"],
	_change_vehicle_ammo,
	true
] call ace_interact_menu_fnc_addActionToClass;
