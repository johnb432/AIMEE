#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Ejects a unit from a vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_seats_fnc_eject
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

switch (_this call FUNC(canEject)) do {
    case EJECT_TYPE_JET: {
        [_vehicle] call BIS_fnc_PlaneEjection;
    };
    case EJECT_TYPE_CAR: {
        _unit action ["Eject", _vehicle];
    };
    case EJECT_TYPE_FORCE: {
        private _engineOn = _this call EFUNC(vehicle_controls,isDriver) && {isEngineOn _vehicle};

        moveOut _unit;

        if (_engineOn) then {
            _vehicle engineOn true;
        };
    };
    default {};
};
