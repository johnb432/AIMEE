#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if a unit can eject.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Can eject <BOOL>
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_seats_fnc_canEject
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;

if (isClass (_config >> "EjectionSystem")) exitWith {EJECT_TYPE_JET};

private _type = [EJECT_TYPE_NONE, EJECT_TYPE_CAR] select (
    switch (_unit call CBA_fnc_vehicleRole) do {
        case "driver": {
            getNumber (_config >> "driverCanEject")
        };
        case "cargo": {
            getNumber (_config >> "cargoCanEject")
        };
        default {
            private _path = _vehicle unitTurret _unit;

            if (_path isEqualTo []) exitWith {0};

            getNumber ([_config, _path] call CBA_fnc_getTurret >> "canEject")
        };
    }
);

if (GVAR(settingForceEject) && {_type == EJECT_TYPE_NONE} && {_vehicle isKindOf "Helicopter"}) then {
    _type = EJECT_TYPE_FORCE;
};

_type
