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

!lockedInventory _this && {maxLoad _this > 0} && {getNumber (configOf _this >> "disableInventory") != 1}
