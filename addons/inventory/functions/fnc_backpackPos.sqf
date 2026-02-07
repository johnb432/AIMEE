#include "..\script_component.hpp"
/*
 * Author: upsilon, johnb43
 * Returns the position of where the ACE interaction has to go.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Position <ARRAY>
 *
 * Example:
 * cursorTarget call AIMEE_inventory_fnc_backpackPos
 *
 * Public: No
 */

params ["_unit"];

private _spine = _unit selectionPosition "spine3";
(((_unit selectionPosition "rightshoulder" vectorDiff _spine) vectorCrossProduct (_unit selectionPosition "leftshoulder" vectorDiff _spine)) vectorMultiply 4) vectorAdd _spine // return
