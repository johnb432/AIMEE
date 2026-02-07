#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns whether a static weapon can be assembled.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * If weapon can be assembled <BOOL>
 *
 * Example:
 * player call AIMEE_inventory_fnc_canAssemble
 *
 * Public: No
 */

params ["_unit"];

if (isNull (configOf backpackContainer _unit >> "assembleInfo")) exitWith {
    false // return
};

(_unit call FUNC(locateBackpack)) params ["_base", "_weapon"];

!isNull _base && {!isNull _weapon} // return
