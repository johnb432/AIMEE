#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Returns if a weapon holder can be interacted with.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Container <OBJECT>
 *
 * Return Value:
 * If object can be picked up <BOOL>
 *
 * Example:
 * [player, cursorObject] call AIMEE_inventory_fnc_canPickup
 *
 * Public: No
 */

params ["_unit", "_target"];

private _content = itemCargo _target;
_content append (magazineCargo _target);
_content append (backpackCargo _target);

count _content == 1 && {[_unit, _target, []] call ace_common_fnc_canInteractWith}
