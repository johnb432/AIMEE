#include "script_component.hpp"

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

private _config = configOf _this;

!lockedInventory _this && {getNumber (_config >> "disableInventory") isNotEqualTo 1} && {getNumber (_config >> "maximumLoad") isNotEqualTo 0};
