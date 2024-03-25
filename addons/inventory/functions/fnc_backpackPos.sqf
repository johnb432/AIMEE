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

private _spine = _this selectionPosition "spine3";
(((_this selectionPosition "rightshoulder" vectorDiff _spine) vectorCrossProduct (_this selectionPosition "leftshoulder" vectorDiff _spine)) vectorMultiply 4) vectorAdd _spine;
