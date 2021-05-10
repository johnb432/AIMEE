#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Container <OBJECT>
 *
 * Return Value:
 * Returns <BOOL>
 *
 * Public: No
 */

params ["_object"];

private _total = count weaponCargo _object;

if (_total > 1) exitWith {false};

_total = _total + count magazineCargo _object;

if (_total > 1) exitWith {false};

(_total + count backpackCargo _object) isEqualTo 1
