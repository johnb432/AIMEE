#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns if inventory is present.
 *
 * Arguments:
 * 0: Object (Vehicle/Unit) <OBJECT>
 *
 * Return Value:
 * If object has inventory <BOOL>
 *
 * Example:
 * cursorObject call AIMEE_inventory_fnc_hasInventory
 *
 * Public: No
 */

params ["_object"];

!lockedInventory _object && {maxLoad _object > 0} && {getNumber (configOf _object >> "disableInventory") != 1} // return
