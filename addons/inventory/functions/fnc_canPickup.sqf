#include "script_component.hpp"

/*
 * Author: johnb43
 * Returns if a weapon holder contains 1 item only.
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

private _content = weaponCargo _this;
_content append (itemCargo _this);
_content append (magazineCargo _this);
_content append (backpackCargo _this);

count _content == 1
