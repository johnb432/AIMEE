#include "script_component.hpp"

/*
 * Author: upsilon, johnb43
 * Returns if an object can be picked up from a weaponHolder.
 *
 * Arguments:
 * 0: Container <OBJECT>
 *
 * Return Value:
 * If object can be picked up <BOOL>
 *
 * Example:
 * cursorObject call AIMEE_inventory_fnc_canPickup
 *
 * Public: No
 */

private _content = weaponCargo _target;
_content append (itemCargo _target);
_content append (magazineCargo _target);
_content append (backpackCargo _target);

count _content == 1;
