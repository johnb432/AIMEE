#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Target (Static Weapon) <OBJECT>
 *
 * Return Value:
 * Returns if weapon can be disassembled <BOOL>
 *
 * Public: No
 */

params ["_vehicle"];

private _config = configOf _vehicle >> "assembleInfo";

if (isNull _config) exitWith {false};

getArray (_config >> "dissasembleTo") isNotEqualTo [];
