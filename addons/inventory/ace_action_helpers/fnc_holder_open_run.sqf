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

_player action ["Gear", firstBackpack _target];