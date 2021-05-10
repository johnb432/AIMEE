#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Backpack <OBJECT>
 *
 * Return Value:
 * Returns  whether a static weapon can be assembled <BOOL>
 *
 * Public: No
 */

params ["_player", "_backpack"];

private _config = configOf _backpack >> "assembleInfo";
if (isNull _config) exitWith {false};

([_player, _backpack] call FUNC(locateBackpack)) params ["_baseOnGround", "_base", "_weapon", "_weaponHolder"];

if (isNull _base || isNull _weapon) exitWith {false};

true;
