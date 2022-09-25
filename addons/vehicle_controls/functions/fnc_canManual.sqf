#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns whether a gun can be manually fired by commander.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Can manual fire <BOOL>
 *
 * Example:
 * [player, vehicle player] call AIMEE_vehicle_controls_fnc_canManual
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;

if (getNumber (_config >> "enableManualFire") == 0 || {isPlayer gunner _vehicle}) exitWith {
    false
};

if (_vehicle isKindOf "Air" || {unitIsUAV _vehicle}) then {
    _this call FUNC(isDriver) && {"true" configClasses (_config >> "Turrets") isNotEqualTo []}
} else {
    _unit == commander _vehicle
};
