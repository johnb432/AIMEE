#include "..\script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Makes a unit get into a vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_target", "_unit"];

{
    if ([_unit, _target, _x] call FUNC(canSwitch)) exitWith {
        switch (_x select 1) do {
            case "driver": {
                _unit action ["GetInDriver", _target];
            };
            case "gunner";
            case "commander";
            case "turret": {
                _unit action ["GetInTurret", _target, _x select 3];
            };
            case "cargo": {
                _unit action ["GetInCargo", _target];
            };
            default {};
        };
    };
} forEach fullCrew [_target, "", true];
