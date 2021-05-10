#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Vehicle/Unit <OBJECT>
 *
 * Return Value:
 * Returns if inventory is present <BOOL>
 *
 * Public: No
 */

params ["_object"];

private _config = configOf _object;

getNumber (_config >> "maximumLoad") isNotEqualTo 0 && {getNumber (_config >> "disableInventory") isNotEqualTo 1};
