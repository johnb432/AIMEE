#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Returns if player eject <BOOL>
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;

if (isClass (_config >> "EjectionSystem")) exitWith {EJECT_TYPE_JET};

private _type = [EJECT_TYPE_NONE, EJECT_TYPE_CAR] select (
   	switch (_unit call CBA_fnc_vehicleRole) do {
      		case "driver": {
      			   getNumber (_config >> "driverCanEject");
      		};

      		case "cargo": {
      			   getNumber (_config >> "cargoCanEject");
      		};

      		default {
         			private _path = _unit call CBA_fnc_turretPath;

         			if (_path isEqualTo []) exitWith {0};

         			getNumber ([_config, _path] call CBA_fnc_getTurret >> "canEject");
      		};
   	}
);

if (_type isEqualTo EJECT_TYPE_NONE && {_vehicle isKindOf "Helicopter"} && {GVAR(settingForceEject)}) then {
	   _type = EJECT_TYPE_FORCE;
};

_type;
