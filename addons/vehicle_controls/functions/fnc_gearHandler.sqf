#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Called by gear EH.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Gear down or up <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player, 2] call AIMEE_vehicle_controls_fnc_gearHandler
 *
 * Public: No
 */

params ["_vehicle", "_gearDown"];

[_vehicle, [GEAR_UP, GEAR_DOWN] select _gearDown] call FUNC(gearStatus);
