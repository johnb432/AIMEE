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

private _total = count weaponCargo _this;

if (_total > 1) exitWith {false};

_total = _total + count magazineCargo _this;

if (_total > 1) exitWith {false};

(_total + count backpackCargo _this) isEqualTo 1
