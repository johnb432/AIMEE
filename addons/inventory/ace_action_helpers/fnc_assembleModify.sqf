#include "script_component.hpp"
/*
 * Author: upsilon, johnb43
 *
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Player <OBJECT>
 * 2: Params <ARRAY>
 * 3: Interaction menu <ARRAY>
 *
 * Return Value:
 * Modified interaction menu <ARRAY>
 *
 * Public: No
 */

params ["_target", "_player", "_args", "_menu"];

private _backpack = backpackContainer _player;

if (isNull _backpack) exitWith {};

([_player, _backpack] call FUNC(locateBackpack)) params ["_baseOnGround", "_base", "_weapon", "_weaponHolder"];

if (isNull _base || isNull _weapon) exitWith {};

_menu set [1, format [LQSTRING(STR_ACTION_ASSEMBLE), getText (configFile >> "CfgVehicles" >> getText (configOf _weapon >> "assembleInfo" >> "assembleTo") >> "displayName")]];
