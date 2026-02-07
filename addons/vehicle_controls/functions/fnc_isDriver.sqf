#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if unit is vehicle's driver.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Is driver <BOOL>
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_controls_fnc_isDriver
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

if (_unit == (currentPilot _vehicle)) exitWith {
    true // return
};

if (_vehicle == (getConnectedUAV _unit)) exitWith {
    ((UAVControl _vehicle) select 1) == "DRIVER" // return
};

false // return
