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

private _config = configFile >> "CfgWeapons" >> [_player, true] call FUNC(assignedGPS);

_menu set [1, getText (_config >> "displayName")];
_menu set [2, getText (_config >> "picture")];
