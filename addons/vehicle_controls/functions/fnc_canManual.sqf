#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Name <STRING>
 *
 * Return Value:
 * Returns whether a gun can be manually fired by commander <BOOLEAN>
 *
 * Public: No
 */

params ["_unit", "_vehicle"];

private _config = configOf _vehicle;

if (getNumber (_config >> "enableManualFire") isEqualTo 0 || {isPlayer gunner _vehicle}) exitWith {
				false
};

if (_vehicle isKindOf "Air" || {unitIsUAV _vehicle}) then {
				[_unit, _vehicle] call FUNC(isDriver) && {"true" configClasses (_config >> "Turrets") isNotEqualTo []};
} else {
				_unit isEqualTo commander _vehicle;
};
