#include "script_component.hpp"
/*
 * Author: upsilon
 *
 *
 * Arguments:
 * 0: <OBJECT>
 * 1: Player <OBJECT>
 * 2:
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
	"_args"
];

private _backpack = firstBackpack _target;

GVAR(settingOpenAction) && { !isNull _backpack } && { _backpack call FUNC(has_inventory) } && { _target call FUNC(can_pickup) };