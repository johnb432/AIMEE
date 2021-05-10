#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Gear down or up <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_vehicle", "_down"];

[_vehicle, [GEAR_UP, GEAR_DOWN] select _down] call FUNC(gearStatus);
