#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: <OBJECT>
 * 1: Player <OBJECT>
 * 2:
 * 3: Menu <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 *
 *
 * Public: No
 */

params [
	"_target",
	"_player",
	"_args",
	"_menu"
];

private _config = configFile >> "CfgVehicles" >> backpack _player >> "assembleInfo";
private _class = getText (_config >> "assembleTo");
private _name = getText (configFile >> "CfgVehicles" >> _class >> "displayName");

_menu set [1, "Assemble " + _name];