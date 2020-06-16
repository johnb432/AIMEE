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

if (!(_target call FUNC(can_pickup) && { [_player, _target] call FUNC(player_pickup) })) then {
	_player action ["Gear", _target];
};